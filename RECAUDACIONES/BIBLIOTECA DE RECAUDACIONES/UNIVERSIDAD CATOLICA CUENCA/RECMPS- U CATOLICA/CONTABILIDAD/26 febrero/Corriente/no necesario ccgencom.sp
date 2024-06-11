/************************************************************************/
/*  Archivo:            ccgencom.sp                                     */
/*  Motor BD:           sybase                                          */
/*  Base de datos:      cob_cuentas                                     */
/*  Aplicacion:         CUENTAS CORRIENTES                              */
/*  Stored procedure:   pa_cte_bgenera_comprob_contab                   */
/*  Disenado por:       Jorge Pazminno M.                               */
/*  Fecha de escritura: 24/Sep/2020                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "BANCO BOLIVARIANO".                                                 */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.       */
/************************************************************************/
/* Se encarga de generar los comprobantes contables de CTE              */
/************************************************************************/
/* MODIFICACIONES                                                       */
/************************************************************************/
/* REF  FECHA          AUTOR            RAZON                           */
/*   1  23/Oct/2020  J.Pazminno  CTE-CC-SGC00040520                     */
/*                               Tunning Proceso - Transformar SQR => SP*/
/************************************************************************/
use cob_cuentas
go


if exists(select 1 from db_general..sysobjects where name = 'cte_tmp_asientos_error')
  drop table db_general.dbo.cte_tmp_asientos_error
go

create table db_general.dbo.cte_tmp_asientos_error(
  ra_perfil       varchar(6)  null,
  ra_tipo_tran    int         null,
  ra_asiento      int         null,
  ra_cuenta       varchar(30) null,
  ra_oficina_orig smallint    null,
  ra_oficina_dest smallint    null,
  ra_area_dest    smallint    null,
  ra_credito      money       null,
  ra_debito       money       null,
  ra_concepto     varchar(50) null,
  ra_credito_me   money       null,
  ra_debito_me    money       null,
  ra_moneda       smallint    null,
  ra_cotizacion   money       null,
  ra_tipo_doc     varchar(10) null,
  ra_producto     smallint    null,
  ra_debcred      char(1)     null
)
go

if exists (select 1 from sysobjects where name = "pa_cte_bgenera_comprob_contab" and type='P')
  begin
    drop procedure  dbo.pa_cte_bgenera_comprob_contab
    if exists (select 1 from sysobjects where name = 'pa_cte_bgenera_comprob_contab' and type = 'P')
      PRINT '<<< DROP PROCEDURE pa_cte_bgenera_comprob_contab -- ERROR -- >>>'
    else
      PRINT '== DROP PROCEDURE pa_cte_bgenera_comprob_contab *OK* =='
  end
go

create procedure dbo.pa_cte_bgenera_comprob_contab (
@e_filial                   tinyint,
@e_fecha                     smalldatetime,
@s_procesadas               int         out,
@s_error_comprb             char(1)     out
)
as
declare
@v_estado_proc              char(1),
@v_moneda_base              tinyint,
@v_numdecbase               tinyint,
@v_tipo_tran                int,                -- cursor <<transacciones>>
@v_moneda                   tinyint,            -- cursor <<total_tran>> -->
@v_trn_descripcion          varchar(50),
@v_ofic_orig                smallint,
@v_ofic_dest                smallint,
@v_tran                     int,
@v_mon                      tinyint,
@v_origen                   smallint,
@v_causa                    varchar(4),
@v_cotizacion               float,
@v_producto                 tinyint,
@v_valor                    money,
@v_perfil                   varchar(10),
@v_codval                   smallint,
@v_valor_me                 money,
@v_tipo_contable            char(2),
@v_estado_sob               char(3),
@v_tipo_sobregiro           char(1),
@v_tipo_credito             char(1),
@v_plazo                    char(2),
@v_ccontable                varchar(11),
@v_cuenta                   varchar(40),
@v_signo                    smallint,
@v_debcred                  tinyint,
@v_constante                varchar(3),
@v_origen_dest              char(1),            -- <-- cursor <<total_tran>>
@v_ult_trx                  int,
@v_ult_moneda               smallint,           -- variables de quiebre -->
@v_ult_of_org               smallint,
@v_ult_tip_tr               int,
@v_ult_cotiza               float,
@v_of_origen                smallint,
@v_of_destino               smallint,
@v_cuenta_final             varchar(30),
@v_tipo_doc                 char(1),
@v_asiento                  int,
@v_cdebcred_str             char(1),
@v_dtr_concepto             varchar(50),
@v_debito_mn                money,
@v_debito_me                money,
@v_credito_mn               money,
@v_credito_me               money,
@v_tot_credito_mn           money,
@v_tot_debito_mn            money,
@v_tot_credito_me           money,
@v_tot_debito_me            money,
@v_total_todo               money,
@v_salir                    bit,
@v_cuenta_aux               varchar(40),
@v_trama                    varchar(40),
@v_pos                      smallint,
@v_pos_ant                  smallint,
@v_pos_sig                  smallint,
@v_return                   int,
@v_of_duenia                smallint,
@v_moneda_cuenta            tinyint,
@v_mensaje                  varchar(300),       -- mensajes de error
@v_procesadas               int,
@v_leidos                   int,
@v_error_comprb				char(1)

truncate table db_general..cte_tmp_asientos_error

-- inicializaciones generales
select @s_error_comprb = 'N',
	   @v_error_comprb = 'N',
       @v_procesadas   = 0,
	   @s_procesadas   = 0

-- "Verifica_Procesos" -->
select @v_estado_proc = cc_estado
 from cob_cuentas..cc_control_contabilidad
 where cc_fecha = @e_fecha
   and cc_producto = 3
   and cc_transaccion = 'M'
select @v_estado_proc = isnull(@v_estado_proc, 'N')
if @v_estado_proc = 'N'
begin
  print 'NO SE HA EJECUTADO cctotmon.sqr ........'
  return 1
end
if @v_estado_proc = 'E'
begin
  print 'TODAVIA SE ESTA EJECUTANDO cctotmon.sqr ........'
  return 2
end

select @v_estado_proc = cc_estado
 from cob_cuentas..cc_control_contabilidad
 where cc_fecha = @e_fecha
   and cc_producto = 3
   and cc_transaccion = 'S'
select @v_estado_proc = isnull(@v_estado_proc, 'N')
if @v_estado_proc = 'N'
begin
  print 'NO SE HA EJECUTADO cctotser.sqr ........'
  return 3
end
if @v_estado_proc = 'E'
begin
  print 'TODAVIA SE ESTA EJECUTANDO cctotser.sqr ........'
  return 4
end
-- <-- "Verifica_Procesos"

-- "Borra_Repositorio" -->
begin transaction
 delete cob_cuentas..cc_sasiento
  where sa_fecha_tran = @e_fecha
    and sa_empresa    = @e_filial
    and sa_producto   = 3
 if @@error <> 0
 begin
   rollback transaction
   print 'ERROR AL ELIMINAR cob_cuentas..cc_sasiento'
   return 5
 end

 delete cob_cuentas..cc_scomprobante
  where sc_fecha_tran = @e_fecha
    and sc_empresa    = @e_filial
    and sc_producto   = 3
 if @@error <> 0
 begin
   rollback transaction
   print 'ERROR AL ELIMINAR cob_cuentas..cc_scomprobante'
   return 6
 end
commit transaction

truncate table cob_remesas..re_asientos_cc
-- <-- "Borra_Repositorio"

-- "Inicializaciones" -->
-- moneda base
select @v_moneda_base = em_moneda_base
 from cob_conta..cb_empresa
 where em_empresa = @e_filial
if @@rowcount = 0
begin
  print 'MONEDA BASE NO DEFINIDA'
  return 7
end

-- numero de decimales para moneda base
select @v_numdecbase = 0
if exists(select 1 from cobis..cl_moneda
           where mo_moneda = @v_moneda_base
             and mo_decimales = 'S')
 select @v_numdecbase = 2
-- <-- "Inicializaciones"

-- "Transacciones" -->
select @v_ult_trx = -1
declare cur_trx cursor for
 select distinct tr_tran = to_tipo_tran
  from cob_remesas..re_total

  order by to_tipo_tran
  for read only

open cur_trx
fetch cur_trx  into @v_tipo_tran

while @@sqlstatus = 0
begin
  truncate table cob_remesas..re_asientos_cc

  -- controles de quiebre
  select @v_leidos          = 0,
         @v_ult_moneda      = -1,
         @v_ult_of_org      = -1,
         @v_ult_cotiza      = -1,
         @v_trn_descripcion = null  -- para validacion de perfil

  -- "ContaTrx" -->
  select @v_asiento         = 0,
         @v_tot_credito_mn  = 0,             @v_tot_debito_mn   = 0,
         @v_tot_credito_me  = 0,             @v_tot_debito_me   = 0


  declare cur_total_tran cursor for
  select to_moneda,
         substring(tn_descripcion, 1, 50),
         to_ofic_orig,
         to_ofic_dest = case when dp_origen_dest = 'O' or (dp_codval = 322 and dp_perfil in ('3054', '3055'))
                                  then to_ofic_orig         -- PARA CUENTAS QUE SE MUEVEN SOLO EN OF. QUE ORIGINA LA TRANS.(DSC970908)
                             else      to_ofic_dest
                        end,
         to_causa,
         to_cotizacion,
         to_producto,         to_valor,            to_perfil,         to_codval,         to_valor_me,         to_tipo_contable,
         to_estado_sob,       to_tipo_sobregiro,   to_tipo_credito,   to_plazo,          to_ccontable,
         dp_cuenta,
         ti_signo   =  case when to_valor < 0 then -1 else 1 end,
         dp_debcred =  case when to_valor < 0
                                   then case when convert(tinyint, dp_debcred) = 2
                                           then 1
                                           else 2
                                        end
                            else   convert(tinyint, dp_debcred)
                       end,
         dp_constante,
         dp_origen_dest --,
  from cob_remesas..re_total
       left outer join cobis..cl_ttransaccion                   -- "Comprobar_Perfil"
           on tn_trn_code = to_tipo_tran
       inner join cob_conta..cb_det_perfil                      -- "Cuentas_Perfil" -->
             inner join cob_conta..cb_perfil                    -- <-- "Cuentas_Perfil"
                 on    dp_producto = pe_producto
                   and dp_perfil   = pe_perfil
                   and dp_empresa  = pe_empresa
           on    to_perfil   = dp_perfil
             and to_codval   = dp_codval
             and to_producto = dp_producto
  where to_producto  = 3
    and to_estado    = 'V'
    and to_tipo_tran = @v_tipo_tran
    and dp_empresa   = @e_filial
  order by to_moneda, to_ofic_orig, to_cotizacion, to_causa
  for read only

  open cur_total_tran
  fetch cur_total_tran
    into @v_moneda,         @v_trn_descripcion,         @v_ofic_orig,         @v_ofic_dest,         @v_causa,         @v_cotizacion,
         @v_producto,       @v_valor,                   @v_perfil,            @v_codval,            @v_valor_me,      @v_tipo_contable,
         @v_estado_sob,     @v_tipo_sobregiro,          @v_tipo_credito,      @v_plazo,             @v_ccontable,     @v_cuenta,
         @v_signo,          @v_debcred,                 @v_constante,         @v_origen_dest

  while @@sqlstatus = 0
  begin
    -- implementacion de validacion de perfil a nivel de quiebre
    if @v_trn_descripcion is null
    begin
       print 'no hay descipcoion de trx => procesar el siguiente registro... no ejecuta ningun proceso'
      fetch cur_total_tran
        into @v_moneda,         @v_trn_descripcion,         @v_ofic_orig,         @v_ofic_dest,         @v_causa,         @v_cotizacion,
             @v_producto,       @v_valor,                   @v_perfil,            @v_codval,            @v_valor_me,      @v_tipo_contable,
             @v_estado_sob,     @v_tipo_sobregiro,          @v_tipo_credito,      @v_plazo,             @v_ccontable,     @v_cuenta,
             @v_signo,          @v_debcred,                 @v_constante,         @v_origen_dest
      continue
    end

    -- inicializaciones x ciclo de cursor
    select @v_of_origen    = @v_ofic_orig,
           @v_of_destino   = @v_ofic_dest,
           @v_cuenta_final = '',
           @v_tipo_doc     = 'N'

      select @v_ult_moneda = @v_moneda
      select @v_ult_tip_tr = @v_tipo_tran
      select @v_ult_of_org = @v_ofic_orig

	select @v_debito_mn  = 0,
	       @v_debito_me  = 0,
	       @v_credito_mn = 0,
	       @v_credito_me = 0


    -- "Cuentas_Perfil" -->
--  print 'leo cuenta %1!, trx %2!, cau %3!, valor %4!, perfil %5!, codval %6!', @v_cuenta, @v_tipo_tran, @v_causa, @v_valor, @v_perfil, @v_codval
    if  ((@v_cuenta in ('2101.TCTA.05.MON.01', '2101.TCTA.10.MON.01', '2101.TCTA.15.MON.01', '2101.TCTA.20.MON.01', '2101.TCTA.25.MON.02') and @v_tipo_contable <> '0')
      or (@v_cuenta not in ('2101.TCTA.05.MON.01', '2101.TCTA.10.MON.01', '2101.TCTA.15.MON.01', '2101.TCTA.20.MON.01', '2101.TCTA.25.MON.02'))
      or (@v_cuenta = '4101.ITCTA.01'))             -- GYC 2010/Jun/24
    begin
-- print 'resolver cuenta %1!, trx %2!, cau %3!, valor %4!, perfil %5!, codval %6!', @v_cuenta, @v_tipo_tran, @v_causa, @v_valor, @v_perfil, @v_codval

      select @v_of_duenia = 99
      if isnull(@v_constante, '') not in ('N', '')
        select @v_of_duenia = convert(smallint, @v_constante)         --* OF. DUENIA DE CTA. CTBLE *

      -- "Resolver_Cuenta" -->
      --!* A partir de la cuenta dinamica determina la final con los parametros *!
      select @v_salir        = 0,
             @v_cuenta_aux   = @v_cuenta,
             @v_cuenta_final = ''

      while @v_salir = 0
      begin

        select @v_pos = charindex('.', @v_cuenta_aux, 1)
        if @v_pos = 0                                   -- No existen mas tramas
        begin
          select @v_trama = @v_cuenta_aux,
                 @v_salir = 1               -- marcar salida una vez armada la cuenta
        end
        else
        begin
          select @v_pos_ant = @v_pos - 1,
                 @v_pos_sig = @v_pos + 1
          select @v_trama      = substring(@v_cuenta_aux, 1, @v_pos_ant),
                 @v_cuenta_aux = substring(@v_cuenta_aux, @v_pos_sig, len(@v_cuenta_aux) + 1 - @v_pos_sig)
        end
        -- "Armar_Cuenta" -->
        select @v_return = 0
        exec @v_return = cob_cuentas.dbo.pa_cte_barmar_cuenta
                @e_filial                   = @e_filial,
                @e_trama                    = @v_trama,            -- por verificar OJO
                @e_estado_sob               = @v_estado_sob,
                @e_tipo_sobregiro           = @v_tipo_sobregiro,
                @e_tipo_credito             = @v_tipo_credito,
                @e_tipo_tran                = @v_tipo_tran,
                @e_codval                   = @v_codval,
                @e_tipo_contable            = @v_tipo_contable,
                @e_moneda                   = @v_moneda,
                @e_plazo                    = @v_plazo,
                @e_ccontable                = @v_ccontable,
                @s_cuenta_final             = @v_cuenta_final     out
        if @@error <> 0
          select @v_mensaje = 'ERROR EN PROCESO cob_cuentas..pa_cte_barmar_cuenta',
                 @v_return  = 8
        else
          if @v_return <> 0
            select @v_mensaje   = 'Retorno "cob_cuentas..pa_cte_barmar_cuenta": ' + convert(varchar, @v_return)
        if @v_return <> 0
          print @v_mensaje

        select @v_cuenta_final = ltrim(rtrim(@v_cuenta_final))
        -- <-- "Armar_Cuenta"
      end
--print '@v_cuenta_final:%1!', @v_cuenta_final 
      -- <-- "Resolver_Cuenta"

      -- GENERACION DEL VALOR EN MONEDA NACIONAL
      if @v_moneda <> @v_moneda_base
      begin
        --VIVI, 5/Ene/2004  !ESA 11MAY2005   !WMH 10AGO20005,
        if @v_tipo_tran not in (3770, 3775, 3774, 3208, 3870, 4007, 3874, 3875, 3909, 4317, 4319, 43565)    -- REF 31 (4317, 4319, 43565)
        begin
          -- "Calcular_Cotizacion" -->
          select @v_cotizacion = ct_compra
           from cob_conta..cb_cotizacion
           where ct_fecha  = @e_fecha
             and ct_moneda = @v_moneda
          if @@rowcount = 0
          begin
            print 'NO EXISTE COTIZACION PARA LA MONEDA %1!, EN LA FECHA %2!', @v_moneda, @e_fecha
            select @v_cotizacion = 0      -- JPM
          end
          -- <-- "Calcular_Cotizacion"
        end
      end
      else
        select @v_cotizacion = 0      -- tc 01162009

	if @v_debcred = 1
      	select 	@v_debito_mn  = @v_valor       * @v_signo,
        	@v_debito_me  = @v_valor_me    * @v_signo,
             	@v_credito_me = 0, @v_credito_me = 0 

	if @v_debcred = 2
	select 	@v_credito_mn = @v_valor       * @v_signo,
             	@v_credito_me = @v_valor_me    * @v_signo,
		@v_debito_mn = 0, @v_debito_me = 0

      -- acumular debitos/creditos
      select @v_tot_debito_mn  = @v_tot_debito_mn  + @v_debito_mn,            @v_tot_debito_me  = @v_tot_debito_me  + @v_debito_me,
             @v_tot_credito_mn = @v_tot_credito_mn + @v_credito_mn,           @v_tot_credito_me = @v_tot_credito_me + @v_credito_me

      -- backup trx/of.or/moneda <por analisis de error>
      select @v_tran   = @v_tipo_tran,             @v_origen = @v_ofic_orig,             @v_mon    = @v_moneda
--print '@v_debito_mn:%1! @v_credito_mn %2! @v_debito_me %3! @v_credito_me %4!', @v_debito_mn , @v_credito_mn,@v_debito_me,@v_credito_me
      select @v_total_todo = @v_debito_mn + @v_credito_mn + @v_debito_me + @v_credito_me

      -- PARA OFICINAS QUE SON DUENIAS DE LA CTA CTBLE QUE SE MUEVE (DSC970917) ==>
      if @v_of_duenia <> 99 and @v_of_destino <> @v_of_duenia
        select @v_of_destino = @v_of_duenia
      -- <== PARA OFICINAS QUE SON DUENIAS DE LA CTA CTBLE QUE SE MUEVE (DSC970917)

      select @v_asiento = @v_asiento  + 1
--print '@v_cuenta_final %1! @v_total_todo:%2!',@v_cuenta_final , @v_total_todo
      if @v_cuenta_final <> '' and @v_total_todo > 0
      begin
        -- "Generar_Asientos" -->
        select @v_cdebcred_str = convert(varchar, @v_debcred)

        select @v_dtr_concepto = @v_trn_descripcion + ' (' + convert(varchar, @v_tipo_tran) + ')'

        -- "Busca_Moneda" -->
        -- <<Busca moneda de la cuenta contable>>
        -- JPM se conserva codigo original comentado -->
        --if @v_of_destino > 99                             --**DSC      RE 19/DIC/2000
        --begin
        --   select @v_ofi = substring(convert(varchar, @v_of_destino), 1, 1) + substring(convert(@v_of_destino), 3, 1)
        --   select @v_ofic_dst = convert(smallint, @v_ofi)
        --else
        --   let @v_ofic_dst = @v_of_destino
        --end                                          --**DSC
        -- <-- JPM se conserva codigo original comentado

        select @v_moneda_cuenta = null
        select @v_moneda_cuenta = cu_moneda
         from cob_conta..cb_plan_general
              inner join cob_conta..cb_cuenta on cu_cuenta  = pg_cuenta
         where pg_empresa = @e_filial                                 --SIPECOM
           -- and pg_oficina = convert(tinyint, @v_ofic_dst)          --SIPECOM
           and pg_oficina = @v_of_destino                             --RCA 24/Feb/2003
           and pg_cuenta  = convert(char(20), @v_cuenta_final)
           and cu_empresa = @e_filial                                 --SIPECOM
        if @v_moneda_cuenta is not null
          select @v_moneda = @v_moneda_cuenta
          --select @v_moneda_asnto = moneda_cuenta
        -- <-- "Busca_Moneda"

-- print 'insert asiento (%7!) cuenta %1!, trx %2!, cau %3!, valorCR %4!, valorrDB %8!, perfil %5!, codval %6!', @v_cuenta_final, @v_tipo_tran, @v_causa, @v_credito_mn, @v_perfil, @v_codval, @v_asiento, @v_debito_mn
        insert into cob_remesas..re_asientos_cc
                   (ra_perfil, ra_tipo_tran, ra_asiento, ra_cuenta, ra_oficina_orig, ra_oficina_dest,
                    ra_area_dest, ra_credito, ra_debito, ra_concepto, ra_credito_me, ra_debito_me,
                    ra_moneda, ra_cotizacion, ra_tipo_doc, ra_producto, ra_debcred)
            values (@v_perfil, @v_tipo_tran, @v_asiento, @v_cuenta_final, @v_of_origen, @v_of_destino,
                    0, @v_credito_mn, @v_debito_mn, @v_dtr_concepto, @v_credito_me, @v_debito_me,         -- no se establece valor de #area en sqr
                    @v_moneda, @v_cotizacion, @v_tipo_doc, @v_producto, @v_cdebcred_str)
        if @@error <> 0
        begin
          print 'ERROR AL INSERTAR cob_remesas..re_asientos_cc (Ref. Asiento)'
        end

        -- <-- "Generar_Asientos"
      end
    end	-- del if de las cuentas rrrr
-- print '=> NEXT'
    select @v_constante = null          -- evitar que se quede el valor anterior <<validacion v_of_duenia>>
    select @v_trn_descripcion = null    -- validar existencia del perfil

    fetch cur_total_tran
    into @v_moneda,         @v_trn_descripcion,         @v_ofic_orig,         @v_ofic_dest,         @v_causa,         @v_cotizacion,
         @v_producto,       @v_valor,                   @v_perfil,            @v_codval,            @v_valor_me,      @v_tipo_contable,
         @v_estado_sob,     @v_tipo_sobregiro,          @v_tipo_credito,      @v_plazo,             @v_ccontable,     @v_cuenta,
         @v_signo,          @v_debcred,                 @v_constante,         @v_origen_dest

--print '@v_moneda:%1! @v_ult_moneda:%2! @v_ofic_orig:%3! @v_ult_of_org %4!,@@sqlstatus:%5!',@v_moneda,@v_ult_moneda,@v_ofic_orig,@v_ult_of_org,@@sqlstatus

      if ( @v_moneda <> @v_ult_moneda  or @v_tipo_tran <> @v_ult_tip_tr or @v_ofic_orig <> @v_ult_of_org ) or @@sqlstatus=2
      begin
        if @v_tot_credito_mn <> 0 or @v_tot_credito_me <> 0 or @v_tot_debito_mn <> 0 or @v_tot_debito_me <> 0
        begin
            print '===> GENERA COMPROBANTE  =>  @v_tipo_tran:%1!, @v_tot_credito_mn:%2!,@v_tot_credito_me:%3!',@v_tipo_tran, @v_tot_credito_mn , @v_tot_credito_me
            begin transaction       --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
            exec @v_return = dbo.pa_cte_bgenera_comprob_final
                    @e_filial                   = @e_filial,
                    @e_fecha                    = @e_fecha,
                    @e_tipo_tran                = @v_tipo_tran,
                    @s_procesadas               = @v_procesadas               out,
                    @s_error_comprb             = @v_error_comprb             out
            if @@error <> 0
              select @v_mensaje = ' - Error al ejecutar proceso: "cob_cuentas..pa_cte_bgenera_comprob_final"',
                     @v_return  = 9
            else
              if @v_return <> 0
                select @v_mensaje   = '- Retorno SP "cob_cuentas..pa_cte_bgenera_comprob_final": ' + convert(varchar, @v_return)

            if @v_return <> 0
               rollback transaction
            else
               commit transaction   --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

            select @s_procesadas = @s_procesadas + @v_procesadas

			if @v_error_comprb = 'S'
			begin
				insert into db_general..cte_tmp_asientos_error
					(
						ra_perfil,		ra_tipo_tran,	ra_asiento,		ra_cuenta,		ra_oficina_orig,	ra_oficina_dest,
						ra_area_dest,	ra_credito,		ra_debito,		ra_concepto,	ra_credito_me,		ra_debito_me,		
						ra_moneda,		ra_cotizacion,	ra_tipo_doc,	ra_producto,	ra_debcred
					)
				select 	ra_perfil,		ra_tipo_tran,	ra_asiento,		ra_cuenta,		ra_oficina_orig,	ra_oficina_dest,
						ra_area_dest,	ra_credito,		ra_debito,		ra_concepto,	ra_credito_me,		ra_debito_me,		
						ra_moneda,		ra_cotizacion,	ra_tipo_doc,	ra_producto,	ra_debcred
				from cob_remesas..re_asientos_cc
				if @@error <> 0
				begin
					print 'ERROR AL GUARDAR db_general..cte_tmp_asientos_error ...'
				end
				
				select @s_error_comprb = 'S'
			end

            truncate table cob_remesas..re_asientos_cc

            --inicializa totales
            select @v_asiento       = 0,
                 @v_tot_credito_mn  = 0,             @v_tot_debito_mn   = 0,
                 @v_tot_credito_me  = 0,             @v_tot_debito_me   = 0
        end
        if @v_moneda    <> @v_ult_moneda     select @v_ult_moneda = @v_moneda
        if @v_tipo_tran <> @v_ult_tip_tr     select @v_ult_tip_tr = @v_tipo_tran
        if @v_ofic_orig <> @v_ult_of_org     select @v_ult_of_org = @v_ofic_orig

      end
  end
  close cur_total_tran
  deallocate cursor cur_total_tran

  fetch cur_trx  into @v_tipo_tran

end

close cur_trx
deallocate cursor cur_trx

-- <-- "Transacciones"

-- borrar estructuras de extraccion y totalizacion de transacciones -->
if exists(select 1 from db_general..sysobjects where name = 'cte_tmp_monet_conta')
  drop table db_general.dbo.cte_tmp_monet_conta

-- if exists(select 1 from db_general..sysobjects where name = 'cte_tmp_re_total_m')
--     drop table db_general.dbo.cte_tmp_re_total_m
-- 
-- if exists(select 1 from db_general..sysobjects where name = 'cte_tmp_serv_conta')
--   drop table db_general.dbo.cte_tmp_serv_conta
-- 
-- if exists(select 1 from db_general..sysobjects where name = 'cte_tmp_re_total_s')
--     drop table db_general.dbo.cte_tmp_re_total_s

-- <-- borrar estructuras de extraccion y totalizacion de transacciones


return 0
go

if exists(select 1 from sysobjects where name='pa_cte_bgenera_comprob_contab' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_cte_bgenera_comprob_contab *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_cte_bgenera_comprob_contab -- ERROR -- >>>'
go

