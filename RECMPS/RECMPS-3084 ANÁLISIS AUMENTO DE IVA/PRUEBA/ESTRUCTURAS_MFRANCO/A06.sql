SELECT * from cob_super..cc_detalle_a06
where cd_fecha_corte = '12/13/2023' and cd_canal = 'I' and cd_tipo_servicio = 'TA01610000'


delete from cob_ahorros_acum..ah_his_mov_a06
delete cob_super..cc_detalle_a06 

update cobis..cl_parametro
set pa_datetime = '03/20/2024'
where pa_nemonico = 'FCA06'

delete from cob_cuentas_his..cc_his_movimiento
where hm_fecha = '12/13/2023'
go
delete from cob_ahorros_his..ah_his_movimiento
where hm_fecha = '12/13/2023'
go
delete from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = '12/13/2023'
go
delete from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = '12/13/2023'
go


declare @fecha datetime
set @fecha = '03/21/2024' 

---PASO MONETARIA CORRIENTE A LA HISTORICA
insert into cob_cuentas_his..cc_his_movimiento
select tm_fecha,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_fecha_ult_mov,tm_oficina_pago,tm_cta_banco,tm_cheque,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_tipo,tm_signo,tm_indicador,tm_causa,tm_departamento,tm_ctabanco_dep,tm_prod_dep,tm_l24h,tm_remesas,tm_contratado,tm_ocasional,tm_saldo_contable,tm_saldo_disponible,tm_banco,tm_ctadestino,tm_tipo_xfer,tm_tasa_interes,tm_tasa_impuesto,tm_tasa_solca,tm_tasa_comision,tm_valor_interes,tm_valor_impuesto,tm_valor_solca,tm_valor_comision,tm_tarjeta_atm,tm_hora,tm_beneficiario,tm_oficina_cta,tm_tsn,0,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos,tm_ubicacion,tm_canal
from cob_cuentas..cc_tran_monet
where tm_fecha = @fecha


--PASO MONETARIO AHORRO A LA HISTORICA
insert into cob_ahorros_his..ah_his_movimiento
select tm_cta_banco,tm_fecha,0,             tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_signo,tm_fecha_ult_mov,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_indicador,tm_causa,tm_departamento,tm_saldo_lib,tm_saldo_contable,tm_saldo_disponible,tm_saldo_interes,tm_fecha_efec,tm_interes,tm_control,tm_ctadestino,tm_tipo_xfer,tm_valor_comision,tm_hora,tm_tarjeta,tm_oficina_cta,tm_tsn,tm_cheque,tm_val_cheque,tm_banco,tm_valor_impuesto,tm_rol,tm_ubicacion,tm_canal
from cob_ahorros..ah_tran_monet
where tm_fecha = @fecha

--PASO TABLA DE SERVICIOS A LA HISTORICA
insert into cob_cuentas_his..cc_his_servicio 
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = @fecha

--PASO TABLA DE SERVICIOS A LA DE RESPALDO
insert into cob_cuentas..cc_tran_servicio_resp
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = @fecha


select count(1) from cob_cuentas_his..cc_his_movimiento
where hm_fecha = @fecha
go
select count(1) from cob_ahorros_his..ah_his_movimiento
where hm_fecha = @fecha
go
select count(1) from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = @fecha
go
select count(1) from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = @fecha
go


cd /fuentes/cobis/cuentas/ctacte/batch/fuentes
operadorRec
ClvOpeRec++1
sqr cccrea06_TEST.sqr  -debug
do ParamS '12/08/2023'	--Fecha solicitada mm/dd/aaaa
do ParamN 1
do ParamS N


sqr -debug -Mvar cccrea06_TEST.sqr operadorRec/Ope+1234Rec
sqr -debug -Mvar cccrea06_TEST.sqr operadorRec/ClvOpeRec++1

--REALIZAR DELETE
--delete from cob_ahorros_acum..ah_his_mov_a06
--delete cob_super..cc_detalle_a06
/respaldo/archivos/cuentas/data/

--JONATHAN LO HIZO POR PARTES D HAY Cargo-Dólares sin IVA ES POR QUE ESTABA QUEMADO