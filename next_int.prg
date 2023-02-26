FUNCTION next_int
LPARAMETERS lq

lfract=lq-INT(lq)
ret=0
IF lfract>0
   ret=INT(lq)+1
ELSE
	ret=INT(lq)
endif   
RETURN ret