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
   select * from bdcontratos.clientes_sigesco_bdcontrato WHERE marcar_null = '0' order by sigesco_razon_social 
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_clientes, "tver_sigesco")
SELECT tver_sigesco
GO top
SCAN
    lc_dni = ALLTRIM(tver_sigesco.ruc_sigesco)
    IF LEN(lc_dni) = 11
	     
	    TEXT TO lqry_ubicar noshow
	      SELECT * FROM bdcontratos.mpersonas where cruc = ?lc_dni
	    ENDTEXT
	    lejecutabusca = sqlexec(gconecta,lqry_ubicar, "tver_encontrado")
	    SELECT tver_encontrado
	    ln_rec = RECCOUNT()
	    IF ln_rec > 0
	       lc_ccodper_2 = ALLTRIM(tver_encontrado.ccodper)
	       lc_cnomper_2 = ALLTRIM(tver_encontrado.cnomper)
	       lc_cdni = ALLTRIM(tver_encontrado.cdni)
	       lc_ruc = ALLTRIM(tver_encontrado.cruc)
	       lc_tipo = ALLTRIM(tver_encontrado.ctipper)
	       lc_distri = ALLTRIM(tver_encontrado.cdistri)
	       lc_direccion = ALLTRIM(tver_encontrado.cdir)
	       lc_null = '1'
	       lc_grabar = '-- GRABADO --- '
	    ELSE
	      lc_ccodper_2 = ''
	       lc_cnomper_2 = ''
	       lc_cdni = ''
	       lc_ruc = ''
	       lc_tipo = ''
	       lc_distri = ''
	       lc_direccion = ''
	       lc_null = '0'
	       lc_grabar = '-- NO EXISTE --- '
	    ENDIF
	    TEXT TO lqry_update_sigesco noshow
	      UPDATE bdcontratos.clientes_sigesco_bdcontrato SET bdcontratos_ccodper = ?lc_ccodper_2, bdcontratos_nombre_razon = ?lc_cnomper_2, bdcontratos_dni = ?lc_cdni,
	      bdcontratos_ruc = ?lc_ruc, bdcontratos_tipo = ?lc_tipo, bdcontratos_distrito = ?lc_distri, bdcontratos_direccion = ?lc_direccion, marcar_null = ?lc_null
	       where ruc_sigesco = ?lc_dni
	    ENDTEXT
	    lejecutabusca = sqlexec(gconecta,lqry_update_sigesco)
	    
      ENDIF
      
	?lc_dni 
    
	 
	 
    
ENDSCAN
  ?' ---  FIN ---'
 
