FUNCTION check_art_mapping
LPARAMETERS lcon,lid,ldata

CLEAR
?lcon
?"ID INTERN="
??lid
?ldata

myq="SELECT * from mapare_articole where id_extern="+ALLTRIM(STR(lid))+" AND ALIVE=1"

**?myq
VK=SQLEXEC(lcon,myq,"crsCrt")
myq2="SELECT * from mapare_articole where 0=1"

VN=SQLEXEC(lcon,myq2,"crsNEW")

**WAIT
SELECT crsCrt
SELECT * FROM crsCrt INTO dbf tdb

SELECT CRSCRT

IF RECCOUNT()>0
**************************************************
	idext=lid
	rnk=id
	idint=id_intern
	SELECT * FROM crscrt INTO ARRAY asrv
	SELECT * FROM tmp_categ WHERE id_extern=idext INTO CURSOR cCx
	SELECT cCx
	**BROW
	pden=""
	pcateg=""
	psubcateg=""
	IF RECCOUNT()>0
		pden=ALLTRIM(articol)
		pcateg=ALLTRIM(grupa)
		psubcateg=ALLTRIM(segment)
	ENDIF
	SELECT * FROM tmp_comanda_hbc WHERE cod_hbc=idext INTO CURSOR chX
**	USE IN (SELECT("tmp_comanda_hbc"))
	SELECT chX

	pum1=um_com
	pit1=item_com
	pg1=g_com
	pp1=pret_com
	
	STORE 0 TO pret_min,g_min,pret_max,g_max,pg2,pg3,pp2,pp3
	
	pum2=um_min
	pit2=item_min
	
	pum3=um_max
	pit3=item_max
	
	UPDATE tdb SET den_art=pden,categ=pcateg,subcateg=psubcateg,;
		um_1=pum1,item_1=pit1,g_1=pg1,p_1=pp1,;
		um_2=pum2,item_2=pit2,g_2=pg2,p_2=pp2,;
		um_3=pum3,item_3=pit3

    SELECT TDB
    NRF=AFIELDS(ARF)
    STORE 0 TO swch
    FOR i=1 TO nrf
    	STORE arf(i,1) TO fld
	
		IF &fld#asrv(i)   		 	
    		swch=1
    		EXIT
    	endif	
    ENDFOR

	IF swch=1
		WAIT "AM GASIT DIFERENTE"
			
		UPDATE tdb SET id=0,alive=1,ch_data=DATE()
		
		SELECT crscrt
		
		MakeSPTUpdateable("crscRT","id","mapare_articole")
		
		REPLACE alive WITH 0
		
    	z=Tableupdate(.T.,.T.)		

		SELECT crsnew
		MakeSPTUpdateable("crsNEW","id","mapare_articole")
		
		APPEND FROM DBF("tdb")
    	z=Tableupdate(.T.,.T.)		
		

	endif

	USE IN CRSCRT
	USE IN CRSNEW
	USE IN CHX
	USE IN CCX
	SELECT TDB
	ZAP
	
**************************************************
ELSE
*!*	    WAIT "HERE " WIND
*!*	    WAIT LID WIND
*!*	    WAIT VARTYPE(LID) WIND
*!*	    

    SELECT * FROM TESTT WHERE ID_extern=LID INTO CURSOR KX
**    USE IN (SELECT("TESTT"))
    SELECT KX
    
	idext=lid
	idint=id_intern
	
	SELECT * FROM crscrt INTO ARRAY asrv
	SELECT * FROM tmp_categ WHERE id_extern=idext INTO CURSOR cCx
	SELECT cCx
	**BROW
	pden=""
	pcateg=""
	psubcateg=""
	IF RECCOUNT()>0
		pden=ALLTRIM(articol)
		pcateg=ALLTRIM(grupa)
		psubcateg=ALLTRIM(segment)
	ENDIF
	SELECT * FROM articole_cola WHERE cod_hbc=idext INTO CURSOR chX
	SELECT chX

	pum1=um_com
	pit1=item_com
	pg1=g_com
	pp1=pret_com
	
	STORE 0 TO pret_min,g_min,pret_max,g_max,pg2,pg3,pp2,pp3
	
	pum2=um_min
	pit2=item_min
	
	pum3=um_max
	pit3=item_max
	
	INSERT INTO TDB (ID,ID_EXTERN,ID_INTERN,FURNIZOR,DEN_ART,CATEG,SUBCATEG,UM_1,ITEM_1,G_1,P_1,UM_2,ITEM_2,G_2,P_2,UM_3,ITEM_3,ALIVE,CH_DATA);
	 VALUES(0,IDEXT,idint,1,PDEN,PCATEG,PSUBCATEG,PUM1,PIT1,PG1,PP1,PUM2,PIT2,PG2,PP2,PUM3,PIT3,1,DATE())
*!*		den_art=pden,categ=pcateg,subcateg=psubcateg,;
*!*		um_1=pum1,item_1=pit1,g_1=pg1,p_1=pp1,;
*!*		um_2=pum2,item_2=pit2,g_2=pg2,p_2=pp2,;
*!*		um_3=pum3,item_3=pit3,alive=1,ch_data=DATE()
SELECT CRSNEW
**BROWSE TITLE "ASTA E CURSORUL"
 MakeSPTUpdateable("crsNEW","id","mapare_articole")
 APPEND FROM DBF("TDB")
	z=Tableupdate(.T.,.T.)		
USE IN CRSCRT
USE IN CRSNEW
USE IN CCX
USE IN CHX
USE IN KX

ENDIF
RETURN 



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
