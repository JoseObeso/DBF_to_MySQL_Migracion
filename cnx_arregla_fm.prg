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

      gcfecha_dia = SUBSTR(DTOC(DATE()),4,2)
      gcfecha_mes = SUBSTR(DTOC(DATE()),1,2)
      gcfecha_anio = SUBSTR(DTOC(DATE()),7,4)
      gcfecha = gcfecha_dia + '/' + gcfecha_mes + '/' + gcfecha_anio
      
      lcruta = ADDBS(FULLPATH(CURDIR()))
      nnro = AT("FNT", lcruta)
      IF nnro <> 0
         gcgraficos = substr(lcruta,1,nnro-1) + "GRA\"
      ELSE
         gcgraficos = lcruta + "GRA\"
      ENDIF
      gcruta = lcruta       
      gcsistema = "SICONTRATOS"
      gctitulo = "--- PROCESAMIENTO ----- "
      gndecimal = 0
      gcnombrepc_user_red = SYS(0)
 
      _screen.Caption = gcsistema + " : " + gctitulo +  "  [FECHA : " + gcfecha + "] "  
      _screen.picture=gcgraficos + "wfondo.jpg"
      _screen.icon=gcgraficos  + "ilpaz.ico"
      _Screen.AddProperty("lmostrar","")



gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
lcuser = '32921099'
lc_pc_user = SYS(0)

*!*	TEXT TO lqry_truncate_fm noshow
*!*	  truncate table bdcontratos.fondo_mantenimiento
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_truncate_fm)


*!*	TEXT TO lqry_ver_fm noshow
*!*	 SELECT * FROM bdcontratos.mnein  where nfondx > 0
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_fm,"t_mne")
*!*	SELECT t_mne
*!*	GO top
*!*	SCAN
*!*	  lc_idcontrato = ALLTRIM(t_mne.idcontrato)  
*!*	  lc_fechacontrato = ALLTRIM(t_mne.dfecpro)  
*!*	  ln_fm_total = t_mne.nfondo_mant_inicial  
*!*	  ln_fm_pago_inicial = t_mne.nfondo_mant_pagado  
*!*	  ln_nfondo_mant_saldo = t_mne.nfondo_mant_saldo   
*!*	  ln_fm_actualizado = t_mne.nfm_actualizado
*!*	  ln_fm_saldo_actual = t_mne.nfm_actualizado
*!*	  ln_fm_condicion = ALLTRIM(t_mne.cestado)
*!*	  lc_tipo_sistema = ALLTRIM(t_mne.tipo_sistema_informatico)
*!*	  TEXT TO lqry_ver_pgnein noshow
*!*	     SELECT dfeccan, ncuota, dfecpag  FROM bdcontratos.pgnein  where tipo_pago = 'FM' 
*!*	     and idcontrato = ?lc_idcontrato
*!*	  endtext
*!*	  lejecutabusca = sqlexec(gconecta,lqry_ver_pgnein,"t_pg")
*!*	  SELECT t_pg
*!*	  ln_pg = RECCOUNT()
*!*	  IF   ln_pg > 0
*!*	    lc_dfeccan = ALLTRIM(t_pg.dfeccan)
*!*	    lc_cuota = ALLTRIM(t_pg.ncuota)
*!*	    lc_dfecpag = ALLTRIM(t_pg.dfecpag)
*!*	  ELSE
*!*	    lc_dfeccan = ''
*!*	    lc_cuota = ''
*!*	    lc_dfecpag = ''
*!*	  ENDIF
*!*	  
*!*	  TEXT TO lqry_insert_fm noshow
*!*	    INSERT INTO bdcontratos.fondo_mantenimiento (idcontrato, fechacontrato, fm_cuota, fm_fecha_vencimiento, fm_total,
*!*	     fm_pago_inicial, fm_saldo_inicial, fm_actualizado, fm_saldo_actual, fm_condicion, fm_fecha_pago, usuarioregistro, 
*!*	     tipo_sistema_informatico, pc_user)
*!*	    value(?lc_idcontrato,?lc_fechacontrato, ?lc_cuota, ?lc_dfeccan, ?ln_fm_total, ?ln_fm_pago_inicial, ?ln_nfondo_mant_saldo,
*!*	    ?ln_fm_actualizado, ?ln_fm_saldo_actual, ?ln_fm_condicion, ?lc_dfecpag, '32921099', ?lc_tipo_sistema, ?lc_pc_user)
*!*	  ENDTEXT
*!*	  lejecutabusca = sqlexec(gconecta,lqry_insert_fm)
*!*	  lc_grabar = IIF(lejecutabusca>0, 'SERVIDOR : ' + x_Server + ' --GRABACION OK   -  ' + lc_idcontrato  , 'ERROR DE GRABACION EN -- ' + lc_idcontrato)
*!*	  WAIT Window lc_grabar  nowait

*!*	  
*!*	ENDSCAN
*!*	WAIT Window '--- PROCESO TERMINADO ---'  nowait

