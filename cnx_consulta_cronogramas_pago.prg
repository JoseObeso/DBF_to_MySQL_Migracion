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

*!*	TEXT TO lqry_ver_cn noshow
*!*	  SELECT * FROM bdcontratos.mnein where cestado = 'V'
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_cn, "tver_cn")
*!*	SELECT tver_cn



*!*	ln_detalle_pagos = RECCOUNT()
*!*	DO CASE ln_detalle_pagos 
*!*	   CASE ln_detalle_pagos > 2
*!*	           MESSAGEBOX("LA CUENTA TIENE PAGOS REALIZADOS POR CAJA, NO PUEDE ELIMINAR, PRIMERO EXTORNE TODOS LOS PAGOS REALIZADOS, LUEGO PROCEDA. SI CONSIDERA QUE DEBE ELIMINAR TODOS LOS PAGOS Y CONTRATO, USE LA OPCION ELIMINAR TODO EL CONTRATO",0,"EN TODO CASO INGRESE OTRO NUMERO DE CONTRATO")
*!*	              
*!*	   CASE BETWEEN(ln_detalle_pagos,1,2)
*!*	            MESSAGEBOX("1 o 2",0,"Ok" );
*!*	            

*!*	   
*!*	   OTHERWISE
*!*	            MESSAGEBOX("NINGUNO",0,"Ok" );
*!*	   
*!*	ENDCASE

*!*	   
*!*	?ln_detalle_pagos


*!*	IF ln_detalle_pagos = 2
*!*	   WITH thisform
*!*	     .detalle_del_servicio
*!*	     .detalle_del_cronograma
*!*	   ENDWITH
*!*	  
*!*	ELSE
*!*	   MESSAGEBOX("LA CUENTA TIENE PAGOS REALIZADOS POR CAJA, NO PUEDE ELIMINAR, PRIMERO EXTORNE TODOS LOS PAGOS REALIZADOS, LUEGO PROCEDA. SI CONSIDERA QUE DEBE ELIMINAR TODOS LOS PAGOS Y CONTRATO, USE LA OPCION ELIMINAR TODO EL CONTRATO",0,"EN TODO CASO INGRESE OTRO NUMERO DE CONTRATO")
*!*	    WITH thisform
*!*	     .limpiar_detalle_cronograma
*!*	     .command1.setfocus
*!*	    ENDWITH


*!*	     
*!*	   
*!*	ENDIF



