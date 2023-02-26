CLOSE ALL
CLEAR
SET ENGINEBEHAVIOR 70

USE db_criterii
SUM nota_crite TO x
?x/RECCOUNT()
med=x/RECCOUNT()
?"med="
??med
?"MEDD="
??100/RECCOUNT()
MED100=100/RECCOUNT()

delta=7000

SELECT *,(nota_crite/med)*MED100  as prok,get_greutate_min(ID_PRODUS,1) as gmin FROM db_cRIterii ORDER BY prok DESC INTO CURSOR CC
SELECT *,ROUND((DELTA*PROK/100)/gmin,0) AS ROT FROM CC INTO CURSOR C2
SELECT C2
BROWSE
SUM rot*gmin TO dlt
xd=delta-dlt

?"au mai ramas xd="
??xd
??" kilograme"
WAIT

SELECT *,xd AS DIFx FROM c2 INTO CURSOR c3
SELECT *,INT(difx/gmin) as itdif,((difx/gmin)-INT(difx/gmin))*gmin as newr FROM c3 INTO CURSOR c4 readwrite
SELECT c4
brow



IF difx<0
        GO bott
		difg=(-difx)

		DO WHILE NOT BOF()
		?difg
		?"rot*gmin"
		pkk=rot*gmin
		??rot*gmin
		?"poz="
		??RECNO()
		WAIT
		pkk=rot*gmin
			IF pkk<difg
				?"flag1"
				x=rot
				REPLACE rot WITH 0
				difg=difg-x*gmin
			ELSE
			    IF difg>=gmin
			        
			        rc=RECNO()
			        x=rot
				    ?"flag2 difg="
				    ??difg
				    ??" gmin="
				    ??gmin
				      
					newrot=INT(difg/gmin)
					?"rot="
					??rot
					?"newrot="
					??newrot
					
					df=x-newrot
					REPLACE rot WITH x-newrot
					?"------------------"
					difg=difg-(newrot*gmin)
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
							?"greutate minima ramasa in serie="
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
				?"gmin"
				
				IF gmin<=difg
					items=int(difg/gmin)
					REPLACE rot with rot+items
					difg=difg-items*gmin
					brow
				ELSE
					SELECT MAX(gmin) FROM c4 WHERE gmin<difg INTO ARRAY ming
					IF VARTYPE(ming)#"X" AND VARTYPE(ming)#"U" AND ming>0
						SELECT c4
						LOCATE FOR gmin=ming
						items=INT(difg/gmin)	
						REPLACE rot with rot+items
						difg=difg-items*gmin
					else
						
						SELECT MIN(RECNO()) FROM c4 WHERE gmin<=difg INTO ARRAY urec
						IF VARTYPE(urec)#"U" AND VARTYPE(urec)#"X"
						
						    SELECT c4
							GOTO urec
							REPLACE rot WITH INT(difg/gmin)
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

