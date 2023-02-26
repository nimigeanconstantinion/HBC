FUNCTION retur_realoc_0
LPARAMETERS pcod,bd1,bd2


**?bd2

PUBLIC ARRAY arr(2)
STORE 0 TO arr(1),arr(2)

pc=0
pra=0
SELECT q_com_0,q_ret_0 FROM &bd1 WHERE id_ext=pcod INTO ARRAY ura

pc=ura(1)
pr=ura(2)

SWW=0
IF pr>0 
	if(pc>=pr)
		ARr(1)=PR
		ARr(2)=pr
		SWW=1
	ELSE
	   ARr(1)=PR
	   ARr(2)=PC
	   SWW=2	
	
	ENDIF

endif


IF SWW>0
		SELECT * FROM &BD2 WHERE id_ext=PCOD AND (Q_REt>0 OR Q_nec>0) INTO CURSOR CW ORDER BY Q_nec desc
		USE IN (SELECT(BD2))
*!*			SELECT CW
*!*			BROWSE TITLE "CW-UL"
		TR=ARr(1)
		TA=0
        
		DO WHILE NOT EOF()
		    SELECT cw
*!*			    BROW
*!*			    ?"tr="
*!*			    ??tr
*!*			    ?"ta="
*!*			    ??ta
		
		    pcod=id_ext
		    pqn=q_nec
		    pqr=q_ret
		    
		    
		    PPL=ID_PL
*!*			    ?"pqn="
*!*			    ??pqn
*!*			    ?"pqr="
*!*			    ??pqr
*!*			    ?"pcod="
*!*			    ??pcod
*!*			    ?"tr="
*!*			    ??tr
*!*	    WAIT
			IF pqn>0
				IF pqn>=TR
					ta=ta+tr
*!*						?"pqn>=tr"
*!*						?"PUN LA REALOCARE="
*!*						??TR
					UPDATE &BD2 SET REALOCARE=TR WHERE id_ext=PCOD AND ID_PL=PPL
					USE IN (SELECT(BD2))
					SELECT CW
					TR=0
					
				
				ELSE
					
					UPDATE &BD2 SET REALOCARE=pqn WHERE id_ext=PCOD AND ID_PL=PPL
					USE IN (SELECT(BD2))
					SELECT CW
					
					TR=TR-pqn
				
				ENDIF
				
				
			
			ELSE
					UPDATE &BD2 SET RETUR=pqr WHERE id_ext=PCOD AND ID_PL=PPL
					USE IN (SELECT(BD2))
			
					SELECT CW
					TA=TA+pqr
					tr=tr-pqr
			ENDIF
			**IF TR=0 anD TA=arr(2)
			SELECT CW
			SKIP   
		
		ENDDO	 

**	ENDIF
ENDIF

IF USED("cw")
   USE IN cw
endif   

RETURN
