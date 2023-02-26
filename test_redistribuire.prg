FUNCTION test_redistribuire
LPARAMETERS pbd,pdifx

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
delta=pdifx


SELECT *,(nota_crite/med)*MED100  as prok,get_greutate_min(cod_hbc,1) as gmin;
 FROM &pbd WHERE comanda_1>0 ORDER BY prok DESC INTO CURSOR CC

SELECT cc

IF delta<0
?"PING------------------------------"
	SELECT *,IIF(comanda_1+ROUND((DELTA*PROK/100)/gmin,0)<0,-comanda_1,ROUND((DELTA*PROK/100)/gmin,0)) AS ROT FROM CC ORDER BY PROK DESC INTO CURSOR C2

ELSE

	SELECT *,ROUND((DELTA*PROK/100)/gmin,0) AS ROT FROM CC INTO CURSOR C2

endif
SELECT C2
BROWSE TITLE "dupa prima evaluare"
SUM rot*gmin TO dlt
xd=delta-dlt

?"au mai ramas xd="
??xd
??" kilograme"
WAIT "--------------------------------------------------"

SELECT *,xd AS DIFx FROM c2 INTO CURSOR c3
SELECT *,INT(difx/gmin) as itdif,((difx/gmin)-INT(difx/gmin))*gmin as newr FROM c3 INTO CURSOR c4 readwrite



SELECT c4
BROWSE TITLE "Inainte de redistribuire"
pdif=ABS(pdifx)
swex=0
DO WHILE swex=0
	BROWSE
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
	
	?"In um min="
	vsup=int((deredis/qmin))
	??vsup
	
	
	
	
	
	?"pdif era="
	??pdif
*!*		?"pdif devine="
*!*		pdif=pdif-vsup*p_gmin
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
	
	SELECT c4
		
	
	
SKIP
IF EOF()
	exit
endif
enddo

CLEAR
?"la final pdif="
??pdif
wait


IF difx<0
        GO bott
        
		difg=(-difx)
*!*			?"Diferenta negativa"
		DO WHILE NOT BOF()
*!*			?"Diferenta negativa"
*!*			?"---------------------------------------------------"		
*!*					?"difg"
*!*					??difg
*!*					?"rot*gmin"
				pkk=rot*gmin
				**??rot*gmin
				**?"poz="
*!*					??RECNO()
*!*					
*!*					brow
				pkk=rot*gmin
				pkk=gmin
				IF pkk<0
				   pkk=-pkk
				endif   
				IF pkk<=difg
*!*							?"**flag1-----------"
*!*							?"pkk<difg"
						k0=comanda_1
						x=rot
						z=INT(difg/pkk)
*!*							?"dif de greutate de redistribuit="
*!*							??difg
*!*							?"comanda0="
*!*							??comanda0
*!*							?"rot="
*!*							??rot
*!*							?"g min a produs="
*!*							??pkk
*!*							
*!*							?"incap z="
*!*							??z
*!*							
*!*							
						  news=-z
						  
						IF comanda_1+x+news>=0
						    SELECT c4
						    
						   	
							REPLACE rot WITH x+news	    
					        
							difg=difg+news*gmin
								
						ELSE
*!*							    ?"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
							rt=-comanda_1
							y=comanda_1+x
							REPLACE rot WITH rt		
							difg=difg-y*gmin
*!*								?difg
						endif    
						
						
					ELSE
					    crt=RECNO()
*!*							?"Prima saritura la gmin"				    
						prevrec=get_prev_gmin(crt,difg)
*!*							?"prevrec="
*!*							??prevrec
*!*							WAIT "asta e pvrec"
						
						SELECT c4
						IF prevrec>0 
						    IF prevrec=RECCOUNT()
						       pv=RECCOUNT()-1
						    endif   
							GOTO prevrec+1
							
						ELSE
							exit
						
						endif
					ENDIF
					Select c4

					Skip -1
					If difg<0
						Exit
					Endif
		enddo
ELSE
			difg=difx
			GO top
			DO WHILE NOT EOF()
					IF gmin<=difg
						items=int(difg/gmin)
						REPLACE rot with rot+items
						difg=difg-items*gmin
					ELSE
					    crt=RECNO()
						pnextrec=get_next_gmin(crt,difg)
						
						SELECT c4
						IF pnextrec>0 
						    IF pnextrec=RECCOUNT()
						       pv=RECCOUNT()-1
						    endif   
							GOTO prevrec+1
							
						ELSE
							exit
						
						endif
				endif			
				SELECT c4
				skip
			enddo			

endif


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