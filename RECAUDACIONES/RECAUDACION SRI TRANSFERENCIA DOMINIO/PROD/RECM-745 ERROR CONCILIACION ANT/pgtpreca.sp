
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_pg_tpag_reca_varios' and type = 'P')
begin
   drop procedure dbo.pa_pg_tpag_reca_varios
   if exists (select 1 from sysobjects where name = 'pa_pg_tpag_reca_varios' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_tpag_reca_varios -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_tpag_reca_varios *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pgtpreca.sp                                     */
/*  Stored procedure:   pa_pg_tpag_reca_varios                          */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Jonathan Guerrero                               */
/*  Fecha de escritura: 05-May-2022                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECMPS-1351                                   */
/*  Ult.Referencia:     REF 4                                           */
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
/*  Este programa procesa pagos/reversos de recaudaciones en via rapida */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  Ref  FECHA       AUTOR          	RAZON                           */
/*  1  05/May/2022  Jonathan Guerrero  	RECESABREC-39  Emisión inicial  */
/*  2  13/Dic/2022 	Kevin Bastidas  	RECESABREC-107  Add campo TC	*/
/*  3  05/May/2023 	Jonathan Guerrero  	RECMPS-2050 Pagos Mixtos ATX  	*/
/*  4  04/Jul/2023 Kevin Bastidas  RECMPS-1351 MIGRACION MICROSERVICIO SRI Tranf Dominio */
/************************************************************************/

create procedure dbo.pa_pg_tpag_reca_varios
(
@e_ssn                  int,
@e_srv                  varchar(30) = '',
@e_user                 varchar(30) = '',
@e_term                 varchar(10),
@e_date                 datetime,
@e_ofi                  int = 1,
@e_rol                  smallint = 1,
@e_corr                 char(1) = 'N',
@e_ssn_corr             int = 0,      
@e_trn                  int,
@e_mon                  tinyint = 1,
@e_ruc_cliente          varchar(13) = '',
@e_servicio             varchar(10) = '',
@e_empresa              varchar(10) = '',
@e_efectivo             money = 0,
@e_cheque               money = 0,
@e_debito               money = 0,
@e_tarjeta              money = 0,
@e_tarjeta_cta          varchar(20) = '', /*<REF 3>*/
@e_tarjeta_plazo        char(2) = '', /*<REF 3>*/
@e_comision_tot         money = 0,
@e_comision_efe         money = 0,
@e_comision_chq         money = 0,
@e_comision_db          money = 0,
@e_total                money = 0,
@e_cant_cheques         int = 0,
@e_tipo_cta             char(3) = '', 
@e_cuenta               varchar(24) = '',
@e_nombre_cta           varchar(70) = '',
@e_autoriza             char(1) = 'N',
@e_canal                char(3) = '',
@e_ubi                  int = 0,
@e_codigo               varchar(15) = '',  
@e_cod_referencia       varchar(30) = '',
@e_nombre_cliente       varchar(32) = '',
@e_base_imponible       money = 0,
@e_factura              varchar(32) = '', 
@e_cod_respuesta        varchar(32) = '',
@e_cod_grupo            varchar(10) = '',
@e_nomb_tramite         varchar(64) = '',
@e_phoralocal           varchar(6)  = '',
@e_cod_consultora		int = 0, 
@s_fecha_contable       varchar(10) = '' out,
@s_ssn                  int = 0 out,
@s_cod_respuesta        int out, 
@s_mensaje_respuesta    varchar(80) = '' out,
@s_horario              char(1) = '' out,
@s_tasa         		money = 0 out,  
@s_base_imp     		float = 0 out, 
@s_impuesto     		float = 0 out,  
@s_servicio_not 		varchar(5) = '' out,	
@s_nomb_ente     		varchar(64) = '' out,	
@s_cod_ente      		varchar(20) = '' out,	
@s_desccanal    		varchar(16) = '' out,	
@s_celular     		    varchar(10) = '' out,	
@s_correo        		varchar(64) = '' out,	
@s_desc_empresa  		varchar(32)  = '' out,	
@s_prod_deb      		char(3) = '' out, 
@s_valor				varchar(11) = '' out, 
@s_fecha_deb			varchar(10) = '' out, 
@s_hora_deb 			varchar(8) = '' out,  
@s_valor_comi			varchar(11) = '' out, 
@s_valor_tot			varchar(11) = '' out, 
@s_cta_lat				char(3)  = '' out, 
@s_tipo_serv 			varchar(16)  = '' out,
@s_envia_notf 			bit = 0 out 
)
  
as

declare @v_return           int,
    @v_hora_tope            int,
    @v_hora_sys             char(8),
    @v_hora                 int,
    @v_fecha_hoy            varchar(10),
	@v_tipocta_emp			char(3),
	@v_cta_emp				char(10),
	@v_nombre_emp           varchar(32),
	@v_efec_dep			    money,
    @v_hora_dif             varchar(9),
    @v_maximo_p       		money,
    @v_tipocta              char(1),
    @v_cod_referencia       varchar(30), 
    @v_num_operacion		varchar(20),
	@v_depEspLinea			bit,
	@v_org                  char(1),
	@v_ocasional       		money,
	@v_aporte_iess			money, 
    @v_autoriz_aut			varchar(8)
	
	/*<REF 4 @v_ocasional v_aporte_iess v_autoriz_aut>*/
select  @v_depEspLinea = 0,
		@v_org = 'D',
		@s_cod_respuesta = 9999,
		@s_ssn = @e_ssn,
		@v_fecha_hoy = convert(varchar(10), getdate(),101),
		@s_horario = 'N',
		@v_hora_sys  = convert(varchar,getdate(),108),
		@v_ocasional = 0, 
		@v_aporte_iess = 0 

if @e_corr = 'N'
	begin
		select @e_date = convert(varchar(10),@e_date,101)  
	end

if @e_date is null
	begin
		select @e_date = fp_fecha 
		from cobis..ba_fecha_proceso
	end

--El campo @v_cod_referencia va a contener el codigo del pago
if len(isnull(@e_cod_referencia,'')) <= len(isnull(@e_codigo,'')) 
	begin
		select @v_cod_referencia = @e_codigo
	end
else
	begin
		select @v_cod_referencia = @e_cod_referencia
	end
	
select @s_fecha_contable = convert(varchar(10),@e_date,101)


if @e_comision_db > 0  
	begin
		select @v_num_operacion = @e_cuenta
	end
else
	begin
		select @v_num_operacion = @v_cod_referencia 
	end


if @e_canal not in ( 'VEN','CNB')  
	begin
		select @e_comision_db = @e_comision_tot
	end

   
  

--HORA TOPE 
     select @v_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
       from cobis..cl_catalogo b 
 inner join cobis..cl_tabla a 
		 on b.tabla = a.codigo
      where a.tabla = 'sv_horario_serv'
        and b.codigo = @e_empresa
        and estado = 'V'
   
if @@rowcount = 0 or @v_hora_tope = 0
    begin
	    select @s_mensaje_respuesta = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
		       @s_cod_respuesta = 130010
        return 130010
    end
    
if exists (select 1
			 from cobis..cl_catalogo b
	   inner join cobis..cl_tabla a 
			   on b.tabla = a.codigo
			where a.tabla = 'sv_emp_recauda_deposito'
			  and b.codigo = @e_empresa and estado = 'V') 
	begin		  					  
		select @v_depEspLinea = 1
		select @e_trn = 4435
		select @v_efec_dep = 0
		select @v_org = 'L'
		
		select @v_cta_emp     = pe_cuenta ,
			   @v_tipocta_emp = pe_producto ,
			   @v_nombre_emp  = substring(pe_nombre ,1,32)
		from cob_pagos..pg_person_empresa
		where pe_empresa = convert(int,@e_empresa)

		if @v_cta_emp is null or @v_cta_emp = ""
		begin
				select @s_mensaje_respuesta = 'CTA EMPRESA NO DEFINIDA',
				       @s_cod_respuesta = 130020
			return 130020
		end
		
	end	
else
	begin
	
		   select @e_trn = convert(int,b.valor)
			 from cobis..cl_catalogo b
	   inner join cobis..cl_tabla a
			   on b.tabla = a.codigo
			where a.tabla = 'sv_trx_srv_rms_hn'
			  and b.codigo = @e_empresa
			  and estado = 'V'
			
	   if @@rowcount = 0 or @e_trn = 0 or @e_trn is null
		begin
			select @s_mensaje_respuesta = 'TRX DE SERVICIO HN NO DEFINIDA',
				   @s_cod_respuesta = 140010
			return 140010
		end
	
	end
	
	
if @e_canal = 'VEN'
   begin
	   
	   --Identifico si estoy en el horario diferido caja
	if @v_depEspLinea = 0
		begin

			 select @v_hora_dif = rh_inicio 
			   from cob_remesas..re_horario 
			  where rh_oficina = @e_ofi and rh_ubicacion = @e_ubi
			 
			 if @v_hora_sys >= @v_hora_dif  
				begin
				
					select @s_horario = 'D'
				
						select @e_trn =  convert(int,b.valor)
						  from cobis..cl_catalogo b
					inner join cobis..cl_tabla a 
							on b.tabla = a.codigo
						 where a.tabla = 'sv_trx_srv_rms_hd1'
						   and b.codigo = @e_empresa
						   and estado = 'V'
				
					if @@rowcount = 0 
						begin
							select @s_mensaje_respuesta = 'TRX DE SERVICIO HD1 NO DEFINIDA',
								   @s_cod_respuesta = 140020
							return 140020
						end
			  
				end 
		end


      exec @v_return = cob_remesas..sp_verifica_caja_rc
					  @s_ssn   = @e_ssn,
					  @s_srv   = @e_srv,
					  @s_lsrv  = @e_srv,
					  @s_user  = @e_user,
					  @s_term  = @e_term,
					  @s_date  = @e_date,
					  @s_ofi   = @e_ofi,
					  @s_rol   = @e_rol,
					  @s_org   = @v_org,
					  @t_trn   = @e_trn,
					  @t_corr  = @e_corr,
					  @i_mon   = @e_mon,
					  @i_ubi   = @e_ubi,
					  @o_horario = @s_horario out
	  
	  if @v_return != 0 or @@error != 0
		  begin
				select @s_mensaje_respuesta = 'HORARIO DE CAJA NO DEFINIDO',
					   @s_cod_respuesta = 300003299
				return 300003299
		   end   
	   
   end

select @s_hora_deb = @v_hora_sys,
       @s_fecha_deb = @v_fecha_hoy
	   	   
if @v_depEspLinea = 1
	begin
		select @e_trn = 43569
	end
   


select @v_hora = convert(int, (substring (@v_hora_sys,1,2) + substring (@v_hora_sys,4,2) + substring (@v_hora_sys,7,2)))

if  @v_depEspLinea = 0 and @v_hora >= @v_hora_tope  and @e_date = @v_fecha_hoy 
	begin

		select @s_horario = 'D'

		    select @e_trn =  convert(int,b.valor)
			  from cobis..cl_catalogo b
		inner join cobis..cl_tabla a 
			    on b.tabla = a.codigo
		     where a.tabla = 'sv_trx_srv_rms_hd2'
			   and b.codigo = @e_empresa
			   and estado = 'V'

		if @@rowcount = 0 
			begin
				select @s_mensaje_respuesta = 'TRX DE SERVICIO HD2 NO DEFINIDA',
					   @s_cod_respuesta = 140030
				return 140030
			end

		select @s_fecha_contable = convert(varchar,min(dl_fecha),101)
		  from cob_cuentas..cc_dias_laborables
		 where dl_ciudad = 1
		   and dl_num_dias = 1
	 
	end


if @e_corr = 'S'
	begin
			
		select @e_trn           = ts_tipo_transaccion,    -- identifica trx original
			   @e_cod_respuesta = ts_campo_alt_uno 
		  from cob_cuentas..cc_tran_servicio (index cc_tran_servicio_secuencial)
		 where ts_secuencial = @e_ssn_corr
		   and ts_causa = @e_empresa
		   and ts_tsfecha = @e_date
		
		 --Valida que exista registrado el pago antes de registrar el reverso
		if @@rowcount = 0 or @e_trn = 0 or @e_trn is null
			begin
				select @s_mensaje_respuesta = 'NO EXISTE TRANSACCIÓN ORIGINAL',
				       @s_cod_respuesta = 18122
				return 18122
			end	
		
	   if @v_hora >= @v_hora_tope  and @e_date = @v_fecha_hoy  and @e_trn = (select convert(int,b.valor)
																			   from cobis..cl_catalogo b
																	     inner join cobis..cl_tabla a 
																			     on b.tabla = a.codigo
																			  where a.tabla = 'sv_trx_srv_rms_hn'
																			    and b.codigo = @e_empresa
																			    and estado = 'V')
		   begin
			   select @s_mensaje_respuesta = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO',
					  @s_cod_respuesta = 358750
			   return 358750
		   end
		   
	end


--VALIDACION DE MONEDA
if @e_mon <> 1
	begin
		select @s_mensaje_respuesta = 'TRANSACCION SOLO SE DEBE REALIZAR EN DOLARES',
		        @s_cod_respuesta = 898994
		return 898994
	end
  
-- VALIDACION DE PARAMETRO DE MONTO MAXIMO
if @e_autoriza = 'N' and  @e_corr = 'N'
   begin
     select @v_maximo_p = pa_money
     from cobis..cl_parametro
     where pa_nemonico = 'MMVI'
     and pa_producto = 'CTE'
	 
		 if (@v_maximo_p <= @e_total )
			 begin
			   select @s_mensaje_respuesta = 'VALOR EXCEDE O ES INFERIOR AL MONTO PERMITIDO SOLICITE AUTORIZACION',
					  @s_cod_respuesta = 311819
			   return 311819
			 end
   end
   
-- CONSULTA DATOS PARA ENVIO DE NOTIFICACION   
exec @v_return = cob_pagos..pa_pg_cpag_notificacion
					@e_empresa              = @e_empresa,
					@e_debito               = @e_debito,
					@e_tarjeta              = @e_tarjeta,
					@e_comision_tot         = @e_comision_tot,
					@e_tipo_cta             = @e_tipo_cta, 
					@e_cuenta               = @e_cuenta,
					@e_tarjeta_cta          = @e_tarjeta_cta, /*<REF 3>*/
					@e_canal                = @e_canal,
					@e_corr                 = @e_corr,
					@s_mensaje_respuesta    = @s_mensaje_respuesta out,
					@s_servicio_not 		= @s_servicio_not out,
					@s_nomb_ente     		= @s_nomb_ente out,
					@s_cod_ente      		= @s_cod_ente out,
					@s_desccanal    		= @s_desccanal out,	
					@s_celular     		    = @s_celular out,
					@s_correo        		= @s_correo out,
					@s_desc_empresa  		= @s_desc_empresa out,
					@s_valor				= @s_valor out,
					@s_valor_comi			= @s_valor_comi out,
					@s_valor_tot			= @s_valor_tot out,
					@s_cta_lat				= @s_cta_lat out,
					@s_tipo_serv 			= @s_tipo_serv out,
					@s_prod_deb             = @s_prod_deb out, /*<REF 3>*/
					@s_envia_notf 			= @s_envia_notf out


if @v_return <> 0 or @@error <> 0 	
	begin
		select @s_servicio_not = 'ERROR NOTIFICACION ' + convert(varchar(30),@v_return),
			   @s_envia_notf  = 0   
	end 
	   


begin tran  

-- REGISTRAR TRX MONETARIA DEBITO/CREDITO
exec @v_return =  cob_pagos..pa_pg_tpag_deb_cre
					@e_ssn                = @e_ssn,
					@e_srv                = @e_srv,
					@e_user               = @e_user,
					@e_term               = @e_term,
					@e_date               = @e_date,
					@e_ofi                = @e_ofi,
					@e_rol                = @e_rol,
					@e_corr               = @e_corr,
					@e_ssn_corr           = @e_ssn_corr,      
					@e_mon                = @e_mon,
					@e_empresa            = @e_empresa,
					@e_efectivo           = @e_efectivo,
					@e_cheque             = @e_cheque,
					@e_debito             = @e_debito,
					@e_cant_cheques       = @e_cant_cheques,
					@e_tipo_cta           = @e_tipo_cta, 
					@e_cuenta	          = @e_cuenta,
					@e_autoriza           = @e_autoriza,
					@e_canal              = @e_canal,
					@e_cod_referencia     = @v_cod_referencia, 
					@e_ubi                = @e_ubi,
					@e_depEspLinea		  = @v_depEspLinea,
					@e_cta_emp			  = @v_cta_emp,
					@e_tipocta_emp		  = @v_tipocta_emp,
					@s_tipocta            = @v_tipocta out,
					@s_mensaje_respuesta  = @s_mensaje_respuesta out

if @v_return <> 0 or @@error <> 0
  begin
	 
	   If @@trancount > 0
			begin
				rollback tran
			end
				
		select @s_mensaje_respuesta = 'ERROR DEB/CRE ' + @s_mensaje_respuesta,
			   @s_cod_respuesta = @v_return
		return @v_return
   end

select @v_autoriz_aut = convert(varchar, @e_comision_tot)

--<REF 4 --SRI e_comision_tot en campo ts_aporte_iess
if @e_empresa = '9718'	
	begin
		select @v_aporte_iess = @e_comision_tot
		select @v_autoriz_aut  = '0'
		
		if @e_debito > 0 
		begin 										
			select @v_ocasional = @e_debito	
			select @e_debito = 0
		end	
	end
--REF 4>

-- REGISTRAR TRX DE SERVICIO
insert into cob_cuentas..cc_tran_servicio(
	ts_secuencial, ts_tipo_transaccion, ts_oficina,
	ts_usuario, ts_rol, ts_terminal,
	ts_correccion, ts_tipo_chequera, ts_reentry,
	ts_origen, ts_nodo, ts_tsfecha,
	ts_clase, ts_fecha, ts_referencia,
	ts_saldo, ts_ssn_corr, ts_cta_banco,
	ts_moneda, ts_tipo, ts_valor,
	ts_monto, ts_ocasional, ts_contratado,
	ts_aporte_iess, ts_descuento_iess, ts_tsn,
	ts_ccontable, ts_hora, ts_endoso,
	ts_causa, ts_tipocta,ts_nombre,
	ts_tipo_def , ts_oficina_cta, ts_cheque_rec,
	ts_ubicacion, ts_descripcion_ec, ts_autoriz_anula,
	ts_campo_alt_uno, ts_autoriz_aut,ts_propietario,
	ts_agente,ts_autorizante,ts_campo_alt_dos,ts_cod_banco , ts_cliente, ts_ced_ruc,
	ts_plazo, ts_tarjcred) /*<REF 3>*/
values(
	@e_ssn, @e_trn, @e_ofi,
	@e_user, @e_rol, @e_term,
	@e_corr, @e_canal, null,
	'L', @e_srv, convert(varchar(10),@e_date,101),
	@e_servicio, @e_date, @e_codigo,
	@e_cheque, @e_ssn_corr, @e_cuenta,
	@e_mon, 'L',  @e_efectivo,
	@e_debito, @v_ocasional, @e_tarjeta, 
	@v_aporte_iess, null, @e_ssn,  
	null, getdate(), @e_ssn,
	@e_empresa, @v_tipocta, isnull(@e_nombre_cliente,@e_nombre_cta),
	'N', null, @e_cant_cheques,
	@e_ubi, @e_nombre_cliente, convert(varchar, @e_base_imponible),
	@e_cod_respuesta, @v_autoriz_aut,@e_cod_grupo, 
	@e_cod_referencia,@e_nomb_tramite,@e_factura,@e_phoralocal, @e_cod_consultora, @e_ruc_cliente,
	@e_tarjeta_plazo, @e_tarjeta_cta) /*<REF 3>*/ 
	/*<REF 4 v_ocasional v_aporte_iess v_autoriz_aut>*/
	if @@error <> 0 or @@rowcount <> 1
		begin
		
		   If @@trancount > 0
				begin
					rollback tran
				end
		   
		   select @s_mensaje_respuesta = 'ERROR EN LA GENERACION DE TRX DE SERVICIO',
				  @s_cod_respuesta = 33005
		   return 33005
		end
	  
  
  

--REGISTRAR TRX COMISION
exec @v_return = cob_pagos..pa_pg_tpag_comision
				@e_ssn                  = @e_ssn,
				@e_srv                  = @e_srv,
				@e_user                 = @e_user,
				@e_term                 = @e_term,
				@e_date                 = @e_date,
				@e_ofi                  = @e_ofi,
				@e_rol                  = @e_rol,
				@e_corr                 = @e_corr,
				@e_ssn_corr             = @e_ssn_corr,      
				@e_trn                  = @e_trn,
				@e_mon                  = @e_mon,
				@e_empresa              = @e_empresa,
				@e_efectivo             = @e_efectivo,
				@e_cheque               = @e_cheque,
				@e_debito               = @e_debito,
				@e_comision_tot         = @e_comision_tot,
				@e_comision_efe         = @e_comision_efe,
				@e_comision_chq         = @e_comision_chq,
				@e_comision_db          = @e_comision_db,
				@e_cant_cheques         = @e_cant_cheques,
				@e_tipo_cta             = @e_tipo_cta, 
				@e_num_operacion		= @v_num_operacion,
				@e_cuenta               = @e_cuenta,
				@e_canal                = @e_canal,
				@e_org                  = @v_org,
				@e_ubi                  = @e_ubi,
				@e_cod_referencia       = @e_cod_referencia,
				@e_nomb_tramite         = @e_nomb_tramite,
				@e_horario			    = @s_horario,
				@e_depEspLinea			= @v_depEspLinea,
				@e_tarjeta				= @e_tarjeta, /*<REF 2, KBastida Add campo TC REF 2>*/
				@s_mensaje_respuesta    = @s_mensaje_respuesta out,
				@s_tasa         		= @s_tasa out,  
				@s_base_imp     		= @s_base_imp out, 
				@s_impuesto     		= @s_impuesto out

if @v_return <> 0 or @@error <> 0
  begin
	 
	   If @@trancount > 0
			begin
				rollback tran
			end
				
		select @s_mensaje_respuesta = 'ERROR COMISION ' + @s_mensaje_respuesta,
			   @s_cod_respuesta = @v_return
		return @v_return
   end
	
	

If @@trancount > 0
	begin
		commit tran
	end
 
select @s_mensaje_respuesta = 'OK',
       @s_cod_respuesta = 0

return 0

go
if exists(select 1 from sysobjects where name='pa_pg_tpag_reca_varios' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_tpag_reca_varios *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_tpag_reca_varios -- ERROR -- >>>'
go

grant execute on pa_pg_tpag_reca_varios to apl_recms_hpact
go
