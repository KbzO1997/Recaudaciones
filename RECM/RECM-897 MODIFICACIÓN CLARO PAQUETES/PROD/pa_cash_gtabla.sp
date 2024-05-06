/***********************************************************************************/
/*  Archivo:            pa_cash_gtabla.sp                                     		*/
/*  Motor de Base: 		SYBASE                     					   				*/
/*  Base de datos:      cob_internet                                       			*/
/*  Servidor: 			HP-ACT                                       				*/
/*  Aplicacion: 		Cyberbank	                                				*/
/*  Stored procedure:   pa_cash_gtabla                         						*/
/*  Procesamiento: 		OLTP	                                       				*/
/*  Ult.ControlTarea:   J-RECM-897                       							*/
/*  Ult.Referencia:     REF 02                          		 					*/
/*  Producto:           BIB                              							*/
/*  Disenado por:       Daniela Garaicoa                         					*/
/*  Fecha de escritura: 2016/03/14                                     				*/
/***********************************************************************************/
/*                               PROPOSITO                                         */
/* OLTP - El siguiente procedure permite obtener los parametros de una tabla       */
/***********************************************************************************/
/*  REF      FECHA               AUTOR               RAZON              MOTIVO     */
/*    1 2016/05/20 Daniela Garaicoa CHBOT-AP-SGC00030131-SGC00030199 	Consulta parametros    */
/*    1 2018/10/02 Jorge Villavicencio INT-CE-SGC00033096 	Consulta parametros    */
/*	  2 2024/04/26	Kevin Bastidas	RECM-897 MODIFICACIÓN CLARO PAQUETES		   */
/***********************************************************************************/

use cob_internet
go
if exists(select 1 from sysobjects where name = 'pa_cash_gtabla' and type = 'P')
begin
   drop procedure dbo.pa_cash_gtabla
   if exists (select 1 from sysobjects where name = 'pa_cash_gtabla' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_cash_gtabla -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_cash_gtabla *OK* =='
end
go

create  proc dbo.pa_cash_gtabla(
	@e_tabla varchar(50),
	@s_codigo_respuesta int = 0 output,
	@s_mensaje_usuario varchar(132) = '' output,
	@e_canal char(3) = 'BIB'
)
as
begin

select @s_codigo_respuesta = 1, @s_mensaje_usuario = 'ERROR'

	if @e_tabla = 'cl_valor_paquetes_claro_online'  /*<REF 02 If Ordenamiento REF 02>*/
		select 
			cat.tabla id_tabla,
			cat.codigo parametro,
			convert(varchar(64),valor) valor 
		from cobis..cl_catalogo cat
		inner join cobis..cl_tabla tab on tab.codigo = cat.tabla 
			where tab.tabla = @e_tabla
			and cat.estado = 'V'
			order by convert(float,cat.codigo,0) asc
	else
		select 
			cat.tabla id_tabla,
			cat.codigo parametro,
			convert(varchar(64),valor) valor 
		from cobis..cl_catalogo cat
		inner join cobis..cl_tabla tab on tab.codigo = cat.tabla 
			where tab.tabla = @e_tabla
			and cat.estado = 'V'
	
	if @@rowcount = 0                              
		begin
			select @s_mensaje_usuario = 'No existe dato en catalogo', @s_codigo_respuesta = 101000
			return @s_codigo_respuesta
		end		
		
	select @s_codigo_respuesta = 0, @s_mensaje_usuario = 'TRANSACCION EXITOSA'		
	
 return 0				
end

go
grant execute on pa_cash_gtabla to apl_osb_hpact
grant execute on pa_cash_gtabla to apl_recms_hpact

if exists(select 1 from sysobjects where name='pa_cash_gtabla' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_cash_gtabla *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_cash_gtabla -- ERROR -- >>>'
go