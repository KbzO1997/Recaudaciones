
--PAGOS VEN
--select sum(ts_saldo + ts_monto + ts_valor + ts_contratado + ts_aporte_iess + ts_fonres_iess) TotalRecaudo_VEN, sum(ts_descuento_iess) TotalComision from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'VEN' and ts_tsfecha between '01/01/2023' and '02/06/2024'

--PAGOS IBK
--select sum(ts_saldo + ts_monto + ts_valor + ts_contratado + ts_aporte_iess + ts_fonres_iess) TotalRecaudo_IBK, sum(ts_descuento_iess) TotalComision from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'IBK' and ts_tsfecha between '01/01/2023' and '02/06/2024'

--PAGOS SAT
--select sum(ts_saldo + ts_monto + ts_valor + ts_contratado + ts_aporte_iess + ts_fonres_iess) TotalRecaudo_SAT, sum(ts_descuento_iess) TotalComision from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'SAT' and ts_tsfecha between '01/01/2023' and '02/06/2024'


select count(ts_secuencial) CantTrx,   sum(ts_ocasional + ts_contratado) TotalRecaudo_VEN  from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'VEN' and ts_tsfecha between '01/01/2023' and '02/06/2024' and ts_plazo != null

select count(ts_secuencial) CantTrx,   sum(ts_ocasional + ts_contratado) TotalRecaudo_IBK from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'IBK' and ts_tsfecha between '01/01/2023' and '02/06/2024' and ts_plazo != null

select count(ts_secuencial) CantTrx,   sum(ts_ocasional + ts_contratado) TotalRecaudo_SAT from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = 3611 and ts_causa = null and ts_tipo_chequera = 'SAT' and ts_tsfecha between '01/01/2023' and '02/06/2024' and ts_plazo != null



