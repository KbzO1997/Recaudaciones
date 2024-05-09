use cob_cuentas
go

if exists(select 1 from sysobjects where name = 'sp_procesa_rise' and type = 'P')
begin
   drop procedure dbo.sp_procesa_rise
   if exists (select 1 from sysobjects where name = 'sp_procesa_rise' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_procesa_rise -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_procesa_rise *OK* =='
end
go

/************************************************************************/
/*  Archivo:            ccpgrise.sp                                     */
/*  Stored procedure:   sp_procesa_rise                          		*/
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       German Medina C.                                */
/*  Fecha de escritura: Sep-2008                                        */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECM-784                                 		*/
/*  Ult.Referencia:     REF 15                                          */
/************************************************************************/
/*                                IMPORTANTE                            */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.  */
/************************************************************************/
/*                           PROPOSITO                                  */
/*      Este programa realiza el cobro de servicios para SRI - RISE */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR     RAZON                   		*/
/*   19/Sep/2008   German Medina C.   Emision inicial         		*/
/* 2 26/04/2010    Tania Cumbicus  CTE-CC-8433  Cambio de tipo de dato sec sri */
/* 3 20/Jul/2010   Tania Cumbicus  CTE-6969   Cambio tipo de dato   	*/
/* 4 27/Jul/2010   Tania Cumbicus  CTE-6999  Cambio de tipo de dato sec sri */
/* 5 29/Jul/2010   Ana Mendez      CTE-CC-9249 cambios factura comision  */
/*   13/12/2012    Sandra Merino    CTE-CC-SGC00006244                   */
/* 7 20/01/2014    Daniel Pereira   SGC00012170 Facturacion Electronica  */
/* 8 01/08/2016  Luis Banda Pozo  RECA-CC-SGC00025868 se agrega validacion  */
/*               para obtener descuento de la comision para damnificados*/
/* 9 08/26/2016    smerino          CNBFASEIII SGC00026412              */
/*10 12/Jun/2017   Daniel Pereira  RECA-CC-SGC00028164 comision SRI 24online*/
/*11 09/Abr/2018  María José Silva    Facturación OffLine  SGC00030409  */
/*12  01/13/2020   Pablo Ricaurte         RECM-60 evitar reverso cuando no hay pago de RISE */
/*13  04/May/2020  Daniel Pereira RECMPS-523  Migracion Latinia         */
/*14  03/Dic/2020  Daniel Pereira  RECMPS-526   Comision                */
/*15  06/Oct/2023  Kevin Bastidas  RECM-784   Comision en auxliar RISE*/
/************************************************************************/

create procedure dbo.sp_procesa_rise (
@s_ssn                int,
@s_srv                varchar(30),
@s_lsrv               varchar(30),
@s_user               varchar(30),
@s_sesn               int       = null,
@s_term               varchar(10),
@s_date               datetime,
@s_ofi                smallint,
@s_rol                smallint,
@s_org_err            char(1)       = null,
@s_error              int           = null,
@s_sev                tinyint       = null,
@s_org                char(1),
@s_msg                      char(64)      = null,
@t_corr               char(1)       = 'N',
@t_ssn_corr           int           = null, --Reverso primer corebanking
@t_ssn_corr1          int           = null, --Reverso en Proveedor
@t_ssn_corr2          int           = null, --Reverso en tran_servicio
@t_debug              char(1)       = 'N',
@t_file               varchar(14)   = null,
@t_from               varchar(32)   = null,
@t_rty                char(1)       = 'N',
@t_trn                int,
@i_aplcobis                 char(1)       = 'S',
@i_tsn            int       = null,
@i_mon            tinyint     = 1,
@i_canal          varchar(10)   = null,
@i_operacion          char(1)       = null,
@i_identificacion     varchar(13)   = null,
@i_razon_soc        varchar(64)   = null,
@i_efectivo         money     = 0,
@i_cheque         money     = 0,
@i_debito         money     = 0,
@i_subtotal         money     = 0,
@i_comision_tot       money     = 0, --smerino se registra cdo la coimision es con debito aq cuenta
@i_comision_efe       money     = 0,
@i_comision_chq       money     = 0,
@i_total          money     = 0,
@i_cant_cheques       varchar(3)    = "0",
@i_tipo_cta         varchar(3)    = null,
@i_cuenta         cuenta      = null,
@i_nombre_cta       varchar(64)   = null,
@i_autoriza         varchar(1)    = 'N',
@i_supautor         varchar(10)   = "",
@i_pterminal        varchar(10)   = null,
@i_rubro          varchar(10)   = null,
@i_sucursal         varchar(10)   = null,
@i_comprobante        varchar(10)   = null,
@i_tipoid         varchar(10)   = null,
@i_servname         varchar(10)   = null,
@i_sec_rise         varchar(12) = null, --ref 2
@i_ubi            smallint    = 0,
@i_pmcn           int       = null,
@o_sec_rise         int       = null out,
@o_pmcn           int       = null out,
@o_fecha_contable     varchar(20)   = null out,
@o_autorisri        varchar(30)   = null out,
@o_fecvensri        varchar(30)   = null out,
@o_nota_venta       varchar(15)   = null out,
@o_ssn            int       = null out,
@o_sec_reverso        int       = null out,
@o_comision         money     = null out,
@o_provincia        char(10)    = null out,
@o_horario                  char(1)       = null out,
@o_nombcta                  varchar(30)   = null out,
@o_tasa              money = 0 out,  --smerino
@o_base_imp          float = 0 out,  --smerino
@o_impuesto          float = 0 out,  --smerino
--ini ref13
@o_servicio_not  varchar(5) = null out,	
@o_nomb_ente     varchar(64) = null out,	
@o_cod_ente      varchar(20) = null out,	
@o_desccanal     varchar(16) = null out,	
@o_celular       varchar(10) = null out,	
@o_correo        varchar(64) = null out,	
@o_desc_empresa  varchar(32)  = null out,	
@o_prod_deb      char(3) = null out, 
@o_valor	varchar(11) = null out, 
@o_fecha_deb	varchar(10) = null out,  
@o_hora_deb 	varchar(8) = null out,     
@o_valor_comi	varchar(11) = null out, 
@o_valor_tot	varchar(11) = null out, 
@o_cta_lat	char(3)  = null out 
--fin ref13
 

)
as
declare
@w_return             int,
@w_sp_name            varchar(30),
@w_maximo_p           money,
@w_trn                int,
@w_servicio           varchar(6),
@w_com                money,
@w_serie              varchar(6),
@w_secuenciac         varchar(7),
@w_fechora            datetime,
@w_estado_cta               char(1),
@w_cuenta                   int,
@w_disponible_aho           money,
@w_saldo_contable           money,
@w_saldo_valsus             money,
@w_disponible_cte           money,
@w_disponible_valsus        money,
@w_horario                  char(1),
@w_hora_trn                 varchar(5),
@w_hora_dif                 varchar(9),
@w_trx_orig                 int,
@w_causal                   char(3),
@w_cant_cheques          int,
@w_autorisri            varchar(30),
@w_fecvensri            varchar(30),
@w_sec_reverso          int,
@w_comision             money,
--smerino
@w_tasa                 float,
@w_base_imp             money,
@w_impuesto2            money,
@w_ced_ruc              varchar(13),
@w_nombre               varchar(20),
@w_cliente              int,
@w_total_com            money,    --smerino
@w_fecha_desde_excep    datetime,  --REF 7
@w_fecha_hasta_excep    datetime,  --REF 7
@w_hora_dif_excep       varchar(8), --REF 7
/*REF9 Inicio SMM */ 
@w_oficina_cta2         smallint,  --SMERINO CNB
@w_telefono             varchar(10),--smerino faseIII
@w_desc_canal           varchar(16),   --smerino faseIII 
@w_desc_servicio        varchar(5), --smerino faseIII
@w_desc_empresa         varchar(32), --smerino faseIII
@w_valor_debito         varchar(11), --smerino faseIII
@w_fecha_deb            varchar(10), --smerino faseIII
@w_ssn                  int,   --smerino faseIII
@w_categoria            char(1),   --smerino faseIII
@w_correo               varchar(64),   --Ref 9 smerino
@w_tipo_cta             varchar(3), --smerino faseIII
@w_hora_deb             varchar(8), --smerino faseIII
@w_producto             tinyint,   --smerino
@w_rows                 int,             --smerino faseIII -->
@w_tab_causrv           char(30) ,       --smerino faseIII
@w_causa                varchar(10), --smerino faseIII
@w_mensaje              varchar(132), --smerino faseIII
@w_num_error            int,         --smerino faseIII
@w_msg                  varchar(200), --smerino faseIII
/*REF9 Fin SMM */ 
/*REF8 Inicio LBP */ 
@w_valor_compensa   money,
@w_comi_total       money,
@w_com_original     money,
@w_aplica_des       char(1),
@w_ofi              int,
/*REF8 Fin LBP */
@w_rubro_per    char(4),  --REF 10
@w_servicio_per char(4)	  --REF 10

select @w_sp_name = 'sp_procesa_rise'
select @o_ssn     = @s_ssn


---REF5
if @i_sec_rise <> "" and @i_sec_rise <> null
   begin
     select @i_sec_rise = convert(varchar(10), convert(int,@i_sec_rise) )
   end
---REF5
-----print "@i_sec_rise %1! @i_operacion  %2!",@i_sec_rise,@i_operacion


if @i_canal = 'VENTANILLA'
  set @i_canal = 'VEN'

if @i_canal = 'WEB'
  set @i_canal = 'IBK'


/*************************/
--Consulta de comision y parametros para el pago de Rise
/******************************************************/
if @i_operacion = 'C'
begin --if @i_operacion = 'C' - ini
  select @w_fechora     = getdate()

  select @o_fecha_contable = convert(varchar(20), convert(varchar(10), @w_fechora, 101) + ' ' + convert(varchar(10), @w_fechora, 108))


  set rowcount 1
  select
    @o_provincia = substring(a.valor, 1, 3)
  from
    cobis..cl_catalogo a, cobis..cl_oficina b, cobis..cl_tabla c
  where
    a.tabla = c.codigo
  and a.codigo = b.of_provincia
  and c.tabla = 'cl_provincia_rise'
  and of_oficina = @s_ofi
  set rowcount 0

  set @o_provincia = rtrim(ltrim(@o_provincia))


 -- INI REF 10
 select  
	@w_servicio_per = pe_cod_serv,
	@w_rubro_per  = pe_rubro  
 from cob_pagos..pg_person_empresa 
 where pe_empresa = 8369
 -- FIN REF 10

  exec @w_return = cob_pagos..sp_verif_genera_costo
      @s_date         = @s_date,
      @i_mon          = @i_mon,
      @i_rubro        = @w_rubro_per, ----REF 10 'RISE',
      @i_servicio     = @w_servicio_per, ----REF 10 'SRI',
      @i_canal        = @i_canal,
      @o_costo        = @o_comision out

    if @w_return <> 0
      return @w_return

  if  @o_comision > 0
  begin
  -- smerino busqueda de la tasa del iva parametrizada en el person
    exec @w_return = cob_pagos..sp_verif_genera_costo
         @s_date         = @s_date,
         @i_mon          = @i_mon,
         @i_rubro        = 'IVA',
         @i_servicio     = 'SRI',  ---se coloco para poder probar senae
         @i_canal        = @i_canal,
         @i_tipocta      = '3',
         @o_costo        = @o_tasa out

       if @w_return <> 0
      return @w_return

     -- print 'tasa %1!', @o_tasa
     -- print 'comision  %1!', @o_comision

  --smerino llamar al sp que retorna el valor del iva ----

  if @o_tasa > 0
    begin
       -- smerino llamar al sp que retorna el valor del iva ----
   exec  @w_return = cob_cuentas..sp_cal_impuesto
            @i_tasa   = @o_tasa,
          @i_valor_serv = @o_comision,
          @o_base_imp = @o_base_imp out,
            @o_impuesto = @o_impuesto out

       if @w_return <> 0
      begin

         if @@trancount >0
    rollback

    return @w_return

     end
       end
       else
          select @w_base_imp=@o_comision,@w_impuesto2=0




  end --fin de smerino


  return 0
end   --if @i_operacion = 'C' - fin

/***********************************/
--Actualizacion del Comprobante del SRI solo para canal Banking - IBK
/*******************************************************************/
if @i_operacion = 'U'
begin --if @i_operacion = 'U' - ini
  --begin tran

  update cob_cuentas..cc_tran_servicio
  set ts_stick_imp = @i_sec_rise   ---- ref 2 ame 04/22/2010 convert(varchar(10),@i_sec_rise)
  where
    ts_tipo_transaccion in (3934, 3935)
  and ts_secuencial = @i_tsn

  if @@error != 0
  begin
    --rollback tran
    return 35000
  end
  --commit tran
  return 0
end   --if @i_operacion = 'U' - fin


/***************************/
--Dentro del Multiflujos, primera opcion - Validacion de datos
/************************************************************/
if @i_operacion = 'V'
begin --if @i_operacion = 'V' - ini
  if @t_corr = 'N'
  begin --if @t_corr = 'N' - ini
    if @i_canal = 'IBK'
      select @i_aplcobis = 'N'

      if @i_autoriza in ('n','N') AND @t_corr = 'N' and @i_canal = 'VEN'
      begin
       if @i_debito > 0
       begin
        exec @w_return = cob_remesas..sp_verifica_cupos_rc
        @s_user     = @s_user,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @t_debug    = @t_debug,
        @t_trn      = @t_trn,
        @i_mon      = @i_mon,
        @i_ubi      = @i_ubi,
        @i_sec      = 1,
        @i_cau      = null,
        @i_tsn      = @s_ssn ,  ---@i_tsn,smerino
        @i_cuenta   = @i_cuenta,
        @i_chq_lib  = 0,
        @i_valor    = @i_debito,
        @i_operacion = 'S',
        @i_nemonico = 'MMXDB'    --MMXDB MAXIMO DEBITO EN CTAS
        if @w_return != 0
           return @w_return
       end

       if @i_efectivo > 0
       begin
        select @w_maximo_p = pa_money
        from cobis..cl_parametro
        where pa_nemonico = 'MSVP'
        and  pa_producto = 'CTE'

        if (@w_maximo_p <= @i_efectivo )
        begin
           if @i_aplcobis = 'S'
           begin
            exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 311819
            return 311819
           end
           else
            return 37608
        end
       end

      end

     -->Inicio de la Validacion de Ahorros
     if @i_tipo_cta = 'AHO' and @i_debito > 0
     begin
      --Valido existencia de la cuenta en el Maestro para la moneda especificada.
      select
      @w_estado_cta = ah_estado,
      @w_cuenta = ah_cuenta
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cuenta
      and ah_moneda = @i_mon
      if @@rowcount = 0
      begin
       if @i_aplcobis = 'S'
       begin
        exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @s_msg    = 'Cuenta no existe',
        @i_num    = 035000
        return 1
       end
       else
        return 1
      end

      if @w_estado_cta <> 'A'
      begin
       if @i_aplcobis = 'S'
       begin
        exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @s_msg    = 'Cuenta no esta activa',
        @i_num    = 035001
        return 2
       end
       else
        return 2
      end

      exec cob_ahorros..sp_ahcalcula_saldo
      @t_debug            = null,
      @t_file             = null,
      @t_from             = '',
      @i_cuenta           = @w_cuenta,
      @i_fecha            = @s_date,
      @i_ofi              = @s_ofi,
      @o_saldo_para_girar = @w_disponible_aho out,
      @o_saldo_contable   = @w_saldo_contable out

      if @i_debito > @w_disponible_aho
      begin
       if @i_aplcobis = 'S'
       begin
        exec cobis..sp_cerror
        @t_debug         = @t_debug,
        @t_file          = @t_file,
        @t_from          = @w_sp_name,
        @i_msg           = 'FONDOS INSUFICIENTES',
        @i_num           = 111111
        return 111111
       end
       else
        return 3
      end
     end
     -->Fin de la Validacion de Ahorros

     -->Inicio de la Validacion de Ahorros
     if @i_tipo_cta = 'CTE' and @i_debito > 0
     begin

      select
      @w_estado_cta = cc_estado,
      @w_cuenta = cc_ctacte
      from cob_cuentas..cc_ctacte
      where cc_cta_banco = @i_cuenta
      and cc_moneda = @i_mon
      if @@rowcount = 0
      begin
       if @i_aplcobis = 'S'
       begin
        exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @s_msg    = 'Cuenta no existe',
        @i_num    = 035000
        return 1
       end
       else
        return 1
      end

      if @w_estado_cta <> 'A'
      begin
       exec cobis..sp_cerror
       @t_debug         = @t_debug,
       @t_file          = @t_file,
       @t_from          = @w_sp_name,
       @i_msg           = 'CUENTA NO ESTA ACTIVA',
       @i_num           = 111111
      return 1
      end

      exec cob_cuentas..sp_calcula_saldo
      @i_cuenta           = @w_cuenta,
      @i_fecha            = @s_date,
      @i_ofi              = @s_ofi,
      @o_disponible       = @w_disponible_valsus out,
      @o_saldo_para_girar = @w_disponible_cte out,
      @o_saldo_contable   = @w_saldo_contable out,
      @o_saldo_valsus     = @w_saldo_valsus out

      if @i_debito > @w_disponible_cte
      begin
       exec cobis..sp_cerror
       @t_debug         = @t_debug,
       @t_file          = @t_file,
       @t_from          = @w_sp_name,
       @i_msg           = 'FONDOS INSUFICIENTES',
       @i_num           = 111111
       return 1
      end
     end

     if @i_canal = 'VEN'
     begin
      --Verifica Apertura de Caja
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
      @s_org   = @s_org,
      @t_trn   = @t_trn,
      @t_corr  = @t_corr,
      @i_mon   = @i_mon,
      @i_ubi   = @i_ubi,
      @o_horario = @w_horario  out
      if @w_return != 0
       return @w_return
     end

  end   --if @t_corr = 'N' - fin
  else
  begin --eles if @t_corr = 'N' - ini
    if @t_corr = 'S'
    begin
      set @o_pmcn = @t_ssn_corr1 -- Parametro de reverso para el proveedor
    end
  end   --else if @t_corr = 'N' - fin


   return 0


end   --if @i_operacion = 'V' - fin

/***************************/
--Dentro del Multiflujos, segunda opcion - Insercio de datos
/***********************************************************/
if @i_operacion = 'P'
begin

   if @t_trn in (62158,62159)  --- ame 04/12/2010
      select @t_trn = 3934

   if @i_canal = 'IBK'
      select @i_aplcobis = 'N'
      
  /*REF08 Inicio LBP */  
  if @i_canal = 'CNB'
     select @w_ofi = @s_ofi, @s_ofi = 0
     else
     if @i_canal = 'VEN'
        select @w_ofi = @s_ofi
  /*REF08 Fin LBP */

   /*REF9 Inicio SMM */ 
   if @i_canal in ('VEN','CNB')   --smerino CNBFASEIII
   /*REF9 FIN SMM */ 
   begin
      --Identifico si estoy en el horario normal o diferido
      select @w_hora_trn = convert(varchar,getdate(),108)
      select @w_hora_dif = rh_inicio,
             @w_fecha_desde_excep =rh_fecha_desde,   --REF 7
      			 @w_fecha_hasta_excep = rh_fecha_hasta,  --REF 7
      			 @w_hora_dif_excep = rh_nuevo_inicio  --REF 7
      from cob_remesas..re_horario
      where rh_oficina = @s_ofi and rh_ubicacion = @i_ubi
      
   		---Si la fecha de proceso esta dentro delperiodo de excepcion reemplazo la hora del diferido por la hora de excepcion
   		if  @s_date >= @w_fecha_desde_excep  and @s_date <= @w_fecha_hasta_excep  --REF 7
      		select @w_hora_dif = @w_hora_dif_excep
      		
      if  @w_hora_trn >= @w_hora_dif
         select @t_trn = 3935
      else
         select @t_trn = 3934
   end

      /*REF9 Inicio SMM */ 
   if @i_canal in ( 'VEN','CNB') and @t_corr = 'S'
      /*REF9 FIN SMM */ 
   begin

      select @w_trx_orig = ts_tipo_transaccion    -- identifica trx original
      from cob_cuentas..cc_tran_servicio
      where ts_tsfecha = @s_date
      and ts_secuencial = @t_ssn_corr2
      and ts_tipo_transaccion in (3934)
      if @@rowcount <> 0
         select @t_trn = @w_trx_orig
   end


	--ref12 pricaura ini	validacion que exista pago antes de hacer el reverso
	if @t_corr = 'S'
	begin
		select ts_tipo_transaccion    -- identifica trx original
				from cob_cuentas..cc_tran_servicio
			   where ts_tsfecha = @s_date
				 and ts_secuencial = @t_ssn_corr
				 and ts_tipo_transaccion = @t_trn
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
				@t_debug         = @t_debug,
				@t_file          = @t_file,
				@t_from          = @w_sp_name,
				@i_msg           = 'NO EXISTE TRANSACCIÓN ORIGINAL',
				@i_num           = 34014
			return 34014
		end
	end
	--ref12 pricaura fin	validacion que exista pago antes de hacer el reverso


   -- Valida si se ha aperturado caja
   if @s_org = 'U' and @i_aplcobis = 'S' and @i_canal = 'VEN'
   begin
      exec @w_return = cob_remesas..sp_verifica_caja_rc
           @s_ssn     = @s_ssn,
           @s_srv     = @s_srv,
           @s_lsrv    = @s_lsrv,
           @s_user    = @s_user,
           @s_term    = @s_term,
           @s_date    = @s_date,
           @s_ofi     = @s_ofi,
           @s_rol     = @s_rol,
           @s_sev     = @s_sev,
           @s_msg     = @s_msg,
           @s_org     = @s_org,
           @t_trn     = @t_trn,
           @t_corr    = @t_corr,
           @i_mon     = @i_mon,
           @i_ubi     = @i_ubi,
           @o_horario = @w_horario out
      if @w_return != 0
         return @w_return
   end

   select @w_serie = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'SERNV'
     and pa_producto = 'CTE'

   --Obtener la secuencia de la nota de venta
 /*  exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'sv_seq_nota_venta',
        @o_siguiente = @w_secuencian out
   if @w_return != 0
      return @w_return

   --Armar el numero de nota de venta
   select @w_secuenciac = convert(varchar(7),@w_secuencian)
   select @w_secuenciac = replicate('0',7-datalength(@w_secuenciac))+@w_secuenciac*/

   if @i_canal = 'VEN'
   begin
      select
        @w_fecvensri = pa_char
      from
        cobis..cl_parametro
      where
        pa_nemonico = 'FECVAL'
      and pa_producto = 'CTE'

      select
        @w_autorisri = pa_char
      from
        cobis..cl_parametro
      where
        pa_nemonico = 'NUMAUT'
      and pa_producto = 'CTE'
  end



    
 /*REF9 Inicio SMM */ 
 -- anticipar queries de validacion de cuenta
    select @w_num_error = 0
    if @i_debito > 0  or @i_comision_tot > 0  --Ref011:msilvag 
    begin
      if @i_tipo_cta = 'CTE'
      begin
        select @w_tipo_cta = @i_tipo_cta,
               @w_cliente = cc_cliente,
               @w_categoria = cc_categoria,
               @o_nombcta = substring(cc_nombre,1,32) ----SMERINO CNB FASEII
         from cob_cuentas..cc_ctacte
         where cc_cta_banco = @i_cuenta
         if @@rowcount = 0
           select @w_num_error = 31004
      end
      else
      if @i_tipo_cta in ('AHO', 'PAG')
      begin
        
        select @w_tipo_cta = @i_tipo_cta,
               @w_cliente = ah_cliente,
               @w_categoria = ah_categoria,
               @o_nombcta = substring(ah_nombre,1,32) --SMERINO CNB FASEII
         from cob_ahorros..ah_cuenta
         where ah_cta_banco = @i_cuenta
        select @w_rows = @@rowcount
        if @w_rows = 0
          if @i_canal in ('CNB', 'ATM', 'IBK', 'DBA')
          begin
           select @w_cliente   = vi_cliente,
                  @w_categoria = vi_categoria,
                  @w_tipo_cta  = 'BAS'
            from cob_virtuales..vi_cuenta
            where vi_cta_banco = @i_cuenta and vi_prod_banc = 13
           select @w_rows = @@rowcount
          end
        if @w_rows = 0
          select @w_num_error = 41001
      end
      else
        select @w_num_error = 30073
      --select @w_tipo_cta = substring(@w_tipo_cta, 1, 1)        -- incluir cta bas
    end
    if @w_num_error <> 0
    begin
      select @w_mensaje = mensaje,
             @w_num_error = numero
       from cobis..cl_errores
       where numero = @w_num_error
      if @i_aplcobis = 'S'
      exec cobis..sp_cerror
           @t_from   = @w_sp_name,
           @i_msg    = @w_mensaje,
           @i_num    = @w_num_error
      else
        select @w_msg = '[' + @w_sp_name + ']  ' + @w_mensaje
      return @w_num_error
    end
 
--smerino busca causal del debito a la cuenta ----
 if @w_tipo_cta = 'CTE'
    begin
       select @w_causa = isnull(b.valor,' ')
         from cobis..cl_tabla a, cobis..cl_catalogo b       
         where a.tabla = 'causa_nd_cte_servicios'       
         and a.codigo = b.tabla       
         and convert(smallint,b.codigo) = 8369 --135 
         and estado = 'V'
                     
         if @@rowcount = 0 or (@w_causa = null or @w_causa = ' ')
         begin
       		if @i_aplcobis = 'S'                                               
                begin                                                      
             		exec cobis..sp_cerror
                  	@t_debug = @t_debug,
                  	@t_file  = @t_file,
                  	@t_from  = @w_sp_name,
                  	@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
                  	@i_num   = 158693
                  return 1
             	end
       
  	end
   end
   else
   if @i_tipo_cta in ('AHO', 'PAG')                          
   begin
    select @w_tab_causrv = case @w_tipo_cta when 'AHO' then 'causa_nd_aho_servicios' when 'BAS' then 'causa_nd_bas_servicios' end
   	select @w_causa = isnull(b.valor,' ')
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = @w_tab_causrv  
        and a.codigo = b.tabla
        and convert(smallint,b.codigo) = 8369 --135   
      	and estado = 'V'
    
      	if @@rowcount = 0 or (@w_causa = null or @w_causa = ' ')    
	begin    
        	if @i_aplcobis = 'S'                                               
        	begin                                                               
        	  exec cobis..sp_cerror    
        	  @t_debug = @t_debug,    
        	  @t_file  = @t_file,    
               	  @t_from  = @w_sp_name,    
               	  @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',    
               	  @i_num   = 158693    
                  return 1
               end            -- dbl
        end
  end
 -- fin de buscar el cuasal del debito smerino
 /*REF9 FIN SMM */

         
/*REF9 Inicio SMM */
select @i_tsn=@s_ssn -- SMERINO CNBIII

begin tran
   -->FORMA DE PAGO: DEBITO EN CUENTA
   if @i_debito > 0
   begin
   
   
      if @i_tipo_cta = 'CTE'
      begin
      
      
         select @w_producto = 3
       
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
         @i_cau          = @w_causa , ---'441',comenta smerino
         @i_mon          = 1,
         @i_ref          = @i_identificacion,
         @i_fecha        = @s_date,
         @s_rol          = @s_rol,
         @i_ubi          = @i_ubi,
         @i_tsn          = @i_tsn,
         @i_detalle      = @i_identificacion, -- SMERINO CNB
	 @o_oficina_cta   = @w_oficina_cta2 out  --SMERINO CNB
          
          
         if @w_return <> 0
         begin
            
            rollback tran
            return @w_return
         end

      end
      
      if @i_tipo_cta in ('AHO', 'PAG')
      begin
      
      if @w_tipo_cta = 'AHO'  
      begin
        select @w_producto = 4
     
         exec @w_return = cob_ahorros..sp_ahndc_automatica
         @s_srv          = @s_srv,
         @s_ofi          = @s_ofi,
         @s_ssn          = @s_ssn,
         @s_user         = @s_user,
         @s_term         = @s_term,
         @t_trn          = 4264,
         @t_corr         = @t_corr,
         @i_cta          = @i_cuenta,
         @i_val          = @i_debito,
         @i_cau          = @w_causa ,  ---'441',comenta smerino
         @i_mon          = 1,
         @i_ref          = @i_identificacion,
         @i_fecha        = @s_date,
         @s_rol          = @s_rol,
         @i_ubi          = @i_ubi,
         @i_tsn          = @i_tsn,
         @i_tarjeta        = @i_identificacion, --SMERINO CNB
         @o_oficina_cta    = @w_oficina_cta2 out  ---smerino cnb
         if @w_return <> 0
         begin
            
            rollback tran
            return @w_return
         end
      end
      
   else                                                         
    if @w_tipo_cta = 'BAS'
       
                 exec @w_return = cob_virtuales..sp_basndc_automatica
		 @s_srv              = @s_srv,
		 @s_ofi              = @s_ofi,
		 @s_ssn              = @s_ssn,
		 @s_user             = @s_user,
		 @s_term             = @s_term,
		 @s_rol              = @s_rol,
		 @t_trn              = 120060,
		 @t_corr             = @t_corr,
		 @i_cta              = @i_cuenta,
		 @i_val              = @i_debito,
		 @i_cau              = @w_causa,
		 @i_mon              = 1,
		 @i_fecha            = @s_date,
		 @i_aplcobis         = @i_aplcobis,
		 @i_referen          = @t_ssn_corr,
		 @i_tarjeta          = @i_identificacion,
		 @i_ref              = @i_identificacion,
		 @i_ubi              = @i_ubi,
		 @i_tsn              = @i_tsn,
		 @i_con_tran         = 'N',
		 @i_canal            = @i_canal                     

                 if @w_return <> 0
                  begin
                      if @@trancount > 0
                       begin
                         rollback tran
                         return @w_return
                        end
            end         
      
   end
 end
 --<FORMA DE PAGO: DEBITO EN CUENTA
 /*REF9 FIN SMM */  
 
   
 /*REF9 INICIO SMM */
--- smerino llamado al sp que extrae CEL e email
    --if  @i_canal='CNB'  and @i_debito <> 0
    if  @i_debito <> 0   --ref13
    begin
    
 
select @w_fecha_deb = convert(varchar(10),getdate(),101)  -- GYC 2008/Ene/28  -- Fecha debito
select @w_hora_deb = convert(varchar(8),getdate(),108)  -- HORA debito
  		  
  	if @i_canal = 'ATM'
		select @w_desc_canal = 'VEINTI4EFECTIVO'
	if @i_canal = 'DBA'
		select @w_desc_canal = 'AUTOMATICO'
	if @i_canal = 'IBK'
		select @w_desc_canal = '24Online'  
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
          
          if @i_tipo_cta = 'AHO'
          begin
		  select @w_cliente = ah_cliente			 
		  from cob_ahorros..ah_cuenta
		  where ah_cta_banco = @i_cuenta
          end
          
          if @i_tipo_cta = 'CTE'
          begin
          	select @w_cliente = cc_cliente
		from cob_cuentas..cc_ctacte
	    	where cc_cta_banco = @i_cuenta
          end          
          
          select @w_valor_debito = convert(varchar(11),@i_debito)
          
          select @w_desc_empresa ='SRI'
  		      	
  	exec  @w_return = cob_pagos..sp_consulta_celular
  	      @i_cliente = @w_cliente,
  	      @o_celular = @w_telefono  out,
  	      @o_correo=@w_correo  out
  
  		if @w_return <> 0
                  begin
                     if @@trancount > 0
                        begin
                        rollback tran
                        return @w_return
                        end
                  end
                  
          
		if @t_corr = 'N'
		begin
			select @w_desc_servicio = 'PAGSB', @w_ssn = @s_ssn
		end
		else
		begin
			select @w_desc_servicio = 'PAGSR', @w_ssn = @t_ssn_corr
		end
		
	  /*REF9 INICIO SMM */
	   select @w_comi_total = isnull(@i_comision_efe,0) + isnull(@i_comision_chq,0) + isnull(@i_comision_tot,0) ----SMERINO CNBIII
	   /*REF9 fIN SMM */
   
  
	 select @o_servicio_not = @w_desc_servicio,
		@o_nomb_ente = @o_nombcta,
		@o_cod_ente =  convert(varchar(20),@w_cliente) ,
		@o_desccanal = @w_desc_canal,         	       
		@o_celular = @w_telefono,
		@o_correo  = @w_correo,
		@o_desc_empresa = @w_desc_empresa,
		@o_prod_deb = @w_tipo_cta,
		@o_valor = @w_valor_debito,
		@o_fecha_deb = @w_fecha_deb,
		@o_hora_deb = @w_hora_deb,
		@o_valor_comi = convert(varchar, @w_comi_total),
		@o_valor_tot =  convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @w_comi_total))  ,
	       	@o_cta_lat = substring(@i_cuenta,8,3)
  
                   /* exec  @w_return = cob_internet..sp_eventos
                          @i_operacion    = 'I',
                          @i_fecha        = @w_fecha_deb,
                          @i_retardo      = 'S',
                          @i_fecha_tope   = @w_fecha_proc,
                          @i_cliente      = @w_cliente,
                          @i_servicio     = @w_desc_servicio,
                          @i_producto     = @w_producto,
                          @i_prod_deb     = @w_tipo_cta ,
                          @i_cuenta       = @i_cuenta,
                          @i_empresa      = @w_desc_empresa,
                          @i_desc_servicio  = 'Pago de Impuestos',
                          @i_nombre         = @o_nombcta ,
                          @i_planilla       = @i_identificacion,
                          @i_valor          = @w_valor_debito,
                          @i_canal          = @i_canal,
                          @i_desc_canal     = @w_desc_canal,
                          @i_ssn            = @w_ssn,
                          @i_categoria_cta  = @w_categoria,      
                          @i_mail           =@w_correo , --smerino
                          @i_telefono       =@w_telefono,  ---smerino-
                          @i_motivo         = 'Servicios Públicos',
                          @i_valor1         =@w_hora_deb
                           */
  
                    if @w_return <> 0
                       begin
                         rollback tran
                         return @w_return
                       end
           end     
  ---- fin smerino                     
 /*REF9 fin SMM */

   /*REF9 INICIO SMM */
   if @i_canal not in ( 'VEN','CNB') --smerino  CNBFASEIII
   /*REF9 Fin SMM */
      begin
        -- ini REF 10
        select  
          @w_servicio_per = pe_cod_serv,
       	  @w_rubro_per  = pe_rubro  
        from cob_pagos..pg_person_empresa 
 	where pe_empresa = 8369
 	-- fin REF 10
 
         --Calculo de la Comision para la Ventanilla
         exec cob_pagos..sp_verif_genera_costo
         @s_date         = @s_date,
         @i_mon          = @i_mon,
         @i_rubro        = @w_rubro_per, --REF 10 'RISE',
         @i_servicio     = @w_servicio_per, --REF 10 'SRI',
         @i_canal        = @i_canal,
         @i_tipocta      = @i_tipo_cta,
         @i_cuenta       = @i_cuenta,
         @o_costo        = @w_comision out
         select @i_comision_tot = @w_comision
   end
   
   --Ref011:msilvag Inicio comento bloque
   /*
   if @i_canal = 'VEN'
   	select @i_comision_tot = 0
   */
   --Ref011:msilvag Fin
   

   --<REF 15 Add w_comi_total comison auxiliar
   --INSERTO LA TRANSACCION DE PAGO DEL IESS EN TABLA CC_TRAN_SERVICIO
   insert into cob_cuentas..cc_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_rol, ts_terminal,
   ts_correccion, ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_referencia,
   ts_saldo, ts_ssn_corr, ts_moneda, ts_tipo, ts_monto, ts_valor,
   ts_ocasional, ts_tsn, ts_ccontable, ts_hora, ts_servicio,
   ts_contratado, ts_aporte_iess, ts_ced_ruc, ts_autorizante, ts_descripcion_ec, ts_descuento_iess,
   ts_cheque_rec, ts_ubicacion, ts_nombre, ts_autoriz_aut, ts_cta_banco, ts_tipocta, ts_fonres_iess,
   ts_propietario, ts_campo_alt_uno, ts_campo_alt_dos, ts_stick_imp, ts_fecha, ts_tipo_chequera)
   values
   (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term,
   @t_corr, null, 'L', @s_lsrv, @s_date, convert(varchar(15),@i_identificacion),
   @i_cheque, @t_ssn_corr, 1, 'L', @i_debito, @i_efectivo,
   0, @i_tsn, null, getdate(), null,
   0, 0, '0', '0', '0', @w_comi_total,
    /*REF9 INICIO SMM */
   convert(int, @i_cant_cheques), @i_ubi, @i_razon_soc, @w_com, @i_cuenta, @w_tipo_cta, @w_comi_total,   ----SMERINO CNBIII @w_tipo_cta/i_comision_tot
    /*REF9 fin SMM */
   --- ame 04/22/2010 '000', @i_identificacion, @i_rubro, convert(varchar(10), @i_sec_rise), convert(smalldatetime, getdate()),
   '000', @i_identificacion, @i_rubro, @i_sec_rise, convert(smalldatetime, getdate()),  --ref 2
   @i_canal)
   --REF 15>
   set @w_sec_reverso = @s_ssn

    /*REF9 INICIO SMM */
   
   --- smerinom CNB FASEIII
      select @w_causal = '445'
   /*REF9 Fin SMM */
  
   if (@i_comision_tot > 0 or @i_comision_efe > 0 or @i_comision_chq > 0)--and @i_canal = 'VEN' --REF 7
   begin
      select @w_servicio = '1'

      if @t_trn = 3934
         select @w_trn = 3366

      if @t_trn = 3935
         select @w_trn = 3372

    --Ref011:msilvag Inicio comento bloque
    /*
      if @i_canal = 'VEN'  --smerino  CNBFASEIII cnb si tiene debitos
        set @i_comision_tot = 0,
            @i_cuenta = null
            */
    --Ref011:msilvag Fin
            
      /*REF08: Inicio LBP */ 
     if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
                where rs_nemonico = '135'
                and rs_canal = @i_canal and rs_estado = 'V')  
      begin
     
           select @w_comi_total = isnull(@i_comision_efe,0) + isnull(@i_comision_chq,0) + isnull(@i_comision_tot,0) -- Comision que debe venir del 12%
            
           exec @w_return = cob_pagos..pa_pg_ivalor_comcal
                @e_valor_comision  = @w_comi_total,
                @e_oficina         = @w_ofi,
                @e_empresa         = 135,
                @e_canal           = @i_canal,
                @s_valor_com_final = @w_com_original out, -- obtengo comision original al 14%
                @s_aplica          = @w_aplica_des out
           if @w_return <> 0
              begin
              rollback tran
              return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
              end
           if @w_aplica_des = 'S'
           begin
                exec @w_return = cob_gov..pa_iva_pcompensacion
                     @e_oficina        = @w_ofi,
                     @e_monto          = @w_com_original,
                     @s_monto_compensa = @w_valor_compensa out   
                if @w_return <> 0
                  begin
                   rollback tran
                   return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
                   end
           end
     
      end
      /*REF08: Fin LBP */ 

	---INI REF 10
	if @w_tipo_cta = 'CTE'
	begin 
		select @w_causal = b.valor 
		from cobis..cl_tabla a, cobis..cl_catalogo b
		where a.tabla = 'causa_nd_comision_servcte'
		and a.codigo = b.tabla
		and b.codigo = '8369'
		and estado = 'V'
            
            	if @@rowcount = 0
			select @w_causal = '445' 	    	
        end    
        else 
		if @w_tipo_cta = 'AHO'
		begin     
			select @w_causal = b.valor   
			from cobis..cl_tabla a, cobis..cl_catalogo b
			where a.tabla = 'causa_nd_comision_servaho'
			and a.codigo = b.tabla
			and b.codigo = '8369'
			and estado = 'V'

			if @@rowcount = 0 
				select @w_causal = '445' 
		end
		else
		begin     
			select @w_causal = b.valor   
			from cobis..cl_tabla a, cobis..cl_catalogo b
			where a.tabla = 'causa_nd_comision_servbas'
			and a.codigo = b.tabla
			and b.codigo = '8369'
			and estado = 'V'

			if @@rowcount = 0 
				select @w_causal = '445' 
		end
        --FIN REF 10
        
        
        
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
      @s_org_err  = @s_org_err,
      @s_error    = @s_error,
      @s_sev      = @s_sev,
      @t_corr     = @t_corr,
      @t_ssn_corr = @t_ssn_corr,
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @t_from,
      @t_rty      = @t_rty,
      @t_trn      = @w_trn,  --Transaccion de la Comision dependiendo del Horario.
      @i_ubi      = @i_ubi,
      @i_mon      = @i_mon,
      @i_opcion   = "T",
      @i_servicio = @w_servicio,
      @i_codigo   = @i_identificacion,
      @i_efectivo = @i_comision_efe,
      @i_cheque   = @i_comision_chq,
      @i_tipocta  = @w_tipo_cta , --smerino CNBFASEIII para que considere basica @i_tipo_cta,
      @i_cuenta   = @i_cuenta,
      @i_debito   = @i_comision_tot,
      @i_causal   = @w_causal,
      @i_aplcobis = C,
      /*REF9 INICIO SMM */
      @i_tsn      = @i_tsn, --smerino CNBFASEIII
      @i_canal    = @i_canal,   --smerino CNBFASEIII
      /*REF9 fin SMM */
	  @i_empresa = 8369
	  
      if @w_return != 0
      begin
         if @i_aplcobis = 'S'
         begin
           
            rollback tran
           
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = @w_return --035000
            return @w_return --1
         end
         else
           begin
           rollback tran
             return @w_return --35000
             end
      end
     --smerino busca calculo dle iva
     -- smerino busqueda de la tasa del iva parametrizada en el person

    select  @w_total_com= @i_comision_efe +  @i_comision_chq + @i_comision_tot

    exec @w_return = cob_pagos..sp_verif_genera_costo
        @s_date         = @s_date,
        @i_mon          = @i_mon,
        @i_rubro        = 'IVA',
        @i_servicio     = 'SRI',
        @i_canal        = @i_canal , 
        @i_tipocta      = '3',
        @o_costo        = @w_tasa out


     if @w_return <> 0
     begin
      if @@trancount >0
          begin
           rollback tran
           return @w_return
          end
     end

       -- smerino llamar al sp que retorna el valor del iva ----


       if @w_tasa > 0
       begin
            /*REF08: Inicio LBP */ 
            if @w_aplica_des = 'S' and @i_canal in ('VEN','CNB') ---smerino CNBFASEIII
            begin
                 --print 'comision %1!', @w_total_com
                 exec @w_return = cob_cuentas..sp_cal_impuesto
                      @i_tasa        = @w_tasa,
                      @i_valor_serv  = @w_com_original, -- Comision Original al 14
                      @o_base_imp    = @w_base_imp out,
                      @o_impuesto    = @w_impuesto2 out
                      
                      /*REF9 INICIO SMM */
                      select @o_base_imp=@w_base_imp,@o_impuesto=@w_impuesto2,@o_tasa=@w_tasa ---smerino CNBFASEIII
                      /*REF9 fin SMM */
                 if @w_return <> 0
                 begin
                     if @@trancount >0
                     begin
                      rollback tran
                     return @w_return
                     end
                end
            end
            else
            begin
            /*REF08: Fin LBP */
                 --print 'comision %1!', @w_total_com
                 exec @w_return = cob_cuentas..sp_cal_impuesto
                      @i_tasa        = @w_tasa,
                      @i_valor_serv  = @w_total_com, --@w_com,
                      @o_base_imp    = @w_base_imp out,
                      @o_impuesto    = @w_impuesto2 out
                      
                      /*REF9 INICIO SMM */
                      select @o_base_imp=@w_base_imp,@o_impuesto=@w_impuesto2,@o_tasa=@w_tasa ---smerino CNBFASEIII
                      /*REF9 fin SMM */
                 if @w_return <> 0
                 begin
                     if @@trancount >0
                     begin
                       rollback tran
                     return @w_return
                     end
                 end
            end -- Fin if @w_aplica_des = 'S' and @i_canal = 'VEN'   LBP        
       end
       else
           /*REF9 INICIO SMM */
            select @w_base_imp=@w_total_com,@w_impuesto2=0
           /*REF9 fin SMM */



      if @w_base_imp > 0
      begin
           /*REF08: Inicio LBP */ 
           if @w_aplica_des = 'S' and @i_canal in ( 'VEN','CNB')   --smerino CNBFASEIII
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
                     @s_ofi       = @w_ofi,
                     @t_rty       = @t_rty,
                     @s_org       = @s_org,
                     @i_base_imp  = @w_base_imp,
                     @i_iva       = @w_impuesto2,
                     @i_total     = @w_com_original, -- Comision Original al 14
                     @i_cau       = @w_servicio,   --servivio que debe de enviarse
                     @i_cta       = @i_identificacion, --referencia
                     @i_mon       = @i_mon,    --Moneda
                     @i_oficina_cta = @w_ofi,
                     @i_ubi         = @i_ubi,
                     @i_cta_deb     = @i_cuenta, -- REF08 LBP se agrega cuenta
                     @i_canal       = @i_canal   --smerino CNBFASEIII

                if @w_return <> 0
                begin
                    if @@trancount >0
                    begin
                       rollback tran
                       return @w_return
                       end
                end
           end
           else
           begin
           /*REF08: Fin LBP */ 
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
                     @i_total     = @w_total_com,
                     @i_cau       = @w_servicio,   --servivio que debe de enviarse
                     @i_cta       = @i_identificacion, --referencia
                     @i_mon       = @i_mon,    --Moneda
                     @i_oficina_cta = @s_ofi,
                     @i_ubi         = @i_ubi,
                     @i_canal       = @i_canal  --smerino CNBFASEIII 
           end -- Fin if @w_aplica_des = 'S' and @i_canal = 'VEN' LBP

     if @w_return <> 0
     begin
      if @@trancount >0
         begin
          rollback tran
          return @w_return
          end
     end
        end



        if @i_tipo_cta= 'CTE' and @i_debito > 0
       begin
       select @w_cliente = cc_cliente
       from cob_cuentas..cc_ctacte
       where cc_cta_banco = @i_cuenta
       end

       if @i_tipo_cta = 'AHO' and @i_debito > 0
       begin
       select @w_cliente = ah_cliente
       from cob_ahorros..ah_cuenta
       where ah_cta_banco = @i_cuenta
       end

       if @w_cliente > 0
       begin
   			select @w_ced_ruc = en_ced_ruc,
    		               @w_nombre = substring(ltrim(en_nombre) + " " + ltrim(p_p_apellido) + " " + rtrim(ltrim(p_s_apellido)),1,45)
   			from cobis..cl_ente
   			where en_ente = @w_cliente
       end
     	 else
     		select @w_ced_ruc = '9999999999999' --REF 7


  
     --fin smerino
   end
   --<Fin de Cobro de la Comision

commit tran
   -->Actualizacion de Totales de cajero
   set @w_cant_cheques = convert(int, @i_cant_cheques)
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
      @i_cant_chq       = @w_cant_cheques,
      @i_cheque         = @i_cheque,
      @i_efecto_chq     = 0,
      @i_efecto_odb     = 0,
      @i_nc_fiscales    = 0,
      @i_otros          = @i_debito,
      @i_tipocta        = @i_tipo_cta
      if @w_return != 0
      begin
         rollback tran
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 035000
         return 1
      end
   end

   select   @o_sec_rise         = convert(int,@i_sec_rise), --ref 2
        @o_pmcn           = @o_pmcn,
        @o_fecha_contable       = convert(varchar(20),convert(varchar(10),@s_date, 101) + ' ' + convert(varchar(10),getdate(),108)),
        @o_autorisri        = @w_autorisri,
        @o_fecvensri        = @w_fecvensri,
        @o_nota_venta         = substring(@w_serie,1,3)+'-'+substring(@w_serie,4,3)+'-'+@w_secuenciac,
        @o_ssn            = @s_ssn,
      @o_sec_reverso        = @w_sec_reverso

   if @i_canal = 'IBK'
   begin
     select "results_submit_rpc",
    r_ssn            = @s_ssn,
    r_fecha_efe        = @o_fecha_contable
   end


end


return 0

go
if exists(select 1 from sysobjects where name='sp_procesa_rise' and type = 'P')
  PRINT '== CREATE PROCEDURE procedimiento *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE procedimiento -- ERROR -- >>>'
go
 grant execute on sp_procesa_rise to apl_osb_hpact
--  grant execute on sp_procesa_rise to apl_osb_hpdes
go

