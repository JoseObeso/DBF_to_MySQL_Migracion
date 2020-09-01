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
 

*** PARA TABLA MESPACIOS *
TEXT TO lqry_migrar_truncar NOSHOW 
   truncate table bdcontratos.mespacioniveles
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_migrar_truncar)

 
TEXT TO lqry_ver_plataforma NOSHOW 
    SELECT * FROM bdcontratos.plataforma  
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_ver_plataforma, "ver_plata")
SELECT ver_plata
GO top
SCAN
  ln_idplataforma = ALLTRIM(STR(ver_plata.idplataforma))
  lc_plataforma = ALLTRIM(ver_plata.descripcion)
  TEXT TO lver_espacio noshow
      select * from bdcontratos.mespacios where ccodplat = ?ln_idplataforma
  endtext
  lejecutabusca = sqlexec(gconecta,lver_espacio, "ver_espacio")

  SELECT ver_espacio
  GO top
  SCAN
     lc_nrespacio = ALLTRIM(ver_espacio.nrespacio)
     ln_ncantini = ver_espacio.ncantini
     ln_usado = ver_espacio.nusado
     ln_reservado = ver_espacio.ncantre
     ln_disponible = ver_espacio.ncantdi
      
     
 
     ln_n1 = VAL(ver_espacio.cposnib)
     ln_n2 = VAL(ver_espacio.cposnm)
     ln_n3 = VAL(ver_espacio.cpona)
     ln_n4 = VAL(ver_espacio.cnivel4)
     
     FOR t=1 TO ln_ncantini
       text to lqry_graba noshow
           insert into bdcontratos.mespacioniveles(crespacio, nnivel, nusado, nreservado)
           values (?lc_nrespacio, ?t, 0, 0);
       endtext
       lejecutabusca = sqlexec(gconecta,lqry_graba)
         
    
     ENDFOR
     
     DO CASE ln_ncantini
        CASE ln_ncantini = 2
             IF  ln_usado = 2 AND ln_reservado = 0
                TEXT TO lqry_up1 noshow
                   update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1,2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up1)
             
             ENDIF
             IF  ln_usado = 0 AND ln_reservado = 2
                TEXT TO lqry_up2 noshow
                   update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (1,2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up2)   
             ENDIF       
             
            IF  ln_usado = 1 AND ln_reservado = 1
                TEXT TO lqry_up3 noshow
                   update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up3)   
                
                TEXT TO lqry_up33 noshow
                   update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up33)   
             ENDIF
             
               
          IF  ln_usado = 0 AND ln_reservado = 1
                TEXT TO lqry_up4 noshow
                   update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (1)
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up4)   
                
                TEXT TO lqry_up44 noshow
                   update bdcontratos.mespacioniveles set nusado = 0, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up44)   
             ENDIF                  
             
               
          IF  ln_usado = 1 AND ln_reservado = 0
                TEXT TO lqry_up5 noshow
                    update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1)
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up5)   
                
                TEXT TO lqry_up55 noshow
                   update bdcontratos.mespacioniveles set nusado = 0, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (2);
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up5)   
             ENDIF                  
                  
        CASE ln_ncantini = 3
        
           IF  ln_usado = 3 AND ln_reservado = 0
                TEXT TO lqry_up5 noshow
                    update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1,2,3)
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up5)
              
           ENDIF   
        
        
           IF  ln_usado = 2 AND ln_reservado = 0
                TEXT TO lqry_up6 noshow
                    update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1,2)
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up6)   
                
              
           ENDIF   
        
        
           IF  ln_usado = 1 AND ln_reservado = 0
                TEXT TO lqry_up7 noshow
                    update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1)
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up7)   
                
              
           ENDIF   
           
           IF  ln_usado = 0 AND ln_reservado = 3
                TEXT TO lqry_up8 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (1,2,3) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up8)   
                
              
           ENDIF   
      
          IF  ln_usado = 0 AND ln_reservado = 2
                TEXT TO lqry_up9 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (1,2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up9)   
                
              
           ENDIF  
           
       
          IF  ln_usado = 0 AND ln_reservado = 1
                TEXT TO lqry_up10 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (1) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up10)   
                
              
           ENDIF   
        
              
     
        
          IF  ln_usado = 2 AND ln_reservado = 1
                TEXT TO lqry_up119 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up119)
                
                TEXT TO lqry_up129 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up129)   
                   
                TEXT TO lqry_up1378 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (3) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up1378)   
                
                          
              
           ENDIF   
        
           IF  ln_usado = 1 AND ln_reservado = 2
                TEXT TO lqry_up127 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up127)
                
                TEXT TO lqry_up137 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up137)   
                   
                TEXT TO lqry_up147 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  and nnivel in (3) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up147)   
                
           ENDIF   
       
         CASE ln_ncantini = 4
         
         
           IF  ln_usado = 4 AND ln_reservado = 0
                TEXT TO lqry_up12 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio   and nnivel in (1,2,3,4) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up12)
                    
           ENDIF   
            
          IF  ln_usado = 3 AND ln_reservado = 0
                TEXT TO lqry_up13 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio   and nnivel in (1,2,3) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up13)
                    
           ENDIF   
                     
           IF  ln_usado = 2 AND ln_reservado = 0
                TEXT TO lqry_up14 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio   and nnivel in (1,2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up14)
                    
           ENDIF   
            
           IF  ln_usado = 1 AND ln_reservado = 0
                TEXT TO lqry_up15 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio   and nnivel in (1);
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up15)
                    
           ENDIF     
           
           
           
         IF  ln_usado = 0 AND ln_reservado = 4
                TEXT TO lqry_up16 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (1,2,3,4) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up16)
                    
           ENDIF    
                  
    
       IF  ln_usado = 0 AND ln_reservado = 3
                TEXT TO lqry_up17 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (1,2,3) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up17)
                    
           ENDIF    
                        
           
       IF  ln_usado = 0 AND ln_reservado = 2
                TEXT TO lqry_up18 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (1,2) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up18)
                    
           ENDIF    
              
           
       IF  ln_usado = 0 AND ln_reservado = 1
                TEXT TO lqry_up188 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (1) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up188)
                    
           ENDIF            
           
           
        IF  ln_usado = 3 AND ln_reservado = 1
                TEXT TO lqry_up19 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  AND  nnivel in (1,2,3) 
                        
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up19)
                
               TEXT TO lqry_up21 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio  AND  nnivel in (4) 
       
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up21)
                    
                    
           ENDIF            
           
           
           
        IF  ln_usado = 2 AND ln_reservado = 2
                TEXT TO lqry_up20 noshow
                       update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1,2)   
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up20)
                
                
               TEXT TO lqry_up22 noshow
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (3,4) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up22)
                    
                    
           ENDIF      
           
           
           
          IF  ln_usado = 1 AND ln_reservado = 3
                TEXT TO lqry_up25 noshow
                        update bdcontratos.mespacioniveles set nusado = 1, nreservado = 0 where crespacio = ?lc_nrespacio  and nnivel in (1)       
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up25)
                
                
               TEXT TO lqry_up26 noshow
               
                       update bdcontratos.mespacioniveles set nusado = 0, nreservado = 1 where crespacio = ?lc_nrespacio   and nnivel in (2,3,4) 
                endtext
                lejecutabusca = sqlexec(gconecta,lqry_up26)
                    
                    
           ENDIF      
           
        
        
     ENDCASE
    
     TEXT TO lqry_gt_idcontrato noshow
        select idcontrato from    bdcontratos.mnein where cnroespa = ?lc_nrespacio
     ENDTEXT
     lejecutabusca = sqlexec(gconecta,lqry_gt_idcontrato, "tver_cont")
     SELECT tver_cont
     ln_reccount_tver = RECCOUNT()
     ?ln_reccount_tver
     DO CASE ln_reccount_tver
        CASE ln_reccount_tver = 1
         lc_idcon = ALLTRIM(tver_cont.idcontrato)
             TEXT TO lqry_p1 noshow
               UPDATE bdcontratos.mespacioniveles SET idcontrato = ?lc_idcon where crespacio= ?lc_nrespacio  and nnivel = 1;
             endtext
             lejecutabusca = sqlexec(gconecta,lqry_p1)
            
        CASE ln_reccount_tver = 2
        
           TEXT TO lqry_1 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_1, "tver_1")
          SELECT tver_1
          lc_con1 = ALLTRIM(tver_1.idcontrato)
          TEXT TO lqry_up1 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con1 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up1)
          
           TEXT TO lqry_2 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato <>  ?lc_con1
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_2, "tver_2")
          SELECT tver_2
          lc_con2 = ALLTRIM(tver_2.idcontrato)
          TEXT TO lqry_up2 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con2 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up2)
          
          
       CASE ln_reccount_tver = 3
        
           TEXT TO lqry_31 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_31, "tver_31")
          SELECT tver_31
          lc_con31 = ALLTRIM(tver_31.idcontrato)
          TEXT TO lqry_up13 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con31 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up13)
          

          TEXT TO lqry_32 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con31) limit 1
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_32, "tver_32")
          SELECT tver_32
          lc_con32 = ALLTRIM(tver_32.idcontrato)
          TEXT TO lqry_up32 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con32 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up32)
          
                
          
         TEXT TO lqry_33 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con31, ?lc_con32)           
         ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_33, "tver_33")
          SELECT tver_33
          lc_con33 = ALLTRIM(tver_33.idcontrato)
          TEXT TO lqry_up33 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con33 WHERE crespacio =  ?lc_nrespacio AND nnivel = 3
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up33)
          
          
                  
          CASE ln_reccount_tver = 4
        
           TEXT TO lqry_41 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio  limit 1 
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_41, "tver_41")
          SELECT tver_41
          lc_con41 = ALLTRIM(tver_41.idcontrato)
          
          TEXT TO lqry_up14 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con41 WHERE crespacio =  ?lc_nrespacio AND nnivel = 1
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up14)
          

          TEXT TO lqry_42 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41) limit 1
           ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_42, "tver_42")
          SELECT tver_42
          lc_con42 = ALLTRIM(tver_42.idcontrato)
          TEXT TO lqry_up42 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con42 WHERE crespacio =  ?lc_nrespacio AND nnivel = 2
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up42)
          
                
          
         TEXT TO lqry_34 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41, ?lc_con42)           
         ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_34, "tver_34")
          SELECT tver_34
          lc_con34 = ALLTRIM(tver_34.idcontrato)
          TEXT TO lqry_up34 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con34 WHERE crespacio =  ?lc_nrespacio AND nnivel = 3
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up34)
          
          
          
        TEXT TO lqry_44 noshow
            select  idcontrato  from bdcontratos.mnein where cnroespa = ?lc_nrespacio AND idcontrato NOT in (?lc_con41, ?lc_con42, ?lc_con43)        
         ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_44, "tver_44")
          SELECT tver_44
          lc_con44 = ALLTRIM(tver_44.idcontrato)
          TEXT TO lqry_up44 noshow
            update bdcontratos.mespacioniveles where  idcontrato = ?lc_con44 WHERE crespacio =  ?lc_nrespacio AND nnivel = 4
          ENDTEXT
          lejecutabusca = sqlexec(gconecta,lqry_up44)
          
            
          
          
          
          
       ENDCASE
          
          
          
            
  
     
    
     
     
     
     cMensage = '... PLATAFORMA : ' + lc_plataforma + ' ... ESPACIO....  ' + lc_nrespacio + '.. NIVELES : ' + ALLTRIM(STR( ln_ncantini))
    ?cMensage
    ?ln_usado
    ?ln_reservado
    ?lc_nrespacio
 
  ENDSCAN
    
  
  

ENDSCAN

 
