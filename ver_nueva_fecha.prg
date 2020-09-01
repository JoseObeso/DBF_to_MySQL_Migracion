CLEAR

lnanio=2020
lnmes=2
lndia=1

lcfecha = dtoc(DATE())
lctime =TIME()
lcdia = ALLTRIM(STR(lndia))
lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))

lc_fecha_aaaa_mm_dd = ALLTRIM(STR(lnanio)) + '-' +  PADL(ALLTRIM(STR(lnmes)), 2, '0') + '-' + PADL(lcdia, 2, '0')
?lc_fecha_aaaa_mm_dd
?VARTYPE(lc_fecha_aaaa_mm_dd)

lc_fecha_impresion = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_hoy = DATE()
?VARTYPE(lc_fecha_hoy)

ln_mes_inicio = lnmes
ln_anio_inicio =  lnanio
ld_fecha_inicio = DATE(ln_anio_inicio,ln_mes_inicio,1)
lc_fecha_final_seleccion = GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1
?lc_fecha_final_seleccion

lc_fecha_inicial = lc_fecha_final_seleccion
IF lc_fecha_hoy = lc_fecha_inicial 
   lc_marcar_fin_de_mes = 'F'
ELSE
   lc_marcar_fin_de_mes = ''
ENDIF

*** Ultimo dia del año
lc_fecha_fin_de_anio = DATE(lnanio,12,31)
IF lc_fecha_hoy = lc_fecha_fin_de_anio
   lc_marcar_fin_de_anio = 'A'
ELSE
   lc_marcar_fin_de_anio = ''
ENDIF