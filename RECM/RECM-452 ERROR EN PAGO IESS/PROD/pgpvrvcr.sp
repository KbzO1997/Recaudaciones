/************************************************************************/
/*  Archivo:            pgpvrvcr.sp                                     */
/*  Stored procedure:   pa_pg_pval_rev_core                             */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Jonathan Guerrero                               */
/*  Fecha de escritura: 23-Nov-2021                                     */
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
/*  Este programa valida que no se ejecute el reverso automatico al     */
/*  proveedor si ya se encuentra registrado un pago exitoso en el core  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*    FECHA           AUTOR                      RAZON                  */
/*  23/Nov/2021  Jonathan Guerrero      RECM-438 Emision Inicial        */
/*  09/Ene/2021   Kevin Bastida         RECM-452 Error Pago IESS        */
/************************************************************************/

use cob_pagos
go


if exists (select 1 from dbo.sysobjects where name = 'pa_pg_pval_rev_core' and type = 'P')
begin
	drop procedure dbo.pa_pg_pval_rev_core
	if exists (select 1 from sysobjects where name = 'pa_pg_pval_rev_core' and type = 'P')
		PRINT '<<< DROP PROCEDURE pa_pg_pval_rev_core -- ERROR -- >>>'
	else
		PRINT '== DROP PROCEDURE pa_pg_pval_rev_core *OK* =='
end
go

create procedure dbo.pa_pg_pval_rev_core(
@e_empresa		  varchar(10),
@e_suministro	  varchar(30),
@e_canal	      char(5),
@e_usuario		  varchar(30),
@e_identificacion char(15) ='',
@e_fecha		  smalldatetime,
@t_debug     	  char(1) = 'N',
@t_file      	  varchar(14) = null
)

as
declare @v_Cod_Error	int
 select @v_Cod_Error = 901422
  --Verifica que no se encuentre un pago exitoso en el core
  if @e_empresa = '940'

		begin

		  if exists(select 1 from cob_cuentas..cc_tran_servicio 
						where ts_tsfecha = @e_fecha 
						and ts_referencia = rtrim(ltrim(@e_suministro)) 
						and ts_causa = @e_empresa
						and ts_tipo_chequera = @e_canal
						and ts_usuario = @e_usuario
						and ts_ced_ruc = @e_identificacion
						and ts_correccion = 'N')
			 return @v_Cod_Error

		end

	else
	if @e_empresa = '2494' --KBastidas Se Agrega Validacion para IESS INI

		begin
		  if exists(select 1 from cob_cuentas..cc_tran_servicio 
						where ts_tsfecha = @e_fecha 
						and ts_campo_alt_dos = rtrim(ltrim(@e_suministro))  
						and ts_causa = @e_empresa
						and ts_tipo_chequera = @e_canal
						and ts_usuario = @e_usuario
						and ts_referencia = @e_identificacion						
						and ts_correccion = 'N')
			 return @v_Cod_Error
		end --KBastidas Se Agrega Validacion para IESS FIN
	else
		begin

			if exists(select 1 from cob_cuentas..cc_tran_servicio 
					where ts_tsfecha = @e_fecha 
					and ts_referencia = rtrim(ltrim(@e_suministro)) 
					and ts_causa = @e_empresa
					and ts_tipo_chequera = @e_canal
					and ts_usuario = @e_usuario
					and ts_correccion = 'N')
		 return @v_Cod_Error			
	end
return 0

go

if exists(select 1 from sysobjects where name='pa_pg_pval_rev_core')
	PRINT '== CREATE PROCEDURE pa_pg_pval_rev_core *OK* =='
else
	PRINT '<<< CREATE PROCEDURE pa_pg_pval_rev_core -- ERROR -- >>>'
go

--grant execute on pa_pg_pval_rev_core to apl_osb_hpdes
grant execute on pa_pg_pval_rev_core to apl_osb_hpact