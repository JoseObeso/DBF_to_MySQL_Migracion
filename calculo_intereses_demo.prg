* calculo de intereses
CLEAR
SET DECIMALS TO 2

ln_saldoafinanciar =9500
ln_tea = 8
ln_cuotas = 12

ln_intereses = (((1+ln_tea/100))^(30/360)-1)*100
ln_monto_interes = ln_intereses *ln_saldoafinanciar/100
ln_fraccion_capital01 = ((1+ln_intereses/100)^ln_cuotas)*(ln_intereses/100)
ln_fraccion_capital02 = ((1+ln_intereses/100)^ln_cuotas) - 1
ln_fraccion_capital_saldo = round((ln_fraccion_capital01/ln_fraccion_capital02)*ln_saldoafinanciar,8) 
ln_fraccion_capital = ROUND((ln_fraccion_capital01/ln_fraccion_capital02),8)
ln_capital = ln_fraccion_capital_saldo - ln_monto_interes
ln_nuevo_saldo = ln_saldoafinanciar - ln_capital
?'Saldo a financiar'
?ln_saldoafinanciar
?'interes'
?ln_monto_interes
?'capital'
?ln_capital
?'pago_cuota'
?ln_fraccion_capital_saldo
?'Nuevo saldo'
?ln_nuevo_saldo
    
