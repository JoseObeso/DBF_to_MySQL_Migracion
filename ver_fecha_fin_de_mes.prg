CLEAR
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON

lnfechoy=DTOC(DATE())
lnanio=YEAR(DATE())
lnmes=MONTH(DATE())
lxdia = DAY(DATE())
?lxdia
?DATE()


lndia=IIF(DAY(DATE())-1 = 0, DAY((GOMONTH(DATE(),-1)) - DAY(GOMONTH(DATE(),-1))), DAY(DATE())-1)
?lndia
lcfecha = dtoc(DATE())
lctime =TIME()
lcdia = ALLTRIM(STR(lndia))
lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_impresion = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
?lc_fecha_mes_dia_anio
lc_fecha_seleccion = ALLTRIM(STR(lnanio))  + '-' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '-' + PADL(lcdia, 2, '0')

?lc_fecha_seleccion


 