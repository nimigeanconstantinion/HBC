FUNCTION get_com_unfinished
LPARAMETERS pcon

ret=0
myq="SELECT * from comenzi where stare<3"

rez=SQLEXEC(pcon,myq,"crscom")

SELECT crscom
IF RECCOUNT()>0
    ret=id_cmd
ENDIF
USE IN crscom
RETURN ret    
