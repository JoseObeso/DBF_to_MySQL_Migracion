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

*!*	*** PARA TABLA TZONAS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table bdcontratos.tzona;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	 
*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\tzonas EXCLU
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lc_czona = ALLTRIM(tzonas.czona) 
*!*	lc_usuarioregistro = '32921099'



*!*	TEXT TO lqry_migrar_tzona NOSHOW    
*!*	   INSERT INTO bdcontratos.tzonas(czona, usuarioregistro)
*!*	      VALUES(?lc_czona, ?lc_usuarioregistro)
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_tzona)

*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme TZONA...  ' + lc_czona
*!*	    ?cMensage
*!*	  ELSE
*!*	     cMensage = ' ... Error de Grabacion....  ' + lc_czona
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA TZONA..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	   


*!*	TEXT TO lqry_clear_tzona NOSHOW    
*!*	 truncate table bdcontratos.tzonas_backup;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_clear_tzona)

*!*	TEXT TO lqry_clear_tzona1 NOSHOW    
*!*	 insert into bdcontratos.tzonas_backup (czona)
*!*	 SELECT CZONA  FROM bdcontratos.tzonas GROUP BY CZONA ORDER BY CZONA;

*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_clear_tzona1)


*!*	TEXT TO lqry_clear_tzona2 NOSHOW    
*!*	 truncate table bdcontratos.tzonas;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_clear_tzona2)


*!*	TEXT TO lqry_clear_tzona3 NOSHOW    
*!*	 insert into bdcontratos.tzonas(czona)
*!*	 select * from bdcontratos.tzonas_backup;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_clear_tzona3)

*!*	TEXT TO lqry_clear_tzona5 NOSHOW    
*!*	 update bdcontratos.tzonas set usuarioregistro = '32921099';
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_clear_tzona5)









*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	 
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
