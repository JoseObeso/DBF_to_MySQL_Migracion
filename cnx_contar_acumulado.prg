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

TEXT TO lqry_ver_montos noshow
	SELECT * FROM bdcontratos.tmp_cuotas_seleccion where idaleatorio = '0967'  
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_montos,"tver_mon")
SELECT tver_mon
COUNT TO ln_cuotas_total
GO top
SCAN
			  ln_idpgnein = tver_mon.idpgnein
			  lc_cuota = tver_mon.nro_cuotas
			  lc_fila = lc_cuota
			 * lc_fila = lc_fila + ',' + lc_fila
			  ?lc_fila
			
ENDSCAN
?ln_cuotas_total		
		
***  TEXT TO lqry_update_pg noshow
*!*				    update bdcontratos.pgnein set pgnein.dfecpag = ?lc_fecha_pago, ncappag = npagcap, nintpag = npagint, cestado = 'P' where idpgnein = ?ln_idpgnein
*!*				  ENDTEXT
*!*				  lejecutabusca = sqlexec(gconecta,lqry_update_pg)
*!*				  cMensage = '.. PROCESANDO PAGO .... ' + ALLTRIM(STR(ln_idpgnein))
*!*				  _Screen.Scalemode = 0
*!*				  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*				  			
			