FUNCTION mk_comanda0
LPARAMETERS lbd

SET ENGINEBEHAVIOR 70


PUBLIC totret
totret=0

SELECT *,get_stoc_optim(iesiri) as stoc_opt FROM &lbd INTO CURSOR c0
USE IN (SELECT(lbd))

SELECT *,CAST((2*stoc_opt) as n(10)) as stoc_max,round_next_int(stoc_opt/2) as stoc_min FROM c0 INTO CURSOR c1
USE IN c0

SELECT *,CAST(IIF(stoc_opt-disponibil<0,0,stoc_opt-disponibil) as n(10)) as q_nec,;
CAST(IIF(stoc_opt-(disponibil-stoc_min)<0,(disponibil-stoc_min)-stoc_opt,0) as n(10)) as q_ret FROM c1 INTO dbf bd_stare0




SELECT *,SUM(disponibil) as tot_dispo,SUM(iesiri) as tot_ies,SUM(stoc_opt) as tot_st_opt,SUM(stoc_max) as tot_st_max,;
SUM(stoc_min) as tot_st_min,SUM(q_nec) as q_com_0,SUM(q_ret) as q_ret_0 FROM bd_stare0 GROUP BY id_ext INTO CURSOR c3
SELECT c3

SELECT *,RETUR_REALOC_0(id_ext,"C3","bd_stare0"),ArR(1) AS Ret,ArR(2) AS alo FROM C3 INTO CURSOR c4
 
SELECT c4
BROWSE TITLE "Comada dupa retur realoc 1"

SELECT *,CAST(q_com_0-alo as n(10)) as comanda_1 FROM c4 INTO dbf bd_stare1
CLOSE ALL
USE bd_stare1
BROWSE TITLE "final comanda"

