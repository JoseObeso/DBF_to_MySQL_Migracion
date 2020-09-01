** de dbf to MySQL

lcruta = ADDBS(FULLPATH(CURDIR()))
SET DEFAULT TO &lcruta

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
*!*	 

*!*	*** PARA TABLA MESPACIOS *
*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table bdcontratos.mnein;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

*!*	TEXT TO lqry_migrar_truncar NOSHOW 
*!*	  truncate table  bdcontratos.terror;
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)


*!*	SET DEFAULT TO C:\APL\CTR\
*!*	CLOSE DATABASES all

*!*	UPDATE c:\apl\ctr\mnein.dbf SET cdeel = 0 WHERE cdeel <>0
*!*	UPDATE c:\apl\ctr\mnein.dbf SET ndescuen = 0 WHERE idcontrato in ('0088-2006-NI', '0060-2007-NI', '0057-2008-NF', '0059-2008-NF', '0066-2009-NF', '0179-2009-NF', '0207-2009-NF', '0229-2009-NF')
*!*	UPDATE c:\apl\ctr\mnein.dbf SET cnivesp = 0 WHERE idcontrato in ('0157-2012-NF')
*!*	CLOSE DATABASES all
*!*	SELECT 1
*!*	USE c:\apl\ctr\mnein EXCLUSIVE
*!*	PACK
*!*	SELECT 1
*!*	GO TOP 
*!*	SCAN

*!*	lc_idcontrato = ALLTRIM(mnein.idcontrato)
*!*	lc_cestado = ALLTRIM(mnein.cestado)
*!*	lc_ccodper = ALLTRIM(mnein.ccodper)
*!*	lc_dfecpro = ALLTRIM(mnein.dfecpro)
*!*	ln_nprecio1 = mnein.nprecio1
*!*	ln_nsersepul = mnein.nsersepul
*!*	ln_nmontototal = mnein.nmontotal
*!*	ln_nmoninicio = mnein.nmoninicio
*!*	ln_ncuotas = mnein.ncuotas
*!*	ln_nsalaf = mnein.nsalaf
*!*	lc_dfecfin = mnein.dfecfin
*!*	ln_nmonpag = mnein.nmonpag
*!*	ln_ntasa = mnein.ntasa
*!*	ln_ndiaatr = mnein.ndiaatr
*!*	lc_ccodplat = mnein.ccodplat
*!*	lc_ccodlet = mnein.ccodlet
*!*	lc_ccodnum = mnein.ccodnum
*!*	lc_cnivesp = mnein.cnivesp
*!*	ln_nnivusa = mnein.nnivusa
*!*	lc_ctipsepu = mnein.ctipsepu
*!*	lc_ccompag = mnein.ccompag
*!*	ln_ccantni = mnein.ccantni
*!*	ln_cnivrese = mnein.cnivrese
*!*	ln_cnivusa = mnein.cnivusa
*!*	ln_cniv1 = mnein.cniv1
*!*	ln_cniv2 = mnein.cniv2
*!*	ln_cniv3 = mnein.cniv3
*!*	ln_cniv4 = mnein.cniv4
*!*	ln_nsiinla = mnein.nsiinla
*!*	ln_nsilamo = mnein.nsilamo
*!*	ln_nsirere = mnein.nsirere
*!*	ln_nsiurco = mnein.nsiurco
*!*	ln_nsicein = mnein.nsicein
*!*	ln_cdeel = mnein.cdeel
*!*	ln_ccodcom = mnein.ccodcom
*!*	lc_ccodusu = ALLTRIM(mnein.ccodusu)
*!*	lc_dfecmod = mnein.dfecmod
*!*	lc_chora = mnein.chora
*!*	ln_nctservi = mnein.nctservi
*!*	lc_cdessepul = ALLTRIM(mnein.cdessepul)
*!*	lc_cnrodoc = ALLTRIM(mnein.cnrodoc)
*!*	lc_cnivel = ALLTRIM(mnein.cnivel)
*!*	ln_ndescuen = mnein.ndescuen
*!*	lc_cespocu = ALLTRIM(mnein.cespocu)
*!*	lc_cnroespa = ALLTRIM(mnein.cnroespa)
*!*	ln_nfondx = mnein.nfondx
*!*	lc_dfecsys = ALLTRIM(mnein.dfecsys)
*!*	ln_namplia = mnein.namplia
*!*	lc_idconampli = ALLTRIM(mnein.idconampli)
*!*	ln_nprecioa = mnein.nprecioa
*!*	lc_cgratis = ALLTRIM(mnein.cgratis)
*!*	ln_nfmg = mnein.nfmg
*!*	ln_ncuotag = mnein.ncuotag
*!*	ln_npagofmg = mnein.npagofmg
*!*	lc_ccanfm = ALLTRIM(mnein.ccanfm)
*!*	lcuser = '32921099'

*!*	* 56
*!*	TEXT TO lqry_migrar_mnein NOSHOW 
*!*	  call bdcontratos.sp_crud_operaciones_mnein(0,?lc_idcontrato, ?lc_cestado, ?lc_ccodper, ?lc_dfecpro, ?ln_nprecio1, ?ln_nsersepul, ?ln_nmontototal, ?ln_nmoninicio, ?ln_ncuotas, ?ln_nsalaf,
*!*	      ?lc_dfecfin, ?ln_nmonpag, ?ln_ntasa, ?ln_ndiaatr, ?lc_ccodplat, ?lc_ccodlet, ?lc_ccodnum, ?lc_cnivesp, ?ln_nnivusa,
*!*	      ?lc_ctipsepu, ?lc_ccompag, ?ln_ccantni, ?ln_cnivrese, ?ln_cnivusa, ?ln_cniv1, ?ln_cniv2, ?ln_cniv3, ?ln_cniv4, ?ln_nsiinla,
*!*	      ?ln_nsilamo, ?ln_nsirere, ?ln_nsiurco, ?ln_nsicein, ?ln_cdeel, ?ln_ccodcom, ?lc_ccodusu, ?lc_dfecmod, ?lc_chora, ?ln_nctservi, ?lc_cdessepul, ?lc_cnrodoc, ?lc_cnivel,
*!*	      ?ln_ndescuen, ?lc_cespocu, ?lc_cnroespa, ?ln_nfondx, ?lc_dfecsys, ?ln_namplia, ?lc_idconampli, ?ln_nprecioa, ?lc_cgratis, ?ln_nfmg, ?ln_ncuotag, ?ln_npagofmg, ?lc_ccanfm, ?lcuser, 'GRA')
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_migrar_mnein)
*!*	  IF lejecutabusca > 0
*!*	    cMensage = ' ... Grabacion, conforme....  ' + lc_idcontrato
*!*	    ?cMensage
*!*	  ELSE
*!*	     TEXT TO lqry_migrar_mnein_error NOSHOW 
*!*	            insert INTO bdcontratos.terror(codigo)
*!*	              values(?lc_idcontrato)
*!*	     ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_migrar_mnein_error)
*!*	  
*!*	    cMensage = ' ... Error de Grabacion....  ' + lc_idcontrato
*!*	    ?cMensage
*!*	  ENDIF
*!*	  _Screen.Scalemode = 0
*!*	  WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	ENDSCAN
*!*	_Screen.Scalemode = 0
*!*	WAIT Window cMensage At Int(_Screen.Height/2), Int(_Screen.Width/2 - Len(cMensage)/2) nowait
*!*	   
*!*	TEXT TO lqry_update_fm NOSHOW 
*!*	   update bdcontratos.mnein set nfondo_mant_saldo = nfondx, nfondo_mant_inicial = nfondx, tipo_sistema_informatico = ''
*!*	ENDTEXT
*!*	lejecutabusca = sqlexec(gconecta,lqry_update_fm)


*!*	CLOSE DATABASES ALL

*!*	****************************************************************************
*!*	SET DEFAULT TO &lcruta
*!*	 
*!*	CLOSE DATABASES ALL
*!*	*?' ... FIN DE MIGRACION TOTAL...  '
