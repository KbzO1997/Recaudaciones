use cob_pagos
go

if exists (select 1 from dbo.sysobjects where name = 'pa_pag_brecau_privadas' and type = 'P')
begin
	drop procedure dbo.pa_pag_brecau_privadas
	if exists (select 1 from sysobjects where name = 'pa_pag_brecau_privadas' and type = 'P')
		PRINT '<<< DROP PROCEDURE pa_pag_brecau_privadas -- ERROR -- >>>'
	else
		PRINT '== DROP PROCEDURE pa_pag_brecau_privadas *OK* =='
end
go


/************************************************************************/
/*    Archivo           : pgcrecpri.sp                                  */
/*    Stored procedure  : pa_pag_brecau_privadas   	                    */
/*    Base de datos     : cob_pagos                                     */
/*    Producto          : Cuentas de pagos                              */
/*    Disenado por      : Danny Olaya S.                                */
/*    Fecha de escritura: 11/29/2018                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
/*    Este programa es parte de los paquetes bancarios propiedad del    */
/*    "BANCO BOLIVARIANO".                                              */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus usuarios  */
/*    sin el debido consentimiento por escrito de la Presidencia        */
/*    Ejecutiva del BANCO BOLIVARIANO o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa se encarga de poblar la tabla de recaudaciones privadas */
/*    con las transacciones 3925,3926,3927 y 3928 con fecha anterior    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/*0  12/03/2018   Danny Olaya S. Emisión Inicial                        */
/*1  12/03/2018   Danny Olaya S. HU002 EXTRACCIÓN DE RECAUDACIONES PRIVADAS */
/*2  12/03/2018   Danny Olaya S. RECM-109 Control de fecha de recaudacion */
/*3  05/27/2020   María José Silva RECM-138  Ajustes de tipo trx 		*/
/*4  09/25/2020   María José Silva RECM-189  Eliminar parte de ajuste	*/
/*5  10/01/2020   María José Silva RECM-191  Incorporar cobro comision empresa	*/
/*6  10/29/2020   María José Silva RECM-199  Control asume tarifa comision empresa*/
/*7  11/23/2020   Jonathan Guerrero RECM-211 Reproceso Cubo Recaudaciones Privadas*/
/*8  11/30/2020   Jonathan Guerrero RECM-213 Ajuste conversion tipo de dato*/
/*9  12/11/2020   Jonathan Guerrero RECM-218 Mejora al proceso de Cubo    */
/**************************************************************************/

create proc dbo.pa_pag_brecau_privadas
(   
@e_fecha_desde datetime,  -- Ref007:jguerrej 
@e_fecha_hasta datetime,  -- Ref007:jguerrej 
@e_reintento char(1) = 'N',
@t_debug     char(1) = 'N',
@t_file      varchar(14) = null
)
as
declare             
    @v_sp_name                  varchar(30),
	@v_error          			int,
	@v_porcIva					float,
	@v_cant_trx_h				int,
	@v_procesado				int  -- Ref007:jguerrej 

--PRINT 'Inicio'
--PRINT  select convert(char(26), getdate(), 109)

select @v_sp_name = 'pa_pag_brecau_privadas'

--Tabla temporal de recaudaciones privadas
if object_id('tempdb.dbo.#reca_tmp_brecau_priv_his') is not null
    drop table #reca_tmp_brecau_priv_his
	
if object_id('tempdb.dbo.#reca_tmp_brecau_priv_his2') is not null
    drop table #reca_tmp_brecau_priv_his2	
	
	
if object_id('tempdb.dbo.#reca_tmp_brecau_priv_acum') is not null
    drop table #reca_tmp_brecau_priv_acum
		
if object_id('tempdb.dbo.#reca_tmp_brecau_priv_acum2') is not null
    drop table #reca_tmp_brecau_priv_acum2

	
	
select @v_cant_trx_h=0

select @v_porcIva = isnull(pa_float,0)
from cobis..cl_parametro 
where pa_nemonico = 'IVA'
and pa_producto  = 'CTE'

if @e_reintento = 'S'
begin   
  if exists(select 1 from cob_pagos..reca_h_emppri where em_fecha_proc >= @e_fecha_desde and em_fecha_proc < = @e_fecha_hasta)
	begin
			set @v_procesado = 5000
			set rowcount 5000

			while @v_procesado = 5000
			   begin
			   
					  delete from cob_pagos..reca_h_emppri where em_fecha_proc >= @e_fecha_desde and em_fecha_proc < = @e_fecha_hasta 
					  select @v_procesado = @@rowcount, @v_error = @@error

					  if @v_error <> 0
					  begin
						   exec cobis..sp_cerror
							   @t_debug  = @t_debug,
							   @t_file   = @t_file,
							   @t_from   = @v_sp_name,
							   @i_num    = 30004034
						   return 30004034
					   end

					 dump transaction cob_pagos with truncate_only   
			   end
			set rowcount 0

			-- Actualizamos estadísticas
			update index statistics cob_pagos..reca_h_emppri 
			execute sp_recompile reca_h_emppri 

	end
end

	select hs_ssn_corr, hs_secuencial,  hs_tsfecha,   hs_correccion,
	       hs_causa,    hs_hora,        hs_oficina,   hs_filial,
		   hs_usuario,	hs_monto,	    hs_valor,     hs.hs_tipo_chequera,
		   hs_saldo,	hs_autoriz_aut, hs_cta_banco, hs_tipo_transaccion,
           hs_tipocta,  convert(int,hs_causa) as hs_causa_int		   
	into #reca_tmp_brecau_priv_his
	from cob_cuentas_his..cc_his_servicio hs
	where (hs_tsfecha  >= @e_fecha_desde  and hs_tsfecha < = @e_fecha_hasta)
	and hs_tipo_transaccion in (select convert(int,c.codigo) 
							from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
							where t.tabla = 'cl_trx_emp_pri' 
							and c.estado = 'V')
	and hs_causa in (select c.codigo
						from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
						where t.tabla = 'cl_emp_pri' 
						and c.estado = 'V')
						
						   
		if @@error <> 0
		begin
			exec cobis..sp_cerror
				@t_debug  = @t_debug,
				@t_file   = @t_file,
				@t_from   = @v_sp_name,
				@i_num    = 300003377
			return 300003377
		end		 

    create index i_reca_tmp_brecau_priv_his_01 on #reca_tmp_brecau_priv_his (hs_causa_int)
    create index i_reca_tmp_brecau_priv_his_02 on #reca_tmp_brecau_priv_his (hs_correccion, hs_ssn_corr)
			

	-- Verificar que existan registros a reprocesar en cc_his_servicio    Ref007:jguerrej 
      if exists(select 1 
				from #reca_tmp_brecau_priv_his hs
				where (hs.hs_correccion = 'N' or hs.hs_correccion is null)
				and not exists (select 1 
								from #reca_tmp_brecau_priv_his
								where hs_ssn_corr = hs.hs_secuencial
								and hs_correccion = 'S') )  			
		begin
		      			
					select 
							hs_secuencial SECUENCIAL,
								hs_causa	EMPRESA,
								convert(varchar,hs_tsfecha,101) FEC_PROC,
								hs_hora FEC_REC,
								hs_oficina OFI_PAGO,
								hs_filial FIL_PAGO,
								case hs.hs_tipo_chequera
									when 'VEN' then 'VENTANILLA'
									when 'IBK' then 'WEB'
									when 'ATM' then 'ATM'
									when 'WAP' then 'TELEFONO'
									when 'DIR' then 'BATCH'
									when 'DBA' then 'DBA'
									when 'CNB' then 'CNB'
									when 'CPV' then 'CPV'
									when 'SAT' then 'SAT'
									when 'IVR' then 'IVR'
								end TIP_CANAL,
								(select 
								case valor
									when 'L' then 'EN LINEA'
									when 'B' then 'BATCH'
									else 'REF/BANCA'
								end
								from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
								where t.tabla = 'cl_emp_pri_serv' and c.estado = 'V' and c.codigo = hs.hs_causa)   TIP_SERV,
								convert(varchar,hs_tipo_transaccion) TRX, --Ref003:msilvag 
								hs_usuario USUARIO,
								(case hs.hs_causa 
									when '696' then hs_usuario
								end) USUARIO_REFBAN,
								(select ce.en_ente from cobis..cl_ente ce where en_ced_ruc = pe.pe_ruc and pe.pe_empresa = hs.hs_causa_int) COD_MIS,
								pe_ruc IDENTIFICACION,
								(select cs.valor from cobis..cl_ente ce inner join cobis..v_acf_cl_segmento_cart cs on cs.codigo = ce.en_segmento_cart where ce.en_ced_ruc = pe.pe_ruc) SEGMENTO,
								(select fu.fu_nombre from cobis..cl_ente ce inner join cobis..cl_funcionario fu on ce.en_oficial = fu.fu_funcionario where ce.en_ced_ruc = pe.pe_ruc) OFICIAL,
								'' DIVISION,
								'' BANCA_CONSO,
								'' OFICIAL_BANCA,	
								(select convert(varchar,ofi.of_oficina)+"-"+ofi.of_nombre from cobis..cl_ente ce inner join cobis..cl_oficina ofi on ce.en_oficina_manejo = ofi.of_oficina where ce.en_ced_ruc = pe.pe_ruc) OFICINA_MAN,
								(select b.valor from cobis..cl_tabla a inner join cobis..cl_catalogo b on a.codigo = b.tabla where a.tabla = 'cl_zona' 
								and b.codigo = (select pv_region_ope from cobis..cl_provincia pro inner join cobis..cl_oficina ofi on pro.pv_provincia = convert(int,ofi.of_provincia) 
								and ofi.of_oficina = hs.hs_oficina)) ZONA_MCLI,
								'' OFICIAL_CASH,
								(case
									--Ref006:msilvag Inicio
									when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera ) 
										then 'EMPRESA'
									--Ref006:msilvag Fin
									when convert(money,hs_autoriz_aut) > 0 then 'CLIENTE'
									when convert(money,hs_autoriz_aut) =0 and pe_costo > 0 then 'EMPRESA'
									when convert(money,hs_autoriz_aut) > 0 and pe_costo > 0 then 'CLI/EMP'
									else 'N/A'
								end) ASUME_TARIF,
								(case 
									when hs_monto > 0 then 'S'
									else 'N'
								end) CLI_BB,
								((case when isnull(hs_valor,0) > 0 then "EFECTIVO/" end) +
								 (case when isnull(hs_saldo,0) > 0 then "CHEQUE/" end) +
								 (case when isnull(hs_monto,0) > 0 and hs_tipocta ='C' then "DEB CTA CTE/" end)+
								(case when isnull(hs_monto,0) > 0 and hs_tipocta ='A' then "DEB CTA AHO/" end)
								) TIPO_PAGO,
								(case 
									when hs_monto > 0 and hs_tipo_transaccion <> 3227 then hs_cta_banco
									else ''
								end) NUM_CTA,
								(case
									when hs_tipo_transaccion =3227 then hs_valor
									else (hs_valor+hs_saldo+hs_monto)
								end) MONTO_RECA,
								--Ref005:msilvag Inicio
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then  (select pg_costo from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select pe_costo from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									 else
										isnull(convert(money,hs_autoriz_aut),0) 
								end COMI_TOT,
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then (select round(isnull(convert(money,pg_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_costo_com_canal where pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select round(isnull(convert(money,pe_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									else
										round(isnull(convert(money,hs_autoriz_aut)/(@v_porcIva+1),0),2)
								end COMISION ,
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then (select round(isnull(convert(money,pg_costo) - convert(money,pg_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_costo_com_canal where pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select round(isnull(convert(money,pe_costo) - convert(money,pe_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									else
										round(isnull(convert(money,hs_autoriz_aut) - convert(money,hs_autoriz_aut)/(@v_porcIva+1),0),2)
								end IVA_COMI , 
								--Ref005:msilvag Fin
								(case
									when hs_tipo_transaccion =3227 then hs_valor
									else 0
								end) ACRED_EMP,
								(case
									when hs_tipo_transaccion =3227 then (SELECT isnull(pn_retimpret,0) FROM cob_pagos..pg_control_ncrecaudacion WHERE pn_empresa = hs.hs_causa_int and pn_fecha_pago = hs.hs_tsfecha) -- Ref007:jguerrej 
									else 0
								end)  VALOR_RETEN,
								(case
									when hs_tipo_transaccion =3227 then (SELECT isnull(pn_retimpret,0) FROM cob_pagos..pg_control_ncrecaudacion WHERE pn_empresa = hs.hs_causa_int and pn_fecha_pago = hs.hs_tsfecha) -- Ref007:jguerrej 
									else 0
								end) RETEN_FTE,
								0 TOT_AJUS
							into #reca_tmp_brecau_priv_his2
							from #reca_tmp_brecau_priv_his hs  inner join cob_pagos..pg_person_empresa pe
							--on hs.hs_causa = convert(varchar,pe.pe_empresa)
							on hs.hs_causa_int = pe.pe_empresa
							where (hs.hs_correccion = 'N' or hs.hs_correccion is null)
							and not exists (select 1 
											from #reca_tmp_brecau_priv_his
											where hs_ssn_corr = hs.hs_secuencial
											and hs_correccion = 'S')									
																																			
							if @@error <> 0
							begin
								exec cobis..sp_cerror
									 @t_debug  = @t_debug,
									 @t_file   = @t_file,
									 @t_from   = @v_sp_name,
									 @i_num    = 30004034
								return 30004034
							end	
								
					
					set rowcount 5000
					select @v_cant_trx_h =  5000
					while (@v_cant_trx_h=5000)
					begin
						insert into cob_pagos..reca_h_emppri (
							em_secuencial, em_empresa,em_fecha_proc,em_fecha_reca,em_ofi_pago,em_fil_pago,
							em_ti_canal,em_ti_serv,em_trx,em_user_reca,em_user_refban,em_cod_mis,em_identificacion,
							em_segmento,em_oficial,em_division,em_banca_conso,em_oficial_banca,em_oficina_mane,em_zona_mcliente,
							em_oficial_cash,em_asume_tarif,em_cli_bb,em_tipo_pago,em_num_cta,em_monto_reca,em_comision_tot,em_comision,
							em_iva_comision,em_acred_emp,em_valor_reten,em_reten_fuente,em_tot_ajuste)														
						    select SECUENCIAL,EMPRESA,FEC_PROC,FEC_REC,OFI_PAGO,FIL_PAGO,TIP_CANAL,TIP_SERV,
								TRX,USUARIO,USUARIO_REFBAN,COD_MIS,IDENTIFICACION, SEGMENTO, OFICIAL, DIVISION,BANCA_CONSO,
								OFICIAL_BANCA, OFICINA_MAN, ZONA_MCLI, OFICIAL_CASH, ASUME_TARIF, CLI_BB, TIPO_PAGO, NUM_CTA, MONTO_RECA, COMI_TOT,
								COMISION, IVA_COMI, ACRED_EMP, VALOR_RETEN, RETEN_FTE, TOT_AJUS
							from #reca_tmp_brecau_priv_his2
							
						select @v_cant_trx_h = @@rowcount, @v_error = @@error
						
						if @v_error <> 0
						begin
							exec cobis..sp_cerror
								@t_debug  = @t_debug,
								@t_file   = @t_file,
								@t_from   = @v_sp_name,
								@i_num    = 300003377
							return 300003377
						end
						
						set rowcount @v_cant_trx_h
						delete from #reca_tmp_brecau_priv_his2
						
						if @@error <> 0
						begin
							exec cobis..sp_cerror
								@t_debug  = @t_debug,
								@t_file   = @t_file,
								@t_from   = @v_sp_name,
								@i_num    = 300003379
							return 300003379
						end					
					end		

					if object_id('tempdb.dbo.#reca_tmp_brecau_priv_his') is not null
						drop table #reca_tmp_brecau_priv_his
						
					if object_id('tempdb.dbo.#reca_tmp_brecau_priv_his2') is not null
						drop table #reca_tmp_brecau_priv_his2	
					
			end	

		
			else
			-- Si no existen datos, busca en la tabla cc_his_servicio_acum	  Ref007:jguerrej 		
			begin		
						
						select hs_ssn_corr, hs_secuencial,  hs_tsfecha,   hs_correccion,
							   hs_causa,    hs_hora,        hs_oficina,   hs_filial,
							   hs_usuario,	hs_monto,	    hs_valor,     hs.hs_tipo_chequera,
							   hs_saldo,	hs_autoriz_aut, hs_cta_banco, hs_tipo_transaccion,
							   hs_tipocta,  convert(int,hs_causa) hs_causa_int			   
						into #reca_tmp_brecau_priv_acum
						from cob_cuentas_acum..cc_his_servicio_acum hs
						where (hs_tsfecha  >= @e_fecha_desde  and hs_tsfecha < = @e_fecha_hasta)
						and hs_tipo_transaccion in (select convert(int,c.codigo) 
												from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
												where t.tabla = 'cl_trx_emp_pri' 
												and c.estado = 'V')	

						create index i_reca_tmp_brecau_priv_acum_01 on #reca_tmp_brecau_priv_acum (hs_causa_int)
						create index i_reca_tmp_brecau_priv_acum_02 on #reca_tmp_brecau_priv_acum (hs_correccion, hs_ssn_corr)
												
																							
						if @@error <> 0
						begin
							exec cobis..sp_cerror
								 @t_debug  = @t_debug,
								 @t_file   = @t_file,
								 @t_from   = @v_sp_name,
								 @i_num    = 30004034
							return 30004034
						end		
						
						select 
								hs_secuencial SECUENCIAL,
								hs_causa	EMPRESA,
								convert(varchar,hs_tsfecha,101) FEC_PROC,
								hs_hora FEC_REC,
								hs_oficina OFI_PAGO,
								hs_filial FIL_PAGO,
								case hs.hs_tipo_chequera
									when 'VEN' then 'VENTANILLA'
									when 'IBK' then 'WEB'
									when 'ATM' then 'ATM'
									when 'WAP' then 'TELEFONO'
									when 'DIR' then 'BATCH'
									when 'DBA' then 'DBA'
									when 'CNB' then 'CNB'
									when 'CPV' then 'CPV'
									when 'SAT' then 'SAT'
									when 'IVR' then 'IVR'
								end TIP_CANAL,
								(select 
								case valor
									when 'L' then 'EN LINEA'
									when 'B' then 'BATCH'
									else 'REF/BANCA'
								end
								from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
								where t.tabla = 'cl_emp_pri_serv' and c.estado = 'V' and c.codigo = hs.hs_causa)   TIP_SERV,
								convert(varchar,hs_tipo_transaccion) TRX, --Ref003:msilvag 
								hs_usuario USUARIO,
								(case hs.hs_causa 
									when '696' then hs_usuario
								end) USUARIO_REFBAN,
								(select ce.en_ente from cobis..cl_ente ce where en_ced_ruc = pe.pe_ruc and pe.pe_empresa = hs.hs_causa_int) COD_MIS,
								pe_ruc IDENTIFICACION,
								(select cs.valor from cobis..cl_ente ce inner join cobis..v_acf_cl_segmento_cart cs on cs.codigo = ce.en_segmento_cart where ce.en_ced_ruc = pe.pe_ruc) SEGMENTO,
								(select fu.fu_nombre from cobis..cl_ente ce inner join cobis..cl_funcionario fu on ce.en_oficial = fu.fu_funcionario where ce.en_ced_ruc = pe.pe_ruc) OFICIAL,
								'' DIVISION,
								'' BANCA_CONSO,
								'' OFICIAL_BANCA,	
								(select convert(varchar,ofi.of_oficina)+"-"+ofi.of_nombre from cobis..cl_ente ce inner join cobis..cl_oficina ofi on ce.en_oficina_manejo = ofi.of_oficina where ce.en_ced_ruc = pe.pe_ruc) OFICINA_MAN,
								(select b.valor from cobis..cl_tabla a inner join cobis..cl_catalogo b on a.codigo = b.tabla where a.tabla = 'cl_zona' 
								and b.codigo = (select pv_region_ope from cobis..cl_provincia pro inner join cobis..cl_oficina ofi on pro.pv_provincia = convert(int,ofi.of_provincia) 
								and ofi.of_oficina = hs.hs_oficina)) ZONA_MCLI,
								'' OFICIAL_CASH,
								(case
									--Ref006:msilvag Inicio
									when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera ) 
										then 'EMPRESA'
									--Ref006:msilvag Fin
									when convert(money,hs_autoriz_aut) > 0 then 'CLIENTE'
									when convert(money,hs_autoriz_aut) =0 and pe_costo > 0 then 'EMPRESA'
									when convert(money,hs_autoriz_aut) > 0 and pe_costo > 0 then 'CLI/EMP'
									else 'N/A'
								end) ASUME_TARIF,
								(case 
									when hs_monto > 0 then 'S'
									else 'N'
								end) CLI_BB,
								((case when isnull(hs_valor,0) > 0 then "EFECTIVO/" end) +
								 (case when isnull(hs_saldo,0) > 0 then "CHEQUE/" end) +
								 (case when isnull(hs_monto,0) > 0 and hs_tipocta ='C' then "DEB CTA CTE/" end)+
								(case when isnull(hs_monto,0) > 0 and hs_tipocta ='A' then "DEB CTA AHO/" end)
								) TIPO_PAGO,
								(case 
									when hs_monto > 0 and hs_tipo_transaccion <> 3227 then hs_cta_banco
									else ''
								end) NUM_CTA,
								(case
									when hs_tipo_transaccion =3227 then hs_valor
									else (hs_valor+hs_saldo+hs_monto)
								end) MONTO_RECA,
								--Ref005:msilvag Inicio
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then  (select pg_costo from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select pe_costo from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									 else
										isnull(convert(money,hs_autoriz_aut),0) 
								end COMI_TOT,
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then (select round(isnull(convert(money,pg_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_costo_com_canal where pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select round(isnull(convert(money,pe_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									else
										round(isnull(convert(money,hs_autoriz_aut)/(@v_porcIva+1),0),2)
								end COMISION ,
								case when exists (select 1 from cob_pagos..pg_costo_com_canal  where  pg_empresa = hs.hs_causa_int  and pg_canal = hs.hs_tipo_chequera ) --Ref006:msilvag hs.hs_causa = '7256' 
										then (select round(isnull(convert(money,pg_costo) - convert(money,pg_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_costo_com_canal where pg_empresa = hs.hs_causa_int and pg_canal = hs.hs_tipo_chequera )
									 when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo where t.tabla = 'cl_cobro_comi_emp' and c.codigo  = hs.hs_causa and c.estado = 'V' ) 
										then (select round(isnull(convert(money,pe_costo) - convert(money,pe_costo)/(@v_porcIva+1),0),2) from cob_pagos..pg_person_empresa where pe_empresa = hs.hs_causa_int )
									else
										round(isnull(convert(money,hs_autoriz_aut) - convert(money,hs_autoriz_aut)/(@v_porcIva+1),0),2)
								end IVA_COMI , 
								--Ref005:msilvag Fin
								(case
									when hs_tipo_transaccion =3227 then hs_valor
									else 0
								end) ACRED_EMP,
								(case
									when hs_tipo_transaccion =3227 then (SELECT isnull(pn_retimpret,0) FROM cob_pagos..pg_control_ncrecaudacion WHERE pn_empresa = hs.hs_causa_int and pn_fecha_pago = hs.hs_tsfecha) -- Ref007:jguerrej 
									else 0
								end)  VALOR_RETEN,
								(case
									when hs_tipo_transaccion =3227 then (SELECT isnull(pn_retimpret,0) FROM cob_pagos..pg_control_ncrecaudacion WHERE pn_empresa = hs.hs_causa_int and pn_fecha_pago = hs.hs_tsfecha) -- Ref007:jguerrej 
									else 0
								end) RETEN_FTE,
								0 TOT_AJUS
								into #reca_tmp_brecau_priv_acum2
								from #reca_tmp_brecau_priv_acum hs  inner join cob_pagos..pg_person_empresa pe
								--on hs.hs_causa = convert(varchar,pe.pe_empresa)
								on hs.hs_causa_int = pe.pe_empresa
								where (hs.hs_correccion = 'N' or hs.hs_correccion is null)
								and hs_causa in (select c.codigo
												 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla
												 where t.tabla = 'cl_emp_pri' 
												 and c.estado = 'V')
								and not exists (select 1 
												from #reca_tmp_brecau_priv_acum
												where hs_ssn_corr = hs.hs_secuencial
												and hs_correccion = 'S')
												
								if @@error <> 0
								begin
									exec cobis..sp_cerror
										 @t_debug  = @t_debug,
										 @t_file   = @t_file,
										 @t_from   = @v_sp_name,
										 @i_num    = 30004034
									return 30004034
								end		

						
						set rowcount 5000
							select @v_cant_trx_h =  5000
							while (@v_cant_trx_h=5000)
							begin
								insert into cob_pagos..reca_h_emppri (
									em_secuencial, em_empresa,em_fecha_proc,em_fecha_reca,em_ofi_pago,em_fil_pago,
									em_ti_canal,em_ti_serv,em_trx,em_user_reca,em_user_refban,em_cod_mis,em_identificacion,
									em_segmento,em_oficial,em_division,em_banca_conso,em_oficial_banca,em_oficina_mane,em_zona_mcliente,
									em_oficial_cash,em_asume_tarif,em_cli_bb,em_tipo_pago,em_num_cta,em_monto_reca,em_comision_tot,em_comision,
									em_iva_comision,em_acred_emp,em_valor_reten,em_reten_fuente,em_tot_ajuste)
								select SECUENCIAL,EMPRESA,FEC_PROC,FEC_REC,OFI_PAGO,FIL_PAGO,TIP_CANAL,TIP_SERV,
								TRX,USUARIO,USUARIO_REFBAN,COD_MIS,IDENTIFICACION, SEGMENTO, OFICIAL, DIVISION,BANCA_CONSO,
								OFICIAL_BANCA, OFICINA_MAN, ZONA_MCLI, OFICIAL_CASH, ASUME_TARIF, CLI_BB, TIPO_PAGO, NUM_CTA, MONTO_RECA, COMI_TOT,
								COMISION, IVA_COMI, ACRED_EMP, VALOR_RETEN, RETEN_FTE, TOT_AJUS
								from #reca_tmp_brecau_priv_acum2
								
									
								select @v_cant_trx_h = @@rowcount, @v_error = @@error
								
								if @v_error <> 0
								begin
									exec cobis..sp_cerror
										@t_debug  = @t_debug,
										@t_file   = @t_file,
										@t_from   = @v_sp_name,
										@i_num    = 300003377
									return 300003377
								end
								
								set rowcount @v_cant_trx_h
								delete from #reca_tmp_brecau_priv_acum2
								
								if @@error <> 0
								begin
									exec cobis..sp_cerror
										@t_debug  = @t_debug,
										@t_file   = @t_file,
										@t_from   = @v_sp_name,
										@i_num    = 300003379
									return 300003379
								end
							
							end
							
							if object_id('tempdb.dbo.#reca_tmp_brecau_priv_acum') is not null
								drop table #reca_tmp_brecau_priv_acum
									
							if object_id('tempdb.dbo.#reca_tmp_brecau_priv_acum2') is not null
								drop table #reca_tmp_brecau_priv_acum2

																	
				end			
												
--PRINT 'Fin'
--PRINT  select convert(char(26), getdate(), 109)

return 0

go

if exists(select 1 from sysobjects where name='pa_pag_brecau_privadas')
	PRINT '== CREATE PROCEDURE pa_pag_brecau_privadas *OK* =='
else
	PRINT '<<< CREATE PROCEDURE pa_pag_brecau_privadas -- ERROR -- >>>'
go