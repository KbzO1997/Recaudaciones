/********************************************************************************/
/*   Archivo:           pa_sat_anotificacion_latinia.sp                         */
/*   Stored procedure:  pa_sat_anotificacion_latinia                            */
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
/*  01  20-Ene-2021  Jorge Quiñonez   SAT-3366 Ajustar estado PRO y LAT         */
/********************************************************************************/
use db_biz_servicios
GO
if exists(select 1 from sysobjects where name = 'pa_sat_anotificacion_latinia' and type = 'P')
begin
   drop procedure dbo.pa_sat_anotificacion_latinia
   if exists (select 1 from sysobjects where name = 'pa_sat_anotificacion_latinia' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_sat_anotificacion_latinia -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_sat_anotificacion_latinia *OK* =='
end
go

create procedure dbo.pa_sat_anotificacion_latinia
(
@e_cab_servicio varchar(5),
@e_cab_canal 	varchar(5)
)
as
begin
	UPDATE	cob_internet..vm_eventos
	SET 	ev_canal = (SUBSTRING(ev_canal,1,3)+'L'), ev_estado_proceso = 'PRO' --ref01:jqp
	WHERE ev_servicio = @e_cab_servicio and ev_canal = @e_cab_canal
		and isNull(SUBSTRING(ev_canal,4,1),'')='P'
		and ev_estado_proceso = 'LAT' --ref01:jqp
end	 
GO  

if exists(select 1 from sysobjects where name='pa_sat_anotificacion_latinia' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_sat_anotificacion_latinia *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_sat_anotificacion_latinia -- ERROR -- >>>'
go