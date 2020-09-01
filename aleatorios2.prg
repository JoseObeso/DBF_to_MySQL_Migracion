clear
RAND(-1)
v1=INT(RAND()*1000)
DO WHILE .t.
 v2=INT(RAND()*44)
 IF v2<>v1
   EXIT
 ENDIF
ENDDO

DO WHILE .t.
 v3=INT(RAND()*43)
 IF v3<>v1 .and. v3<>v2
   EXIT
 ENDIF
ENDDO

DO WHILE .t.
v4=INT(RAND()*42)
IF v4<>v1 .and. v4<>v2 .and. v4<>v3
  EXIT
ENDIF
ENDDO
DO WHILE .t.
v5=INT(RAND()*41)
IF v5<>v1 .and. v5<>v2 .and. v5<>v3 .and. v5<>v4
  EXIT
ENDIF
ENDDO


DO WHILE .t.
 v6=INT(RAND()*40)
 IF v6<>v1 .and. v6<>v2 .and. v6<>v3 .and. v6<>v4 .and. v6<>v5
   EXIT
 ENDIF
ENDDO

t1 = PADL(ALLTRIM(STR(v1)),4,'0')
 
?t1
?v2

?v3

?v4

?v5

?v6