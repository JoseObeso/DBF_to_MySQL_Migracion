** fechas
CLEAR
lc_tipo_sistema_informatico = ' '
lc_fecha = '2007.08.23'
IF lc_tipo_sistema_informatico <> 'MSQ'
   lc_fecha_anio = substr(lc_fecha, 1,4)
   lc_fecha_mes = substr(lc_fecha, 6,2)
   lc_fecha_dia = substr(lc_fecha, 9,2)
ELSE
   lc_fecha_anio = substr(lc_fecha, 7,4)
   lc_fecha_mes = substr(lc_fecha, 4,2)
   lc_fecha_dia = substr(lc_fecha, 1,2)
ENDIF
DO CASE lc_fecha_mes
   CASE lc_fecha_mes = '01'
        lc_mes_descripcion = 'ENERO'
   CASE lc_fecha_mes = '02'
        lc_mes_descripcion = 'FEBRERO'
   CASE lc_fecha_mes = '03'
        lc_mes_descripcion = 'MARZO'
   CASE lc_fecha_mes = '04'
        lc_mes_descripcion = 'ABRIL'
   CASE lc_fecha_mes = '05'
        lc_mes_descripcion = 'MAYO'
   CASE lc_fecha_mes = '06'
        lc_mes_descripcion = 'JUNIO'
   CASE lc_fecha_mes = '07'
        lc_mes_descripcion = 'JULIO'
   CASE lc_fecha_mes = '08'
        lc_mes_descripcion = 'AGOSTO'
   CASE lc_fecha_mes = '09'
        lc_mes_descripcion = 'SEPTIEMBRE'
   CASE lc_fecha_mes = '10'
        lc_mes_descripcion = 'OCTUBRE'
   CASE lc_fecha_mes = '11'
        lc_mes_descripcion = 'NOVIEMBRE'
   CASE lc_fecha_mes = '12'
        lc_mes_descripcion = 'DICIEMBRE'
ENDCASE
lc_fecha_final = lc_fecha_dia + ' DE ' + lc_mes_descripcion + ' DEL ' + lc_fecha_anio


