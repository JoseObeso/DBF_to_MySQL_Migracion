CLEAR
SET CENTURY ON
SET DATE TO ANSI
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

TEXT TO lqry_truncate noshow
 truncate table  bdcontratos.tmp_fechas_revisar
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_truncate)


TEXT TO lqry_ver_fechas noshow
   SELECT dfeccan, tipo_sistema_informatico, 
   CAST((CASE WHEN (tipo_sistema_informatico= '') THEN CONCAT(SUBSTR( dfeccan, 1, 4), '-', SUBSTR(dfeccan, 6, 2), '-', SUBSTR(dfeccan, 9, 2))
    ELSE CONCAT(SUBSTR(dfeccan, 7, 4), '-', SUBSTR(dfeccan, 4, 2), '-', SUBSTR(dfeccan, 1, 2))  END)  AS DATE) AS  fecha_cancelacion_formato   FROM bdcontratos.pgnein 
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_fechas, "tver_fechas")
SELECT tver_fechas
GO top
SCAN
    lc_dfeccan = ALLTRIM(tver_fechas.dfeccan)
    lc_fecha_cancelacion_formato  = ALLTRIM(DTOC(tver_fechas.fecha_cancelacion_formato))
 
    lc_dia = VAL(SUBSTR(lc_fecha_cancelacion_formato,9,2))
 
    lc_mes = VAL(SUBSTR(lc_fecha_cancelacion_formato,6,2))
 
    lc_anio = VAL(SUBSTR(lc_fecha_cancelacion_formato,1,4))
 
    lverifica = esfechavalida(lc_dia, lc_mes, lc_anio)
 
    IF lverifica = .f.
       TEXT TO lqry_grabar noshow
          INSERT INTO bdcontratos.tmp_fechas_revisar
           values(lc_dfeccan, '0', '')
       ENDTEXT
       lejecutabusca = sqlexec(gconecta,lqry_grabar)
        ?lc_dfeccan
 
    ENDIF
 
  ?lc_dfeccan 

 
 
ENDSCAN

?'--- fin -----'


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