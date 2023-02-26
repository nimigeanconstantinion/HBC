FUNCTION f_round_min
LPARAMETERS cod,qant

ret=0

SELECT * FROM articole_cola WHERE cod_hbc=cod INTO CURSOR crs
USE IN (SELECT("articole_cola"))

SELECT crs



qmin=item_min/item_com

IF qant>0

	ret = ROUND(qant/qmin,0)


ENDIF
USE IN crs

RETURN ret