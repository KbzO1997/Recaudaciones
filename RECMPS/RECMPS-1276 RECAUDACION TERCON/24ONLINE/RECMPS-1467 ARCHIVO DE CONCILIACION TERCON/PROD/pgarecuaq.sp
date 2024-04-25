/************************************************************************/
/*    Archivo           : pgarecuaq.sp                                  */
/*    Stored procedure  : pa_pag_g_archivo_resp_ecuaq                   */
/*    Base de datos     : cob_pagos                                     */
/*    Producto          : Cuentas de pagos                              */
/*    Disenado por      : Danny Olaya                                   */
/*    Fecha de escritura: 23/Mayo/2018                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*    Este programa es parte de los paquetes bancarios propiedad del    */
/*    "BANCO BOLIVARIANO".                                              */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus usuarios  */
/*    sin el debido consentimiento por escrito de la Presidencia        */
/*    Ejecutiva del BANCO BOLIVARIANO o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/* Consulta informacion para generar archivo de respuesta para ECUAQUIMICA */
/************************************************************************/
/*     FECHA           AUTOR           RAZON                            */
/*1    07/Jun/2018     Danny Olaya S.  DEPONL-AP-SGC00031612-SGC00032076*/
/*2    12/Jul/2019     Daniel Pereira  RECMPS-21 Recaudacion MSC        */
/*3    26/Sep/2019     Daniel Pereira  RECMPS-58  MSC - Canal SAT       */
/*4    29/Oct/2021     Jonathan Guerrero RECMPS-1035 Recaudacion Equifax*/
/*5    08/Mar/2022     Kevin Bastidas RECMPS-1467 ARCHIVO DE CONCILIACION TERCON*/
/************************************************************************/

use cob_pagos
go 

if exists (select 1 from dbo.sysobjects where name = 'pa_pag_g_archivo_resp_ecuaq' and type = 'P')
begin
	drop procedure dbo.pa_pag_g_archivo_resp_ecuaq
	if exists (select 1 from sysobjects where name = 'pa_pag_g_archivo_resp_ecuaq' and type = 'P')
		PRINT '<<< DROP PROCEDURE pa_pag_g_archivo_resp_ecuaq -- ERROR -- >>>'
	else
		PRINT '== DROP PROCEDURE pa_pag_g_archivo_resp_ecuaq *OK* =='
end
go



create proc dbo.pa_pag_g_archivo_resp_ecuaq (
@e_fecha_proceso        smalldatetime,
@e_empresa              varchar(6)    --ref 2
)

as 

if object_id('tempdb.dbo.#pg_tmp_reverso_ts') is not null
    drop table #pg_tmp_reverso_ts

if object_id('tempdb.dbo.#pg_tmp_reverso_hs') is not null
    drop table #pg_tmp_reverso_hs

	select isnull(rts.ts_ssn_corr,0) reverso
	into #pg_tmp_reverso_ts
	from cob_cuentas..cc_tran_servicio rts
	inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on rts.ts_tipo_transaccion = trx.tipo_trx 
	where ts_tsfecha  = @e_fecha_proceso
	and ts_causa=@e_empresa  
	and ts_correccion = 'S'

select p.TIPO_PROCESO, p.TIPO_IDENTIFICACION, p.IDENTIFICACION, p.REFERENCIA, p.REFERENCIA_AUX, p.MONEDA_PAGO,p.VALOR_PAGO, p.SECUENCIAL_PAGO,p.FECHA_PAGO,p.HORA_PAGO,p.CANAL_PROCESO, p.MODO_PROCESO, p.FORMA_PAGO	
from
(select 	
	case ts_correccion when 'N' then 1 else 2 end	 TIPO_PROCESO,
	case @e_empresa when '8459' then ts.ts_campo_alt_dos else isnull(ts_agente,'C')  end	 TIPO_IDENTIFICACION, --RECMPS-1467	
	case @e_empresa when '8459' then STR_REPLACE(ts.ts_nombre, ' ', '_') else "'"+isnull(ts_referencia,'')  end	 IDENTIFICACION,  --RECMPS-1467
	ts_campo_alt_uno								 REFERENCIA,   --ref 2
	"BOL" 											 REFERENCIA_AUX,
	"USD"   										 MONEDA_PAGO,
	round(isnull(ts_valor,0),2)                      VALOR_PAGO,
	ts_secuencial			   						 SECUENCIAL_PAGO,
    convert(varchar,ts_hora,103)                	 FECHA_PAGO,	
    convert(varchar,ts_hora,108)  					 HORA_PAGO,
	case substring(ts_tipo_chequera,1,3)
		when 'VEN' then 'VENBCO'
		when 'IBK' then 'WEBBCO'
		when 'SAT' then 'WEBBCO'
		when 'WAP' then 'MOVBCO'
		when 'CNB' then 'CNBBCO'
		when 'ATM' then 'ATMBCO'
		else 'BCOBCO'
	end CANAL_PROCESO,
	'ON' MODO_PROCESO,
	'EFECTIVO' FORMA_PAGO	
from cob_cuentas..cc_tran_servicio ts
left join #pg_tmp_reverso_ts  rt on  ts.ts_secuencial = rt.reverso 
inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on  ts.ts_tipo_transaccion = trx.tipo_trx 
where ts_causa = @e_empresa    
and ts_tsfecha = @e_fecha_proceso
and ts_correccion = 'N'
and ts_valor > 0
and rt.reverso is null

union all
select 	
	case ts_correccion when 'N' then 1 else 2 end	TIPO_PROCESO,
	case @e_empresa when '8459' then ts.ts_campo_alt_dos else isnull(ts_agente,'C')  end	 TIPO_IDENTIFICACION, --RECMPS-1467	
	case @e_empresa when '8459' then STR_REPLACE(ts.ts_nombre, ' ', '_') else "'"+isnull(ts_referencia,'')  end	 IDENTIFICACION, --RECMPS-1467
	ts_campo_alt_uno								REFERENCIA,  --ref 2
	"BOL" 											REFERENCIA_AUX,
	"USD"   										MONEDA_PAGO,
	round(isnull(ts_saldo,0),2)						VALOR_PAGO,
	ts_secuencial			   						SECUENCIAL_PAGO,
    convert(varchar,ts_hora,103)                	FECHA_PAGO,	
    convert(varchar,ts_hora,108)  					HORA_PAGO,
	case substring(ts_tipo_chequera,1,3)
		when 'VEN' then 'VENBCO'
		when 'IBK' then 'WEBBCO'
		when 'SAT' then 'WEBBCO'
		when 'WAP' then 'MOVBCO'
		when 'CNB' then 'CNBBCO'
		when 'ATM' then 'ATMBCO'
		else 'BCOBCO'	    
	end CANAL_PROCESO,
	'ON' MODO_PROCESO,
	'CHEQUE' FORMA_PAGO	
from cob_cuentas..cc_tran_servicio ts
left join #pg_tmp_reverso_ts rt on ts.ts_secuencial = rt.reverso 
inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on ts.ts_tipo_transaccion = trx.tipo_trx
where ts_causa = @e_empresa    
and ts_tsfecha = @e_fecha_proceso
and ts_correccion = 'N'
and ts_saldo > 0
and rt.reverso is null

union all
select 	
	case ts_correccion when 'N' then 1 else 2 end	TIPO_PROCESO,
	case @e_empresa when '8459' then ts.ts_campo_alt_dos else isnull(ts_agente,'C')  end	 TIPO_IDENTIFICACION, --KB RECMPS-1467	
	case @e_empresa when '8459' then STR_REPLACE(ts.ts_nombre, ' ', '_') else "'"+isnull(ts_referencia,'')  end	 IDENTIFICACION, --KB RECMPS-1467
	ts_campo_alt_uno								REFERENCIA,  --ref 2
	"BOL" 											REFERENCIA_AUX,
	"USD"   										MONEDA_PAGO,
	round(isnull(ts_monto,0),2)						VALOR_PAGO,
	ts_secuencial			   						SECUENCIAL_PAGO,
    convert(varchar,ts_hora,103)                	FECHA_PAGO,	
    convert(varchar,ts_hora,108)  					HORA_PAGO,
	case substring(ts_tipo_chequera,1,3)
		when 'VEN' then 'VENBCO'
		when 'IBK' then 'WEBBCO'
		when 'SAT' then 'WEBBCO'
		when 'WAP' then 'MOVBCO'
		when 'CNB' then 'CNBBCO'
		when 'ATM' then 'ATMBCO'
		else 'BCOBCO'		    
	end CANAL_PROCESO,
	'ON' MODO_PROCESO,
	'DEBITO' FORMA_PAGO	
from cob_cuentas..cc_tran_servicio ts
left join #pg_tmp_reverso_ts  rt on ts.ts_secuencial = rt.reverso 
inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V') trx on ts.ts_tipo_transaccion = trx.tipo_trx
where ts_causa = @e_empresa    
and ts_tsfecha = @e_fecha_proceso
and ts_correccion = 'N'
and ts_monto > 0
and rt.reverso is null
			
) p
order by p.SECUENCIAL_PAGO

if @@rowcount = 0
begin

	select isnull(hs_ssn_corr,0) reverso
	into #pg_tmp_reverso_hs
	from cob_cuentas_his..cc_his_servicio rhs
	inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on trx.tipo_trx = rhs.hs_tipo_transaccion
	where hs_tsfecha  = @e_fecha_proceso
	and hs_causa=@e_empresa  
	and hs_correccion = 'S'
					
	select p.TIPO_PROCESO, p.TIPO_IDENTIFICACION, p.IDENTIFICACION, p.REFERENCIA, p.REFERENCIA_AUX, p.MONEDA_PAGO,p.VALOR_PAGO, p.SECUENCIAL_PAGO,p.FECHA_PAGO,p.HORA_PAGO,p.CANAL_PROCESO, p.MODO_PROCESO, p.FORMA_PAGO	
	from (select 	
		case hs_correccion when 'N' then 1 else 2 end	 TIPO_PROCESO,		
		case @e_empresa when '8459' then hs_campo_alt_dos else hs_agente  end	 TIPO_IDENTIFICACION, --RECMPS-1467		
		case @e_empresa when '8459' then STR_REPLACE(hs_nombre, ' ', '_') else "'"+isnull(hs_referencia,'')  end	 IDENTIFICACION, --RECMPS-1467
		hs_campo_alt_uno					   			 REFERENCIA,  --ref 2
		'BOL'   										 REFERENCIA_AUX,
		'USD'   										 MONEDA_PAGO,
		round(isnull(hs_valor,0),2) 					 VALOR_PAGO,
		hs_secuencial			   						 SECUENCIAL_PAGO,
		convert(varchar,hs_hora,103)                	 FECHA_PAGO,	
		convert(varchar,hs_hora,108)  					 HORA_PAGO,
		case substring(hs_tipo_chequera,1,3)
			when 'VEN' then 'VENBCO'
			when 'IBK' then 'WEBBCO'
			when 'SAT' then 'WEBBCO'
			when 'WAP' then 'MOVBCO'
			when 'CNB' then 'CNBBCO'
			when 'ATM' then 'ATMBCO'
			else 'BCOBCO'		    
		end CANAL_PROCESO,
		'ON' MODO_PROCESO,
		'EFECTIVO' FORMA_PAGO
	from cob_cuentas_his..cc_his_servicio a
	left join #pg_tmp_reverso_hs rh on a.hs_secuencial = rh.reverso
	inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on a.hs_tipo_transaccion = trx.tipo_trx
	where hs_tsfecha  = @e_fecha_proceso
	and hs_causa=@e_empresa   --ref 2
	and hs_correccion = 'N'
	and (hs_valor > 0)
	and rh.reverso is null
	
	union all
	select 	
		case hs_correccion when 'N' then 1 else 2 end	TIPO_PROCESO,
		case @e_empresa when '8459' then hs_campo_alt_dos else hs_agente  end	 TIPO_IDENTIFICACION, --RECMPS-1467		
		case @e_empresa when '8459' then STR_REPLACE(hs_nombre, ' ', '_') else "'"+isnull(hs_referencia,'')  end	 IDENTIFICACION, --RECMPS-1467
		hs_campo_alt_uno					   			REFERENCIA,   --ref 2
		'BOL'   										REFERENCIA_AUX,
		'USD'   										MONEDA_PAGO,
		round(isnull(hs_saldo,0),2)						VALOR_PAGO,
		hs_secuencial			   						SECUENCIAL_PAGO,
		convert(varchar,hs_hora,103)                	FECHA_PAGO,	
		convert(varchar,hs_hora,108)  					HORA_PAGO,
		case substring(hs_tipo_chequera,1,3)
			when 'VEN' then 'VENBCO'
			when 'IBK' then 'WEBBCO'
			when 'SAT' then 'WEBBCO'
			when 'WAP' then 'MOVBCO'
			when 'CNB' then 'CNBBCO'
			when 'ATM' then 'ATMBCO'
			else 'BCOBCO'	    
		end CANAL_PROCESO,
		'ON' MODO_PROCESO,
		'CHEQUE' FORMA_PAGO
	from cob_cuentas_his..cc_his_servicio a
	left join #pg_tmp_reverso_hs  rh on a.hs_secuencial = rh.reverso
	inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on a.hs_tipo_transaccion = trx.tipo_trx
	where hs_tsfecha  = @e_fecha_proceso
	and hs_causa=@e_empresa   --ref 2
	and hs_correccion = 'N'
	and hs_saldo > 0
	and rh.reverso is null
	
	union all
	select 	
		case hs_correccion when 'N' then 1 else 2 end	TIPO_PROCESO,
		case @e_empresa when '8459' then hs_campo_alt_dos else hs_agente  end	 TIPO_IDENTIFICACION, --RECMPS-1467		
		case @e_empresa when '8459' then STR_REPLACE(hs_nombre, ' ', '_') else "'"+isnull(hs_referencia,'')  end	 IDENTIFICACION, --RECMPS-1467
		hs_campo_alt_uno					   			REFERENCIA,   --ref 2
		'BOL'   										REFERENCIA_AUX,
		'USD'   										MONEDA_PAGO,
		round(isnull(hs_monto,0),2)						VALOR_PAGO,
		hs_secuencial			   						SECUENCIAL_PAGO,
		convert(varchar,hs_hora,103)                	FECHA_PAGO,	
		convert(varchar,hs_hora,108)  					HORA_PAGO,
		case substring(hs_tipo_chequera,1,3)
			when 'VEN' then 'VENBCO'
			when 'IBK' then 'WEBBCO'
			when 'SAT' then 'WEBBCO'
			when 'WAP' then 'MOVBCO'
			when 'CNB' then 'CNBBCO'
			when 'ATM' then 'ATMBCO'
			else 'BCOBCO'		    
		end CANAL_PROCESO,
		'ON' MODO_PROCESO,
		'DEBITO' FORMA_PAGO
	from cob_cuentas_his..cc_his_servicio a
	left join #pg_tmp_reverso_hs rh on a.hs_secuencial = rh.reverso
	inner join (select convert(int,isnull(c.codigo,'0')) tipo_trx
			    from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
			    where t.tabla = 'sv_archivos_rec_trx' 
			    and c.estado = 'V')  trx on a.hs_tipo_transaccion = trx.tipo_trx
	where hs_tsfecha  = @e_fecha_proceso
	and hs_causa=@e_empresa   --ref 2
	and hs_correccion = 'N'
	and hs_monto > 0
	and rh.reverso is null
	
	) p
order by p.SECUENCIAL_PAGO

end

if object_id('tempdb.dbo.#pg_tmp_reverso_ts') is not null
			drop table #pg_tmp_reverso_ts 
			
if object_id('tempdb.dbo.#pg_tmp_reverso_hs') is not null
			drop table #pg_tmp_reverso_hs 
						
return 0

go


if exists(select 1 from sysobjects where name='pa_pag_g_archivo_resp_ecuaq')
	PRINT '== CREATE PROCEDURE pa_pag_g_archivo_resp_ecuaq *OK* =='
else
	PRINT '<<< CREATE PROCEDURE pa_pag_g_archivo_resp_ecuaq -- ERROR -- >>>'
go

