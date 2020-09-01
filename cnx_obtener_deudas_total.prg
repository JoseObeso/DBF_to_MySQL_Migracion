* procesar deudas


*!*	Archivo_ = FILE(".\bd.ini") 
*!*	N_Cadena = ALLTRIM(FILETOSTR(".\bd.ini")) 
*!*	x_Server = ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
*!*	N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
*!*	x_UID =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
*!*	N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
*!*	x_PWD =    ALLTRIM(SUBSTR(N_Cadena,1,(ATC(CHR(13),N_Cadena,1) - 1))) 
*!*	N_Cadena = ALLTRIM(RIGHT(N_Cadena,LEN(N_Cadena) - ( ATC(CHR(13),N_Cadena,1) + 1 ))) 
*!*	x_Change = CHRTRAN(N_Cadena,CHR(13),"*") 
*!*	x_DBaseName = Substr(x_Change,1,ATC("*",x_Change,1)-1) 
*!*	lcStringCnxLocal="Driver={MySQL ODBC 5.3 ANSI Driver}" +";Server="+x_Server+";Port=3306;+Database="+x_DBaseName+";Uid="+x_UID+";Pwd="+x_PWD  && Cadena de Conexión
*!*	Sqlsetprop(0,"DispLogin" , 3 ) 
*!*	SQLSETPROP(0,"IdleTimeout",0)
*!*	gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
*!*	?gconecta

*!*	lc_fecha_inicio = '2019-09-01' 
*!*	lc_fecha_final = '2019-09-30'
*!*	*** obtener los contratos en deudas *
*!*	TEXT TO lqry_ver_truncate_contratos NOSHOW
*!*	  truncate table bdcontratos.tmp_contratos_deudas
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_truncate_contratos)
*!*	 
*!*	  
*!*	TEXT TO lqry_ver_contratos NOSHOW 
*!*	    select * from bdcontratos.v_pgnein where  cestado = 'D' and fecha_cancelacion between date(?lc_fecha_inicio) and date(?lc_fecha_final);
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_contratos, "tver_contratos")

*!*	SELECT tver_contratos
*!*	GO top
*!*	SCAN
*!*	 lc_contrato_cnt_deuda = ALLTRIM(tver_contratos.idcontrato)
*!*	 TEXT TO lqry_insertar noshow
*!*	       insert into bdcontratos.tmp_contratos_deudas (idcontrato, total_deuda, total_cuotas_deuda, capital_deudor, interes_deudor)
*!*	      select idcontrato, sum(npagtot) as total_deuda, count(ncuota) as total_cuotas, sum(npagcap) as capital_deudor, sum(npagint) as interes_deudor 
*!*	          from bdcontratos.v_pgnein where idcontrato = ?lc_contrato_cnt_deuda and cestado = 'D'     and   fecha_cancelacion <= date(?lc_fecha_final);
*!*	 ENDTEXT
*!*	 lejecutabusca = sqlexec(gconecta,lqry_insertar)
*!*	 cMensage = ' ... PROCESANDO CONTRATO :  ' + lc_contrato_cnt_deuda
*!*	 _Screen.Scalemode = 0
*!*	 WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

*!*	ENDSCAN

*!*	cMensage = '  ---- PREPARANDO CONTRATOS EN DEUDA A MOSTRAR  ----'
*!*	 _Screen.Scalemode = 0
*!*	 WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

*!*	TEXT TO lqry_mostrar_cnt noshow
*!*	    select a.idcontrato, a.total_deuda, a.total_cuotas_deuda, a.capital_deudor,a.interes_deudor, b.cnomper, b.cfono, b.cdir, b.cdistri,b.dfecpro, 
*!*	    b.ncuotas, b.nfondo_mant_saldo, b.nfondx, b.dfecfin, b.cfecinicio, b.cfecha_vencimiento_fm, b.cfecha_pago_fm, b.ncuota_a_pagar 
*!*	          from bdcontratos.tmp_contratos_deudas a left join bdcontratos.v_mnein b on a.idcontrato = b.idcontrato 
*!*	            order by substring(a.idcontrato,6,4)
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_mostrar_cnt, "tver_deudas")            