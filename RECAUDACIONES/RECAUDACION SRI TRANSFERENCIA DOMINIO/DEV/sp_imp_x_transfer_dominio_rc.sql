create proc sp_imp_x_transfer_dominio_rc (
   @s_ssn           int,
   @s_lsrv          varchar(30),
   @s_srv           varchar(30),
   @s_user          varchar(30),
   @s_sesn          int=null,
   @s_term          varchar(10),
   @s_date          datetime,
   @s_ofi           smallint,
   @s_rol           smallint,
   @s_org_err       char(1) = null,
   @s_error         int = null,
   @s_sev           tinyint = null,
   @s_org           char(1),
   @t_corr          char(1) = 'N',
   @t_ssn_corr      int = null,
   @t_debug         char(1) = 'N',
   @t_file          varchar(14) = null,
   @t_from          varchar(32) = null,
   @t_rty           char(1) = 'N',
   @t_trn           int,
   @p_lssn          int = null,
   @p_rssn          int = null,
   @p_rssn_corr     int = null,
   @i_opcion        char = 'C',
   @i_matricula     varchar(13) = null,        -- Matricula del Vehículo
   @i_efe           money = 0,          -- Valor en Efectivo
   @i_cant_chq      int = 0, -- RCA 26/May/2003
   @i_cheq          money = 0,          -- Valor en Cheque
   @i_tipocta       varchar(3) = null,      -- Tipo de Cta.
   @i_cuenta        varchar(10) = null,     -- No. de Cta. Banco
   @i_deb           money = 0,          -- Valor del Debito
   @i_tarjeta       money = 0,          -- Valor de la tarjeta de Credito
   @i_total         money = 0,          -- Total del Pago
   @i_mon           tinyint = 1,
   @i_autoriza      char(1) = 'N',          -- Autorizante para la Concep.
   @i_tsn           int     = null,
   @i_ubi           int     = null,    --- ame  11/04/2003
   @i_efe_com       money = 0,      --- ps 27/01/2004
   @i_chq_com       money = 0,      --- ps 27/01/2004
   @i_deb_com       money = 0,      --- ps 27/01/2004
   @i_tipocta_com   char(3) = null, --- ps 27/01/2004
   @i_cta_com       cuenta = null,   --- ps 27/01/2004
   -->hy-26-sep-2005
   @i_nomprop       descripcion = null,
   @i_nomcta        descripcion = null,
   @i_compro        int = null,
   @i_motor         varchar(25) = null,
   @i_chasis        varchar(25) = null,
   @i_periodo       varchar(16) = null,
   @i_fisco         money  = null,
   @i_avaluo        money = null,
   @i_valor         money = null,
   @i_cedruc        numero = null,
   @i_fecha_contrato datetime = null out,
   --<hy-26-sep-2005
   @o_nomprop       descripcion = null out,
   @o_nomcta        descripcion = null out,
   @o_total         money       = null out,
   @o_compro        int         = null out,
   @o_motor         varchar(25) = null out,
   @o_chasis        varchar(25) = null out,
   @o_periodo       varchar(16) = null out,
   @o_fisco         money       = null out,
   @o_avaluo        money       = null out  ,
   @o_valor         money       = null out,
   @o_cedruc        numero      = null out,
   @o_fecha_contrato datetime   = null out,
   @o_ssn       int out, -- RCA 10/Jul/2003
   @o_autorisri     varchar(30) = null out, -- ps 27/01/2004
   @o_fecvensri     varchar(30) = null out, -- ps 27/01/2004
   @o_nota_venta    varchar(15) = null out, --hy-24-feb-2005
   -->hy-26-sep-2005
   @i_adminis       money       = 0,
   @i_cod_autor     int         = 0,
   @i_autor         int         = 0,
   @i_propietario   descripcion = null,
   @i_secuencial    int         = 0,
   @i_cod_vehiculo  varchar(13) = null,  --hy-21-nov-2005 antes estaba a 6
   @i_mcn           varchar(8)  = null,
   @i_tranrevsri    varchar(30) = null,  --fmv-14-mar-2006 ampliar LogMonitor
   @i_logrevsri     varchar(30) = null,  --fmv-14-mar-2006 ampliar LogMonitor
   @o_fechora       varchar(16) = ''   out,
   @o_feccontable   varchar(10) = ''   out,
   @o_provincia     varchar(7)  = ''   out,
   @o_secuencial    int         = 0 out,
   @o_cod_cajero    varchar(8)  = null out,
   @o_terminal      varchar(6)  = null out,
   @i_canal         varchar(6) = 'VEN'  --smerino
   --<hy-26-sep-2005
)
as

declare @w_return   int,
   @w_sp_name       varchar(30),
   @w_secuencial    int,
   @w_producto      tinyint,
   @w_ctacte        int,
   @w_filial_cta    tinyint,
   @w_oficina_cta   smallint,
   @w_oficina_cta2  smallint,
   @w_tipo_promedio char(1),
   @w_oficial       smallint,
   @w_opcion        char(1),
   @w_total     money,
   @w_moneda        tinyint,
   @w_hora_original datetime,
   @w_mensaje       varchar(80),
   @w_maximo_p      money,
   @w_fecha     datetime,
   @w_saldo_para_girar money,
   @w_saldo_contable money,
   @w_horario   char(1),      --- ame 11/17/2003
   @w_trn            int ,    -- ps 27/01/2004
   @w_servicio       varchar(6),    -- ps 27/01/2004
   @w_com          money,
   @w_serie           varchar(6),  -- hy-24-feb-2005
   @w_secuencian      int,         -- hy-24-feb-2005
   @w_secuenciac      varchar(7),  -- hy-24-feb-2005
   -->hy-26-sep-2005
   @w_fec_comp         datetime,
   @w_codigo_usuario   smallint,
   @w_codigo_usuario1  varchar(8),
   @w_fechora      datetime,
   @w_hh           varchar(2),
   @w_mm           varchar(2),
   @w_ss           varchar(2),
   @w_ms           varchar(2),
   @w_s_ofi        varchar(3),
   --smerino
   @w_tasa         float,
   @w_base_imp     money,
   @w_impuesto2    money,
   /*REF19 Inicio LBP */ 
   @w_valor_compensa   money,
   @w_comi_total       money,
   @w_com_original     money,
   @w_aplica_des       char(1),
   /*REF19 Fin LBP */ 
    --Ref020:msilvag Inicio
    @w_causa        varchar(5),
    @w_causa_com    varchar(5),
    @w_rowcount     int
    --Ref020:msilvag Fin



   --<hy-26-sep-2005


/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_imp_x_transfer_dominio_rc'


select @w_fecha = convert(varchar(10),@s_date,101),
       @o_ssn = @s_ssn  -- RCA 10/Jul/2003

-->hy-26-sep-2005
if @i_opcion = 'L'
begin
   select @w_fechora     = getdate()
   select @w_hh          = convert(varchar(2),datepart(hh,@w_fechora))
   select @w_hh          = replicate('0',2-datalength(@w_hh)) + @w_hh
   select @w_mm          = convert(varchar(2),datepart(mm,@w_fechora))
   select @w_mm          = replicate('0',2-datalength(@w_mm)) + @w_mm
   select @w_ss          = convert(varchar(2),datepart(ss,@w_fechora))
   select @w_ss          = replicate('0',2-datalength(@w_ss)) + @w_ss
   select @w_ms          = convert(varchar(2),datepart(ms,@w_fechora)/10)
   select @w_ms          = replicate('0',2-datalength(@w_ms)) + @w_ms
   select @o_fechora     = convert(varchar(8),@w_fechora,112) + @w_hh + @w_mm + @w_ss + @w_ms
   --Fecha contable
   select @o_feccontable = convert(varchar(10),@w_fechora,101)
   select @w_s_ofi = of_provincia
   from cobis..cl_oficina
   where of_oficina = @s_ofi
   select @o_provincia = b.valor
   from cobis..cl_tabla a, cobis..cl_catalogo b
   where a.tabla  = 'cl_prov_matsri'
     and a.codigo = b.tabla
     and b.estado = 'V'
     and b.codigo = @w_s_ofi
   select @o_terminal = @s_term
   return 0
end
--<hy-26-sep-2005

-->hy-21-sep-2005
--Por un caso extremo se realiza esta validación aqui en el sp
if @i_total <> @i_efe + @i_cheq + @i_deb + @i_tarjeta
begin
   exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_num    = 072174,
        @i_msg    = 'VALORES DE PAGO NO CUADRAN - VUELVA A REALIZAR LA TRANSACCION'
   return 1
end
--<hy-21-sep-2005

-- Valida montos de ingreso
if @i_autoriza = 'N' and  @t_corr = 'N'                                 -- RE 05/MAY/2000
begin
   select @w_maximo_p = pa_money
     from cobis..cl_parametro
    where pa_nemonico = 'MSVP'
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

if @t_trn = 3295              --- ame 11/17/2003
   select @w_horario = "N"
else
   select @w_horario = "D"


/***************   FECHA Y AUTORIZACION DEL SRI ********************/ -- ps 27/01/2004

Select @o_fecvensri = pa_char
from cobis..cl_parametro
where pa_nemonico = 'FECVAL'
  and pa_producto = 'CTE'

select @o_autorisri = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NUMAUT'
  and pa_producto = 'CTE'

select @w_com = @i_efe_com +  @i_chq_com +   @i_deb_com

/*******************************************************************/


if @i_opcion <> 'C'
begin
   /* Valida si se ha aperturado caja */
   -- RCA 26/May/2003
   exec @w_return = cob_remesas..sp_verifica_caja_rc
       @s_ssn   = @s_ssn,
       @s_srv   = @s_srv,
       @s_lsrv  = @s_lsrv,
       @s_user  = @s_user,
       @s_sesn  = @s_sesn,
       @s_term  = @s_term,
       @s_date  = @s_date,
       @s_ofi   = @s_ofi,
       @s_rol   = @s_rol,
       @s_sev   = @s_sev,
       @s_msg   = "",
       @s_org   = @s_org,
       @t_trn   = @t_trn,
       @t_corr  = @t_corr,  --- ame 11/21/2003
       @i_mon   = @i_mon,
       @i_ubi   = @i_ubi    --- ame  11/04/2003
        if @w_return != 0
           return @w_return

end

--hy-26-sep-2005 comentar este párrafo
/*
if @t_corr = "N"
   begin

    select @w_opcion    =   @i_opcion,
               @w_hora_original = getdate()

    exec @w_return = cobis..sp_cseqnos
             @t_debug  = @t_debug,
             @t_file      = @t_file,
             @t_from   = @w_sp_name,
             @i_tabla  = 'sv_transf_dominio',
             @o_siguiente = @w_secuencial out
        if @w_return != 0
           return @w_return
   end

else */
if @t_corr <> "N"
   begin
        select @w_opcion = 'R'
        select @w_secuencial = td_secuencial,
               @w_hora_original = td_hora
          from cob_servicios..sv_transf_dominio (INDEX  sv_transf_dominio_Key)
         where td_matricula = @i_matricula
       and td_estado = 'P'
    if @@rowcount = 0
           begin
              exec cobis..sp_cerror
                   @t_debug  = @t_debug,
                   @t_file   = @t_file,
                   @t_from   = @w_sp_name,
                   @i_num    = 072174,
                   @i_msg    = 'NO EXISTE RECAUDACION PARA ESTA MATRICULA.'
              return 1
            end
   end

if @i_tipocta = 'CTE'
   select @w_producto = 3
else
   select @w_producto = 4


if @w_opcion <> 'C' and @i_deb > 0
begin
   if @w_producto = 3
   begin
      /*  Determinacion de vigencia de cuenta  */
      exec @w_return = cob_cuentas..sp_cta_vigente
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_cta_banco    = @i_cuenta,
           @i_moneda       = 1,
           @i_tran         = @t_trn,
           @o_cuenta       = @w_ctacte out,
           @o_filial       = @w_filial_cta out,
           @o_oficina      = @w_oficina_cta out,
           @o_tipo_promedio= @w_tipo_promedio out,
           @o_oficial      = @w_oficial out
      if @w_return != 0
           return @w_return


      if @i_deb <> 0 and @t_corr = "N"
        begin
         exec @w_return = cob_cuentas..sp_calcula_saldo
                 @t_debug            = @t_debug,
                 @t_file             = @t_file,
                 @t_from             = @w_sp_name,
                 @i_cuenta           = @w_ctacte,
                 @i_fecha            = @w_fecha,
                 @i_ofi              = @w_oficina_cta,
                 @o_saldo_para_girar = @w_saldo_para_girar out,
                 @o_saldo_contable   = @w_saldo_contable out
             if @w_return <> 0
        return @w_return

             if @i_deb > @w_saldo_para_girar
        begin
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                    @i_num    = 031017
               return 1
                end
        end

   end
   else
   begin
      /*  Determinacion de vigencia de cuenta  */
      exec @w_return = cob_ahorros..sp_ctah_vigente
           @t_debug        = @t_debug,
           @t_file         = @t_file,
           @t_from         = @w_sp_name,
           @i_cta_banco    = @i_cuenta,
           @i_moneda       = 1,
           @i_tran         = @t_trn,
           @o_cuenta       = @w_ctacte out,
           @o_filial       = @w_filial_cta out,
           @o_oficina      = @w_oficina_cta out,
           @o_tipo_promedio= @w_tipo_promedio out,
           @o_oficia       = @w_oficial out
      if @w_return != 0
         return @w_return


      if @i_deb <> 0 and @t_corr = "N"
         begin

        exec @w_return = cob_ahorros..sp_ahcalcula_saldo
                 @t_debug            = @t_debug,
                 @t_file             = @t_file,
                 @t_from             = @w_sp_name,
                 @i_cuenta           = @w_ctacte,
                 @i_fecha            = @w_fecha,
                 @i_ofi              = @w_oficina_cta,
                 @o_saldo_para_girar = @w_saldo_para_girar out,
                 @o_saldo_contable   = @w_saldo_contable out
        if @w_return <> 0
               return @w_return

            if @i_deb > @w_saldo_para_girar
        begin
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                    @i_num    = 031017
               return 1
                end

         end

   end
end

-->hy-26-sep-2005
--A partir de este instante el procedimiento de enlace a banred queda
--inhabilitado ya que su conexión se ejecutará desde el front-end
--mediante un switch distinto
/* Rutina de Enlace con BanRed */
/*exec @w_return  = cob_servicios..sp_tr_comunicacion_isobanred
     @s_ssn     = @s_ssn,
     @s_lsrv    = @s_lsrv,
     @s_srv     = @s_srv,
     @s_rol     = @s_rol,
     @s_ofi     = @s_ofi,
     @s_user    = @s_user,
     @s_term    = @s_term,
     @s_date    = @s_date,
     @s_org     = @s_org,
     @t_corr    = @t_corr,
     @t_debug   = @t_debug,
     @t_trn     = 3295,       ---  ame 11/17/2003 @t_trn,
     @i_tipotran = @w_opcion,
     @i_codigo  = @i_matricula,
     @i_secuencial = @w_secuencial,
     @i_moneda  = 1,
     @i_total   = @i_total,
     @i_hora_original = @w_hora_original,
     @i_horario  = @w_horario,              --- ame 11/17/2003
     @o_avaluo  = @o_avaluo out,
     @o_valor   = @o_valor out,             -- Valor de Compra/Venta
     @o_cedruc  = @o_cedruc out,            -- Cedula/Ruc del Comprador
     @o_fecha_contrato = @o_fecha_contrato out,     -- GYC 2002/ABR/08
     @o_nomprop = @o_nomprop out,
     @o_total   = @o_total out

if @w_return != 0
begin

   select @w_sp_name = 'sp_tr_comunicacion_isobanred'
   select @w_mensaje = 'ERROR DESCONOCIDO'

   select @w_mensaje = b.valor
   from cobis..cl_tabla a,
   cobis..cl_catalogo b
   where a.tabla = "sv_error_isoban"
     and a.codigo = b.tabla
     and convert(int,b.codigo) = @w_return


   if @w_return = 551
   begin
      if @w_opcion = 'P'
      begin
        exec @w_return  = cob_servicios..sp_tr_comunicacion_isobanred
             @s_ssn             = @s_ssn,
             @s_lsrv            = @s_lsrv,
             @s_srv             = @s_srv,
             @s_rol             = @s_rol,
             @s_ofi             = @s_ofi,
             @s_user            = @s_user,
             @s_term            = @s_term,
             @s_date            = @s_date,
             @s_org             = @s_org,
             @t_corr            = @t_corr,
             @t_debug           = @t_debug,
             @t_trn             = 3295,        ---  ame 11/17/2003 @t_trn,
             @i_tipotran        = 'F',
             @i_codigo          = @i_matricula,
             @i_secuencial      = @w_secuencial,
             @i_moneda          = 1,
             @i_total           = @i_total,
             @i_hora_original   = @w_hora_original,
             @i_horario         = @w_horario,           --- ame 11/17/2003
             @o_avaluo      = @o_avaluo out,
                 @o_valor       = @o_valor out,
                 @o_cedruc      = @o_cedruc out,
             @o_fecha_contrato  = @o_fecha_contrato out,
             @o_nomprop         = @o_nomprop out,
             @o_total           = @o_total out
      end
      select @w_mensaje = 'ERROR DE COMUNICACION CON BANRED. INTENTE EN UNOS MINUTOS'
   end
   exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_num    = 30125,
        @i_msg    = @w_mensaje
   return @w_return
end
*/ --<hy-26-sep-2005

begin tran

-->hy-26-sep-2005
if @t_corr = "N"
begin
   select @w_secuencial = convert(int,@i_mcn)
   insert into cob_servicios..sv_transf_dominio
   (td_estado, td_matricula, td_secuencial, td_fecha, td_hora,
    td_moneda, td_monto, td_fisco, td_valor_contra, td_valor_avaluo,
    td_ced_ruc, td_fecha_compe, td_codig_autor, td_autorizadora, td_codig_error,
    td_operador, td_efectivo, td_cheque, td_tipocta, td_cta_banco,
    td_notadebito, td_tarjeta, td_fecha_contrato, td_horario)
   values
   ('I', @i_matricula, @w_secuencial, @s_date, getdate(),
    1, @i_fisco, @i_fisco, @i_valor, @i_avaluo,
    @i_cedruc, @s_date, @w_secuencial, 0, 0,
    @s_user, @i_efe, @i_cheq, @w_producto, @i_cuenta,
    @i_deb, @i_tarjeta, @s_date, @w_horario)
end
--<hy-26-sep-2005

if @w_opcion <> 'C' and @i_deb <> 0
begin
   if @w_producto = 3
   begin
      select @o_nomcta = cc_nombre
        from cob_cuentas..cc_ctacte
       where cc_cta_banco = @i_cuenta

        --Ref020:msilvag Inicio
        select @w_causa = isnull(b.valor,'')
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = 'causa_nd_cte_servicios'
        and a.codigo = b.tabla
        and b.codigo = '9718'
        and estado = 'V'
        if @@rowcount = 0
            select @w_causa = '834'
        --Ref020:msilvag Fin
        
      exec @w_return = cob_cuentas..sp_ccndc_automatica
           @s_srv  = @s_srv,
           @s_ofi  = @s_ofi,  --hy-16-julio-2007 antes @w_oficina_cta
           @s_ssn  = @s_ssn,
           @s_user = @s_user,
           @s_term = @s_term,
           @t_corr = @t_corr,
           @t_trn  = 3050,
           @i_cta  = @i_cuenta,
           @i_val  = @i_deb,
           @i_cau  = @w_causa , --Ref020:msilvag '834',
           @i_mon  = 1,
           @i_fecha = @s_date,
           @s_rol          = @s_rol,
           @i_ubi   = @i_ubi,    --- ame  11/04/2003
           @i_tsn   = @i_tsn,    --- ame  11/04/2003
           @o_oficina_cta = @w_oficina_cta2 out
   end
   else
   begin
      select @o_nomcta = ah_nombre
        from cob_ahorros..ah_cuenta
       where ah_cta_banco = @i_cuenta
       
        --Ref020:msilvag Inicio
        select @w_causa = isnull(b.valor,'')
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = 'causa_nd_aho_servicios'
        and a.codigo = b.tabla
        and b.codigo = '9718'
        and estado = 'V'
        if @@rowcount = 0
            select @w_causa = '834'
        --Ref020:msilvag Fin
        
       exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv  = @s_srv,
           @s_ofi  = @s_ofi,  --hy-16-julio-2007 antes @w_oficina_cta
           @s_ssn  = @s_ssn,
           @s_user = @s_user,
           @s_term = @s_term,
           @t_trn  = 4272,
           @t_corr = @t_corr,
           @i_cta  = @i_cuenta,
           @i_val  = @i_deb,
           @i_cau  = @w_causa , --Ref020:msilvag '834',
           @i_mon  = 1,
           @i_fecha = @s_date,
           @s_rol          = @s_rol,
           @i_ubi          = @i_ubi,    --- ame  11/04/2003
           @i_tsn          = @i_tsn,    --- ame  11/04/2003
           @o_oficina_cta = @w_oficina_cta2 out
   end
   if @w_return != 0
      return @w_return
end

if @t_corr = "N"
begin
   select @o_nomprop    = ma_descripcion,
          @o_total  = td_monto,
          @o_compro     = td_codig_autor,
          @o_motor  = ma_motor,
      @o_chasis     = ma_chasis,
      @o_fisco  = td_fisco,
      @o_avaluo     = td_valor_avaluo,
      @o_valor  = td_valor_contra,
      @o_fecha_contrato = convert(char(10),td_fecha_contrato,101),
          @o_cedruc     =  td_ced_ruc
     from cob_servicios..sv_transf_dominio (INDEX  sv_transf_dominio_Key), cob_servicios..sv_matriculas_vehiculos
    where td_matricula = @i_matricula
      and td_estado = 'I'
      and ma_matricula = td_matricula


   update cob_servicios..sv_transf_dominio
      set td_estado = 'P',
          td_secuencial = @w_secuencial,
      td_operador = @s_user,
      td_efectivo = @i_efe,
      td_cheque = @i_cheq,
      td_tipocta = @w_producto,
      td_cta_banco = @i_cuenta,
      td_notadebito = @i_deb,
      td_tarjeta = @i_tarjeta
    where td_matricula = @i_matricula
      and td_estado = 'I'
end
else
begin
   select @o_nomprop = ma_descripcion,
          @o_total = td_monto,
          @o_compro = td_codig_autor,
          @o_motor = ma_motor,
      @o_chasis = ma_chasis,
      @o_fisco = td_fisco,
      @o_avaluo = td_valor_avaluo,
      @o_valor  = td_valor_contra,
      @o_cedruc = td_ced_ruc,
      @o_fecha_contrato =convert(char(10), td_fecha_contrato, 101)
     from cob_servicios..sv_transf_dominio, cob_servicios..sv_matriculas_vehiculos
    where td_matricula = @i_matricula
      and ma_matricula = td_matricula
      and td_estado = 'P'

   select @o_nomprop = '(REVERSO) ' + @o_nomprop

   update cob_servicios..sv_transf_dominio
      set td_estado = 'R'
    where td_matricula = @i_matricula
      and td_estado = 'P'
end


if @w_opcion <> 'C'
begin
  /******* INSERTA EL PAGO DE TRANSFERENCIA DE DOMINIO *******/   -- ps 27/01/2004

  if  @i_efe_com > 0 or  @i_chq_com > 0 or   @i_deb_com > 0
      begin
         if @t_trn = 3295
            select  @w_trn = 3366 , @w_servicio ="3"
         else
            select  @w_trn = 3372 , @w_servicio ="3"
            
            
         /*REF19: Inicio LBP */ 
         if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
                   where rs_nemonico = '35'
                   and rs_canal = @i_canal and rs_estado = 'V')  
         begin
     
              select @w_comi_total = isnull(@i_efe_com,0) + isnull(@i_chq_com,0) + isnull(@i_deb_com,0) -- Comision que debe venir del 12%
     
              exec @w_return = cob_pagos..pa_pg_ivalor_comcal
                   @e_valor_comision  = @w_comi_total,
                   @e_oficina         = @s_ofi,
                   @e_empresa         = 35,
                   @e_canal           = @i_canal,
                   @s_valor_com_final = @w_com_original out, -- obtengo comision original al 14%
                   @s_aplica          = @w_aplica_des out
              if @w_return <> 0
                 return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
             
              if @w_aplica_des = 'S'
              begin
                  exec @w_return = cob_gov..pa_iva_pcompensacion
                       @e_oficina        = @s_ofi,
                       @e_monto          = @w_com_original,
                       @s_monto_compensa = @w_valor_compensa out   
              if @w_return <> 0
                 return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
              end
     
         end
         /*REF19: Fin LBP */    
        
        --Ref020:msilvag Inicio
        if @i_tipocta_com = 'CTE'
        begin
            select @w_causa_com = b.valor 
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'causa_nd_comision_servcte'
            and a.codigo = b.tabla
            and b.codigo = '9718'
            and estado = 'V'
            set @w_rowcount = @@rowcount
        end
        else
        begin
            select @w_causa_com = b.valor   
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'causa_nd_comision_servaho'
            and a.codigo = b.tabla
            and b.codigo = '9718'
            and estado = 'V'
            set @w_rowcount = @@rowcount
        end
        if @w_rowcount = 0 or (@w_causa_com = null or @w_causa_com = ' ')
        begin
            select @w_causa_com = '858'
        end
        --Ref020:msilvag Fin
        
         exec @w_return = cob_remesas..sp_cobro_comision_rc
                @s_ssn     = @s_ssn,
                @s_lsrv    = @s_lsrv,
                @s_srv     = @s_srv,
                @s_user    = @s_user,
                @s_sesn    = @s_sesn,
                @s_term    = @s_term,
                @s_date    = @s_date,
                @s_ofi     = @s_ofi,
                @s_rol     = @s_rol,
                @s_org     = @s_org,
                @s_org_err = @s_org_err, /* Origen de error: [A], [S] */
                @s_error   = @s_error,
                @s_sev     = @s_sev,
                @t_corr    = @t_corr,
                @t_ssn_corr= @t_ssn_corr, /* Trans a ser reversada */
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @t_from,
                @t_rty     = @t_rty,
                @t_trn     = @w_trn,
                @i_ubi     = @i_ubi,
                @i_mon     = @i_mon,
                @i_opcion  = "T",
                @i_servicio  = @w_servicio,
                @i_codigo    = @i_matricula,
                @i_efectivo  = @i_efe_com,
                @i_cheque    = @i_chq_com,
                @i_tipocta   = @i_tipocta_com,
                @i_cuenta    = @i_cta_com,
                @i_debito    = @i_deb_com, -- DEBITO A CTAS
                @i_causal    = @w_causa_com --Ref020:msilvag '858'  --smerino

           if @w_return != 0
              begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 035000
                     return 1
              end

             -- smerino busqueda de la tasa del iva parametrizada en el person

     exec @w_return = cob_pagos..sp_verif_genera_costo
        @s_date         = @s_date,
        @i_mon          = @i_mon,
        @i_rubro        = 'IVA',
        @i_servicio     = 'SRI',
        @i_canal        = 'VEN',
        @i_tipocta      = '3',
        @o_costo        = @w_tasa out

      if @w_return <> 0
      begin

         if @@trancount >0
    rollback

    return @w_return

     end

     --print 'tasa %1!', @w_tasa
    -- print 'comision  %1!', @w_com


       if @w_tasa > 0
       begin
           /*REF19: Inicio LBP */ 
           if @w_aplica_des = 'S' and @i_canal = 'VEN'
           begin
           
               -- smerino llamar al sp que retorna el valor del iva ----
               exec @w_return = cob_cuentas..sp_cal_impuesto
                 @i_tasa        = @w_tasa,
                 @i_valor_serv  = @w_com_original, -- Comision Original al 14
                 @o_base_imp    = @w_base_imp out,
                 @o_impuesto    = @w_impuesto2 out

               if @w_return <> 0
               begin
                   if @@trancount >0
                      rollback
                   return @w_return
               end
           
           end
           else
           begin
           /*REF19: Fin LBP */ 
           
               -- smerino llamar al sp que retorna el valor del iva ----
               exec @w_return = cob_cuentas..sp_cal_impuesto
                 @i_tasa        = @w_tasa,
                 @i_valor_serv  = @w_com,
                 @o_base_imp    = @w_base_imp out,
                 @o_impuesto    = @w_impuesto2 out

               if @w_return <> 0
               begin
                   if @@trancount >0
                      rollback
                   return @w_return
               end
            
           end
           
       end
       else
            select @w_base_imp=@w_com,@w_impuesto2=0


     --print 'base %1!', @w_base_imp
     --print 'impuesto  %1!', @w_impuesto2

     if @w_base_imp > 0
     begin
         /*REF19: Inicio LBP */ 
         if @w_aplica_des = 'S' and @i_canal = 'VEN'
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
                  @s_ofi       = @s_ofi,
                  @t_rty       = @t_rty,
                  @s_org       = @s_org,
                  @i_base_imp  = @w_base_imp,
                  @i_iva       = @w_impuesto2,
                  @i_total     = @w_com_original, -- Comision Original al 14
                  @i_cau       = @w_servicio,
                  @i_cta       = @i_matricula,  --referencia
                  @i_mon       = @i_mon,    --Moneda
                  @i_oficina_cta= @s_ofi,
                  @i_ubi       = @i_ubi

             if @w_return <> 0
             begin
                 if @@trancount >0
                    rollback
                 return @w_return
             end
         
         end
         else
         begin
         /*REF19: Fin LBP */ 
         
             --insert la trx del iva 3497 para cobro de la comision ---
             exec @w_return = cob_cuentas..sp_cont_impuesto
                  @t_trn       = 3497 ,
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
                  @i_total     = @w_com,
                  @i_cau       = @w_servicio,
                  @i_cta       = @i_matricula,  --referencia
                  @i_mon       = @i_mon,    --Moneda
                  @i_oficina_cta= @s_ofi,
                  @i_ubi       = @i_ubi

             if @w_return <> 0
             begin
                 if @@trancount >0
                    rollback
                 return @w_return
             end
             
         end -- Fin if @w_aplica_des = 'S' and @i_canal = 'VEN' LBP
         
     end -- Fin if @w_base_imp > 0
 
 end
  /********************************************************/


-->hy-24-feb-2005
--Obtener el numero de serie de nota de venta
if @t_corr = "N"
begin
   Select @w_serie = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'SERNV'
     and pa_producto = 'CTE'
   --Obtener la secuencia de la nota de venta
  /* exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'sv_seq_nota_venta',
        @o_siguiente = @w_secuencian out
   if @w_return != 0
      return @w_return
   --Armar el numero de nota de venta
   select @w_secuenciac = convert(varchar(7),@w_secuencian)
   select @w_secuenciac = replicate('0',7-datalength(@w_secuenciac))+@w_secuenciac
   select @o_nota_venta = substring(@w_serie,1,3)+'-'+substring(@w_serie,4,3)+'-'+@w_secuenciac*/
end
--<hy-24-feb-2005


   -- TRN DE SERVICIO
   insert into cob_cuentas..cc_tran_servicio
       (ts_secuencial, ts_tipo_transaccion, ts_oficina,
        ts_usuario, ts_rol, ts_terminal, ts_correccion,
        ts_reentry, ts_origen, ts_nodo, ts_tsfecha,
        ts_referencia, ts_saldo, ts_ssn_corr,
        ts_moneda, ts_tipo, ts_monto, ts_valor, ts_ocasional,
        ts_tsn, ts_ccontable, ts_hora, ts_endoso,
        ts_cta_asociada, ts_cheque_rec,ts_ubicacion,ts_descuento_iess,  -- RCA 26/May/2003
        ts_campo_alt_uno, --hy-24-feb-2005
        ts_stick_imp, ts_propietario, ts_agente, ts_campo_alt_dos) --hy-26-sep-2005
   values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term, @t_corr,
        null, 'L', @s_lsrv, @s_date, @i_matricula, @i_efe, @t_ssn_corr,
        1, 'L', @i_tarjeta, @i_cheq, @i_deb,@i_tsn, null, getdate(), @o_compro,
        @o_cedruc, @i_cant_chq,@i_ubi,@w_com,
        @o_nota_venta,  --hy-24-feb-2005
        right(@i_cod_vehiculo,12), @i_mcn, @i_tranrevsri, @i_logrevsri) --hy-26-sep-2005

   /* Actualizacion de Totales de cajero */
   exec @w_return = cob_remesas..sp_upd_totales_rc
      @i_ofi            = @s_ofi,
      @i_rol            = @s_rol,
      @i_user           = @s_user,
      @i_producto       = 'CTE',
      @i_mon            = @i_mon,
      @i_ubi            = @i_ubi,    --- ame  11/04/2003
      @i_trn            = @t_trn,
      @i_nodo           = @s_srv,
      @i_tipo           = 'L',
      @i_corr           = @t_corr,
      @i_efectivo       = @i_efe,
      @i_cheque         = @i_cheq,
      -- @i_chq_locales    = @i_deb,     -- RCA 26/May/2003
      -- @i_interes        = @i_tarjeta  -- RCA 26/May/2003
      @i_tipocta    = @i_tipocta,
      @i_otros      = @i_deb,
      @i_tarjetas       = @i_tarjeta,
      @i_cant_chq       = @i_cant_chq

      if @w_return != 0
      begin
         exec cobis..sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 035000
              return 1
      end
end

commit tran

return 0
