FUNCTION test_redis_greutate
LPARAMETERS pbd,pdifx

CLOSE ALL
CLEAR
SET ENGINEBEHAVIOR 70
?pbd

delta=pdifx


SELECT *,get_greutate_min(cod_hbc,1) as gmin;
 FROM &pbd WHERE comanda_1>0 ORDER BY nota_crite DESC INTO CURSOR CC

SELECT cc

IF delta<0
	SELECT *,00000.000000 AS ROT FROM CC ORDER BY nota_crite ASC INTO CURSOR C2

ELSE

	SELECT *,00000.000000 AS ROT FROM CC ORDER BY nota_crite deSC INTO CURSOR C2

endif
SELECT C2
*!*	BROWSE TITLE "dupa prima evaluare"
*!*	SUM rot*gmin TO dlt
*!*	xd=delta-dlt

*!*	?"au mai ramas xd="
*!*	??xd
*!*	??" kilograme"
*!*	WAIT "--------------------------------------------------"

*!*	SELECT *,xd AS DIFx FROM c2 INTO CURSOR c3
SELECT * FROM c2 INTO CURSOR c4 readwrite



SELECT c4
BROWSE TITLE "Inainte de redistribuire"
pdif=ABS(pdifx)
swex=0
swadd=0
IF pdifx>0
	swadd=1
ENDIF
swpas=0

DO WHILE swex=0
	
	qmin=ret_q_min(cod_hbc)

	SELECT c4
	p_gmin=gmin

	?"comanda_1="
	??comanda_1
	
	?"Cant min="
	??qmin
	
	?"Greutare min="
	??p_gmin
	
	valk=ROUND(comanda_1/qmin,0)
	
	?"Cate qmin incap in comanda_1?"
	??valk
	
	
	?"comanda devine "
	
		
	?"comanda=valk*qmin="
	??valk*qmin
	?"----------------------------------"
	
	
	deredis=tot_st_max-(tot_dispo+valk*qmin)
	?"Pana la stoc max um comercial="
	??deredis
	
	IF swadd>0
		?"In um min="
		vsup=int((deredis/qmin)*.7)
		??vsup
		
		
		
		
		
		?"pdif era="
		??pdif
		newv=0
		
		IF vsup>0
		
			IF gmin<=pdif	
				
				IF vsup*p_gmin<=pdif
					newv=vsup
					pdif=pdif-vsup*p_gmin
				
				ELSE
					newv=int(pdif/p_gmin)
					pdif=pdif-newv*p_gmin
				
				endif
				
				
				
			
			
			endif

		
		
		endif
		?"Comanda redistrib ="
		??newv

		?"pdif devine="
		??pdif
		
		wait
	

ELSE
    SELECT c4
    ?"Scadere"
	?"Recno="
	??RECNO()
    newv=0
	IF p_gmin<=pdif
		IF comanda_1*p_gmin<=pdif
			
			newv=-comanda_1
			pdif=pdif+newv*gmin
		ELSE
		    
			newv=-INT(pdif/gmin)
			pdif=pdif+newv*gmin
			?"Noul newv="
			??newv
			wait
		endif
		
	
	endif
	
endif
		SELECT c4
			
		
		REPLACE rot WITH newv
	SKIP

IF EOF() OR pdif<=0.01*ABS(pdifx)
	?" -----pdif="
	??pdif
	?"pdifx="
	??ABS(pdifx)
	?RECNO()
	wait
	exit
endif
enddo


?"la final pdif="
??pdif
wait
SELECT c4
brow
SUM rot*gmin TO x
?"Am ajustat "
??x
wait
CLEAR


FUNCTION GET_ALL_ROT
LPARAMETERS DELTA,pgmin
SELECT SUM(ROT*pgmin) FROM C2 INTO ARRAY UALL

RETURN DELTA-UALL



FUNCTION get_prev_gmin
LPARAMETERS rc,prest

ret=0
SELECT *,RECNO() as rk FROM c4 WHERE RECNO()<rc AND gmin<=prest INTO CURSOR xcrs

SELECT xcrs
IF RECCOUNT()>0
	GO bott
	ret =rk
	

endif
USE IN xcrs

return ret


FUNCTION get_next_gmin
LPARAMETERS rc,prest

ret=0
SELECT *,RECNO() as rk FROM c4 WHERE RECNO()>rc AND gmin<=prest INTO CURSOR xcrs

SELECT xcrs
IF RECCOUNT()>0
	GO top
	ret =rk
	

endif
USE IN xcrs

return ret