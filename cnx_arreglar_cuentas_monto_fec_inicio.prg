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


*!*	TEXT TO lry_ver_contratos  NOSHOW 
*!*	  SELECT idcontrato FROM bdcontratos.pgnein  group by idcontrato
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lry_ver_contratos, "ver_contrato")
*!*	SELECT ver_contrato
*!*	GO top
*!*	SCAN
*!*	   lc_idcontrato = ALLTRIM(ver_contrato.idcontrato)
*!*	   TEXT TO lqry_ver_fecha  NOSHOW 
*!*	      SELECT dfeccan, npagtot FROM bdcontratos.pgnein where idcontrato = ?lc_idcontrato limit 1;
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_ver_fecha, "ver_contrato_fecha")
*!*	   SELECT ver_contrato_fecha
*!*	   lc_dfeccan = ALLTRIM(ver_contrato_fecha.dfeccan)
*!*	   lnpagtot = ver_contrato_fecha.npagtot
*!*	   
*!*	   * final 
*!*	   TEXT TO lqry_ver_fecha_final  NOSHOW 
*!*	      SELECT dfeccan FROM bdcontratos.pgnein where idcontrato = ?lc_idcontrato order by idpgnein desc limit 1 
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_ver_fecha_final, "ver_contrato_fecha_final")
*!*	   SELECT ver_contrato_fecha_final
*!*	   lc_dfeccan_final = ALLTRIM(ver_contrato_fecha_final.dfeccan)
*!*	 
*!*	 
*!*	   TEXT TO lqry_update_menin noshow
*!*	     update  bdcontratos.mnein set cfecinicio = ?lc_dfeccan, dfecfin = ?lc_dfeccan_final, ncuota_a_pagar = ?lnpagtot where idcontrato = ?lc_idcontrato
*!*	   ENDTEXT
*!*	    lejecutabusca = sqlexec(gconecta,lqry_update_menin)
*!*	   
*!*	   
*!*	   cMensage = ' ...A C T U A L I Z A N D O  C O N T R A T O S .... ' + lc_idcontrato
*!*	   ?cMensage
*!*	   
*!*	    


*!*	ENDSCAN

*!*	 cMensage = ' ... FINAL ... '
*!*	 ?cMensage
*!*	   

