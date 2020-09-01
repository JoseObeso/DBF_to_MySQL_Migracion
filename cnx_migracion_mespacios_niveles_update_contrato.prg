** de dbf to MySQL
CLEAR

lcruta_inicial = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta_inicial


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
 
*!*	 
*!*	 
*!*	TEXT TO lqry_ver_crespacio NOSHOW 
*!*	     select crespacio from  bdcontratos.mespacioniveles where  nusado = 0 and nreservado = 0 and idcontrato <> '' group by crespacio
*!*	     
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_ver_crespacio, "trespacio")
*!*	SELECT trespacio
*!*	GO top
*!*	SCAN
*!*	 lc_respacio = ALLTRIM(trespacio.crespacio)
*!*	 
*!*	 TEXT TO lqry_ver_espa noshow
*!*	   select idcontrato, cnivrese, cnivusa from  bdcontratos.mnein where cnroespa =  ?lc_respacio
*!*	 ENDTEXT
*!*	 lejecutabusca = sqlexec(gconecta,lqry_ver_espa, "t_espa")
*!*	 SELECT t_espa 
*!*	 lc_cnivrese = t_espa.cnivrese
*!*	 lc_cnivusa = t_espa.cnivusa 
*!*	 IF lc_cnivrese = 1
*!*	    TEXT TO lqry_update_rese noshow
*!*	      update bdcontratos.mespacioniveles set nreservado = 1 where   crespacio = ?lc_respacio and nreservado = 0 and nusado = 0 and idcontrato <> '';
*!*	    ENDTEXT
*!*	    lejecutabusca = sqlexec(gconecta,lqry_update_rese)
*!*	 ENDIF

*!*	  IF lc_cnivusa = 1
*!*	    TEXT TO lqry_update_cusa noshow
*!*	      update bdcontratos.mespacioniveles set nusado = 1 where   crespacio = ?lc_respacio and nreservado = 0 and nusado = 0 and idcontrato <> '';
*!*	    ENDTEXT
*!*	    lejecutabusca = sqlexec(gconecta,lqry_update_cusa)
*!*	 ENDIF
*!*	   cMensage = '...PROCESANDO....' + lc_respacio 
*!*	   ?cMensage
*!*	     

*!*	ENDSCAN








*!*	 
