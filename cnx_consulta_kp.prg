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

*!*	lc_idcontrato = '0018-2005-NF'
*!*	TEXT TO lqry_ver_detalles_de_pagos noshow
*!*	  SELECT cconcep FROM bdcontratos.kpagos WHERE idcontrato=?lc_idcontrato AND CESTADO = 'A'  
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_detalles_de_pagos, "tver_contratos_detalle_pagos")
*!*	SELECT tver_contratos_detalle_pagos
*!*	GO top
*!*	SCAN
*!*	    lc_concepto = ALLTRIM(tver_contratos_detalle_pagos.cconcep)
*!*	     IF lc_concepto = 'PC'
*!*	        lc_mostrar = '1'
*!*	     ELSE
*!*	        lc_mostrar = '0'
*!*	     ENDIF
*!*	ENDSCAN

*!*	IF lc_mostrar = '0'
*!*	   TEXT TO lqry_ver_si_existe_cn noshow
*!*	     SELECT count(cconcep) as cp  FROM bdcontratos.kpagos WHERE idcontrato=?lc_idcontrato AND CESTADO = 'A' and cconcep='CN' group by cconcep 
*!*	   ENDTEXT
*!*	   lejecutabusca = sqlexec(gconecta,lqry_ver_si_existe_cn, "tver_cp")
*!*	   ln_ver_cp = VAL(tver_cp.cp)
*!*	   IF ln_ver_cp = 1
*!*	      ?'mostrando calendario'
*!*	   ELSE
*!*	      ?'NO - MOSTRAR'
*!*	   ENDIF
*!*	   
*!*	ELSE
*!*	   ?'NO - MOSTRAR'
*!*	ENDIF

