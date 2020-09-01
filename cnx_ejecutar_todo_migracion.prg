
CLEAR
?'INICIANDO......'
lcruta = ADDBS(FULLPATH(CURDIR()))
*!*	DO &lcruta.cnx_migracion_mespacios.prg

*!*	DO &lcruta.cnx_migracion_mespacios_niveles.prg
*!*	DO &lcruta.cnx_migracion_mespacios_niveles_update_contrato.prg
DO &lcruta.cnx_migracion_mfalle.prg
DO &lcruta.cnx_migracion_mnicho.prg
DO &lcruta.cnx_migracion_mpersonas.prg
DO &lcruta.cnx_migracion_pabellones_nichos.prg
DO &lcruta.cnx_migracion_precios.prg

DO &lcruta.cnx_migracion_prnein.prg
DO &lcruta.cnx_migracion_snein.prg
DO &lcruta.cnx_migracion_tzonas.prg

DO &lcruta.cnx_migracion_mnein.prg
DO &lcruta.cnx_migracion_kpagos.prg
DO &lcruta.cnx_migracion_pgnein.prg
DO &lcruta.cnx_get_contratos_para_marcar_si_tiene_cronograma.prg
DO &lcruta.cnx_get_contratos_para_eliminar.prg
DO &lcruta.cnx_get_contratos_para_eliminar_ampliacion.prg
DO &lcruta.cnx_limpiar_contratos_tmp.prg







?'SE TERMINO TODO......'


