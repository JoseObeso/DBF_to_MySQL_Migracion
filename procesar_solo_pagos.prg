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
SQLSETPROP(0,"IdleTimeout",0)
gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
lc_pc_user = SYS(0)

***
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON
lnfechoy=DTOC(DATE())

lnanio=2020
lnmes=2
lndia=4

 


lcfecha = dtoc(DATE())
lctime =TIME()
lcdia = ALLTRIM(STR(lndia))
lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))

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



cMensage = ' ... PROCESANDO PAGOS DIARIOS  ..  '
_Screen.Scalemode = 0
WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait


lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_procesar_pagos_diarios(?lc_fecha_aaaa_mm_dd, ?lc_fecha_mes_dia_anio, ?lc_pc_user, ?lc_marcar_fin_de_mes, ?lc_marcar_fin_de_anio)")
IF lejecutabusca > 0
	cMensage = ' ... PROCESAMIENTO DE PAGOS DIARIOS   ..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE PAGOS DIARIOS..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF


cMensage = ' ... AGRUPANDO PAGOS   ..  '
_Screen.Scalemode = 0
WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait


lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_procesar_pagos_diarios_agrupar(?lc_fecha_aaaa_mm_dd)")
IF lejecutabusca > 0
	cMensage = ' ... PROCESAMIENTO DE PAGOS DIARIOS   AGRUPANDO..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE PAGOS DIARIOS..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF


** Ejecutando la clasificacion 

cMensage = ' ... CLASIFICANDO DIAS    ..  '
_Screen.Scalemode = 0
WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait


lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_pagos_clasificar_dias(?lc_fecha_aaaa_mm_dd, ?lc_marcar_fin_de_mes, ?lc_marcar_fin_de_anio)")
IF lejecutabusca > 0
	cMensage = ' ... PROCESAMIENTO CLASIFICACION..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ELSE
 	cMensage = ' ...ERROR DE CLASIFICACION..  '
	_Screen.Scalemode = 0
	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF



cMensage = ' ... PROCESOS CULMINADOS  ..  '
_Screen.Scalemode = 0
WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
	
 
 
