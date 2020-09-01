** de dbf to MySQL



lcruta_inicial = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta_inicial

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
lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_limpiar_tablas_para_migrar()")
lejecutabusca = sqlexec(gconecta,"CALL bdcontratos.sp_migracion_plataforma()")

 CLEAR
SET DEFAULT TO C:\APL\CTR\

*** PARA TABLA MCOMI *
*!*	SELECT 1
*!*	USE c:\apl\ctr\mcomi EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_idcomi = mcomi.idcomi
*!*	  lc_denominacion = ALLTRIM(UPPER(mcomi.cnom))
*!*	  lc_direccion = ALLTRIM(UPPER(mcomi.cdir))
*!*	  lc_telefono = mcomi.cfono
*!*	  lcuser = '32921099'
*!*	  *lejecutabusca  = 6
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_comisionista(0, ?lc_denominacion, ?lc_direccion, ?lc_telefono, '', ?lcuser, '','MIG')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_denominacion
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MCOMI...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL

*!*	** PARA TABLA MRELI
*!*	SELECT 1
*!*	USE c:\apl\ctr\mreli EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_descripcion = ALLTRIM(UPPER(mreli.cdesreli))
*!*	  lcuser = '32921099'
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_religion('',?lc_descripcion, '', ?lcuser, '', 'GRA')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' +  lc_descripcion
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MRELI...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL

*!*	** PARA TABLA FUNERARIAS
*!*	SELECT 1
*!*	USE c:\apl\ctr\mfune EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_descripcion = ALLTRIM(UPPER(mfune.cdesfun))
*!*	  lc_repre = ALLTRIM(UPPER(mfune.crepre))
*!*	  lc_tele = ALLTRIM(mfune.ctele)
*!*	  lc_ciudad = ALLTRIM(UPPER(mfune.cciudad))
*!*	  lcuser = '32921099'
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_funeraria('',?lc_descripcion,?lc_repre, ?lc_tele, ?lc_ciudad,  '', ?lcuser, '', 'GRA')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' +  lc_descripcion
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MFUNE...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL

*!*	*** PARA PRECIOS SERVICIOS
*!*	SELECT 1
*!*	USE c:\apl\ctr\mservi EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_idservi = ALLTRIM(mservi.idservi)
*!*	  lc_cdesser = ALLTRIM(UPPER(mservi.cdesser))
*!*	  ln_precio = mservi.ncostoser
*!*	  lcuser = '32921099'
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_precioserviciosd(0, 1,?lc_cdesser, ?ln_precio, '', ?lc_idservi,?lcuser, '', 'GRA')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' +  lc_cdesser
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MSERVI...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL

*!*	*** ESTADO CIVIL
*!*	SELECT 1
*!*	USE c:\apl\ctr\tcivil EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_idcivil = ALLTRIM(tcivil.idcivil)
*!*	  lc_cdes = ALLTRIM(UPPER(tcivil.cdes))
*!*	  lcuser = '32921099'
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_estado_civil('',?lc_cdes,?lcuser,'GRA')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' +  lc_cdesser
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA ESTADO CIVIL...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL


*!*	*** PARENTESCO
*!*	SELECT 1
*!*	USE c:\apl\ctr\tparen EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	  lc_idparen = ALLTRIM(tparen.idparen)
*!*	  lc_cdesparen = ALLTRIM(UPPER(tparen.cparen))
*!*	  lcuser = '32921099'
*!*	  lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_parentesco('',?lc_cdesparen, ?lcuser, '', 'GRA')")
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' +  lc_cdesparen
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA PARENTESCO...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL


*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta_inicial
*!*	cMensage = ' ... FIN DE MIGRACION TOTAL...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL
