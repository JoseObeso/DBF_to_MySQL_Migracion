** de dbf to MySQL

lcruta = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta

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
?gconecta
*!*	CLEAR
*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all 

*!*	*** PARA TABLA MESPACIOS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table bdcontratos.kpagos;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table  bdcontratos.kpagos_error;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	CLOSE DATABASES all
*!*	SELECT 1
*!*	USE c:\apl\ctr\kpagos EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN

*!*	lc_idcontrato = ALLTRIM(kpagos.idcontrato)
*!*	lc_dfecha = ALLTRIM(kpagos.dfecha)
*!*	ln_nmonto1 = kpagos.nmonto1
*!*	ln_nmorax = kpagos.nmorax
*!*	ln_ndescu = kpagos.ndescu
*!*	ln_nmontot = kpagos.nmontot
*!*	lc_cconcep = ALLTRIM(kpagos.cconcep)
*!*	lc_cestado = ALLTRIM(kpagos.cestado)
*!*	lc_ccodusu = ALLTRIM(kpagos.ccodusu)
*!*	lc_dfecmod = ALLTRIM(kpagos.dfecmod)
*!*	lc_dfecsys = ALLTRIM(kpagos.dfecsys)
*!*	lc_usuarioregistro = '32921099'

*!*	TEXT TO lqry_migrar_kpagos NOSHOW 
*!*	 call bdcontratos.sp_crud_kpagos(0, ?lc_idcontrato, ?lc_dfecha, ?ln_nmonto1, ?ln_nmorax, ?ln_ndescu, ?ln_nmontot, ?lc_cconcep, ?lc_cestado, ?lc_ccodusu, ?lc_dfecmod, ?lc_dfecsys, ?lc_usuarioregistro, 'MIG')
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_kpagos)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....KPAGOS : ....  ' + lc_idcontrato
*!*	    ?cMensage
*!*	  ELSE
*!*	     TEXT TO lqry_migrar_kpagos_error NOSHOW 
*!*	               INSERT INTO bdcontratos.kpagos_error(idcontrato)
*!*	              VALUES(?lc_idcontrato);
*!*	      ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_migrar_kpagos_error)
*!*	     
*!*	    cMensage = ' ... Error de Grabacion...KPAGOS :.  ' + lc_idcontrato
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA KPAGOS..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	   
*!*	 
*!*	 

*!*	? ' ... FIN DE MIGRACION PARA KPAGOS..  '
*!*	CLOSE DATABASES ALL

*!*	****************************************************************************

*!*	SET DEFAULT TO &lcruta

*!*	 
*!*	CLOSE DATABASES ALL

