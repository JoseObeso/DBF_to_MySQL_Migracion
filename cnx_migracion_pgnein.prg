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
*!*	 

*!*	*** PARA TABLA MESPACIOS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table bdcontratos.pgnein;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table  bdcontratos.pgnein_error;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)


*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	 
*!*	SELECT 1
*!*	USE c:\apl\ctr\pgnein EXCLUSIVE
*!*	PACK

*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lc_idcontrato = ALLTRIM(pgnein.idcontrato)
*!*	lc_dfeccan  = ALLTRIM(pgnein.dfeccan)
*!*	lc_dfecpag  = ALLTRIM(pgnein.dfecpag)
*!*	ln_npagtot = pgnein.npagtot
*!*	lc_ncuota = ALLTRIM(pgnein.ncuota)
*!*	ln_ndeuda = pgnein.ndeuda
*!*	ln_npagcap = pgnein.npagcap
*!*	ln_npagint = pgnein.npagint
*!*	ln_ncappag = pgnein.ncappag
*!*	ln_nintpag = pgnein.nintpag
*!*	ln_ncapita = pgnein.ncapita
*!*	ln_nintmor = pgnein.nintmor
*!*	ln_nmorpag = pgnein.nmorpag
*!*	ln_nsaldox = pgnein.nsaldox
*!*	lc_cestado = ALLTRIM(pgnein.cestado)
*!*	lc_ccodusu = ALLTRIM(pgnein.ccodusu)
*!*	lc_dfecmod = ALLTRIM(pgnein.dfecmod)
*!*	ln_ncuota_pagada = pgnein.ncuota_pagada
*!*	ln_nsaldo_cuota = pgnein.nsaldo_cuota
*!*	ln_nnueva_cuota = pgnein.nnueva_cuota
*!*	lc_usuarioregistro = '32921099'

*!*	TEXT TO lqry_migrar_pgnein NOSHOW 
*!*	   
*!*	call bdcontratos.sp_crud_pgnein(0, ?lc_idcontrato, ?lc_dfeccan, ?lc_dfecpag, ?ln_npagtot, ?lc_ncuota, ?ln_ndeuda, ?ln_npagcap, ?ln_npagint, ?ln_ncappag, ?ln_nintpag, ?ln_ncapita, ?ln_nintmor,
*!*	?ln_nmorpag, ?ln_nsaldox, ?lc_cestado, ?lc_ccodusu, ?lc_dfecmod, ?ln_ncuota_pagada, ?ln_nsaldo_cuota, ?ln_nnueva_cuota, ?lc_usuarioregistro, 'MIG')
*!*	   
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_pgnein)

*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_idcontrato
*!*	    ?cMensage
*!*	  ELSE
*!*	     TEXT TO lqry_migrar_prnein_error NOSHOW 
*!*	              INSERT INTO bdcontratos.pgnein_error(idcontrato)
*!*	              VALUES(?lc_idcontrato);
*!*	     ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_migrar_prnein_error)
*!*	    cMensage = ' ... Error de Grabacion....  ' + lc_idcontrato
*!*	    
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA PGNEIN..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	   


*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
