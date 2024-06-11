/************************************************************************/
/*	Archivo: 		ahtotmpr.sp			        */
/*	Stored procedure: 	pa_aho_btotmon_proc_jg			*/
/*	Base de datos:  	cob_ahorros  				*/
/*	Producto:               Ahorros                 		*/
/*	Disenado por:           Sipecom                            	*/
/*	Fecha de escritura:     25-sep-2020   				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*   Este programa es parte de los paquetes bancarios propiedad del     */
/*   "BANCO BOLIVARIANO".                                               */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus usuarios   */
/*   sin el debido consentimiento por escrito de la Presidencia         */
/*   Ejecutiva del BANCO BOLIVARIANO o su representante.                */
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Inserta el header de comprobante en la tabla temporal  		*/
/*      de Perfiles Contables (cuentas de ahorros)                      */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/* 22  24/Sep/2020   C.Vera Sipecom    Tunning - Transformar SQR ==> SP */
/*                                     Tarea:   CTE-CC-SGC00039533      */
/* 23  05/Ene/2021   R. Alvarez Sipecom    Ajuste cotizacion compra     */
/*				Tarea:   CTE-CC-SGC00040520		*/
/************************************************************************/

-- cambiar tm_secuencial 107200521 

use cob_ahorros
go

if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_monet_conta')
          drop table db_general..aho_tmp_monet_conta

if exists (select 1 from sysobjects where name = 'pa_aho_btotmon_proc_jg' and type = 'P')
	drop procedure dbo.pa_aho_btotmon_proc_jg
	if exists (select 1 from sysobjects where name = 'pa_aho_btotmon_proc_jg' and type = 'P')
		PRINT '<<< DROP PROCEDURE pa_aho_btotmon_proc_jg -- ERROR-- >>>'
	else
		PRINT '== DROP PROCEDURE pa_aho_btotmon_proc_jg *OK* =='
go

create procedure dbo.pa_aho_btotmon_proc_jg (
@e_filial			tinyint,
@e_fecha_proceso	smalldatetime, /* formato MM/DD/YYYY*/
@s_procesadas		int out
)
as
declare
	@v_moneda_base		tinyint,
	@v_return			int

/************************************************/
/*  Inicio_Valida  */
/************************************************/

begin tran

delete cob_cuentas..cc_control_contabilidad
where cc_fecha = @e_fecha_proceso
  and cc_producto = 4
  and cc_transaccion = 'M'
if @@error <> 0
begin
	rollback tran
	print 'ERROR EN DELETE cob_cuentas..cc_control_contabilidad (AHO-M)'
	return 1
end

insert into cob_cuentas..cc_control_contabilidad (cc_fecha, cc_producto, cc_transaccion, cc_estado, cc_hora_inicio, cc_hora_fin)
  values (@e_fecha_proceso, 4, 'M', 'E', getdate(), null)
if @@error <> 0
begin
	rollback tran
	print 'ERROR EN INSERT cob_cuentas..cc_control_contabilidad (AHO-M)'
	return 2
end

commit tran


/************************************************/
/*  Inicializaciones (parte 1-a)  */
/************************************************/

select @v_moneda_base = em_moneda_base
from    cob_conta..cb_empresa
where   em_empresa = 1

if @@rowcount = 0
begin
  print 'MONEDA BASE NO DEFINIDA (AHO-M)'
  return 3
end


/************************************************/
/*  Carga_Datos  */
/************************************************/

if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_monet_conta')
          drop table db_general..aho_tmp_monet_conta

select 
	ti_moneda = tm_moneda,
	ti_ofic_orig = tm_oficina,
	ti_ofic_dest = tm_oficina_cta,
	ti_tipo_tran = tm_tipo_tran,
	ti_causa = tm_causa,
	ti_valor =
				case
					when tc_contabiliza = 'VTR'		then isnull(tm_valor, 0)
					when tc_contabiliza = 'VCH'		then isnull(tm_chq_locales, 0)
					when tc_contabiliza = 'COM'		then isnull(tm_valor_comision, 0)
					when tc_contabiliza = 'INT'		then isnull(tm_saldo_interes, 0)
					when tc_contabiliza = 'TDE'		then (isnull(tm_valor, 0) + isnull(tm_chq_locales, 0))
					when tc_contabiliza = 'VCO'		then (isnull(tm_valor, 0) - isnull(tm_valor_comision, 0))
					when tc_contabiliza = 'VIN'		then (isnull(tm_valor, 0) - isnull(tm_saldo_interes, 0))
					when tc_contabiliza = 'CCO'		then (isnull(tm_chq_locales, 0) + isnull(tm_valor_comision, 0))
					when tc_contabiliza = 'EFE' and substring(isnull(tm_canal,''),1,3) <> 'CNB'
													then isnull(tm_efectivo, 0)
					when tc_contabiliza = 'EFECNB' and substring(isnull(tm_canal,''),1,3) = 'CNB'
													then isnull(tm_efectivo, 0)
					when tc_contabiliza = 'SAL'		then isnull(tm_saldo_lib, 0)
					when tc_contabiliza = 'SAC'		then isnull(tm_saldo_contable, 0)
					when tc_contabiliza = 'SAD'		then isnull(tm_saldo_disponible, 0)
					when tc_contabiliza = 'IN2'		then isnull(tm_interes, 0)
					when tc_contabiliza = 'MCH'		then isnull(tm_val_cheque, 0)
					when tc_contabiliza = 'IMP'		then isnull(tm_valor_impuesto, 0)
					when tc_contabiliza = 'CAP'		then (isnull(tm_valor, 0) + isnull(tm_valor_impuesto, 0))
					when tc_contabiliza = 'VCC'		then (isnull(tm_chq_locales, 0) + isnull(tm_valor_impuesto, 0) - (isnull(tm_efectivo, 0) - isnull(tm_valor, 0)))
					else 0
				end * case tm_correccion when 'S' then -1 else 1 end,
	ti_contar = 1 * case tm_correccion when 'S' then -1 else 1 end,
	ti_tarjeta = isnull(tm_tarjeta,'1.0'),
	tc_causa_dst, 
	tc_causa_org,
	tc_perfil,
	tc_estado,
	ti_cotiza = isnull(convert(varchar,mt_cotiza),'1.0'),
	ti_cotizcompra = isnull(
							case
								-- when (tm_cod_alterno is null) then
								-- 	convert(float, 0)
								when ((tm_moneda <> @v_moneda_base) and (isnull(tm_tarjeta,'1.0') = '1.0')) then
									(case
										when (isnull(convert(varchar,mt_cotiza), '1.0') = '1.0') then
											null
										else
											convert(float, isnull(convert(varchar,mt_cotiza), '1.0'))
									end)
								else
									(case
										when (((tm_tipo_tran = 4272 and tm_causa in('333', '424', '515', '940', '959', '516' ))
												or (tm_tipo_tran = 4253 and tm_causa = '32')) and (tm_moneda <> @v_moneda_base)) then
											(case
												when (isnull(convert(varchar,mt_cotiza), '1.0') = '1.0') then
													null
												else
													convert(float, isnull(convert(varchar,mt_cotiza), '1.0'))
											end)
										else
											(case
												when ((isnumeric(isnull(str_replace( str_replace( tm_tarjeta,'E','x') ,'e','x'), '1.0')) = 1) and char_length(tm_tarjeta) < 15 --error isnumeric with 'e' -> Sybase bug
														and (convert(money, isnull(tm_tarjeta, '1.0')) = 0 or convert(money, isnull(tm_tarjeta, '1.0')) > 100)) then
													null
												else
													case
														when (isnumeric(isnull(str_replace( str_replace( tm_tarjeta,'E','x') ,'e','x'), '1.0')) = 1) and char_length(tm_tarjeta) < 15 then
															convert(money, isnull(tm_tarjeta, '1.0'))
														else
															null
													end
											end)
									end)
							end,
						isnull( (select case when isnumeric(c.ct_compra) = 1 then isnull(c.ct_compra,1) else 1 end
								from cob_conta..cb_cotizacion c
								where c.ct_fecha = @e_fecha_proceso
									and c.ct_moneda = m.tm_moneda), convert(float, 0))
						)
into db_general..aho_tmp_monet_conta lock datarows
from cob_ahorros..ah_tran_monet m
	inner join cob_remesas..re_tran_contable (index index1)
		on		tm_tipo_tran = tc_tipo_tran
			and	tc_causa_org in (isnull(tm_causa,'0'),'0')
	left outer join cob_cuentas..cc_monet_transfer --(index cc_monet_transfer_sec) -- SIP:antes en produccion
		on		tm_fecha = mt_fecha
			and	tm_secuencial = mt_ssn_monet
			and	tm_tipo_tran  = mt_tipo_tran
			and	tm_causa = mt_causa
where tc_estado		= 'V'
	and tm_tipo_tran  not in (select convert (smallint, codigo)
								from cobis..cl_catalogo
								where tabla = (select codigo
												from cobis..cl_tabla
												where tabla = 'tr_mon_no_cont_ah')
								and estado = 'V')
	and tm_fecha = @e_fecha_proceso
	--and tm_usuario in  ('crodrigm','ralavaz')
    and tm_secuencial  in  (55134286,95197242,95198552,95197980,95198305)

if @@error <> 0
begin
	print 'ERROR EN INSERT PRINCIPAL PARA db_general..aho_tmp_monet_conta (AHO-M)'
	return 4
end

/************************************************/
/*  Main  */
/************************************************/


/*  >>>>>>>  TrxEuros  <<<<<<<  */

update cob_ahorros..ah_tran_monet
	set tm_tarjeta = null
where	tm_tipo_tran = 4272
	and tm_moneda = 17
	and tm_causa = '515'

if @@error <> 0
begin
	print 'ERROR EN UPDATE PARA cob_ahorros..ah_tran_monet (AHO-M)'
	return 5
end


/*  >>>>>>>  Inicializaciones (parte 1-b)  <<<<<<<  */

delete cob_remesas..re_total_ah
where to_producto = 4
  and to_tipo = 'M'
if @@error <> 0
begin
	print 'ERROR EN DELETE PARA cob_remesas..re_total_ah (AHO-M)'
	return 6
end


/*  >>>>>>>  Transacciones  <<<<<<<  */

dump tran db_general with truncate_only

exec @v_return = cob_ahorros..pa_aho_btotmon_sub_proc
					@e_filial			= @e_filial,
					@e_fecha_proceso	= @e_fecha_proceso,
					@e_moneda_base		= @v_moneda_base,
					@s_procesadas		= @s_procesadas out
if @@error <> 0
begin
	print 'ERROR EN cob_ahorros..pa_aho_btotmon_sub_proc (AHO-M)'
	return 7
end
else if @v_return <> 0
	begin
		return @v_return
	end


/************************************************/
/*  Fin_Valida  */
/************************************************/

update cob_cuentas..cc_control_contabilidad
set cc_estado = 'F',
    cc_hora_fin = getdate()
where cc_fecha = @e_fecha_proceso
  and cc_producto = 4
  and cc_transaccion = 'M'

if @@error <> 0
begin
	print 'ERROR EN UPDATE cob_cuentas..cc_control_contabilidad (AHO-M)'
	return 8
end

/************************************************/

return 0
go

if exists (select 1 from sysobjects where name = 'pa_aho_btotmon_proc_jg' and type = 'P')
	PRINT '== CREATE PROCEDURE pa_aho_btotmon_proc_jg *OK* =='
else
	PRINT '<<< CREATE PROCEDURE pa_aho_btotmon_proc_jg -- ERROR-- >>>'
go
