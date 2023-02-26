FUNCTION f_get_greutate
LPARAMETERS pid


ret=0
SELECT g_com FROM articole_cola WHERE cod_hbc=pid INTO ARRAY ug
USE IN (SELECT("articole_cola"))

IF VARTYPE(ug)#"X" AND VARTYPE(ug)#"U"

	ret=ug
ENDIF

RETURN ug