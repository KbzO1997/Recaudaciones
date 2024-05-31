use cob_pagos
go
if exists(select 1 from sysobjects where name = 'pa_pg_bconcilia_reca_banred' and type = 'P')
begin
   drop procedure dbo.pa_pg_bconcilia_reca_banred
   if exists (select 1 from sysobjects where name = 'pa_pg_bconcilia_reca_banred' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_bconcilia_reca_banred -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_bconcilia_reca_banred *OK* =='
end
go
/***********************************************************************************/
/*   Archivo:                pacnibrd.sp                       					   */
/*   Motor de Base:      	 SYBASE                                      	  	   */
/*   Servidor:           	 HP-ACT                                  		       */
/*   Base de datos:          cob_pagos                                             */
/*   Procesamiento:      	 BATCH                                        	 	   */
/*   Aplicacion:         	 CyberBank                                  		   */
/*   Stored Procedure:       pa_pg_bconcilia_reca_banred                          */
/*   Diseñado por:           Dario Espinosa Aldean                                 */
/*   Fecha de escritura:     04/Mar/2022                                           */
/***********************************************************************************/
/*                                 IMPORTANTE                                      */
/*      "Este programa es parte de los paquetes bancarios propiedad de             */
/*      BANCO BOLIVARIANO S.A.                                                     */
/*      Su uso no autorizado queda expresamente prohibido asi como                 */
/*      cualquier alteracion o agregado hecho por alguno de sus                    */
/*      usuarios sin el debido consentimiento por escrito de la                    */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante."            */
/***********************************************************************************/
/*                                  PROPOSITO                                      */
/* BATCH: Generación de la Información del Archivo Consolidado para Banred, la info*/
/* se guarda en la tabla física db_general..reca_tmp_concilia_banred                */
/***********************************************************************************/
/*                               MODIFICACIONES:                                   */
/* REF FECHA        AUTOR         TAREA JIRA	                  DESCRIPCION      */
/* 01  04/Mar/2022  Dario Espinosa  ARCHIVO CONCILIACION           Emision Inicial  */
/************************************************************************************/

create proc dbo.pa_pg_bconcilia_reca_banred (
@e_fecha_corte      datetime,
@e_reproceso        char(1) = 'N',
@s_treg_cabecera    char(2) = '' out,
@s_tipo_servicio    char(6) = '' out,
@s_total_registros  varchar(10) = '0' out,
@s_long_archivo     varchar(10) = '0' out,
@s_total_recaudado  varchar(20) = '0' out,
@s_nombre_archivo   varchar(25) = 'X' out
)
as
  declare @v_sp_name      varchar(32),
          @v_return       int,
          @v_ind_cab      varchar(2),
          @v_ind_det      varchar(2),
          @v_servicio     varchar(6),
          @v_ori_reg      varchar(2),
          @v_tipo_proc    varchar(4),
          @v_nom_arch     varchar(10),
          @v_ext_arch     varchar(3),
          @v_relleno_num  varchar(1),
          @v_tot_reg      int,
          @v_tot_recauda  bigint


  truncate table db_general..reca_tmp_concilia_banred
  ----------------------------------------------------------------------
  -- Selección de Empresas que se procesaran en el Archivo Consolidado
  if object_id('tempdb.dbo.#reca_tmp_empresas_banred') is not null
    drop table #reca_tmp_empresas_banred
  --
  select em_empresa = convert(int,c.codigo),
  	 em_codigo = c.valor 
    into #reca_tmp_empresas_banred
    from cobis..cl_catalogo c 
	inner join cobis..cl_tabla t on (t.codigo = c.tabla)
	where t.tabla = 'sv_reca_concilia_banred'
	and c.estado = 'V'
   --
   if @@error <> 0 
       begin
         set @v_return = 5004011
         print 'ERROR LECTURA CATALOGO sv_reca_concilia_banred'
         return @v_return 
    end
   -- Selección de Tipo-Trx que se procesaran en el Archivo Consolidado
    if object_id('tempdb.dbo.#reca_tmp_trx_serv_banred') is not null
      drop table #reca_tmp_trx_serv_banred
    --
    select ts_codigo = c.codigo
      into #reca_tmp_trx_serv_banred
      from cobis..cl_catalogo c 
	  inner join cobis..cl_tabla t on (t.codigo = c.tabla)
      where t.tabla = 'sv_reca_concilia_trx_banred'
      and c.estado = 'V'
  --
  if @@error <> 0 
    begin
      set @v_return = 5004011
      print 'ERROR LECTURA CATALOGO sv_reca_concilia_trx_banred'
      return @v_return 
    end
	
   
  ----------- CONFIGURACIONES GENERALES ARCHIVO BANRED --------------
  set @v_ind_cab   = 'HE'             -- RCP-TIPO-REGISTRO CAB
  set @v_ind_det   = 'DR'             -- RCP-TIPO-REGISTRO DET
  set @v_servicio  = '001036'	      -- RCP-SERVICIO-SUBSERVICIO
  set @v_ori_reg   = 'AD'             -- RCP-ORIGEN-REGISTRO
  set @v_tipo_proc = '0210'	          -- RCP-CODIGO-TIPO-MENSAJE
  set @v_nom_arch  = 'A036DDCBOL'     -- NOMBRE ARCHIVO
  set @v_ext_arch  = 'TXT'	          -- EXTENSION ARCHIVO
  set @v_relleno_num = '0'            -- RELLENO

  ----------- FIN CONFIGURACIONES GENERALES ARCHIVO BANRED --------------
  
  if @e_reproceso = 'N' -- Cuando no es reproceso se leen las estructuras de las transacciones del día
    begin
       -- Control tablas temporales       
       if object_id('tempdb.dbo.#reca_tmp_trx_reversadas_banred') is not null
         drop table #reca_tmp_trx_reversadas_banred
       -------------- Transacciones Reversadas --------------
       select x.ts_ssn_corr
         into #reca_tmp_trx_reversadas_banred
         from cob_cuentas..cc_tran_servicio x
		 inner join #reca_tmp_empresas_banred e on (e.em_empresa = convert(int, x.ts_causa))
		 inner join #reca_tmp_trx_serv_banred s on (s.ts_codigo = convert(varchar, x.ts_tipo_transaccion))
        where x.ts_tsfecha = @e_fecha_corte
          and x.ts_correccion = 'S'
       
       if @@error <> 0 
        begin
          set @v_return = 33333
          print 'ERROR: Insertar Transacciones Reversadas'
          return @v_return 
        end
		 
       insert into db_general..reca_tmp_concilia_banred (
               tc_tipo_transaccion,     tc_secuencial,          tc_tsfecha,
               tc_hora_tran,            tc_empresa,             tc_referencia,
               tc_sec_bred,             tc_usuario,             tc_terminal,
               tc_correccion,           tc_ssn_corr,            tc_tipocta,
               tc_cta_banco,            tc_oficina,             tc_moneda,
               tc_tipo_registro,        tc_ori_registro,        tc_servicio,
               tc_tipo_proceso,         tc_tipo_disp,
               tc_subtipo_trans,        
               tc_tipo_pago,
               tc_ciudad_of,
               tc_tipocta_bred,
               tc_cod_autoriza,
               tc_tipocta_dest,
               tc_cta_banco_dest,
               tc_valor_total,
               tc_valor_servicio,
               tc_comision,
               tc_unidad_negocio
               )
          select           
               ts_tipo_transaccion,     isnull(ts_secuencial,0),                    ts_tsfecha,
               ts_hora,                 convert(int,isnull(ts_causa,'0')),      ts_referencia,
               isnull(ts_secuencial,0),     ts_usuario,             left(ts_terminal,8),
               ts_correccion,           x.ts_ssn_corr,            isnull(ts_tipocta, 'E'),
               replicate('0',16),       ts_oficina,             ts_moneda,
               @v_ind_det,              @v_ori_reg,             @v_servicio,
               @v_tipo_proc,
	       case ts_tipo_chequera when 'DBA' then '149' 
	                             when 'VEN' then '149'
	                             when 'IBK' then '129'
                                     else '149' end,
               tc_subtipo_trans = '44109M',
               tc_tipo_pago     = '00',
               tc_ciudad_of     = (select ci_descripcion from cobis..cl_oficina, cobis..cl_ciudad where of_ciudad = ci_ciudad  and of_oficina = x.ts_oficina),
               tc_tipocta_bred  = '00',
               tc_cod_autoriza  = convert(varchar(10),ts_secuencial),
               tc_tipo_cta_dest = '00',
               tc_num_cta_dest  = replicate('0',16),
               tc_valor_total    = convert(bigint,((isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0))*100)),
               tc_valor_servicio = convert(bigint,((isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0))*100)),
               tc_comision = convert(bigint,(convert(money, isnull(ts_autoriz_aut,'0')) *100)),
               tc_unidad_negocio=isnull(em_codigo,'0')
           from cob_cuentas..cc_tran_servicio x
           inner join #reca_tmp_empresas_banred y on x.ts_causa = convert(varchar,y.em_empresa)
		   inner join #reca_tmp_trx_serv_banred on convert(varchar, x.ts_tipo_transaccion) = ts_codigo
		   left join #reca_tmp_trx_reversadas_banred z on x.ts_secuencial = z.ts_ssn_corr
            where ts_tsfecha = @e_fecha_corte
            and ts_correccion = 'N'
            and z.ts_ssn_corr is null
			
	
	if @@error <> 0 
	begin
	  set @v_return = 33333
	  print 'ERROR: Insertar Transacciones Empresa'
	  return @v_return 
	end      

	if object_id('tempdb.dbo.#reca_tmp_trx_reversadas_banred') is not null
		drop table #reca_tmp_trx_reversadas_banred
     
  end  
  else --if @e_reproceso = 'N' -- Se leen las estructuras históricas
    begin
       -- Control tablas temporales       
       if object_id('tempdb.dbo.#reca_tmp_trx_hreversadas_cnel') is not null
         drop table #reca_tmp_trx_hreversadas_cnel
       -------------- Transacciones Reversadas --------------
       select hs_ssn_corr
         into #reca_tmp_trx_hreversadas_cnel
         from cob_cuentas_his..cc_his_servicio x
		 inner join #reca_tmp_empresas_banred e on (e.em_empresa = convert(int, x.hs_causa))
		 inner join #reca_tmp_trx_serv_banred s on (s.ts_codigo = convert(varchar, x.hs_tipo_transaccion))
        where hs_tsfecha = @e_fecha_corte
          and hs_correccion = 'S'

       if @@error <> 0 
        begin
          set @v_return = 33333
          print 'ERROR: Insertar Transacciones Reversadas'
          return @v_return 
        end
       
       insert into db_general..reca_tmp_concilia_banred (
               tc_tipo_transaccion,     tc_secuencial,          tc_tsfecha,
               tc_hora_tran,            tc_empresa,             tc_referencia,
               tc_sec_bred,             tc_usuario,             tc_terminal,
               tc_correccion,           tc_ssn_corr,            tc_tipocta,
               tc_cta_banco,            tc_oficina,             tc_moneda,
               tc_tipo_registro,        tc_ori_registro,        tc_servicio,
               tc_tipo_proceso,         tc_tipo_disp,
               tc_subtipo_trans,        
               tc_tipo_pago,
               tc_ciudad_of,
               tc_tipocta_bred,
               tc_cod_autoriza,
               tc_tipocta_dest,
               tc_cta_banco_dest,
               tc_valor_total,
               tc_valor_servicio,
               tc_comision,
               tc_unidad_negocio
               )
          select 
               hs_tipo_transaccion,     isnull(hs_cheque,0),          hs_tsfecha,
               hs_hora,                 convert(int,isnull(hs_causa,'0')),      hs_referencia,
               isnull(hs_cheque,0),     hs_usuario,             left(hs_terminal,8),
               hs_correccion,           x.hs_ssn_corr,            isnull(hs_tipocta, 'E'),
               replicate('0',16),       hs_oficina,             hs_moneda,
               @v_ind_det,              @v_ori_reg,             @v_servicio,
               @v_tipo_proc,
	       case hs_tipo_chequera when 'DBA' then '149' 
	                             when 'VEN' then '149'
	                             when 'IBK' then '129'
                                     else '149' end,
               tc_subtipo_trans = '44109M',
               tc_tipo_pago     = '00',
               tc_ciudad_of     = (select ci_descripcion from cobis..cl_oficina, cobis..cl_ciudad where of_ciudad = ci_ciudad  and of_oficina = x.hs_oficina),
               tc_tipocta_bred  = '00',
               tc_cod_autoriza  = convert(varchar(10),hs_cheque),
               tc_tipo_cta_dest = '00',
               tc_num_cta_dest  = replicate('0',16),
               tc_valor_total    = convert(bigint,((isnull(hs_saldo,0) + isnull(hs_monto,0) + isnull(hs_valor,0))*100)),
               tc_valor_servicio = convert(bigint,((isnull(hs_saldo,0) + isnull(hs_monto,0) + isnull(hs_valor,0))*100)),
               tc_comision = convert(bigint,(convert(money, isnull(hs_autoriz_aut,'0')) *100)),
               tc_unidad_negocio=isnull(em_codigo,'0')
           from cob_cuentas_his..cc_his_servicio x
           inner join #reca_tmp_empresas_banred y on x.hs_causa = convert(varchar,y.em_empresa)
		   inner join #reca_tmp_trx_serv_banred on convert(varchar, x.hs_tipo_transaccion) = ts_codigo
		   left join #reca_tmp_trx_hreversadas_cnel z on x.hs_secuencial = z.hs_ssn_corr
          where hs_tsfecha = @e_fecha_corte
            and hs_correccion = 'N'
            and hs_tipo_chequera <> 'CNB'
			 and z.hs_ssn_corr is null

      	if @@error <> 0 
        begin
      		set @v_return = 33333
      		print 'ERROR: Insertar Transacciones Empresa'
      		return @v_return 
        end            
    end
	
  -- Se borran las estructuras temporales
  if object_id('tempdb.dbo.#reca_tmp_empresas_banred') is not null
    drop table #reca_tmp_empresas_banred 
	
  if object_id('tempdb.dbo.#reca_tmp_trx_hreversadas_cnel') is not null
    drop table #reca_tmp_trx_hreversadas_cnel

  if object_id('tempdb.dbo.#reca_tmp_trx_serv_banred') is not null
    drop table #reca_tmp_trx_serv_banred
	
	
  --Total de Registros Archivos
  select @v_tot_reg = count(1) 
    from db_general..reca_tmp_concilia_banred
  -- 
  set @s_total_registros = replicate (@v_relleno_num, 10 - len(convert(varchar, @v_tot_reg))) + convert(varchar(10), @v_tot_reg)
  --Longitud del Archivo, se consideran 400 caracteres por c/detalle
  set @v_tot_reg = (@v_tot_reg * 400) + 56 -- 400 caracteres x detalle + caracteres cabecera
  set @s_long_archivo = replicate (@v_relleno_num, 10 - len(convert(varchar, @v_tot_reg))) + convert(varchar, @v_tot_reg)
  --Total Recaudado
  select @v_tot_recauda = sum(tc_valor_total) 
    from db_general..reca_tmp_concilia_banred
  --
  set @s_total_recaudado = convert(varchar,cast(@v_tot_recauda as int))
  set @s_total_recaudado = replicate (@v_relleno_num, 20 - len(@s_total_recaudado )) + @s_total_recaudado
  -- Nombre archivo
  set @s_nombre_archivo = rtrim(ltrim(@v_nom_arch)) + substring(str_replace(convert(char(10),@e_fecha_corte,102),'.',null),3,6) + '.' + rtrim(ltrim(@v_ext_arch))
  -- Tipo Registro cabecera
  set @s_treg_cabecera = @v_ind_cab
  -- Tipo de servicio
  set @s_tipo_servicio = @v_servicio

return 0

go
if exists(select 1 from sysobjects where name='pa_pg_bconcilia_reca_banred' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_bconcilia_reca_banred *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_bconcilia_reca_banred -- ERROR -- >>>'
go
