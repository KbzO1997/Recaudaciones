/************************************************************************/
/*  Archivo:            updtot.sp_rc                                    */
/*  Stored procedure:   sp_upd_totales_rc                             	*/
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Xavier Gellibert Coello.                        */
/*  Fecha de escritura: 08-Nov-1994                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECESABREC-107                                */
/*  Ult.Referencia:     REF 2                                           */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa la actualizacion en la tabla de totales       */
/*              MODIFICACIONES                                          */
/* REF FECHA       AUTOR           TAREA RATIONAL   DESCRIPCION         */
/*  08/Nov/1994 X Gellibert C.  Emision inicial                         */
/*  11/Nov/1995 J.Gordillo  Inclusion de Producto                       */
/*      14/Ago/1997     Sophia Proano   Cambio num.tran. 4222 por 3042  */
/*  09/May/2001 Rosa Castillo   Registrar la causa de la transa.        */
/*                  Pago de Agua.                                       */
/*  31/May/2001 Rosa Castillo   Registro de la inf. de cortes           */
/*  02/Dic/2001 Rosa Castillo   Generar Dos tipos de Cortes por         */
/*                              los depositos: Efectivo y Cheque        */
/*  28/May/2003 Sipecom         Cuadre de Caja                          */
/*  15/Feb/2004 SIPECOM          Flujo de Caja                          */
/*  30Mayo2006  Mauricio Echeverría Ctas virtuales                      */
/*  22/AGO/2006 J.LOZANO  Adaptación para canje de euros. Nuevo         */
/*                              tipo 'CJE' y nuevas trasacciones.       */
/*  27/Oct/2008 Freddy J R. Validar Tran = 3374 Para F.E entre ofic.    */
/*  12 03/jun/2010 T. Cervantes Z. CTE-CC-8833      Incluir nuevas tran-*/
/*                          sacciones de entrega/recepcion de efectivo. */
/*  13 30/10/2010  J.Pazmino    Actualizar efectivo on-line para Puntos */
/*                 (SIPECOM)    de Atencion                             */
/*                              Tarea CTE-CC-9230                       */
/*  31/Ene/2020  Galo Yanez	Caja Verde				*/
/*				Tarea: CAJVER-AP-SGC00037659-SGC00037660*/
/*  2 13/Dic/2022 Kevin Bastidas  RECESABREC-107  Agregar tipo cta CH y TC*/
/************************************************************************/
use cob_remesas
go

--if exists (select 1 from sysobjects where name = 'sp_upd_totales_rc')
--    drop proc sp_upd_totales_rc
--go

if exists(select 1 from sysobjects where name = 'sp_upd_totales_rc' and type = 'P')
begin
   drop procedure dbo.sp_upd_totales_rc
   if exists (select 1 from sysobjects where name = 'sp_upd_totales_rc' and type = 'P')
     print '<<< DROP PROCEDURE sp_upd_totales_rc -- ERROR -- >>>'
    else
     print '== DROP PROCEDURE sp_upd_totales_rc *OK* =='
end
go

create proc dbo.sp_upd_totales_rc (
     @i_ofi          smallint,
     @i_rol          smallint,
     @i_user         login,
     @i_producto     char(3),
     @i_mon          tinyint,
     @i_trn          int,
     @i_nodo         descripcion,
     @i_tipo         char(1) = 'L',
     @i_corr         char(1) = 'N',
     @i_efectivo     money = 0,     -- valor efectivo   
     @i_cheque       money = 0,     -- total cheques
     @i_chq_locales  money = 0,
     @i_chq_ot_plaza money = 0,
     @i_otros        money = 0,     -- nd nc
     @i_interes      money = 0,
     @i_adj_int      money = 0,
     @i_adj_cap      money = 0,
     @i_causa        varchar(6) = '',     -- RCA 09/May/2001
     @i_efecto_chq   money = 0,
     @i_efecto_odb   money = 0,
     @i_nc_fiscales  money = 0,
     @i_tarjetas     money = 0,
     @i_retencion    money = 0,
     @i_depto        money = 0,
     @i_cant_chq     int = 0 ,
     @i_tipocta      char(3) = null,
     @i_ubi          int = 0,
     @e_verde	     char(1) = 'N'		-- GYC 2020/Feb/06
)
as

declare --@w_return      int,
    @w_sp_name     varchar(30),
    @w_fecha           datetime, 
    @w_fecha_corte     datetime,  -- RCA 25/Jun/2001
    @w_fecha_siguiente datetime,  -- RCA 28/Jun/2001
    @w_factor          int, 
    @w_afecta_corte    char(1),   -- RCA 01/Jun/2001
    @w_tipo_corte      char(3),   -- RCA 01/Jun/2001
    @w_num_corte       tinyint,   -- RCA 01/Jun/2001
    @w_campo_debito    char(1),   -- RCA
    @w_horario_corte   char(1),   -- RCA 25/jun/2001
    @w_ciudad      smallint,      -- RCA 25/jun/2001
    @w_corte_efectivo  char(1),   -- RCA 02/Ene/2002
    @w_tipo_corefe     char(3),   -- RCA 02/Ene/2002
    @w_fecha_hoy       char(10),
    @w_ndah            money,
    @w_ndcc            money,
    @w_error_ptoate    int,       -- Ref. 13
    @w_punto_atencion  smallint,  -- Ref. 13
    @w_tipo_punto_ate  tinyint,   -- Ref. 13
    @w_existe          char(1),   -- Ref. 13
    @w_estado_pto_ate  char(1),   -- Ref. 13
    @w_afecta_efectivo char(1),   -- Ref. 13
    @w_signo           int,       -- Ref. 13
    @w_cotizacion      float      -- Ref. 13
    
/* Captura nombre de Stored Procedure */
select @w_sp_name = 'sp_upd_totales_rc'

select @w_fecha   = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha_hoy = convert(char(10), getdate(),101)

/*** if @i_ubi is NULL 
    select @i_ubi = lr_ubicacion 
               from cob_remesas..re_login_rol
               where lr_login   = @i_user
               and   lr_oficina = @i_ofi
               and   lr_rol     = @i_rol
               and convert(varchar(10), lr_fecha_in,101) = convert(char(10), getdate(), 101)
               and   lr_fecha_out = null ***/

if @i_ubi is NULL   
   select @i_ubi = 0

if @i_corr = 'N'
     select @w_factor = 1
else select @w_factor = -1


/*Ref. 13: */
select @w_error_ptoate = 0
/*Validar punto de atencion*/
select @w_punto_atencion = ou_punto_atencion,
       @w_tipo_punto_ate = ou_tipo_punto_atencion
 from cob_remesas..re_ofic_ubicacion
 where ou_oficina = @i_ofi
   and ou_ubicacion = @i_ubi

  -- NO EXISTE LA UBICACION
if @@rowcount = 0
  select @w_error_ptoate = 300003189
else
  -- NO ESTA DEFINIDO EL PUNTO DE ATENCION, PARA LA OFICINA-UBICACION
  if @w_punto_atencion is null or @w_tipo_punto_ate is null
    select @w_error_ptoate = 300003179

if @w_error_ptoate = 0
begin
  select @w_estado_pto_ate = pa_estado
   from cob_remesas..re_punto_atencion
   where pa_punto_atencion = @w_punto_atencion
    -- PUNTO DE ATENCION NO EXISTE
  if @@rowcount = 0
    select @w_error_ptoate = 300003306

    -- ESTADO DEL PUNTO DE ATENCION DEBE SER VIGENTE
  if @w_estado_pto_ate = 'I'
    select @w_error_ptoate = 300003307

  select @w_existe = 'N'
  if exists(select 1
             from cob_remesas..re_det_tipo_punto_atencion
             where dt_punto_atencion = @w_punto_atencion
               and dt_tipo_punto_atencion = @w_tipo_punto_ate)
    select @w_existe = 'S'
  else
    -- TIPO DEL PUNTO DE ATENCION NO EXISTE
    select @w_error_ptoate = 300003308
end
/*Ref. 13 */


/* Validacion del tipo de Producto */
--30Mayo2006 añadió producto VIR 
if @i_producto not in ('CTE','AHO','APE','VIR', 'CJE') 
begin
     exec cobis..sp_cerror
          @t_debug  = null,
          @t_file   = null,
          @t_from   = @w_sp_name,
          @i_num    = 351105
     return 1
end

--jlf nuevas transacciones    22-8-2006
--if @i_producto = 'APE' and @i_trn not in (4105,4107,4106,3015,3042,4222,3377)   Sofpro 14/08/97 
if @i_producto = 'APE' and @i_trn not in (4105,4107,4106,3015,3042,4222,3377,3374,
3730,3731,3732,3734,3736,3382,3380,3386,3388,3394,3387,3389,3381,3379,3385) --ref12: Transacciones de entrega/recepcion de efectivo
begin /* Error en el codigo de la transaccion */
     exec cobis..sp_cerror
          @t_debug  = null,
          @t_file   = null,
          @t_from   = @w_sp_name,
          @i_num    = 031048
     return 1
end

if @i_tipocta = 'AHO' 
   begin
     select @w_ndah = @i_otros,
            @w_ndcc = 0,
            @i_otros = 0
   end
if @i_tipocta = 'CTE' 
   begin
     select @w_ndcc = @i_otros,
            @i_otros = 0,
            @w_ndah = 0
   end 
if @i_tipocta = 'VIR' 
   begin
     select @w_ndah = @i_otros,
            @w_ndcc = 0,
            @i_otros = 0
   end 

if @i_tipocta = 'CJE' --jlf 22-08-2006
   begin
     select @w_ndah = @i_otros,
            @w_ndcc = 0,
            @i_otros = 0
   end 
  
  --<REF 2, KBastida Add tipo cta EF CH y TC evita null en cta y deb
  --if @i_tipocta = 'EF' or @i_tipocta = 'CH' or @i_tipocta = 'TC'
  --begin
  --   select @w_ndcc = 0,
  --          @i_otros = 0,
  --          @w_ndah = 0
  -- end 
 --REF 2>

 PRINT 'Variable 1 = %1!', @i_efectivo 
 PRINT 'Variable 2 = %1!', @i_otros 
 PRINT 'Variable 3 = %1!', @w_ndah 
 PRINT 'Variable 4 = %1!', @w_ndcc 
 
/*  Actualizacion de totales de cajero  */
begin tran
if exists (select 1 from cob_remesas..re_caja
            where cj_oficina     = @i_ofi
              and cj_rol         = @i_rol
              and cj_operador    = @i_user
              and cj_producto    = @i_producto
              and cj_moneda      = @i_mon
              and cj_transaccion = @i_trn 
              and cj_causa       = @i_causa
              and cj_ubicacion   = @i_ubi
              and cj_fecha_real  = @w_fecha_hoy)  -- RCA 09/May/2001
begin
    update cob_remesas..re_caja
       set cj_numero       = cj_numero       + @w_factor, 
           cj_efectivo     = cj_efectivo     + (@i_efectivo * @w_factor),
           cj_cheque       = cj_cheque       + (@i_cheque   * @w_factor),
           cj_chq_locales  = cj_chq_locales  + (@i_chq_locales * @w_factor),
           cj_chq_ot_plaza = cj_chq_ot_plaza + (@i_chq_ot_plaza * @w_factor),
           cj_otros        = cj_otros        + (@i_otros    * @w_factor),
           cj_ndah         = cj_ndah         + (@w_ndah    * @w_factor),
           cj_ndcc         = cj_ndcc         + (@w_ndcc    * @w_factor),
           cj_interes      = cj_interes      + (@i_interes  * @w_factor),
           cj_ajuste_int   = cj_ajuste_int   + (@i_adj_int  * @w_factor),
           cj_ajuste_cap   = cj_ajuste_cap   + (@i_adj_cap  * @w_factor),
           cj_efecto_chq   = cj_efecto_chq   + (@i_efecto_chq * @w_factor),
           cj_efecto_odb   = cj_efecto_odb   + (@i_efecto_odb * @w_factor),
           cj_nc_fiscales  = cj_nc_fiscales  + (@i_nc_fiscales * @w_factor),
           cj_tarjetas     = cj_tarjetas     + (@i_tarjetas * @w_factor),
           cj_retencion    = cj_retencion    + (@i_retencion * @w_factor),
           cj_depto        = cj_depto        + (@i_depto * @w_factor),
           cj_cant_chq     = cj_cant_chq     + (@i_cant_chq * @w_factor)
     where cj_oficina      = @i_ofi
       and cj_rol          = @i_rol
       and cj_operador     = @i_user
       and cj_producto     = @i_producto
       and cj_moneda       = @i_mon
       and cj_transaccion  = @i_trn 
       and cj_causa        = @i_causa  --RCA 09/May/2001
       and cj_ubicacion    = @i_ubi
       and cj_fecha_real   = @w_fecha_hoy
    if @@rowcount = 0
    begin
         exec cobis..sp_cerror
            @t_debug  = null,
            @t_file   = null,
            @t_from   = @w_sp_name,
            @i_num    = 035012
         return 1
    end
end
else
begin
    insert into cob_remesas..re_caja
           (cj_oficina, cj_rol, cj_operador, cj_producto, cj_moneda, 
        cj_transaccion, cj_numero, cj_efectivo, cj_cheque, cj_otros,
        cj_ajuste_int, cj_ajuste_cap,cj_interes, cj_nodo, cj_tipo, 
        cj_fecha, cj_chq_locales, cj_chq_ot_plaza,
        cj_causa,cj_fecha_real,cj_efecto_chq,cj_efecto_odb,cj_nc_fiscales,
        cj_tarjetas,cj_retencion,cj_ndah,cj_ndcc,cj_depto,cj_cant_chq,cj_ubicacion ) --RCA 09/May/2001
    values (@i_ofi, @i_rol, @i_user, @i_producto, @i_mon, 
        @i_trn, 1, @i_efectivo, @i_cheque, @i_otros,
        @i_adj_int,@i_adj_cap, @i_interes, @i_nodo, @i_tipo, 
        @w_fecha, @i_chq_locales, @i_chq_ot_plaza,
        @i_causa,@w_fecha_hoy, @i_efecto_chq,@i_efecto_odb,@i_nc_fiscales,@i_tarjetas,
            @i_retencion,@w_ndah,@w_ndcc,@i_depto,@i_cant_chq,@i_ubi) --RCA 09/May/2001
    if @@error != 0
    begin
         exec cobis..sp_cerror
            @t_debug  = null,
            @t_file   = null,
            @t_from   = @w_sp_name,
            @i_num    = 033018
         return 1
    end
end


/*****************************************************************************/
/*          MODIFICA RCA 31/MAY/2001                 */
/*****************************************************************************/
select @w_afecta_efectivo = 'N'       -- Ref. 13
select  @w_afecta_corte   = tg_afecta_corte,
        @w_tipo_corte     = tg_tipo_corte,
        @w_campo_debito   = tg_campo_debito,
        @w_horario_corte  = tg_horario_corte,
        @w_corte_efectivo = tg_corte_efectivo,
        @w_tipo_corefe    = tg_tipo_corefe,
        @w_afecta_efectivo = tg_afecta_efectivo,              -- Ref. 13
        @w_signo           = (44- ascii(tg_afecta_signo))   -- Ref. 13
from    cob_remesas..re_trn_caja
where   tg_transaccion = @i_trn

if @@rowcount <> 1
    begin
         exec cobis..sp_cerror
            @t_debug  = null,
            @t_file   = null,
            @t_from   = @w_sp_name,
        @i_msg    = 'La trn no esta definida en la Tabla re_trn_caja',
            @i_num    = 999999
         return 1
    end

if @e_verde = 'S'					-- GYC 2020/Ene/31
   begin
     if @i_trn = 3040
        select @w_tipo_corte = '91', @w_tipo_corefe = '94'
     else
        if @i_trn in (4251,4252)
           select @w_tipo_corte = '92', @w_tipo_corefe = '95'
   end

if @w_afecta_corte = 'S'
begin
    /*  Actualizacion de totales de cajero  */

   -- RCA 02/Dic/2001
   -- Verificar si la Trn Tiene cortes en Efectivo

   if @w_corte_efectivo = 'S' and @i_cheque = 0      ----@i_chq_locales = 0
      select @w_tipo_corte = @w_tipo_corefe    

   if exists (select 1 from cob_remesas..re_corte
        where ct_fecha_real  = @w_fecha_hoy
          and ct_oficina     = @i_ofi
          and ct_moneda      = @i_mon
          and ct_operador    = @i_user
          and ct_rol         = @i_rol
          and ct_ubicacion   = @i_ubi
          and ct_tipo        = @w_tipo_corte
          and ct_estado      = 'V') 
     begin
	 
    update cob_remesas..re_corte
    set ct_cantidad     = ct_cantidad     + @w_factor, 
            ct_efectivo     = ct_efectivo     + (@i_efectivo * @w_factor),
        ct_cheque       = ct_cheque       + (@i_cheque   * @w_factor),
            ct_chq_locales  = ct_chq_locales  + (@i_chq_locales * @w_factor),
            ct_chq_ot_plaza = ct_chq_ot_plaza + (@i_chq_ot_plaza * @w_factor),
            ct_efecto_chq   = ct_efecto_chq   + (@i_efecto_chq * @w_factor),
            ct_efecto_odb   = ct_efecto_odb   + (@i_efecto_odb * @w_factor),
            ct_nc_fiscales  = ct_nc_fiscales  + (@i_nc_fiscales * @w_factor),
            ct_tarjetas     = ct_tarjetas     + (@i_tarjetas * @w_factor),
            ct_retencion    = ct_retencion    + (@i_retencion * @w_factor),
            ct_depto        = ct_depto        + (@i_depto * @w_factor),
            ct_ndah         = ct_ndah         + (@w_ndah * @w_factor),
            ct_ndcc         = ct_ndcc         + (@w_ndcc * @w_factor),
            ct_cant_chq     = ct_cant_chq     + (@i_cant_chq * @w_factor)
        where ct_fecha_real  = @w_fecha_hoy
        and ct_oficina     = @i_ofi
            and ct_moneda      = @i_mon
            and ct_operador    = @i_user
            and ct_rol         = @i_rol
            and ct_ubicacion   = @i_ubi
        and ct_tipo        = @w_tipo_corte
        and ct_estado      = 'V'
    if @@rowcount = 0
    begin
           exec cobis..sp_cerror
            @t_debug  = null,
                @t_file   = null,
                @t_from   = @w_sp_name,
        @i_msg    = 'Error al Actualizar Registro de Corte',
                @i_num    = 999999
           return 1
    end
     end
   else
     begin
       select @w_num_corte = max(ct_num_corte) 
       from  cob_remesas..re_corte
       where ct_fecha_real  = @w_fecha_hoy
         and ct_oficina     = @i_ofi
         and ct_moneda      = @i_mon
         and ct_operador    = @i_user
         and ct_rol         = @i_rol
         and ct_ubicacion   = @i_ubi
         and ct_tipo        = @w_tipo_corte

         

       if @w_num_corte is null
          select @w_num_corte = 1
       else
          select @w_num_corte = @w_num_corte + 1

       if @w_factor <> 1
    begin
           exec cobis..sp_cerror
            @t_debug  = null,
                @t_file   = null,
                @t_from   = @w_sp_name,
        @i_msg    = 'Reverse el corte para realizar el REVERSO DE LA TRN',
                @i_num    = 999999
           return 1
    end
       
       if @w_horario_corte = 'D'
          begin 
            -- Rutina para verificar el siguiente dia laborable
            select @w_ciudad = of_ciudad
            from cobis..cl_oficina
                where of_oficina = @i_ofi
       
            if @@rowcount <> 1
            begin
                exec cobis..sp_cerror
                        @t_debug  = null,
                        @t_file   = null,
                        @t_from   = @w_sp_name,
                        @i_msg    = 'La ciudad no ha sido definida para esta Oficina',
                        @i_num    = 999999
                return 1
            end

            select @w_fecha_siguiente = min(dl_fecha)
            from cob_cuentas..cc_dias_laborables 
            where dl_ciudad = @w_ciudad and dl_num_dias = 1

            if @w_fecha_siguiente = null
            begin
                exec cobis..sp_cerror
                        @t_debug  = null,
                        @t_file   = null,
                        @t_from   = @w_sp_name,
                        @i_msg    = 'Error en Tabla de Dias Laborables',
                        @i_num    = 999999
                return 1
            end
                select @w_fecha_corte = @w_fecha_siguiente
          end  
       else
          select @w_fecha_corte = @w_fecha
       
        
       insert into cob_remesas..re_corte
             (ct_fecha, ct_oficina, ct_moneda, ct_operador, ct_rol, ct_tipo,
              ct_num_corte, ct_cantidad, ct_efectivo, ct_cheque, 
              ct_chq_locales, ct_chq_ot_plaza, ct_remesas_inter, ct_estado,
          ct_fecha_ip,ct_fecha_real,ct_efecto_chq,ct_efecto_odb,ct_nc_fiscales,ct_tarjetas,
              ct_retencion,ct_depto,ct_ndah,ct_ndcc,ct_cant_chq,ct_ubicacion) 
       values (@w_fecha, @i_ofi, @i_mon, @i_user, @i_rol, @w_tipo_corte,
              @w_num_corte, 1, @i_efectivo, @i_cheque,  
              @i_chq_locales, @i_chq_ot_plaza, 0, 'V',
              @w_fecha_corte,@w_fecha_hoy, @i_efecto_chq,@i_efecto_odb,@i_nc_fiscales,
              @i_tarjetas,@i_retencion,@i_depto,@w_ndah,@w_ndcc,@i_cant_chq,@i_ubi)
       if @@error != 0
          begin
              exec cobis..sp_cerror
                    @t_debug  = null,
                    @t_file   = null,
                    @t_from   = @w_sp_name,
            @i_msg    = 'Error al Insertar Registro de Corte',
                    @i_num    = 999999
              return 1
          end
     end
end

/*  Fin Modifica RCA 01/Jun/2001 */

-- Ref. 13 --->
-- ++ ERROR DEBE TENERE SEVERIDAD 1 (ROLLBACK)??
/*  Actualizacion de efectivo de punto de atencion  */
if @w_error_ptoate = 0
begin
  if @w_afecta_efectivo = 'S'
  begin
    select @w_cotizacion = ct_compra
    from cob_conta..cb_cotizacion
    where ct_fecha = (select max(ct_fecha)
                      from cob_conta..cb_cotizacion
                      where ct_moneda = @i_mon)
    and ct_moneda = @i_mon

    select @w_cotizacion = isnull(@w_cotizacion,1.0)
    select @i_efectivo = round(@i_efectivo * @w_cotizacion,2)

    select @w_factor = @w_factor * @w_signo
    update cob_remesas..re_det_tipo_punto_atencion
           set dt_efectivo     = dt_efectivo + (@i_efectivo * @w_factor)
         where dt_punto_atencion = @w_punto_atencion
           and dt_tipo_punto_atencion = @w_tipo_punto_ate

        if @@error <> 0 or @@rowcount = 0
        begin
          -- ERROR AL ACTUALIZAR EFECTIVO DEL PUNTO DE ATENCION
         exec cobis..sp_cerror
            @t_debug  = null,
            @t_file   = null,
            @t_from   = @w_sp_name,
            @i_num    = 300003309
         return 1
        end
  end
end
-- <--- Ref. 13
commit tran
return 0

go

grant execute on sp_upd_totales_rc to apl_osb_hpact
go

grant execute on sp_upd_totales_rc to ivr
go

if exists(select 1 from sysobjects where name='sp_upd_totales_rc' and type = 'P')
  print '== CREATE PROCEDURE sp_upd_totales_rc *OK* =='
 else
  print '<<< CREATE PROCEDURE sp_upd_totales_rc -- ERROR -- >>>'

go

