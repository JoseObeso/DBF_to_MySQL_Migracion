PUBLIC gconecta, lcuser

CLEAR
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
lcuser = '32921099'
CLEAR

*!*	TEXT TO lqry_00 noshow
*!*	 truncate table bdcontratos.tmp_tabla_cta_eliminar
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_00)
*!*	*  SELECT * FROM bdcontratos.mnein where cestado = 'V' AND namplia = 0
*!*	TEXT TO lqry_01 noshow
*!*	  SELECT * FROM bdcontratos.mnein
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_01, "tver_01")
*!*	SELECT tver_01
*!*	GO top
*!*	SCAN
*!*	   lc_idcontrato = ALLTRIM(tver_01.idcontrato)
*!*	   ln_cuotas = tver_01.ncuotas
*!*	   TEXT TO lqry_02 noshow
*!*	     select * from bdcontratos.pgnein where idcontrato = ?lc_idcontrato
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_02, "tver_02")
*!*	   ln_registro = RECCOUNT()
*!*	   IF ln_registro > 0
*!*	       TEXT TO lqry_03 noshow
*!*	         update bdcontratos.mnein set tiene_cronograma = 'S' where idcontrato = ?lc_idcontrato
*!*	       ENDTEXT
*!*	       lc_tiene_cronograma = 'SI TIENE CRONOGRAMA'
*!*	   ELSE
*!*	       TEXT TO lqry_03 noshow
*!*	         update bdcontratos.mnein set tiene_cronograma = 'N' where idcontrato = ?lc_idcontrato
*!*	       ENDTEXT
*!*	      lc_tiene_cronograma = 'NO TIENE CRONOGRAMA'
*!*	   ENDIF
*!*	   lejecutabusca = sqlexec(gconecta,lqry_03)
*!*	   ?'REVISANDO CONTRATO ' + lc_idcontrato  + ' -- ' + lc_tiene_cronograma + ' -- CUOTAS : ' + ALLTRIM(STR(ln_cuotas))
*!*	ENDSCAN
*!*	   ?' --- FIN DE REVISION DE CRONOGRAMAS'
