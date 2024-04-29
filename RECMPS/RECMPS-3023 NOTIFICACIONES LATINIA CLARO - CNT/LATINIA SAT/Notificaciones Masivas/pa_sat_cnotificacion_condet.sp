/********************************************************************************/
/*   Archivo:           pa_sat_cnotificacion_condet.sp                         */
/*   Stored procedure:  pa_sat_cnotificacion_condet                            */
/*   Motor de Base:     SYBASE                                                  */
/*   Base de datos:     db_biz_servicios                                        */
/*   Servidor:          HP-ACT                                                  */
/*   Aplicacion:        SAT                                                     */
/*   Procesamiento:     BATCH                                                   */
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
/*  1   18-Feb-2020  Roberto Leon.    SAT-3689 Ajsute SMS y secuencial          */
/*  2   09-Jun-2021  Carlos Dier.     SATM-728 Quitar salto de linea en campo de correo para latinia */
/*  3   22-Jun-2021  Jorge Quinz.     SATM-752 Mejora en proceso satexlat por desbordamiento de variable */
/*  4   21-Feb-2022  Roberto Leon.    SAT-6083 Ajuste envio notificacion con adjunto */
/*  5   26-Ago-2022  Joffre Pita      SAT-7855 Ajustar notificaciones con detalle de facturas (hasta 100) por el servicio pago a proveedores */
/********************************************************************************/
use db_biz_servicios
GO
if exists(select 1 from sysobjects where name = 'pa_sat_cnotificacion_condet' and type = 'P')
begin
   drop procedure dbo.pa_sat_cnotificacion_condet
   if exists (select 1 from sysobjects where name = 'pa_sat_cnotificacion_condet' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_sat_cnotificacion_condet -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_sat_cnotificacion_condet *OK* =='
end
go

create procedure dbo.pa_sat_cnotificacion_condet
(
@e_cab_servicio varchar(5),
@e_cab_canal 	varchar(5),
@e_paso 		char(1) --ref04
)
as
begin	
	declare @v_return int
	if (@e_paso = '1') --ref04 ini
	begin
		exec @v_return = db_biz_servicios..pa_sat_cnotifcondet_cab
			@e_cab_servicio	= @e_cab_servicio, 
			@e_cab_canal	= @e_cab_canal
		if @@error != 0		
			return 1
		if @v_return != 0
			return 1
	end	
	if (@e_paso = '2')
	begin
		exec @v_return = db_biz_servicios..pa_sat_cnotifcondet_des
			@e_cab_servicio	= @e_cab_servicio, 
			@e_cab_canal	= @e_cab_canal
		if @@error != 0		
			return 1
		if @v_return != 0
			return 1
	end --ref04 ini
	--ref05 ini
	if (@e_paso = '3')
	begin
		exec @v_return = db_biz_servicios..pa_sat_cnotifcondet_not
			             @e_cab_servicio   =  @e_cab_servicio, 
			             @e_cab_canal      =  @e_cab_canal
		if @@error != 0		
			return 1
		if @v_return != 0
			return 1
	end 
	--ref05 fin
	return 0
end	 
GO  

if exists(select 1 from sysobjects where name='pa_sat_cnotificacion_condet' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_sat_cnotificacion_condet *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_sat_cnotificacion_condet -- ERROR -- >>>'
go