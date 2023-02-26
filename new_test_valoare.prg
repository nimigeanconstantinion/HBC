FUNCTION new_test_valoare
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


SELECT *,(nota_crite/med)*MED100  as prok,get_pret_min(ID_PRODUS,1) as pmin FROM &pbd ORDER BY prok DESC INTO CURSOR CC
SELECT *,ROUND((DELTA*PROK/100)/pmin,0) AS ROT FROM CC INTO CURSOR C2
SELECT C2
BROWSE
SUM rot*pmin TO dlt
xd=delta-dlt

?"au mai ramas xd="
??xd
??" lei"
WAIT "--------------------------------------------------"



SELECT *,xd AS DIFx FROM c2 INTO CURSOR c3
SELECT *,INT(difx/pmin) as itdif,((difx/pmin)-INT(difx/pmin))*pmin as newr FROM c3 INTO CURSOR c4 readwrite
SELECT c4
brow



IF difx<0
        GO bott
		difg=(-difx)

		DO WHILE NOT BOF()
		?difg
		?"rot*pmin"
		pkk=rot*pmin
		??rot*pmin
		?"poz="
		??RECNO()
		WAIT
		pkk=rot*pmin
			IF pkk<difg
				?"flag1"
				x=rot
				REPLACE rot WITH 0
				difg=difg-x*pmin
			ELSE
			    IF difg>=pmin
			        
			        rc=RECNO()
			        x=rot
				    ?"flag2 difg="
				    ??difg
				    ??" pmin="
				    ??pmin
				      
					newrot=INT(difg/pmin)
					?"rot="
					??rot
					?"newrot="
					??newrot
					
					df=x-newrot
					REPLACE rot WITH x-newrot
					?"------------------"
					difg=difg-(newrot*pmin)
					?"Atentie difg="
					??difg
		*!*				SELECT MIN(gmin) FROM c4 WHERE RECNO()<rc INTO ARRAY rx
		*!*				gkmin=0
		*!*				SELECT c4
		*!*				IF VARTYPE(rx)#"X" AND VARTYPE(rx)#"U"
		*!*					   gkmin=rx 
		*!*				ENDIF
		*!*				IF gkmin>0 AND difg<gkmin
		*!*					difg=gkmin
		*!*				endif
					WAIT
				ELSE
				      IF difg>0
							SELECT MIN(gmin) FROM c4 WHERE RECNO()<rc INTO ARRAY rx
							?"pret minim ramasa in serie="
							??rx
							difg=rx
					  endif		
										
				endif
			ENDIF
			SELECT c4
			brow
			SKIP -1
		enddo
ELSE
			difg=difx
			GO top
			DO WHILE NOT EOF()
				?difg
				?"pmin"
				
				IF pmin<=difg
					items=int(difg/pmin)
					REPLACE rot with rot+items
					difg=difg-items*pmin
					brow
				ELSE
					SELECT MAX(pmin) FROM c4 WHERE pmin<difg INTO ARRAY ming
					IF VARTYPE(ming)#"X" AND VARTYPE(ming)#"U" AND ming>0
						SELECT c4
						LOCATE FOR pmin=ming
						items=INT(difg/pmin)	
						REPLACE rot with rot+items
						difg=difg-items*pmin
					else
						
						SELECT MIN(RECNO()) FROM c4 WHERE pmin<=difg INTO ARRAY urec
						IF VARTYPE(urec)#"U" AND VARTYPE(urec)#"X"
						
						    SELECT c4
							GOTO urec
							REPLACE rot WITH INT(difg/pmin)
						endif
						
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

