** de dbf to MySQL
CLEAR

*!*	lcruta_inicial = ADDBS(FULLPATH(CURDIR()))
*!*	SET DEFAULT TO &lcruta_inicial


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
*!*	 

*!*	*** PARA TABLA MESPACIOS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table bdcontratos.mespacios;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	SELECT 1
*!*	USE c:\apl\ctr\mespacio  EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lc_nrespacio = ALLTRIM(mespacio.nrespacio)
*!*	lc_ccodplat = ALLTRIM(mespacio.ccodplat)
*!*	lc_cletespaci = ALLTRIM(mespacio.cletespaci)
*!*	lc_cnumesp = ALLTRIM(mespacio.cnumesp)
*!*	lc_cocupado = ALLTRIM(mespacio.cocupado)
*!*	ln_ncantini = mespacio.ncantni
*!*	ln_nusado = mespacio.nusado
*!*	ln_ncantre = mespacio.ncantre
*!*	ln_ncantdi = mespacio.ncantdi
*!*	lc_cposnib = mespacio.cposnib
*!*	lc_cposnm = ALLTRIM(mespacio.cposnm)
*!*	lc_cpona = ALLTRIM(mespacio.cpona)
*!*	lc_cnivel4 = ALLTRIM(mespacio.cnivel4)
*!*	lc_cgratis = ALLTRIM(mespacio.cgratis)
*!*	lcuser = '32921099'

*!*	TEXT TO lqry_migrar_espacios NOSHOW 
*!*	   INSERT INTO bdcontratos.mespacios(nrespacio,ccodplat,cletespaci,cnumesp,cocupado,ncantini,nusado,ncantre,ncantdi,cposnib,cposnm,cpona,cnivel4,cgratis,cestado,usuarioregistro)
*!*	 VALUES(?lc_nrespacio, ?lc_ccodplat, ?lc_cletespaci, ?lc_cnumesp, ?lc_cocupado, ?ln_ncantini, ?ln_nusado, ?ln_ncantre, ?ln_ncantdi, ?lc_cposnib,?lc_cposnm, ?lc_cpona, ?lc_cnivel4, ?lc_cgratis, 'A', ?lcuser)
*!*	 
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_espacios)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_nrespacio
*!*	    ?cMensage
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  ' + lc_nrespacio
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

*!*	ENDSCAN

*!*	  
*!*	cMensage = ' ... FIN DE MIGRACION PARA Mespacio..  '
*!*	?cMensage = ' ... FIN DE MIGRACION PARA Mespacio..  '

*!*	TEXT TO lqry_update_disponible NOSHOW 
*!*	  update bdcontratos.mespacios set ncantdi = ncantini - (nusado + ncantre) 
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_disponible)

*!*	 IF lejecutabusca > 0
*!*	    cMensage = ' ... actualizando disponibles conformes....  '  
*!*	    ?cMensage
*!*	  ELSE
*!*	    cMensage = ' ... Error de actualizacion....  '  
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

*!*	TEXT TO lqry_update_disponible_di NOSHOW 
*!*	  update bdcontratos.mespacios set cocupado = case when ncantdi = 0 then '1' else '0' end;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_disponible_di)


*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta_inicial
*!*	CLOSE DATABASES ALL
*!*	?' ... FIN DE MIGRACION TOTAL...  '
