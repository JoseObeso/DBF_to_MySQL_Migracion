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
gconecta2 = SQLSTRINGCONNECT(lcStringCnxLocal)

lc_fecha_aaaa_mm_dd = '2020-02-20'

?'lqry_proceso_1'
TEXT TO lqry_proceso_1 noshow
  update bdcontratos.pgnein set fecha_vencimiento_formato = concat(substring(dfeccan,1,4), '-', substring(dfeccan,6,2), '-', substring(dfeccan,9,2)) where dfeccan like '%.%'
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_1)
?lejecutabusca

?'lqry_proceso_2'
TEXT TO lqry_proceso_2 noshow
 update bdcontratos.pgnein set fecha_vencimiento_formato = concat(substring(dfeccan,7,4), '-', substring(dfeccan,4,2), '-', substring(dfeccan,1,2)) where dfeccan like '%/%'
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_2)
?lejecutabusca


?'lqry_proceso_3'
TEXT TO lqry_proceso_3 noshow
 update bdcontratos.pgnein set npagototal_calculado = 0, compensatorio_monto_interes = 0, dias_de_atraso = 0
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_3)
?lejecutabusca

?'lqry_proceso_4'
TEXT TO lqry_proceso_4 noshow
 update bdcontratos.pgnein set npagototal_calculado = 0, compensatorio_monto_interes = 0, dias_de_atraso = 0
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_4)
?lejecutabusca


 ?'lqry_proceso_5'
TEXT TO lqry_proceso_5 noshow
 update bdcontratos.pgnein set npagototal_calculado = 0, compensatorio_monto_interes = 0, dias_de_atraso = 0
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_5)
?lejecutabusca

?'lqry_proceso_6'
TEXT TO lqry_proceso_6 noshow
    update bdcontratos.pgnein  set dias_de_atraso = DATEDIFF(date(?lc_fecha_aaaa_mm_dd),date(fecha_vencimiento_formato)),  compensatorio_fecha_calculo = ?lc_fecha_aaaa_mm_dd
     where date(fecha_vencimiento_formato) <= DATE(?lc_fecha_aaaa_mm_dd); 
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_6)
?lejecutabusca


 
?'lqry_proceso_7'
TEXT TO lqry_proceso_7 noshow
 update bdcontratos.pgnein set compensatorio_monto_interes = round(((pow(((1+compensatorio_tasa_interes/100)),1/360)-1)*100) * ndeuda,2), compensatorio_fecha_pc = now()
      where CESTADO = 'D' AND TIPO_PAGO = 'CN' AND DIAS_DE_ATRASO >0;
ENDTEXT
lejecutabusca7 = sqlexec(gconecta2,lqry_proceso_7)
?lejecutabusca7


?'lqry_proceso_8'
TEXT TO lqry_proceso_8 noshow
 update bdcontratos.pgnein set npagototal_calculado = (case when npagcap = 0 then npagtot else npagcap end)  + compensatorio_monto_interes 
where CESTADO = 'D' AND TIPO_PAGO = 'CN' AND DIAS_DE_ATRASO >0; 
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_proceso_8)

?'----fin'

 