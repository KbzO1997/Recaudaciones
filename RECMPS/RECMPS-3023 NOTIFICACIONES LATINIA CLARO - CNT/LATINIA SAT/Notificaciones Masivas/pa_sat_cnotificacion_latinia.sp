/************************************************************************/
/*          Archivo:                pa_sat_cnotificacion_latinia.sp 	*/
/*          Stored procedure:       pa_sat_cnotificacion_latinia	    */
/*          Base de datos:          db_biz_servicios	               	*/
/*          Producto:               servicios                       	*/
/*          Disenado por:           SISOEMP                             */
/*          Derechos de autor:      SISOEMP                             */
/*		    Motor de Base:       SYBASE                                 */
/*		    Servidor:            HP-ACT                                 */
/*          Aplicacion:          SAT                                    */
/*          Procesamiento:       OLTP                                   */
/*          Producto:            SAT                                    */
/*          Ult.ControlTarea:    J-SAT-10999                            */
/*          Ult.Referencia:      REF 3                                  */
/*          Fecha de escritura:     17/07/2020                      	*/
/************************************************************************/
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
/*  01  20-Ene-2021  Jorge Quinonez   SAT-3366 Ajustar estado LAT               */
/*  02  24-Jun-2021  Roberto Leon     SAT-4813 Ajustar notificaciones suscritas */
/*  03  18-Ago-2023  Julio Hermenejildo SAT-10999 Ajustar Proceso Generación Filereader */
/********************************************************************************/
use db_biz_servicios
GO
if exists(select 1 from sysobjects where name = 'pa_sat_cnotificacion_latinia' and type = 'P')
begin
   drop procedure dbo.pa_sat_cnotificacion_latinia
   if exists (select 1 from sysobjects where name = 'pa_sat_cnotificacion_latinia' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_sat_cnotificacion_latinia -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_sat_cnotificacion_latinia *OK* =='
end
go

create procedure dbo.pa_sat_cnotificacion_latinia
(
@e_fecha datetime
)
as
begin
	
	declare @v_row_count int, @v_return int
	
    /*<REF 3 JHC, REF 3>*/
	-- OBTIENE CANTIDAD DE REGISTROS A PROCESAR
	exec @v_return = db_biz_admempresa..sp_con_parametroconf
		 @i_empresa          = 0,
		 @i_producto         = 1,
		 @i_servicio         = 'T',
		 @i_parametro        = 'ROWSLATINIA',
		 @o_pa_val_numerico  = @v_row_count output
		 
		 if @@error <> 0 or @v_return <> 0
		    begin
		  	  select @v_row_count = 20000
            end	
    /*<REF 3 JHC, REF 3>*/        	
	 	
	
	if exists(select 1 from db_biz_admempresa..ba_catalogo  c
						inner join db_biz_admempresa..ba_tabla t
						on  t.tb_cod_tabla  = c.ct_cod_tabla
						and t.tb_nom_tabla = 'bs_nemonicos_migrados' 
						where c.ct_est_catalogo='A' )
	begin
		--*******************************************
		--Se consulta nemonicos migrados a Latinia
		--*******************************************
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
		if @@error <> 0
		begin
		   return 1
		end
        
        /*<REF 3 JHC, REF 3>*/
        set rowcount @v_row_count
			
		UPDATE	cob_internet..vm_eventos
		SET 	ev_canal = (SUBSTRING(ev.ev_canal,1,3)+'P')
		FROM cob_internet..vm_eventos ev (index vm_eventos_id01)
			inner join #sat_tmp_nemonico_migrado tmp
				on tmp.tn_servicio = ev.ev_servicio			
		WHERE ev.ev_estado_proceso = 'LAT' --ref01:jqp
		and ev.ev_fch_hora >= @e_fecha
		and ((isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') or ((isnull(ev_cliente,0) <> 0) and tmp.tn_otro_campo_catalogo='SUS'))--ref02: notificaciones suscritas
		and isNull(SUBSTRING(ev.ev_canal,4,1),'')<>'L' 	
		
		select cab_canal = ev.ev_canal, cab_servicio = ev.ev_servicio, cab_cantidad = convert(varchar(5),count(1))
				,tn.tn_otro_campo_catalogo as cab_tiene_detalle
				--,max(case when isnull(ev_req_sat, 0) > 0 then 'S' else 'N' end) as cab_tiene_detalle
		from cob_internet..vm_eventos ev (index vm_eventos_id01)
		inner join #sat_tmp_nemonico_migrado tn on tn.tn_servicio = ev.ev_servicio 
		where ev.ev_estado_proceso = 'LAT' --ref01:jqp
		and ev.ev_fch_hora >= @e_fecha
		and ((isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '') or ((isnull(ev_cliente,0) <> 0) and tn.tn_otro_campo_catalogo='SUS'))--ref02: notificaciones suscritas
		and isNull(SUBSTRING(ev.ev_canal,4,1),'')='P' 		
		group by ev.ev_canal, ev.ev_servicio, tn.tn_otro_campo_catalogo
			
		drop table #sat_tmp_nemonico_migrado  
	end
	else
	begin
		--print 'proceder sin catalogo'
		select cab_canal = ev_canal, cab_servicio = ev_servicio, cab_cantidad = convert(varchar(5),count(1))
				,max(case when isnull(ev_req_sat, 0) > 0 then 'S' else 'N' end) as cab_tiene_detalle
		from cob_internet..vm_eventos (index vm_eventos_id01)
		where ev_estado_proceso = 'LAT' --ref01:jqp
		and ev_fch_hora >= @e_fecha
		and (isnull(ev_mail,'') <> '' or isnull(ev_telefono,'') <> '')
		and isNull(SUBSTRING(ev_canal,4,1),'')<>'L'		
		group by ev_canal, ev_servicio
	end
end	 
GO

if exists(select 1 from sysobjects where name='pa_sat_cnotificacion_latinia' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_sat_cnotificacion_latinia *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_sat_cnotificacion_latinia -- ERROR -- >>>'
go
