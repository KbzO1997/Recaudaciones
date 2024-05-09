delete cob_super..cc_detalle_a06 where cd_fecha_corte='05/15/2023'
select cd_canal,cd_numero_trans,cd_tarifa, * from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
and cd_tipo_servicio = 'TA01610000'
and cd_canal='O'


--24online--55969916,55887919
--sat--56260689,56342859
--24movil-55992159,55937083
--Ventanilla --134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293
--todos--134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083

134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,55992159,55937083

PROCEDIMIENTO DE ESTRUCTURAS DE A06

Se debe actualizar el parómetro FCA06 con la fecha de un dóa antes a la solicitada. Por ejemplo, si solicitan generar el A06 del 7 de mayo, se debe actualizar el parómetro con fecha 6 de mayo.

update cobis..cl_parametro
set pa_datetime = '05/14/2023'   	---fecha de un dóa antes a la solicitada. mm/dd/aaaa
where pa_nemonico = 'FCA06'	

Con este select confirmas el cambio de fecha del update
select convert(varchar, dateadd(dd, 1, pa_datetime), 101)
from cobis..cl_parametro
where pa_nemonico = 'FCA06'

Verificar y eliminar información de históricos.

Antes de actualizar los históricos se debe verificar si la información a pasar ya existe en los históricos o no.

select count(1) from cob_cuentas_his..cc_his_movimiento
where hm_fecha = '05/15/2023'
go
select count(1) from cob_ahorros_his..ah_his_movimiento
where hm_fecha = '05/15/2023'
go
select count(1) from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = '05/15/2023'
go
select count(1) from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = '05/15/2023'
go

En caso de que exista información en alguna de las tablas se la debe eliminar.

delete from cob_cuentas_his..cc_his_movimiento
where hm_fecha = '05/15/2023'
go
delete from cob_ahorros_his..ah_his_movimiento
where hm_fecha = '05/15/2023'
go
delete from cob_cuentas_his..cc_his_servicio 
where hs_tsfecha = '05/15/2023'
go
delete from cob_cuentas..cc_tran_servicio_resp
where ts_tsfecha = '05/15/2023'
go

Actualizar los históricos de monetarios y servicios de las fechas a procesar
---PASO MONETARIA CORRIENTE A LA HISTORICA
insert into cob_cuentas_his..cc_his_movimiento
select tm_fecha,tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_fecha_ult_mov,tm_oficina_pago,tm_cta_banco,tm_cheque,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_tipo,tm_signo,tm_indicador,tm_causa,tm_departamento,tm_ctabanco_dep,tm_prod_dep,tm_l24h,tm_remesas,tm_contratado,tm_ocasional,tm_saldo_contable,tm_saldo_disponible,tm_banco,tm_ctadestino,tm_tipo_xfer,tm_tasa_interes,tm_tasa_impuesto,tm_tasa_solca,tm_tasa_comision,tm_valor_interes,tm_valor_impuesto,tm_valor_solca,tm_valor_comision,tm_tarjeta_atm,tm_hora,tm_beneficiario,tm_oficina_cta,tm_tsn,0,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos,tm_ubicacion,tm_canal
from cob_cuentas..cc_tran_monet
where tm_fecha = '05/15/2023'
and tm_tsn in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)
	
--PASO MONETARIO AHORRO A LA HISTORICA
insert into cob_ahorros_his..ah_his_movimiento
select tm_cta_banco,tm_fecha,0,             tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_filial,tm_oficina,tm_usuario,tm_terminal,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,tm_signo,tm_fecha_ult_mov,tm_valor,tm_chq_propios,tm_chq_locales,tm_chq_ot_plazas,tm_remoto_ssn,tm_moneda,tm_efectivo,tm_indicador,tm_causa,tm_departamento,tm_saldo_lib,tm_saldo_contable,tm_saldo_disponible,tm_saldo_interes,tm_fecha_efec,tm_interes,tm_control,tm_ctadestino,tm_tipo_xfer,tm_valor_comision,tm_hora,tm_tarjeta,tm_oficina_cta,tm_tsn,tm_cheque,tm_val_cheque,tm_banco,tm_valor_impuesto,tm_rol,tm_ubicacion,tm_canal
from cob_ahorros..ah_tran_monet
where tm_fecha = '05/15/2023'
and tm_tsn in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)

--PASO TABLA DE SERVICIOS A LA HISTORICA
insert into cob_cuentas_his..cc_his_servicio 
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = '05/15/2023'
and ts_secuencial in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)

--PASO TABLA DE SERVICIOS A LA DE RESPALDO
insert into cob_cuentas..cc_tran_servicio_resp
select * from cob_cuentas..cc_tran_servicio
where ts_tsfecha = '05/15/2023'
and ts_secuencial in (134717732,134717777,134717994,134718043,134718103,134718129,134718248,134718270,134718293,55969916,55887919,56260689,56342859,55992159,55937083)


Validar catalogo para envóo de correo.

Select * from cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cc_mails_a06'
and a.codigo = '01'
and a.estado = 'V'

De ser necesario se debe actualizar la cuenta de correo de quien va a recibir el archivo.

update cobis..cl_catalogo
set valor = 'FCRODRIGUEZ@BOLIVARIANO.COM'
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.tabla = b.codigo
and b.tabla = 'cc_mails_a06'
and a.codigo = '01'
and a.estado = 'V'


Cuando la información corresponda al SAT, se debe ejecutar primero el sqr bpinfa06.sqr

cd /fuentes/aplicaciones/sat/pagos/batch/fuentes

sqr bpinfa06.sqr  -debug operadorRec/Ope+1234Rec
sqr bpinfa06.sqr -debug operadorRec/ClvOpeRec++1
do ParamS (1,$i_fecha_fin,'','','')	'07/13/2021'	--Fecha solicitada mm/dd/aaaa
do ParamS (2,$i_reproceso,'','','')	N


Ejecutar sqr para generar el A06

cd /fuentes/cobis/cuentas/ctacte/batch/fuentes

sqr cccrea06_TEST.sqr  -debug operadorRec/ClvOpeRec++1
do ParamS (1,$i_fecha_fin,'','','')	'07/13/2021'	--Fecha solicitada mm/dd/aaaa
do ParamN (2,#i_producto,'','','') 	1
do ParamS (3,$i_reproceso,'','','')	N

El archivo Excel es enviado por correo a la cuenta que se encuentra parametrizada en el católogo cc_mails_a06.  
Adicionalmente el archivo se genera en la ruta /respaldo/archivos/cuentas/data/



update cobis..cl_parametro
set pa_datetime = '05/14/2023'
where pa_nemonico = 'FCA06'

select * from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
and cd_tipo_servicio = 'TA01610000'
and cd_canal='O'


delete from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
delete from cob_ahorros_acum..ah_his_mov_a06
