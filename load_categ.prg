FUNCTION load_categ
LPARAMETERS pexcel

Use tmp_categ In 0 Exclusive Alias u
Select u
Zap
Use In u


OB1=pEXCEL.ACTIVEWORKBOOK
NRS=OB1.Sheets.Count
Wait NRS Wind
For I=1 To NRS

	If At("mapare prod",Lower(OB1.Sheets(I).Name))#0
		Exit
	Endif

Endfor
pEXCEL.Visible=.T.
OB1.Sheets(I).Visible=.T.
OB1.Sheets(I).Select

r=3
For I=0 To 700
	Store 0 To m.id_extern
	Store Space(254) To m.articol,m.grupa,m.segment
	If !Isnull(.cells(r+I,2).Value) And !Isblank(.cells(r+I,2).Value) And Vartype(.cells(r+I,2).Value)#"X"
*!*			?"tip cel 1="
*!*			??Vartype(.cells(r+I,2).Value)
*!*			??"   "
*!*			??.cells(r+I,2).Value
*!*			?"tip cel 2="
*!*			??Vartype(.cells(r+I,3).Value)
*!*			?"tip cel 3="
*!*			??Vartype(.cells(r+I,3).Value)
*!*			?"tip cel 4"
*!*			??Vartype(.cells(r+I,4).Value)

		m.id_extern=Int(Val(.cells(r+I,2).Text))
		m.articol=.cells(r+I,3).Value
		If Isnull(.cells(r+I,4).Value) Or Isblank(.cells(r+I,4).Value)
			m.grupa=""
		Else

			m.grupa=.cells(r+I,4).Value
		Endif
		m.segment=.cells(r+I,5).Value

		Insert Into tmp_categ From Memvar
	Else
		Exit
	Endif


Endfor

Close All
Return