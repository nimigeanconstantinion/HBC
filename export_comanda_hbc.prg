FUNCTION export_comanda_hbc
LPARAMETERS lfis

 loexcel = CREATEOBJECT("Excel.application")
 aici=SYS(5)+CURDIR()
 torap=aici+"Rapoarte\"
       

 WITH loexcel
       ob1 = loexcel.workbooks.open(lfis)
       OB1=LOEXCEL.ACTIVEWORKBOOK
       NRS=OB1.Sheets.Count

       FOR I=1 TO NRS
       
       		IF AT("formular pentru",LOWER(OB1.Sheets(i).name))#0
       		    EXIT
       		endif    
       		 
       ENDFOR 
       loexcel.visible=.t.
       ob1.sheets(i).select
       sh=loexcel.activesheet
       rst=0
       FOR i=1 TO 20
       		IF !ISNULL(.cells(i,1).value)
       			.cells(i,1).select
       			adr=.selection.rows.count()
       			z=.cells(i,1).text
       			?z
       			rst=i+adr
       			IF AT("categ",LOWER(z))#0
       			   EXIT
       			endif   
       		endif
       
       ENDFOR
       ?"rst="
       ??rst
       wait
 ENDWITH 
 loexcel.quit