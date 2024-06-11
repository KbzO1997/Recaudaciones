/************************************************************************/
/*  Archivo:            ahgencpr.sp                                     */
/*  Motor BD:           sybase                                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Aplicacion:         CUENTAS AHJORROS                                */
/*  Stored procedure:   pa_aho_bgencom_proc                             */
/*  Disenado por:       Christian Vera T.                               */
/*  Fecha de escritura: 30/Oct/2020                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "BANCO BOLIVARIANO".                                                 */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.       */
/************************************************************************/
/* Se encarga de calcular los totales de las transacciones monetarias   */
/* del dia a contabilizar.  Estos totales se almacenan en re_total      */
/************************************************************************/
/* MODIFICACIONES                                                       */
/************************************************************************/
/* REF  FECHA          AUTOR            RAZON                           */
/*   1  30/Oct/2020  J.Pazminno        Tunning - Transformar SQR ==> SP */
/*                                     Tarea:   CTE-CC-SGC00040520      */
/************************************************************************/
use cob_ahorros
go

if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_asientos_error')
  drop table db_general.dbo.aho_tmp_asientos_error
go

create table db_general.dbo.aho_tmp_asientos_error(
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

if exists (select 1 from sysobjects where name = "pa_aho_bgencom_proc" and type='P')
  begin
    drop procedure  dbo.pa_aho_bgencom_proc
    if exists (select 1 from sysobjects where name = 'pa_aho_bgencom_proc' and type = 'P')
      PRINT '<<< DROP PROCEDURE pa_aho_bgencom_proc -- ERROR -- >>>'
    else
      PRINT '== DROP PROCEDURE pa_aho_bgencom_proc *OK* =='
  end
go

create procedure dbo.pa_aho_bgencom_proc (
@e_filial           tinyint,
@e_fecha_proceso    datetime, /* formato MM/DD/YYYY*/
@s_procesadas       int out,
@s_error_comprb     char(1)      out,
@s_mensaje          varchar(100) out,
@s_tot_debito       money out,
@s_tot_credito      money out
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
@v_causa                    varchar(4),
@v_cotizacion               float,
@v_perfil                   varchar(10),
@v_valor                    money,
@v_producto                 tinyint,
@v_cuenta                   varchar(40),
@v_signo                    smallint,
@v_debcred                  tinyint,
@v_constante                varchar(3),
@v_origen_dest              char(1),            -- <-- cursor <<total_tran>>
@v_ult_moneda               smallint,           -- variables de quiebre -->
@v_ult_of_org               smallint,
@v_ult_tip_tr               int,
@v_of_origen                smallint,
@v_of_destino               smallint,
@v_cuenta_final             varchar(30),
@v_asiento                  int,
@v_tot_credito_mn           money,
@v_tot_debito_mn            money,
@v_total_todo               money,
@v_salir                    bit,
@v_codval                   smallint,
@v_valor_me                 money,
@v_cuenta_aux               varchar(40),
@v_trama                    varchar(40),
@v_clave                    varchar(40),
@v_resultado                varchar(40),
@v_to_monto_mn              money,
@v_to_monto_me              money,
@v_debito                   money,
@v_debito_me                money,
@v_credito                  money,
@v_dtr_concepto             varchar(50),
@v_credito_me               money,
@v_tot_debito_me            money,
@v_s_debcred                char(1),
@v_ascii                    int,
@v_pos                      smallint,
@v_pos_ant                  smallint,
@v_pos_sig                  smallint,
@v_of_duenia                smallint,
@v_procesadas               int,
@v_s_perfil                 varchar(10),
@v_error_comprb             char(1),
@v_area                     smallint,
@v_tipo_doc                 char(1),
@v_tot_credito_me           money,
@v_return                   int,
@v_usuario                  varchar(64),
@v_mensaje                  varchar(100)

truncate table db_general..aho_tmp_asientos_error

-- inicializaciones generales
select @s_error_comprb = 'N',
       @v_procesadas   = 0,
       @v_error_comprb = 'N',
       @v_tipo_doc     = 'N',
       @v_area         = 80,
       @v_usuario      = suser_name()

-- "Verifica_Procesos" -->
select @v_estado_proc = cc_estado
 from cob_cuentas..cc_control_contabilidad
 where cc_fecha = @e_fecha_proceso
   and cc_producto = 4
   and cc_transaccion = 'M'
select @v_estado_proc = isnull(@v_estado_proc, 'N')
if @v_estado_proc = 'N'
begin
  print 'NO SE HA EJECUTADO ahtotmon.sqr ........'
  return 1
end
if @v_estado_proc = 'E'
begin
  print 'TODAVIA SE ESTA EJECUTANDO ahtotmon.sqr ........'
  return 2
end

select @v_estado_proc = cc_estado
 from cob_cuentas..cc_control_contabilidad
 where cc_fecha = @e_fecha_proceso
   and cc_producto = 4
   and cc_transaccion = 'S'
select @v_estado_proc = isnull(@v_estado_proc, 'N')
if @v_estado_proc = 'N'
begin
  print 'NO SE HA EJECUTADO ahtotser.sqr ........'
  return 3
end
if @v_estado_proc = 'E'
begin
  print 'TODAVIA SE ESTA EJECUTANDO ahtotser.sqr ........'
  return 4
end
-- <-- "Verifica_Procesos"

-- "Borra_Repositorio" -->
begin transaction
 delete cob_ahorros..ah_sasiento
  where sa_fecha_tran = @e_fecha_proceso
    and sa_empresa    = @e_filial
    and sa_producto   = 4
 if @@error <> 0
 begin
   rollback transaction
   print 'ERROR AL ELIMINAR cob_ahorros..ah_sasiento'
   return 5
 end

 delete cob_ahorros..ah_scomprobante
  where sc_fecha_tran = @e_fecha_proceso
    and sc_empresa    = @e_filial
    and sc_producto   = 4
 if @@error <> 0
 begin
   rollback transaction
   print 'ERROR AL ELIMINAR cob_ahorros..ah_scomprobante'
   return 6
 end
commit transaction

truncate table cob_remesas..re_asientos_ah
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
declare cur_trx cursor for
 select distinct tr_tran = to_tipo_tran
  from cob_remesas..re_total_ah
  order by to_tipo_tran
  for read only

open cur_trx
fetch cur_trx  into @v_tipo_tran

while @@sqlstatus = 0
begin
  truncate table cob_remesas..re_asientos_ah

  -- controles de quiebre
	select @v_ult_moneda = convert(smallint, -1), @v_ult_of_org = -1, @v_ult_tip_tr = -1
  select @v_trn_descripcion = null  -- para validacion de perfil

  select @v_asiento         = 0,             @v_error_comprb    = 'N',
         @v_tot_credito_mn  = 0,             @v_tot_debito_mn   = 0,
         @v_tot_credito_me  = 0,             @v_tot_debito_me   = 0

  -- "ContaTrx" -->
  --*-* RRRR
  declare cur_total_tran cursor for
  select to_moneda,
         oficina_origen  = to_ofic_orig,
         oficina_destino = case when dp_origen_dest = 'O'
                                  then to_ofic_orig         -- PARA CUENTAS QUE SE MUEVEN SOLO EN OF. QUE ORIGINA LA TRANS.(DSC970908)
                             else      to_ofic_dest
                            end,
         to_causa,
         to_cotizacion,
         to_producto,
         to_valor,
         to_perfil,
         to_codval,
         to_valor_me,
         substring(tn_descripcion, 1, 50),
         dp_cuenta,
         ti_signo   =  case when to_valor < 0 then -1 else 1 end,
         dp_debcred = convert(tinyint, dp_debcred),
         dp_constante,
         dp_origen_dest --,
  from cob_remesas..re_total_ah
       inner join cobis..cl_ttransaccion                        -- "Comprobar_Perfil"
           on tn_trn_code = to_tipo_tran
       inner join cob_conta..cb_det_perfil                      -- "Cuentas_Perfil" -->
             inner join cob_conta..cb_perfil                    -- <-- "Cuentas_Perfil"
                 on    dp_producto = pe_producto
                   and dp_perfil   = pe_perfil
                   and dp_empresa  = pe_empresa
           on    to_perfil   = dp_perfil
             and to_codval   = dp_codval
             and to_producto = dp_producto
  where to_producto  = 4
    and to_estado    = 'V'
    and to_tipo_tran = @v_tipo_tran
    and dp_empresa   = @e_filial
  order by to_moneda, to_ofic_orig, to_cotizacion, to_causa
  for read only

  open cur_total_tran
  fetch cur_total_tran
    into @v_moneda,         @v_ofic_orig,         @v_ofic_dest,         @v_causa,         @v_cotizacion,              @v_producto,
         @v_valor,          @v_perfil,            @v_codval,            @v_valor_me,      @v_trn_descripcion,         @v_cuenta,
         @v_signo,          @v_debcred,           @v_constante,         @v_origen_dest

  while @@sqlstatus = 0
  begin

    -- inicializaciones x ciclo de cursor
    select @v_of_origen    = @v_ofic_orig,
           @v_of_destino   = @v_ofic_dest,
           @v_cuenta_final = ''

    select @v_ult_moneda = @v_moneda
    select @v_ult_tip_tr = @v_tipo_tran
    select @v_ult_of_org = @v_ofic_orig
    
    select @v_debito  = 0,
           @v_debito_me  = 0,
           @v_credito = 0,
           @v_credito_me = 0

    -- Cuentas_Perfil - INI >>>>>>>>>>>>>>>>>>
    select	@v_of_duenia = 99,
            @v_cuenta_final = ''
    if (isnull(@v_constante, '') not in ('N', ''))
    begin
      set @v_of_duenia = convert(smallint, @v_constante)
    end

    --------------------------------------------------------
    --	>>	Resolver_Cuenta - Ini -- ARMA LA CUENTA CONTABLE
    --------------------------------------------------------
    set @v_salir = 0
    set @v_cuenta_aux = @v_cuenta

    while @v_salir = 0
    begin
      set @v_pos = charindex('.', @v_cuenta_aux) -- ANTES: charindex('.', @v_cuenta_aux, 1) -> por soporte ver. Sybase-15
      if @v_pos = 0 -- No existen mas tramas
      begin
        set @v_trama = @v_cuenta_aux

        -- Armar_Cuenta - Ini --
        set @v_ascii = ascii(substring(@v_trama, 1, 1))
        if (@v_ascii >= 48 and @v_ascii <= 57) --Numerico, parte fija
        begin
          set @v_cuenta_final = @v_cuenta_final + @v_trama
        end
        else
        begin
          set @v_clave =  convert(varchar, @v_moneda)   --OJOOOOOO

          --	>>	Extraer_Valor - Ini --
          select @v_resultado = re_substring
          from cob_conta..cb_relparam
            where re_empresa = @e_filial
              and re_parametro = convert(varchar(10), @v_trama)
              and re_clave = convert(varchar(20), @v_clave)
          --	>>	Extraer_Valor - Fin --

          if (@@rowcount > 0)
          begin
            set @v_cuenta_final = @v_cuenta_final + isnull(@v_resultado, '')
          end
        end

        -- Armar_Cuenta - Fin --
        set @v_salir = 1
      end
      else
      begin
        set @v_pos_ant = @v_pos - 1
        set @v_pos_sig = @v_pos + 1
        set @v_trama = substring (@v_cuenta_aux, 1, @v_pos_ant)
        set @v_cuenta_aux = substring(@v_cuenta_aux, @v_pos_sig, len(@v_cuenta_aux) + 1 - @v_pos_sig)

        -- Armar_Cuenta - Ini --
        set @v_ascii = ascii(substring(@v_trama, 1, 1))
        if (@v_ascii >= 48 and @v_ascii <= 57) --Numerico, parte fija
        begin
          set @v_cuenta_final = @v_cuenta_final + @v_trama
        end
        else
        begin
          set @v_clave =  convert(varchar, @v_moneda)   --OJOOOOOO

          --	>>	Extraer_Valor - Ini --
          select @v_resultado = re_substring
          from cob_conta..cb_relparam
            where re_empresa = @e_filial
              and re_parametro = convert(varchar(10), @v_trama)
              and re_clave = convert(varchar(20), @v_clave)

          --	>>	Extraer_Valor - Fin --
          if (@@rowcount > 0)
          begin
            set @v_cuenta_final = @v_cuenta_final + isnull(@v_resultado, '')
          end
        end
        -- Armar_Cuenta - Fin --
      end
    end
    set @v_cuenta_final = ltrim(rtrim(@v_cuenta_final))
		--	>>	Resolver_Cuenta - Fin --

    select @v_asiento = (@v_asiento  + 1),
           @v_to_monto_mn = @v_valor,
           @v_to_monto_me = @v_valor_me
    
    if (@v_to_monto_mn <  0) -- Cambiar el debito por el credito y viceversa
    begin
      if (@v_debcred = 2)
      begin
        set @v_debcred = 1
      end
      else
      begin
        set @v_debcred = 2
      end
      select @v_to_monto_mn = ( @v_to_monto_mn * -1 ),
             @v_to_monto_me = ( @v_to_monto_me * -1 )
    end

    select @v_debito         = ( @v_to_monto_mn  * (2 - @v_debcred) ),
           @v_debito_me      = ( @v_to_monto_me  * (2 - @v_debcred) ),
           @v_credito        = ( @v_to_monto_mn  * (@v_debcred - 1) ),
           @v_credito_me     = ( @v_to_monto_me  * (@v_debcred - 1) ),
           @v_credito_me     = ( @v_to_monto_me  * (@v_debcred - 1) )
           
    select @v_total_todo     = @v_debito + @v_credito + @v_debito_me + @v_credito_me
    -- acumular debitos/creditos
    select @v_tot_debito_mn  = @v_tot_debito_mn  + @v_debito,
           @v_tot_debito_me  = @v_tot_debito_me  + @v_debito_me,
           @v_tot_credito_mn = @v_tot_credito_mn + @v_credito,
           @v_tot_credito_me = @v_tot_credito_me + @v_credito_me

    -- PARA OFICINAS QUE SON DUENIAS DE LA CTA CTBLE QUE SE MUEVE (DSC970917)
    if ( (@v_of_duenia <> 99) and (@v_of_destino <> @v_of_duenia) )
    begin
      set @v_of_destino = @v_of_duenia
    end

    if ( @v_cuenta_final <> '' and  @v_total_todo > 0 )
    begin
      -- Generar_Asientos - Ini --
      if (@v_debito = 0)
        set @v_s_debcred = '2'
      else
        set @v_s_debcred = '1'
      
      select	@v_dtr_concepto = ( @v_trn_descripcion + ' (' + convert(varchar, @v_tipo_tran) + ')' ),
              @v_moneda    = @v_moneda,
              @v_s_perfil  = @v_perfil

      --	>>	Busca_Moneda - Ini --

      select	@v_moneda = cu_moneda
       from cob_conta..cb_plan_general
        inner join cob_conta..cb_cuenta
            on cu_empresa = pg_empresa and cu_cuenta  = pg_cuenta
       where pg_empresa = @e_filial and
             pg_oficina = @v_of_destino and
             pg_cuenta  = convert(char(20), @v_cuenta_final)
      --	>>	Busca_Moneda - Fin --

      insert into cob_remesas..re_asientos_ah
             (ra_perfil, ra_tipo_tran, ra_asiento, ra_cuenta, ra_oficina_orig,
              ra_oficina_dest, ra_area_dest, ra_credito, ra_debito, ra_concepto, ra_credito_me,
              ra_debito_me, ra_moneda, ra_cotizacion, ra_tipo_doc, ra_producto, ra_debcred, ra_codval)
      values (@v_s_perfil, @v_tipo_tran, @v_asiento, @v_cuenta_final, @v_of_origen,
              @v_of_destino, @v_area, @v_credito, @v_debito, @v_dtr_concepto, @v_credito_me,
              @v_debito_me, @v_moneda, @v_cotizacion, @v_tipo_doc, @v_producto, @v_s_debcred, @v_codval)
      if @@error <> 0
        print 'ERROR EN INSERCION cob_remesas..re_asientos_ah (Generar_Asientos)'
      else
        set @s_procesadas = @s_procesadas + 1
      -- Generar_Asientos - Fin --
    end
    
    -- Cuentas_Perfil - FIN <<<<<<<<<<<<<<<<<<
    
    
    
        
    select @v_constante = null          -- evitar que se quede el valor anterior <<validacion v_of_duenia>>

    fetch cur_total_tran
      into @v_moneda,         @v_ofic_orig,         @v_ofic_dest,         @v_causa,         @v_cotizacion,              @v_producto,
           @v_valor,          @v_perfil,            @v_codval,            @v_valor_me,      @v_trn_descripcion,         @v_cuenta,
           @v_signo,          @v_debcred,           @v_constante,         @v_origen_dest
    if ( @v_moneda <> @v_ult_moneda  or @v_tipo_tran <> @v_ult_tip_tr or @v_ofic_orig <> @v_ult_of_org ) or @@sqlstatus=2
    begin
      if @v_tot_credito_mn <> 0 or @v_tot_credito_me <> 0 or @v_tot_debito_mn <> 0 or @v_tot_debito_me <> 0
      begin
          print '===> GENERA COMPROBANTE  =>  tran:%1!, @v_tot_credito_mn:%2!,@v_tot_credito_me:%3!',@v_tipo_tran, @v_tot_credito_mn , @v_tot_credito_me

 
          begin transaction       --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
          exec @v_return = dbo.pa_aho_bgenera_comprob_final
                  @e_filial                   = @e_filial,
                  @e_fecha    	              = @e_fecha_proceso,
                  @e_username                 = @v_usuario,
                  @e_tipo_tran                = @v_tipo_tran,
                  @s_procesadas               = @v_procesadas               out,
                  @s_error_comprb             = @v_error_comprb             out,
                  @s_mensaje                  = @v_mensaje                  out,
                  @s_tot_debito               = @v_tot_debito_mn            out,
                  @s_tot_credito              = @v_tot_credito_mn           out
          if @@error <> 0
            select @v_mensaje = ' - Error al ejecutar proceso: "cob_cuentas..pa_aho_bgenera_comprob_final"',
                   @v_return  = 9
          else
            if @v_return <> 0
              select @v_mensaje   = '- Retorno SP "cob_cuentas..pa_aho_bgenera_comprob_final": ' + convert(varchar, @v_return)

          if @v_return <> 0
             rollback transaction
          else
             commit transaction   --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

          if @v_error_comprb = 'S'
          begin
            insert into db_general..aho_tmp_asientos_error
                   (ra_perfil, ra_tipo_tran, ra_asiento, ra_cuenta, ra_oficina_orig, ra_oficina_dest, ra_area_dest, ra_credito, ra_debito,
                    ra_concepto, ra_credito_me, ra_debito_me, ra_moneda, ra_cotizacion, ra_tipo_doc, ra_producto, ra_debcred)
             select ra_perfil, ra_tipo_tran, ra_asiento, ra_cuenta, ra_oficina_orig, ra_oficina_dest, ra_area_dest, ra_credito, ra_debito,
                    ra_concepto, ra_credito_me, ra_debito_me, ra_moneda, ra_cotizacion, ra_tipo_doc, ra_producto, ra_debcred
              from cob_remesas..re_asientos_ah
            if @@error <> 0
            begin
              print 'Error al grabar informacion en tabla db_general..aho_tmp_asientos_error'
            end
            select @s_error_comprb = 'S',
                   @s_mensaje      = @v_mensaje
          end
          select @s_procesadas  = @s_procesadas  + @v_procesadas,
                 @s_tot_debito  = @s_tot_debito  + @v_tot_debito_mn,
                 @s_tot_credito = @s_tot_credito + @v_tot_credito_mn
          truncate table cob_remesas..re_asientos_ah

          --inicializa totales
          select @v_asiento         = 0,
                 @v_tot_credito_mn  = 0,             @v_tot_debito_mn   = 0,
                 @v_tot_credito_me  = 0,             @v_tot_debito_me   = 0
      end
      if @v_moneda    <> @v_ult_moneda     select @v_ult_moneda = @v_moneda
      if @v_tipo_tran <> @v_ult_tip_tr     select @v_ult_tip_tr = @v_tipo_tran
      if @v_ofic_orig <> @v_ult_of_org     select @v_ult_of_org = @v_ofic_orig

    end
  end   -- while cur_total_tran
  close cur_total_tran
  deallocate cursor cur_total_tran
  

  fetch cur_trx  into @v_tipo_tran
end     -- while cur_trx

close cur_trx
deallocate cursor cur_trx
-- <-- "Transacciones"

-- borrar estructuras de extraccion y totalizacion de transacciones -->
if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_monet_conta')
  drop table db_general.dbo.aho_tmp_monet_conta

--  estructuras pemdientes: usadas por "procesos parciales" y "totalizadores servicio"
--if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_re_total_m')
--    drop table db_general.dbo.aho_tmp_re_total_m

--  estructuras pemdintes: usadas por "totalizadores servicio"
--if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_serv_conta')
--  drop table db_general.dbo.aho_tmp_serv_conta

--if exists(select 1 from db_general..sysobjects where name = 'aho_tmp_re_total_s')
--    drop table db_general.dbo.aho_tmp_re_total_s
-- <-- borrar estructuras de extraccion y totalizacion de transacciones
return 0
go

if exists(select 1 from sysobjects where name='pa_aho_bgencom_proc' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_aho_bgencom_proc *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_aho_bgencom_proc -- ERROR -- >>>'
go
