* calculo de intereses
CLEAR
SET DECIMALS TO 2

ln_saldoafinanciar =9500
ln_tea = 8
ln_cuotas = 12

ln_intereses = (((1+ln_tea/100))^(30/360)-1)*100
ln_fraccion_capital01 = ((1+ln_intereses/100)^ln_cuotas)*(ln_intereses/100)
ln_fraccion_capital02 = ((1+ln_intereses/100)^ln_cuotas) - 1
ln_fraccion_capital_saldo = round((ln_fraccion_capital01/ln_fraccion_capital02)*ln_saldoafinanciar,8) 
ln_fraccion_capital = ROUND((ln_fraccion_capital01/ln_fraccion_capital02),8)


?ln_intereses 
?ln_fraccion_capital_saldo
?ln_fraccion_capital
ln_pago_por_cuota =   ln_intereses + ln_fraccion_capital_saldo
?ln_pago_por_cuota

    