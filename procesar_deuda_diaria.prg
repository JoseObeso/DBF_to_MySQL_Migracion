Archivo_ = FILE(".\bd.ini") 
N_Cadena = ALLTRIM(FILETOSTR(".\bd.ini")) 
x_Server = ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
x_UID =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
x_PWD =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
x_Change = CHRTRAN(N_Cadena,CHR(13),"*") 
x_DBaseName = Substr(x_Change,1,ATC("*",x_Change,1)-1) 
lcStringCnxLocal="Driver={MySQL ODBC 5.3 ANSI Driver}" +";Server="+x_Server+";Port=3306;+Database="+x_DBaseName+";Uid="+x_UID+";Pwd="+x_PWD  && Cadena de Conexión
Sqlsetprop(0,"DispLogin" , 3 ) 
SqlSetProp(0, 'QueryTimeOut',300) 
SQLSETPROP(0,"IdleTimeout",0)



lc_pc_user = SYS(0)

***
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON

 
lc_fecha_externa = DTOC(DATE())
lc_captura_de_fecha = SUBSTR(lc_fecha_externa,7,4) + '-' + SUBSTR(lc_fecha_externa,4,2) + '-' + SUBSTR(lc_fecha_externa,1,2) 

 

lnanio=VAL(SUBSTR(lc_captura_de_fecha,1,4))
lnmes=VAL(SUBSTR(lc_captura_de_fecha,6,2))
lndia=VAL(SUBSTR(lc_captura_de_fecha,9,2))

 
lctime = '19:00:00'
lcdia = ALLTRIM(STR(lndia))



lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))


lc_fecha_dia_mes_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_aaaa_mm_dd = ALLTRIM(STR(lnanio)) + '-' +  PADL(ALLTRIM(STR(lnmes)), 2, '0') + '-' + PADL(lcdia, 2, '0')

lc_fecha_impresion = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_hoy = DATE()
ln_mes_inicio = lnmes
ln_anio_inicio =  lnanio
ld_fecha_inicio = DATE(ln_anio_inicio,ln_mes_inicio,1)
lc_fecha_final_seleccion = GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,1)),1)-1
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


gconecta45=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_45 noshow
 update bdcontratos.pgnein set fecha_pago_formato = concat(substring(dfecpag,7,4), '-', substring(dfecpag,4,2), '-', substring(dfecpag,1,2)) where dfecpag like '%/%'
ENDTEXT
lejecutabusca45 = sqlexec(gconecta45,lqry_proceso_45)
IF lejecutabusca45 > 0
	cMensage = ' ... LIMPIANDO FECHA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE LIMPIEZA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta45)


 
gconecta46=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_46 noshow
    update bdcontratos.pgnein set fecha_pago_formato = concat(substring(dfecpag,1,4), '-', substring(dfecpag,6,2), '-', substring(dfecpag,9,2)) where dfecpag like '%.%'
ENDTEXT
lejecutabusca46 = sqlexec(gconecta46,lqry_proceso_46)
IF lejecutabusca46 > 0
	cMensage = ' ... LIMPIANDO FECHA pgnein..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE LIMPIEZA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta46)

gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_1 noshow
  update bdcontratos.pgnein set fecha_vencimiento_formato = concat(substring(dfeccan,1,4), '-', substring(dfeccan,6,2), '-', substring(dfeccan,9,2)) where dfeccan like '%.%'
ENDTEXT
lejecutabusca1 = sqlexec(gconecta,lqry_proceso_1)
IF lejecutabusca1 > 0
	cMensage = ' ... EJECUTADO FECHA DE VENCIMIENTO EXITOSA FORMATO ANTERIOR ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR FECHA DE VENCIMIENTO  FORMATO ANTERIOR..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta)



gconecta2=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_2 noshow
 update bdcontratos.pgnein set fecha_vencimiento_formato = concat(substring(dfeccan,7,4), '-', substring(dfeccan,4,2), '-', substring(dfeccan,1,2)) where dfeccan like '%/%'
ENDTEXT
lejecutabusca2 = sqlexec(gconecta2,lqry_proceso_2)
IF lejecutabusca2 > 0
	cMensage = ' ... EJECUTADO FECHA DE VENCIMIENTO EXITOSA NUEVO FORMATO ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR FECHA DE VENCIMIENTO NUEVO FORMATO..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta2)


gconecta22=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_22 noshow
   update bdcontratos.pgnein set fecha_pago_formato = '1900-01-01' where dfecpag = ''
ENDTEXT
lejecutabusca22 = sqlexec(gconecta22,lqry_proceso_22)
IF lejecutabusca22 > 0
	cMensage = ' ... LIMPIANDO FECHA..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE LIMPIEZA..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta22)

 
gconecta3=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_6 noshow
    update bdcontratos.pgnein  set dias_de_atraso = DATEDIFF(date(?lc_fecha_aaaa_mm_dd),date(fecha_vencimiento_formato)),  compensatorio_fecha_calculo = ?lc_fecha_aaaa_mm_dd
     where date(fecha_vencimiento_formato) <= DATE(?lc_fecha_aaaa_mm_dd); 
ENDTEXT
lejecutabusca = sqlexec(gconecta3,lqry_proceso_6)
SQLDISCONNECT(gconecta3)


 
 
 
 ***
gconecta33=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_33 noshow
   update bdcontratos.kpagos set dfecha_formato = concat(substring(dfecha,1,4), '-', substring(dfecha,6,2), '-', substring(dfecha,9,2))   where dfecha like '%.%'
ENDTEXT
lejecutabusca33 = sqlexec(gconecta33,lqry_proceso_33)
IF lejecutabusca33 > 0
	cMensage = ' ... LIMPIANDO FECHA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE LIMPIEZA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta33)


 
 ***
 

***
gconecta44=SQLSTRINGCONNECT(lcStringCnxLocal)
TEXT TO lqry_proceso_44 noshow
  update bdcontratos.kpagos set dfecha_formato = concat(substring(dfecha,7,4), '-', substring(dfecha,4,2), '-', substring(dfecha,1,2)) where dfecha like '%/%';
ENDTEXT
lejecutabusca44 = sqlexec(gconecta44,lqry_proceso_44)
IF lejecutabusca44 > 0
	cMensage = ' ... LIMPIANDO FECHA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE LIMPIEZA 2..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta44)





 




cMensage = ' ... INICIANDO PROCESO DE CALCULO DE CARTERA DE DEUDA PESADA / LIGERA  ..  '
_Screen.Scalemode = 0
WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

gconecta4=SQLSTRINGCONNECT(lcStringCnxLocal)
lejecutabusca4 = sqlexec(gconecta4,"CALL bdcontratos.sp_procesar_cartera_deudor_diaria(?lc_pc_user, ?lc_marcar_fin_de_mes, ?lc_marcar_fin_de_anio, ?lc_fecha_aaaa_mm_dd)")
IF lejecutabusca4 > 0
	cMensage = ' ... PROCESAMIENTO DE CARTERA EXITOSA  ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE CARTERA EXITOSA ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta4)

 
gconecta5=SQLSTRINGCONNECT(lcStringCnxLocal)
lejecutabusca5 = sqlexec(gconecta5,"call bdcontratos.sp_procesar_pagos_diarios(?lc_fecha_aaaa_mm_dd, ?lc_fecha_dia_mes_anio, ?lc_pc_user, ?lc_marcar_fin_de_mes, ?lc_marcar_fin_de_anio)")
IF lejecutabusca5 > 0
	cMensage = ' ... PROCESAMIENTO DE PAGOS DIARIOS   ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE PAGOS DIARIOS..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta5)
 
 
 
 ***
  
gconecta6=SQLSTRINGCONNECT(lcStringCnxLocal)
lejecutabusca6 = sqlexec(gconecta6,"call bdcontratos.sp_procesar_pagos_diarios_agrupar(?lc_fecha_aaaa_mm_dd)")
IF lejecutabusca6 > 0
	cMensage = ' ... PROCESAMIENTO DE PAGOS DIARIOS AGRUPAR  ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE PAGOS DIARIOS AGRUPAR..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta6)
 
 
 ***
 
 
 
 
gconecta7=SQLSTRINGCONNECT(lcStringCnxLocal)
lejecutabusca7 = sqlexec(gconecta7,"call bdcontratos.sp_pagos_clasificar_dias(?lc_fecha_aaaa_mm_dd, ?lc_marcar_fin_de_mes, ?lc_marcar_fin_de_anio)")
IF lejecutabusca7 > 0
	cMensage = ' ... PROCESAMIENTO CLASIFICACION..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE CLASIFICACION..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
SQLDISCONNECT(gconecta7)
 
 
gconecta8=SQLSTRINGCONNECT(lcStringCnxLocal) 
TEXT TO lqry_proceso_7 noshow
 update bdcontratos.pgnein set compensatorio_monto_interes = round(((pow(((1+compensatorio_tasa_interes/100)),1/360)-1)*100) * ndeuda,2), compensatorio_fecha_pc = now()
      where CESTADO = 'D' AND TIPO_PAGO = 'CN' AND DIAS_DE_ATRASO >0;
ENDTEXT
lejecutabusca7 = sqlexec(gconecta8,lqry_proceso_7)
SQLDISCONNECT(gconecta8) 

gconecta9=SQLSTRINGCONNECT(lcStringCnxLocal)  
TEXT TO lqry_proceso_8 noshow
 update bdcontratos.pgnein set npagototal_calculado = (case when npagcap = 0 then npagtot else npagcap end)  + compensatorio_monto_interes 
where CESTADO = 'D' AND TIPO_PAGO = 'CN' AND DIAS_DE_ATRASO >0; 
ENDTEXT
lejecutabusca = sqlexec(gconecta9,lqry_proceso_8)
SQLDISCONNECT(gconecta9) 
   
    
 




*!*	cMensage = ' ... PROCESOS CULMINADOS  ..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*		
*!*	 
*!*	 
