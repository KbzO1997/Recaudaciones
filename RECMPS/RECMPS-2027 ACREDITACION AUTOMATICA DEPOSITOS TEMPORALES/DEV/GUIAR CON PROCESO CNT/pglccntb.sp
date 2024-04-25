use cob_pagos
go

if exists (select 1 from dbo.sysobjects where name = 'pa_pag_blc_cnt')
	drop procedure dbo.pa_pag_blc_cnt
	if exists (select 1 from sysobjects where name = 'pa_pag_blc_cnt')
		PRINT '<<< DROP PROCEDURE pa_pag_blc_cnt -- ERROR -- >>>'
	else
		PRINT '== DROP PROCEDURE pa_pag_blc_cnt *OK* =='

go

/*************************************************************************/
/*  Archivo         :       pglccntb.sp                                	 */
/*  Stored procedure:       pa_pag_blc_cnt	                         	 */
/*  Base de datos:          cob_pagos                                    */
/*  Producto:               Recaudaciones		                         */
/*  Disenado por:           Maria Jose Silva G.                          */
/*  Fecha de escritura:     15-Nov-2003                                  */
/*-----------------------------------------------------------------------*/
/*                            IMPORTANTE                                 */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      BANCO BOLIVARIANO S.A.                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante .  */
/*-----------------------------------------------------------------------*/
/*                            PROPOSITO                                  */
/*  Este programa realiza la acreditación del servicio de empresas CNT   */
/*-----------------------------------------------------------------------*/
/*                          MODIFICACIONES                               */
/* REF FECHA       AUTOR           	TAREA JIRA    DESCRIPCION            */
/* 0  04/29/2021   María José Silva  RECMPS-864   Emisión Inicial        */
/*************************************************************************/


create proc dbo.pa_pag_blc_cnt (
@e_fecha_proceso	datetime ,
@e_empresa			int
)
as

declare @v_fecha_pro       varchar(10),
        @v_return          int,
        @v_flag            int,
        @v_cont            int,
        @v_pe_laborables   char(1),
        @v_pe_fpago        varchar(6),
        @v_pe_dias         int,
        @v_pe_costo        money,
        @v_pe_porcentaje   money,
        @v_pe_cuenta       varchar(24),
        @v_pe_impret       tinyint,
        @v_fecha_pago      datetime,
        @v_val_n           money,
        @v_val_s           money,
        @v_can_n           money,
        @v_can_s           money,
        @v_b_imponible_n   money,
        @v_b_imponible_s   money,
        @v_v_retencion_n   money,
        @v_v_retencion_s   money,
        @v_val_ret_n       money,
        @v_val_ret_s       money,
        @v_val_ret_1       money,  
        @v_val_ret_2       money,  
        @v_ret_impto       money,  
        @v_total_trn       int,
        @v_retencion       money,
        @v_val_retencion   money,
        @v_costo_diario    money,
        @v_total           money,
        @v_tipo_empresa    tinyint,   
        @v_carga           int,
        @v_base            money,
        @v_porc            float,  
        @v_cliente               int,       
        @v_ind_factelect         char(1),
        @v_producto              char(4),
        @v_servicio              char(4),
        @v_autorizacion          varchar(30),
        @v_validez               varchar(30),
        @v_fec_ini_vig_aut       varchar (10), 
        @v_fec_fin_vig_aut       varchar (10), 
        @v_base_impo             money, --REF 33
        @v_impuesto2         	 money,
        @v_acedita_grp           char(1), 
        @v_cod_grupo             char(6),  
        -->Ref50 MLR: se crean variables para la Retención IVA Bienes / Servicio
        @v_cont_especial         char(2),
        @v_baseimp0              money,
        @v_baseimp12             money,
        @v_val_ivabienes         money,
        @v_val_ivaserv           money,
        @v_ret_ivabienes         money,
        @v_ret_ivaserv           money,
        @v_exo_ivabienes         money,
        @v_exo_ivaserv           money,
        --<--Fin Ref50
        @v_indCost               char(1),        
        @v_fecha_anterior        datetime,
        @v_ciudad                smallint ,        
        @v_pe_producto			 char(3) ,
        @v_ssn					 int,
        @v_pe_impiva         	 int,
        @v_porc_impiva       	 float,
        @v_fact_diaria           char(1),
        @v_sp_name				 varchar(30),
        @v_file         		 varchar(14),
        @v_trn_iva				 int,
        @v_causa_nc          	 varchar(5),
        @v_causa_nd          	 varchar(5),
        @v_referencia        	 varchar(20)

select @v_flag = 0
select @v_sp_name = 'pa_pag_blc_cnt', @v_file = 'pglccntb.sp'

select @v_fecha_pro = convert(varchar(10), @e_fecha_proceso,101)

select @v_ciudad = pa_smallint
from cobis..cl_parametro
where pa_nemonico = 'CFN'
and pa_producto = 'CTE'
if @@rowcount = 0
	select @v_ciudad = 1
	
-- calcular fecha del dia anterior habil
select @v_fecha_anterior = max(dl_fecha)
from cob_cuentas..cc_dias_laborables
where dl_ciudad = @v_ciudad
and dl_num_dias = -1
if @@rowcount <> 1
begin
	print 'ERROR EN LECTURA DE FECHA ANTERIOR LABORABLE'
	return 1
end


select @v_porc = 0      


if exists(select 1 from cob_pagos..pg_control_ncrecaudacion
		where pn_empresa = @e_empresa
		and pn_fecha_rec = @e_fecha_proceso)
begin
	print "YA EXISTE REGISTRO DE PAGO"
end 
else
	select @v_flag = 1


if @v_flag = 1
begin
	--PARAMETROS DE LA EMPRESA
	select @v_pe_fpago   = pe_fpago,
		@v_pe_producto   = pe_producto,
		@v_pe_cuenta     = pe_cuenta,
		@v_pe_dias       = pe_dias,
		@v_pe_costo      = pe_costo,
		@v_pe_porcentaje = pe_porcentaje,
		@v_pe_laborables = pe_laborables,
		@v_pe_impret     = pe_impret,
		@v_porc          = pe_porc_retimp,  
		@v_cod_grupo     = convert(char(6),pe_cod_grupo), 
		@v_acedita_grp 	 = (case when isnull(@v_cod_grupo, '0') = '0' then (select isnull(pe_acedita_grp, 'N') from cob_pagos..pg_person_empresa where pe_empresa = @e_empresa )  
																	  else (select isnull(pe_acedita_grp, 'N') from cob_pagos..pg_person_empresa where pe_empresa = convert(int,@v_cod_grupo ) )
							end )  , 
		@v_indCost       = pe_imdCostCanal,                 
		@v_pe_impiva     = isnull(pe_impiva,0),    
		@v_porc_impiva   = isnull(pe_porc_impiva,0),
		@v_fact_diaria   = isnull(pe_fact_diaria, 'N')
  	from cob_pagos..pg_person_empresa
  	where pe_empresa = @e_empresa
  	if @@rowcount = 0
  	Begin
		print "ERROR REGISTRO DE PERSONALIZACION NO EXISTE <1001>"
		return 1
	End


	if @v_pe_impret = 1 and @v_porc is null   
		select @v_porc = pa_float
		from cobis..cl_parametro
		where pa_nemonico = 'IMR'
		and pa_producto = 'CTE'            


	if @v_pe_fpago <> 'NCRCTA'
		select @v_pe_cuenta = null

	if @e_empresa in (5482,3)
	begin
		if @v_acedita_grp = 'N'
		begin
			select
				@v_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),    --lfcm 04-enero-2007
				@v_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
				@v_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
				@v_can_n      = count(1),
				@v_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
				@v_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
			from cob_cuentas..cc_tran_servicio
			where ts_tipo_transaccion in (3194,3203,3925,3926,3928,43547)
			and ts_correccion       = 'N'
			and ts_causa     = convert(varchar,@e_empresa)
			and ts_tsfecha = @e_fecha_proceso

			select
				@v_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),      --lfcm 04-enero-2007
				@v_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
				@v_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
				@v_can_s     = count(1),
				@v_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
				@v_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
			from cob_cuentas..cc_tran_servicio
			where ts_tipo_transaccion in (3194,3203,3925,3926,3928,43547)
			and ts_correccion       = 'S'
			and ts_causa     = convert(varchar,@e_empresa) 
			and ts_tsfecha = @e_fecha_proceso
		end
		else
		begin
			exec cobis..sp_cerror
				@t_debug         = "N",
				@t_file          = @v_file ,
				@t_from          = @v_sp_name ,
				@i_msg           = 'ESTA PARAMETRIZADO COMO ACREDITACIÒN GRUPO',
				@i_num           = 111111
			return 1
		end
	end


select @v_total     = @v_val_n - @v_val_s
select @v_total_trn = isnull(@v_can_n,0) - isnull(@v_can_s,0)
select @v_retencion = @v_val_ret_n - @v_val_ret_s
select @v_ret_impto = @v_val_ret_1 - @v_val_ret_2
select @v_base = @v_total


if @v_total_trn = 0
begin
	print "NO EXISTE REGISTROS DE RECAUDACIONES"
	return 1
end

select @v_carga = null
select @v_tipo_empresa = 0


BEGIN TRAN

	if @v_pe_impret = 1    
		select @v_val_retencion = round(@v_total * @v_porc, 2)
	else
		select @v_val_retencion = 0
	
	
	select @v_cliente=(select en_ente from cobis..cl_ente where en_ced_ruc = a.pe_ruc)
	from cob_pagos..pg_person_empresa a
	where  pe_empresa = @e_empresa

	select 	@v_producto = 'RECA',
			@v_servicio = 'RECS'

	select @v_ind_factelect = 'E'

	--CHEQUEO DE LOS DIAS LABORABLES
	if @v_pe_laborables = 'N'
	begin
		select @v_fecha_pago = dateadd(dd,@v_pe_dias,@e_fecha_proceso)
		while exists (select 1 from cobis..cl_dias_feriados 
						where df_ciudad = 1
						and df_fecha = @v_fecha_pago)
		begin
			select @v_fecha_pago = dateadd(dd, 1, @v_fecha_pago)
		end
	end
	else
	begin
		select @v_fecha_pago = @e_fecha_proceso
		select @v_cont = 0

		while @v_cont < @v_pe_dias
		begin
			select  @v_fecha_pago = dateadd(dd, 1, @v_fecha_pago)
			if not exists (select df_fecha
							from  cobis..cl_dias_feriados
							where df_fecha = @v_fecha_pago
							and df_ciudad = 1 )
				select @v_cont = @v_cont + 1
		end
	end

	select @v_costo_diario = round((isnull(@v_pe_costo,0) * isnull(@v_total_trn,0)),2)
	
	if @v_costo_diario > 0
	begin
		if @v_costo_diario > @v_total
		begin
			if @@trancount > 0
				rollback tran
			exec cobis..sp_cerror
				@t_debug = 'N',
				@t_file  = @v_file,
				@t_from  = @v_sp_name,
				@i_num   = 1111111,
				@i_msg = "Error Valor del costo mayor al Valor a pagar"
			return 346546
		end
	
		if @v_pe_impiva = 1 and @v_porc_impiva > 0
		begin
			exec @v_return = cob_cuentas..sp_cal_impuesto
				@i_tasa          = @v_porc_impiva,
	    		@i_valor_serv    = @v_costo_diario,
	    		@o_base_imp      = @v_base_impo out,
	    		@o_impuesto      = @v_impuesto2 out
			if @v_return <> 0 or @@error != 0 
			begin
				if @@trancount > 0
					rollback tran
				
				return @v_return
			end
		end
		else
   			select  @v_base_impo = 0, @v_impuesto2 = 0
   	end

	if @v_pe_fpago = 'NCRCTA'
	begin
		if @v_pe_producto = 'CTE'
		begin
			select @v_causa_nc = b.valor
			from cobis..cl_tabla a inner join cobis..cl_catalogo b
				on a.codigo = b.tabla
			where a.tabla = 'sv_nc_causas_servicios'
			and convert(int,b.codigo) = @e_empresa    
			and b.estado = 'V'
			if  @@rowcount = 0
			begin
				rollback tran
				exec cobis..sp_cerror
					@t_debug         = 'N',
					@t_file          = @v_file,
					@t_from          = @v_sp_name,
					@i_msg           = 'EMPRESA NO POSEE CAUSA PARA NC CTE',
					@i_num           = 111111
				return 1
			end
		end
		
		if @v_pe_producto = 'AHO'
		begin
			-- Causa de NC para Empresa                                                    
			select @v_causa_nc = b.valor
			from cobis..cl_tabla a inner join cobis..cl_catalogo b
				on a.codigo = b.tabla
			where a.tabla = 'sv_nc_aho_servicios'
			and convert(int,b.codigo) = @e_empresa 
			and estado = 'V'
			if  @@rowcount = 0
			begin
				rollback tran
				exec cobis..sp_cerror
					@t_debug         = 'N',
					@t_file          = @v_file,
					@t_from          = @v_sp_name,
					@i_msg           = 'EMPRESA NO POSEE CAUSA PARA NC AHO',
					@i_num           = 111111
				return 1
			end
		end
	
		exec cob_cuentas..sp_gen_sec2
			@o_ssn = @v_ssn out
		if @@error <> 0
		begin
			if @@trancount > 0
				rollback tran
			exec cobis..sp_cerror
				 @t_debug  = 'N' ,
				 @t_file   = @v_file,
				 @t_from   = @v_sp_name,
				 @i_num    = 105060
			return 105060
		end	
		
		
		if @v_pe_producto = 'CTE'
		begin
			exec @v_return = cob_cuentas..sp_ccndc_automatica
				@s_srv  = 'BOLIVSRV',
				@s_ofi  = 0 ,
				@s_ssn  = @v_ssn,
				@s_user = 'sa' ,
				@s_term = 'consola' ,
				@t_trn  = 3048,
				@i_cta  = @v_pe_cuenta,
				@i_val  = @v_total,
				@i_cau  = @v_causa_nc,
				@i_mon  = 1,
				@i_fecha = @e_fecha_proceso
			if @v_return != 0 or @@error != 0
			begin
				rollback tran				
				exec cobis..sp_cerror
					@t_debug = 'N',
					@t_file  = @v_file,
					@t_from  = @v_sp_name,
					@i_msg   = 'NO SE PUEDE REALIZAR EL CREDITO A LA CUENTA',
					@i_num   = 2103003
				return 2103003
			end
		end
	
		if  @v_pe_producto =  'AHO'
		begin
			exec @v_return = cob_ahorros..sp_ahndc_automatica
			@s_srv  = 'BOLIVSRV',
			@s_ofi  = 0,
			@s_ssn  = @v_ssn,
			@s_user = 'sa' ,
			@s_term = 'consola',
			@t_trn  = 4253,
			@i_cta  = @v_pe_cuenta,
			@i_val  = @v_total,
			@i_cau  = @v_causa_nc,
			@i_mon  = 1,
			@i_fecha = @e_fecha_proceso
			if @v_return != 0 or @@error != 0
			begin
				rollback tran
				exec cobis..sp_cerror
					@t_debug = 'N',
					@t_file  = @v_file,
					@t_from  = @v_sp_name,
					@i_msg   = 'NO SE PUEDE REALIZAR EL CREDITO A LA CUENTA',
					@i_num   = 2103003
				return 2103003
			end
    	end
	
	
		if @v_costo_diario > 0 --realiza el debito por costo en trx
		begin
			if @v_fact_diaria = 'N'
			begin
				if @v_pe_producto =  'CTE'
				begin
					-- Causa de ND para Empresa P2
					select @v_causa_nd = b.valor
					from cobis..cl_tabla a inner join cobis..cl_catalogo b
						on a.codigo = b.tabla
					where a.tabla = 'cc_causas_nd_empresas'
					and convert(smallint,convert(smallint,b.codigo)) = @e_empresa
					and estado = 'V'
					if @@rowcount = 0
					begin
						rollback tran
						exec cobis..sp_cerror
							@t_debug         = 'N',
							@t_file          = @v_file,
							@t_from          = @v_sp_name,
							@i_msg           = 'EMPRESA NO POSEE CAUSA PARA ND CTE <COSTOS>',
							@i_num           = 111112
						return 1
					end
				end

				if @v_pe_producto =  'AHO'
				Begin
					-- Causa de ND para Empresa 
					select @v_causa_nd = b.valor
					from cobis..cl_tabla a inner join cobis..cl_catalogo b
						on a.codigo = b.tabla
					where a.tabla = 'sv_nd_aho_servicios'
					and convert(smallint,convert(smallint,b.codigo)) = @e_empresa
					and estado = 'V'
					if @@rowcount = 0
					begin
						rollback tran
						exec cobis..sp_cerror
							@t_debug         = 'N',
							@t_file          = @v_file,
							@t_from          = @v_sp_name,
							@i_msg           = 'EMPRESA NO POSEE CAUSA PARA ND AHO',
							@i_num           = 111111	
						return 1
					end
				end
			end   
		
			if @v_pe_producto =  'CTE'
			Begin
				exec @v_return = cob_cuentas..sp_ccndc_automatica
					@s_srv  = 'BOLIVSRV',
					@s_ofi  = 0,
					@s_ssn  = @v_ssn,
					@s_user = 'sa',
					@s_term = 'consola',
					@t_trn  = 3050,
					@i_cta  = @v_pe_cuenta,
					@i_val  = @v_costo_diario,
					@i_cau  = @v_causa_nd,
					@i_mon  = 1,
					@i_fecha = @e_fecha_proceso
				if @v_return != 0 or @@error != 0
				begin
					rollback tran
					exec cobis..sp_cerror
						@t_debug = 'N' ,
						@t_file  = @v_file,
						@t_from  = @v_sp_name,
						@i_msg   = 'NO SE PUEDE REALIZAR EL DEBITO DE LA COMISION',
						@i_num   = 2103003
					return 2103003
				end
			end
		
			if @v_pe_producto =  'AHO'
			Begin
				exec @v_return = cob_ahorros..sp_ahndc_automatica
					@s_srv  = 'BOLIVSRV',
					@s_ofi  = 0,
					@s_ssn  = @v_ssn,
					@s_user = 'sa' ,
					@s_term = 'consola' ,
					@t_trn  = 4264,
					@i_cta  = @v_pe_cuenta,
					@i_val  = @v_costo_diario,
					@i_cau  = @v_causa_nd,
					@i_mon  = 1,
					@i_fecha = @e_fecha_proceso
				if @v_return != 0 or @@error != 0
				begin
					rollback tran
					exec cobis..sp_cerror
						@t_debug = 'N' ,
						@t_file  = @v_file,
						@t_from  = @v_sp_name,
						@i_msg   = 'NO SE PUEDE REALIZAR EL DEBITO DE LA COMISION',
						@i_num   = 2103003
					return 2103003
				end
			end
		
		    if @v_base_impo > 0
		    begin
		    	select @v_referencia  = convert (varchar, @e_fecha_proceso,101) + " - " + convert(varchar, @e_empresa)
		
				select @v_trn_iva = 3497
		    	
				exec @v_return = cob_cuentas..sp_cont_impuesto
					@t_trn       = @v_trn_iva, 
					@s_ssn       = @v_ssn,
					@s_date      = @e_fecha_proceso,
					@t_corr      = 'N', ---- @t_corr,
					@s_user      = 'sa',
					@s_term      = 'consola',
					@s_ofi       = 0 ,
					@t_rty       = 'N' ,
					@s_org       = 'U' ,
					@i_base_imp  = @v_base_impo,
					@i_iva       = @v_impuesto2,
					@i_total     = @v_costo_diario,
					@i_cau       = @v_servicio,
					@i_cta       = @v_referencia,   --referencia
					@i_mon       = 1     --Moneda
				if @v_return <> 0 or @@error != 0
				begin
					if @@trancount > 0
						rollback tran
					return @v_return
				end
    		end
    	end  
	end  --fin NCR

	exec cob_cuentas..sp_gen_sec2
		@o_ssn = @v_ssn out
	if @@error <> 0
	begin
		if @@trancount > 0
			rollback tran
		
		exec cobis..sp_cerror
			 @t_debug  = 'N' ,
			 @t_file   = @v_file,
			 @t_from   = @v_sp_name,
			 @i_num    = 105060
		return 105060
	end	
		
	insert into cob_cuentas..cc_tran_servicio (
		ts_secuencial	, ts_tipo_transaccion	, ts_oficina	, ts_usuario	, ts_rol		, ts_terminal	,  
		ts_reentry		, ts_origen				, ts_nodo		, ts_tsfecha	, ts_clase		, ts_referencia	, 
		ts_hora			, ts_moneda				, ts_tipo		, ts_valor		, ts_saldo		, ts_monto		,
		ts_contratado	, ts_aporte_iess		, ts_causa		, ts_fecha		, ts_fecha_aper	, ts_descuento_iess, 
		ts_fonres_iess	, ts_ocasional	)
		values (
		@v_ssn			, 3227					, 0				, 'operador'	, 999			, 'consola'		, 
		null			, 'L'					, 'BOLIVSRV'	, @e_fecha_proceso, 'P'			, 'NCRCTA'		,	
		getdate()		, 1						, 'L'			, @v_total		, 0				, @v_total		,
		0				, @v_costo_diario		, convert(varchar(6),@e_empresa),@e_fecha_proceso,@e_fecha_proceso, @v_costo_diario, 
		@v_val_retencion ,null	)
	if @@error != 0
	begin
		rollback tran
		exec cobis..sp_cerror
			@t_debug        = "N",
			@t_file         = "pglccntb.sp",
			@t_from         = "pa_pag_blc_cnt",
			@i_num          = 170600,
			@i_msg    = 'ERROR EN TRANSACCION DE SERVICIO' 
		return 033000             
	end

	
    
	insert cob_pagos..pg_control_ncrecaudacion(
	pn_empresa		, pn_fecha_rec		, pn_fecha_pago		, pn_valor				, pn_retencion		, pn_costo_recauda		,
	pn_cont_trn		, pn_forma_pago		, pn_estado			, pn_secuencial			, pn_retimpret		, pn_cta_banco			,
	pn_fecha_efec	, pn_tipo_empresa	, pn_sec_servicio	, pn_valor_uno			, pn_fact_elect		, pn_autorizacion		, 
	pn_fecval_formato, pn_fecha_ini_vig	, pn_fecha_fin_vig	, pn_contrib_especial	, pn_baseimp0		, pn_baseimp12			, 
	pn_ivabienes	, pn_ivaservicio	, pn_exonera_ivabienes, pn_exonera_ivaserv	, pn_val_ret_bienes	, pn_val_ret_serv 	)
	values (
	@e_empresa		, @e_fecha_proceso	, @v_fecha_pago		, @v_total				, @v_retencion		, @v_costo_diario		,
	@v_total_trn	, @v_pe_fpago		, 'P'				, null					, @v_val_retencion	, @v_pe_cuenta			,
	@e_fecha_proceso, @v_tipo_empresa	, @v_carga			, @v_base				, @v_ind_factelect	, @v_autorizacion		,
	@v_validez		, @v_fec_ini_vig_aut, @v_fec_fin_vig_aut, @v_cont_especial		, @v_baseimp0		, @v_baseimp12			, 
	@v_val_ivabienes, @v_val_ivaserv	, @v_exo_ivabienes	, @v_exo_ivaserv		, @v_ret_ivabienes	, @v_ret_ivaserv	)
	if @@rowcount = 0
	begin
		rollback tran
		exec cobis..sp_cerror
			@t_debug = "N",
			@t_file  = "pglccntb.sp",
			@t_from  = "pa_pag_blc_cnt",
			@i_num   = 170600,
			@i_msg    = 'ERROR EN TABLA DE NC A EMPRESAS'
		return 2103001
	end

COMMIT TRAN

end

return 0

go

if exists(select 1 from sysobjects where name='pa_pag_blc_cnt')
	PRINT '== CREATE PROCEDURE pa_pag_blc_cnt *OK* =='
else
	PRINT '<<< CREATE PROCEDURE pa_pag_blc_cnt -- ERROR -- >>>'
go

