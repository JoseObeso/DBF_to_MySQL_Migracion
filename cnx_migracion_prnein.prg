*!*	** de dbf to MySQL
*!*	CLEAR
*!*	lcruta = ADDBS(FULLPATH(CURDIR()))
*!*	SET DEFAULT TO &lcruta


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
*!*	  truncate table bdcontratos.prnein;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table  bdcontratos.prnein_error;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all
*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\prnein EXCLU
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lc_ccodper = ALLTRIM(prnein.ccodper)
*!*	lc_idcontrato = ALLTRIM(prnein.idcontrato)
*!*	lc_ctipasig = ALLTRIM(prnein.ctipasig)
*!*	lc_cparen = ALLTRIM(prnein.cparen)
*!*	lc_cestado = ALLTRIM(prnein.cestado)
*!*	lc_ccodusu = ALLTRIM(prnein.ccodusu)
*!*	lc_dfecmod = ALLTRIM(prnein.dfecmod)
*!*	lc_cfalle = ALLTRIM(prnein.cfalle)
*!*	ln_namplia = prnein.namplia
*!*	lc_idconampli = ALLTRIM(prnein.idconampli)
*!*	lc_usuarioregistro = '32921099'


*!*	TEXT TO lqry_migrar_prnein NOSHOW 
*!*	   call bdcontratos.sp_crud_prnein(0, ?lc_ccodper, ?lc_idcontrato, ?lc_ctipasig,?lc_cparen, ?lc_cestado, ?lc_ccodusu, ?lc_dfecmod, ?lc_cfalle,?ln_namplia, ?lc_idconampli, ?lc_usuarioregistro, 'GRA');
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_prnein)

*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_ccodper
*!*	    ?cMensage
*!*	  ELSE
*!*	     TEXT TO lqry_migrar_prnein_error NOSHOW 
*!*	              INSERT INTO bdcontratos.prnein_error(ccodper)
*!*	              VALUES(?lc_ccodper);
*!*	     ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_migrar_prnein_error)
*!*	    cMensage = ' ... Error de Grabacion....  ' + lc_ccodper
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	*cMensage = ' ... FIN DE MIGRACION PARA PRNEIN..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	   


*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	 
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
