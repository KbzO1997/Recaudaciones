
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_pg_tpag_comision' and type = 'P')
begin
   drop procedure dbo.pa_pg_tpag_comision
   if exists (select 1 from sysobjects where name = 'pa_pg_tpag_comision' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_tpag_comision -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_tpag_comision *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pgtpcomi.sp                                     */
/*  Stored procedure:   pa_pg_tpag_comision                             */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Jonathan Guerrero                               */
/*  Fecha de escritura: 05-May-2022                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECMPS-1351                                   */
/*  Ult.Referencia:     REF 6                                           */
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
/*  Este programa registra la comision de la recaudacion por via rapida */
/*  Este SP solo puede ser ejecutado por pa_pg_tpag_reca_varios         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/* REF     FECHA          AUTOR                  RAZON                  */
/*  1  05/May/2022 Jonathan Guerrero  RECESABREC-39  Emisión inicial    */
/*  2  22/Nov/2022 Kevin Bastidas  	  RECESABREC-107  Add Letra Por Comi. Efec*/
/*  3  13/Dic/2022 Kevin Bastidas  	  RECESABREC-107  Add campo TC		*/
/*  4  05/May/2023 Jonathan Guerrero  RECMPS-2050 Pagos Mixtos ATX  	*/
/*  5  24/May/2023 Kevin Bastidas  RECMPS-2117 MIGRACION MICROSERVICIO CLARO SERVICIOS FIJOS */
/*  6  04/Jul/2023 Kevin Bastidas  RECMPS-1351 MIGRACION MICROSERVICIO SRI Tranf Dominio */
/************************************************************************/

create procedure dbo.pa_pg_tpag_comision
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
@e_empresa              varchar(10) = '',
@e_efectivo             money = 0,
@e_cheque               money = 0,
@e_debito               money = 0,
@e_comision_tot         money = 0,
@e_comision_efe         money = 0,
@e_comision_chq         money = 0,
@e_comision_db          money = 0,
@e_cant_cheques         int = 0,
@e_tipo_cta             char(3) = '', 
@e_num_operacion		varchar(20),
@e_cuenta               varchar(24) = '',
@e_canal                char(3) = '',
@e_org                  char(1),
@e_ubi                  int = 0,
@e_cod_referencia       varchar(30) = '',
@e_nomb_tramite         varchar(64) = '',
@e_horario				char(1),
@e_depEspLinea			bit,
@e_tarjeta				money = 0, /*<REF 3, KBastida Add campo TC REF 3>*/
@s_mensaje_respuesta    varchar(80) = '' out,
@s_tasa         		money = 0 out,  
@s_base_imp     		float = 0 out, 
@s_impuesto     		float = 0 out
)
as

declare @v_return               int,
		@v_trx_iva          	int,
		@v_trn_ah               int,
		@v_trx_com          	int,
		@v_servicio             char(4),
		@v_tasa                 money,
		@v_base_imp             float, 
		@v_impuesto2            float,  
		@v_causal_com           varchar(5),
		@v_valor_compensa  		money,
		@v_comi_total       	money,
		@v_com_original     	money,
		@v_aplica_des       	char(1),
		@v_empresa          	int,
		@v_servicio_costo  		varchar(4)
    
select @s_base_imp = 0, @s_impuesto = 0 , @s_tasa= 0 , @v_trx_iva  = 0, @v_trn_ah = 0

if @e_comision_tot > 0
	begin
		
		/*>REF 4>*/
		if @e_comision_chq = 0 and @e_comision_db = 0 and @e_comision_efe = 0
			begin
				select @s_mensaje_respuesta = 'ERROR VALOR COMISION ES 0'
				return 140110
			end
				
		if @e_comision_efe > 0 and exists ( select 1  /*<REF 2, KBastida incluir Efectivo comision REF 2>*/
											 from cobis..cl_catalogo b
									   inner join cobis..cl_tabla a 
											   on b.tabla = a.codigo
											where a.tabla = 'sv_trx_cont_iva_rms'
											  and b.codigo = 'E' + @e_empresa and b.valor = '3497'  and estado = 'V') /*<REF 2, Com en Efec REF 2>*/
			begin
				select @v_trx_iva = 3497
			end
		
		--<REF 2, KBastida incluir Cheque comision
		else if @e_comision_chq > 0 and exists ( select 1 
											 from cobis..cl_catalogo b
									   inner join cobis..cl_tabla a 
											   on b.tabla = a.codigo
											where a.tabla = 'sv_trx_cont_iva_rms'
											  and b.codigo = 'CH' + @e_empresa and b.valor = '3497'  and estado = 'V')
			begin
				select @v_trx_iva = 3497
			end
		--REF 2>
	   
		if @e_horario = 'D'
			begin
				select @v_trx_com = 3372
			end
		else
			begin
				select @v_trx_com = 3366
			end
			
			
		if @e_depEspLinea = 1
			begin
				select @v_trx_com = 3366
			end

		--Consulta el servicio de la empresa la personalizacion
		select @v_servicio = pe_serv_com, 
			   @v_servicio_costo = isnull(pe_cod_serv,'CSPR')  
		from cob_pagos..pg_person_empresa
		where pe_empresa = convert(int,@e_empresa)
			
		if @e_tipo_cta = 'AHO'  and @e_comision_db > 0
			begin
					select @v_causal_com = b.valor
					  from cobis..cl_catalogo b
				inner join cobis..cl_tabla a 
						on b.tabla = a.codigo
					 where a.tabla = 'causa_nd_comision_servaho'
					   and b.codigo = @e_empresa
					   and estado = 'V'
						
				if @@rowcount = 0  or (@v_causal_com = null or @v_causal_com = ' ')
				begin
					select @s_mensaje_respuesta = 'CAUSA ND AHO COMISION NO DEFINIDA'
					return 140010
				end
				
				if @v_trx_iva = 0 and exists (select 1 
												from cobis..cl_catalogo b
										  inner join cobis..cl_tabla a 
												  on b.tabla = a.codigo
											   where a.tabla = 'sv_trx_cont_iva_rms'
												 and b.codigo = 'A'+ @e_empresa and b.valor = '4188' and estado = 'V')		
					begin
						select @v_trx_iva = 4188
					end
					
				/*>REF 4>*/	
				else if @v_trx_iva = 0 and exists (select 1 
												from cobis..cl_catalogo b
										  inner join cobis..cl_tabla a 
												  on b.tabla = a.codigo
											   where a.tabla = 'sv_trx_cont_iva_rms'
												 and b.codigo = 'A'+ @e_empresa and b.valor = '3497' and estado = 'V')		
					begin
						select @v_trx_iva = 3497
					end
						
				else
					begin
						select @s_mensaje_respuesta = 'TRX CONT IVA AHO NO DEFINIDA'
						return 140020
					end				
									
				if @e_canal = 'DIR' or @e_depEspLinea = 1
					begin
						select @v_trn_ah = 4272
					end
				else
					begin
						select @v_trn_ah = 4264
					end
																   
			
			end
		else if @e_tipo_cta = 'CTE'  and @e_comision_db > 0
				begin   
						select @v_causal_com = b.valor
						  from cobis..cl_catalogo b
					inner join cobis..cl_tabla a 
							on b.tabla = a.codigo
						 where a.tabla = 'causa_nd_comision_servcte'
						   and b.codigo = @e_empresa
						   and estado = 'V'
					
					if @@rowcount = 0  or (@v_causal_com = null or @v_causal_com = ' ')
						begin
							select @s_mensaje_respuesta = 'CAUSA ND CTE COMISION NO DEFINIDA'
							return 140030
						end
					
					
					if @v_trx_iva = 0 and exists (select 1 
													from cobis..cl_catalogo b
											  inner join cobis..cl_tabla a 
													  on b.tabla = a.codigo
												   where a.tabla = 'sv_trx_cont_iva_rms'
													 and b.codigo = 'C' + @e_empresa and b.valor = '3188' and estado = 'V')
						begin
							select @v_trx_iva  = 3188
						end
						
					/*>REF 4>*/
					else if @v_trx_iva = 0 and exists (select 1 
													from cobis..cl_catalogo b
											  inner join cobis..cl_tabla a 
													  on b.tabla = a.codigo
												   where a.tabla = 'sv_trx_cont_iva_rms'
													 and b.codigo = 'C' + @e_empresa and b.valor = '3497' and estado = 'V')
						begin
							select @v_trx_iva  = 3497
						end
							
							
					else
						begin
							select @s_mensaje_respuesta = 'TRX CONT IVA CTE NO DEFINIDA'
							return 140040
						end		
						
					
				end
		
		else if @e_comision_efe > 0
			begin
				select @v_causal_com = b.valor
							  from cobis..cl_catalogo b
						inner join cobis..cl_tabla a 
								on b.tabla = a.codigo
							 where a.tabla = 'causa_ef_comision_serv'
							   and b.codigo = @e_empresa
							   and estado = 'V'
				
				if @@rowcount = 0  or (@v_causal_com = null or @v_causal_com = ' ')
						begin
							select @s_mensaje_respuesta = 'CAUSA EF COMISION NO DEFINIDA'
							return 140010
						end
						
			end
		else if @e_comision_chq > 0
			begin
				select @v_causal_com = b.valor
							  from cobis..cl_catalogo b
						inner join cobis..cl_tabla a 
								on b.tabla = a.codigo
							 where a.tabla = 'causa_ch_comision_serv'
							   and b.codigo = @e_empresa
							   and estado = 'V'
				
				if @@rowcount = 0  or (@v_causal_com = null or @v_causal_com = ' ')
						begin
							select @s_mensaje_respuesta = 'CAUSA CH COMISION NO DEFINIDA'
							return 140010
						end
						
			end

		select @v_aplica_des = 'N',
			   @v_empresa = convert(int,@e_empresa)
		
		if exists (select 1 
					 from cob_pagos..pg_p_rubro_ser_dam 
					where rs_empresa = @v_empresa 
					  and rs_canal = @e_canal and rs_estado = 'V')  
			begin
		
				if @e_canal in ('VEN', 'CNB')
				begin
				
				  select @v_comi_total = isnull(@e_comision_efe,0) + isnull(@e_comision_chq,0) + isnull(@e_comision_db,0)
				  
				  exec @v_return = cob_pagos..pa_pg_ivalor_comcal
									  @e_valor_comision  = @v_comi_total,
									  @e_oficina         = @e_ofi,
									  @e_empresa         = @v_empresa,
									  @e_canal           = @e_canal,
									  @s_valor_com_final = @v_com_original out, -- obtengo comision original
									  @s_aplica          = @v_aplica_des out								  
				  
				  if @v_return <> 0 or @@error <> 0
					begin					  
						 select @s_mensaje_respuesta = 'NO EXISTE REGISTRO DE PARAMETRO COMISION'
						 return 300003360  
					end 

				   if @v_aplica_des = 'S'	  
					  begin
					  
						  exec  @v_return = cob_gov..pa_iva_pcompensacion
											@e_oficina        = @e_ofi,
											@e_monto          = @v_com_original, -- Saco compensacion
											@s_monto_compensa = @v_valor_compensa out   
						  
						  if @v_return <> 0 or @@error <> 0
							begin					  
								 select @s_mensaje_respuesta = 'NO EXISTE REGISTRO DE PARAMETRO COMISION'
								 return 300003360  
							end 
					  end
		  
				end
					
			end
		else
			begin
				select @v_com_original = @e_comision_efe + @e_comision_chq + @e_comision_db
			end	
			
			 
			  
		
		if @v_trx_iva = 3497
			begin					
				--<REF 6, Deflactacion de SRI Tranf. Dominio
				if @e_empresa = '9718'
					if @e_tipo_cta = 'CTE' or @e_tipo_cta = 'AHO'
					begin 										
						select @v_servicio = '3'
					end
				--REF 6>
				
				exec @v_return = cob_remesas..sp_cobro_comision_rc
								@s_ssn      = @e_ssn,
								@s_lsrv     = @e_srv,
								@s_srv      = @e_srv,
								@s_user     = @e_user,
								@s_term     = @e_term,
								@s_date     = @e_date,
								@s_ofi      = @e_ofi,
								@s_rol      = @e_rol,
								@s_org      = @e_org,
								@t_corr     = @e_corr,
								@t_ssn_corr = @e_ssn_corr,
								@t_debug    = null,
								@t_file     = null,
								@t_from     = null,
								@t_rty      = 'N',
								@t_trn      = @v_trx_com,
								@i_ubi      = @e_ubi,
								@i_mon      = @e_mon,
								@i_opcion   = 'T',
								@i_servicio = @v_servicio,
								@i_causal   = @v_causal_com,   -- Causa debito comision
								@i_codigo   = @e_cod_referencia,
								@i_efectivo = @e_comision_efe,
								@i_cheque   = @e_comision_chq,
								@i_debito   = @e_comision_db,
								@i_cuenta   = @e_cuenta,
								@i_aplcobis = 'N',        
								@i_tipocta  = @e_tipo_cta, /*>REF 4>*/
								@i_canal    = @e_canal,
								@i_nomb_tramite = @e_nomb_tramite , 
								@i_tsn      = @e_ssn    
				
				if @v_return != 0 or @@error != 0
					begin								
						select @s_mensaje_respuesta = 'NO FUE POSIBLE COBRAR LA COMISION'
						return 120013
					end
			end 
		else
			begin
			
			  if @e_tipo_cta = 'CTE'  and @e_comision_db > 0
					begin
						
						exec @v_return = cob_cuentas..sp_ccndc_automatica
										 @s_srv          = @e_srv,
										 @s_ofi          = @e_ofi,
										 @s_ssn          = @e_ssn,
										 @s_user         = @e_user,
										 @s_term         = @e_term,
										 @t_corr         = @e_corr,
										 @t_trn          = 3050,
										 @i_cta          = @e_cuenta,
										 @i_val          = @e_comision_db,
										 @i_cau          = @v_causal_com, 
										 @i_mon          = @e_mon,
										 @i_ref          = @e_cod_referencia,
										 @i_fecha        = @e_date,
										 @i_nchq         = @e_ssn_corr,
										 @i_aplcobis     = 'N',
										 @i_tsn          = @e_ssn,          
										 @i_ubi          = @e_ubi,          
										 @s_rol          = @e_rol,          							
										 @i_detalle	     = @e_cod_referencia	
										 
						if @v_return != 0 or @@error != 0
						begin								
							select @s_mensaje_respuesta = 'NO FUE POSIBLE COBRAR LA COMISION CTE'
							return 120014
						end
					 end
				
			  else if @e_tipo_cta = 'AHO' and @e_comision_db > 0
					begin
					
						exec @v_return = cob_ahorros..sp_ahndc_automatica
										 @s_srv          = @e_srv,
										 @s_ofi          = @e_ofi,
										 @s_ssn          = @e_ssn,
										 @s_user         = @e_user,
										 @s_term         = @e_term,
										 @t_trn          = @v_trn_ah,  
										 @t_corr         = @e_corr,
										 @i_cta          = @e_cuenta,
										 @i_val          = @e_comision_db,
										 @i_cau          = @v_causal_com,  
										 @i_mon          = @e_mon,
										 @i_ref          = @e_cod_referencia,
										 @i_fecha        = @e_date,
										 @i_aplcobis     = 'N',
										 @i_tsn          = @e_ssn,
										 @i_ubi          = @e_ubi,
										 @s_rol          = @e_rol,
										 @i_tarjeta      = @e_cod_referencia, 
										 @i_referen		 = @e_ssn_corr	
										 
						if @v_return != 0 or @@error != 0
							begin								
								select @s_mensaje_respuesta = 'NO FUE POSIBLE COBRAR LA COMISION AHO'
								return 120014
							end
					 end	
					 
					 
					/*>REF 4>*/
					if @e_canal = 'VEN'
						begin
							exec @v_return = cob_remesas..sp_upd_totales_rc
								 @i_ofi            = @e_ofi,
								 @i_rol            = @e_rol,
								 @i_user           = @e_user,
								 @i_producto       = 'CTE',
								 @i_mon            = @e_mon,
								 @i_ubi            = @e_ubi,
								 @i_trn            = @v_trx_iva,
								 @i_nodo           = @e_srv,
								 @i_tipo           = 'L',
								 @i_corr           = @e_corr,
								 @i_tipocta        = @e_tipo_cta,
								 @i_otros          = @e_comision_db,
								 @i_causa          = @v_causal_com
								 
							if @v_return != 0 or @@error != 0
							   begin        						  
								 select @s_mensaje_respuesta = 'ERROR UPD_TOTALES_RC COMISION'
								 return 111112		                   
							   end
						end
					   	   				 
			end

		--  busqueda de la tasa del iva parametrizada en el person													  
		exec  @v_return = cob_pagos..sp_verif_genera_costo
						  @s_date         = @e_date,
						  @i_mon          = @e_mon,
						  @i_rubro        = 'IVA',
						  @i_servicio     = @v_servicio_costo, 
						  @i_canal        = @e_canal,
						  @i_tipocta      = '3',
						  @o_costo        = @v_tasa out
						  
		if @v_return <> 0 or @@error <> 0
			begin              
			  select @s_mensaje_respuesta = 'ERROR TASA IVA PERSON'
			  return 121212
			end
	   
		if @v_tasa > 0
			begin
				  if @v_valor_compensa > 0 and @v_aplica_des = 'S' and (@e_canal = 'CNB' or @e_canal = 'VEN')
					  begin           			   
						  -- llamar al sp que retorna el valor del iva ----
						  exec @v_return = cob_cuentas..sp_cal_impuesto
										   @i_tasa         = @v_tasa,
										   @i_valor_serv   = @v_com_original,  -- Comision Original al 14
										   @o_base_imp     = @v_base_imp out,
										   @o_impuesto     = @v_impuesto2 out								
						  if @v_return <> 0 or @@error <> 0
							  begin					 
								   select @s_mensaje_respuesta = 'ERROR VALOR IVA PERSON 1'
								   return 131313
							  end
											   
						  select @s_base_imp = @v_base_imp,
								 @s_impuesto = @v_impuesto2,
								 @s_tasa     = @v_tasa
					  
					  end
				  else
					  begin
					  
						  -- llamar al sp que retorna el valor del iva ----
						  exec @v_return = cob_cuentas..sp_cal_impuesto
										   @i_tasa         = @v_tasa,
										   @i_valor_serv   = @e_comision_tot,
										   @o_base_imp     = @v_base_imp out,
										   @o_impuesto     = @v_impuesto2 out	
										   
						  if @v_return <> 0 or @@error <> 0
							  begin                  
								   select @s_mensaje_respuesta = 'ERROR VALOR IVA PERSON 2'
								   return 141414					   
							  end
						 
						  select @s_base_imp = @v_base_imp,
								 @s_impuesto = @v_impuesto2,
								 @s_tasa     = @v_tasa             
						  
					  end 
			end
		else
			begin
			   select @s_base_imp = @e_comision_tot, @s_impuesto = 0 , @s_tasa= 0 
			end
				 
					 
		if @v_base_imp > 0
			begin
		
				 if (@e_canal = 'CNB' or @e_canal = 'VEN') and @v_aplica_des = 'S' and @v_valor_compensa > 0
					 begin   
							  --insert la trx del iva 3497 para cobro de la comision ---
							  exec @v_return = cob_cuentas..sp_cont_impuesto
								   @t_trn       = 3497 ,
								   @s_ssn       = @e_ssn,
								   @s_date      = @e_date,
								   @t_corr      = @e_corr,
								   @t_ssn_corr  = @e_ssn_corr,
								   @s_user      = @e_user,
								   @s_term      = @e_term,
								   @s_ofi       = @e_ofi, -- Oficina Damnificado 
								   @t_rty       = 'N',
								   @s_org       = @e_org,
								   @i_base_imp  = @v_base_imp,
								   @i_iva       = @v_impuesto2,
								   @i_total     = @v_com_original, -- Comision Original al 14
								   @i_cau       = @v_servicio,
								   @i_cta       = @e_num_operacion, 
								   @i_mon       = @e_mon,   --Moneda
								   @i_oficina_cta = @e_ofi, -- Oficina Damnificado REF13 LBP
								   @i_ubi       = @e_ubi,
								   @i_canal     = @e_canal,
								   @i_cta_deb   = @e_cuenta 

							  if @v_return <> 0 or @@error <> 0
								  begin                 
									  select @s_mensaje_respuesta = 'ERROR TRX IVA COMISION 1'
									  return 151515
								  end
						end
				else
						begin 
								--<REF 5, Deflactacion de Claro Srv. Fijo
								if @e_empresa = '8521'
									if @e_tipo_cta = 'CTE' or @e_tipo_cta = 'AHO'
										begin 										
											select @v_causal_com = '50'
										end
								--REF 5>
								
								--<REF 6, Deflactacion de SRI Tranf. Dominio
								if @e_empresa = '9718'
									if @e_tipo_cta = 'CTE' or @e_tipo_cta = 'AHO'
										begin 										
											select @v_causal_com = '3'
										end
								--REF 6>
										
							  --Insert la trx del iva  para cobro de la comision
							  exec @v_return = cob_cuentas..sp_cont_impuesto
											   @t_trn         = @v_trx_iva, 
											   @s_ssn         = @e_ssn,
											   @s_date        = @e_date,
											   @t_corr        = @e_corr,
											   @t_ssn_corr    = @e_ssn_corr,
											   @s_user        = @e_user,
											   @s_term        = @e_term,
											   @s_ofi         = @e_ofi,
											   @t_rty         = 'N',
											   @s_org         = @e_org,
											   @i_base_imp    = @v_base_imp,
											   @i_iva         = @v_impuesto2,
											   @i_total       = @e_comision_tot,
											   @i_cau         = @v_causal_com,
											   @i_cta         = @e_num_operacion,  
											   @i_mon         = @e_mon,   --Moneda
											   @i_oficina_cta = @e_ofi,
											   @i_ubi         = @e_ubi,
											   @i_canal       = @e_canal
											   
							  if @v_return <> 0 or @@error <> 0
								  begin                  
									  select @s_mensaje_respuesta = 'ERROR TRX IVA COMISION 2'
									  return 161616
								  end
												  
							end 
			end

	end
	 
 
if @e_canal = 'VEN'
	begin

		if @e_depEspLinea = 1
			begin
				select @e_trn = 4435
			end
		  
		  if @e_tipo_cta != 'CTE' /*>REF 4>*/
			begin
				select @e_tipo_cta  = 'CTE'
			end
				  
		exec @v_return = cob_remesas..sp_upd_totales_rc
						 @i_ofi            = @e_ofi,
						 @i_rol            = @e_rol,
						 @i_user           = @e_user,
						 @i_producto       = 'CTE',
						 @i_mon            = @e_mon,
						 @i_ubi            = @e_ubi,
						 @i_trn            = @e_trn,
						 @i_nodo           = @e_srv,
						 @i_tipo           = 'L',
						 @i_corr           = @e_corr,
						 @i_efectivo       = @e_efectivo,
						 @i_cant_chq       = @e_cant_cheques,
						 @i_cheque         = @e_cheque,
						 @i_tipocta        = @e_tipo_cta,
						 @i_otros          = @e_debito,
						 @i_retencion      = 0,
						 @i_causa          = @e_empresa, 
						 @i_tarjetas 	   = @e_tarjeta /*<REF 3, KBastida Add campo TC REF 3>*/
		if @v_return != 0 or @@error != 0
		   begin        						  
			 select @s_mensaje_respuesta = 'ERROR UPD_TOTALES_RC'
			 return 111111		                   
		   end
		   
	end

select @s_mensaje_respuesta = 'OK'
return 0

go
if exists(select 1 from sysobjects where name='pa_pg_tpag_comision' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_tpag_comision *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_tpag_comision -- ERROR -- >>>'
go

grant execute on pa_pg_tpag_comision to apl_recms_hpact
go

