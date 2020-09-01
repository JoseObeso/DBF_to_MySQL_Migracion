clear
ln_numero_inicial = 1
ln_numero_final = 9999 
valor =  INT((ln_numero_final - ln_numero_inicial + 1) * RAND( ) + ln_numero_inicial)
lc_nro_aleatorio = ALLTRIM(STR(valor))
?lc_nro_aleatorio