
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_rec_cfilreader_latinia' and type = 'P')
begin
   drop procedure dbo.pa_rec_cfilreader_latinia
   if exists (select 1 from sysobjects where name = 'pa_rec_cfilreader_latinia' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_rec_cfilreader_latinia -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_rec_cfilreader_latinia *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pa_rec_cfilreader_latinia.sp                    */
/*  Stored procedure:   pa_rec_cfilreader_latinia                       */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                               	*/
/*  Fecha de escritura: 26-Ene-2024                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECMPS-3023                                   */
/*  Ult.Referencia:     REF 1                                           */
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
/************************************************************************/

create procedure dbo.pa_rec_cfilreader_latinia
(
@e_fecha datetime,
@e_empresa int,
@e_numarchivo int
)
as
declare	
    @v_total  int,
	@v_servicio varchar(5),
	@v_detalle varchar(5)        
begin		
		select  @v_servicio = b.codigo, @v_detalle = b.valor 
				from cobis..cl_tabla a
					inner join cobis..cl_catalogo b 
					on a.codigo = b.tabla
				where a.tabla = 'rec_nemonicos_migrados' and estado = 'V'
		
		if @e_empresa = 113
			begin
				set @v_total = (select count(1) 
					from cob_cuentas..cc_debito_cnt
				where cc_empresacnt =  convert(char(5), isnull(@e_empresa,0)) and cc_fecha_inicio = @e_fecha and cc_codigo = '000' and cc_estado in('P'))
			end
		else
			begin
				set @v_total = (select count(1) 
					from cob_pagos..pg_cobro_debitos_servicio 
				where cd_empresa =  convert(char(5), isnull(@e_empresa,0)) and cd_fecha_arc = @e_fecha and cd_cod_error is null and (cd_no_archivo = @e_numarchivo OR @e_numarchivo = 9) and cd_estado in( 'P','F'))			
			end

		select cab_canal = 'DBA', cab_servicio = @v_servicio , cab_cantidad =  convert(varchar(7), @v_total) , cab_tiene_detalle = @v_detalle , cab_empresa = convert(varchar(5), @e_empresa)
		
end

go

if exists(select 1 from sysobjects where name='pa_rec_cfilreader_latinia' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_rec_cfilreader_latinia *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_rec_cfilreader_latinia -- ERROR -- >>>'
go