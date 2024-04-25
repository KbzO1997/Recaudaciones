use cob_internet
go
if exists(select 1 from sysobjects where name = 'pa_cash_cprocesar_tarifaBP' and type = 'P')
begin
     drop procedure dbo.pa_cash_cprocesar_tarifaBP
	 if exists (select 1 from sysobjects where name = 'pa_cash_cprocesar_tarifaBP' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_cash_cprocesar_tarifaBP -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_cash_cprocesar_tarifaBP *OK* =='
end
go

/***************************************************************************/
/*  Archivo: 			pa_cash_cprocesar_tarifaBP.sp                    	*/
/*  Motor de Base: 		SYBASE                     					   		*/
/*  Base de datos: 		cob_internet                                     	*/
/*  Servidor: 			HP-ACT                                           	*/
/*  Aplicacion: 		Cyberbank	                                    	*/
/*  Stored Procedure: 	pa_cash_cprocesar_tarifaBP	                   		*/
/*  Procesamiento: 		OLTP	                                       	   	*/
/*  Producto: 			BIB                                              	*/
/*  Desarrollado Por: 	Daniela Garaicoa                                 	*/
/*  Derechos de Autor: 	Banco Bolivariano C.A.                           	*/
/*  Fecha de Escritura: 	2016/06/07                                      */
/****************************************************************************/
/*                               PROPOSITO                                   */
/* OLTP - El siguiente procedure permite comision en banca personas  	     */
/*****************************************************************************/
/*  REF      FECHA               AUTOR               RAZON              MOTIVO     */
/*    1 2016/06/07 Daniela Garaicoa REMPL_BCA_PERS_EMPR 	Obtiene comision BP    */
/* 	  2 2017/08/23 Robinson Macias Sandoval REMPL_BCA_PERS_EMPR   adhesion de campo */
/*															por cobro en tarifario*/
/*    3 2017/12/07 Ronald Suquinagua    CHBOT-AP-SGC00030131-SGC00030199 Consultar por Transferencias SPI o PAGDIR*/
/*    4 2018/08/27 mleonl  RCASH-AP-SGC00026212-SGC00026219 Ajustes pago servicios*/
/*    5 2018/09/04 mleonl  RCASH-AP-SGC00026212-SGC00026219 Valor contratado multicanal/WAP 6*/
/*    6 2018/10/25 mleonl  RCASH-AP-SGC00026212-SGC00026219 Consulta Banco internacional*/
/*    7 19/ABRIL/2019 Jonathan Lopez   BV-CC-35071    Optimizar consulta */
/*    8 23/Feb/2022 Kevin Bastida   RECM-519    CONSULTA Y PAGO RECAUDACION TERCON */
/***********************************************************************************/

create procedure dbo.pa_cash_cprocesar_tarifaBP 
(
@e_identificacion   varchar(20),
@e_servicio         varchar(4) = null,
@e_id_funcionalidad varchar(100),
@e_canal         varchar(16),
@e_codigo_empresa_proveedora  int = null,
@e_accion_revocatoria_ch      char(4) = null,
@e_cuenta          varchar(20) = null,
@e_tipo_cuenta     char(3) = null, 
@e_tipo_impuesto_fiscal         char(10) = null,
@e_codigo_empresa  int = null, 	
@e_pais         int = null, 
@s_comision float   = 0 output,
@s_comi_trans money = 0 output,
@s_costo_envio money = 0 output,
@s_codigo_respuesta int = 0 output,
@s_mensaje_usuario 	varchar(132) = '' output,
@s_transaccion int = 0 output,
@s_causa varchar(10) = '' output,
@e_se_debita varchar(5) = 'false',
@s_cobrado_en_tarifario		char(1)='S' output,--REF2
@e_tipo_transfer varchar(20) = null,   --REF 3 
@e_monto_transfer money = 0, -- Monto de transferencia, solo usado en transwift REF. 3
@e_cargo varchar(5) = 'OUR', -- Quien asume el pago de transferencia (OUR|SHA), solo usado en transwift
@e_bco_internacional varchar(15) = null  --Ref. 6
)

as
begin

	declare @s_ssn              int,
		@s_user             VARCHAR(30),
		@s_sesn             int,
		@s_term             varchar(30) ,
		@s_date             datetime,
		@s_srv              varchar(30) ,
		--@s_lsrv             varchar(30),
		@s_ofi              smallint,
		@s_rol              smallint,
		--@s_org_err          char(1),
		@s_error            int,
		--@s_sev              tinyint,
		@s_msg              varchar(4000),
		@s_org              char(1),
		--@t_debug            char(1),
		--@t_file             varchar(10),
		--@t_from             varchar(32),
		--@t_trn              int,
		--@o_msj_error        varchar(132),
		@v_id_servicio		int,
		@v_retorno 		 	int,
		@v_transaccion 		varchar(10),
		@v_tipo_cuenta int, --Ref. 4
		@v_cod_servicio char(4),
		@v_opcion char(1),
		@v_rubro char(10),
		@v_tabla varchar(50),
		@v_tipo_ente char(1),
		@v_cod_colegio int, 
		@s_cobro_cliente char(1),
		@v_canal         char(4) --REF6 LBP 

	select 
		@s_codigo_respuesta = 101113, 
		@s_mensaje_usuario = 'ERROR GENERAL O PARAM. NO INGRESADA'

	-- REF04 Validacion de comision de Pago de Servicios 
	--if(@e_codigo_empresa_proveedora = 1111	OR @e_codigo_empresa_proveedora = 1112 OR @e_codigo_empresa_proveedora = 1113 OR @e_codigo_empresa_proveedora = 1114 OR @e_codigo_empresa_proveedora = 1929) --kbastida RECM-519 se add codigos 1114 - 1929
	if exists ( select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla --kbastida RECM-519 CREACION DE CATALOGO DE EMPRESAS PARA TARIFA BP
			    where t.tabla = 'sv_grp_emp_tarifabp' 
			    and c.estado = 'V' and c.codigo = @e_codigo_empresa_proveedora) 
		begin
			select @e_codigo_empresa_proveedora = convert(INT, @e_servicio)
		end

	-- REF04 Se coloca para el pago de SRI
	if(@e_codigo_empresa_proveedora = 5993 AND @e_servicio = 'MATV')
		begin
			select @e_codigo_empresa_proveedora = 2
		end

		exec cobis..pa_CanalesNoCobis_interfase
		@i_canal            = 'IBK',    
		@s_ssn              = @s_ssn out,
		@s_user             = @s_user out,
		@s_sesn             = @s_sesn out,
		@s_term             = @s_term out,
		@s_date             = @s_date out,
		@s_srv              = @s_srv  out,
		@s_ofi              = @s_ofi  out,
		@s_rol              = @s_rol  out,
		@s_error            = @s_error  out,
		@s_org              = @s_org  out

if  @e_identificacion = '' or @e_identificacion is null 

begin
		select @s_codigo_respuesta = 101474, 
			   @s_mensaje_usuario = 'DEBE INGRESAR NUMERO DE IDENTIFICACION'


		return @s_codigo_respuesta
end

-- TRANSFORMACION DE NEMONICO DE TIPO DE CUENTAS A ID TIPO CUENTA

	 if @e_tipo_cuenta is not null
		begin
			 if @e_tipo_cuenta = 'AHO'
				 begin
					select @v_tipo_cuenta = 4	 
				 end
			 else 	if @e_tipo_cuenta = 'CTE'
				 	begin
						select @v_tipo_cuenta = 3	 
				 	end
					else 	if @e_tipo_cuenta = 'BAS'
			 				begin
								select @v_tipo_cuenta = 12	 
			 				end
			  				else 	if @e_tipo_cuenta = 'VIR'
			 						begin
										select @v_tipo_cuenta = 12	 
			 						end
		end--if @e_tipo_cuenta is not null

		 
		if @e_servicio = 'CIES' and @e_canal <> 'CNB'
		begin
			exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_tipo_cuenta = @e_tipo_cuenta,
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2
				
			if @v_retorno <> 0
				begin
					if (@v_retorno = 1621006)
						begin
								select @s_codigo_respuesta = 0, 
									   @s_mensaje_usuario = convert(varchar(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario, 
									   @s_comision = 0
								return @s_codigo_respuesta
						end

					return @s_codigo_respuesta			
				end

			if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end
			
			if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))
			begin
					select @s_codigo_respuesta = 5005029,

						   @s_mensaje_usuario = 'No existe transaccion ni causa para este producto'
					return @s_codigo_respuesta
			end
			
			select @s_transaccion = convert(int, @v_transaccion)
		
			select @v_cod_servicio = 'CIES'
			select @v_opcion = 'N'
			  --ref7
			--select @v_tipo_ente = en_subtipo from cobis..cl_ente where en_ced_ruc = @e_identificacion

			--if @@rowcount = 0
			--	begin
			--		select @v_tipo_ente = en_subtipo from cobis..cl_ente where p_pasaporte = @e_identificacion
			--	end
			
			--ref7
			set @v_tipo_ente = null
			exec pa_cash_ccliente_cedula @e_identificacion, @s_subtipo = @v_tipo_ente out
			if @v_tipo_ente is null
			   begin
			     exec pa_cash_ccliente_pasaporte @e_identificacion, @s_subtipo = @v_tipo_ente out
			   end
			if @v_tipo_ente = 'P'	
				begin
					select @v_rubro = 'IESS'
				end
			else 
				begin
					select @v_rubro = 'IESJ' 
				end				
		end


	-- VALIDAR CUENTA
	if @e_cuenta is not null 
	begin

	declare @v_tipo_identificacion char(1),
			@v_identificacion varchar(20)

	exec @v_retorno = cob_internet..pa_cash_cidentTipoIdentxCta
		@e_cuenta_destino = @e_cuenta,
		@s_tipo_identificacion = @v_tipo_identificacion output,
		@s_identificacion = @v_identificacion  output

	if @v_retorno <> 0
		begin
			select  	@s_codigo_respuesta = 251030,
						@s_mensaje_usuario= 'Error en tabla de cuentas'				
			return @s_codigo_respuesta			
		end

	if @v_identificacion is null                             
		begin
			select @s_mensaje_usuario = 'CUENTA NO EXISTE', @s_codigo_respuesta = 18755
			return @s_codigo_respuesta
		end
	end

	
	-- SWIFT
	if @e_pais is not null	
		begin
			exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_tipo_cuenta = @e_tipo_cuenta,					
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2


			if @v_retorno <> 0
				begin		
					if (@v_retorno = 1621006)
						begin
								select @s_codigo_respuesta = 0, 
									   @s_mensaje_usuario = convert(varchar(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario, 
									   @s_comision = 0
								return @s_codigo_respuesta
						end
					return @s_codigo_respuesta			
				end

			if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end
		
			if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))
			begin
					select @s_codigo_respuesta = 5005029,

						   @s_mensaje_usuario = 'No existe transaccion ni causa para este producto'
					return @s_codigo_respuesta
			end
		
			select @s_transaccion = convert(int, @v_transaccion)
            --Inicio Ref. 6		
            if @e_tipo_cuenta = 'AHO'
				select @v_tipo_cuenta = 4	 
			else
				select @v_tipo_cuenta = 3
            --Fin Ref. 6
			exec @v_retorno = cob_internet..pa_cash_ccons_otrbcos
				@e_user        = @s_user,  
				@e_ofi         = @s_ofi,  
				@e_date    = @s_date,  
				@e_term        = @s_term,  
				@e_rol         = @s_rol,  
				@e_srv         = @s_srv,  
				 --     t_online      = @t_online,  
				@e_trn         = 18708,   
				@e_ejec        = 'R',  
				@e_opcion     = 'O',  
				@e_cuenta = '9999',
				@e_canal = 'BNK', --Ref04
				-- @i_tipcargo = '',
				@e_pais = @e_pais,
				@e_tipo_cta = @e_tipo_cuenta, --Ref. 6
				@e_cargos = @e_cargo,
                @e_tabla = @e_cuenta, --Ref. 6
                @e_autorizacion = @v_tipo_cuenta, --Ref. 6
				@e_banco = @e_bco_internacional, --Ref. 6
				@e_valor_transf = @e_monto_transfer, --Ref. 3
				@s_comi_trans =  @s_comision  output,-- @s_comi_trans  output,
				@s_costo_envio = @s_costo_envio output


				select @s_comi_trans = @s_comision
				
				if @v_retorno = 0
				begin
					select  	@s_codigo_respuesta = 0,
								@s_mensaje_usuario= 'TRANSACCION EXITOSA'				
					return @s_codigo_respuesta			
				end

				if @v_retorno <> 0
				begin
					select  	@s_codigo_respuesta = 5004007,
								@s_mensaje_usuario= 'Error en la consulta, Formula Comision'				
					return @s_codigo_respuesta			
				end
			return 0
		end
		
	-- IMPUESTO FISCAL		

	if @e_tipo_impuesto_fiscal is not null	
	begin

			exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_tipo_impuesto_fiscal = @e_tipo_impuesto_fiscal,
					@e_tipo_cuenta = @e_tipo_cuenta,					
					@s_tf_opcion = @v_opcion output, 
					@s_tf_rubro = @v_cod_servicio output, 
					@s_tf_tipoImpuestoFiscal = @v_rubro output, 
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2

			if @v_retorno <> 0
				begin
					if (@v_retorno = 1621006)
						begin
								select @s_codigo_respuesta = 0, 
									   @s_mensaje_usuario = convert(varchar(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario, 
									   @s_comision = 0
								return @s_codigo_respuesta
						end
					return @s_codigo_respuesta			
				end

				if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end
			
				if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))
					begin
							select @s_codigo_respuesta = 5005029,
								   @s_mensaje_usuario = 'No existe transaccion ni causa para este producto'
							return @s_codigo_respuesta
					end
			
			select @s_transaccion = convert(int, @v_transaccion)
		end

	-- BLOQUEO CHEQUES
	if @e_accion_revocatoria_ch is not null
		begin
			exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_accion_revocatoria_ch = @e_accion_revocatoria_ch,
					@e_codigo_empresa_proveedora = null,
					@e_tipo_cuenta = @e_tipo_cuenta,					
					@s_tf_opcion = @v_opcion output, 
					@s_tf_rubro = @v_rubro output, 
					@s_tf_accionRevocatoria = @v_cod_servicio output, 
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2

			if @v_retorno <> 0
				begin	
					if (@v_retorno = 1621006)
						begin
								select @s_codigo_respuesta = 0, 
									   @s_mensaje_usuario = convert(varchar(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario, 
									   @s_comision = 0
								return @s_codigo_respuesta
						end
					return @s_codigo_respuesta			
				end

			if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end
				
			if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))
				begin
						select @s_codigo_respuesta = 5005029,

							   @s_mensaje_usuario = 'No existe transaccion ni causa para este producto'
						return @s_codigo_respuesta
				end	
					
			select @s_transaccion = convert(int, @v_transaccion)
		end


	-- TRANSFERENCIAS-DEPOSITOS ESPECIALES	Y PAGO DE SERVICIOS
	if @e_codigo_empresa_proveedora is not null and @e_servicio != '12'
		begin						


			exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_codigo_empresa_proveedora = @e_codigo_empresa_proveedora,
					@e_tipo_cuenta = @e_tipo_cuenta,					
					@s_tf_opcion = @v_opcion output, 
					@s_tf_codigo = @v_cod_servicio output, 
					@s_tf_rubro = @v_rubro output, 
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2


			if @v_retorno <> 0
				begin		
					if (@v_retorno = 1621006)
						begin
		select @s_transaccion = convert(int, @v_transaccion)	
						exec @v_retorno = cob_internet..pa_cash_ccons_otrbcos
						@e_user = @s_user,  
						@e_ofi = @s_ofi,  
						@e_date = @s_date,  
						@e_term  = @s_term,  
						@e_rol = @s_rol,  
						@e_srv = @s_srv,  
						@e_trn = 18664,   
						@e_ejec = 'R',  
						@e_opcion = 'I',  
						@e_codigo = 'REE',  
						@e_cod_general = @e_codigo_empresa_proveedora, --@e_codigo_empresa,
						@e_alcance = '',
						@e_tipo_comision = '02',
						@e_producto = 4,
						@e_cuenta = @e_cuenta,
						@e_tipo_cuenta = @v_tipo_cuenta,
						@e_canal = 'BNK',
						@e_servicio = 'REE',
						@s_costo_BB  = @s_comision out

					if @v_retorno <> 0
						begin
							select @s_codigo_respuesta = 5004007,
							       @s_comision = 0,
								   @s_mensaje_usuario= 'OPCION I - PARAMETRIZACION FALTANTE O INVALIDA ('+convert(varchar,@v_retorno)+')'				
							return @s_codigo_respuesta			
						end

					if @s_comision is not null
						begin
							select @s_codigo_respuesta = 0,
								   @s_mensaje_usuario = 'TRANSACCION EXITOSA'				
							return @s_codigo_respuesta			
						end							
						return 0
						end
					return @s_codigo_respuesta			
				end		

				if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end

				if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))

				begin
					select @s_codigo_respuesta = 5005029,
						   @s_mensaje_usuario = 'NO EXISTE TRANSACCION O CAUSA PARA ESTE PRODUCTO'

					return @s_codigo_respuesta
				end					


			end

		
		 --Inicio Ref04
         if @e_servicio = '12'--este es el convenio de colegios en OTC
		 begin
			select @v_cod_colegio = pa_cod_empresa
			from db_biz_admempresa..ba_parametroconf
			where pa_cod_producto = 4
			and pa_cod_servicio  = 'COLEGIOS'
			and pa_cod_parametro = 'CODCOLEGIO'
			and convert(int,pa_val_caracter) = @e_codigo_empresa_proveedora
			
			exec @v_retorno = db_biz_cobros..sp_comision_cliente_get 
				@i_empresa = @v_cod_colegio,
				@i_producto = 4 , 
				@i_servicio = 'COLEGIOS' ,
				@i_aplcobis = 'N',
				@i_fecha = @s_date,
				@i_canal = 'BNK',
				@o_cobro_cliente = @s_cobro_cliente out,
				@o_valor_comision = @s_comision out
				
			if @v_retorno <> 0

				begin
					select @s_codigo_respuesta = @v_retorno,
					@s_mensaje_usuario= 'ERROR AL OBTENER VALORES DE SAT ('+convert(varchar,@v_retorno)+')',
					@s_comision = 0
					return @s_codigo_respuesta
				end
			if @s_comision is not null			
			begin
				if @s_cobro_cliente = 'S'
					begin
						select @s_codigo_respuesta = 0,
						@s_mensaje_usuario = 'TRANSACCION EXITOSA'				
						return @s_codigo_respuesta			
					end
				else
					begin
						select @s_codigo_respuesta = 0,
						@s_mensaje_usuario = 'COMISION NO COBRADA A CLIENTE',
						@s_comision = 0
						return @s_codigo_respuesta			
					end
	 		end				
			return 0			
		end
        --Fin Ref04
	

	if (@v_opcion <> 'X')
		begin
			if(@e_canal	= 'BIB')
				begin
					set @e_canal = 'IBK'
				end
		end
	--Ref04 Fin

							
	if (@e_accion_revocatoria_ch is null and @e_codigo_empresa_proveedora is null 
		and @e_tipo_impuesto_fiscal is null and @e_codigo_empresa is null and ( @e_servicio <> 'CIES' or (@e_servicio = 'CIES' and @e_canal = 'CNB')))
	begin

--AQUIIIIII ENVIAR EL NUEVO CAMPO!!!

	-- Buscar funcionalidad en tabla de funcionalidades por tarifa (caso normal por Person)
	-- Nota: esto no toma en cuenta el canal guardado

	exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
					@e_id_funcionalidad = @e_id_funcionalidad,
					@e_ambito = 'BP',
					@e_tipo_cuenta = @e_tipo_cuenta,		
					@e_tipo_transfer = @e_tipo_transfer,
					@s_tf_opcion = @v_opcion output, 
					@s_tf_tabla = @v_tabla  output,
					@s_tf_codigo = @v_cod_servicio output, 
					@s_tf_rubro = @v_rubro output, 
					@s_codigo_respuesta = @s_codigo_respuesta output,
					@s_mensaje_usuario = @s_mensaje_usuario output,
					@s_tf_transaccion  = @v_transaccion output, 
					@s_tf_causa = @s_causa output,
					@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario output--REF2

			if @v_retorno <> 0
				begin	
					if (@v_retorno = 1621006)
						begin
								select @s_codigo_respuesta = 0, 
									   @s_mensaje_usuario = convert(varchar(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario, 
									   @s_comision = 0
								return @s_codigo_respuesta
						end			
					return @s_codigo_respuesta			
				end

			if @s_codigo_respuesta <> 0
				begin
					return @s_codigo_respuesta				
				end

			if (@e_se_debita = 'true' and (@v_transaccion is null or @s_causa is null))
				begin
						select @s_codigo_respuesta = 5005029,

							   @s_mensaje_usuario = 'No existe transaccion ni causa para este producto'
						return @s_codigo_respuesta
				end
				
			select @s_transaccion = convert(int, @v_transaccion)

	if (@v_opcion <> 'X')
		begin
			if(@e_canal	= 'BIB')
				begin


					set @e_canal	= 'IBK'

				end
		end			
				
	if @v_opcion = 'S'	
		begin
			--REF6 INI LBP se agrega
			if @e_canal <> 'WAP'
				select @v_canal = 'BNK'
			else
				select @v_canal = @e_canal
			--REF6 FIN LBP

			exec @v_retorno = cob_internet..pa_cash_ccons_otrbcos
			@e_user        = @s_user,  
			@e_ofi         = @s_ofi,  
			@e_date    = @s_date,  
			@e_term        = @s_term,  
			@e_rol         = @s_rol,  
			@e_srv         = @s_srv,    
			@e_trn         = 18708,   
			@e_ejec        = 'R',  
			@e_opcion     = 'S',  
			@e_tabla    = @v_tabla,   
 		    @e_codigo    = @v_canal,  --REF6 LBP --'BNK',  
			@s_costo_BB  = @s_comision out

			if @v_retorno <> 0
				begin
					select  	@s_codigo_respuesta = 5004007,

								@s_mensaje_usuario= 'Error en la consulta, Formula Comision'				
					return @s_codigo_respuesta			

				end

			if @s_comision is not null
				begin
					select  	@s_codigo_respuesta = 0,
								@s_mensaje_usuario= 'TRANSACCION EXITOSA'				
					return @s_codigo_respuesta			
				end
			return 0
		end	
	end
	
	if @v_opcion = 'N'	
		begin
		exec @v_retorno = cob_internet..pa_cash_ccons_otrbcos
			@e_user        = @s_user,  
			@e_ofi         = @s_ofi,  
			@e_date    = @s_date,  
			@e_term        = @s_term,  
			@e_rol         = @s_rol,  
			@e_srv         = @s_srv,   
			@e_trn         = 18664,   
			@e_ejec        = 'R',  
			@e_opcion     = 'N',  
		    @e_codigo    = @v_cod_servicio,   --servicio
			@s_servicio  = @v_id_servicio out

			if @v_retorno <> 0 or @v_id_servicio is null
				begin
					select  	@s_codigo_respuesta = 5005038,

								@s_mensaje_usuario= 'Inconsistencia en los parametros de la funcionalidad',
								@s_comision = 0
					return @s_codigo_respuesta			
				end

		-- PERSON
		-- En reunion con Pablo Vivanco 20180123 se solicito que las tarifas ingresadas por GRYP sean IBK en person, en cuyo caso se quema IBK
			exec @v_retorno = cob_internet..pa_cash_cvalor_contratado-- cob_remesas..sp_valor_contratado
	        @e_ssn		= @s_ssn, 
			@e_srv		= @s_srv, 
			@e_user		= @s_user,
			@e_sesn         = @s_sesn,
			@e_term		= @s_term,
			@e_date		= @s_date, 
			@e_ofi		= @s_ofi,
			@e_rol		= @s_rol,
			@e_error	= @s_error,
			@e_msg		= @s_msg, 
			@e_org		= @s_org,			
			@e_trn		= 17073, 
			@e_ejec         = 'R',
			@e_oficina	= @s_ofi,
			@e_operacion	= 'C',
			@e_producto	= @v_tipo_cuenta,
			@e_cuenta	= @e_cuenta,
			@e_servicio	= @v_id_servicio,  
			@e_rubro	= @v_rubro, --costo de la anulacion
			@e_canal	= @e_canal, --Ref. 5
			@s_comision = @s_comision out

			if @v_retorno <> 0 or @s_comision is null
				begin
					select  	@s_codigo_respuesta = 5004007,

								@s_mensaje_usuario= 'Error en la consulta, Formula Comision',
								@s_comision	= 0		
					return @s_codigo_respuesta			
				end

			if @s_comision is not null
			begin
				select  	@s_codigo_respuesta = 0,
							@s_mensaje_usuario= 'TRANSACCION EXITOSA'				
				return @s_codigo_respuesta			
			end

		end	
	return 0
end
		
				
go
grant execute on pa_cash_cprocesar_tarifaBP to apl_osb_hpact
go

if exists(select 1 from sysobjects where name='pa_cash_cprocesar_tarifaBP' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_cash_cprocesar_tarifaBP *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_cash_cprocesar_tarifaBP -- ERROR -- >>>'
  
go
