use cob_remesas
go

if exists (select 1 from sysobjects where name = 'sp_cobro_comision_rc' and type = 'P')
begin	
   drop proc dbo.sp_cobro_comision_rc
   if exists (select 1 from sysobjects where name = 'sp_cobro_comision_rc' and type = 'P')
      PRINT '<<< DROP PROCEDURE sp_cobro_comision_rc -- ERROR -- >>>'
   else
      PRINT '== DROP PROCEDURE sp_cobro_comision_rc *OK* =='
end
go

/************************************************************************/
/*  Archivo:            recobcom_rc.sp                                  */
/*  Stored procedure:   sp_cobro_comision_rc                            */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_remesas                                       */
/*  Producto:           Pagos                                   		*/
/*  Disenado por:       Ricardo Egas S.                               	*/
/*  Fecha de escritura: Oct-2000                                     	*/
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECMPS-2391                                   */
/*  Ult.Referencia:     REF 13                                           */
/************************************************************************/
/*                                IMPORTANTE                            */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.  */
/************************************************************************/
/*                           PROPOSITO					*/
/*      Este programa realiza el cobro en ventanilla de Emelec  	*/
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES				*/
/*    FECHA        AUTOR            RAZON        			*/
/*    15/feb/2006  Hugo Yépez Yépez Incluir parametros de causales	*/
/*    18/Ago/2010  D.Rodriguez      CTE-CC-9217 Pago comision por 	*/
/*				    tarjeta,cheque,cruce departamental  */
/* 19 22/Ago/2011  Sandra Merino    ATMFULL-286-CU-1720 		*/
/*				    ATM SERVICIOS        		*/
/* 4  16/Jul/2014  Daniel Pereira   CTE-CC-SGC00015932          	*/
/* 20 29/SEP/2014  Sandra Merino    CTE-CE-SGC00017569			*/
/* 06 06/Mar/2015  J.Pazminno M     Tarea: CB-AP-SGC00018374-SGC00018798*/
/*                                  Cuenta Basica - CNB 		*/
/* 6  18-Ene-2016  María José Silva ETAPA-AP-SGC00018437-SGC00018451    */
/*                                  Comisión de Etapa                   */
/* 7  20-Jul-2016  Jorge Barrera H. SGC00021271  Boton de pagos		*/
/* 8  22/Ago/2016  Daniel Pereira   DEPTEM-AP-SGC00025705-SGC00025712   */
/* 9  04/Abr/2017  María José Silva RECA-CC-SGC00028400 		*/
/*                                  Cobro de comision CNT Fijo		*/
/* 10 23/Abr/2017  María José Silva RECA-CC-SGC00028461 		*/
/*                                  Cobro de comision CNEL DIR		*/
/************************************************************************/
/* 11 10/Jul/2017  Daniel Pereira   CAJ-CC-SGC00028304	         	*/
/*            			    cobro comision canal ATM		*/
/************************************************************************/
/* 12 15/Ago/2017  Vanessa Miranda  MEER-AP-SGC00026606-SGC00028066	*/
/*				    cobro de comision canal DIR		*/
/*    01/Feb/2022  Galo Yanez       Modificar causal a 4 digitos.Tarea:	*/
/*                                  ALCCAU-AP-SGC00036523-SGC00036526   */
/*13 15/Agost/2023 Kevin Bastidas RECMPS-2391 INTEGRACION BBTS MIGRACION A BUS SERVICIO RISE*/
/************************************************************************/

create procedure dbo.sp_cobro_comision_rc
 (
       @s_ssn          int,
       @s_user         varchar(30),
       @s_term         varchar(10),
       @s_date         datetime,
       @s_srv          varchar(30),
       @s_lsrv         varchar(30),
       @s_ofi          smallint,
       @s_rol          smallint,
       @s_org_err      char(1) = NULL,
       @s_error        int     = NULL,
       @s_sev          tinyint = NULL,
       @s_msg          mensaje = NULL,
       @s_org          char(1),
       @t_debug        char(1) = 'N',
       @t_file         varchar(14) = null,
       @t_from         varchar(32) = null,
       @t_trn          int,
       @t_corr         char(1) = 'N',
       @t_ssn_corr     int = null,
       @i_mon          tinyint,
       @i_servicio     varchar(6) = null,
       @i_empresa      smallint = null,
       @i_codigo       varchar(30) = null,  --REF:7
       @i_efectivo     money = null,
       @i_cheque       money = null,
       @i_tipocta      char(3) = null,
       @i_debito       money = null,  -- DEB
       @i_cuenta       cuenta = null,
       @i_opcion       char(1),
       @i_autoriza     char(1) = 'N',
       @i_tsn          int = null,
       @i_aplcobis     char(1) = 'S',
       @i_ubi          int = null,
       --@i_causal       varchar(3) = null,   --hy-15-feb-2006		-- GYC 2022/Feb/01
       @i_causal       varchar(4) = null,   
       @i_tarjeta      money = null,     -- drodriguez CTE-CC-9217
       @i_cruce_dpto   money = null,   -- drodriguez CTE-CC-9217
       @i_canal        varchar(14) = null,  ---ref19
       @i_nomb_tramite varchar(10) = null --Ref006:msilvag 

)
as
declare @w_return      int,
        @w_sp_name     varchar(30),
        --@w_nombre      descripcion,
        @w_tipocta     char(1),
        @w_secuencial  int,
        --@w_codigo      char(15),
        --@w_rubro       char(3),
        @w_emp          varchar(6),
        @w_efec_com_atm  money,   --ref19
        @w_msg           varchar(200),      -- JPM Ref.06 -->
        @w_ssn_corr      int,
        @w_error         int,
        @w_detalle_error descripcion        -- <-- JPM Ref.06



/* Captura nombre del Store Procedure */
select @w_sp_name = 'sp_cobro_comision_rc'
select @s_date = convert(varchar(10),@s_date,101)


if @i_opcion = 'T'   -- Transaccion de Cobro
begin
    -->hy-15-feb-2006
    if @i_causal = null
    begin
       if @i_tipocta = 'AHO'
          select @i_causal = '130'
       if @i_tipocta = 'CTE'
          select @i_causal = '229'
    end
    --<hy-15-feb-2006

     begin tran

    if @i_tipocta = 'AHO' and @i_debito > 0
         select @w_tipocta = 'A'

    if @i_tipocta = 'CTE' and @i_debito > 0
        select @w_tipocta = 'C'

    if @i_tipocta = 'BAS' and @i_debito > 0     -- JPM Ref.06
        select @w_tipocta = 'B'
    
      if @i_tipocta = 'CTE' and @i_debito > 0
         begin
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
                 @i_cau          = @i_causal,  --hy-15-feb-2006 cambiar por parametro '229',
                 @i_mon          = @i_mon,
                 @i_ref          = @i_codigo,
                 @i_fecha        = @s_date,
                 @i_nchq         = @t_ssn_corr,
                 @i_aplcobis     = @i_aplcobis,
                 @i_tsn          = @i_tsn,           -- eas 12/04/2003
                 @i_ubi          = @i_ubi,           --- ame 11/13/2003
                 @s_rol          = @s_rol ,          --- ame 11/13/2003
                 @i_detalle      = @i_codigo --REF:7 
            if @w_return <> 0
               begin
                 rollback tran
                 return @w_return
               end
         end
      else                                  -- JPM Ref.06
      if @i_tipocta = 'AHO' and @i_debito > 0
         begin
         -- REF 7
	 	 declare @w_tran int
	 	 set @w_tran = 4264
         if @i_canal = 'CPV' or (@i_nomb_tramite = '112' and @i_canal = 'DIR') or (@i_nomb_tramite = '113' and @i_canal = 'DIR') --Ref009:msilvag 
            or (exists(select 1 from cob_pagos..pg_person_empresa where pe_empresa = convert(int, @i_nomb_tramite) and pe_cod_grupo = 4994) and @i_canal = 'DIR' )  --Ref010:msilvag 
	 	 begin
	 	   set @w_tran = 4272
	 	 end
        -- REF 7
            exec @w_return = cob_ahorros..sp_ahndc_automatica
                 @s_srv          = @s_srv,
                 @s_ofi          = @s_ofi,
                 @s_ssn          = @s_ssn,
                 @s_user         = @s_user,
                 @s_term         = @s_term,
                 @t_trn          = @w_tran,  --REF 7
                 @t_corr         = @t_corr,
                 @i_cta          = @i_cuenta,
                 @i_val          = @i_debito,
                 @i_cau          = @i_causal,  --hy-15-feb-2006 cambiar por parametro '130',
                 @i_mon          = @i_mon,
                 @i_ref          = @i_codigo,
                 @i_fecha        = @s_date,
                 @i_referen      = @t_ssn_corr,
                 @i_aplcobis     = @i_aplcobis,
                 @i_tsn          = @i_tsn,
                 @i_ubi          = @i_ubi,
                 @s_rol          = @s_rol,
                 @i_tarjeta      = @i_codigo  --REF:7
            if @w_return <> 0
               begin
                 rollback tran         --WRP20020625
                 return @w_return
               end
         end
      else
      if @i_tipocta = 'BAS' and @i_debito > 0 and @i_canal in ('CNB', 'IBK', 'ATM','DIR')  -- JPM Ref.06 --> --ref12 se agrega canal DIR
      begin
        select @w_ssn_corr = isnull(@t_ssn_corr, 0)
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
               @i_cau              = @i_causal,
               @i_mon              = @i_mon,
               @i_fecha            = @s_date,
               @i_aplcobis         = @i_aplcobis,
               @i_referen          = @w_ssn_corr,
               @i_tarjeta          = ' ',
               @i_ref              = @i_codigo,
               @i_ubi              = @i_ubi,
               @i_tsn              = @i_tsn,
               @i_con_tran         = 'N',
               @o_msg              = @w_msg                 out,
               @o_error            = @w_error               out,
               @o_detalle_error    = @w_detalle_error       out,
               @i_canal            = @i_canal
            if @w_return <> 0
               begin
                 rollback tran         --WRP20020625
                 return @w_return
               end
      end                                                           -- <-- JPM Ref.06

      /* SALVAR VARIBALE DE DEBITO USD */
       select @w_emp = convert(varchar(6),@i_empresa)            --GYC 2003/Ene/27
            --smerino

              if @i_canal='ATM'
              begin

                select @w_efec_com_atm=0  --ref 11 --@i_efectivo
                select @i_efectivo=@i_efectivo  --ref 11 --0
              end
              else
              begin
               select @w_efec_com_atm=0
              end

        -- Transaccion servicio  smerino aumentar ts_contratado
        -- Transaccion servicio
      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal, ts_correccion,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia, ts_saldo, ts_ssn_corr, ts_cta_banco,
              ts_moneda, ts_tipo, ts_valor, ts_monto,ts_contratado,ts_tsn,ts_hora, ts_endoso, ts_causa,ts_servicio,
              ts_tipocta,ts_tipo_def,ts_descripcion_ec, ts_ubicacion,
        ts_fonres_iess,  -- drodriguez CTE-CC-9217
        ts_aporte_iess,   -- drodriguez CTE-CC-9217
        ts_tipo_chequera, --Ref:4 dpereirv
        ts_autorizante  --Ref006:msilvag
       )
      values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term, @t_corr,
              null, 'L', @s_lsrv, @s_date, 'C', @i_codigo, @i_cheque, @t_ssn_corr, @i_cuenta,
              1, 'L',  @i_efectivo, @i_debito,@w_efec_com_atm, @i_tsn, getdate(),
              @w_secuencial, @i_servicio,@w_emp, @w_tipocta, @i_aplcobis,@i_codigo, @i_ubi,
              @i_tarjeta,     -- drodriguez CTE-CC-9217
              @i_cruce_dpto,   -- drodriguez CTE-CC-9217
              @i_canal, --Ref:4 dpereirv
              @i_nomb_tramite --Ref006:msilvag
       )

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
           else                                                                 -- JLS 23/FEB/2001
           begin                                                                -- GMD 10/ABR/2003
             rollback tran                                                      -- GMD 10/ABR/2003
             return 33005                                                       -- JLS 23/FEB/2001
           end                                                                  -- GMD 10/ABR/2003
         end


    if @i_canal <> 'CNB'
      begin
			if @i_tipocta != 'CTE' /*<REF 13 KBastida MEJORA COMISION CRTL+T>*/
			begin
				select @i_tipocta  = 'CTE'
			end
			
           exec @w_return = cob_remesas..sp_upd_totales_rc
                 @i_ofi            = @s_ofi,
                 @i_rol            = @s_rol,
                 @i_user           = @s_user,
                 @i_producto       = 'CTE',
                 @i_mon            = @i_mon,
                 @i_ubi            = @i_ubi,    ---- ame 11/13/2003
                 @i_trn            = @t_trn,
                 @i_nodo           = @s_srv,
                 @i_tipo           = 'L',
                 @i_corr           = @t_corr,
                 @i_efectivo       = @i_efectivo,
                 @i_cheque         = @i_cheque,
----                 @i_cant_chq       = @i_cant_chq,
                 @i_otros          = @i_debito,
                 @i_tipocta        = @i_tipocta,
                 @i_causa          = @i_servicio ---@w_emp
            if @w_return != 0
               begin
                  if @i_aplcobis = 'S'                                                        -- JLS 23/FEB/2001
                     begin                                                                       -- JLS 23/FEB/2001
                        exec cobis..sp_cerror
                             @t_debug         = @t_debug,
                             @t_file          = @t_file,
                             @t_from          = @w_sp_name,
                             @i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                             @i_num           = 111111
                        return 1 --WRP
                     end
                  else
                  begin
                     rollback tran
                     return 37609
                  end
               end
      end

    commit tran
end     -- Fin de Opcion = 'T' 

return 0
go

grant execute on sp_cobro_comision_rc to apl_osb_hpact
--grant execute on sp_cobro_comision_rc to apl_osb_hpdes
go

if exists (select 1 from sysobjects where name = 'sp_cobro_comision_rc' and type = 'P')
begin
   PRINT '== CREATE PROCEDURE sp_cobro_comision_rc *OK* =='
end
else
begin
   PRINT '<<< CREATE PROCEDURE sp_cobro_comision_rc -- ERROR -- >>>'
end
go