CLOSE ALL

c1=SYS(5)+CURDIR()
cp1=chr(34)+c1+CHR(34)
a=GETFILE("xls?","Alegeti formularul")

SET DEFAULT TO &cp1

=export_comanda_hbc(a)
