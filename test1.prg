
*SELECT cod_ecu,denumire,um0,CAST(getum(um0) as c 20) as den0,it0,r0,g0,um1,CAST(getum(um1) as c 20) as den1,it1,r1 FROM articole lEFT JOIN um_articole ON articole.cod_ecu=um_articole.id_articol
SELECT cod_ecu,denumire,um0,CAST(getum(um0) as c(20)) as den0,it0,r0,g0,um1,CAST(getum(um1) as c(20)) as den1,it1,r1,g1,;
um2,CAST(getum(um2) as c(20)) as den2,it2,r2,CAST(get_g(cod_ecu,um2,1) as n(10,2)) FROM articole lEFT JOIN um_articole ON articole.cod_ecu=um_articole.id_articol
