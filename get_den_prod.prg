FUNCTION get_den_prod
LPARAMETERS lcod,con

ret=""

IF VARTYPE(lcod)="N"
	ssql="select den_art from mapare_articole where alive=1 and id_extern="+ALLTRIM(STR(lcod))
	=SQLEXEC(con,ssql,"tmpp")
	SELECT tmpp
	IF RECCOUNT()>0
	    ret=den_art
	ENDIF
USE
ENDIF
RETURN ret    


