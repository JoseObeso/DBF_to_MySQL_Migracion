** de dbf to MySQL
CLEAR
lcruta = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta




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
*!*	  truncate table  bdcontratos.mfalle
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	 
*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\mfalle EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN

*!*	lc_nregistro = ALLTRIM(mfalle.nregistro)
*!*	lc_idcontrato = ALLTRIM(mfalle.idcontrato)
*!*	lc_dfeccon = ALLTRIM(mfalle.dfeccon)
*!*	lc_ccodper = ALLTRIM(mfalle.ccodper)
*!*	lc_dfecnac = ALLTRIM(mfalle.dfecnac)
*!*	lc_dfecfa = ALLTRIM(mfalle.dfecfa)
*!*	lc_cnomape = ALLTRIM(mfalle.cnomape)
*!*	lc_ccplat = ALLTRIM(mfalle.ccplat)
*!*	lc_cubica = ALLTRIM(mfalle.cubica)
*!*	lc_csepul = ALLTRIM(mfalle.csepul)
*!*	lc_cnivel = ALLTRIM(mfalle.cnivel)
*!*	lc_cplan = ALLTRIM(mfalle.cplan)
*!*	lc_dfecent = ALLTRIM(mfalle.dfecent)
*!*	lc_choraen = ALLTRIM(mfalle.choraen)
*!*	lc_creli = ALLTRIM(mfalle.creli)
*!*	lc_cfune = ALLTRIM(mfalle.cfune)
*!*	lc_ccodusu = ALLTRIM(mfalle.ccodusu)
*!*	lc_dfecmod = ALLTRIM(mfalle.dfecmod)
*!*	lc_cfuner = ALLTRIM(mfalle.cfuner)
*!*	lc_crelig = ALLTRIM(mfalle.crelig)
*!*	lc_nroespacio  = ALLTRIM(mfalle.nroespacio )
*!*	lc_dfecsys = ALLTRIM(mfalle.dfecsys)
*!*	lcuser = '32921099'



*!*	TEXT TO lqry_migrar_mfalle NOSHOW    
*!*	 
*!*	 INSERT INTO bdcontratos.mfalle(nregistro,idcontrato, dfeccon,ccodper,dfecnac,dfecfa,cnomape, ccplat,cubica,csepul,cnivel,cplan,dfecent,choraen,creli,cfune, ccodusu,dfecmod,cfuner,crelig,nroespacio,dfecsys, usuarioregistro)
*!*	  VALUES(?lc_nregistro, ?lc_idcontrato, ?lc_dfeccon, ?lc_ccodper, ?lc_dfecnac, ?lc_dfecfa, ?lc_cnomape, ?lc_ccplat, ?lc_cubica, ?lc_csepul, ?lc_cnivel, ?lc_cplan, ?lc_dfecent, ?lc_choraen, ?lc_creli, ?lc_cfune, ?lc_ccodusu, ?lc_dfecmod, ?lc_cfuner, ?lc_crelig,?lc_nroespacio, ?lc_dfecsys, ?lcuser)

*!*	 
*!*	 
*!*	    
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mfalle)

*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_idcontrato
*!*	    ?cMensage
*!*	  ELSE
*!*	     cMensage = ' ... Error de Grabacion....  ' + lc_idcontrato
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MFALLE..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait


*!*	TEXT TO lqry_migrar_mfale_corregir NOSHOW 
*!*	  update bdcontratos.mfalle set idcontrato = '0009-2011-NI'  where  idcontrato = '009-2011-NI';
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mfale_corregir)

*!*	TEXT TO lqry_migrar_mfale_corregir_nregistro NOSHOW 
*!*	  update bdcontratos.mfalle set nregistro = concat(cast(idmfalle as char), '-', substr(dfecfa,1,4))
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mfale_corregir_nregistro)






*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	 
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
