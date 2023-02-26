FUNCTION excel_2_dbf

CLEAR
ph=CHR(34)+SYS(5)+CURDIR()+CHR(34)

a=GETFILE("xls?","Alege")

SET DEFAULT TO &ph

loexcel = CREATEOBJECT("Excel.application")
 SET DEFAULT TO &ph     

 WITH loexcel
       ob1 = loexcel.workbooks.open(a)
       OB1=LOEXCEL.ACTIVEWORKBOOK
	   loexcel.visible=.t.
	   FOR j=1 TO 20
	   		IF !ISDIGIT(.cells(1,j).text)
	   			EXIT
	   		endif	
	   		
	   ENDFOR
	   d=j
	   
	   FOR  j=1 TO d-1
			   FOR i=2 TO 30
				   	IF !ISNULL(.cells(1,j).text) and !ISBLANK(.cells(1,j).text) 
				   		ctg=.cells(1,j).value
				   	
				   		IF !ISNULL(.cells(i,j).text) and !ISBLANK(.cells(i,j).text) and LEN(ALLTRIM(.cells(i,j).text))#0
				   		    ?"i="
				   		    ??i
				   		    ?"j="
				   		    ??j
				   		    ?"ctg="
				   		    ??ctg
				   			pra=.cells(i,j).value
				   			IF ctg=6 OR ctg=14
							dk=.cells(i,d+1).value
							ELSE
							dk=.cells(i,d).value
							endif
							?"prag="
							??pra
							?"disc="
							??dk
							
							INSERT INTO contract (id_categ,discount,prag,alive,data1,data2) values(ctg,dk*100,pra,1,dx1,dx2)
						   			
				   		ELSE
				   			exit	
				   		endif	
				   	ELSE
				   		exit
				   	endif
			   ENDFOR
	   endfor
ENDWITH 

loexcel.quit
CLOSE all