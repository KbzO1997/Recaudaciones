--create table tmp_cedulas (cedula varchar(20))
select en_ced_ruc from cobis..cl_ente where en_ced_ruc not in(select cedula from tmp_cedulas)

use db_integracion
sp_helptext pa_sat_cdatosregistrocivil, null, null, showsql

select count(1) from cobis..cl_ente --29988 
select top 10 * from cobis..cl_ente where en_ced_ruc = '0931552442'

select top 10 * from cobis..cl_ente where en_ced_ruc = '0913721007'
select top 10 * from cobis..cl_ente where en_ced_ruc = '0961777182'

select top 10 * from db_externas..dwh_e_registro_civil where rc_cedula = '0931552442'

select top 10 * from db_externas..dwh_e_registro_civil where rc_cedula = '0913721007'
select top 10 * from db_externas..dwh_e_registro_civil where rc_cedula = '0961777182'

insert into db_externas..dwh_e_registro_civil values('0913721007')
insert into db_externas..dwh_e_registro_civil values('0961777182')


select *
from db_externas..dwh_e_registro_civil 
			where rc_cedula not in(select en_ced_ruc from cobis..cl_ente) 
select en_ced_ruc 
from cobis..cl_ente
			where en_ced_ruc not in(select rc_cedula from db_externas..dwh_e_registro_civil ) 


cob_internet..sp_helptext sp_eventos, null, null, showsql
select *	from cobis.dbo.cl_catalogo a join cobis.dbo.cl_tabla b on a.tabla = b.codigo	where b.tabla = 'lat_serv_notificador' and a.estado='V' and a.codigo =@i_servicio
select * from db_biz_admempresa..ba_catalogo c inner join db_biz_admempresa..ba_tabla t on  t.tb_cod_tabla  = c.ct_cod_tabla and t.tb_nom_tabla = 'bs_nemonicos_migrados' where c.ct_est_catalogo='A' 

update db_biz_admempresa..ba_catalogo set ct_est_catalogo = 'A' where ct_cod_tabla = 10069 and ct_cod_catalogo = 'REVPG' 


select top 100 * from cob_internet..vm_eventos where --ev_estado_proceso = 'PRO' 
--and isNull(SUBSTRING(ev_canal,4,1),'')<>'P' 
ev_servicio = 'PPRCX'
and (isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') 
and ev_fch_hora >= '09/15/2023'
order by ev_fch_hora desc

update cob_internet..vm_eventos 
set ev_estado_proceso = 'LAT', ev_canal = 'SAT' 
where ev_servicio = 'PPRCX'
and (isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') 
and ev_fch_hora >= '09/15/2023'

select top 10 * from cob_internet..vm_eventos_log

CREATE TABLE #sat_tmp_nemonico_migrado(
			tn_servicio varchar(6) NOT NULL PRIMARY KEY,
			tn_otro_campo_catalogo varchar(40) --PRIMARY KEY(ID) IN Dsp4
			
		)

		insert into #sat_tmp_nemonico_migrado(tn_servicio, tn_otro_campo_catalogo ) 
		select ct_cod_catalogo, ct_otro_campo_catalogo
		from db_biz_admempresa..ba_catalogo  c
		inner join db_biz_admempresa..ba_tabla t
		on  t.tb_cod_tabla  = c.ct_cod_tabla
		and t.tb_nom_tabla = 'bs_nemonicos_migrados' 
		where c.ct_est_catalogo='A' 
		--select * from #sat_tmp_nemonico_migrado
		
		select *
		FROM cob_internet..vm_eventos ev (index vm_eventos_id01)
			inner join #sat_tmp_nemonico_migrado tmp
				on tmp.tn_servicio = ev.ev_servicio			
		WHERE ev.ev_estado_proceso = 'LAT' --ref01:jqp
		and ev.ev_fch_hora >= '07/01/2023'
		and ((isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') or ((isnull(ev_cliente,0) <> 0) and tmp.tn_otro_campo_catalogo='SUS'))--ref02: notificaciones suscritas
		and isNull(SUBSTRING(ev.ev_canal,4,1),'')<>'L' 	



use db_biz_servicios
exec pa_sat_cnotificacion_latinia '09/15/2023'

-- RUTA UNIX /fuentes/aplicaciones/sat/servicios/batch/mensajeria
-- GAW-2243
select top 10 * from cob_internet..sms_det_procesos where dp_proceso = 'PPRCX'

  exec @w_return = cob_internet..sp_eventos
                           @i_operacion    = 'I',
                           @i_canal    =  @w_canal_sms, 
                           @i_servicio     =  @w_serv_sms,
                           @i_producto             =  @w_tipcta, 
                           @i_cuenta               =  @w_numcta, 
                           @i_valor                =  @w_valor_sms, 
                           @i_cta_cre              =  @w_numcta, 
                           @i_prod_cre             =  @w_prodcre,
                           @i_empresa              =  @w_emp_inst, 
                           @i_desc_canal           =  @w_desc_canal,
                           @i_cliente    = @w_ente, --REF57:RMC
                           @i_costo    = @w_costo, --REF57:RMC
                           @i_nombre   =  @w_nombre_empleado, --ref75:jcv
                           @i_planilla   =  @w_nuc_empleado --ref75:jcv

