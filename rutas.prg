clear
lcruta = ADDBS(FULLPATH(CURDIR()))
?lcruta
nnro = AT("FNT", lcruta)
?nnro
IF nnro <> 0
   gcgraficos = substr(lcruta,1,nnro-1) + "GRA\"
ELSE
   gcgraficos = lcruta + "GRA\"
ENDIF
_screen.picture=gcgraficos + "wfondo.jpg"
?gcgraficos
 
      
      