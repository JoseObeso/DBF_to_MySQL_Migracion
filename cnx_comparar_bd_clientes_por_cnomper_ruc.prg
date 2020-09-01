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
?gconecta

lcuser = '32921099'


text to lqry_ver_clientes noshow
  SELECT * FROM bdcontratos.tabla_sigesco where condicion = 'ERROR' and length(ruc) > 8 ORDER BY razon_social 
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_clientes, "tver_sigesco")
SELECT tver_sigesco
GO top
SCAN
    lc_cnomper = ALLTRIM(tver_sigesco.razon_social)
    TEXT TO lqry_ubicar noshow
      SELECT  * FROM bdcontratos.mpersonas where cruc = ?lc_cnomper  limit 1
    ENDTEXT
    lejecutabusca = sqlexec(gconecta,lqry_ubicar, "tver_encontrado")
    SELECT tver_encontrado
    ln_rec = RECCOUNT()
    IF ln_rec > 0
       lc_ccodper_2 = ALLTRIM(tver_encontrado.ccodper)
       lc_cnomper_2 = ALLTRIM(tver_encontrado.cnomper)
       lc_condicion = 'OK'
    ELSE
       lc_ccodper_2 = 'NO EXISTE'
       lc_cnomper_2 = 'NO EXISTE'
       lc_condicion = 'ERROR'
    ENDIF
    TEXT TO lqry_update_sigesco noshow
      UPDATE bdcontratos.tabla_sigesco SET ccodper_bdcontrato = ?lc_ccodper_2, cnomper_bdcontrato = ?lc_cnomper_2, condicion = ?lc_condicion
       where ruc = ?lc_cnomper
    ENDTEXT
    lejecutabusca = sqlexec(gconecta,lqry_update_sigesco)
    ?lc_cnomper
    ?lc_ccodper_2
    ?lc_cnomper_2
    ?lc_condicion
    
ENDSCAN
  ?' ---  FIN ---'


