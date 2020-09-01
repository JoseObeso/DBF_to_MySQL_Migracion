PUBLIC gconecta, lcuser

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

****
TEXT TO lqry_proceso_0 noshow
 update bdcontratos.pgnein set fecha_vencimiento_formato = concat(substring(dfeccan,7,4), '-', substring(dfeccan,4,2), '-', substring(dfeccan,1,2)) where dfeccan LIKE '%/%'
ENDTEXT
lejecuta1 = sqlexec(gconecta,lqry_proceso_0)
?lejecuta1

TEXT TO lqry_proceso_00 noshow
  truncate table bdcontratos.tmp_mnein_comisionista  
ENDTEXT
lejecuta2 = sqlexec(gconecta,lqry_proceso_00)
?lejecuta2

  
  
TEXT TO lqry_proceso_1 noshow
   SELECT idcontrato, fecha_creacion_formato, ncuotas, cfecinicio, dfecfin, ncuota_a_pagar, denominacion, cnomper, cdessepul, nprecio1, 
   nfondo_mant_inicial, nfondo_mant_saldo,  cfono, cdir, czona, cdepar,  nsersepul, nmontototal,ndescuen,nsalaf, nmoninicio, cdni, cruc, correo_electronico
         FROM bdcontratos.v_mnein_comisionista
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_1, "tprocesar")
SELECT tprocesar
SCAN
  lc_idcontrato = ALLTRIM(tprocesar.idcontrato) 
  lc_fecha_creacion_formato = ALLTRIM(tprocesar.fecha_creacion_formato) 
  ln_ncuotas = tprocesar.ncuotas
  lc_cfecinicio = ALLTRIM(tprocesar.cfecinicio) 
  lc_dfecfin = ALLTRIM(tprocesar.dfecfin) 
  ln_ncuota_a_pagar = tprocesar.ncuota_a_pagar
  lc_comisionista = ALLTRIM(tprocesar.denominacion)
  lc_cnomper = ALLTRIM(tprocesar.cnomper)
  lc_cdessepul = ALLTRIM(tprocesar.cdessepul)
  ln_precio1 = tprocesar.nprecio1
  ln_nfondo_mant_inicial = tprocesar.nfondo_mant_inicial
  ln_nfondo_mant_saldo = tprocesar.nfondo_mant_saldo
  lc_cfono = ALLTRIM(tprocesar.cfono)
  lc_cdir = ALLTRIM(tprocesar.cdir)
  lc_czona = ALLTRIM(tprocesar.czona)
  lc_cdepar = ALLTRIM(tprocesar.cdepar)
  ln_nsersepul = tprocesar.nsersepul
  ln_nmontototal = tprocesar.nmontototal
  ln_ndescuen = tprocesar.ndescuen
  ln_nsalaf = tprocesar.nsalaf
  ln_nmoninicio = tprocesar.nmoninicio
  lc_cdni = ALLTRIM(tprocesar.cdni)
  lc_cruc = ALLTRIM(tprocesar.cruc)
  lc_correo_electronico = ALLTRIM(tprocesar.correo_electronico)

  TEXT TO lqry_proceso_debe noshow
       call bdcontratos.sp_get_data_pgnein(?lc_idcontrato, ?lc_fecha_fin_consulta)
  ENDTEXT
  lejecutagrabacion = sqlexec(gconecta,lqry_proceso_debe, "tresul")
  SELECT tresul
  ln_ncuotas_debe = tresul.ndebe
  ln_ncuotas_pago = tresul.npago
  ln_ninteres = tresul.ninteres
  ln_ntasa = tresul.ntasa
  lc_cplataforma = ALLTRIM(tresul.cplataforma)
  lc_cespacio = ALLTRIM(tresul.cespacio)

  TEXT TO lqry_proceso_2 noshow
   insert into bdcontratos.tmp_mnein_comisionista (idcontrato, fecha_creacion_formato, ncuotas, cfecinicio, dfecfin, ncuota_a_pagar, denominacion, cnomper, ndebe, npago, cdessepul, nprecio, nfondo, nfondo_saldo, cfono, cdir, czona, cdepar,nsersepul, nmontototal, ndescuen, nsalaf, nmoninicio, cdni, cruc, correo_electronico, ntasa, total_interes, plataforma,espacio)
       values (?lc_idcontrato, ?lc_fecha_creacion_formato, ?ln_ncuotas, ?lc_cfecinicio, ?lc_dfecfin, ?ln_ncuota_a_pagar, ?lc_comisionista, ?lc_cnomper, ?ln_ncuotas_debe, ?ln_ncuotas_pago, ?lc_cdessepul, ?ln_precio1, ?ln_nfondo_mant_inicial, ?ln_nfondo_mant_saldo, ?lc_cfono, ?lc_cdir, ?lc_czona, ?lc_cdepar, ?ln_nsersepul, ?ln_nmontototal, ?ln_ndescuen, ?ln_nsalaf, ?ln_nmoninicio, ?lc_cdni, ?lc_cruc, ?lc_correo_electronico, ?ln_ninteres, ?ln_ntasa, ?lc_cplataforma, ?lc_cespacio)
  ENDTEXT
  lejecutagrabacion = sqlexec(gconecta,lqry_proceso_2)
  cMensage = ' PROCESANDO CONTRATO : ' + lc_idcontrato + ' - UN MOMENTO POR FAVOR, ESTE PROCESO DE 2 A 3 HORAS ...INICIO : ' + lc_cfecinicio + ' FIN  : ' + lc_dfecfin 
  _Screen.Scalemode = 0
  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDSCAN


TEXT TO lqry_ver_ventas NOSHOW 
 SELECT   year(date(fecha_creacion_formato)) as anio, CASE WHEN SUBSTRING(idcontrato,12,1) = 'I' then 'INMEDIATA'       WHEN SUBSTRING(idcontrato,12,1) = 'F' then 'FUTURA' WHEN SUBSTRING(idcontrato,12,1) = 'C' then 'NICHO'       WHEN SUBSTRING(idcontrato,12,1) = 'R' then 'CREMACION' ELSE '' END AS necesidad,  case when estado = 'C' then 'CANCELADO' when estado = 'V' then 'VIGENTE' ELSE   'NO DEFINIDO' END AS ESTADO,    CONCAT(SUBSTRING(fecha_creacion_formato,9,2),'/',SUBSTRING(fecha_creacion_formato,6,2), '/', SUBSTRING(fecha_creacion_formato,1,4)) AS fecha_creacion_contrato,idcontrato,         cnomper AS titular, cdni, cruc, correo_electronico, cfono as telefono, cdir as direccion, czona as zona, cdepar as departamento, substr(cdessepul,1,250)   as producto, nprecio as precio,         nsersepul as servicio_sepultura, plataforma, espacio,  nmontototal as total,   ndescuen as descuento, nmoninicio as monto_inicial,ntasa,total_interes, nsalaf as saldo_financiar, cfecinicio, dfecfin,         ncuotas, ndebe, npago, ncuota_a_pagar, nfondo_saldo,  ndebe*ncuota_a_pagar as pago_deuda, denominacion             FROM bdcontratos.tmp_mnein_comisionista  order by date(fecha_creacion_formato) ;            
   
  ENDTEXT
  
lejecutabusca = sqlexec(gconecta,lqry_ver_ventas, "tver_ventas")
SELECT tver_ventas
ln_registros = RECCOUNT()
IF ln_registros > 0
  COPY TO d:\REPORTE_TODOS_LOS_CONTRATOS&lc_fecha_hora TYPE XLS
MESSAGEBOX("TABLA EXPORTADA DEBIDAMENTE A EXCEL ","UBIQUELO EN LA UNIDAD D: ")

 
ELSE
  cMensage = ' ... NO EXISTEN REGISTROS....  '
  _Screen.Scalemode = 0
  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

ENDIF
	
	
	
