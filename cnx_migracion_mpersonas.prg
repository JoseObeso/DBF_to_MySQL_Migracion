*!*	** de dbf to MySQL
*!*	lcruta = ADDBS(FULLPATH(CURDIR()))
*!*	SET DEFAULT TO &lcruta

*!*	CLEAR



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

*!*	*** PARA TABLA MPERSONAS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  TRUNCATE TABLE bdcontratos.mpersonas;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	TEXT TO lqry_migrar_truncar_2 NOSHOW 
*!*	  truncate table  bdcontratos.mpersonas_error
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar_2)

*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\mpersonas EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN

*!*	lc_ccodper = ALLTRIM(mpersonas.ccodper)
*!*	lc_ctipper = ALLTRIM(mpersonas.ctipper)
*!*	lc_cape = ALLTRIM(mpersonas.cape)
*!*	lc_cnom = ALLTRIM(mpersonas.cnom)
*!*	lc_cnomper = ALLTRIM(mpersonas.cnomper)
*!*	lc_cfecnaci = ALLTRIM(mpersonas.cfecnaci)
*!*	lc_csexo = ALLTRIM(mpersonas.csexo)
*!*	lc_cdni = ALLTRIM(mpersonas.cdni)
*!*	lc_cruc = ALLTRIM(mpersonas.cruc)
*!*	lc_cestciv = ALLTRIM(mpersonas.cestciv)
*!*	lc_cfono = ALLTRIM(mpersonas.cfono)
*!*	lc_cdir = ALLTRIM(mpersonas.cdir)
*!*	lc_czona = ALLTRIM(mpersonas.czona)
*!*	lc_cdistri = ALLTRIM(mpersonas.cdistri)
*!*	lc_cprovin = ALLTRIM(mpersonas.cprovin)
*!*	lc_cdepar = ALLTRIM(mpersonas.cdepar)
*!*	lc_dfecreg = ALLTRIM(mpersonas.dfecreg)
*!*	lc_dfecmod = ALLTRIM(mpersonas.dfecmod)
*!*	lc_cfalle = ALLTRIM(mpersonas.cfalle)
*!*	lc_ctitular = ALLTRIM(mpersonas.ctitular)
*!*	lc_dfecsys = ALLTRIM(mpersonas.dfecsys)
*!*	lc_usuarioregistro = '32921099'

*!*	TEXT TO lqry_migrar_mpersonas NOSHOW 
*!*	 call bdcontratos.sp_crud_mpersonas(0,?lc_ccodper, ?lc_ctipper, ?lc_cape, ?lc_cnom, ?lc_cnomper, ?lc_cfecnaci, ?lc_csexo, ?lc_cdni, ?lc_cruc, ?lc_cestciv, ?lc_cfono, ?lc_cdir, ?lc_czona, ?lc_cdistri, ?lc_cprovin, ?lc_cdepar, ?lc_dfecreg, ?lc_dfecmod, ?lc_cfalle, ?lc_ctitular, ?lc_dfecsys, ?lc_usuarioregistro, 'GRA');

*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mpersonas)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme.... MPERSONAS  ' + lc_cape 
*!*	  ELSE
*!*	     TEXT TO lqry_migrar_error NOSHOW 
*!*	            insert INTO bdcontratos.mpersonas_error(ccodper)
*!*	              values(?lc_ccodper)
*!*	     ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_migrar_error)
*!*	  
*!*	    cMensage = ' ... Error de Grabacion....  ' + lc_cape 
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	?cMensage
*!*	lejecutabusca = sqlexec(gconecta,"call bdcontratos.sp_crud_mpersonas(0, '', '', '', '', '', '', '', '', '', '', '','', '', '', '', '', '', '','', '', '', '', 'NAC')")

*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
