**
CLEAR
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

  
lnfechoy=DTOC(DATE())
lnanio=YEAR(DATE())
lnmes=MONTH(DATE())
lndia=DAY(DATE()) 
lcfecha = dtoc(DATE())
lctime =TIME()
lcdia = ALLTRIM(STR(lndia))
lc_fecha_mes_dia_anio = PADL(lcdia, 2, '0') + '/' + PADL(ALLTRIM(STR(lnmes)), 2, '0') + '/' + ALLTRIM(STR(lnanio))
lc_fecha_inicio_consulta = '2005-01-01'
lc_fecha_hora = '_' + SUBSTR(DTOC(DATE()),1,2)+'_'+SUBSTR(DTOC(DATE()),4,2) + '_'+SUBSTR(DTOC(DATE()),7,4) + '_' + SUBSTR(TIME(),1,2) + '_' + SUBSTR(TIME(),4,2)
lc_fecha_fin_consulta = ALLTRIM(STR(lnanio)) +  '-' + PADL(ALLTRIM(STR(lnmes)),2,"0")+"-" + PADL(ALLTRIM(STR(lndia)),2,"0")


* RUTAS
 
lcruta = ADDBS(FULLPATH(CURDIR()))
nnro = AT("FNT", lcruta)
IF nnro <> 0
    gcgraficos = substr(lcruta,1,nnro-1) + "GRA\"
    gc_ruta_exportar = substr(lcruta,1,nnro-1) + "EXPORTAR\"
ELSE
   gcgraficos = lcruta + "GRA\"
   gc_ruta_exportar = lcruta + "EXPORTAR\"
ENDIF



?gc_ruta_exportar

lc_ruta_nombre_archivo = gc_ruta_exportar + 'REPORTE_TODOS_LOS_CONTRATOS' + lc_fecha_hora

?lc_ruta_nombre_archivo

lc_ruta_nombre_archivo = gc_ruta_exportar + 'REPORTE_TODOS_LOS_CONTRATOS' + lc_fecha_hora
TEXT TO lqry_ver_ventas NOSHOW 
 SELECT   year(date(fecha_creacion_formato)) as anio, CASE WHEN SUBSTRING(idcontrato,12,1) = 'I' then 'INMEDIATA'       WHEN SUBSTRING(idcontrato,12,1) = 'F' then 'FUTURA' WHEN SUBSTRING(idcontrato,12,1) = 'C' then 'NICHO'       WHEN SUBSTRING(idcontrato,12,1) = 'R' then 'CREMACION' ELSE '' END AS necesidad,  case when estado = 'C' then 'CANCELADO' when estado = 'V' then 'VIGENTE' ELSE   'NO DEFINIDO' END AS ESTADO,    CONCAT(SUBSTRING(fecha_creacion_formato,9,2),'/',SUBSTRING(fecha_creacion_formato,6,2), '/', SUBSTRING(fecha_creacion_formato,1,4)) AS fecha_creacion_contrato,idcontrato,         cnomper AS titular, cdni, cruc, correo_electronico, cfono as telefono, cdir as direccion, czona as zona, cdepar as departamento, substr(cdessepul,1,250)   as producto, nprecio as precio,         nsersepul as servicio_sepultura, plataforma, espacio,  nmontototal as total,   ndescuen as descuento, nmoninicio as monto_inicial,ntasa,total_interes, nsalaf as saldo_financiar, cfecinicio, dfecfin,         ncuotas, ndebe, npago, ncuota_a_pagar, nfondo_saldo,  ndebe*ncuota_a_pagar as pago_deuda, denominacion             FROM bdcontratos.tmp_mnein_comisionista  order by date(fecha_creacion_formato) ;            
  ENDTEXT
  
lejecutabusca = sqlexec(gconecta,lqry_ver_ventas, "tver_ventas")
SELECT tver_ventas
ln_registros = RECCOUNT()
IF ln_registros > 0
  COPY TO &lc_ruta_nombre_archivo TYPE XLS
MESSAGEBOX("ARCHIVO EXCEL, LO ENCUENTRA EN : " + CHR(13) + '*********************' +CHR(13) + lc_ruta_nombre_archivo +  CHR(13) + '*********************'  + CHR(13)  + "---- SE LE RECOMIENDA, ABRIR EL ARCHIVO Y GRABARLO EN FORMATO EXCEL ACTUALIZADO Y ENVIARLO, POSTERIORMENTE..", "PROCESO FINALIZADO..." )

 
ELSE
  cMensage = ' ... NO EXISTEN REGISTROS....  '
  _Screen.Scalemode = 0
  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF

      