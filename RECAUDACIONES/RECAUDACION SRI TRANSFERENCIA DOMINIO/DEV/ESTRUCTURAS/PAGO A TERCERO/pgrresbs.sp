use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_proc_rep_mensual_sbs' and type = 'P')
begin
   drop procedure dbo.sp_proc_rep_mensual_sbs
   if exists (select 1 from sysobjects where name = 'sp_proc_rep_mensual_sbs' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_proc_rep_mensual_sbs -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_proc_rep_mensual_sbs *OK* =='
end
go

/************************************************************************/
/*  Archivo:            pgrresbs.sp                                     */
/*  Stored procedure:   sp_proc_rep_mensual_sbs                         */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Miriam Lindao Rodríguez                         */
/*  Fecha de escritura: 12-Oct-2015                                     */
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
/*  Este programa carga en tablas temporales las Transacciones y Causas */
/*  que se reportarán para los Tipos de archivos a la  SBS              */
/*  También carga las transacciones monetarias y de servicios de acuerdo*/
/*  al tipo de Proceso, cuando es normal (reproceso 'N') lee las tablas */
/*  cc_tran_servicio y cc_tran_monet, caso contrario lee las históricas */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*    FECHA       AUTOR          RAZON                                  */
/* 01 08/Oct/2015 Miriam Lindao  CTE-AS-SGC00022677 Emisión inicial     */
/* 02 26/Ene/2016 Miriam Lindao  RECA-CC-SGC00023966 Cambios Regulación */
/* 03 04/MAY/2016 Paul Hoyos V.  Tarea:CB-AP-SGC00018374-SGC00018869    */
/* 04 12/Dic/2021 Dario Espinosa RECMPS-1393 AJUSTE EN ESTRUCTURAS PAGO DE PLANILLAS BB */
/************************************************************************/

create proc dbo.sp_proc_rep_mensual_sbs(
        @i_fecha  datetime,
        @reproceso char(1) = 'N'
)
as
declare @w_return      int,
        @w_coderror    int,
        @w_total_reg   int,
	@v_monto_max   money, --ref04
        @v_val_activa  char(1) --ref04

set  @w_return = 0

if exists (select 1
             from cob_cuentas..cc_debito_cnt
            where cc_fecha_debito = @i_fecha 
              and cc_estado = 'P')
begin
  delete cob_cuentas..cc_inf_super
   where is_FechTransaccion = convert(char(10),@i_fecha,103)
     and is_nem_servicio = 'CTA'
end
else
  delete cob_cuentas..cc_inf_super
   where is_FechTransaccion = convert(char(10),@i_fecha,103)
     and is_nem_servicio = 'CTA'
     and is_usuario != 'cnt' --Las transacciones cnt no se deben borrar a no ser que exista la carga activa
     
   if @@error != 0 
     begin
       print 'ERROR AL ELIMINAR INFORMACION DEL DIA PARA EL REPROCESO'
       set @w_return = 1
       return @w_return
     end

-- Se registra el nombre de los archivos con los nombres de catalogos asociados
if exists(select 1 from db_temporal..sysobjects where name='cc_tarchivos_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_tarchivos_pagos_terc
    
 
 -->Ref02 MLR: se cambia query principal para recuperar la cta contable de otro catálogo nuevo
 /* select cod_archivo = c.valor, 
       catalogo_trx1 = 'SBS_' + c.valor + '_TRX',
       catalogo_causa1 = 'SBS_' +  c.valor + '_CAUSA'
  into db_temporal..cc_tarchivos_pagos_terc
  from cobis..cl_tabla t, cobis..cl_catalogo c
 where t.codigo = c.tabla
   and t.tabla = 'pg_tiparch_pagter_sbs'
   and c.estado = 'V'*/
  
  select id_archivo = c.codigo,
         cod_archivo = c.valor, 
         catalogo_trx1 = 'SBS_PTERC_' + rtrim(c.codigo) + '_TRX',
         catalogo_causa1 = 'SBS_PTERC_' +  rtrim(c.codigo) + '_CAUSA',
         catalogo_concep = 'SBS_PTERC_CONCEPTO_'+  rtrim(c.codigo),
         catalogo_comision = 'SBS_PTERC_' +  rtrim(c.codigo) + '_COMISION',
         ctas.cta_contable,concepto_reca = conceptos.concepto
    into db_temporal..cc_tarchivos_pagos_terc
    from cobis..cl_tabla t, cobis..cl_catalogo c,
         (select cod_archivo = c.codigo, cta_contable = c.valor
            from cobis..cl_tabla t, cobis..cl_catalogo c
           where t.codigo = c.tabla
             and t.tabla = 'SBS_PTERC_CTAS_CONTABLES' ) ctas,
         (select cod_archivo = c.codigo, concepto = c.valor
            from cobis..cl_tabla t, cobis..cl_catalogo c
           where t.codigo = c.tabla
             and t.tabla = 'SBS_PTERC_CONCEPTOS' ) conceptos
   where t.codigo = c.tabla
     and t.tabla = 'SBS_PTERC_TIPOS_ARCHIVOS'
     and c.estado = 'V'
     and c.codigo = ctas.cod_archivo
     and c.codigo = conceptos.cod_archivo
     and c.codigo IN ('ID10')
--<--Fin Ref02

  set @w_coderror = @@error, @w_total_reg = @@rowcount
  
  if @w_coderror != 0 or @w_total_reg = 0
     begin
       print 'ERROR AL REGISTRAR INFORMACION DE TIPOS DE ARCHIVOS, VERIFIQUE LA CONFIGURACION DEL CATALOGO  SBS_PTERC_TIPOS_ARCHIVOS' --Ref02: se cambia nombre de catálogo
       set @w_return = 1
       return @w_return
     end
     
--Inicio ref04
	select @v_val_activa  = cl.valor 
	from cobis..cl_catalogo cl
	inner join cobis..cl_tabla ct  on cl.tabla = ct.codigo
	where cl.codigo = 'ACTVALID' 
	and cl.estado = 'V'
	and ct.tabla = 'sv_val_srvpub_param'	

	select @v_monto_max  = convert(money,cl.valor)
	from cobis..cl_catalogo cl
	inner join cobis..cl_tabla ct  on cl.tabla = ct.codigo
	where cl.codigo = 'MONTOMAX' 
	and cl.estado = 'V'
	and ct.tabla = 'sv_val_srvpub_param'
	
	-- Se pobla una estructura temporal con las causas de monto_max
	if object_id('tempdb.dbo.#cl_sv_val_srvpub_causa') is not null
            drop table #cl_sv_val_srvpub_causa
			
	select cl.codigo 
	into #cl_sv_val_srvpub_causa
	from cobis..cl_catalogo cl
	inner join cobis..cl_tabla ct  on cl.tabla = ct.codigo
	where ct.tabla = 'sv_val_srvpub_causa'
	and cl.estado = 'V'
		
	-- Se pobla una estructura temporal con las causas/planillas
	if object_id('tempdb.dbo.#cl_sv_val_srvpub_banco') is not null
            drop table #cl_sv_val_srvpub_banco
				
	select cl.codigo, cl.valor
	into #cl_sv_val_srvpub_banco
	from cobis..cl_catalogo cl
	inner join cobis..cl_tabla ct on cl.tabla = ct.codigo
	where ct.tabla = 'sv_val_srvpub_banco'
	and cl.estado = 'V'
--Fin ref04


-- Se registra en la tabla temporal cc_trans_pagos_terc toda la información de los Tipos de Transacciones configuradas en los distintos catalogos para cada archivo
if exists(select 1 from db_temporal..sysobjects where name='cc_trans_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_trans_pagos_terc

select tp_tipo_trx = convert(int, c.codigo),  
       tp_descripcion= c.valor,
       tp_cod_archivo = c1.cod_archivo,
       tp_nom_cat = t.tabla
  into db_temporal..cc_trans_pagos_terc
  from cobis..cl_tabla t, cobis..cl_catalogo c, db_temporal..cc_tarchivos_pagos_terc c1
 where t.codigo = c.tabla
   and (t.tabla = c1.catalogo_trx1 or 
        t.tabla = (c1.catalogo_trx1 + '_2') or 
        t.tabla = (c1.catalogo_trx1 + '_3') or
        t.tabla = (c1.catalogo_trx1 + '_4'))
   and c.estado = 'V'

  set @w_coderror = @@error, @w_total_reg = @@rowcount
  
  if @w_coderror != 0 or @w_total_reg = 0
     begin
       print 'ERROR AL REGISTRAR INFORMACION DE TIPOS DE TRANSACCIONES, VERIFIQUE LA CONFIGURACION DE LOS CATALOGOS'
       set @w_return = 1
       return @w_return
     end
-- Se registra en la tabla temporal cc_causas_pagos_terc toda la información de los Tipos de Causas configuradas en los distintos catalogos para cada archivo
if exists(select 1 from db_temporal..sysobjects where name='cc_causas_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_causas_pagos_terc

select cp_causa= c.codigo,--ref02 MLR c.valor,
       cp_cod_archivo = c1.cod_archivo,
       cp_nom_cat = t.tabla
  into db_temporal..cc_causas_pagos_terc
  from cobis..cl_tabla t, cobis..cl_catalogo c, db_temporal..cc_tarchivos_pagos_terc c1
 where t.codigo = c.tabla
   and (t.tabla = c1.catalogo_causa1 or 
        t.tabla = (c1.catalogo_causa1 + '_2') or 
        t.tabla = (c1.catalogo_causa1 + '_3') or
        t.tabla = (c1.catalogo_causa1 + '_4'))
   and c.estado = 'V'
   --
  set @w_coderror = @@error, @w_total_reg = @@rowcount
  
  if @w_coderror != 0 or @w_total_reg = 0
     begin
       print 'ERROR AL REGISTRAR INFORMACION DE TIPOS DE LAS CAUSAS, VERIFIQUE LA CONFIGURACION DE LOS CATALOGOS'
       set @w_return = 1
       return @w_return
     end

-- Se pobla una estructura temporal con las transacciones reversadas
if object_id('tempdb.dbo.#cc_tran_serv_rev') is not null
    drop table #cc_tran_serv_rev
    
select ts_ssn_corr, ts_tipo_transaccion
  into #cc_tran_serv_rev
  from cob_cuentas..cc_tran_servicio
 where @reproceso = 'N'
   and ts_correccion = 'S'
and ts_secuencial in (135779001,135779049,135779097,135779111,135779150,135779223,135779254,135779304,135779550,135779747)
   and ts_ssn_corr is not null 
 union all
select hs_ssn_corr, hs_tipo_transaccion
  from cob_cuentas_his..cc_his_servicio
 where @reproceso = 'S'
   and hs_correccion = 'S'
   and hs_tsfecha = @i_fecha
   and hs_ssn_corr is not null
-- Se llena la temporal db_temporal..cc_tran_servicio_tmp con las transacciones de servicios que se van a procesar
if exists(select 1 from db_temporal..sysobjects where name='cc_tran_servicio_tmp' and type = 'U')
    drop table  db_temporal..cc_tran_servicio_tmp


  select ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
         ts_oficina,ts_tipo,ts_moneda,ts_causa = isnull(ts_causa,'0'),ts_saldo,ts_fecha_uso,
	--ref04 Inicio
         ts_monto = case when @v_val_activa = 'S' 
	 and ts_valor > @v_monto_max
	 and exists (select 1 from #cl_sv_val_srvpub_causa cl
	                where cl.codigo = isnull(ts.ts_causa,'0'))
	 and exists(select 1 from #cl_sv_val_srvpub_banco cl
	   	    where substring (cl.codigo, 1, charindex('-',cl.codigo) - 1) = isnull(ts.ts_causa,'0')
	   	    and str_replace(substring(cl.valor, patindex('%[^0]%', cl.valor), len(cl.valor)),'',null)
         	    in(str_replace(substring(ts.ts_referencia, patindex('%[^0]%', ts.ts_referencia), len(ts.ts_referencia)),'',null),
	               str_replace(substring(ts.ts_campo_alt_uno, patindex('%[^0]%', ts.ts_campo_alt_uno), len(ts.ts_campo_alt_uno)),'',null),
	               str_replace(substring(ts.ts_campo_alt_dos, patindex('%[^0]%', ts.ts_campo_alt_dos), len(ts.ts_campo_alt_dos)),'',null),
	               str_replace(substring(ts.ts_descripcion_ec, patindex('%[^0]%', ts.ts_descripcion_ec),len(ts.ts_descripcion_ec)),'',null))) then ts_valor else ts_monto end,
	 ts_autoriz_aut,ts_contratado,
	 ts_valor = case when @v_val_activa = 'S' 
	                 and ts_valor > @v_monto_max
			 and exists (select 1 from #cl_sv_val_srvpub_causa cl
	                where cl.codigo = isnull(ts.ts_causa,'0'))
		         and exists(select 1 from #cl_sv_val_srvpub_banco cl
	   	    where substring (cl.codigo, 1, charindex('-',cl.codigo) - 1) = isnull(ts.ts_causa,'0')
	   	    and str_replace(substring(cl.valor, patindex('%[^0]%', cl.valor), len(cl.valor)),'',null)
         	    in(str_replace(substring(ts.ts_referencia, patindex('%[^0]%', ts.ts_referencia), len(ts.ts_referencia)),'',null),
	               str_replace(substring(ts.ts_campo_alt_uno, patindex('%[^0]%', ts.ts_campo_alt_uno), len(ts.ts_campo_alt_uno)),'',null),
	               str_replace(substring(ts.ts_campo_alt_dos, patindex('%[^0]%', ts.ts_campo_alt_dos), len(ts.ts_campo_alt_dos)),'',null),
	               str_replace(substring(ts.ts_descripcion_ec, patindex('%[^0]%', ts.ts_descripcion_ec),len(ts.ts_descripcion_ec)),'',null))) then 0 else ts_valor end,
	 --ref04 Fin
	 ts_ocasional,ts_tipo_chequera,ts_aporte_iess,ts_descuento_iess,ts_fonres_iess
    into db_temporal..cc_tran_servicio_tmp
    from cob_cuentas..cc_tran_servicio ts
   where @reproceso = 'N' 
   and ts_secuencial in (135779001,135779049,135779097,135779111,135779150,135779223,135779254,135779304,135779550,135779747)
   
     and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.ts_tipo_transaccion)
     and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.ts_causa,'0'))
     and ts_correccion = 'N'
     and not exists (select 1 
                       from #cc_tran_serv_rev tc
                      where tc.ts_ssn_corr = ts.ts_secuencial
                        and tc.ts_tipo_transaccion = ts.ts_tipo_transaccion)
 union all
    select ts_secuencial = hs_secuencial,ts_tipo_transaccion = hs_tipo_transaccion,ts_tsfecha = hs_tsfecha,ts_usuario = hs_usuario,
           ts_oficina = hs_oficina,ts_tipo = hs_tipo,ts_moneda = hs_moneda,ts_causa = isnull(ts.hs_causa,'0'),ts_saldo = hs_saldo,ts_fecha_uso = hs_fecha_uso,
           --ref04 Inicio
	   ts_monto = case when @v_val_activa = 'S' 
		           and hs_valor > @v_monto_max
		           and exists (select 1 from #cl_sv_val_srvpub_causa cl
	            	               where cl.codigo = isnull(ts.hs_causa,'0'))
		            and exists(select 1 from #cl_sv_val_srvpub_banco cl
		   	               where substring (cl.codigo, 1, charindex('-',cl.codigo) - 1) = isnull(ts.hs_causa,'0')
		   	               and str_replace(substring(cl.valor, patindex('%[^0]%', cl.valor), len(cl.valor)),'',null)
	         	               in(str_replace(substring(ts.hs_referencia, patindex('%[^0]%', ts.hs_referencia), len(ts.hs_referencia)),'',null),
		                          str_replace(substring(ts.hs_campo_alt_uno, patindex('%[^0]%', ts.hs_campo_alt_uno), len(ts.hs_campo_alt_uno)),'',null),
		                          str_replace(substring(ts.hs_campo_alt_dos, patindex('%[^0]%', ts.hs_campo_alt_dos), len(ts.hs_campo_alt_dos)),'',null),
		                          str_replace(substring(ts.hs_descripcion_ec, patindex('%[^0]%', ts.hs_descripcion_ec),len(ts.hs_descripcion_ec)),'',null))) then hs_valor else hs_monto end,
	   ts_autoriz_aut = hs_autoriz_aut,ts_contratado = hs_contratado,
	   ts_valor = case when @v_val_activa = 'S' 
		           and hs_valor > @v_monto_max
		           and exists (select 1 from #cl_sv_val_srvpub_causa cl
	            	               where cl.codigo = isnull(ts.hs_causa,'0'))
		            and exists(select 1 from #cl_sv_val_srvpub_banco cl
		   	               where substring (cl.codigo, 1, charindex('-',cl.codigo) - 1) = isnull(ts.hs_causa,'0')
		   	               and str_replace(substring(cl.valor, patindex('%[^0]%', cl.valor), len(cl.valor)),'',null)
	         	               in(str_replace(substring(ts.hs_referencia, patindex('%[^0]%', ts.hs_referencia), len(ts.hs_referencia)),'',null),
		                          str_replace(substring(ts.hs_campo_alt_uno, patindex('%[^0]%', ts.hs_campo_alt_uno), len(ts.hs_campo_alt_uno)),'',null),
		                          str_replace(substring(ts.hs_campo_alt_dos, patindex('%[^0]%', ts.hs_campo_alt_dos), len(ts.hs_campo_alt_dos)),'',null),
		                          str_replace(substring(ts.hs_descripcion_ec, patindex('%[^0]%', ts.hs_descripcion_ec),len(ts.hs_descripcion_ec)),'',null))) then 0 else hs_valor end,
	   ts_ocasional = hs_ocasional,
	   --ref04 Fin
           ts_tipo_chequera = hs_tipo_chequera,ts_aporte_iess = hs_aporte_iess,ts_descuento_iess = hs_descuento_iess,ts_fonres_iess = hs_fonres_iess
       from cob_cuentas_his..cc_his_servicio ts
      where @reproceso = 'S'
        and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.hs_tipo_transaccion)
        and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.hs_causa,'0'))
        and hs_tsfecha = @i_fecha
        and hs_correccion = 'N'
        and not exists (select 1 
                       from #cc_tran_serv_rev tc
                      where tc.ts_ssn_corr = ts.hs_secuencial
                        and tc.ts_tipo_transaccion = ts.hs_tipo_transaccion)
		



if @@error != 0 
   begin
     print 'ERROR AL INSERTAR TRANSACCIONES DE SERVICIOS. REPROCESO %1!',@reproceso 
     set @w_return = 1
     return @w_return
   end
   
-- Se pobla una estructura temporal con las transacciones reversadas
if object_id('tempdb.dbo.#ah_tran_monet_rev') is not null
    drop table #ah_tran_monet_rev

select tm_sec_correccion
  into #ah_tran_monet_rev
  from cob_ahorros..ah_tran_monet
 where @reproceso        = 'N'
   and tm_correccion     = 'S'
   and tm_fecha          = @i_fecha
   and tm_sec_correccion is not null 
union all
select tm_sec_correccion = hm_sec_correccion
  from cob_ahorros_his..ah_his_movimiento
 where @reproceso        = 'S'
   and hm_correccion     = 'S'
   and hm_fecha          = @i_fecha
   and hm_sec_correccion is not null
union all                               --REF03 INI PHOYOSV 20160504
select tm_sec_correccion
  from cob_virtuales..vi_tran_monet
 where @reproceso        = 'N'
   and tm_correccion     = 'S'
   and tm_fecha          = @i_fecha
   and tm_sec_correccion is not null
union all
select tm_sec_correccion = hm_sec_correccion
  from cob_virtuales_his..vi_his_movimiento
 where @reproceso        = 'S'
   and hm_correccion     = 'S'
   and hm_fecha          = @i_fecha
   and hm_sec_correccion is not null    --REF03 FIN PHOYOSV 20160504

-- Se llena la temporal db_temporal..ah_tran_monet_tmp con las transacciones de servicios que se van a procesar
if exists(select 1 from db_temporal..sysobjects where name='ah_tran_monet_tmp' and type = 'U')
    drop table  db_temporal..ah_tran_monet_tmp

select tm_secuencial,tm_tipo_transaccion = tm_tipo_tran,tm_fecha,tm_usuario,
       tm_oficina,tm_moneda,tm_causa = isnull(ts.tm_causa,'0'),
       tm_valor
  into db_temporal..ah_tran_monet_tmp
  from cob_ahorros..ah_tran_monet ts
 where @reproceso = 'N'
   and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.tm_tipo_tran)
   and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.tm_causa,'0'))
   and tm_correccion = 'N'
   and not exists (select 1 
                          from  #ah_tran_monet_rev tc
                         where tc.tm_sec_correccion = ts.tm_secuencial)
union all
select tm_secuencial = hm_secuencial,tm_tipo_transaccion = hm_tipo_tran,tm_fecha = hm_fecha,tm_usuario = hm_usuario,
       tm_oficina = hm_oficina,tm_moneda = hm_moneda,tm_causa = isnull(ts.hm_causa,'0'),
       tm_valor = hm_valor
   from cob_ahorros_his..ah_his_movimiento ts
  where @reproceso = 'S'
    and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.hm_tipo_tran)
    and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.hm_causa,'0'))
    and hm_fecha = @i_fecha
    and hm_correccion = 'N'
    and not exists (select 1 
                          from  #ah_tran_monet_rev  tc
                         where tc.tm_sec_correccion = ts.hm_secuencial)
union all                               --REF03 INI PHOYOSV 20160504
select tm_secuencial,tm_tipo_transaccion = tm_tipo_tran,tm_fecha,tm_usuario,
       tm_oficina,tm_moneda,tm_causa = isnull(ts.tm_causa,'0'),tm_valor
  from cob_virtuales..vi_tran_monet ts
 where @reproceso = 'N'
   and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.tm_tipo_tran)
   and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.tm_causa,'0'))
   and tm_correccion = 'N'
   and not exists ( select 1 from #ah_tran_monet_rev tc
                    where tc.tm_sec_correccion = ts.tm_secuencial )
union all
select tm_secuencial = hm_secuencial,tm_tipo_transaccion = hm_tipo_tran,tm_fecha = hm_fecha,tm_usuario = hm_usuario,
       tm_oficina = hm_oficina,tm_moneda = hm_moneda,tm_causa = isnull(ts.hm_causa,'0'),
       tm_valor = hm_valor
   from cob_virtuales_his..vi_his_movimiento ts
  where @reproceso = 'S'
    and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.hm_tipo_tran)
    and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.hm_causa,'0'))
    and hm_fecha = @i_fecha
    and hm_correccion = 'N'
    and not exists ( select 1 from #ah_tran_monet_rev  tc
                     where tc.tm_sec_correccion = ts.hm_secuencial )
                                        --REF03 FIN PHOYOSV 20160504
if @@error != 0 
begin
   print 'ERROR AL INSERTAR TRANSACCIONES MONETARIAS (AHORROS). REPROCESO %1!',@reproceso 
   set @w_return = 1
   return @w_return
end

if object_id('tempdb.dbo.#ah_tran_monet_rev') is not null
   drop table #ah_tran_monet_rev


-- Se pobla una estructura temporal con las transacciones reversadas
if object_id('tempdb.dbo.#cc_tran_monet_rev') is not null
    drop table #cc_tran_monet_rev
select tm_sec_correccion
  into #cc_tran_monet_rev
  from cob_cuentas..cc_tran_monet
 where @reproceso = 'N'
   and tm_correccion = 'S'
   and tm_sec_correccion is not null 
 union all
select tm_sec_correccion = hm_sec_correccion
  from cob_cuentas_his..cc_his_movimiento
 where @reproceso = 'S'
   and hm_correccion = 'S'
   and hm_fecha = @i_fecha
   and hm_sec_correccion is not null
   
   
-- Se llena la temporal db_temporal..cc_tran_monet_tmp con las transacciones de servicios que se van a procesar
if exists(select 1 from db_temporal..sysobjects where name='cc_tran_monet_tmp' and type = 'U')
   drop table  db_temporal..cc_tran_monet_tmp

    select tm_secuencial,tm_tipo_transaccion = tm_tipo_tran,tm_fecha,tm_usuario,
           tm_oficina,tm_moneda,tm_causa = isnull(ts.tm_causa,'0'),
           tm_valor
       into db_temporal..cc_tran_monet_tmp
       from cob_cuentas..cc_tran_monet ts
      where @reproceso = 'N'
        and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.tm_tipo_tran)
        and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.tm_causa,'0'))
        and tm_correccion = 'N'
        and not exists (select 1 
                          from #cc_tran_monet_rev tc
                         where tc.tm_sec_correccion = ts.tm_secuencial)
   union all
    select tm_secuencial = hm_secuencial,tm_tipo_transaccion = hm_tipo_tran,tm_fecha = hm_fecha,tm_usuario = hm_usuario,
           tm_oficina = hm_oficina,tm_moneda = hm_moneda,tm_causa = isnull(ts.hm_causa,'0'),
           tm_valor = hm_valor
      from cob_cuentas_his..cc_his_movimiento ts
     where @reproceso = 'S'
       and exists( select 1 from db_temporal..cc_trans_pagos_terc where tp_tipo_trx = ts.hm_tipo_tran)
       and exists( select 1 from db_temporal..cc_causas_pagos_terc where cp_causa = isnull(ts.hm_causa,'0'))
       and hm_fecha = @i_fecha
       and hm_correccion = 'N'
       and not exists (select 1 
                          from #cc_tran_monet_rev tc
                         where tc.tm_sec_correccion = ts.hm_secuencial)
    if @@error != 0 
       begin
         print 'ERROR AL INSERTAR TRANSACCIONES MONETARIAS (CUENTAS). REPROCESO %1!',@reproceso 
         set @w_return = 1
         return @w_return
       end
if object_id('tempdb.dbo.#cc_tran_monet_rev') is not null
    drop table #cc_tran_monet_rev

--ref04 Inicio     
if object_id('tempdb.dbo.#cl_sv_val_srvpub_causa') is not null
    drop table #cl_sv_val_srvpub_causa

if object_id('tempdb.dbo.#cl_sv_val_srvpub_banco') is not null
    drop table #cl_sv_val_srvpub_banco
--ref04 Fin 

create nonclustered index cc_tran_servicio_tmp_key1 on db_temporal..cc_tran_servicio_tmp (ts_tipo_transaccion)
create nonclustered index cc_tran_servicio_tmp_key2 on db_temporal..cc_tran_servicio_tmp (ts_causa)
update statistics db_temporal..cc_tran_servicio_tmp
exec db_temporal..sp_recompile cc_tran_servicio_tmp

create nonclustered index cc_tran_monet_tmp_key1 on db_temporal..cc_tran_monet_tmp (tm_tipo_transaccion)
create nonclustered index c_tran_monet_tmp_key2 on db_temporal..cc_tran_monet_tmp (tm_causa)
update statistics db_temporal..cc_tran_monet_tmp
exec db_temporal..sp_recompile cc_tran_monet_tmp

create nonclustered index ah_tran_monet_tmp_key1 on db_temporal..ah_tran_monet_tmp (tm_tipo_transaccion)
create nonclustered index ah_tran_monet_tmp_key2 on db_temporal..ah_tran_monet_tmp (tm_causa)
update statistics db_temporal..ah_tran_monet_tmp
exec db_temporal..sp_recompile ah_tran_monet_tmp

-->Ref02 creación de tablas temporales
--se crea tabla para conceptos por ID cliente
if not exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_concepto' and type = 'U')
    create table db_temporal..cc_pag_ter_concepto(
        pt_id         varchar(15),
        pt_concepto   varchar(50) )

--se crea tabla para las comisiones por Causa
if not exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_comision' and type = 'U')
    create table db_temporal..cc_pag_ter_comision(
        pt_causa      varchar(10),
        pt_valor      varchar(64) )
--<--fin Ref02

-- Se invoca sp que procesa la información cargada en las tablas temporales
exec @w_return = cob_pagos..sp_reporte_mensual_sbs
                       @i_fecha = @i_fecha 

if exists(select 1 from db_temporal..sysobjects where name='cc_tran_monet_tmp' and type = 'U')
    drop table  db_temporal..cc_tran_monet_tmp 
if exists(select 1 from db_temporal..sysobjects where name='ah_tran_monet_tmp' and type = 'U')
    drop table  db_temporal..ah_tran_monet_tmp
if exists(select 1 from db_temporal..sysobjects where name='cc_tran_servicio_tmp' and type = 'U')
    drop table  db_temporal..cc_tran_servicio_tmp
    
if exists(select 1 from db_temporal..sysobjects where name='cc_tarchivos_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_tarchivos_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_trans_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_trans_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_causas_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_causas_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_concepto' and type = 'U') --Ref02 MLR se elimina la tabla temporal
    drop table  db_temporal..cc_pag_ter_concepto
if exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_comision' and type = 'U') --Ref02 MLR se elimina la tabla temporal
    drop table  db_temporal..cc_pag_ter_comision

print 'Proceso Generado Correctamente Fecha: %1!',@i_fecha
return @w_return
go

go
if exists(select 1 from sysobjects where name='sp_proc_rep_mensual_sbs' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_proc_rep_mensual_sbs *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_proc_rep_mensual_sbs -- ERROR -- >>>'
go
