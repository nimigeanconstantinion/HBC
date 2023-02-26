FUNCTION method_cmd0
LPARAMETERS xcon


ssql="select * from temp_ptc"

x=SQLEXEC(xcon,ssql,"crs_ptc")

SELECT crs_ptc
BROWSE



=mk_comanda0("crs_ptc")