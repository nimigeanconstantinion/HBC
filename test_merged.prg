CLOSE ALL
CLEAR
RELEASE ALL

path_in=CHR(34)+SYS(5)+CURDIR()+CHR(34)
WAIT "Incarc datele din excel in Baza de Date!!" WINDOW nowait

PATH_CRT=SYS(5)+CURDIR()
P_IN=CHR(34)+PATH_CRT+CHR(34)
a=GETFILE("xls*","","Open",1,"Alegeti fisierul EXCEL DE COMANDA")
**?a
**?JUSTFNAME(a)

 loexcel = CREATEOBJECT("Excel.application")
 SET DEFAULT TO &p_IN      


 WITH loexcel
       ob1 = loexcel.workbooks.open(a)
       OB1=LOEXCEL.ACTIVEWORKBOOK
       loexcel.visible=.t.
	   RW=0
	   prm=0
       FOR i=8 TO 200
            ?i
       		x=.cells(i,18).select

			IF !ISNULL(.cells(i,18).value) AND !ISBLANK(.cells(i,18).value) 
				PRM=.cells(i,18).value
			ENDIF 	
       		RW = .SELECTION.Rows.Count()

 			IF RW>1
				SWM=1	 						    
       			?"cELULA "+STR(I)+",18"+" ARE "
       			??RW
       		
       		ELSE
       		    SWM=0
       		    RW=0
       		    PRM=0
       		ENDIF
       	
       		IF SWM=1 
				?"cELULA "+STR(I)+",18"+" E MULTIPLA "
       			?"PRM="
       			??PRM
       			
       		ENDIF
       		WAIT
       endfor
 ENDWITH 
 SET DEFAULT TO 