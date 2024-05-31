
use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_pg_pval_reca_pago' and type = 'P')
begin
   drop procedure dbo.pa_pg_pval_reca_pago
   if exists (select 1 from sysobjects where name = 'pa_pg_pval_reca_pago' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_pval_reca_pago -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_pval_reca_pago *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pgpvrcpg.sp                                     */
/*  Stored procedure:   pa_pg_pval_reca_pago                            */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Jonathan Guerrero                               */
/*  Fecha de escritura: 05-May-2022                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECMPS-2440	                                */
/*  Ult.Referencia:     REF 2                                           */
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
/* Este programa realiza las validaciones de pagos de recaudaciones     */
/*                                                                      */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA            AUTOR                 RAZON                      */
/*  05/May/2022 Jonathan Guerrero  RECESABREC-39  Emisión inicial       */
/*  2 	04/Jul/2023 Kevin Bastidas  	RECMPS-2440 PAGO ECUANET EN VENTANILLA  */
/************************************************************************/

create procedure dbo.pa_pg_pval_reca_pago 
(
@e_ssn                  int,
@e_srv                  varchar(30) = '',
@e_user                 varchar(30) = '',
@e_term                 varchar(10),
@e_date                 datetime,
@e_ofi                  int = 1,
@e_rol                  smallint = 1,
@e_corr                 char(1) = 'N',
@e_ssn_corr             int,      
@e_trn                  int=0,
@e_mon                  tinyint = 1,
@e_empresa              varchar(10) = '',
@e_codigo               varchar(30) = '',
@e_efectivo             money = 0,
@e_cheque               money = 0,
@e_debito               money = 0,
@e_tarjeta				money = 0,	
@e_comision_efe         money = 0,
@e_comision_chq         money = 0,
@e_comision_db          money = 0,  
@e_total                money = 0,
@e_tipo_cta             char(3) = '',
@e_cuenta               varchar(24) = '',
@e_autoriza             char(1) = 'N',
@e_canal                char(3) = 'VEN',
@e_ubi                  int = 0,
@e_reverso              char(1) = '', 
@s_fecha_contable       varchar(10) = '' out,
@s_mensaje              varchar(80)='' out
)
as

declare @v_return           int,
		@v_hora_tope            int,
		@v_hora_sys             char(8),
		@v_hora                 int,
		@v_fecha_hoy            varchar(10),
		@v_hora_dif             varchar(9),
		@v_cta_cte              int,
		@v_estado_cta_cte       char(1),
		@v_disponible_cte       money,
		@v_disponible_valsus    money,
		@v_saldo_contable       money,
		@v_saldo_valsus         money,
		@v_maximo_p             money,
		@v_horario              char(1),
		@v_total_pagar          money, 
		@v_fecha_contable       varchar(8),    
		@v_prod_banc            smallint,   
		@v_nrocta		        varchar(15), 
		@v_flag_mflujo          char,
		@v_montoaut             money,
		@v_depEspLinea			bit,
		@v_monto_min_pe         money, 
		@v_monto_minimo_entero  money,
		@v_maxpago_mgd          money,
		@v_org_aviso_mgd        varchar(30)
		
		select    @v_total_pagar    = isnull(@e_efectivo,0) + isnull(@e_cheque,0) + isnull(@e_debito,0) + isnull(@e_tarjeta,0),
                  @s_fecha_contable = convert(varchar(10),@e_date,101),
	              @v_fecha_contable = convert(varchar(8),@e_date,112),
				  @v_fecha_hoy      = convert(varchar(10), getdate(),101),  
				  @v_hora_sys  = convert(varchar,getdate(),108)

		select	  @e_debito = @e_debito + @e_comision_db

--VALIDACION PEJAE
if @e_empresa = '8461' 
	begin
	   select @v_monto_min_pe = pa_money  
		 from cobis..cl_parametro 
		where pa_producto  = 'CTE'
		  and pa_nemonico = 'MMRPE'
		  
	   if @v_total_pagar < @v_monto_min_pe
		   begin 
			 select @s_mensaje = 'VALOR INFERIOR AL MÍNIMO PERMITIDO'
			 return 1010       
		   end
		   
	   if @v_total_pagar > @v_monto_min_pe
		   begin
				select @v_monto_minimo_entero = convert(money, convert(int,@v_total_pagar))
				
				if @v_monto_minimo_entero <> @v_total_pagar
					begin
						select @s_mensaje = 'VALOR SUPERIOR AL MÁXIMO PERMITIDO'
						return 1011
					end
		   end
	end 

	-- HORA TOPE 
	select @v_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
	  from cobis..cl_tabla a
inner join cobis..cl_catalogo b 
		on a.codigo = b.tabla
	 where a.tabla = 'sv_horario_serv'
	   and b.codigo = @e_empresa
	   and estado = 'V'

if (@@rowcount = 0 or @v_hora_tope = 0)
	begin
		  select @s_mensaje = 'PARAMETRO DE HORA TOPE NO DEFINIDA'
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
			select @s_mensaje = 'TRX DE SERVICIO HN NO DEFINIDA'
			return 140010
		end
	
	end
	
--Identifico si estoy en el horario normal o diferido
if @e_canal = 'VEN'  and @v_depEspLinea = 0
	begin
		 select @v_hora_dif = rh_inicio 
		   from cob_remesas..re_horario 
		  where rh_oficina = @e_ofi and rh_ubicacion = @e_ubi
		 
		 if @v_hora_sys >= @v_hora_dif 
			begin	
			
					select @e_trn =  convert(int,b.valor)
					  from cobis..cl_catalogo b
				inner join cobis..cl_tabla a 
						on b.tabla = a.codigo
					 where a.tabla = 'sv_trx_srv_rms_hd1'
					   and b.codigo = @e_empresa
					   and estado = 'V'
				
					if @@rowcount = 0 
						begin
							select @s_mensaje = 'TRX DE SERVICIO HD1 NO DEFINIDA'
							return 140020
						end					
			end	

	end

select @v_hora = convert(int, (substring (@v_hora_sys,1,2) + substring (@v_hora_sys,4,2) + substring (@v_hora_sys,7,2)))
	
if @v_depEspLinea = 0 and @v_hora >= @v_hora_tope  and @e_date = @v_fecha_hoy
	begin
	
		  select @e_trn =  convert(int,b.valor)
			from cobis..cl_catalogo b
	  inner join cobis..cl_tabla a 
			  on b.tabla = a.codigo
		   where a.tabla = 'sv_trx_srv_rms_hd2'
			 and b.codigo = @e_empresa
			 and estado = 'V'

		if @@rowcount = 0 
			begin
				select @s_mensaje = 'TRX DE SERVICIO HD2 NO DEFINIDA'
				return 140030
			end
			
		select @s_fecha_contable = convert(varchar,min(dl_fecha),101),
			   @v_fecha_contable = convert(varchar(8),min(dl_fecha),112)
		  from cob_cuentas..cc_dias_laborables
		 where dl_ciudad = 1
		   and dl_num_dias = 1
	 end

if @e_canal = 'VEN'
   begin
	
		exec @v_return = cob_remesas..sp_verifica_caja_rc
						@s_ssn   = @e_ssn,
						@s_srv   = @e_srv,
						@s_lsrv  = @e_srv,
						@s_user  = @e_user,
						@s_term  = @e_term,
						@s_date  = @e_date,
						@s_ofi   = @e_ofi,
						@s_rol   = @e_rol,
						@s_sev   = null,
						@s_msg   = null,
						@s_org   = '',
						@t_trn   = @e_trn,
						@t_corr  = @e_corr,
						@i_mon   = @e_mon,
						@i_ubi   = @e_ubi,
						@o_horario = @v_horario out
		
		if @v_return != 0 or @@error != 0
			begin
					select @s_mensaje = 'HORARIO DE CAJA NO DEFINIDO'
					return 300003299
			end
	end

if @e_corr = 'S' and @e_reverso = 'M'
	begin   
	
		select @e_trn = ts_tipo_transaccion    -- identifica trx original
		  from cob_cuentas..cc_tran_servicio (index cc_tran_servicio_secuencial)
		 where ts_secuencial = @e_ssn_corr
		   and ts_causa = @e_empresa
		   and ts_tsfecha = @e_date
		
		 --Valida que exista registrado el pago antes de registrar el reverso
		if @@rowcount = 0 or @e_trn = 0 or @e_trn is null
			begin
				select @s_mensaje = 'NO EXISTE TRANSACCIÓN ORIGINAL'
				return 18122
			end
		 
		if @v_hora >= @v_hora_tope and @e_date = @v_fecha_hoy and @e_trn = (select convert(int,b.valor)
																			  from cobis..cl_catalogo b
																			  inner join cobis..cl_tabla a 
																			  on b.tabla = a.codigo
																			  where a.tabla = 'sv_trx_srv_rms_hn'
																			  and b.codigo = @e_empresa
																			  and estado = 'V')
			begin
				select @s_mensaje  = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO'                        
				return 358750
			end        

	end

--- VALIDACION DE MONEDA
if @e_mon <> 1
	begin
		select @s_mensaje = 'TRANSACCION SOLO SE DEBE REALIZAR EN DOLARES'
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
				select @s_mensaje = 'VALOR EXCEDE O ES INFERIOR AL MONTO PERMITIDO'
				return 311819
			end
	end

-- VALIDACION DE PARAMETRO DE MONTO MAXIMO DE DIRECTV POSTPAGO 
if @e_empresa = '5488' 
begin
	select @v_maximo_p = convert(money,pa_char)
	  from cobis..cl_parametro
	 where pa_nemonico = 'MAXDTP'
	   and pa_producto = 'CTE'

	if (@v_maximo_p <= @e_total )
	begin
		select @s_mensaje = 'VALOR EXCEDE O ES INFERIOR AL MONTO PERMITIDO'
		return 311819
	end
end

--<REF 2 VALIDACION DE PARAMETRO DE MONTO MAXIMO ECUANET
    if @e_empresa = '21980' and @e_corr = 'N'
    begin
      select @v_maxpago_mgd = pa_money
       from cobis..cl_parametro
       where pa_nemonico = 'MAXPEN'
         and pa_producto = 'CTE'
      if @v_maxpago_mgd is not null
      begin
        if @e_total > @v_maxpago_mgd
        begin
          select @s_mensaje = 'AVISO'          
          return 30076
        end
      end
    end
--REF 2>


--VALIDACION  NO ACEPTA PAGOS PARCIALES
if @e_empresa = '5482'
	begin
	  if @e_total < @v_total_pagar
		  begin
			select @s_mensaje = 'SERVICIO NO PERMITE REALIZAR PAGOS PARCIALES'
			return 355103
		  end
	end

-- VALIDACION DE PARAMETRO DE MONTO MAXIMO DE MATRICULACION VEHICULAR CON TC 
if @e_empresa = '2' and @e_canal = 'VEN'
	begin

		Select @v_flag_mflujo = pa_char
		  from cobis..cl_parametro
		 where pa_nemonico = 'FMMV'
		   and pa_producto = 'CTE'

		if @v_flag_mflujo = 'S'
			begin
			
			   if @e_corr='N' and @e_tarjeta > 0 
				   begin
				   
						 select @v_montoaut = pr_money
						   from cob_remesas..re_perfiles_rol
						  where pr_moneda    = @e_mon
							and pr_rol       = @e_rol
							and pr_oficina   = @e_ofi
							and pr_ubicacion = @e_ubi
							and pr_nemonico  = 'MAXTMV'
							
						if @@rowcount = 0
							begin
							 select @v_montoaut = 0
							end
							 
						if @v_montoaut = 0
							begin
								select @v_montoaut = pr_money
								from cob_remesas..re_perfiles_rol
								where pr_moneda    	= 1 
								and pr_rol       	= 244   
								and pr_oficina   	= 0 
								and pr_ubicacion 	= 0
								and pr_nemonico  	= 'MAXTMV'
							end
						
						if @e_tarjeta > @v_montoaut 
						  begin
							select @s_mensaje = 'VALOR EXCEDE O ES INFERIOR AL MONTO PERMITIDO'
							return 311819
						  end 
					
				   end
			   
		end

	end

if @e_canal in ('DBA', 'DIR') 
	begin

		if @e_empresa = '3' --CNT
			begin
				select @v_nrocta = pa_char 
				  from cobis..cl_parametro
			 	 where pa_nemonico = 'CBCNT'
				   and pa_producto = 'CTE'
				 
				if @e_cuenta = @v_nrocta
					begin
						return 0
					end
			end
			
		if exists (select 1 
					 from cobis..cl_catalogo a 
			   inner join cobis..cl_tabla b  
					   on a.tabla = b.codigo 
					  and b.tabla = 'cl_empresas_luz' 
					  and a.codigo = @e_empresa
					  and a.estado = 'V')
			 begin
				select @v_nrocta = pa_char 
				  from cobis..cl_parametro
				 where pa_nemonico = 'BBCNEL'
				   and pa_producto = 'CTE'
			
				if @e_cuenta =  @v_nrocta
					begin
					  return 0
					end
			 end

	end 

if (@e_debito>0 or @e_comision_db>0) and (@e_tipo_cta is null or @e_cuenta is null)
	begin
		  select @s_mensaje = 'No ingreso cuenta o tipo de cuenta'
		  return 128005
	end

if @e_tipo_cta = 'CTE' and @e_debito > 0  and @e_corr = 'N'
	begin	
	
			select @v_cta_cte = cc_ctacte,
				   @v_estado_cta_cte = cc_estado
			  from cob_cuentas..cc_ctacte
			 where cc_cta_banco = @e_cuenta
				if @@rowcount = 0
				begin
					select @s_mensaje = 'CUENTA CORRIENTE NO EXISTE'
					return 31004     
				end
		
			exec @v_return = cob_cuentas..sp_calcula_saldo
							@i_cuenta           = @v_cta_cte,
							@i_fecha            = @e_date,
							@i_ofi              = @e_ofi,
							@o_disponible       = @v_disponible_valsus out,
							@o_saldo_para_girar = @v_disponible_cte out,
							@o_saldo_contable   = @v_saldo_contable out,
							@o_saldo_valsus     = @v_saldo_valsus out
				
			if @v_return <> 0 or @@error <> 0
				begin
					return @v_return
				end
						
			if @v_estado_cta_cte <> 'A'
				begin		
					select @s_mensaje = 'CUENTA NO ESTA ACTIVA'
					return 31088
				end
		
			if @e_debito > @v_disponible_cte
				begin
					select @s_mensaje = 'FONDOS INSUFICIENTES'
					return 31017
				end
					
			if exists (	select 1
						  from cob_cuentas..cc_ctabloqueada
						 where cb_cuenta = @v_cta_cte
						   and cb_estado = 'V'
						   and cb_tipo_bloqueo in ('2','3') )				
				begin			
					select @s_mensaje = 'Cuenta bloqueada'	
					return 31008
				end
				
			if exists (	select 1
						  from cob_cuentas..cc_ctabloqueada
						 where cb_cuenta = @v_cta_cte
						   and cb_estado = 'V'
						   and cb_causa = '2' )				
				begin			
					select @s_mensaje = 'Cuenta bloqueada'	
					return 31009
				end
	end

else if @e_tipo_cta = 'AHO'  and @e_debito > 0 and @e_corr = 'N'
		begin
		
			select @v_prod_banc = 0 
			select @v_estado_cta_cte = ah_estado,
				   @v_cta_cte        = ah_cuenta
			  from cob_ahorros..ah_cuenta
			 where ah_cta_banco = @e_cuenta  
			
			if @@rowcount = 0
				begin
				
					if @e_canal = 'CNB' and exists(select 1
													 from cobis..cl_catalogo c 
											   inner join cobis..cl_tabla t
													   on c.tabla = t.codigo 
													where c.codigo = @e_empresa 
													  and t.tabla = 'cl_trans_ser_np_bas'
													  and c.estado = 'V' )  
						begin
							select @s_mensaje = 'NO EXISTE CUENTA DE AHORROS'
							return 41001
						end 
						
					else				
						begin
						
							select @v_estado_cta_cte = vi_estado,
								   @v_cta_cte        = vi_cuenta,
								   @v_prod_banc      = vi_prod_banc
							  from cob_virtuales..vi_cuenta
							 where vi_cta_banco = @e_cuenta
							   and vi_prod_banc = 13
					 
							if @@rowcount = 0
								begin
									select @s_mensaje = 'NO EXISTE CUENTA DE AHORROS'
									return 41001
								end
						end                               
				end
			
			if @v_estado_cta_cte  <> 'A'
				begin
					 select @s_mensaje = 'CUENTA NO ESTA ACTIVA'
					 return 41064
				end

		    -- consulta a cuenta de basica
			if @v_prod_banc = 13		
				begin
				
					exec @v_return = cob_virtuales..sp_bascalcula_saldo
									@t_debug            = null,
									@t_file             = null,
									@i_cuenta           = @v_cta_cte,
									@i_fecha            = @e_date,
									@i_ofi              = @e_ofi,
									@o_saldo_para_girar = @v_disponible_cte out,
									@o_saldo_contable   = @v_saldo_contable out
						
					if @v_return <> 0 or @@error <> 0
						begin
							select @s_mensaje = 'ERROR CONSULTAR CUENTA BÁSICA'
							return @v_return
						end
						
					if exists ( select 1
								  from cob_virtuales..vi_ctabloqueada
								 where cb_cuenta = @v_cta_cte
								   and cb_estado = 'V'
								   and cb_tipo_bloqueo in ('2','3'))
						begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 128115
						end
						   
					if exists ( select 1
								  from cob_virtuales..vi_ctabloqueada
								 where cb_cuenta = @v_cta_cte
								   and cb_estado = 'V'
								   and  cb_causa = '2' )
						begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 128116
						end 
					   
				end
				
			else
				begin
				
					exec @v_return = cob_ahorros..sp_ahcalcula_saldo
									@t_debug            = null,
									@t_file             = null,
									@i_cuenta           = @v_cta_cte,
									@i_fecha            = @e_date,
									@i_ofi              = @e_ofi,
									@o_saldo_para_girar = @v_disponible_cte out,
									@o_saldo_contable   = @v_saldo_contable out

					if @v_return <> 0 or @@error <> 0
						begin
							select @s_mensaje = 'ERROR EN CONSULTAR CUENTA AHO'
							return @v_return
						end
						
					if exists ( select 1
								  from cob_ahorros..ah_ctabloqueada
								 where cb_cuenta = @v_cta_cte
								   and cb_estado = 'V'
								   and cb_tipo_bloqueo in ('2','3'))
						begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 41025
						end 
						
					if exists ( select 1
								  from cob_ahorros..ah_ctabloqueada
								 where cb_cuenta = @v_cta_cte
								   and cb_estado = 'V'
								   and cb_causa = '2' )
						begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 41026
						end 
																			   				  						
				end
							
			if @e_debito > @v_disponible_cte
				begin  
					select @s_mensaje = 'FONDOS INSUFICIENTES'
					return 41033					
				end
												
		end

else if @e_tipo_cta = 'PAG'  and @e_debito > 0 and @e_corr = 'N' 
		begin
		
			select @v_prod_banc = 0 
			select @v_estado_cta_cte  = vi_estado,
				   @v_cta_cte         = vi_cuenta,
				   @v_prod_banc       = vi_prod_banc
			  from cob_virtuales..vi_cuenta
			 where vi_cta_banco = @e_cuenta
			   and vi_prod_banc = 13

			if @@rowcount = 0
				begin
					select @s_mensaje = 'NO EXISTE CUENTA'
					return 41001
				end
		
			if @v_estado_cta_cte  <> 'A'
				begin
					select @s_mensaje = 'CUENTA NO ESTA ACTIVA'
					return 41064
				end 

			if @v_prod_banc = 13 
				begin
				
					exec @v_return = cob_virtuales..sp_bascalcula_saldo
										@t_debug            = null,
										@t_file             = null,
										@i_cuenta           = @v_cta_cte,
										@i_fecha            = @e_date,
										@i_ofi              = @e_ofi,
										@o_saldo_para_girar = @v_disponible_cte out,
										@o_saldo_contable   = @v_saldo_contable out						
					
					if @v_return <> 0 or @@error <> 0
						begin
							return @v_return
						end
						
					if exists ( select 1
								  from cob_virtuales..vi_ctabloqueada
								 where cb_cuenta = @v_cta_cte
								   and cb_estado = 'V'
								   and cb_tipo_bloqueo in ('2','3'))
					   begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 51025
						end 
						
					if exists ( select 1
							  from cob_virtuales..vi_ctabloqueada
							 where cb_cuenta = @v_cta_cte
							   and cb_estado = 'V'
							   and cb_causa = '2')
					   begin			
							select @s_mensaje = 'Cuenta bloqueada'	
							return 51026
						end 					   	
	
				end		
			else
				begin
					exec @v_return = cob_ahorros..sp_ahcalcula_saldo
										@t_debug            = null,
										@t_file             = null,
										@i_cuenta           = @v_cta_cte,
										@i_fecha            = @e_date,
										@i_ofi              = @e_ofi,
										@o_saldo_para_girar = @v_disponible_cte out,
										@o_saldo_contable   = @v_saldo_contable out
					
					if @v_return <> 0 or @@error <> 0
						begin
							return @v_return
						end
				  end

			if @e_debito > @v_disponible_cte
				begin
					select @s_mensaje = 'FONDOS INSUFICIENTES'
					return 41033
				end 		
			
		end 

if exists (select 1 
		   from cobis..cl_catalogo a
	  inner join cobis..cl_tabla b 
			  on a.tabla = b.codigo
		   where b.tabla = 'sv_emp_fecha_cont' 
			 and a.estado = 'V' and a.codigo = @e_empresa) 
  begin
	 select @s_fecha_contable = @v_fecha_contable
  end
  
if @e_corr='N'
	begin 
	
	   exec @v_return = cob_pagos..pa_pg_pval_serv_pub
				@e_empresa		= @e_empresa, 
				@e_valorEfe		= @e_efectivo,
				@e_valorDeb	 	= @e_debito,
				@e_valorChq	 	= @e_cheque,
				@e_valorTC	 	= @e_tarjeta,
				@e_comision_Efe = @e_comision_efe,
				@e_comision_Deb	= @e_comision_db,	
				@e_comision_Chq = @e_comision_chq,
				@e_comision_TC  = 0,
				@e_canal	    = @e_canal,
				@e_suministro	= @e_codigo
		
		if @v_return <> 0 or @@error <> 0
			begin
				select @s_mensaje = 'Excede monto Resolucion JPRMF'
				return @v_return
			end
			
	end	

return 0
go

if exists(select 1 from sysobjects where name='pa_pg_pval_reca_pago' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_pval_reca_pago *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_pval_reca_pago -- ERROR -- >>>'
go

grant execute on pa_pg_tpag_comision to apl_recms_hpact
go
