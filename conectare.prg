CLOSE ALL
CLEA

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


*X=COLLECT_DATA(XCON)
******j=load_ptcs(xcon)
**SELECT *,GET_ID_EXTERN(COD_ECU,XCON) FROM BDPTC


*!*	lnRetVal = SQLEXEC(xcon,"Select * From mapare_articole","curMap")
*!*	**SELECT * FROM TESTT INTO DBF XT


*!*	SELECT curmap
*!*	COPY TO bdk
*!*	brow
*!*	SELECT *,COUNT(*) as kn FROM curmap GROUP BY id_extern INTO CURSOR c1
*!*	SELECT c1
*!*	BROWSE FOR kn>1 TITLE "group id_intern"
*!*	SELECT *,COUNT(*) as kn FROM curmap GROUP BY id_extern INTO CURSOR c2
*!*	SELECT c2
*!*	BROWSE FOR kn>1 TITLE "grupat id_extern"


**** era SELECT *,hbc_get_categ_by_id(cod_hbc,xcon) FROM tmp_cmd_hbc 
*** ok =method_cmd0(xcon)

*!*	ssq="truncate table temp_ptc"

*!*	=SQLEXEC(xcon,ssq,"tmpc")

ssq="select * from comenzi where 0=1"
c=SQLEXEC(xcon,ssq,"tmpp")
SELECT tmpp
SELECT * FROM tmpp INTO dbf delbd
USE IN (SELECT("delbd"))
USE delbd IN 0 ALIAS b
SELECT b
APPEND BLANK

REPLACE id_furniz WITH 1,data_cmd WITH DATE(),user with "Veronica"
BROWSE


=MakeSPTUpdateable("tmpp","id_cmd","comenzi")
SELECT tmpp

IF FILE("delbd.dbf")
    WAIT "exista"
ELSE
	?"nu-i"
endif	
    
APPEND FROM DBF('b')
XR=Tableupdate(.T.,.T.)
?xr
SELECT tmpp
brow
nState=GETFLDSTATE("id_cmd")
WAIT nstate wind
ssql=CHR(34)+"show table status like "+CHR(39)+"comenzi"+CHR(39)+CHR(34)
?ssql
c=SQLEXEC(xcon,&ssql,"tx")
SELECT tx
BROWSE TITLE "tx"
?c
c=SQLEXEC(xcon,"select MAX(id_cmd) from comenzi","tx")
SELECT tx
brow

*!*	XR=Tableupdate(.T.,.T.)		
*!*	ssql="select last_insert_id()"
*!*	c=SQLEXEC(xcon,ssq,"tmpp")
*!*	SELECT tmpp
*!*	brow

