use cob_cuentas
go

if exists(select 1 from db_temporal..sysobjects where name = 'trax_servicio_sri_tmp' and type = 'U')
  drop table db_temporal..trax_servicio_sri_tmp
go

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
go

if exists(Select 1 from cob_cuentas..sysobjects where name = 'sp_fact_electronica_sri_det' and type = 'P')
  drop proc sp_fact_electronica_sri_det
  if exists(Select 1 from cob_cuentas..sysobjects where name = 'sp_fact_electronica_sri_det' and type = 'P')
    print 'DROP PROC sp_fact_electronica_sri_det <<ERROR>>'
  else
    print 'DROP PROC sp_fact_electronica_sri_det <<OK>>'
go

/************************************************************************/
/*      Archivo           :ccfelsri2.sp                                 */
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
/************************************************************************/
/*   2 02/Ago/2016 P.Holguin V.  CTE-CC-SGC00025809 Compensacion Iva    */
/************************************************************************/
/*   3 19/Oct/2017 Vanessa Miranda T FACOFF-AP-SGC00029747-SGC00029748  */
/*             Enviar el numero de autorizacion al centralizador        */
/************************************************************************/

create proc sp_fact_electronica_sri_det (
      @i_fecha_proceso        smalldatetime,
      @i_id_fact              int,
      @i_sec_factura          int,
      @i_ssn_factura          int,
      @i_ced_firmante         varchar(10),
      @i_resolucion           varchar(20),
      @i_ruc_firmante         varchar(30),
      @i_nom_moneda           varchar(64)
)
as
declare
    @w_return               int,
    @w_ced_ruc              varchar(13),
    @w_nombre               varchar(64),
    @w_fact_elect           char(1),
    @w_pto_estab            char(3),
    @w_pto_emis             char(3),
    @w_fecha_validez        varchar(25),
    @w_fecha_in_validez     varchar(10),
    @w_fecha_fin_validez    varchar(10),
    @w_ge_nom_archivo       varchar(100),
    @w_secdocu              varchar(9),
    @w_fecha_proc_str       varchar(10),
    @w_numero_aut           varchar(49),--ref3 se amplia de 15 a 49
    @w_valor_fact           money,
    @w_fr_servicio          varchar(30),
    @w_fr_referencia        varchar(20),
    @w_fr_iva               money,
    @w_fr_baseImp           money,
    @w_ge_tipo_documento    char(10),
    @w_ge_producto          varchar(10),
    @w_valor_base_iva       money,
    @w_valor_base0          money,
    @w_num_impresion        int,
    @w_ge_servicio          varchar(10),
    @w_secdoctrib           varchar(20),
    @w_fecha_imp1           char(8),
    @w_ofic                 smallint,
    @w_nro_sec              int,
    -- variables del cursor
    @w_id                   int,
    @w_codcat               smallint,
    @w_trx                  varchar(10),
    @w_causa                varchar(6),
    @w_valor                money,
    @w_det                  int,
    @w_concepto             varchar(64),
    @w_producto             tinyint,
    @w_departamento         tinyint,
    @w_adicional_eti1       varchar(100),
    @w_adicional_det1       varchar(100),
    @w_adicional_eti2       varchar(100),
    @w_adicional_det2       varchar(100),    
    ---Ref02 pholguiv
    @w_fr_porc_iva	    money,
    @w_fr_comp_iva          money,
    @w_fr_porc_comp	    money,
    @w_fr_frm_pago	    varchar(60),
    --Ref02
    @w_fr_cheque         int,         --ref_03 phoyosv 20171116
    @w_adicional_eti3    varchar(100),--ref_03 phoyosv 20171116
    @w_adicional_det3    varchar(100) --ref_03 phoyosv 20171116


 select @w_ge_tipo_documento = 'FACT',
        @w_fecha_proc_str    = convert(varchar, @i_fecha_proceso, 101)

  -- buscar datos de repositorio facturacion
  select @w_ced_ruc           = isnull(fr_ced_ruc, ''),
         @w_nombre            = fr_nombre,
         @w_fact_elect        = fr_fact_elect,
         @w_pto_estab         = fr_pto_estab,
         @w_pto_emis          = fr_pto_emis,
         @w_fecha_validez     = fr_fecha_validez,
         @w_fecha_in_validez  = fr_fecha_ini_vig,
         @w_fecha_fin_validez = fr_fecha_fin_vig,
         @w_numero_aut        = fr_nautorizacion,
         @w_valor_fact        = fr_valor,
         @w_fr_servicio       = fr_servicio,
         @w_fr_referencia     = isnull(rtrim(ltrim(fr_referencia)),''),
         @w_fr_iva            = isnull(fr_iva,0),
         @w_fr_baseImp        = isnull(fr_baseImp,0),
         @w_num_impresion     = case isnull(fr_impresa, 'S') when 'S' then 1 else 0 end,
         @w_fr_porc_iva       = fr_porc_iva,	   --Ref02 pholguiv
         @w_fr_comp_iva       = fr_comp_iva,	   --Ref02 pholguiv
         @w_fr_porc_comp      = fr_porc_comp,      --Ref02 pholguiv
         @w_fr_frm_pago       = fr_frm_pago_env,   --Ref02 pholguiv
         @w_fr_cheque         = fr_cheque          --ref_03 phoyosv 20171116
   from cob_cuentas..cc_factura_recaudacion
   where fr_fecha = @i_fecha_proceso
     and fr_estado = 'V'
     and fr_secuencia = @i_sec_factura
     and fr_ssn = @i_ssn_factura
  if @@rowcount = 0
  begin
    print 'ERROR AL OBTENER DATOS DE cob_cuentas..cc_factura_recaudacion @sec_fact %1!, @ssn_fact %2!', @i_sec_factura, @i_ssn_factura
    return 1
  end

  -- si servicio es diferente a 'Transferencias al Exterior', generar factura
  if @w_fr_servicio = 'Transferencias al Exterior'
    return 0

  -- determinar producto y servicio del documento
  if @w_fr_servicio in ('Recarga de Tarjeta Paykard', 'Compra de Tarjeta Paykard', 'Transferencia a Tarjetas Payca')
  begin
    select @w_ge_producto = 'PAYK',
           @w_ge_servicio = 'PAYK'
  end
  else if @w_fr_servicio = 'SRI-Imp. Emision de cheque'
  begin
    select @w_ge_producto = 'TRAN',
           @w_ge_servicio = 'ECHE'
  end
  else if @w_fr_servicio in ('Cobro por Estados Cuenta CTE', 'SRI-IMP NOTA DEB. CTE.')
  begin
    select @w_ge_producto = 'CTAS',
           @w_ge_servicio = 'CCTE'
  end
  else if @w_fr_servicio in ('SRI-Imp. Reposicion cartilla', 'Cobro por Estados Cuenta AHO', 'SRI-IMP NOTA DEB. AHORRO')
  begin
    select @w_ge_producto = 'CTAS',
           @w_ge_servicio = 'CAHO'
  end
  else if @w_fr_servicio = 'Transferencias al Exterior'
  begin
    select @w_ge_producto = 'TRAN',
           @w_ge_servicio = 'TRIN'
  end
  else if @w_fr_servicio = 'SRI-IMP NOTA DEB. VIRT'
  begin
    select @w_ge_producto = 'CTAS',
           @w_ge_servicio = 'VIRT'
  end
  else
  begin
    select @w_ge_producto = 'RECA',
           @w_ge_servicio = 'RECS'
  end

  if @w_fact_elect = 'E'
    select @w_fact_elect = 'S'
  else
    select @w_fact_elect = 'N'

  if @w_fr_iva > 0
    select @w_valor_base_iva = @w_fr_baseImp,
           @w_valor_base0    = 0
  else
    select @w_valor_base0    = @w_valor_fact,
           @w_valor_base_iva = 0

  select @w_secdocu = right(replicate('0', 9) + convert(varchar, @i_sec_factura), 9)
  select @w_secdoctrib = @w_pto_estab + @w_pto_emis + @w_secdocu
  select @w_fecha_imp1 = substring(@w_fecha_proc_str,1,2) + substring(@w_fecha_proc_str,4,2) + substring(@w_fecha_proc_str,7,4)
  select @w_ge_nom_archivo = ltrim(rtrim(@w_ge_tipo_documento)) + '_' + @w_secdoctrib + '_' + @w_fecha_imp1 + '_' + @w_ge_producto + '_' + @w_ge_servicio + '_' + @w_ced_ruc
  select @w_secdoctrib = @w_pto_estab + '-' + @w_pto_emis + '-' + @w_secdocu

  select @w_producto = convert(tinyint,substring(d.valor,11,3))
   from cobis..cl_tabla c,
        cobis..cl_catalogo d
   where c.tabla = 'cc_prod_serv_doc_tributario'
     and c.codigo = d.tabla
     and substring(d.valor,1,4) = @w_ge_producto
     and substring(d.valor,6,4) = @w_ge_servicio
     and d.estado = 'V'

  select @w_departamento = case @w_producto
                               when 3   then 2
                               when 4   then 3
                               when 16  then 25
                               when 159 then 17
                               when 160 then 17
                               else 2
                            end

  -- generar cabecera documento_sri
  exec @w_return = cob_gov..sp_cab_documento_sri
           @i_ge_producto             = @w_ge_producto,
           @i_ge_servicio             = @w_ge_servicio,
           @i_ge_tipo_documento       = @w_ge_tipo_documento,
           @i_ge_nom_archivo          = @w_ge_nom_archivo,
           @i_ge_razon_social_emi     = 'BANCO BOLIVARIANO C.A.',
           @i_ge_identificacion_emi   = @i_ruc_firmante,
           @i_ge_nro_autorizacion     = @w_numero_aut/* @w_numsri*/,--ref3 vmirandt
           @i_ge_codigo_documento     = 1,
           @i_ge_establecimiento      = @w_pto_estab,
           @i_ge_punto_emision        = @w_pto_emis,
           @i_ge_nro_documento        = @w_secdocu,
           @i_ge_caducidad_block      = @w_fecha_fin_validez,
           @i_ge_dir_matriz           = 'JUNIN 200 Y PANAMA',
           @i_ge_fecha_emision        = @i_fecha_proceso,
           @i_ge_razon_social_clte    = @w_nombre,
           @i_ge_identificacion_clte  = @w_ced_ruc,
           @i_ge_contrib_especial     = @i_resolucion,
           @i_ge_base_iva_cero        = @w_valor_base0,
           @i_ge_base_calculo_iva     = @w_valor_base_iva,
           @i_ge_valor_iva            = @w_fr_iva,
           --@i_ge_eti_adicional03      = 'Cedula Firmante',
           --@i_ge_info_adicional03     = @i_ced_firmante,
           --@i_ge_eti_adicional04      = 'RUC  Firmante',
           --@i_ge_info_adicional04     = @i_ruc_firmante,
           @i_fa_tot_sin_imptos       = @w_fr_baseImp,
           @i_fa_tot_con_imptos       = @w_valor_fact,
           @i_fa_moneda               = @i_nom_moneda,
           @i_fa_descuento            = 0,
           @i_ds_est_factelec         = @w_fact_elect,
           @i_ds_fecha_autorizacion   = @w_fecha_in_validez,
           @i_ge_numero_impresion     = @w_num_impresion,
           @i_ofi_at                  = 0,
           @i_dpto_at                 = @w_departamento,
           @i_producto_at             = @w_producto,
           @i_tipotrx_at              = 2,
           @i_porc_compensa           = @w_fr_porc_comp,	--Ref02 pholguiv
           @i_monto_compensa          = @w_fr_comp_iva,		--Ref02 pholguiv
           @i_ds_archivo_anexo        = @w_fr_frm_pago,		--Ref02 pholguiv
           @i_deposito                = @w_fr_porc_iva,		--Ref02 pholguiv
           @o_sec_registro            = @w_nro_sec  out
  if @w_return <> 0
  begin
    print 'ERROR EN LA EJECUCION DE cob_gov..sp_cab_documento_sri %1!', @w_return
    return 2
  end

  -- recorrer detalles transaccional
  select @w_id  = 0,
         @w_det = 1
--ref_03 fin phoyosv 20171116
/*********************         
  if @w_fr_servicio = 'CERTIFICACION CHEQUES'
     select @w_adicional_eti1 = 'Tipo de cuenta',
            @w_adicional_det1 = 'CUENTA CORRIENTE',
            @w_adicional_eti2 = 'Numero de cuenta',
            @w_adicional_det2 = @w_fr_referencia
  else
  begin
     select @w_adicional_eti1 = '',
            @w_adicional_det1 = ''
     if @w_fr_servicio = 'SRI-IMP OTROS INGRESOS'
       select @w_adicional_eti2 = '',
              @w_adicional_det2 = ''
     else
       select @w_adicional_eti2 = 'Referencia',
              @w_adicional_det2 = @w_fr_referencia
  end         
*****************/  
  select @w_adicional_eti1 = '',
         @w_adicional_det1 = ''
  if @w_fr_servicio = 'CERTIFICACION CHEQUES'
     select @w_adicional_eti1 = 'Tipo de cuenta',
            @w_adicional_det1 = 'CUENTA CORRIENTE',
            @w_adicional_eti2 = 'Numero de cuenta',
            @w_adicional_det2 = @w_fr_referencia,
            @w_adicional_eti3 = 'Numero de cheque',               --ref_03 phoyosv 20171116
            @w_adicional_det3 = convert(varchar,@w_fr_cheque)     --ref_03 phoyosv 20171116
  else if @w_fr_servicio = 'Recarga de Tarjeta Paykard' or 
          @w_fr_servicio = 'Transferencia a Tarjetas Paycard' or 
          @w_fr_servicio = 'SRI-IMP OTROS INGRESOS'
     select @w_adicional_eti3 = 'Numero secuencial transaccion',  --ref_03 phoyosv 20171116
            @w_adicional_det3 = convert(varchar,@w_fr_cheque)     --ref_03 phoyosv 20171116
  else
     select @w_adicional_eti2 = 'Referencia',
            @w_adicional_det2 = @w_fr_referencia
            
  if @w_fr_servicio = 'SRI-IMP OTROS INGRESOS'
     select @w_adicional_eti2 = '',
            @w_adicional_det2 = ''
--ref_03 fin phoyosv 20171116

  while @w_id >= 0
  begin
    set rowcount 1
    select @w_id     = ts_id,
           @w_codcat = ts_codcat,
           @w_trx    = convert(varchar(10), ts_trx),
           @w_causa  = ts_causa,
           @w_ofic   = ts_oficina,
           @w_valor  = ts_valor
     from db_temporal..trax_servicio_sri_tmp
     where ts_idfact = @i_id_fact
       and ts_id > @w_id
     order by ts_id
    if @@rowcount = 0
    begin
      set rowcount 0
      select @w_id = -1
      continue
    end
    set rowcount 0


PRINT 'Variable 1 = %1!', @w_codcat
PRINT 'Variable 2 = %1!', @w_causa
    select @w_concepto = null
    if @w_codcat is not null
      select @w_concepto = valor
       from cobis..cl_catalogo
       where tabla  = @w_codcat
         and codigo = @w_causa

PRINT 'Variable 3 = %1!', @w_nro_sec

    exec @w_return =  cob_gov..sp_det_documento_sri
            @i_ge_producto             = @w_ge_producto,
            @i_ge_sec_registro         = @w_nro_sec,
            @i_ge_sec_detalle          = @w_det,
            @i_ge_tipo_detalle         = @w_causa, --'DETALLES',
            @i_ge_concepto             = @w_concepto,
            @i_ge_cantidad             = 1,
            @i_ge_precio_base          = @w_valor,
            @i_ge_precio_total         = @w_valor,
            @i_ge_det_adicional01      = @w_adicional_det1,
            @i_ge_eti_adicional01      = @w_adicional_eti1,
            @i_ge_det_adicional02      = @w_adicional_det2,
            @i_ge_eti_adicional02      = @w_adicional_eti2,
            @i_ge_det_adicional03      = @w_adicional_det3,   --ref_03 phoyosv 20171116
            @i_ge_eti_adicional03      = @w_adicional_eti3,   --ref_03 phoyosv 20171116
            @i_trx_cu                  = @w_trx,
            @i_causa_cu                = @w_causa,
            @i_ofi_cu                  = @w_ofic,
            @i_tipo_det                = 'R',
            @i_gr_valor_retenido       = @w_fr_iva  --Ref02 pholguiv
    if @w_return <> 0
    begin
      print 'ERROR EN LA EJECUCION DE cob_gov..sp_det_documento_sri %1!', @w_return
      return 3
    end
    select @w_det = @w_det + 1
  end
  return 0
go
  if exists(Select 1 from cob_cuentas..sysobjects where name = 'sp_fact_electronica_sri_det' and type = 'P')
    print 'CREATE PROC sp_fact_electronica_sri_det <<OK>>'
  else
    print 'CREATE PROC sp_fact_electronica_sri_det <<ERROR>>'
go
if exists(select 1 from db_temporal..sysobjects where name = 'trax_servicio_sri_tmp' and type = 'U')
  drop table db_temporal..trax_servicio_sri_tmp
go
