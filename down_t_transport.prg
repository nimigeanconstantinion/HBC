FUNCTION DOWN_T_TRANSPORT
LPARAMETERS pbd,pdif

CLOSE ALL
CLEAR
SET ENGINEBEHAVIOR 70
?pbd

USE &pbd
SUM nota_crite TO x
?x/RECCOUNT()
med=x/RECCOUNT()
?"med="
??med
?"MEDD="
??100/RECCOUNT()
MED100=100/RECCOUNT()

wait
delta=pdif


SELECT *,(nota_crite/med)*MED100  as prok,get_greutate_min(ID_PRODUS,1) as gmin;
 FROM &pbd WHERE comanda0>0 ORDER BY prok ASC INTO CURSOR CC

SELECT *,00000.00 AS ROT FROM CC INTO CURSOR CCX READWRITE 


SELECT CCX
BROWSE


IF DELTA<0
	DIFG=-DELTA
ENDIF

DO WHILE NOT EOF()
	XG=GMIN
	N=INT(DIFG/GMIN)
	?RECNO()
	?N
	?"DIFG="
	??DIFG
	WAIT
	CROT=0

	IF N>0
		IF N>=COMANDA0
		  CROT=-COMANDA0
		  DIFG=DIFG-(COMANDA0*GMIN)
		ELSE
		  CROT=-N	
		  DIFG=DIFG-(N*GMIN)
		ENDIF  		
		REPLACE ROT WITH CROT
	
	ELSE
		R=GET_NEXT_GMIN(RECNO(),DIFG)
		?"NEX RECORD="
		??R
		WAIT
		IF R>0
			SELECT CCX
			GOTO R-1
		ELSE
			EXIT
		ENDIF
		
	ENDIF	
	SELECT CCX
		   	   
	SKIP
ENDDO

SELECT CCX
*!*	SELECT *,COMANDA0+ROT as newcom FROM CCX INTO CURSOR ccx2
REPLACE ALL comanda0 WITH ret_comanda0(id_produs) FOR rec=0
REPLACE ALL comanda0 
BROWSE FOR rot<>0
=split_comanda()

*!*	SELECT * FROM ccx2 WHERE newcom#comanda0


SELECT * FROM ccx WHERE rot=0 OR 


fuNCTION get_next_gmin
LPARAMETERS rc,prest

ret=0
SELECT *,RECNO() as rk FROM cCX WHERE RECNO()>rc AND gmin<=prest INTO CURSOR xcrs

SELECT xcrs
IF RECCOUNT()>0
	GO top
	ret =rk
	

endif
USE IN xcrs

return ret


FUNCTION ret_comanda0
LPARAMETERS lcod

ret=0
SELECT * FROM ccx WHERE id_produs=lcod INTO CURSOR tmpc
SELECT tmpc
IF RECCOUNT()>0
	IF rot=0

  		ret=comanda0
  	ELSE
  		ret=comanda0-ABS(rot)
  	endif	
ENDIF
RETURN ret


FUNCTION split_comanda()


