use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_pago_servicios_varios' and type = 'P')
begin
   drop procedure dbo.sp_pago_servicios_varios
   if exists (select 1 from sysobjects where name = 'sp_pago_servicios_varios' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_pago_servicios_varios -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_pago_servicios_varios *OK* =='
end

go

/************************************************************************/
/*  Archivo:            pgpgseva.sp                                     */
/*  Stored procedure:   sp_pago_servicios_varios                        */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       German Medina                               	*/
/*  Fecha de escritura: 16-Feb-2012                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECM-732                                   	*/
/*  Ult.Referencia:     REF 1                                           */
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
/*  Este programa procesa validacion recargas prepagos                  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*    FECHA       AUTOR          RAZON                                  */
/*    16/Feb/2011 German Medina  Emisión inicial MGL-309-CU-1830        */
/*2   18/Sept/2012 Ana Mendez    CTE-CC-SGC00003473 cambio de codigo causa debito a 487*/
/*3   17/Dic/2012  Daniel Pereira  CTE-CC-SGC00006244 - IVA             */
/*4   03/abril/2013 Sandra Merino. TVCABW-SGC00007822                   */
/*5   14/Ene/2013  Daniel Pereira  SGC00005780 CNT SERVICIOS MOVILES    */
/*6   16/Jul/2013  Daniel Pereira  SGC00009046 Recaudacion en Linea Ecutel*/
/*7   27/Agt/2013  Daniel Pereira  SGC00010841 CONECEL TV SATELITAL     */
/*8   10/Mar/2014  Daniel Pereira  EPMTG-AP-SGC00013964-SGC00013966     */
/*9   22/Sep/2014  Sandra Merino   RECBEL-AP-SGC00016734-SGC00016735    */
/*10 18-Ene-2016  María José Silva  ETAPA-AP-SGC00018437-SGC00018451 Comisión de Etapa*/
/*   15/Febrero/2016 smerino   	  RECBEL-AP-SGC00016734-SGC00016737     */
/*12 07/Abril/2016 María José Silva  SGC00023538  Enviar alerta     */
/*13 02/Ago/2016   Luis Banda  RECA-CC-SGC00025868 se valida comision para*/
/*                   oficina damnificados segun comercio                */
/*14 08/Ago/2016   Jorge Barrera H.  SGC00021271  Boton de pagos        */
/*15 12/Sep/2016   J.Pazminno     MEGA-AP-SGC00024776-SGC00024778       */
/*16 16/Feb/2017   Daniel Pereira RECA-CC-SGC00027934 Cobro Comisión ND Ventanilla */
/*17 15/Mar/2017   Daniel Pereira RECA-CC-SGC00027715 Cobro Comisión ND Ventanilla */
/*18 04/May/2017   María José Silva RECA-CE-SGC00028529 Colocar default CTE en la variable @i_tipo_cta */
/*19  18/May/2017  María José Silva    Cobro de Comisión TVCABLE RECA-CC-SGC00027895  */
/*20  31/Ago/2017  Jonathan Lopez Torres Deflactacion de Boton de Pago por Corriente */
/*21  26/Dic/2017  María José Silva   RECA-CE-SGC00030685 Validar que existe el pago antes de realizar el reverso  */
/*22  05/Sept/2018  Maria Jose Silva     RECA-CC-SGC00032726        */
/*23  14/Feb/2019	María José Silva	MGLOB-4 Recaudacion Marglobal*/
/*24  04/May/2020  Daniel Pereira RECMPS-527  Migracion Latinia      */
/*25  09/Dic/2020  Daniel Pereira RECM-217   Cambio en descripcion para notificacion varias */
/*26  05/Feb/2021  Josué Rocafuerte RECMPS-401   Descripcion para canal SAT de Notificaciones Latinia */
/*27  23/Mar/2021  Josué Rocafuerte RECMPS-685   Agregar Empresas TVCable y Megadatos a la Notificacion de Latinia */
/*28  27/Oct/2021  Josué Rocafuerte RECM-416 Agregar Empresas Catalogo de Empresas TVCable */
/*29  05/Jul/2023  JKevin Bastidas RECM-732 Cambiar Nombre Empresa TVCABLE a XTRIM */
/************************************************************************/
create proc dbo.sp_pago_servicios_varios (
    @s_ssn                  int,
    @s_lsrv                 varchar(30),
    @s_srv                  varchar(30) = null,
    @s_user                 varchar(30) = null,
    @s_sesn                 int = null,
    @s_term                 varchar(10),
    @s_date                 datetime,
    @s_ofi                  int = 1,
    @s_rol                  smallint = 1,
    @s_org_err              char(1) = null,       /* Origen de error: [A], [S] */
    @s_error                int = null,
    @s_sev                  tinyint = null,
    @s_msg                  mensaje = null,
    @s_org                  char(1),
    @t_corr                 char(1) = 'N',
    @t_ssn_corr             int     = null,       /* Trans a ser reversada     */
    @t_debug                char(1) = 'N',
    @t_file                 varchar(14) = null,
    @t_from                 varchar(32) = null,
    @t_rty                  char(1) = 'N',
    @t_trn                  int,
    @i_mon                  tinyint     = 1,
    @i_servicio             varchar(10) = "5",
    @i_empresa              varchar(10),
    --@i_codigo     varchar(12),
    @i_aplcobis             char(1) = 'S',
    @i_efectivo             money = 0,
    @i_cheque               money = 0,
    @i_debito               money = 0,
    @i_tarjeta              money = 0,
    @i_subtotal             money = 0,
    @i_comision_tot         money = 0,
    @i_comision_efe         money = 0,
    @i_comision_chq         money = 0,
    @i_comision_db          money = 0,
    @i_total                money = 0,
    @i_cant_cheques         int    = 0,
    @i_tipo_cta             char(3)     = 'CTE',  --Ref018:msilvag 
    @i_cuenta               varchar(24) = null,
    @i_nombre_cta           varchar(70) = null,
    @i_autoriza             char(1) = 'N',
    @i_canal                char(3)     = null,
    @i_tsn                  int = null,
    @i_ubi                  int = null,
    @i_cod_cliente          varchar(15) = null,  --REF 6
    @i_cod_referencia       varchar(30) = null,
    @i_ruc_cliente          varchar(13) = null,
    @i_nombre_cliente       varchar(32) = null,
    @i_bl                   varchar(32) = null,
    @i_base_imponible       money = null,
    @i_tipo_documento       varchar(10) = null, --t_servicio
    @i_factura              varchar(32) = null, --Secuencia_recibo
    @i_cod_respuesta        varchar(32) = null,
    @i_ssn                  int = null,
    @i_servicio_fact        varchar(13) = 'Recaudacion',
    @o_fecha_contable       varchar(10) = null output,
    @o_ssn                  int = null output,
    @o_autorisri            varchar(30) = null output,
    @o_fecvensri            varchar(30) = null output,
    @o_nota_venta           varchar(20) = null output,
    @o_fact_elect           varchar(1) = null output,
    @o_cod_respuesta        varchar(32) = null output, --REF 5 smerino aumenta longitud del campo cod de autorizacion de tvcable
    @o_mensaje_respuesta    varchar(32) = null output,
    @o_fec_ini_vig_aut      varchar(10) = null output,
    @o_fec_fin_vig_aut      varchar(10) = null output,
    @o_fecdessri            varchar(30) = null output,
    @o_horario              char(1) = null output,
    @i_cod_grupo            varchar(10) = null, --REF 4
    @i_grupo                char(1)  = null, --REF 4
    @i_pcodigo_ciudad       varchar(32) = null, --REF 5 smerino
    @i_pdescr_empresa       varchar(32) = null,  --REF 5 smerino
    @i_nomb_tramite         varchar(64) = null,
    @i_pcodigo_operacion    varchar(10) = null, --REF 5 smerino
    @i_pcodigo_secuencia    varchar(10) = null, --REF 5 smerino
    @i_phoralocal           varchar(6)  = null, --smerino belcopr
    @o_tasa         money = 0 out,  --smerino belcopr
    @o_base_imp     float = 0 out,  --smerino belcopr
    @o_impuesto     float = 0 out,  --smerino belcopr
    @i_cod_consultora		int = null, --Ref022:msilvag 
    --ini ref24
    @o_servicio_not 	varchar(5) = null out,	
    @o_nomb_ente     varchar(64) = null out,	
    @o_cod_ente      varchar(20) = null out,	
    @o_desccanal     varchar(16) = null out,	
    @o_celular       varchar(10) = null out,	
    @o_correo        varchar(64) = null out,	
    @o_desc_empresa  varchar(32)  = null out,	
    @o_prod_deb      char(3) = null out, 
    @o_valor		varchar(11) = null out, 
    @o_fecha_deb	varchar(10) = null out, 
    @o_hora_deb 	varchar(8) = null out,  
    @o_valor_comi	varchar(11) = null out, 
    @o_valor_tot	varchar(11) = null out, 
    @o_cta_lat	char(3)  = null out, 
    @o_tipo_serv varchar(16)  = null out 
    --fin ref24
  )
  
as

declare @w_return           int,
    @w_sp_name              varchar(30),
    @w_hora_tope            int,
    @w_hora_sys             char(8),
    @w_hora                 int,
    @w_fecha_hoy            varchar(10),
    @w_offline              char(1),
    @w_hora_dif             varchar(9),
    @w_causa                varchar(5),
    @w_ssn        int,
    @w_trn          int,
    @w_servicio             char(4),
    @w_fact_elect           char (1),
    @w_fecha_validez        varchar (25),
    @w_nautorizacion        varchar (15),
    @w_nro_factura          varchar (20),
    @w_maximo_p       money,
    @w_factor       int,
    @w_trx_orig       int,
    @w_tipocta              char(1),
    @w_operacion            char(1),
    @w_trn_com_fac          int,
    @w_fec_ini_vig_aut      varchar(10) ,
    @w_fec_fin_vig_aut      varchar(10),
    @w_msj_resp_reverso     varchar(32),
    @w_tasa                 money, --REF3
    @w_base_imp             float, --REF3
    @w_impuesto2            float,  --REF3
    @w_causal_com           varchar(5),--dpav
    @w_cod_referencia       varchar(30), --REF 7
    --Ref012:msilvag Inicio
    @w_cliente              int,
    @w_telefono             varchar(10),
    @w_desc_canal   varchar(16),   
    @w_desc_servicio  varchar(5), 
    @w_desc_empresa   varchar(32), 
    @w_valor_debito   varchar(11), 
    @w_categoria  char(1),   
    @w_correo     varchar(64),   
    @w_producto      tinyint,
    @w_nombre_cta       varchar(64),
    @w_servicio_desc    varchar(30),
    @w_motivo       varchar(30), 
    --Ref012:msilvag Fin
        /*REF13 Inicio LBP */ 
        @w_valor_compensa   money,
        @w_comi_total       money,
        @w_ofi              int,
        @w_com_original     money,
        @w_aplica_des       char(1),
        @w_empresa          int,
        /*REF13 Fin LBP */ 
        --REF 14
	@w_empresa_bp varchar(10),
	@w_trx_iva   smallint,
	@w_servicio_costo  varchar(4),
	@w_rowcount int,        --REF 14 
  @v_maxpago_mgd          money,       -- JPM Ref.15
  @v_org_aviso_mgd        varchar(30),  -- JPM Ref.15
  @v_num_operacion	varchar(20) --REF: 16
    
    
    
/*  Captura nombre de Stored Procedure  */

select  @w_sp_name = 'sp_pago_servicios_varios'
-- REF 14

select  @w_trx_iva=3497
select  @w_servicio_costo='CSPR'
select  @w_rowcount = 0
-- REF 14

if @t_corr = 'N'
  select  @s_ssn = @i_ssn
/*Asignar Fecha de Proceso a la variable @s_date*/
select @s_date = convert(varchar(10),@s_date,101)  --smerino belkcorp

/*REF13 Inicio LBP */   
if @i_canal = 'CNB'
    select @w_ofi = @s_ofi, @s_ofi = 0 
    else
    if @i_canal = 'VEN'
    select @w_ofi = @s_ofi
/*REF13 Fin LBP */ 

if @s_date is null
begin
     select @s_date = fp_fecha from cobis..ba_fecha_proceso
end

--El campo @w_cod_referencia va a contener el codigo del pago
if len(isnull(@i_cod_referencia,'')) <= len(isnull(@i_cod_cliente,'')) --Ref012:msilvag --REF 7
  select @w_cod_referencia = @i_cod_cliente
else
  select @w_cod_referencia = @i_cod_referencia

select @o_fecha_contable = convert(varchar(10),@s_date,101)

select @w_fecha_hoy = convert(varchar(10), getdate(),101)

--REF 5 smerino ---
select @o_cod_respuesta= @i_cod_respuesta
--smerino

--REF: 16  INI
if @i_comision_db > 0  
	select @v_num_operacion = @i_cuenta
else
	select @v_num_operacion = @w_cod_referencia 
--REF: 16  FIN

--if @i_canal <> 'VEN'
if @i_canal not in ( 'VEN','CNB')  --SMERINO BELCORP
   begin
       select @i_comision_db = @i_comision_tot
   end

if @t_trn is null 
  select @t_trn = 3925

-- verificar que las trx se realicen dentro del horario establecido y devolver a front end
select @w_offline = atm_offline
from cobis..ba_fecha_proceso

--< HORA TOPE <
select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
  from cobis..cl_tabla a, cobis..cl_catalogo b
 where a.tabla = 'sv_horario_serv'
   and a.codigo = b.tabla
   and b.codigo = @i_empresa
   and estado = 'V'
if @@rowcount = 0 or @w_hora_tope = 0
    begin
  if @i_aplcobis = 'S'
       begin
      exec cobis..sp_cerror
     @t_debug         = @t_debug,
     @t_file          = @t_file,
     @t_from          = @w_sp_name,
     @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
     @i_num           = 111111
      return 1
    end
      else
        return 37601
    end
    
    -- JPM Ref.15 -->
    -- Validar monto maximo pago megadatos... como informativo, no como error
    if @i_empresa = '1089' and @t_corr = 'N'
    begin
      select @v_maxpago_mgd = pa_money
       from cobis..cl_parametro
       where pa_nemonico = 'MAXPMD'
         and pa_producto = 'CTE'
      if @v_maxpago_mgd is not null
      begin
        if @i_total > @v_maxpago_mgd
        begin
          select @v_org_aviso_mgd = case when @i_canal in ('WAP', 'IBK') then 'AVISO' else @w_sp_name end
          exec cobis..sp_cerror
              @t_debug         = @t_debug,
              @t_file          = @t_file,
              @t_from          = @v_org_aviso_mgd,  -- Origen de mensaje depende del canal de la transaccion
              @i_num           = 30076
          return 30076
        end
      end
    end
    -- <-- JPM Ref.15
    
 ---print '@t_trn %1!,' ,@t_trn

  if @i_aplcobis = 'S' and @i_canal = 'VEN'
   begin

      exec @w_return = cob_remesas..sp_verifica_caja_rc
      @s_ssn   = @s_ssn,
      @s_srv   = @s_srv,
      @s_lsrv  = @s_lsrv,
      @s_user  = @s_user,
      @s_term  = @s_term,
      @s_date  = @s_date,
      @s_ofi   = @s_ofi,
      @s_rol   = @s_rol,
      @s_sev   = @s_sev,
      @s_msg   = @s_msg,
      @s_org   = @s_org,
      @t_trn   = @t_trn,
      @t_corr  = @t_corr,
      @i_mon   = @i_mon,
      @i_ubi   = @i_ubi,
      @o_horario = @o_horario out
      if @w_return != 0
      begin
  if @i_aplcobis = 'S'
     begin
    exec cobis..sp_cerror
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @i_msg           = 'HORARIO DE CAJA NO DEFINIDO',
    @i_num           = 111111
    return 1
     end
  else
      return @w_return
      end
   end



select @w_hora_sys  = convert(varchar,getdate(),108)
--Identifico si estoy en el horario normal o diferido
if @i_canal = 'VEN'
begin
     select @w_hora_dif = rh_inicio from cob_remesas..re_horario where rh_oficina = @s_ofi and rh_ubicacion = @i_ubi
     if @w_hora_sys >= @w_hora_dif  ---and @i_cheque > 0
        select @t_trn = 3926
     else
        select @t_trn = 3925
end
else
    select @t_trn = 3925



select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
--if @w_hora >= @w_hora_tope and @w_offline = 'N' and @s_date = @w_fecha_hoy smerino
if @w_hora >= @w_hora_tope  and @s_date = @w_fecha_hoy
 begin
    select  @t_trn = 3927
    select @o_fecha_contable = convert(varchar,min(dl_fecha),101)
      from cob_cuentas..cc_dias_laborables
     where dl_ciudad = 1
       and dl_num_dias = 1
 end


if @t_corr = 'S'
begin
    select @w_factor = -1 ,@w_operacion = 'R' , @i_ssn  = @t_ssn_corr ,@w_trn_com_fac = 4969
    
    --Ref021:msilvag Inicio
    
    --Valida que exista registrado el pago antes de registrar el reverso
    if not exists(select 1 from cob_cuentas..cc_tran_servicio
            where ts_secuencial = @t_ssn_corr 
            and ts_tipo_transaccion in (3925,3926,3927)
            and ts_causa = @i_empresa
            and ts_tsfecha = @s_date )
    begin
        exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'NO EXISTE TRANSACCIÓN ORIGINAL',
            @i_num           = 34014
        return 34014
    end
    
    --Valida si el secuencial de corrección ya que encuentra ingresado para los reversos
    if @i_empresa = "7256"
    begin
        if exists(select 1 from cob_cuentas..cc_tran_servicio
                where ts_ssn_corr = @t_ssn_corr 
                and ts_tipo_transaccion in (3925,3926,3927)
                and ts_correccion = 'S'
                and ts_causa = @i_empresa
                and ts_tsfecha = @s_date )
        begin
            exec cobis..sp_cerror
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_msg           = 'REGISTRO DUPLICADO',
                @i_num           = 130028
            return 130028
        end
    end
    --Ref021:msilvag Fin
        
    --if @i_canal = 'VEN'    --Ref021:msilvag
    --begin                  --Ref021:msilvag
       select  @w_trx_orig = ts_tipo_transaccion, -- identifica trx original
                @w_msj_resp_reverso = ts_campo_alt_uno
        from cob_cuentas..cc_tran_servicio
        where ts_tsfecha = @s_date
        and ts_secuencial = @t_ssn_corr
        and ts_tipo_transaccion in (3925,3926,3927)


        if @@rowcount <> 0
            select @t_trn = @w_trx_orig

       select @i_cod_respuesta = @w_msj_resp_reverso ---REF 5 SMERINO


       if @w_hora >= @w_hora_tope  and @s_date = @w_fecha_hoy  and @t_trn <> 3927
       begin
             exec cobis..sp_cerror
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_from          = @w_sp_name,
           @i_msg           = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO',
           @i_num           = 358750
            return 1
       end
    --end           --Ref021:msilvag
end
else
    select @w_factor =  1,@w_operacion='I',@i_ssn  = @i_ssn,@w_trn_com_fac = 4969


--- VALIDACION DE MONEDA
  if @i_mon <> 1
  begin
    exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 033333,
   @i_msg    = 'TRANSACCION SOLO SE DEBE REALIZAR EN DOLARES'
    return 1
  end
-- VALIDACION DE PARAMETRO DE MONTO MAXIMO
if @i_autoriza = 'N' and  @t_corr = 'N'
   begin
     select @w_maximo_p = pa_money
     from cobis..cl_parametro
     where pa_nemonico = 'MMVI'
     and  pa_producto = 'CTE'
     if (@w_maximo_p <= @i_total )
     begin
     exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 311819
       return 311819
    end
   end


select @w_tipocta = case when @i_tipo_cta = 'CTE' then 'C'
                         when @i_tipo_cta = 'AHO' then 'A'
						 -- else '' Se comenta para que se grabe nulo en caso de pago en efectivo Ref012:msilvag
					end


if @i_tipo_cta = 'CTE' and @i_debito > 0
begin
    --print 'entro aqui'
  -- REF 14
  if @i_canal = 'CPV'
  begin
      set @w_empresa_bp = @i_empresa
	  set @w_cod_referencia= @i_empresa
	  set @i_empresa = @i_grupo + ltrim(rtrim(@i_empresa))
	  set @w_servicio_costo='BTPG'
  end
  -- REF 14
  --select @w_causa ='487'   ---REF2
  select @w_causa = isnull(b.valor,' ')
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_cte_servicios'
  and a.codigo = b.tabla
  and b.codigo = @i_empresa
  and estado = 'V'
  set @w_rowcount = @@rowcount
  -- REF 14
  if @i_canal = 'CPV'
  begin
      set @i_empresa = @w_empresa_bp
  end
  -- REF 14
  
  if @w_rowcount = 0 or (@w_causa = null or @w_causa = ' ')
  begin
    if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
    begin                                                                -- JLS 23/FEB/2001
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
           @i_num   = 158693
           return 1
      end
  end

   exec @w_return = cob_cuentas..sp_ccndc_automatica
   @s_srv          = @s_srv,
   @s_ofi          = @s_ofi,
   @s_ssn          = @s_ssn,
   @s_user         = @s_user,
   @s_term         = @s_term,
   @t_corr         = @t_corr,
   @t_trn          = 3050,
   @i_cta          = @i_cuenta,
   @i_val          = @i_debito,
   @i_cau          = @w_causa,
   @i_mon          = @i_mon,
   @i_ref          = @w_cod_referencia, --REF 7
   @i_fecha        = @s_date,
   @i_nchq         = @t_ssn_corr,
   @i_aplcobis     = @i_aplcobis,
   @i_ubi          = @i_ubi,
   @s_rol          = @s_rol,
   @i_tsn          = @i_tsn,
   @i_con_tran     = 'N',
   @i_detalle      = @w_cod_referencia --REF 7
    if @w_return <> 0
       begin
           -- print 'w_return_automatica: %1! ', @w_return
    return @w_return
       end
   end

if @i_tipo_cta = 'AHO' and @i_debito > 0
begin
 -- REF 14
  if @i_canal = 'CPV'
  begin
      set @w_empresa_bp = @i_empresa
	  set @w_cod_referencia= @i_empresa
	  set @i_empresa = @i_grupo + ltrim(rtrim(@i_empresa))
	  set @w_servicio_costo='BTPG'
  end
  -- REF 14
  --select @w_causa ='487'   ---REF2
  select @w_causa = isnull(b.valor,' ')
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_aho_servicios'
  and a.codigo = b.tabla
  and b.codigo = @i_empresa
  and estado = 'V'
  set @w_rowcount = @@rowcount
  -- REF 14
  if @i_canal = 'CPV'
  begin
      set @i_empresa = @w_empresa_bp
  end
  -- REF 14
  if @w_rowcount = 0 or (@w_causa = null or @w_causa = ' ')
  begin
    if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
    begin                                                                -- JLS 23/FEB/2001
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
           @i_num   = 158693
           return 1
    end
  end
  -- REF 14
  declare @w_tran int
  set @w_tran = 4264
  if @i_canal = 'CPV'
  begin
      set @w_tran = 4272
  end
  -- REF 14
  exec @w_return = cob_ahorros..sp_ahndc_automatica
   @s_srv          = @s_srv,
   @s_ofi          = @s_ofi,
   @s_ssn          = @s_ssn,
   @s_user         = @s_user,
   @s_term         = @s_term,
   @t_trn          = @w_tran,  -- REF 14 
   @t_corr         = @t_corr,
   @i_cta          = @i_cuenta,
   @i_val          = @i_debito,
   @i_cau          = @w_causa,
   @i_mon          = @i_mon,
   @i_ref          = @w_cod_referencia, --REF 7
   @i_fecha        = @s_date,
   @i_referen      = @t_ssn_corr,
   @i_aplcobis     = @i_aplcobis,
   @i_ubi          = @i_ubi,
   @s_rol          = @s_rol,
   @i_tsn          = @i_tsn,
   @i_con_tran     = 'N',
   @i_tarjeta      = @w_cod_referencia --REF 7
    if @w_return <> 0
       begin

    return @w_return
       end

 end
 
 
--- smerino belcorp----
if  @i_empresa='7256' --REF 7
begin

select @i_cod_respuesta= @i_pcodigo_secuencia
select @i_factura= @i_pcodigo_operacion
select @i_servicio='F'

end 

-- Transaccion servicio


insert into cob_cuentas..cc_tran_servicio
    (ts_secuencial, ts_tipo_transaccion, ts_oficina,
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
    ts_agente,ts_autorizante,ts_campo_alt_dos,ts_cod_banco , ts_cliente ) --Ref022:msilvag  --REF 7 smerino belcorp
values
    (@s_ssn, @t_trn, @s_ofi,
    @s_user, @s_rol, @s_term,
    @t_corr, @i_canal, null,
    'L', @s_lsrv, convert(varchar(10),@s_date,101),  --smerino
    @i_servicio, @s_date, @i_cod_cliente,
    @i_cheque, @t_ssn_corr, @i_cuenta,
    @i_mon, 'L',  @i_efectivo,
    @i_debito, 0, @i_tarjeta,
    0, null, @i_tsn,
    null, getdate(), @i_ssn,
    @i_empresa, @w_tipocta, isnull(@i_nombre_cliente,@i_nombre_cta),
    @i_aplcobis, null, @i_cant_cheques,
    @i_ubi, @i_nombre_cliente, convert(varchar, @i_base_imponible),
    @i_cod_respuesta, convert(varchar, @i_comision_tot),@i_cod_grupo, --REF4
    @i_cod_referencia,@i_nomb_tramite,@i_factura,@i_phoralocal, @i_cod_consultora )--Ref022:msilvag  --REF 7

if @@rowcount <> 1
begin
  if @i_aplcobis = 'S'
     begin
     exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
   @i_num = 031004
     return 031004
     end
  else
    return 33005
end

select @o_base_imp = 0, @o_impuesto = 0 , @o_tasa= 0 --Ref012:msilvag 

if @i_comision_tot > 0
begin
  if @t_trn = 3925
   select  @w_trn = 3366

  if @t_trn = 3926 or @t_trn = 3927
   select  @w_trn = 3372

    --Consulta el servicio de la empresa la personalizacion
    select @w_servicio = pe_serv_com, --dapv
    	   @w_servicio_costo = isnull(pe_cod_serv,'CSPR')  --REF: 16
    from cob_pagos..pg_person_empresa
    where pe_empresa = convert(int,@i_empresa)
        
    
   ---if @i_empresa ='7256'    --smerino belcorp la causa de la comision es 29 para belcorp
        ---select @w_servicio = '6'

    if @i_tipo_cta = 'AHO' --dapv
    begin
        -- REF 14
        if @i_canal = 'CPV'
        begin
          set @w_empresa_bp = @i_empresa
          set @i_empresa = @i_grupo + ltrim(rtrim(@i_empresa))
          set @w_trx_iva=4188
        end
	-- REF 14
        select @w_causal_com = b.valor
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = 'causa_nd_comision_servaho'
        and a.codigo = b.tabla
        and b.codigo = @i_empresa
        and estado = 'V'
        set @w_rowcount = @@rowcount  --Ref017:msilvag 
        -- REF 14
    	if @i_canal = 'CPV'
    	begin
    	  set @i_empresa = @w_empresa_bp
    	end
        -- REF 14        
    end
    else
      if @i_tipo_cta = 'CTE' --smerino belcorp
    begin
        -- REF 14
       	if @i_canal = 'CPV'
       	begin
       		set @w_empresa_bp = @i_empresa
       		set @i_empresa = @i_grupo + ltrim(rtrim(@i_empresa))
            set @w_trx_iva=3188 --ref 20
       	end
        -- REF 14    
        select @w_causal_com = b.valor
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = 'causa_nd_comision_servcte'
        and a.codigo = b.tabla
        and b.codigo = @i_empresa
        and estado = 'V'
        set @w_rowcount = @@rowcount  --Ref017:msilvag 
        -- REF 14
	if @i_canal = 'CPV'
	begin
	  set @i_empresa = @w_empresa_bp
	end
	-- REF 14
    end
    
    --Ref017:msilvag Inicio
    if @w_rowcount = 0 or (@w_causal_com = null or @w_causal_com = ' ')
      begin
        if @i_aplcobis = 'S'                                                 
        begin                                                               
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA LA COMISION',
               @i_num   = 300003517 --Ref019:msilvag  158693
               return 300003517 --Ref019:msilvag 1
          end
      end
      --Ref017:msilvag Fin


    
	/*REF13 Inicio LBP*/
	select @w_aplica_des = 'N'
	select @w_empresa = convert(int,@i_empresa)
	if exists (select 1 from cob_pagos..pg_p_rubro_ser_dam 
		   where rs_empresa = @w_empresa 
		   and rs_canal = @i_canal and rs_estado = 'V')  
	begin
	
	    if @i_canal in ('VEN', 'CNB')
	    begin
	    
	          select @w_comi_total = isnull(@i_comision_efe,0) + isnull(@i_comision_chq,0) + isnull(@i_comision_db,0)
	          
	          exec @w_return = cob_pagos..pa_pg_ivalor_comcal
	          @e_valor_comision  = @w_comi_total,
	          @e_oficina         = @w_ofi,
	          @e_empresa         = @w_empresa,
	          @e_canal           = @i_canal,
                  @s_valor_com_final = @w_com_original out, -- obtengo comision original
                  @s_aplica          = @w_aplica_des out
                  if @w_return <> 0
                     return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 

                  if @w_aplica_des = 'S'
                  begin
		      exec @w_return = cob_gov..pa_iva_pcompensacion
		      @e_oficina        = @w_ofi,
		      @e_monto          = @w_com_original, -- Saco compensacion
		      @s_monto_compensa = @w_valor_compensa out   
                      if @w_return <> 0
                         return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
		  end
		  
            end
            
	end
	else
	          select @w_com_original = @i_comision_efe + @i_comision_chq + @i_comision_db
	/*REF13 Fin LBP*/

			exec @w_return = cob_remesas..sp_cobro_comision_rc
			   @s_ssn      = @s_ssn,
			   @s_lsrv     = @s_lsrv,
			   @s_srv      = @s_srv,
			   @s_user     = @s_user,
			   @s_sesn     = @s_sesn,
			   @s_term     = @s_term,
			   @s_date     = @s_date,
			   @s_ofi      = @s_ofi,
			   @s_rol      = @s_rol,
			   @s_org      = @s_org,
			   @s_org_err  = @s_org_err, /* Origen de error: [A], [S] */
			   @s_error    = @s_error,
			   @s_sev      = @s_sev,
			   @t_corr     = @t_corr,
			   @t_ssn_corr = @t_ssn_corr, /* Trans a ser reversada */
			   @t_debug    = @t_debug,
			   @t_file     = @t_file,
			   @t_from     = @t_from,
			   @t_rty      = @t_rty,
			   @t_trn      = @w_trn,
			   @i_ubi      = @i_ubi,
			   @i_mon      = @i_mon,
			   @i_opcion   = "T",
			   @i_servicio = @w_servicio,
			   @i_causal   = @w_causal_com,   -- Causa debito comision IBK
			   @i_codigo   = @w_cod_referencia, --REF 7
			   @i_efectivo = @i_comision_efe,
			   @i_cheque   = @i_comision_chq,
			   @i_debito   = @i_comision_db,
			   @i_cuenta   = @i_cuenta,
			   @i_tipocta  = @i_tipo_cta,
			   @i_canal    = @i_canal,
			   @i_nomb_tramite = @i_nomb_tramite , --Ref010:msilvag 
			   @i_tsn      = @i_tsn     --Ref012:msilvag 

			if @w_return != 0
			begin

				  exec cobis..sp_cerror
				  @t_debug  = @t_debug,
				  @t_file   = @t_file,
				  @t_from   = @w_sp_name,
                  @i_sev    = 1 , --msilvag prueba
                  @i_num    = @w_return --035000
			 return 1
			end

    --INI REF3 - IVA
    --  busqueda de la tasa del iva parametrizada en el person
    exec  @w_return = cob_pagos..sp_verif_genera_costo
          @s_date         = @s_date,
          @i_mon          = @i_mon,
          @i_rubro        = 'IVA',
          @i_servicio     = @w_servicio_costo, -- REF 14
          @i_canal        = @i_canal, --REF 7
          @i_tipocta      = '3',
          --@i_cuenta       = @i_cuenta,
          @o_costo        = @w_tasa out

          if @w_return <> 0
          begin
             if @@trancount > 0
                rollback tran
              return @w_return
          end

   ---print '@w_tasa %1!,' ,@w_tasa
   
    if @w_tasa > 0
    begin
          /*REF13 Inicio LBP*/
          if @w_valor_compensa > 0 and @w_aplica_des = 'S' and (@i_canal = 'CNB' or @i_canal = 'VEN')
          begin
             
              -- llamar al sp que retorna el valor del iva ----
              exec @w_return = cob_cuentas..sp_cal_impuesto
                   @i_tasa         = @w_tasa,
                   @i_valor_serv   = @w_com_original,  -- Comision Original al 14
                   @o_base_imp     = @w_base_imp out,
                   @o_impuesto     = @w_impuesto2 out
             
              select @o_base_imp = @w_base_imp,
                     @o_impuesto = @w_impuesto2,
                     @o_tasa     = @w_tasa
                 
	        --print '@o_base_imp %1!,' ,@o_base_imp
                 --print '@o_impuesto %1!,' ,@o_impuesto

              if @w_return <> 0
              begin
                  if @@trancount > 0
                     rollback tran
                  return @w_return
              end
          
          end
          else
          begin
          /*REF13 Fin LBP*/
    
              -- llamar al sp que retorna el valor del iva ----
              exec @w_return = cob_cuentas..sp_cal_impuesto
                   @i_tasa         = @w_tasa,
                   @i_valor_serv   = @i_comision_tot,
                   @o_base_imp     = @w_base_imp out,
                   @o_impuesto     = @w_impuesto2 out
             
              select @o_base_imp = @w_base_imp,
                     @o_impuesto = @w_impuesto2,
                     @o_tasa     = @w_tasa
                 
	        --print '@o_base_imp %1!,' ,@o_base_imp
                 --print '@o_impuesto %1!,' ,@o_impuesto

              if @w_return <> 0
              begin
                  if @@trancount > 0
                     rollback tran
                  return @w_return
              end
              
          end -- Fin @w_valor_compensa > 0 LBP
    end
    else
           select @o_base_imp = @i_comision_tot, @o_impuesto = 0 , @o_tasa= 0 --Ref012:msilvag --smerino
          --select @w_base_imp = @i_comision_tot, @w_impuesto2 = 0

                 
    if @w_base_imp > 0
    begin
         /*REF13 Inicio LBP*/
         if (@i_canal = 'CNB' or @i_canal = 'VEN') and @w_aplica_des = 'S' and @w_valor_compensa > 0
         begin
              --insert la trx del iva 3497 para cobro de la comision ---
              exec @w_return = cob_cuentas..sp_cont_impuesto
                   @t_trn       = 3497 ,
                   @s_ssn       = @s_ssn,
                   @s_date      = @s_date,
                   @t_corr      = @t_corr,
                   @t_ssn_corr  = @t_ssn_corr,
                   @s_user      = @s_user,
                   @s_term      = @s_term,
                   @s_ofi       = @w_ofi, -- Oficina Damnificado REF13 LBP
                   @t_rty       = @t_rty,
                   @s_org       = @s_org,
                   @i_base_imp  = @w_base_imp,
                   @i_iva       = @w_impuesto2,
                   @i_total     = @w_com_original, -- Comision Original al 14
                   @i_cau       = @w_servicio,
                   @i_cta       = @v_num_operacion, --REF: 16 --@w_cod_referencia, --REF 7
                   @i_mon       = @i_mon,   --Moneda
                   @i_oficina_cta = @w_ofi, -- Oficina Damnificado REF13 LBP
                   @i_ubi       = @i_ubi,
                   @i_canal     = @i_canal,
                   @i_cta_deb   = @i_cuenta -- REF13 LBP se agrega cuenta

              if @w_return <> 0
              begin
                  if @@trancount > 0
                     rollback tran
                  return @w_return
              end
         end
         else
         begin
         /*REF13 Fin LBP*/
              --insert la trx del iva 3497 para cobro de la comision ---
              exec @w_return = cob_cuentas..sp_cont_impuesto
                   --@t_trn       = 3497 , -- REF 14
                   @t_trn       = @w_trx_iva, --REF 14
                   @s_ssn       = @s_ssn,
                   @s_date      = @s_date,
                   @t_corr      = @t_corr,
                   @t_ssn_corr  = @t_ssn_corr,
                   @s_user      = @s_user,
                   @s_term      = @s_term,
                   @s_ofi       = @s_ofi,
                   @t_rty       = @t_rty,
                   @s_org       = @s_org,
                   @i_base_imp  = @w_base_imp,
                   @i_iva       = @w_impuesto2,
                   @i_total     = @i_comision_tot,
                   @i_cau       = @w_servicio,
                   @i_cta       = @v_num_operacion,  --REF: 16 --@w_cod_referencia, --REF 7
                   @i_mon       = @i_mon,   --Moneda
                   @i_oficina_cta = @s_ofi,
                   @i_ubi       = @i_ubi,
                   @i_canal     = @i_canal

              if @w_return <> 0
              begin
                  if @@trancount > 0
                     rollback tran
                  return @w_return
              end
         end -- Fin @w_aplica_des = 'S' LBP
     end
     --FIN REF3 - IVA

end --if @i_comision > 0

    --Ref012:msilvag Envio de Notificacion
    --if  @i_canal = 'CNB' and @i_debito <> 0
    if  @i_debito <> 0
    begin
        if @i_canal = 'ATM'
		select @w_desc_canal = 'VEINTI4EFECTIVO'
	if @i_canal = 'DBA'
		select @w_desc_canal = 'AUTOMATICO'
	if @i_canal = 'IBK'
		select @w_desc_canal = '24online'  
	if @i_canal = 'IVR'
		select @w_desc_canal = 'VEINTI4FONO'
	if @i_canal = 'KSK'
		select @w_desc_canal = 'PUNTOVEINTI4'
	if @i_canal = 'VEN'
		select @w_desc_canal = 'VENTANILLA'
	if @i_canal = 'WAP'
		select @w_desc_canal = 'WAP'
	if @i_canal = 'CNB'
        	select @w_desc_canal = 'CNB'
        -- REF26 JRO	
        if @i_canal = 'SAT'
        	select @w_desc_canal = 'SAT'
        -- REF26 JRO	
        
        if @i_tipo_cta = 'AHO' --@w_producto = 4 
        begin  
            select @w_cliente = ah_cliente,
                @w_categoria = ah_categoria ,
                @w_nombre_cta = substring(ah_nombre,1,32)
            from cob_ahorros..ah_cuenta
            where ah_cta_banco = @i_cuenta
            
            select @w_producto = 4 
        end
        else
        begin
            select @w_cliente = cc_cliente,
                @w_categoria = cc_categoria ,
                @w_nombre_cta = substring(cc_nombre,1,32)
            from cob_cuentas..cc_ctacte
            where cc_cta_banco = @i_cuenta
            
            select @w_producto = 3
        end
        
        select @w_valor_debito = convert(varchar(11),@i_debito)
        
        
	if @i_empresa in ('1707','1708','6951','6952')
	    begin
		select @w_desc_empresa ='ETAPA' , @w_servicio_desc = 'ETAPA' --, @w_motivo = 'SERVICIOS PUBLICOS ETAPA'

		if @i_empresa = '1707'
		    select @w_motivo = 'TELEFONIA',@o_tipo_serv = 'TELEFONO'
		else
		   if @i_empresa = '1708'
		       select @w_motivo = 'AGUA', @o_tipo_serv = 'AGUA'
		    else
			if @i_empresa = '6951'
			    select @w_motivo = 'TV PAGADA', @o_tipo_serv = 'TV PAGADA'
			else
			    select @w_motivo = 'INTERNET', @o_tipo_serv = 'INTERNET'
	    end    
	    else
		if @i_empresa = '6388'
		    select @w_desc_empresa ='ATM' , @w_servicio_desc = 'VEHICULO - ATM' , @w_motivo = 'PAGOS ATM - VEHICULOS', @o_tipo_serv = 'FACTURA'
		else
		   if @i_empresa = '7256'
		     select @w_desc_empresa ='BELCORP' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else   
		   if @i_empresa = '5488'
		     select @w_desc_empresa ='DIRECTVPOSTPAGO' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else   
		   if @i_empresa = '8461'
		     select @w_desc_empresa ='TELETAG' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'RECARGA'
		else
		    if @i_empresa = '6087'
			select @w_desc_empresa ='ECOTEC' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else
		    if @i_empresa = '1125'
			select @w_desc_empresa ='UESS' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else
		    if @i_empresa = '5994'
			select @w_desc_empresa ='CLARO TV SATELITAL' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else /* INI REF27 */
		    if @i_empresa = '1089'
			select @w_desc_empresa ='NETLIFE' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else
		    if @i_empresa = '8090'
			select @w_desc_empresa ='UTPL' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'PAGOS FACT.', @o_tipo_serv = 'FACTURA'
		else /* INI REF28 */
		    if exists(select c.codigo 
				from cobis..cl_catalogo c inner join cobis..cl_tabla t
				     on c.tabla = t.codigo 
			     where c.codigo = @i_empresa 
			     and t.tabla = 'sv_emp_grupotvcable'
			     and c.estado = 'V') /* FIN REF28 */
			select @w_desc_empresa ='XTRIM' , @w_servicio_desc = 'FACTURA' , @w_motivo = 'FACTURA', @o_tipo_serv = 'FACTURA' /*<REF 1>*/
		else /* FIN REF27 */
		    select @w_desc_empresa ='SERVICIOS VARIOS' , @w_servicio_desc = 'PAGO FACT.', @w_motivo = 'SERVICIOS VARIOS'


            exec  @w_return = cob_pagos..sp_consulta_celular
                @i_cliente = @w_cliente,
                @o_celular = @w_telefono  out,
		@o_correo=@w_correo  out
	    if @w_return <> 0
	    begin
		if @@trancount > 0
		    rollback tran

		return @w_return
	    end


	--ini ref24    
	if exists(select c.codigo from cobis..cl_catalogo c inner join cobis..cl_tabla t
			on c.tabla = t.codigo 
		 where c.codigo = @i_empresa 
		 and t.tabla = 'sv_empresas_latinia'
		 and c.estado = 'V' )
        begin 
		if @t_corr = 'N'
		begin
			select @w_desc_servicio = 'PAGSB', @w_ssn = @s_ssn
		end
		else
		begin
			select @w_desc_servicio = 'PAGSR', @w_ssn = @t_ssn_corr
		end	    
	    
	   select @o_servicio_not = @w_desc_servicio,
	       @o_nomb_ente = @w_nombre_cta,
	       @o_cod_ente =  convert(varchar(20),@w_cliente) ,
	       @o_desccanal = @w_desc_canal,         	       
	       @o_celular = @w_telefono,
	       @o_correo  = @w_correo,
	       @o_desc_empresa = @w_desc_empresa,
	       @o_prod_deb = @i_tipo_cta,
	       @o_valor = @w_valor_debito,
	       @o_fecha_deb = @w_fecha_hoy,
	       @o_hora_deb = @w_hora_sys,
	       @o_valor_comi = convert(varchar, @i_comision_tot),
	       @o_valor_tot =  convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @i_comision_tot))  ,
	       @o_cta_lat = substring(@i_cuenta,8,3)
	       
	       
	   end
	   else
	   begin
		
		if @i_canal ='CNB'
		begin	 
			if @t_corr = 'N'
			begin
				select @w_desc_servicio = 'PAGCN', @w_ssn = @s_ssn
			end
			else
			begin
				select @w_desc_servicio = 'PGCRN', @w_ssn = @s_ssn --@t_ssn_corr
			end
		end
		else
		begin
			if @t_corr = 'N'
			begin
				select @w_desc_servicio = 'PAGSB', @w_ssn = @s_ssn
			end
			else
			begin
				select @w_desc_servicio = 'PAGSR', @w_ssn = @t_ssn_corr
			end	    
		end
	    
            exec  @w_return = cob_internet..sp_eventos
                @i_operacion      = 'I',
                @i_fecha          = @w_fecha_hoy , --@w_fecha_deb,
                @i_retardo        = 'S',
                @i_fecha_tope     = @s_date  , --@w_fecha_proc,
                @i_cliente        = @w_cliente,
                @i_servicio       = @w_desc_servicio,
                @i_producto       = @w_producto,
                @i_prod_deb       = @i_tipo_cta , --@w_tipo_Cta ,
                @i_cuenta         = @i_cuenta,
                @i_empresa        = @w_desc_empresa,
                @i_desc_servicio  = @w_servicio_desc  ,  --'POSTPAGO',
                @i_nombre         = @w_nombre_cta , --@o_nomcta,
                @i_planilla       = @i_cod_cliente , --@i_matricula,
                @i_valor          = @w_valor_debito,
                @i_canal          = @i_canal,
                @i_desc_canal     = @w_desc_canal,
                @i_ssn            = @w_ssn,
                @i_categoria_cta  = @w_categoria,      
                @i_mail           = @w_correo , 
                @i_telefono       = @w_telefono,  
                @i_motivo         = @w_motivo,  --'TVCABLE POSTPAGO'
		@i_valor1	  = @w_hora_sys
				
            if @w_return <> 0
            begin
                rollback tran
                return @w_return
            end
        
        end --if exists
        ----fin ref24 
       
    end    
    --Ref012:msilvag fin


  if @i_canal = 'VEN'
  begin
            exec @w_return = cob_remesas..sp_upd_totales_rc
                 @i_ofi            = @s_ofi,
                 @i_rol            = @s_rol,
                 @i_user           = @s_user,
                 @i_producto       = 'CTE',
                 @i_mon            = @i_mon,
                 @i_ubi            = @i_ubi,
                 @i_trn            = @t_trn,
                 @i_nodo           = @s_srv,
                 @i_tipo           = 'L',
                 @i_corr           = @t_corr,
                 @i_efectivo       = @i_efectivo,
                 @i_cant_chq       = @i_cant_cheques,
                 @i_cheque         = @i_cheque,
                 @i_tipocta        = @i_tipo_cta,
                 @i_otros          = @i_debito,
                 @i_retencion      = 0,
                 @i_causa          = @i_empresa
            if @w_return != 0
               begin
                  if @i_aplcobis = 'S'
                  begin
                     exec cobis..sp_cerror
                          @t_debug         = @t_debug,
                          @t_file          = @t_file,
                          @t_from          = @w_sp_name,
                          @i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                          @i_num           = 111111
                     return 1
                  end
                  else
                     return 37609
               end
   end

if @t_trn = 3925
   select @o_horario = 'N'
else
   select @o_horario = 'D'

select @o_fact_elect =   @w_fact_elect
select @o_fecvensri =    @w_fecha_validez
select @o_autorisri =    @w_nautorizacion
select @o_nota_venta =   @w_nro_factura
select @o_ssn        =   @s_ssn
--select @o_cod_pre_autorizacion  = @i_cod_pre_autorizacion
select @o_mensaje_respuesta = @i_cod_respuesta
--select @o_nombre_suscrip        = @i_nombre_cliente
select @o_fec_ini_vig_aut = @w_fec_ini_vig_aut /*  smerino*/
select @o_fec_fin_vig_aut = @w_fec_fin_vig_aut /*  smerino*/


if (@i_canal = 'IBK' or @i_canal = 'KSK')
begin
    select "results_submit_rpc",
        r_fecha_contable        = @o_fecha_contable,
        r_ssn                    = @o_ssn,
        r_autorisri             = @o_autorisri,
        r_fecvensri             = @o_fecvensri,
        r_nota_venta            = @o_nota_venta,
        r_fact_elect            = @o_fact_elect,
        --r_cod_pre_autorizacion  = @o_cod_pre_autorizacion,
        r_cod_autorizacion      = @i_cod_respuesta,
        r_nombre_suscrip        = @i_nombre_cliente,
        r_fecdessri             = @o_fecdessri
end




return 0


go
if exists(select 1 from sysobjects where name='sp_pago_servicios_varios' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_pago_servicios_varios *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_pago_servicios_varios -- ERROR -- >>>'
go
grant execute on sp_pago_servicios_varios to apl_osb_hpact
--grant execute on sp_pago_servicios_varios to apl_osb_hpdes
go


