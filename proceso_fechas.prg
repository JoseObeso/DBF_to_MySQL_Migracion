** fechas
CLEAR
ln_anio_inicio = 2019
ln_mes_inicio = 6
ln_dia = 30

ld_fecha_inicio = DATE(ln_anio_inicio,ln_mes_inicio,1)
ld_fecha_final = GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1

ld_fecha_final_anio = YEAR(GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1)
ld_fecha_final_mes = month(GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1)
ld_fecha_final_dia = day(GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1)



ld_fecha = PADL(ALLTRIM(STR(ln_dia)),2,"0") + '/' + PADL(ALLTRIM(STR(ln_mes_inicio)),2,"0")+"/"+ ALLTRIM(STR(ln_anio_inicio))
ln_cuotas = 9
ld_fecha_calculada = dtoc(GOMONTH(CTOD(ld_fecha),ln_cuotas))




   
 lc_fecha_final = PADL(ALLTRIM(STR(31)),2,"0") + '/' + PADL(ALLTRIM(STR(7)),2,"0")+"/"+ ALLTRIM(STR(2019))
 ?lc_fecha_final
 ld_fecha_calculada = dtoc(GOMONTH(CTOD(lc_fecha_final),ln_cuotas))
?ld_fecha_calculada
 