FUNCTION load_ptc
*-----------------------------------
* AUTHOR: Trevor Hancock
* CREATED: 02/15/08 04:55:31 PM
* ABSTRACT: Code demonstrates how to connect to
* and extract data from an Excel 2007 Workbook
* using the "Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)"
* from the 2007 Office System Driver: Data Connectivity Components
*-----------------------------------
CLOSE ALL
SET SAFETY OFF
SET TALK OFF
SET ENGINEBEHAVIOR 70
SET DATE TO dmy
SET CENTURY on
CLOSE ALL
*!*	USE xcms
*!*	ZAP
CLOSE all

RELEASE ALL

path_in=SYS(5)+CURDIR()
c_in=CHR(34)+path_in+CHR(34)


ERASE tmpfis.xls

LOCAL lcXLBook AS STRING, lnSQLHand AS INTEGER, ;
    lcSQLCmd AS STRING, lnSuccess AS INTEGER, ;
    lcConnstr AS STRING
CLEAR
FOR i=1 TO 2
	a=GETFILE("xls*","","Open",1,"Alegeti fisierul PTC-Puncte de lucru")

	 loexcel = CREATEOBJECT("Excel.application")
	 namesh=""
	 WITH loexcel
	    owb=.application.workbooks.open(a)
		owb.sheets(1).activate
		osh=owb.sheets(1).name
		namesh=osh
	 ENDWITH 
	 loexcel.quit
	 RELEASE loexcel
	 SET DEFAULT TO &c_in

	 WAIT "Am pregatit fisierul PTC "+STR(i,2) WINDOW nowait

	 z=load_excel(a,namesh,i)
endfor	 

CLOSE ALL
SELECT DATE() as now,* FROM ptc1 UNION (SELECT DATE() as now,* FROM ptc2) INTO CURSOR c_ptc ORDER BY id_pl 

COPY TO bdptc
