CLOSE ALL
CLEAR
SET DATE TO dmy
SET CENTURY on

SET ENGINEBEHAVIOR 70

PUBLIC Testx
Testx="DRIVER={MySQL ODBC 8.0 Unicode Driver};SERVER=localhost;PORT=3306;DATABASE=ecuator; USER=root;PASSWORD=root;OPTION=3;"

xCon = SQLSTRINGCONNECT(Testx)
PUBLIC kk
kk=""
IF xCon <= 0
   MESSAGEBOX("Connection Error",0+16, "Error")
ELSE 
   MESSAGEBOX("uraaaaa")   
ENDIF


z=get_luna_hbc(1)

PUBLIC dx1,dx2
STORE {} to dx1,dx2
d1=CTOD(GETWORDNUM(z,1,","))
d2=CTOD(GETWORDNUM(z,2,","))
dx1=d1
dx2=d2


ssq="select * from hbc_target WHERE 0=1"

x=SQLEXEC(xcon,ssq,"tmpc")
SELECT tmpc
COPY TO contract
CLOSE ALL
=excel_2_dbf()
USE CONTRACT IN 0 ALIAS CONTRACT

x=SQLEXEC(xcon,ssq,"tmpc")
SELECT TMPC

= MakeSPTUpdateable("TMPC","id","HBC_TARGET")
APPEND FROM DBF("CONTRACT")
=Tableupdate(.T.,.T.)		



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
**	?lcUpdatableFieldList
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
