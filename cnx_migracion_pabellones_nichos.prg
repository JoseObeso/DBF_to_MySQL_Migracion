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

*!*	*** PARA TABLA MNICHOS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	   truncate table bdcontratos.mnichos
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)


*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all


*!*	SELECT 1
*!*	USE c:\apl\ctr\mnicho EXCLU
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lc_nnicho = ALLTRIM(mnicho.nnicho)
*!*	lc_ccodpab = ALLTRIM(mnicho.ccodpab)
*!*	lc_cdespab = ALLTRIM(mnicho.cdespab)
*!*	lc_cletespaci = ALLTRIM(mnicho.cletespaci)
*!*	lc_cnumesp = ALLTRIM(mnicho.cnumesp)
*!*	lc_cusado = ALLTRIM(mnicho.cusado)
*!*	lc_creser = ALLTRIM(mnicho.creser)
*!*	lc_clibre = ALLTRIM(mnicho.clibre)
*!*	lc_usuarioregistro = '32921099'

*!*	TEXT TO lqry_migrar_nicho NOSHOW 
*!*	   call bdcontratos.sp_crud_mnichos(?lc_nnicho, ?lc_ccodpab, ?lc_cdespab, ?lc_cletespaci, ?lc_cnumesp, ?lc_cusado, ?lc_creser, ?lc_clibre, ?lc_usuarioregistro,  'GRA');
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_nicho)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_cdespab
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA NICHOS..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait

*!*	   

*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	cMensage = ' ... FIN DE MIGRACION TOTAL...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL
*!*	?' ... FIN DE MIGRACION TOTAL...  '
