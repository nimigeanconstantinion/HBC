CLOSE ALL
CLEA

PUBLIC Testx
Testx="DRIVER={MySQL ODBC 8.0 Unicode Driver};SERVER=localhost;PORT=3306;DATABASE=ecuator; USER=root;PASSWORD=root;OPTION=3;"

xCon = SQLSTRINGCONNECT(Testx)
IF xCon <= 0
   MESSAGEBOX("Connection Error",0+16, "Error")
ELSE 
   MESSAGEBOX("uraaaaa")   
ENDIF

lnRetVal = SQLEXEC(xcon,"Select * From mapare_articole","curMap")

SELECT 00000 as id,cod_hbc as id_extern,cod_ecu as id_intern,1 as id_furniz FROM map_articole WHERE COD_HBC#0 AND COD_ECU#0 INTO dbf ccr

MakeSPTUpdateable("curMap","id","mapare_articole")
Select curMap
Append From DBF("ccr")


* and commit that data to MySQL
Tableupdate(.T.,.T.)


function MakeSPTUpdateable
Lparameters tcAlias, tcKeyfieldlist, tcTable, tcUpdatableFieldList
Local lnCounter, lcUpdatableFieldList, lcUpdateNameList, lcType
Local Array laFields[1]
IF VARTYPE(tcAlias) = "C" AND USED(tcAlias)
	Select(tcAlias)
	lcNeededFieldList = ""
	lcUpdatableFieldList=""
	lcUpdateNameList = ""
	?AFIELDS(laFields,tcAlias)
	FOR lnCounter = 1 TO AFIELDS(laFields,tcAlias)
	?lcUpdatableFieldList
		lcUpdatableFieldList = lcUpdatableFieldList +;
		LOWER(ALLTRIM(laFields(lnCounter,1))) + ","
		lcUpdateNameList = lcUpdateNameList +;
		LOWER(ALLTRIM(laFields(lnCounter,1))) + ;
		" "+tcTable+"." +;
		LOWER(ALLTRIM(laFields(lnCounter,1))) + ","
	ENDFOR lnCounter

	lcUpdatableFieldList =LEFT(lcUpdatableFieldList,LEN(lcUpdatableFieldList)-1)
	lcUpdateNameList = LEFT(lcUpdateNameList,LEN(lcUpdateNameList) -1)
	SET MULTILOCKS ON && Must turn on for table buffering.
	CURSORSETPROP('Buffering' , 5 , tcAlias)
	CURSORSETPROP('SendUpdates' , .T. , tcAlias)
	CURSORSETPROP('Tables' , tcTable , tcAlias)
	CURSORSETPROP('KeyFieldlist' , tcKeyfieldlist , tcAlias)
	CURSORSETPROP('UpdatableFieldList', ;
	IIF(EMPTY(tcUpdatableFieldlist), lcUpdatableFieldList,tcUpdatableFieldList), tcAlias )
	CURSORSETPROP('UpdateNameList', lcUpdateNameList, tcAlias)
ENDIF




