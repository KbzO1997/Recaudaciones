/********************************************************************************/
/*   Archivo:           pa_sat_cnotificacion_sindet.sp                          */
/*   Stored procedure:  pa_sat_cnotificacion_sindet                             */
/*   Base:              db_biz_servicios                                        */
/*   Producto:          SAT                                                     */
/********************************************************************************/
/*                     IMPORTANTE                                               */
/*   Esta aplicacion es parte de los  paquetes bancarios                        */
/*   propiedad de BANCO BOLIVARIANO C.A.                                        */
/*   Su uso no autorizado queda  expresamente prohibido                         */
/*   autores de cualquier infraccion.                                           */
/********************************************************************************/
/*                      PROPOSITO                                               */
/*   Consulta notificaciones pendientes para envio masivo de mensajeria         */
/*   por nuevo sistema Latinia                                                  */
/********************************************************************************/
/*                    MODIFICACION                                              */
/*                                                                              */
/* REF  FECHA        AUTOR            Descripcion                               */
/*  0   17-Jun-2020  Roberto Leon.    SAT-1288 Emision inicial                  */
/*  1   18-Feb-2021  Roberto Leon.    SAT-3689 Ajsute SMS y secuencial          */
/*  2   03-Mar-2021  Roberto Leon.    SATM-591 Ajuste error subquery aplicar min*/
/*  3   09-Jun-2021  Carlos Dier.     SATM-728 Quitar salto de linea en campo de correo para latinia*/
/*  4   24-Jun-2021  Roberto Leon     SAT-4813 Ajustar notificaciones suscritas */
/*  5   27-Jul-2021  Roberto Leon     SATM-829 Ajuste permitir null en tabla tmp*/
/********************************************************************************/
use db_biz_servicios
GO
if exists(select 1 from sysobjects where name = 'pa_sat_cnotificacion_sindet' and type = 'P')
begin
   drop procedure dbo.pa_sat_cnotificacion_sindet
   if exists (select 1 from sysobjects where name = 'pa_sat_cnotificacion_sindet' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_sat_cnotificacion_sindet -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_sat_cnotificacion_sindet *OK* =='
end
go

create procedure dbo.pa_sat_cnotificacion_sindet
(
@e_cab_servicio varchar(5),
@e_cab_canal 	varchar(5)
)
as
begin
	
	 CREATE TABLE #sat_tmp_vm_eventos(
		ev_secuencial varchar(23),
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
		ev_fch_hora datetime null,--roleonc
		ev_fecha_tope varchar(30) null,--ref04 ajuste notificacion suscrita
		ev_valor1 varchar(11) null,
		ev_valor2 varchar(11) null,
		ev_motivo varchar(150) null,
		ev_login varchar(30) null,
		ev_ssn int null,
		ev_cliente int null--ref04 ajuste notificacion suscrita ref05
	)
	
	CREATE INDEX i_tmp_vm_eventos_01 ON #sat_tmp_vm_eventos(
	ev_secuencial
	)
	
	insert into #sat_tmp_vm_eventos(ev_secuencial,ev_canal,ev_servicio,ev_mail,ev_cuenta,ev_telefono,ev_valor,ev_fecha,ev_cheque,ev_cta,
	ev_tarjeta,ev_desc_producto,ev_desc_servicio,ev_total,ev_minimo,ev_cupo,ev_planilla,ev_nombre,ev_cta_deb,ev_prod_deb,ev_cta_cre,
	ev_prod_cre,ev_costo,ev_empresa,ev_desc_canal,ev_estado_proceso,ev_fch_hora,ev_fecha_tope,ev_valor1,ev_valor2,ev_motivo,ev_login,ev_ssn,ev_cliente)
	select convert(varchar(30),ev_secuencial) as ev_secuencial,ev_canal,ev_servicio,rtrim(ltrim(str_replace(str_replace(ev_mail, char(10), ''), char(13), ''))) -- Ref3
	,ev_cuenta,ev_telefono,ev_valor,ev_fecha,
	ev_cheque,ev_cta,ev_tarjeta,ev_desc_producto,ev_desc_servicio,ev_total,ev_minimo,ev_cupo,ev_planilla,ev_nombre,ev_cta_deb,ev_prod_deb,
	ev_cta_cre,ev_prod_cre,ev_costo,ev_empresa,ev_desc_canal,ev_estado_proceso,ev_fch_hora,ev_fecha_tope,ev_valor1,ev_valor2,ev_motivo,ev_login,ev_ssn,ev_cliente
	from cob_internet..vm_eventos ev (index vm_eventos_id01)--ref04 inicio
		inner join db_biz_admempresa..ba_catalogo c on c.ct_cod_catalogo = ev.ev_servicio	
		inner join db_biz_admempresa..ba_tabla t on  t.tb_cod_tabla = c.ct_cod_tabla and t.tb_nom_tabla = 'bs_nemonicos_migrados' 				
	where ev_servicio = @e_cab_servicio and ev_canal = @e_cab_canal
	and ((isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') or ((isnull(ev_cliente,0) <> 0) and c.ct_otro_campo_catalogo='SUS'))--ref04 fin
	and isNull(SUBSTRING(ev_canal,4,1),'')='P'
	if @@error <> 0
	begin
		return 1
	end
	
	Select
	 ev_secuencial = 'SAT' + CONVERT(varchar,ev_fch_hora,112)+substring(convert(varchar(8),ev_fch_hora,108),1,2)+substring(convert(varchar(8),ev_fch_hora,108),4,2)+substring(convert(varchar(8),ev_fch_hora,108),7,2)+right(rtrim(ltrim(convert(varchar,ev_secuencial))),6)
	,ev.ev_servicio                              											
	,case WHEN isnull(ev.ev_mail,'')='' THEN ev.ev_telefono Else ev.ev_mail END AS ev_mail
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cuenta' and p.dp_tipo = 'I')+'='+ev.ev_cuenta) as  cuenta 
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cuenta' and p.dp_tipo = 'I'),30) as  cuenta_len 
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_telefono' and p.dp_tipo = 'I')+'='+ev.ev_telefono) as  telefono
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_telefono' and p.dp_tipo = 'I'),30) as  telefono_len
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor' and p.dp_tipo = 'I')+'='+ev.ev_valor) as  valor
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor' and p.dp_tipo = 'I'),30) as  valor_len
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I')+'='+ev.ev_fecha) as  fecha									
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha' and p.dp_tipo = 'I'),30) as  fecha_len									
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cheque' and p.dp_tipo = 'I')+'='+ev.ev_cheque) as  cheque								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cheque' and p.dp_tipo = 'I'),30) as  cheque_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta' and p.dp_tipo = 'I')+'='+ev.ev_cta) as  cta											
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta' and p.dp_tipo = 'I'),30) as  cta_len										
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_tarjeta' and p.dp_tipo = 'I')+'='+ev.ev_tarjeta) as  tarjeta								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_tarjeta' and p.dp_tipo = 'I'),30) as  tarjeta_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_producto' and p.dp_tipo = 'I')+'='+ev.ev_desc_producto) as  desc_producto			
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_producto' and p.dp_tipo = 'I'),30) as  desc_producto_len			
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_servicio' and p.dp_tipo = 'I')+'='+ev.ev_desc_servicio) as  desc_servicio			
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_servicio' and p.dp_tipo = 'I'),30) as  desc_servicio_len			
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_total' and p.dp_tipo = 'I')+'='+ev.ev_total) as  total									
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_total' and p.dp_tipo = 'I'),30) as  total_len									
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_minimo' and p.dp_tipo = 'I')+'='+ev.ev_minimo) as  minimo								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_minimo' and p.dp_tipo = 'I'),30) as  minimo_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cupo' and p.dp_tipo = 'I')+'='+ev.ev_cupo) as  cupo										
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cupo' and p.dp_tipo = 'I'),30) as  cupo_len										
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_planilla' and p.dp_tipo = 'I')+'='+ev.ev_planilla) as  planilla							
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_planilla' and p.dp_tipo = 'I'),30) as  planilla_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_nombre' and p.dp_tipo = 'I')+'='+ev.ev_nombre) as  nombre								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_nombre' and p.dp_tipo = 'I'),30) as  nombre_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_deb' and p.dp_tipo = 'I')+'='+ev.ev_cta_deb) as  cta_deb								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_deb' and p.dp_tipo = 'I'),30) as  cta_deb_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_deb' and p.dp_tipo = 'I')+'='+ev.ev_prod_deb) as  prod_deb							
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_deb' and p.dp_tipo = 'I'),30) as  prod_deb_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_cre' and p.dp_tipo = 'I')+'='+ev.ev_cta_cre) as  cta_cre								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_cta_cre' and p.dp_tipo = 'I'),30) as  cta_cre_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_cre' and p.dp_tipo = 'I')+'='+ev.ev_prod_cre) as  prod_cre							
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_prod_cre' and p.dp_tipo = 'I'),30) as  prod_cre_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_costo' and p.dp_tipo = 'I')+'='+ev.ev_costo) as  costo									
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_costo' and p.dp_tipo = 'I'),30) as  costo_len									
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_empresa' and p.dp_tipo = 'I')+'='+ev.ev_empresa) as  empresa								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_empresa' and p.dp_tipo = 'I'),30) as  empresa_len							
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_canal' and p.dp_tipo = 'I')+'='+ev.ev_desc_canal) as  desc_canal					
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_desc_canal' and p.dp_tipo = 'I'),30) as  desc_canal_len					
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha_tope' and p.dp_tipo = 'I')+'='+convert(varchar,ev.ev_fecha_tope)) as  fecha_tope	
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_fecha_tope' and p.dp_tipo = 'I'),30) as  fecha_tope_len	
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor1' and p.dp_tipo = 'I')+'='+ev.ev_valor1) as  valor1								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor1' and p.dp_tipo = 'I'),30) as  valor1_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor2' and p.dp_tipo = 'I')+'='+ev.ev_valor2) as  valor2								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_valor2' and p.dp_tipo = 'I'),30) as  valor2_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_motivo' and p.dp_tipo = 'I')+'='+ev.ev_motivo) as  motivo								
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_motivo' and p.dp_tipo = 'I'),30) as  motivo_len								
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_login' and p.dp_tipo = 'I')+'='+ev.ev_login) as  login									
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_login' and p.dp_tipo = 'I'),30) as  login_len
	,((select min(p.dp_valor) from cob_internet..sms_det_procesos c          inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_ssn' and p.dp_tipo = 'I')+'='+convert(varchar,ev.ev_ssn)) as  ssn						
	,isnull((select min(p.dp_longitud) from cob_internet..sms_det_procesos c inner join cob_internet..sms_det_procesos p on c.dp_proceso = p.dp_proceso and c.dp_campo = p.dp_campo where c.dp_proceso = @e_cab_servicio and c.dp_tipo = 'T' and c.dp_valor = 'i_ssn' and p.dp_tipo = 'I'),30) as  ssn_len
	,convert(varchar,isnull(ev.ev_cliente,0)) as cliente --ref04 obtiene codigo ente --ref05
	from #sat_tmp_vm_eventos ev	
	order by ev.ev_secuencial

	drop table #sat_tmp_vm_eventos
	
	return 0
end	 
GO  

if exists(select 1 from sysobjects where name='pa_sat_cnotificacion_sindet' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_sat_cnotificacion_sindet *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_sat_cnotificacion_sindet -- ERROR -- >>>'
go
