** fechas
CLEAR
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON

lc_fecha_externa = DTOC(DATE())
lc_captura_de_fecha = SUBSTR(lc_fecha_externa,7,4) + '-' + SUBSTR(lc_fecha_externa,4,2) + '-' + SUBSTR(lc_fecha_externa,1,2) 

?lc_captura_de_fecha
