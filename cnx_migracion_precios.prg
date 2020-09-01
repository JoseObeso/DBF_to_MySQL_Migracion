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

*!*	*** PARA TABLA MCOMI *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	 truncate table bdcontratos.msepul;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)


*!*	SET DEFAULT TO C:\APL\CTR\
*!*	 


*!*	SELECT 1
*!*	USE c:\apl\ctr\msepul EXCLU
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN
*!*	lidsepu = ALLTRIM(msepul.idsepu)
*!*	lccla = ALLTRIM(msepul.ccla)
*!*	lctip = ALLTRIM(msepul.ctip)
*!*	lcdessepu = ALLTRIM(msepul.cdessepu)
*!*	lnprecio = msepul.nprecio
*!*	lnsersepul = msepul.nsersepul
*!*	lncuota = msepul.ncuota
*!*	lnsaldo  = msepul.nsaldo
*!*	lnfondo  = msepul.nfondo
*!*	lnfinan =  msepul.nfinan
*!*	ln3mes =  msepul.n3mes
*!*	ln6mes =  msepul.n6mes
*!*	ln9mes = msepul.n9mes
*!*	ln1ano =  msepul.n1ano
*!*	ln2ano = msepul.n2ano
*!*	ln3ano =  msepul.n3ano
*!*	ln4ano =  msepul.n4ano
*!*	ln5ano =  msepul.n5ano
*!*	ln6ano =  msepul.n6ano
*!*	ln7ano =  msepul.n7ano
*!*	lccodusu =  msepul.ccodusu
*!*	ldfecmod =  msepul.dfecmod
*!*	ldfecsys = msepul.dfecsys
*!*	lccondicion =  msepul.ccondicion
*!*	lcorden =  msepul.corden

*!*	TEXT TO lqry_migrar NOSHOW 
*!*	   INSERT INTO bdcontratos.msepul(idsepu,ccla,ctip,cdessepu,nprecio,nsersepul,ncuota,nsaldo,nfondo,nfinan,n3mes,n6mes,n9mes,n1ano,n2ano,n3ano,n4ano,n5ano,n6ano,n7ano,ccodusu,dfecmod,dfecsys,ccondicion,corden)
*!*	   VALUES(?lidsepu, ?lccla, ?lctip, ?lcdessepu, ?lnprecio, ?lnsersepul, ?lncuota, ?lnsaldo, ?lnfondo, ?lnfinan, ?ln3mes, ?ln6mes, ?ln9mes, ?ln1ano, ?ln2ano, ?ln3ano, ?ln4ano, ?ln5ano,?ln6ano, ?ln7ano, ?lccodusu, ?ldfecmod, ?ldfecsys, ?lccondicion, ?lcorden)
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lcdessepu
*!*	  ELSE
*!*	    cMensage = ' ... Error de Grabacion....  '
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	cMensage = ' ... FIN DE MIGRACION PARA MSEPUL..  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	cMensage = ' ... FIN DE MIGRACION TOTAL...  '
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	CLOSE DATABASES ALL
*!*	?' ... FIN DE MIGRACION TOTAL...  '
