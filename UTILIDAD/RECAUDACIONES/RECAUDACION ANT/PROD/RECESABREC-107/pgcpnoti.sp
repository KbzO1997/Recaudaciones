
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_pg_cpag_notificacion' and type = 'P')
begin
   drop procedure dbo.pa_pg_cpag_notificacion
   if exists (select 1 from sysobjects where name = 'pa_pg_cpag_notificacion' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_cpag_notificacion -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_cpag_notificacion *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pgcpnoti.sp                                     */
/*  Stored procedure:   pa_pg_cpag_notificacion                         */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Jonathan Guerrero                               */
/*  Fecha de escritura: 05-May-2022                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECESABREC-107                                 */
/*  Ult.Referencia:     REF 2                                           */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'BANCO BOLIVARIANO'.                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/ 
/*              PROPOSITO                                               */
/*  Este programa obtiene los datos para envio de notificaciones        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/* REF     FECHA          AUTOR                  RAZON                  */
/*  1  05/May/2022 Jonathan Guerrero  RECESABREC-39  Emisión inicial    */
/*  2  22/Nov/2022 Kevin Bastidas  	  RECESABREC-107  Latinia TC */
/************************************************************************/

create procedure dbo.pa_pg_cpag_notificacion
(
@e_empresa              varchar(10) = '',
@e_debito               money = 0,
@e_tarjeta              money = 0,
@e_comision_tot         money = 0,
@e_tipo_cta             char(3) = '', 
@e_cuenta               varchar(24) = '',
@e_canal                char(3) = '',
@e_corr                 char(1) = 'N',
@s_mensaje_respuesta    varchar(80) = '' out,
@s_servicio_not 		varchar(5) = '' out,	
@s_nomb_ente     		varchar(64) = '' out,	
@s_cod_ente      		varchar(20) = '' out,	
@s_desccanal    		varchar(16) = '' out,	
@s_celular     		    varchar(10) = '' out,	
@s_correo        		varchar(64) = '' out,	
@s_desc_empresa  		varchar(32)  = '' out,	
@s_valor				varchar(11) = '' out, 
@s_valor_comi			varchar(11) = '' out, 
@s_valor_tot			varchar(11) = '' out, 
@s_cta_lat				char(3)  = '' out, 
@s_tipo_serv 			varchar(16)  = '' out,
@s_envia_notf 			bit out 
)
as

declare @v_return           int,
		@v_cliente          int,
		@v_nombre_cta      	varchar(64),
		@v_valor_debito   	varchar(11), 
		@v_categoria  		char(1)
	
if  @e_debito = 0 and @e_tarjeta = 0
	begin
		select @s_envia_notf = 0
		return 0
	end
  	  
  select @s_desccanal = isnull(b.valor,'')
	from cobis..cl_catalogo b
inner join cobis..cl_tabla a 
	  on b.tabla = a.codigo
   where a.tabla = 'sv_canal_notificacion'
	 and b.codigo = @e_canal 
	 and estado = 'V'
	 
if @s_desccanal = '24ONLINE'
	begin
		select @s_desccanal = '24Online'
	end
  
select @v_valor_debito = convert(varchar(11),@e_debito)
  
if @e_tipo_cta = 'AHO' 
	begin  
		select @v_cliente = isnull(ah_cliente,0),
			   @v_categoria = ah_categoria ,
			   @v_nombre_cta = substring(ah_nombre,1,32)
		from cob_ahorros..ah_cuenta
		where ah_cta_banco = @e_cuenta
		
	end
		
else if @e_tipo_cta = 'CTE' 
	begin
		select @v_cliente = isnull(cc_cliente,0),
			   @v_categoria = cc_categoria ,
			   @v_nombre_cta = substring(cc_nombre,1,32)
		from cob_cuentas..cc_ctacte
		where cc_cta_banco = @e_cuenta
		
	end

else if @e_tipo_cta = 'TC' 
	 begin
		 
			select @v_cliente= isnull(b.en_ente,0),
				   @v_nombre_cta= b.en_nombre 
			  from db_tarjeta_bb..tc_tarjetas_credito a 
		inner join cobis..cl_ente b	
				on a.ta_identificacion=b.en_ced_ruc
			 where a.ta_clave_unica = @e_cuenta
					  
			 select @v_valor_debito = convert(varchar(11),@e_tarjeta)
	end
			
if exists(select 1 
			from cobis..cl_catalogo c 
	  inner join cobis..cl_tabla t
			  on c.tabla = t.codigo 
		   where c.codigo = @e_empresa 
			 and t.tabla = 'sv_emp_grupotvcable'
			 and c.estado = 'V') 
	begin
		select @s_desc_empresa ='TVCABLE' ,  @s_tipo_serv = 'FACTURA'
	end
else 
	begin
		select @s_desc_empresa ='SERVICIOS VARIOS' , 				  
			   @s_tipo_serv = 'FACTURA'
	end
	
			
select @s_desc_empresa = isnull(b.valor,@s_desc_empresa)
	from cobis..cl_catalogo b
inner join cobis..cl_tabla a 
	  on b.tabla = a.codigo
   where a.tabla = 'sv_empresas_latinia'
	 and b.codigo = @e_empresa 
	 and estado = 'V'
	 
							
select @s_tipo_serv  = isnull(b.valor,@s_tipo_serv)
	from cobis..cl_catalogo b
inner join cobis..cl_tabla a 
	  on b.tabla = a.codigo
   where a.tabla = 'sv_servicio_notificacion'
	 and b.codigo = @e_empresa 
	 and estado = 'V'
						

exec  @v_return = cob_pagos..sp_consulta_celular
				  @i_cliente = @v_cliente,
				  @o_celular = @s_celular out,
				  @o_correo  = @s_correo  out
				  
if @v_return <> 0 or @@error <> 0
	begin				
		select @s_envia_notf = 0,				
			   @s_mensaje_respuesta = 'ERROR CONSULTA NOTIFICACION'
		return 171717
	end

	
if @e_corr = 'N'
	begin
		select @s_servicio_not = 'PAGSB'
	end
else
	begin
		select @s_servicio_not = 'PAGSR'
	end	


if @e_canal ='CNB'
	begin	 
		if @e_corr = 'N'
			begin
				select @s_servicio_not = 'PAGCN'
			end
		else
			begin
				select @s_servicio_not = 'PGCRN'
			end
	end
		
select @s_nomb_ente = @v_nombre_cta,
	   @s_cod_ente =  convert(varchar(20),@v_cliente) ,
	   @s_valor = @v_valor_debito,	
	   @s_valor_comi = convert(varchar, @e_comision_tot),
	   @s_valor_tot =  convert(varchar,(convert(money,isnull(@v_valor_debito,'0'))+ @e_comision_tot)),
	   @s_cta_lat = (case @e_tipo_cta when 'TC' then substring(@e_cuenta,18,3) else substring(@e_cuenta,8,3) end),  /*<REF 2, Latinia TC REF 2>*/
	   @s_mensaje_respuesta = 'OK',
	   @s_envia_notf = 1

return 0

go
grant execute on pa_pg_tpag_comision to apl_recms_hpact
go
if exists(select 1 from sysobjects where name='pa_pg_cpag_notificacion' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_cpag_notificacion *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_cpag_notificacion -- ERROR -- >>>'
go

