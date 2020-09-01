    ld_fecha_inicio = DATE(2019,6,1)
   * lc_fecha_final = DTOC(GOMONTH((DATE(ln_anio_inicio,ln_mes_inicio,ln_cuotas)),1)-1)
    
    ln_cuotas = 12
    ln_mes_inicio = 6
    ln_anio_inicio = 2019
    ld_fecha_inicio = DATE(ln_anio_inicio,ln_mes_inicio,1)
    
    lc_fecha_final = DTOC(GOMONTH(ld_fecha_inicio,ln_cuotas))
    
    ?lc_fecha_final

