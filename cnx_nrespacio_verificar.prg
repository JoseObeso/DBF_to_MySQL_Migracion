
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
 


*!*	lc_nrespacio = '0000000005'

*!*	   TEXT TO lqry_gt_idcontrato noshow
*!*	        select idcontrato from    bdcontratos.mnein where cnroespa = ?lc_nrespacio 
*!*	     ENDTEXT
*!*	     lejecutabusca = sqlexec(gconecta,lqry_gt_idcontrato, "tver_cont")
*!*	     SELECT tver_cont
*!*	     ln_reccount_tver = RECCOUNT()
*!*	     ?ln_reccount_tver
*!*	     DO CASE ln_reccount_tver
*!*	        CASE ln_reccount_tver = 1
*!*	        ?'aqui 1'
*!*	         lc_idcon = ALLTRIM(tver_cont.idcontrato)
*!*	             TEXT TO lqry_p1 noshow
*!*	               UPDATE bdcontratos.mespacioniveles SET idcontrato = ?lc_idcon where crespacio= ?lc_nrespacio  and nnivel = 1;
*!*	             endtext
*!*	             lejecutabusca = sqlexec(gconecta,lqry_p1)
*!*	            
*!*	        CASE ln_reccount_tver = 2
*!*	           ?'aqui 2'
*!*	        
*!*	           TEXT TO lqry_1 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_1, "tver_1")
*!*	          SELECT tver_1
*!*	          lc_con1 = ALLTRIM(tver_1.idcontrato)
*!*	          TEXT TO lqry_up1 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con1 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up1)
*!*	          
*!*	           TEXT TO lqry_2 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato <>  ?lc_con1
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_2, "tver_2")
*!*	          SELECT tver_2
*!*	          lc_con2 = ALLTRIM(tver_2.idcontrato)
*!*	          TEXT TO lqry_up2 noshow
*!*	            update bdcontratos.mespacioniveles set idcontrato = ?lc_con2 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up2)
*!*	          
*!*	          
*!*	       CASE ln_reccount_tver = 3
*!*	          ?'aqui 3'
*!*	        
*!*	           TEXT TO lqry_31 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_31, "tver_31")
*!*	          SELECT tver_31
*!*	          lc_con31 = ALLTRIM(tver_31.idcontrato)
*!*	          ?lc_con31
*!*	          TEXT TO lqry_up13 noshow
*!*	            update bdcontratos.mespacioniveles set idcontrato = ?lc_con31 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up13)
*!*	          ?lejecutabusca
*!*	          

*!*	          TEXT TO lqry_32 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con31) limit 1
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_32, "tver_32")
*!*	          SELECT tver_32
*!*	          lc_con32 = ALLTRIM(tver_32.idcontrato)
*!*	          TEXT TO lqry_up32 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con32 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up32)
*!*	          
*!*	                
*!*	          
*!*	         TEXT TO lqry_33 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con31, ?lc_con32)           
*!*	         ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_33, "tver_33")
*!*	          SELECT tver_33
*!*	          lc_con33 = ALLTRIM(tver_33.idcontrato)
*!*	          TEXT TO lqry_up33 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con33 WHERE crespacio =  ?lc_nrespacio AND nnivel = 3
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up33)
*!*	          
*!*	          
*!*	                  
*!*	          CASE ln_reccount_tver = 4
*!*	             ?'aqui 4'
*!*	        
*!*	           TEXT TO lqry_41 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_41, "tver_41")
*!*	          SELECT tver_41
*!*	          lc_con41 = ALLTRIM(tver_41.idcontrato)
*!*	          
*!*	          TEXT TO lqry_up14 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con41 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up14)
*!*	          

*!*	          TEXT TO lqry_42 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41) limit 1
*!*	           ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_42, "tver_42")
*!*	          SELECT tver_42
*!*	          lc_con42 = ALLTRIM(tver_42.idcontrato)
*!*	          TEXT TO lqry_up42 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con42 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up42)
*!*	          
*!*	                
*!*	          
*!*	         TEXT TO lqry_34 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41, ?lc_con42)           
*!*	         ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_34, "tver_34")
*!*	          SELECT tver_34
*!*	          lc_con34 = ALLTRIM(tver_34.idcontrato)
*!*	          TEXT TO lqry_up34 noshow
*!*	            update bdcontratos.mespacioniveles set idcontrato = ?lc_con34 WHERE crespacio =  ?lc_nrespacio AND nnivel = 3
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up34)
*!*	          
*!*	          
*!*	          
*!*	        TEXT TO lqry_44 noshow
*!*	            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41, ?lc_con42, ?lc_con43)        
*!*	         ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_44, "tver_44")
*!*	          SELECT tver_44
*!*	          lc_con44 = ALLTRIM(tver_44.idcontrato)
*!*	          TEXT TO lqry_up44 noshow
*!*	            update bdcontratos.mespacioniveles set  idcontrato = ?lc_con44 WHERE crespacio =  ?lc_nrespacio AND nnivel = 4
*!*	          ENDTEXT
*!*	          lejecutabusca = sqlexec(gconecta,lqry_up44)
*!*	          
*!*	            
*!*	          
*!*	          
*!*	          
*!*	          
*!*	       ENDCASE
*!*	          
*!*	          
*!*	  
*!*	  