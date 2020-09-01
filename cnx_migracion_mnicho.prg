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
*!*	  truncate table bdcontratos.mnicho;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	 
*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\mnicho  EXCLUSIVE
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
*!*	lc_dfecmod = ALLTRIM(mnicho.dfecmod)
*!*	lc_dfecsys  = ALLTRIM(mnicho.dfecsys)
*!*	 


*!*	TEXT TO lqry_migrar_mnicho NOSHOW

*!*	INSERT INTO bdcontratos.mnicho(nnicho, ccodpab, cdespab, cletespaci, cnumesp, cusado, creser, clibre, dfecmod, dfecsys)
*!*	VALUES (?lc_nnicho, ?lc_ccodpab, ?lc_cdespab, ?lc_cletespaci, ?lc_cnumesp, ?lc_cusado, ?lc_creser, ?lc_clibre, ?lc_dfecmod, ?lc_dfecsys)

*!*	   
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mnicho)

*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_cdespab + ' -' + lc_cletespaci + ' - ' + lc_cnumesp  
*!*	    ?cMensage
*!*	  ELSE
*!*	     cMensage = ' ... Error de Grabacion....  ' + lc_cdespab  + ' -' + lc_cletespaci + ' - ' + lc_cnumesp  
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MNICHO	..  '
*!*	?cMensage
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	 
*!*	 

*!*	 TEXT TO lqry_update_mnicho NOSHOW

*!*	 update bdcontratos.mnichos a inner join bdcontratos.mnicho b on a.nnicho = b.nnicho set a.cusado = b.cusado, a.creser = b.creser;
*!*	   
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_mnicho)
*!*	cMensage = ' ...A C T U A L I Z A N D O   P A B E L L O N E S   O K'
*!*	?cMensage





*!*	TEXT TO lqry_update_mnicho_clibre NOSHOW
*!*	 UPDATE  bdcontratos.mnichos SET clibre = '1' where cusado = '1'
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_mnicho_clibre)
*!*	cMensage = ' ...A C T U A L I Z A N D O   E S P A C I O S'
*!*	?cMensage






*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	 
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
