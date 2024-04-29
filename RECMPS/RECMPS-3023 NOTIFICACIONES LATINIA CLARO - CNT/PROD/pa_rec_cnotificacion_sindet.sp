
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_rec_cnotificacion_sindet' and type = 'P')
begin
   drop procedure dbo.pa_rec_cnotificacion_sindet
   if exists (select 1 from sysobjects where name = 'pa_rec_cnotificacion_sindet' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_rec_cnotificacion_sindet -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_rec_cnotificacion_sindet *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pa_rec_cnotificacion_sindet.sp                  */
/*  Stored procedure:   pa_rec_cnotificacion_sindet                     */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                               	*/
/*  Fecha de escritura: 26-Ene-2024                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECM-869                                   */
/*  Ult.Referencia:     REF 3                                           */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*              PROPOSITO                                               */
/* Este programa realiza las validaciones de consultas de recaudaciones */
/*                                                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/* RF   FECHA            AUTOR                 RAZON                    */
/* 1  26/Ene/2024 Kevin Bastidas  RECMPS-3023  Emisión inicial     */
/* 2  26/Ene/2024 Kevin Bastidas  RECMPS-3023  Emisión inicial     */
/* 3  11/Marz/2024 Kevin Bastidas  RECMPS-3023  Emisión inicial     */
/************************************************************************/

create procedure dbo.pa_rec_cnotificacion_sindet
(
@e_cab_servicio  varchar(5),
@e_cab_canal 	 varchar(5),
@e_fecha_proceso datetime,
@e_empresa 		 int,
@e_numarchivo 	 int
)
as
declare
@v_desc_producto varchar(30),
@v_desc_servicio varchar(30)
begin
	
	CREATE TABLE #rec_tmp_vm_eventos(
		ev_secuencial varchar(23) ,
		ev_canal varchar(5),
		ev_servicio varchar(5),
		ev_mail varchar(256) null,
		ev_cuenta varchar(40) null,
		ev_telefono varchar(12) null,
		ev_valor varchar(11) null,
		ev_fecha varchar(10) null,
		ev_cheque varchar(10) null,
		ev_cta varchar(40) null,
		ev_tarjeta varchar(16) null,
		ev_desc_producto varchar(32) null,
		ev_desc_servicio varchar(32) null,
		ev_total varchar(11) null,
		ev_minimo varchar(11) null,
		ev_cupo varchar(11) null,
		ev_planilla varchar(64) null,
		ev_nombre varchar(64) null,
		ev_cta_deb varchar(40) null,
		ev_prod_deb varchar(11) null,
		ev_cta_cre varchar(40) null,
		ev_prod_cre varchar(11) null,
		ev_costo varchar(11) null,
		ev_empresa varchar(32) null,
		ev_desc_canal varchar(16) null,
		ev_estado_proceso varchar(3) null,
		ev_fch_hora datetime null,
		ev_fecha_tope varchar(30) null,
		ev_valor1 varchar(11) null,
		ev_valor2 varchar(11) null,
		ev_motivo varchar(150) null,
		ev_login varchar(30) null,
		ev_ssn int null,
		ev_cliente int null
	)
	
	set @v_desc_servicio = (select b.valor 
							from cobis..cl_tabla a 
							inner join  cobis..cl_catalogo b 
							on a.codigo = b.tabla
							where a.tabla = 'rec_empresas_lat' and b.codigo = convert(char(5), isnull(@e_empresa,0)) and b.estado = 'V')
	
	set @v_desc_producto = 'Pago de Servicios'
	
		if @e_empresa = 113
			begin
				insert into #rec_tmp_vm_eventos(ev_secuencial,ev_canal,ev_servicio,ev_mail,ev_cuenta,
				ev_telefono,ev_valor,ev_fecha,ev_cheque,ev_cta,
				ev_tarjeta,ev_desc_producto,ev_desc_servicio,ev_total,ev_minimo,
				ev_cupo,ev_planilla,ev_nombre,ev_cta_deb,ev_prod_deb,
				ev_cta_cre,ev_prod_cre,ev_costo,ev_empresa,ev_desc_canal,
				ev_estado_proceso,ev_fch_hora,ev_fecha_tope,ev_valor1,ev_valor2,
				ev_motivo,ev_login,ev_ssn,ev_cliente)
				--SELECT DE CONSULTA CNT
				select convert(varchar, cc_id), @e_cab_canal, @e_cab_servicio, 
				isnull(de_descripcion, (select pa_parametro 
				from cobis..cl_parametro
				where pa_nemonico = 'RECLAT'
				and pa_producto = 'CTE')), 
				substring(cc.cc_cta_banco, 18, 20),
				null, /*<REF 3, Campo Telefono REF 3>*/
				convert(varchar, convert(money,substring(cc_total,1,10) + '.' + substring(cc_total,11,2))),
				@e_fecha_proceso, null,cta.cc_cta_banco,
				null, @v_desc_producto,'CONSUMO CNT',
				convert(varchar, convert(money,substring(cc_total,1,10) + '.' + substring(cc_total,11,2))), 
				convert(varchar, convert(money,substring(cc_total,1,10) + '.' + substring(cc_total,11,2))),
				null,isnull(en_ced_ruc,p_pasaporte),isnull(ah_nombre, cta.cc_nombre),null,cc_tipo_cta,
				null,null,'0', @v_desc_servicio , @e_cab_canal,
				cc.cc_estado, getdate(),CONVERT(varchar,convert(datetime, cc_fecha_inicio, NULL), 101) , convert(varchar(08),getdate(),108), '0.00',
				'CONSUMO CNT',null,0, cc_ente
				
				from  cob_cuentas..cc_debito_cnt cc
				left join cob_cuentas..cc_ctacte cta 
				on substring(cc.cc_cta_banco, 11, 20) = cta.cc_cta_banco
				left join cob_ahorros..ah_cuenta ah
				on substring(cc.cc_cta_banco, 11, 20) = ah.ah_cta_banco
				inner join cobis..cl_ente c 
				on isnull(cta.cc_cliente, ah.ah_cliente) = c.en_ente
				left join cobis..cl_direccion_email x 
				on c.en_ente = de_ente and (x.de_direccion = (select max(de_direccion) 
								from cobis..cl_direccion_email
								where de_ente = x.de_ente
								and de_tipo = 'E'
								group by de_ente))
				where cc_empresacnt =  convert(char(5), isnull(@e_empresa,0)) and cc_fecha_inicio = @e_fecha_proceso and cc_codigo = '000' and cc.cc_estado in('P') /*<REF 2, Campo Estado REF 2>*/
			end
		else
			begin
				insert into #rec_tmp_vm_eventos(ev_secuencial,ev_canal,ev_servicio,ev_mail,ev_cuenta,
				ev_telefono,ev_valor,ev_fecha,ev_cheque,ev_cta,
				ev_tarjeta,ev_desc_producto,ev_desc_servicio,ev_total,ev_minimo,
				ev_cupo,ev_planilla,ev_nombre,ev_cta_deb,ev_prod_deb,
				ev_cta_cre,ev_prod_cre,ev_costo,ev_empresa,ev_desc_canal,
				ev_estado_proceso,ev_fch_hora,ev_fecha_tope,ev_valor1,ev_valor2,
				ev_motivo,ev_login,ev_ssn,ev_cliente)
				--SELECT DE CONSULTA CLARO
				select cd_num_cmpbte_vta, @e_cab_canal, @e_cab_servicio, isnull(de_descripcion, ''),
					substring(isnull(cd_num_cta,'0000000000'), 8,10),
					null, /*<REF 3, Telefono La REF 3>*/
					convert(varchar, isnull(cd_valor_rec,0)), @e_fecha_proceso, null,cd_num_cta,
					null, @v_desc_producto,cd_concepto,convert(varchar, isnull(cd_valor_pagado,0)), convert(varchar, isnull(cd_valor_pagado,0)),
					null,isnull(en_ced_ruc,p_pasaporte),isnull(ah_nombre, cc_nombre),null,case cd_tipo_cta 
					when '03' then 'CTE' 
					else 'AHO' 
					end,
					null,null,'0', @v_desc_servicio , @e_cab_canal,
					cd_estado, getdate(),CONVERT(varchar,convert(datetime, cd_fecha_arc, NULL), 101) , convert(varchar(08),getdate(),108),convert(varchar, isnull(cd_comision,0)) ,
					cd_concepto,null,0, en_ente
				from  cob_pagos..pg_cobro_debitos_servicio a
				left join cob_cuentas..cc_ctacte cc
				on a.cd_num_cta = cc.cc_cta_banco
				left join cob_ahorros..ah_cuenta ah
				on a.cd_num_cta = ah.ah_cta_banco
				inner join cobis..cl_ente c 
				on isnull(cc.cc_cliente, ah.ah_cliente) = c.en_ente
				left join cobis..cl_direccion_email x 
				on c.en_ente = de_ente and (x.de_direccion = (select max(de_direccion) 
								from cobis..cl_direccion_email
								where de_ente = x.de_ente
								and de_tipo = 'E'
								group by de_ente))
				where cd_empresa =  convert(char(5), isnull(@e_empresa,0)) and cd_fecha_arc = @e_fecha_proceso and cd_cod_error is null and (cd_no_archivo = @e_numarchivo OR @e_numarchivo = 9) and cd_estado in('P','F') /*<REF 2, Campo Estado REF 2>*/
			end
		
	if @@error <> 0
	begin
		return 1
	end
	
	select
	ev_secuencial = @e_cab_canal + CONVERT(varchar,ev_fch_hora,112)+substring(convert(varchar(8),ev_fch_hora,108),1,2)+substring(convert(varchar(8),ev_fch_hora,108),4,2)+substring(convert(varchar(8),ev_fch_hora,108),7,2)+right(rtrim(ltrim(convert(varchar,ev_secuencial))),6)
	,ev.ev_servicio                              											
	,case 
	WHEN isnull(ev.ev_mail,'')='' THEN ev.ev_telefono 
	else ev.ev_mail 
	END AS ev_mail	
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cuenta' and p.dp_tipo = 'I')+'='+ev.ev_cuenta) as  cuenta 
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cuenta' and p.dp_tipo = 'I'),30) as  cuenta_len 
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_telefono' and p.dp_tipo = 'I')+'='+ev.ev_telefono) as  telefono
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_telefono' and p.dp_tipo = 'I'),30) as  telefono_len
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor' and p.dp_tipo = 'I')+'='+ev.ev_valor) as  valor
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor' and p.dp_tipo = 'I'),30) as  valor_len
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I')+'='+ev.ev_fecha) as  fecha									
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I'),30) as  fecha_len									
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cheque' and p.dp_tipo = 'I')+'='+ev.ev_cheque) as  cheque								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cheque' and p.dp_tipo = 'I'),30) as  cheque_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta' and p.dp_tipo = 'I')+'='+ev.ev_cta) as  cta											
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta' and p.dp_tipo = 'I'),30) as  cta_len										
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_tarjeta' and p.dp_tipo = 'I')+'='+ev.ev_tarjeta) as  tarjeta								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_tarjeta' and p.dp_tipo = 'I'),30) as  tarjeta_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_producto' and p.dp_tipo = 'I')+'='+ev.ev_desc_producto) as  desc_producto			
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_producto' and p.dp_tipo = 'I'),30) as  desc_producto_len			
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_servicio' and p.dp_tipo = 'I')+'='+ev.ev_desc_servicio) as  desc_servicio			
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_servicio' and p.dp_tipo = 'I'),30) as  desc_servicio_len			
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_total' and p.dp_tipo = 'I')+'='+ev.ev_total) as  total									
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_total' and p.dp_tipo = 'I'),30) as  total_len									
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_minimo' and p.dp_tipo = 'I')+'='+ev.ev_minimo) as  minimo								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_minimo' and p.dp_tipo = 'I'),30) as  minimo_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cupo' and p.dp_tipo = 'I')+'='+ev.ev_cupo) as  cupo										
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cupo' and p.dp_tipo = 'I'),30) as  cupo_len										
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_planilla' and p.dp_tipo = 'I')+'='+ev.ev_planilla) as  planilla							
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_planilla' and p.dp_tipo = 'I'),30) as  planilla_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_nombre' and p.dp_tipo = 'I')+'='+ev.ev_nombre) as  nombre								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_nombre' and p.dp_tipo = 'I'),30) as  nombre_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_deb' and p.dp_tipo = 'I')+'='+ev.ev_cta_deb) as  cta_deb								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_deb' and p.dp_tipo = 'I'),30) as  cta_deb_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_deb' and p.dp_tipo = 'I')+'='+ev.ev_prod_deb) as  prod_deb							
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_deb' and p.dp_tipo = 'I'),30) as  prod_deb_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_cre' and p.dp_tipo = 'I')+'='+ev.ev_cta_cre) as  cta_cre								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_cre' and p.dp_tipo = 'I'),30) as  cta_cre_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_cre' and p.dp_tipo = 'I')+'='+ev.ev_prod_cre) as  prod_cre							
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_cre' and p.dp_tipo = 'I'),30) as  prod_cre_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_costo' and p.dp_tipo = 'I')+'='+ev.ev_costo) as  costo									
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_costo' and p.dp_tipo = 'I'),30) as  costo_len									
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_empresa' and p.dp_tipo = 'I')+'='+ev.ev_empresa) as  empresa								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_empresa' and p.dp_tipo = 'I'),30) as  empresa_len							
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_canal' and p.dp_tipo = 'I')+'='+ev.ev_desc_canal) as  desc_canal					
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_canal' and p.dp_tipo = 'I'),30) as  desc_canal_len					
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I')+'='+convert(varchar,ev.ev_fecha_tope)) as  fecha_tope	
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I'),30) as  fecha_tope_len	
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor1' and p.dp_tipo = 'I')+'='+ev.ev_valor1) as  valor1								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor1' and p.dp_tipo = 'I'),30) as  valor1_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor2' and p.dp_tipo = 'I')+'='+ev.ev_valor2) as  valor2								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor2' and p.dp_tipo = 'I'),30) as  valor2_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_motivo' and p.dp_tipo = 'I')+'='+ev.ev_motivo) as  motivo								
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_motivo' and p.dp_tipo = 'I'),30) as  motivo_len								
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_login' and p.dp_tipo = 'I')+'='+ev.ev_login) as  login									
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_login' and p.dp_tipo = 'I'),30) as  login_len
	,((select min(p.dp_valor) 
	from cob_internet..sms_det_procesos c          
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_ssn' and p.dp_tipo = 'I')+'='+convert(varchar,ev.ev_ssn)) as  ssn						
	,isnull((select min(p.dp_longitud) 
	from cob_internet..sms_det_procesos c 
	inner join cob_internet..sms_det_procesos p 
	on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo 
	where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_ssn' and p.dp_tipo = 'I'),30) as  ssn_len
	,convert(varchar,isnull(ev.ev_cliente,0)) as cliente --ref Obtiene codigo ente
	from #rec_tmp_vm_eventos ev	
	order by ev.ev_secuencial	

	drop table #rec_tmp_vm_eventos
	
	return 0
end	 

go

if exists(select 1 from sysobjects where name='pa_rec_cnotificacion_sindet' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_rec_cnotificacion_sindet *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_rec_cnotificacion_sindet -- ERROR -- >>>'
go