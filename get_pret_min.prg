FUNCTION get_pret_min
LPARAMETERS cod,q


SELECT * FROM articole_cola WHERE cod_hbc=cod INTO CURSOR cr
USE IN (SELECT("articole_cola"))
SELECT cr
ret=(item_min/item_com)*pret_com

USE IN cr
RETURN ret
