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

*!*	*** PARA TABLA MNICHO  *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  TRUNCATE TABLE bdcontratos.msepuln;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	SET DEFAULT TO C:\APL\CTR\
*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\msepuln EXCLU
*!*	PACK

*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lidsepu = ALLTRIM(msepuln.idsepu)
*!*	lcdessepu = ALLTRIM(msepuln.cdessepu)
*!*	lnprecio = msepuln.nprecio

*!*	TEXT TO lqry_migrar_nicho NOSHOW 
*!*	   INSERT INTO bdcontratos.msepuln(idsepu,cdessepu,nprecio, usuario)
*!*	   VALUES(?lidsepu, ?lcdessepu, ?lnprecio, '32921099' )
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_nicho)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lcdessepu
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MSEPULN..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_calcular_precio_nichos_en_columnas()")
*!*	   


*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	cMensage = ' ... FIN DE MIGRACION TOTAL...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL
*!*	?' ... FIN DE MIGRACION TOTAL...  '
