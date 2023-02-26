*PUBLIC Testx,xcon
CLOSE ALL
CLEAR
SET SAFETY OFF
SET TALK OFF

Testx="DRIVER={MySQL ODBC 8.0 Unicode Driver};SERVER=localhost;PORT=3306;DATABASE=ecuator; USER=root;PASSWORD=root;OPTION=3;"

xCon = SQLSTRINGCONNECT(Testx)
z=1000
?xcon
WAIT

*!*	lnRetVal = SQLEXEC(xcon,"Select * From mapare_articole","curMap")


*!*	SELECT 00000 as id,cod_hbc as id_extern,cod_ecu as id_intern,1 as id_furniz FROM map_articole INTO dbf testt

*!*	SELECT curmap
*!*	Append From DBF("testt")

*!*	*!*	SELECT 00000 as id,cod_hbc as id_extern,cod_ecu as id_intern,1 as id_furniz FROM map_articole INTO dbf ccr
*!*	    
*!*		MakeSPTUpdateable("curMap","id","mapare_articole")
*!*		BROWSE TITLE "cursor updatable"
*!*	*!*	BROWSE

*!*	* and commit that data to MySQL
*!*	Tableupdate(.T.,.T.)

SELECT *,check_art_mapping(xcon,cod_hbc,DATE()) FROM tmp_comanda_hbc