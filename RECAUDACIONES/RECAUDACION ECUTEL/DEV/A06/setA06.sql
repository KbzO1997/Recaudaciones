update cobis..cl_parametro
set pa_datetime = '05/14/2023'
where pa_nemonico = 'FCA06'

select * from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
and cd_tipo_servicio = 'TA01610000'
and cd_canal='O'

select * from cob_ahorros_acum..ah_his_mov_a06

--delete from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
--delete from cob_ahorros_acum..ah_his_mov_a06

select * from cob_super..cc_a06_causa where ac_canal = 'O' and ac_causaÿ = '645'
cob_super..cc_a06_causa where ac_canal = 'O' and ac_causaÿ = '645'

select * from cob_super..cc_a06_causa where ac_canal = 'O' and ac_causa = '645'

--delete from cob_super..cc_a06_causa where ac_canal = 'O' and ac_causa = '645'


select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = '05/15/2023'
and ts_secuencial in (134717732,134717994,134718043)

select * from cob_cuentas_his..cc_his_servicio 
where hs_secuencial in(134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)
and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','WAP', 'SROLESE')

3           May 15 2023 12:00AM         O        TA01610000       CC0001           Recaudaciones de pagos a terceros, a excepcion de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA             T               2               0.51                     1.02                     0.26                                            P             09               01            0.00                       1.02                       0.00                       1.02                       0.12                       
4           May 15 2023 12:00AM         O        TA01610000       CA0001           Recaudaciones de pagos a terceros, a excepcion de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA             T               1               0.51                     0.51                     0.51                                            P             09               01            0.00                       0.51                       0.00                       0.51                       0.06                       




cob_super..sp_helptext sp_selecciona_a06, null, null, showsql
cob_super..sp_helptext sp_inserta_cte_a06_ofi, null, null, showsql
cob_super..sp_helptext sp_inserta_aho_a06_ofi, null, null, showsql

cob_super..sp_helptext sp_procesos_manuales_a06, null, null, showsql


select hs_causa,hs_tipocta, * from cob_cuentas_his..cc_his_servicio where hs_secuencial in(134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293)
and hs_clase = 'C' and hs_correccion = 'N'



select tm_fecha,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_fecha_ult_mov,tm_oficina_pago,tm_cta_banco,tm_cheque,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_tipo,tm_signo,tm_indicador,tm_causa,tm_departamento,tm_ctabanco_dep,tm_prod_dep,tm_l24h,tm_remesas,tm_contratado,tm_ocasional,tm_saldo_contable,tm_saldo_disponible,tm_banco,tm_ctadestino,tm_tipo_xfer,tm_tasa_interes,tm_tasa_impuesto,tm_tasa_solca,tm_tasa_comision,tm_valor_interes,tm_valor_impuesto,tm_valor_solca,tm_valor_comision,tm_tarjeta_atm,tm_hora,tm_beneficiario,tm_oficina_cta,tm_tsn,0,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos,tm_ubicacion,tm_canal
from cob_cuentas..cc_tran_monet
where tm_fecha = '05/15/2023'
and tm_tsn in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)
	
select tm_fecha,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_fecha_ult_mov,tm_oficina_pago,tm_cta_banco,tm_cheque,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_tipo,tm_signo,tm_indicador,tm_causa,tm_departamento,tm_ctabanco_dep,tm_prod_dep,tm_l24h,tm_remesas,tm_contratado,tm_ocasional,tm_saldo_contable,tm_saldo_disponible,tm_banco,tm_ctadestino,tm_tipo_xfer,tm_tasa_interes,tm_tasa_impuesto,tm_tasa_solca,tm_tasa_comision,tm_valor_interes,tm_valor_impuesto,tm_valor_solca,tm_valor_comision,tm_tarjeta_atm,tm_hora,tm_beneficiario,tm_oficina_cta,tm_tsn,0,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos,tm_ubicacion,tm_canal
from cob_ahorros..ah_tran_monet
where tm_fecha = '05/15/2023'
and tm_tsn in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)