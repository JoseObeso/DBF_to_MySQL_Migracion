
ln_usado = 0
ln_reservado =  0


DO CASE ln_usado
   CASE ln_usado = 1 AND ln_reservado = 0
     ?'1 y 0'
     
    CASE ln_usado = 0 AND ln_reservado = 1
     ?'0 y 1' 
     
      CASE ln_usado = 0 AND ln_reservado = 0
     ?'0 y 0' 
     
     
 ENDCASE
 