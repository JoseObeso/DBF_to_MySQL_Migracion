** de dbf to MySQL
CLEAR
lcruta = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta


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
 


*!*	*** ACTUALIZA MNICHOS 
*!*	TEXT TO lqry_update_mnichos NOSHOW 
*!*	  update bdcontratos.mnichos set cusado = '0', clibre = '0' where nnicho =  '01212';
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_mnichos)

*!*	TEXT TO lqry_ver_nro_fila NOSHOW
*!*	     select idcontrato, cnroespa, cdessepul, cnivel, ccodplat, ccodlet, ccodnum from bdcontratos.mnein WHERE substr(idcontrato,12,1) = 'C';
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_nro_fila, "tespa")
*!*	SELECT tespa
*!*	SCAN
*!*	  lc_cnro_espa = ALLTRIM(tespa.cnroespa)
*!*	  lc_cdesepul = ALLTRIM(tespa.cdessepul)
*!*	  TEXT TO lqry_espa noshow
*!*	     update bdcontratos.mnichos set cusado = '1', clibre = '1' where nnicho = ?lc_cnro_espa
*!*	  ENDTEXT
*!*	  lejecutabusca = sqlexec(gconecta,lqry_espa)
*!*	  cMensage = 'ESPACIO : ' + lc_cnro_espa + ' - '  + lc_cdesepul
*!*	  ?cMensage

*!*	ENDSCAN




CLOSE DATABASES ALL

****************************************************************************
 
SET DEFAULT TO &lcruta
 
CLOSE DATABASES ALL
*?' ... FIN DE MIGRACION TOTAL...  '
