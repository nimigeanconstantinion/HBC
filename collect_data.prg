FUNCTION collect_data
LPARAMETERS pcon


path_in=CHR(34)+SYS(5)+CURDIR()+CHR(34)

IF get_com_unfinished(pcon)=0
***************************************************************
		WAIT "Incarc datele din excel in Baza de Date!!" WINDOW nowait

		LOCAL lcXLBook AS STRING, lnSQLHand AS INTEGER, ;
		    lcSQLCmd AS STRING, lnSuccess AS INTEGER, ;
		    lcConnstr AS STRING

		PATH_CRT=SYS(5)+CURDIR()
		P_IN=CHR(34)+PATH_CRT+CHR(34)
		a=GETFILE("xls*","","Open",1,"Alegeti fisierul EXCEL DE COMANDA")

 		loexcel = CREATEOBJECT("Excel.application")
 		SET DEFAULT TO &p_IN      

 		WITH loexcel
       		ob1 = loexcel.workbooks.open(a)
       		OB1=LOEXCEL.ACTIVEWORKBOOK
       		NRS=OB1.Sheets.Count
			prm=0
			swm=0
			SWP=0
			SWR=0
	       	FOR I=1 TO NRS
       
		       		IF AT("formular pentru",LOWER(OB1.Sheets(i).name))#0
		       		    EXIT
		       		endif    
       		 
	       	ENDFOR 
       
       		loexcel.visible=.t.
       		ob1.sheets(i).select
       
       		r=8
       		k=4
       		STORE 0 TO m.cod_hbc,m.um_com,m.item_com,m.g_com,m.pret_com,m.um_min,m.item_min
       		STORE "                                       " TO m.denumire
       		
       		FOR n=8 TO 200
	       		IF LEN(ALLTRIM(.cells(n,4).value))=0 OR ISNULL(.cells(n,4).value)
	       
	           		EXIT
	       		ELSE
		       		culoare=.cells(n,4).Interior.ColorIndex 
	       
	 	       		m.cod_hbc=.cells(n,6).value
		       		.CELLS(n,1).SELECT
			   		alfab="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyzx1234567890 &$-.,()"
				   m.cod_hbc=.cells(n,5).value
				   m.denumire=.cells(n,4).value
				   m.disponibil=.cells(n,3).value
				   m.um_com=7
				   m.item_com=.cells(n,8).value
				   m.g_com=.cells(n,25).value
				   m.pret_com=.cells(n,9).value       
				   m.rank_com=n-8+1	

		       		if(culoare=4)
			       		m.um_min=6
			       		m.item_min=.cells(n,6).value*m.item_com
			       		m.um_max=6
			       		m.item_max=m.item_min
		       		ELSE
			       		m.um_min=4
			 			m.item_min=.cells(n,7).value*m.item_com
			 			m.um_max=6
			 			m.item_max=.cells(n,6).value*m.item_com   
			       	ENDIF

	        		.cells(n,18).select
	       			RW = .SELECTION.Rows.Count()

	 				IF RW>1 
	 			    	IF SWR=0
							RLIM=N+RW-1
							SWR=1
							IF (ISNULL(.cells(n,18).value) OR ISBLANK(.cells(n,18).value)) 
								prm=0
							ELSE
								PRM=.cells(n,18).value
							ENDIF
						endif
       				ELSE
*!*	       			?"================Celula simpla======================"    
				
						RLIM=N				       		    
						IF (ISNULL(.cells(n,18).value) OR ISBLANK(.cells(n,18).value)) 
					 		prm=0
						ELSE
							PRM=.cells(n,18).value
						ENDIF
						SWR=1
       				ENDIF
		
		    		IF N=RLIM
		       			SWR=0
		    		ENDIF   
			
				
					m.promo=prm
       
	       			USE tmp_cmd_hbc
	       
	       			APPEND BLANK
	       			GATHER memvar
	       			CLOSE ALL
       
       			endif    
       
       		endfor
 			LOEXCEL.VISIBLE=.T.

***** INCARC CATEGORIILE DIN FORMULAR	   
			=load_categ(loexcel)
			loexcel.visible=.f.
			ob1.Close(.F.)
			loExcel.Quit() 
 		ENDWITH 
 
 		RELEASE loexcel
 		SET DEFAULT TO &p_IN      
		CLOSE ALL

ELSE


endif
