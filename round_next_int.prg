FUNCTION round_next_int
LPARAMETERS lq

lfract=lq-INT(lq)
ret=0
IF lfract>0
    ret=INT(lq)+1
ELSE
	ret=lq
ENDIF
RETURN ret