CLOSE ALL
CLEAR
SELECT *,test_score_product(cod_hbc,"bd_stare1"),CAST(ar(1) as n(10,6)) as c1,CAST(ar(2)  as n(10,6)) as c2,CAST(ar(3)  as n(10,6)) as c3,CAST(ar(4)  as n(10,6));
 as c4 FROM bd_stare1 INTO CURSOR crsf
 

 SELECT *,CAST(((c1-(sele MIN(c1) FROM crsf))*100/(SELECT MAX(c1)-Min(c1) FROM crsf))*.2+;
 ((c2-(sele MIN(c2) FROM crsf))*100/(SELECT MAX(c2)-Min(c2) FROM crsf))*.5+;
 IIF(c3>0,((c3-(sele MIN(c3) FROM crsf))*100/(SELECT MAX(c3)-Min(c3) FROM crsf)),0)*.2+;
 IIF(c4>0,((c4-(sele MIN(c4) FROM crsf))*100/(SELECT MAX(c4)-Min(c4) FROM crsf)),0)*.1 as n(10,4)) as rnk FROM crsf 

