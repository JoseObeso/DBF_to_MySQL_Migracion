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

TEXT TO lqry_mostrar_duplicados noshow
  SELECT * FROM bdcontratos.tmp_contratos_duplicado order by ncuotas_pgnein
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_mostrar_duplicados, "tver_duplicados")
SELECT tver_duplicados
GO top
SCAN
  lc_idcontrato = tver_duplicados.idcontrato
 
   
  TEXT TO lqry_1 noshow
    select  * from bdcontratos.pgnein  where idcontrato = ?lc_idcontrato AND NCUOTA = '1' ORDER BY idpgnein desc LIMIT 1
  ENDTEXT
  lejecutabusca = sqlexec(gconecta,lqry_1, "tver_primero")
  SELECT tver_primero
  ln_primero = tver_primero.idpgnein
  


  TEXT TO lqry_2 noshow
    select  * from bdcontratos.pgnein  where idcontrato = ?lc_idcontrato order by idpgnein desc limit 1
  ENDTEXT
  lejecutabusca = sqlexec(gconecta,lqry_2, "tver_ultimo")
  SELECT tver_ultimo
  ln_ultimo = tver_ultimo.idpgnein
  
  
  TEXT TO lqry_borrar noshow
   DELETE from bdcontratos.pgnein  where idcontrato = ?lc_idcontrato and idpgnein between ?ln_primero  and ?ln_ultimo
  ENDTEXT
  lejecutabusca = sqlexec(gconecta,lqry_borrar)
  
  cmensaje = 'PROCESANDO : '  + lc_idcontrato
  ?cmensaje


ENDSCAN

