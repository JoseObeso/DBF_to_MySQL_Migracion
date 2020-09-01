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

lc_fecha_aaaa_mm_dd = '2020-02-20'

?'lqry_proceso_7'

TEXT TO lqry_proceso_7 noshow
 update bdcontratos.pgnein set compensatorio_monto_interes = round(((pow(((1+compensatorio_tasa_interes/100)),1/360)-1)*100) * ndeuda,2), compensatorio_fecha_pc = now()
      where CESTADO = 'D' AND TIPO_PAGO = 'CN' AND DIAS_DE_ATRASO >0;
ENDTEXT
lejecutabusca7 = sqlexec(gconecta,lqry_proceso_7)
?lejecutabusca7


?'----fin'

 