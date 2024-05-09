delete cob_super..cc_detalle_a06 where cd_fecha_corte='06/19/2023'

update cobis..cl_parametro
set pa_datetime = '05/14/2023'       ---fecha de un dia antes a la solicitada. mm/dd/aaaa
where pa_nemonico = 'FCA06'

select count(1) from cob_cuentas_his..cc_his_movimiento
where hm_fecha = '06/19/2023'
go
select count(1) from cob_ahorros_his..ah_his_movimiento
where hm_fecha = '06/19/2023'
go
select count(1) from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = '06/19/2023'
go
select count(1) from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = '06/19/2023'
go


delete from cob_cuentas_his..cc_his_movimiento
where hm_fecha = '06/19/2023'
go
delete from cob_ahorros_his..ah_his_movimiento
where hm_fecha = '06/19/2023'
go
delete from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = '06/19/2023'
go
delete from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = '06/19/2023'
go

Actualizar los históricos de monetarios y servicios de las fechas a procesar
---PASO MONETARIA CORRIENTE A LA HISTORICA
insert into cob_cuentas_his..cc_his_movimiento
select tm_fecha,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_fecha_ult_mov,tm_oficina_pago,tm_cta_banco,tm_cheque,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_tipo,tm_signo,tm_indicador,tm_causa,tm_departamento,tm_ctabanco_dep,tm_prod_dep,tm_l24h,tm_remesas,tm_contratado,tm_ocasional,tm_saldo_contable,tm_saldo_disponible,tm_banco,tm_ctadestino,tm_tipo_xfer,tm_tasa_interes,tm_tasa_impuesto,tm_tasa_solca,tm_tasa_comision,tm_valor_interes,tm_valor_impuesto,tm_valor_solca,tm_valor_comision,tm_tarjeta_atm,tm_hora,tm_beneficiario,tm_oficina_cta,tm_tsn,0,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos,tm_ubicacion,tm_canal
from cob_cuentas..cc_tran_monet
where tm_fecha = '06/19/2023'
and tm_secuencial in (521542492,551003210,1184443423,2085853600,1372303501,1350410119,1755782892,1321796413,1284711696,933987627,1966891289,768540382,2050060400)

--PASO MONETARIO AHORRO A LA HISTORICA
insert into cob_ahorros_his..ah_his_movimiento
select tm_cta_banco,tm_fecha,0,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_signo,tm_fecha_ult_mov,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_indicador,tm_causa,tm_departamento,tm_saldo_lib,tm_saldo_contable,tm_saldo_disponible,tm_saldo_interes,tm_fecha_efec,tm_interes,tm_control,tm_ctadestino,tm_tipo_xfer,tm_valor_comision,tm_hora,tm_tarjeta,tm_oficina_cta,tm_tsn,tm_cheque,tm_val_cheque,tm_banco,tm_valor_impuesto,tm_rol,tm_ubicacion,tm_canal
from cob_ahorros..ah_tran_monet
where tm_fecha = '06/19/2023'
and tm_secuencial in (521542492,551003210,1184443423,2085853600,1372303501,1350410119,1755782892,1321796413,1284711696,933987627,1966891289,768540382,2050060400)

--PASO TABLA DE SERVICIOS A LA HISTORICA
insert into cob_cuentas_his..cc_his_servicio 
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = '06/19/2023'
and ts_secuencial in (135779001,135779049,135779097,135779111,135779150,135779223,135779254,135779304,135779550,135779747)

--PASO TABLA DE SERVICIOS A LA DE RESPALDO
insert into cob_cuentas..cc_tran_servicio_resp
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = '06/19/2023'
and ts_secuencial in (135779001,135779049,135779097,135779111,135779150,135779223,135779254,135779304,135779550,135779747)


update cobis..cl_catalogo
set valor = 'KBASTIDZ@BOLIVARIANO.COM'
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cc_mails_a06'
and a.codigo = '01'
and a.estado = 'V'


cd /fuentes/cobis/cuentas/ctacte/batch/fuentes
sqr cccrea06_TEST.sqr  -debug operadorRec/Ope+1234Rec
do ParamS (1,$i_fecha_fin,'','','')    '06/19/2023'    --Fecha solicitada mm/dd/aaaa
do ParamN (2,#i_producto,'','','')     1
do ParamS (3,$i_reproceso,'','','')    N

El archivo Excel es enviado por correo a la cuenta que se encuentra parametrizada en el catalogo cc_mails_a06.  
Adicionalmente el archivo se genera en la ruta /respaldo/archivos/cuentas/data/




cd_producto cd_fecha_corte              cd_canal cd_tipo_servicio cd_tipo_producto cd_descripcion                                                                                       cd_tipo_tarjeta cd_clase_tarjeta cd_tipo_tarifa cd_tipo_cliente cd_numero_trans cd_tarifa                cd_ingreso_total         cd_tasa_ponderada          cd_cta_contable      cd_prop_canal cd_cod_provincia cd_cod_canton cd_cargo_porcentaje        cd_monto_base              cd_ingreso_neto            cd_base_imponible          cd_iva_pagado              
----------- --------------------------- -------- ---------------- ---------------- ---------------------------------------------------------------------------------------------------- --------------- ---------------- -------------- --------------- --------------- ------------------------ ------------------------ -------------------------- -------------------- ------------- ---------------- ------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- 
3           Jun 19 2023 12:00AM         O        TA01610000                        Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             0               0.0                      0.0                      (null)                     540608                                                            0.00                       0.00                       0.00                       0.00                       0.00                       
3           Jun 19 2023 12:00AM         O        TA01610000                        Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             8               0.51                     4.29                     (null)                     540608               P             09               01            0.00                       0.00                       4.29                       4.29                       0.51                       
