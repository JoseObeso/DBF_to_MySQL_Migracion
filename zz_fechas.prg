CLEAR
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON

lnfechoy=DTOC(DATE())
lnanio=YEAR(DATE())
lnmes=MONTH(DATE())
lndia= DAY(DATE())

 

lcfecha = dtoc(DATE())
 
lctime =TIME()
lcdia = ALLTRIM(STR(lndia))
lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_impresion = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
 
lc_fecha_seleccion = ALLTRIM(STR(lnanio))  + '-' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '-' + PADL(lcdia, 2, '0')

 ?lc_fecha_seleccion
 
ldFecha = DATE()
 

**--Extraemos el Anno
ldAnno = YEAR(ldFecha)
 


**--Extraemos en Mes
ldMes = MONTH(ldFecha)

**--Extraemos el dia
ldDia = DAY(ldFecha)

**--Restamos el numero entero de dias a la fecha
ldFecFinal = DATE(ldAnno, ldMes, ldDia) - 1

?ldFecFinal
 