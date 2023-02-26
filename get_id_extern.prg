FUNCTION get_id_extern
LPARAMETERS lid

ret=0


**lnRetVal = SQLEXEC(lcon,"Select * From mapare_articole where id_intern="+ALLTRIM(STR(lid)),"crsa")
SELECT * from tmp_map_art_1 WHERE id_intern=lid INTO CURSOR crsa
USE IN (SELECT("tmp_map_art_1"))
SELECT crsa


*SELECT id_extern FROM crsa INTO dbf cid
SELECT * FROM tmp_comanda_hbc WHERE cod_hbc in(SELECT id_extern FROM crsa) GROUP BY COD_HBC INTO CURSOR C1
USE IN (SELECT("tmp_comanda_hbc"))

*USE IN (SELECT("nda_hbc"))
SELECT C1
IF RECCOUNT()>0
	IF RECCOUNT()>1
	    
  	    
	 	
	 	SELECT COUNT(*) FROM c1 WHERE !ISNULL(DISPONIBIL) INTO ARRAY udis

	    
	    IF VARTYPE(udis)#"X" AND VARTYPE(udis)#"U" AND udis>0
	    	SELECT c1
	    	LOCATE FOR !ISNULL(disponibIL)
	    	    ret=cod_hbc
	    	    
	    ELSE
	    	
	    	SELECT MIN(item_COM) FROM c1 INTO ARRAY umin
	        SELECT C1
	    	
	    	LOCATE FOR item_COM=umin
	    	ret=cod_hbc
	    ENDIF  
	ELSE
		ret=cod_hbc
	endif

ELSE

	ret=0
endif
USE IN c1

RETURN ret