CLEAR
SET DATE TO ansi
SET DATE TO dmy
SET CENTURY ON

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
?lcStringCnxLocal

Sqlsetprop(0,"DispLogin" , 3 ) 
SQLSETPROP(0,"IdleTimeout",0)
gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
?gconecta

TEXT TO lqry_ver_fechas noshow
  SELECT idpgnein, fecha_vencimiento_formato FROM bdcontratos.pgnein  
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_fechas, "tver")
SELECT tver
GO top
SCAN
 ln_id = tver.idpgnein
 lc_fecha = ALLTRIM(tver.fecha_vencimiento_formato)
 ln_dia = VAL(substr(lc_fecha, 9,2))
 ln_mes = VAL(substr(lc_fecha, 6,2))
 ln_anio = VAL(substr(lc_fecha, 1,4))

 IF EsFechaValida(ln_dia, ln_mes, ln_anio) = .t.
 
  ELSE
   ?'error'
  
   
   TEXT TO lqry_inser noshow
    insert bdcontratos.a_error (fecha, iderror)
    values (?lc_fecha, ?ln_id)
   ENDTEXT
   lejecutabusca = sqlexec(gconecta,lqry_inser)
   ?ln_id
 ?lc_fecha
 ?ln_dia
 ?ln_mes
 ?ln_anio
   
  ENDIF
  
  

ENDSCAN


 

 FUNCTION EsFechaValida(tnDia, tnMes, tnAnio)
  RETURN ;
    VARTYPE(tnAnio) = "N" AND ;
    VARTYPE(tnMes) = "N" AND ;
    VARTYPE(tnDia) = "N" AND ;
    BETWEEN(tnAnio, 100, 9999) AND ;
    BETWEEN(tnMes, 1, 12) AND ;
    BETWEEN(tnDia, 1, 31) AND ;
    NOT EMPTY(DATE(tnAnio, tnMes, tnDia))
ENDFUNC
