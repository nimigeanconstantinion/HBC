FUNCTION get_g
LPARAMETERS pid,pid_um,n


CLEAR

IF pid_um>0
USE um_articole order id_articol shared again IN 0 ALIAS uu

**	USE um_articole order id_articol IN 0 again SHARED ALIAS uu
	sele uu
	 
	**SELECT * FROM um_articole WHERE id_articol=pid INTO CURSOR cx
	**USE IN SELECT("um_articole")
	
	SEEK pid
	rk=0

	FOR i=0 TO 2
		STORE "R"+ALLTRIM(STR(i)) TO f
		IF &f=1
		   EXIT
		endif   
	ENDFOR

	rk=i

	FOR i=0 TO 2
		STORE "um"+ALLTRIM(STR(i)) TO f
		IF &f=pid_um
		   EXIT
		endif   
	ENDFOR
	rm=i

	px="it"+ALLTRIM(STR(rk))
	gx="g"+ALLTRIM(STR(rk))
	qf=&px
	gf=&gx

	wx="it"+ALLTRIM(STR(rm))
	qb=&wx
	USE IN uu 
	RETURN (qb*n/qf)*gf
		
ELSE
		RETURN 0
endif