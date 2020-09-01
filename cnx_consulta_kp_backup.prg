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

lc_idcontrato = '0018-2005-NF'


TEXT TO lqry_ver_detalles_de_pagos noshow
  SELECT * FROM bdcontratos.kpagos WHERE idcontrato=?lc_idcontrato AND CESTADO = 'A'  
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_detalles_de_pagos, "tver_contratos_detalle_pagos")
SELECT tver_contratos_detalle_pagos
ln_detalle_pagos = RECCOUNT()
?ln_detalle_pagos

IF BETWEEN(ln_detalle_pagos,1,2)
    TEXT TO lqry_ver_01 noshow
       SELECT count(*) as cuenta FROM bdcontratos.kpagos where idcontrato  = ?lc_idcontrato and  cconcep = 'CN' and tipo_sistema_informatico = '';
    endtext
    lejecutabusca = sqlexec(gconecta,lqry_ver_01, "tver_reg_01")
    ln_cuenta = VAL(tver_reg_01.cuenta)
    IF ln_cuenta = 1
       MESSAGEBOX("mostrar calendario",0,"Ok" ) 
    ELSE
       MESSAGEBOX("TIENE ALGUNOS PAGOS REALIZADOS, REVISE SU HISTORIAL DE PAGOS",0,"Ok" ) 
    ENDIF
ELSE
   MESSAGEBOX("TIENE VARIAS CUOTAS",0,"Ok" ) 
ENDIF
             

**
IF BETWEEN(ln_detalle_pagos,1,2)
    TEXT TO lqry_ver_01 noshow
       SELECT count(*) as cuenta FROM bdcontratos.kpagos where idcontrato  = ?lc_idcontrato and  cconcep IN ('CN', 'FM', 'PC')
    endtext
    lejecutabusca = sqlexec(gconecta,lqry_ver_01, "tver_reg_01")
    ln_cuenta = VAL(tver_reg_01.cuenta)
    IF ln_cuenta = 1
          MESSAGEBOX("MOSTRANDO CRONOGRAMA",0,"Ok" ) 
    ELSE
    
       MESSAGEBOX("TIENE ALGUNOS PAGOS REALIZADOS, REVISE SU HISTORIAL DE PAGOS",0,"Ok" ) 
       
    ENDIF
ELSE
  
       MESSAGEBOX("TIENE ALGUNOS PAGOS REALIZADOS, REVISE SU HISTORIAL DE PAGOS",0,"Ok" ) 

ENDIF

**





*!*	IF ln_detalle_pagos > 2

*!*	                     MESSAGEBOX("TIENE VARIAS CUOTAS",0,"Ok" ) 
*!*	ELSE
*!*	             MESSAGEBOX("1 o 2",0,"Ok" ) 

*!*	ENDIF





*!*	DO CASE ln_detalle_pagos
*!*	   CASE BETWEEN(ln_detalle_pagos,1,2)
*!*	          MESSAGEBOX("1 o 2",0,"Ok" );
*!*	          

*!*	   CASE ln_detalle_pagos > 2
*!*	          MESSAGEBOX("TIENE VAREIAS CUOTAS PAGADAS",0,"Ok" );
*!*	          
*!*	   OTHERWISE
*!*	          MESSAGEBOX("NINGUN PAGO REGISTRADO",0,"Ok" );
*!*	ENDCASE
