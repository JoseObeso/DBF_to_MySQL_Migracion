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

*!*	TEXT TO lqry_seleccion noshow
*!*	  SELECT idcontrato, ncuotas FROM bdcontratos.mnein  WHERE NCUOTAS <> 0 order by substring(IDCONTRATO,6,4)
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_seleccion, "t_con")

*!*	SELECT t_con
*!*	GO top
*!*	SCAN
*!*	   lc_idcon = ALLTRIM(t_con.idcontrato)
*!*	   ln_cuo =  t_con.ncuotas 
*!*	   TEXT TO lqry_actualiza noshow
*!*	     UPDATE  bdcontratos.pgnein  SET tipo_pago = 'CN' WHERE IDCONTRATO = ?lc_idcon AND CAST(ncuota AS UNSIGNED) BETWEEN 1 AND ?ln_cuo
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_actualiza)
*!*	   
*!*	    TEXT TO lqry_actualiza2 noshow
*!*	     UPDATE  bdcontratos.pgnein  SET tipo_pago = 'FM' WHERE IDCONTRATO = ?lc_idcon AND CAST(ncuota AS UNSIGNED) = ?ln_cuo + 1
*!*	     
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_actualiza2)
*!*	   msj = '--- PROCESANDO CONTRATO ' + lc_idcon
*!*	   ?msj
*!*	ENDSCAN

*!*	   msj = '----  FIN DE PROCESO --- '
*!*	   ?msj




