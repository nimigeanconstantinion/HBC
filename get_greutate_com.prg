FUNCTION get_greutate_com

LPARAMETERS codext

ret=0
SELECT g_1 FROM tmp_map_art_1 WHERE id_extern=codext INTO ARRAY ug
USE IN (SELECT("tmp_map_atrt_1"))

IF VARTYPE(ug)#"X" AND VARTYPE(ug)#"U" AND ug>0
    ret=ug
ENDIF

RETURN ret    