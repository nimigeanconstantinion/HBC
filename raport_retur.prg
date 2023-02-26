FUNCTION raport_retur


SELECT depozit FROM bd_stare0 WHERE !id_pl=1 group BY depozit INTO CURSOR cdep


SELECT cdep
DO WHILE NOT EOF()
	x=depozit
	SELECT * FROM bd_stare0 WHERE depozit=x AND retur#0 INTO CURSOR crs
	SELECT crs
	fn=CHR(34)+"Retururi pentru "+ALLTRIM(depozit)+" generat la "+CHRTRAN(DTOC(DATE()),"/","")+CHR(34)
	?fn
	wait
	COPY TO &fn xl5
	SELECT cdep
	skip
enddo
return