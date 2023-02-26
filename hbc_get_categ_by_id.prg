FUNCTION hbc_get_categ_by_id
LPARAMETERS pid,pcon


ret=0
ssql="select * from mapare_articole where id_extern="+ALLTRIM(STR(pid))+" and alive=1"

z=SQLEXEC(pcon,ssql,"ctmp")


SELECT ctmp


x1=null

IF !ISNULL(subcateg)
  x1=UPPER(subcateg)
endif  
x2=ALLTRIM(categ)


IF LEN(x2)>0
	ssql="select * from map_categ_hbc where GetParamMatch('"+ALLTRIM(LOWER(x1))+"',and_segm)=1 and alive=1 and grupa='"+x2+"'"
ELSE
	ssql="select * from map_categ_hbc where GetParamMatch('"+ALLTRIM(LOWER(x1))+"',and_segm)=1"
endif

z=SQLEXEC(pcon,ssql,"ctmp2")

IF z>0
	SELECT ctmp2
	ret=id
    USE IN ctmp2
ENDIF
USE IN ctmp
RETURN ret













FUNCTION match_expr
LPARAMETERS p1,p2

nc1=GETWORDCOUNT(p1," ")
nc2=GETWORDCOUNT(p2,";")
ret=0
FOR i=1 TO nc2
	IF AT(LOWER(GETWORDNUM(p2,i)),p1)#0
	   ret=ret+1
	endif   

endfor
RETURN ret

