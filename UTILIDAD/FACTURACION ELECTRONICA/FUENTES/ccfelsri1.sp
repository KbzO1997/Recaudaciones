/************************************************************************/
/*      Archivo           :ccfelsri1.sp                                 */
/*      Store Procedure   :                                             */
/*      Base de datos     :cob_ahorros                                  */
/*      Producto          :Cuentas                                      */
/*      Disenado por      :Jorge Pazminno Medina                        */
/*      Fecha de escritura:16/Abr/2014                                  */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "Banco Bolivariano".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Banco Bolivariano o su representante.      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*  Graba datos para facturacion electronica                            */
/*   - Recaudaciones de servicios                                       */
/*   - Porta                                                            */
/*   - Paykard                                                          */
/*   - Valores Suspenso CTE/AHO                                         */
/*                         MODIFICACION                                 */
/* REF FECHA      AUTOR         TAREA RATIONAL      DESCRIPCION         */
/* --  ---------- -------------- ------------------  -------------------*/
/*   1 16/Abr/2014 J.Pazminno M. CTE-CC-SGC00015082 Emision inicial     */
/*                                 - Tuning: transformar sqr a sp       */
/*                                 - Deflactar IVA Valores en Suspenso  */
/*   2 29/Sep/2016 María Jo. Silva RECA-CE-SGC00026649  Registrar facturas de retiro */
/************************************************************************/
use cob_cuentas
go

if exists(Select 1 from db_temporal..sysobjects where name = 'trax_servicio_sri_tmp' and type = 'U')
  drop table db_temporal..trax_servicio_sri_tmp
go

if exists(Select 1 from cob_cuentas..sysobjects where name = 'sp_facturacion_electronica_sri' and type = 'P')
  drop proc sp_facturacion_electronica_sri
go

create proc sp_facturacion_electronica_sri (
      @i_filial               int,
      @i_fecha_proceso        smalldatetime,
      @i_reproceso            char(1)
)
as
declare
    @w_return               int,
    -- cursor trax x procesar
    @w_id                   int,
    @w_sec                  int,
    @w_ssn                  int,
    -- variable de trabajo
    @w_ced_firmante       varchar(10),
    @w_resolucion         varchar(20),
    @w_ruc_firmante       varchar(30),
    @w_moneda             tinyint,
    @w_descri_mon         varchar(64),
    @w_cat1               smallint,
    @w_cat2               smallint,
    @w_cat3               smallint,
    @w_cat4               smallint,
    @w_cat5               smallint,
    @w_cat6               smallint --Ref002:msilvag 

  select @w_cat1 = codigo from cobis..cl_tabla where tabla = 'cc_causa_nd'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO ''cc_causa_nd'''
    return 1
  end
  select @w_cat2 = codigo from cobis..cl_tabla where tabla = 'cc_causa_oioe'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO ''cc_causa_oioe'''
    return 2
  end
  select @w_cat3 = codigo from cobis..cl_tabla where tabla = 're_servicio_comision'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO ''re_servicio_comision'''
    return 3
  end

  select @w_cat4 = codigo from cobis..cl_tabla where tabla = 'cl_transf_env'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO ''cl_transf_env'''
    return 4
  end

  select @w_cat5 = codigo from cobis..cl_tabla where tabla = 'ah_causa_nd'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO ''ah_causa_nd'''
    return 6
  end
  
  --Ref002:msilvag Inicio
  select @w_cat6 = codigo from cobis..cl_tabla where tabla = 'bas_causa_nd'
    if @@rowcount = 0
    begin
      print 'NO EXISTE CATALOGO ''bas_causa_nd'''
      return 6
  end
  --Ref002:msilvag Fin
  
  select @w_ced_firmante = substring(valor, 6, 10)
   from cobis..cl_tabla a ,cobis..cl_catalogo b
   where a.codigo= b.tabla
    and a.tabla= 'cc_cedulas_firmantes_bb'
    and b.codigo = 'CCTE'
  if @@rowcount = 0
  begin
    print 'NO EXISTE CATALOGO DE CEDULAS FIRMANTES, FAVOR VERIFICAR'
    return 5
  end
  
  select @w_resolucion = convert(varchar(20), pa_int)
   from cobis..cl_parametro
   where pa_producto = 'CTE'
    and  pa_nemonico = 'CESP'
  if @@rowcount = 0
  begin
    print 'PARAMETRO "CESP" NO EXISTE'
    return 6
  end
  
  select @w_ruc_firmante = pa_char
   from cobis..cl_parametro
   where pa_producto = 'CTE'
    and  pa_nemonico = 'RUCBB'
  if @@rowcount = 0
  begin
    print 'PARAMETRO "RUCBB" NO EXISTE'
    return 7
  end
  
  -- MONEDA DEL PROCESO
  select @w_moneda = pa_tinyint
  from cobis..cl_parametro
  where pa_producto = 'ADM'
    and pa_nemonico = 'MLO'
  if @@rowcount = 0
    set @w_moneda = 1  
  
  select @w_descri_mon = mo_descripcion
   from cobis..cl_moneda
   where mo_moneda = @w_moneda
  if @@rowcount = 0
  begin
    select @w_descri_mon = 'MONEDA ' + convert(varchar, @w_moneda) + '- NO EXISTE'
  end
  
  exec @w_return = cob_pagos..sp_actualiza_facturas
           @i_fecha         = @i_fecha_proceso,
           @i_reproceso     = @i_reproceso
  if @w_return <> 0
  begin
    print 'Error en ejecucion de cob_pagos..sp_actualiza_facturas (%1!)', @w_return
    return 8
  end
  
  exec @w_return = cob_cuentas..sp_actcomp_isd
           @i_filial        = @i_filial,
           @i_fecha_proceso = @i_fecha_proceso,
           @i_reproceso     = @i_reproceso
  if @w_return <> 0
  begin
    print 'Error en ejecucion de cob_cuentas..sp_actcomp_isd (%1!)', @w_return
    return 9
  end
  
  exec @w_return = cob_cuentas..sp_cheque_isd
           @i_filial           = @i_filial,
           @i_fecha_proceso    = @i_fecha_proceso,
           @i_reproceso        = @i_reproceso
  if @w_return <> 0
  begin
    print 'Error en ejecucion de cob_cuentas..sp_cheque_isd (%1!)', @w_return
    return 10
  end


  if exists(select 1 from db_temporal..sysobjects where name = 'trax_servicio_sri_tmp' and type = 'U')
    drop table db_temporal..trax_servicio_sri_tmp
  
  -- repositorio total de transacciones x cuenta
  create table db_temporal..trax_servicio_sri_tmp (
      ts_id                 int identity,
      ts_idfact             int,
      ts_org                tinyint,
      ts_codcat             smallint,
      ts_trx                int,
      ts_oficina            smallint        null,
      ts_causa              varchar(6)      null,
      ts_valor              money           null
  )
  
  select id    = identity(int),
         sec   = fr_secuencia,
         ssn   = fr_ssn
    into #factura
   from cob_cuentas..cc_factura_recaudacion
   where fr_fecha = @i_fecha_proceso
     and fr_estado = 'V'
     and fr_fact_elect = 'E'
  
  -- insertar en tabla fija todo el contenido de las his_servicio que hace matching con #factura
  -- corrientes (origen 3)
  insert into db_temporal..trax_servicio_sri_tmp
         (ts_idfact, ts_trx, ts_org, ts_codcat, ts_oficina, ts_causa, ts_valor)
  select id, ts_tipo_transaccion, 3,
         case ts_tipo_transaccion
                  when 3471 then @w_cat1
                  when 3188 then @w_cat1
                  when 3484 then @w_cat2
                  when 3497 then @w_cat3
                  when 3721 then @w_cat4
         end,
         ts_oficina, ts_causa, sum(isnull(ts_valor, 0))
   from #factura
        inner left join cob_cuentas..cc_factura_recaudacion
             on fr_fecha = @i_fecha_proceso
               and sec   = fr_secuencia
               and ssn   = fr_ssn
               and fr_estado = 'V'
               and fr_fact_elect = 'E'
        inner join cob_cuentas..cc_tran_servicio
             on ts_tsfecha = fr_fecha
               and ts_secuencial = fr_ssn
               and ts_tipo_transaccion in (3497, 3484, 3793, 3721, 3471)
   group by id, ts_tipo_transaccion,
            case ts_tipo_transaccion
                  when 3471 then @w_cat1
                  when 3188 then @w_cat1
                  when 3484 then @w_cat2
                  when 3497 then @w_cat3
                  when 3721 then @w_cat4
            end,
            ts_oficina, ts_causa
   order by id, ts_tipo_transaccion, ts_oficina, ts_causa
  if @@error <> 0
  begin
    print 'ERROR EN INSERT (1) db_temporal..trax_servicio_sri_tmp'
    return 11
  end
  dump transaction db_temporal with truncate_only
  
    --Ref002:msilvag Inicio corriente retiros
    insert into db_temporal..trax_servicio_sri_tmp
         (ts_idfact, ts_trx, ts_org, ts_codcat, ts_oficina, ts_causa, ts_valor)
    select id, ts_tipo_transaccion, 3, @w_cat1, ts_oficina, ts_causa, sum(isnull(ts_valor, 0))
    from #factura
        inner left join cob_cuentas..cc_factura_recaudacion
             on fr_fecha = @i_fecha_proceso
               and sec   = fr_secuencia
               and ssn   = fr_ssn
               and fr_estado = 'V'
               and fr_fact_elect = 'E'
        inner join cob_cuentas..cc_tran_servicio
            on   ts_tsfecha    = fr_fecha
             and ts_secuencial = fr_ssn
             and ts_tipo_transaccion = 3188 and ts_usuario = 'cnb001'
    group by id, ts_tipo_transaccion, ts_oficina, ts_causa
    order by id, ts_tipo_transaccion, ts_oficina, ts_causa
    if @@error <> 0
    begin
        print 'ERROR EN INSERT (2) db_temporal..trax_servicio_sri_tmp' 
        return 11
    end
    dump transaction db_temporal with truncate_only
    --Ref002:msilvag Fin
    
  -- ahorros (origen 4)
  insert into db_temporal..trax_servicio_sri_tmp
         (ts_idfact, ts_trx, ts_org, ts_codcat, ts_oficina, ts_causa, ts_valor)
  select id, hs_tipo_transaccion, 4, @w_cat5, hs_oficina, hs_causa, sum(isnull(hs_valor, 0))
   from #factura
        inner left join cob_cuentas..cc_factura_recaudacion
             on fr_fecha = @i_fecha_proceso
               and sec   = fr_secuencia
               and ssn   = fr_ssn
               and fr_estado = 'V'
               and fr_fact_elect = 'E'
        inner join cob_ahorros_his..ah_his_servicio
            on   hs_tsfecha    = fr_fecha
             and hs_secuencial = fr_ssn
             and hs_tipo_transaccion = 4189
   group by id, hs_tipo_transaccion, hs_oficina, hs_causa
   order by id, hs_tipo_transaccion, hs_oficina, hs_causa
  if @@error <> 0
  begin
    print 'ERROR EN INSERT (3) db_temporal..trax_servicio_sri_tmp' --Ref002:msilvag 
    return 12
  end
  dump transaction db_temporal with truncate_only
  
    --Ref002:msilvag Inicio ahorros retiros
    insert into db_temporal..trax_servicio_sri_tmp
         (ts_idfact, ts_trx, ts_org, ts_codcat, ts_oficina, ts_causa, ts_valor)
    select id, hs_tipo_transaccion, 4, @w_cat5, hs_oficina, hs_causa, sum(isnull(hs_valor, 0))
    from #factura
        inner left join cob_cuentas..cc_factura_recaudacion
             on fr_fecha = @i_fecha_proceso
               and sec   = fr_secuencia
               and ssn   = fr_ssn
               and fr_estado = 'V'
               and fr_fact_elect = 'E'
        inner join cob_ahorros_his..ah_his_servicio
            on   hs_tsfecha    = fr_fecha
             and hs_secuencial = fr_ssn
             and hs_tipo_transaccion = 4188 and hs_usuario = 'cnb001'
    group by id, hs_tipo_transaccion, hs_oficina, hs_causa
    order by id, hs_tipo_transaccion, hs_oficina, hs_causa
    if @@error <> 0
    begin
        print 'ERROR EN INSERT (4) db_temporal..trax_servicio_sri_tmp' 
        return 12
    end
    dump transaction db_temporal with truncate_only
    --Ref002:msilvag Fin
  
  
    --Ref002:msilvag Inicio Cta. Básica retiros
    insert into db_temporal..trax_servicio_sri_tmp
       (ts_idfact, ts_trx, ts_org, ts_codcat, ts_oficina, ts_causa, ts_valor)
    select id, hs_tipo_transaccion, 12, @w_cat6, hs_oficina, hs_causa, sum(isnull(hs_valor, 0))
    from #factura
      inner left join cob_cuentas..cc_factura_recaudacion
           on fr_fecha = @i_fecha_proceso
             and sec   = fr_secuencia
             and ssn   = fr_ssn
             and fr_estado = 'V'
             and fr_fact_elect = 'E'
      inner join cob_virtuales_his..vi_his_servicio 
          on   hs_tsfecha    = fr_fecha
           and hs_secuencial = fr_ssn
           and hs_tipo_transaccion = 120061 and hs_usuario = 'cnb001'
    group by id, hs_tipo_transaccion, hs_oficina, hs_causa
    order by id, hs_tipo_transaccion, hs_oficina, hs_causa
    if @@error <> 0
    begin
      print 'ERROR EN INSERT (4) db_temporal..trax_servicio_sri_tmp' 
      return 12
    end
    dump transaction db_temporal with truncate_only
    --Ref002:msilvag Fin
    
  -- indice para el control de cursor
  create index trax_servicio_sri_tmp_idx1 on db_temporal..trax_servicio_sri_tmp(ts_idfact, ts_id)
  
  update statistics db_temporal..trax_servicio_sri_tmp
  
  -- recorrer cabecera
  select @w_id = 0
  while @w_id >= 0
  begin
    set rowcount 1
    select @w_id    = id,
           @w_sec   = sec,
           @w_ssn   = ssn
     from #factura
     
    if @@rowcount = 0
    begin
      set rowcount 0
      select @w_id = -1
      continue
    end
    
    set rowcount 0
    -- leer datos de la factura, para generar documento
    exec @w_return = cob_cuentas..sp_fact_electronica_sri_det
          @i_fecha_proceso    = @i_fecha_proceso,
          @i_id_fact          = @w_id,
          @i_sec_factura      = @w_sec,
          @i_ssn_factura      = @w_ssn,
          @i_ced_firmante     = @w_ced_firmante,
          @i_resolucion       = @w_resolucion,
          @i_ruc_firmante     = @w_ruc_firmante,
          @i_nom_moneda       = @w_descri_mon
    if @w_return <> 0
    begin
      print 'Error en ejecucion de cob_cuentas..sp_fact_electronica_sri_det (%1!)', @w_return
      return 13
    end
    
    set rowcount 1
    delete #factura
    if @@error <> 0
    begin
      set rowcount 0
      print 'Error en limpiado origen facturas', @w_return
      return 14
    end
  end
  
  if exists(select 1 from db_temporal..sysobjects where name = 'trax_servicio_sri_tmp' and type = 'U')
    drop table db_temporal..trax_servicio_sri_tmp
  
  return 0
go


