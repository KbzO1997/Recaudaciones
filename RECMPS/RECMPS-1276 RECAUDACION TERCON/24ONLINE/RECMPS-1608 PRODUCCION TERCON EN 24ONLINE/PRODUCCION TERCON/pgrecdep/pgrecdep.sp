/************************************************************************/
/*  Archivo:            pgrecdep.sp                                     */
/*  Stored procedure:   pa_reca_tpago_dep_linea                         */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Daniel Pereira                                  */
/*  Fecha de escritura: 13-Abr-2018                                     */
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
/*  Este programa recauda los pagos de empresas con dep�sito en l�nea   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*    FECHA       AUTOR             RAZON                               */
/*1  13/Abr/2018  Daniel Pereira    DEPONL-AP-SGC00031612-SGC00031669   */
/*2  08/Jul/2019  Maria Jo. Silva   RECMPS-20   			*/
/*3  17/Ene/2020  Pablo Holguin     CTE-CC-SGC00037410  Estructura BCE  */
/*4  06/Jun/2021  Josu� Rocafuerte  RECMPS-765 Notificacion Latinia     */
/*5  17/Feb/2022  Kevin Bastidas  RECMPS-1370 RECAUDACION TERCON 24ONLINE*/	
/*6  12/Abr/2022  Kevin Bastidas  RECMPS-1453 PAGO Y REVERSO TERCON - TRANSOCEANICA EN SAT*/
/************************************************************************/

use cob_pagos
go

if exists(select 1 from sysobjects where name = 'pa_reca_tpago_dep_linea' and type = 'P')
begin
   drop procedure dbo.pa_reca_tpago_dep_linea
   if exists (select 1 from sysobjects where name = 'pa_reca_tpago_dep_linea' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_reca_tpago_dep_linea -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_reca_tpago_dep_linea *OK* =='
end
go

create proc dbo.pa_reca_tpago_dep_linea(
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
	@s_sev                  int = null,
	@s_msg                  mensaje = null,
	@s_org                  char(1),
	@t_corr                 char(1) = 'N',
	@t_ssn_corr             int     = null,       /* Trans a ser reversada     */
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_rty                  char(1) = 'N',
	@t_trn                  int,
	@e_mon                  int     = 1,
	@e_servicio             varchar(10) = "5",
	@e_empresa              varchar(10),
	@e_aplcobis             char(1) = 'S',
	@e_efectivo             money = 0,
	@e_cheque               money = 0,
	@e_debito               money = 0,
	@e_tarjeta              money = 0,
	@e_comision_tot         money = 0,
	@e_comision_efe         money = 0,
	@e_comision_chq         money = 0,
	@e_comision_db          money = 0,
	@e_total                money = 0,
	@e_cant_cheques         int    = 0,
	@e_tipo_cta             char(3)     = 'CTE',
	@e_cuenta               varchar(24) = null,
	@e_nombre_cta           varchar(70) = null,
	@e_autoriza             char(1) = 'N',
	@e_canal                char(3)     = null,
	@e_tsn                  int = null,
	@e_ubi                  int = null,
	@e_cod_cliente          varchar(15) = null,
	@e_cod_referencia       varchar(30) = null,
	@e_ruc_cliente          varchar(13) = null,
	@e_nombre_cliente       varchar(32) = null,
	@e_base_imponible       money = null,
	@e_factura              varchar(32) = null, --Secuencia_recibo
	@e_cod_respuesta        varchar(32) = null,
	@e_ssn                  int = null,
	@e_servicio_fact        varchar(13) = 'Recaudacion',
	@e_cod_grupo            varchar(10) = null,
	@e_grupo                char(1)  = null,
	@e_nomb_tramite         varchar(64) = null,
	@e_phoralocal           varchar(6)  = null,
	@s_fecha_contable       varchar(10) = null output,
	@s_ssn1                  int = null output,
	@s_autorisri            varchar(30) = null output,
	@s_fecvensri            varchar(30) = null output,
	@s_nota_venta           varchar(20) = null output,
	@s_fact_elect           varchar(1) = null output,
	@s_cod_respuesta        varchar(32) = null output,
	@s_mensaje_respuesta    varchar(32) = null output,
	@s_fec_ini_vig_aut      varchar(10) = null output,
	@s_fec_fin_vig_aut      varchar(10) = null output,
	@s_fecdessri            varchar(30) = null output,
	@s_horario              char(1) = null output,
	@s_tasa         money = 0 out,
	@s_base_imp     float = 0 out,
	@s_impuesto     float = 0 out ,
	@e_denominaciones	varchar(250) ='',  --Ref03 pholguiv
	/* INI REF4 jrocafuf*/
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
	/* FIN REF4 jrocafuf*/
  )

as

declare @v_return	int,
	@v_sp_name	varchar(30),
	@v_hora_tope	int,
	@v_maximo_p 	money,
	@v_tipocta_emp	char(3),
	@v_cta_emp	char(10),
	@v_nombre varchar(30),
	@v_neto money,
  	@v_causa varchar(5),
  	@v_rowcount int,
  	@v_efec_dep money,
    --msilvag
	@v_cliente          int,
	@v_categoria        varchar(5),
	@v_nombre_cta       varchar(32),
	@v_valor_debito     varchar(15),
	@v_desc_canal       varchar(16),
	--@v_desc_empresa     varchar(32),
	@v_fecha_hoy        varchar(10),
	@v_producto         int,
	@v_cta_cre          varchar(10),
	@v_prod_cre         varchar(5),
	@v_nombre_emp       varchar(32),
	@v_comision         varchar(11),
	@v_hora_sys         varchar(8),
	@v_telefono         varchar(10),
	@v_correo           varchar(64),
	--Ref002:msilvag Inicio
	@v_servicio			varchar(4),
	@v_servicio_costo	varchar(4),
	@v_trn				int,
	@v_causal_com		varchar(6),
	@v_tasa				money,
	@v_base_imp			float,
	@v_impuesto			float,
	@v_num_operacion	varchar(20),
	--Ref002:msilvag Fin
	@w_servicio_alert       char(5), --Ref4
	@w_ssn      		int, --Ref4
	@w_desc_canal   	varchar(16), --Ref4
	@w_empresa   		varchar(32), --Ref4
	@w_motivo 		varchar(150), --Ref4
	@w_desc_serv 		varchar(11), --Ref4
	@w_valor_debito   	varchar(11), --Ref4
	@w_fecha_hoy   	varchar(10), --Ref4
	@w_hora_sys    	char(8) --Ref4

select @w_fecha_hoy = convert(varchar(10),@s_date,101)

select @s_date = convert(varchar(10),@s_date,101),
       @v_sp_name = 'pa_reca_tpago_dep_linea',
       @t_trn = 4435,
       @v_efec_dep = 0,
       @v_fecha_hoy = convert(varchar(10), getdate(),101),
       @v_hora_sys = convert(varchar(08),getdate(),108)

select @s_base_imp = 0  --msilvag Temporal

if @t_corr = 'N'
  select  @s_ssn = @e_ssn


if @s_date is null
begin
     select @s_date = fp_fecha from cobis..ba_fecha_proceso
end

select @s_fecha_contable = convert(varchar(10),@s_date,101)

--< HORA TOPE <
select @v_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
from cobis..cl_tabla a, cobis..cl_catalogo b
where a.tabla = 'sv_horario_serv'
and a.codigo = b.tabla
and b.codigo = @e_empresa
and estado = 'V'
if @@rowcount = 0 or @v_hora_tope = 0
begin
	if @e_aplcobis = 'S'
	begin
		exec cobis..sp_cerror
		@t_debug         = @t_debug,
		@t_file          = @t_file,
		@t_from          = @v_sp_name,
		@i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
		@i_num           = 37601
		return 37601
	end
	else
		return 37601
end




--- VALIDACION DE CAJA
if @e_aplcobis = 'S' and @e_canal = 'VEN'
begin
	exec @v_return = cob_remesas..sp_verifica_caja_rc
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
	@i_mon   = @e_mon,
	@i_ubi   = @e_ubi,
	@o_horario = @s_horario out
	if @v_return != 0
	begin
		if @e_aplcobis = 'S'
		begin
			exec cobis..sp_cerror
			@t_debug         = @t_debug,
			@t_file          = @t_file,
			@t_from          = @v_sp_name,
			@i_msg           = 'HORARIO DE CAJA NO DEFINIDO',
			@i_num           = 111111
			return @v_return
		end
		else
			return @v_return
	end
end


--- VALIDACION DE MONEDA
if @e_mon <> 1
begin
	if @e_aplcobis = 'S'
	begin
		exec cobis..sp_cerror
		@t_debug  = @t_debug,
		@t_file   = @t_file,
		@t_from   = @v_sp_name,
		@i_num    = 898994,
		@i_msg    = 'TRANSACCION SOLO SE DEBE REALIZAR EN DOLARES'
		return 898994
	end
	else
		return 898994
end

-- VALIDACION DE PARAMETRO DE MONTO MAXIMO
if @e_autoriza = 'N' and  @t_corr = 'N'
begin
	select @v_maximo_p = pa_money
	from cobis..cl_parametro
	where pa_nemonico = 'MMVI'
	and  pa_producto = 'CTE'
	if (@v_maximo_p <= @e_total )
	begin
		if @e_aplcobis = 'S'
                begin
			exec cobis..sp_cerror
			  @t_debug        = @t_debug,
			  @t_file         = @t_file,
			  @t_from         = @v_sp_name,
			  @i_num          = 311819
			return 311819
		end
		else
			return 311819
	end
end


begin tran
------------------------------------------
----DEBITO DE LA CUENTA DEL CLIENTE FINAL
------------------------------------------
if @e_tipo_cta = 'CTE' and @e_debito > 0
begin

  select @v_causa = isnull(b.valor,' ')
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_cte_servicios'
  and a.codigo = b.tabla
  and b.codigo = @e_empresa
  and estado = 'V'
  set @v_rowcount = @@rowcount

  if @v_rowcount = 0 or (@v_causa = null or @v_causa = ' ')
  begin
    if @e_aplcobis = 'S'
    begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @v_sp_name,
           @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
           @i_num   = 158693,
           @i_sev   = 1
           return 158693
      end
  end

   exec @v_return = cob_cuentas..sp_ccndc_automatica
   @s_srv          = @s_srv,
   @s_ofi          = @s_ofi,
   @s_ssn          = @s_ssn,
   @s_user         = @s_user,
   @s_term         = @s_term,
   @t_corr         = @t_corr,
   @t_trn          = 3050,
   @i_cta          = @e_cuenta,
   @i_val          = @e_debito,
   @i_cau          = @v_causa,
   @i_mon          = @e_mon,
   @i_ref          = @e_cod_referencia,
   @i_fecha        = @s_date,
   @i_nchq         = @t_ssn_corr,
   @i_aplcobis     = @e_aplcobis,
   @i_ubi          = @e_ubi,
   @s_rol          = @s_rol,
   @i_tsn          = @e_tsn,
   @i_con_tran     = 'N',
   @i_detalle      = @e_cod_referencia

  if @v_return <> 0
  begin
    If @@trancount > 0
		  rollback tran
    return @v_return
  end

end


if @e_tipo_cta = 'AHO' and @e_debito > 0
begin

  select @v_causa = isnull(b.valor,' ')
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_aho_servicios'
  and a.codigo = b.tabla
  and b.codigo = @e_empresa
  and estado = 'V'
  set @v_rowcount = @@rowcount

  if @v_rowcount = 0 or (@v_causa = null or @v_causa = ' ')
  begin
    if @e_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
    begin                                                                -- JLS 23/FEB/2001
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @v_sp_name,
           @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
           @i_num   = 158693,
           @i_sev   = 1
           return 158693
    end
  end

  exec @v_return = cob_ahorros..sp_ahndc_automatica
   @s_srv          = @s_srv,
   @s_ofi          = @s_ofi,
   @s_ssn          = @s_ssn,
   @s_user         = @s_user,
   @s_term         = @s_term,
   @t_trn          = 4272,
   @t_corr         = @t_corr,
   @i_cta          = @e_cuenta,
   @i_val          = @e_debito,
   @i_cau          = @v_causa,
   @i_mon          = @e_mon,
   @i_ref          = @e_cod_referencia,
   @i_fecha        = @s_date,
   @i_referen      = @t_ssn_corr,
   @i_aplcobis     = @e_aplcobis,
   @i_ubi          = @e_ubi,
   @s_rol          = @s_rol,
   @i_tsn          = @e_tsn,
   @i_con_tran     = 'N',
   @i_tarjeta      = @e_cod_referencia

  if @v_return <> 0
  begin
    if @@trancount > 0
      rollback tran
    return @v_return
  end

 end

    --msilvag Inicio
    if @e_tipo_cta = 'AHO'
        select @v_producto = 4
    else
        select @v_producto = 3

    select @v_cta_cre   = pe_cuenta ,
           @v_prod_cre  = pe_producto ,
           @v_nombre_emp= substring(pe_nombre ,1,32)
    from cob_pagos..pg_person_empresa
    where pe_empresa = convert(int,@e_empresa)
	--INI REF4
    if  @e_debito <> 0 and (@e_canal = 'VEN' or @e_canal = 'IBK' or @e_canal = 'SAT' or @e_canal = 'WAP') --KBastida RECM-1453 Ref SAT
    begin
		if @e_canal = 'SAT'  --KBastida RECM-1453 Ref SAT
            select @v_desc_canal = 'SAT' -- --KBastida RECM-1453 Ref SAT
		else if @e_canal = 'VEN'
            	select @v_desc_canal = 'VENTANILLA'
        	else
            	select @v_desc_canal = '24ONLINE'

        if @e_tipo_cta = 'AHO'
        begin
            select  @v_cliente = ah_cliente,
                    @v_categoria = ah_categoria,
                    @v_nombre_cta = substring(ah_nombre,1,32)
            from cob_ahorros..ah_cuenta
            where ah_cta_banco = @e_cuenta
        end
        else
        begin
            select  @v_cliente = cc_cliente,
                    @v_categoria = cc_categoria,
                    @v_nombre_cta = substring(cc_nombre,1,32)
            from cob_cuentas..cc_ctacte
            where cc_cta_banco = @e_cuenta
        end

        select @v_valor_debito = convert(varchar(11),@e_debito)

		/* INI REF4 lgusnayc
        if @t_corr = 'N'
            select @v_desc_servicio = 'ECUAQ'
        else
            select @v_desc_servicio = 'RECUQ'
		*/

        select @v_comision = convert(varchar(11),isnull(@e_comision_tot , 0.00))

        exec  @v_return  = cob_pagos..sp_consulta_celular
              @i_cliente = @v_cliente,
              @o_celular = @v_telefono  out,
              @o_correo  = @v_correo    out
        if @v_return <> 0
        begin
            if @@trancount > 0
                rollback tran

            return @v_return
        end
		
		

	 /* INI REF4  */
	if @t_corr = 'N'
		select @w_servicio_alert = 'PAGSB', @w_ssn = @s_ssn
	else
		select @w_servicio_alert = 'PAGSR', @w_ssn = @s_ssn

	select @w_empresa = "SERVICIOS VARIOS", @w_desc_serv="Factura" , @w_motivo="Factura"

		
	select @w_empresa = b.valor
	from cobis..cl_tabla a inner join  cobis..cl_catalogo b
		on a.codigo = b.tabla
	where a.tabla = 'sv_emp_recauda_deposito'
	and b.codigo = @e_empresa
	and b.estado = 'V'
	

	select @w_valor_debito = convert(varchar(11),@e_debito)

	if @e_canal = 'ATM'
		select @w_desc_canal = 'VEINTI4EFECTIVO'
	if @e_canal = 'DBA'
		select @w_desc_canal = 'AUTOMATICO'
	if @e_canal = 'IBK'
		select @w_desc_canal = '24Online'  
	if @e_canal = 'IVR'
		select @w_desc_canal = 'VEINTI4FONO'
	if @e_canal = 'KSK'
		select @w_desc_canal = 'PUNTOVEINTI4'
	if @e_canal = 'VEN'
		select @w_desc_canal = 'VENTANILLA'
	if @e_canal = 'WAP'
		select @w_desc_canal = 'WAP'
	if @e_canal = 'CNB'
		select @w_desc_canal = 'CNB'
	if @e_canal = 'SAT'  --KBastida RECM-1453
			select @w_desc_canal = 'SAT'
	select  @w_hora_sys = convert(varchar(08),getdate(),108)
			
	select @o_servicio_not = @w_servicio_alert,
		@o_nomb_ente = @v_nombre_cta,
		@o_cod_ente =  convert(varchar(20),@v_cliente) ,
		@o_desccanal = @w_desc_canal ,         	       
		@o_celular = @v_telefono,
		@o_correo  = @v_correo,
		@o_desc_empresa = @w_empresa,
		@o_prod_deb = @e_tipo_cta,
		@o_valor = @w_valor_debito,
		@o_fecha_deb = @w_fecha_hoy,
		@o_hora_deb = @w_hora_sys,
		@o_valor_comi = convert(varchar, @e_comision_db),
		@o_valor_tot =  convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @e_comision_db))  ,
		@o_cta_lat = substring(@e_cuenta,8,3),
		@o_tipo_serv = @w_desc_serv
	       
	/* FIN REF4 */			
	
		
/*  INI REF4 
        exec  @v_return = cob_internet..sp_eventos
            @i_operacion    = 'I',
            @i_fecha        = @v_fecha_hoy ,--@w_fecha_deb,
            --@i_retardo      = 'S',
            @i_fecha_tope   = @s_date,
            @i_cliente      = @v_cliente,
            @i_servicio     = @v_desc_servicio,
            @i_producto     = @v_producto,
            @i_prod_deb     = @e_tipo_cta,             -- Tipo de cuenta
            @i_cta_deb      = @e_cuenta,      -- @i_ctadb,     Cuenta Debito
            @i_empresa      = @e_cod_referencia , --@e_empresa,
            @i_nombre       = @v_nombre_emp , --Nombre de la empresa
            @i_canal        = @e_canal,
            @i_cuenta       = @e_cuenta,
            @i_valor        = @v_valor_debito,
            --@i_cta_cre      = @v_cta_cre,      -- @i_cta_dep,   Cuenta Credito
            --@i_prod_cre     = @v_prod_cre,             -- @w_prodep,    Tipo de Cuenta
            @i_motivo       = @e_nombre_cliente , --@v_nombre_cta,
            @i_costo        = @v_comision,
            @i_desc_canal   = @v_desc_canal,
            @i_valor2       = @v_fecha_hoy,
            @i_valor1       = @v_hora_sys,
            @i_mail         = @v_correo ,
            @i_telefono     = @v_telefono
        if @v_return <> 0
        begin
            If @@trancount > 0
                rollback tran

            return @v_return
        end
 FIN REF4 */
    end
    --msilvag fin

------------------------------------------
-----DEPOSITO A LA CUENTA DE LA EMPRESA
------------------------------------------

select
   @v_tipocta_emp = pe_producto,
   @v_cta_emp = pe_cuenta
from cob_pagos..pg_person_empresa
where pe_empresa = convert(int,@e_empresa)
if @@rowcount = 0
begin
	if @e_aplcobis = 'S'
	begin
		exec cobis..sp_cerror
		@t_debug         = @t_debug,
		@t_file          = @t_file,
		@t_from          = @v_sp_name,
		@i_msg           = 'EMPRESA NO EXISTE',
		@i_num           = 160016,
        @i_sev           = 1
		return 160016
	end
	else
		return 160016
end


if @v_tipocta_emp = 'CTE'
begin
	select @v_efec_dep =  @e_efectivo + @e_debito

	exec @v_return = cob_cuentas..sp_tr_deposito_rc
	@s_ssn        = @s_ssn,
	@s_srv        = @s_srv,
	@s_lsrv       = @s_lsrv,
	@s_user       = @s_user,
	@s_sesn       = @s_sesn,
	@s_term       = @s_term,
	@s_date       = @s_date,
	@s_ofi        = @s_ofi,
	@s_rol        = @s_rol,
	@s_sev        = @s_sev,
	@s_org        = 'D',
	@t_corr       = @t_corr,
	@t_ssn_corr   = @t_ssn_corr,
	@t_debug      = @t_debug,
	@t_trn        = 4435,
	@p_envio      = 'N',
	@p_rpta       = 'N',
	@i_ubi	      = @e_ubi,
	@i_cta        = @v_cta_emp ,
	@i_efe        = @v_efec_dep,
	@i_loc        = @e_cheque,
	@i_mon        = @e_mon,
	@i_tsn        = @e_tsn,
	@i_autoriza   = @e_autoriza,
	@i_cant_chq   = @e_cant_cheques,
	@i_ssn        = @s_ssn,
	@i_date_off   = @s_date,
	@i_canal      = @e_canal,
	@i_aplcobis   = @e_aplcobis,
	@i_codigo     = @e_cod_referencia,
	@o_nombre     = @v_nombre out,
	@o_impuesto   = @s_impuesto out,
	@o_neto       = @v_neto out,
	@i_debito     = @e_debito,
	@i_denominaciones = @e_denominaciones  --Ref03

	if @v_return != 0
	begin
         	If @@trancount > 0
			rollback tran

		return @v_return
	end


end

if @v_tipocta_emp = 'AHO'
begin
	select @v_efec_dep =  @e_efectivo + @e_debito

	exec @v_return = cob_ahorros..sp_ah_depositosl_rc
	@s_ssn        = @s_ssn,
	@s_srv        = @s_srv,
	@s_lsrv       = @s_lsrv,
	@s_user       = @s_user,
	@s_sesn       = @s_sesn,
	@s_term       = @s_term,
	@s_date       = @s_date,
	@s_ofi        = @s_ofi,
	@s_rol        = @s_rol,
	@s_org        = 'D',
	@t_corr       = @t_corr,
	@t_ssn_corr   = @t_ssn_corr,
	@t_debug      = @t_debug,
	@t_trn        = 4436,
	@p_envio      = 'N',
	@p_rpta       = 'N',
	@i_cta        = @v_cta_emp,
	@i_efe        = @v_efec_dep,
	@i_loc        = @e_cheque,
	@i_mon        = @e_mon,
	@i_tsn        = @e_tsn,
	@i_autoriza   = @e_autoriza,
	@i_cant_chq   = @e_cant_cheques,
	@i_ubi        = @e_ubi,
	@i_sec        = @s_ssn,
	@i_canal      = @e_canal,
	@i_aplcobis   = @e_aplcobis,
	@i_cau 	      = '0',
	@i_codigo     = @e_cod_referencia,
	@i_nomb_dep   = @e_cod_referencia,
	@i_debito     = @e_debito,
	@i_denominaciones = @e_denominaciones  --Ref03

	if @v_return != 0
	begin
		If @@trancount > 0
			rollback tran

		return @v_return
	end

end


  insert into cob_cuentas..cc_tran_servicio
    ( ts_secuencial,      ts_tipo_transaccion,      ts_oficina,      ts_usuario,      ts_rol,
      ts_terminal,      ts_origen,      ts_nodo,      ts_tsfecha,      ts_clase,
      ts_referencia,      ts_correccion,      ts_cta_banco,      ts_moneda,      ts_tipo,
      ts_monto,      ts_ocasional,      ts_autoriz_anula,      ts_contratado,      ts_aporte_iess,
      ts_descuento_iess,      ts_hora,      ts_causa,      ts_tipocta,      ts_nombre,
      ts_fonres_iess,      ts_campo_alt_uno,      ts_campo_alt_dos,      ts_fecha,      ts_endoso,
      ts_tipo_chequera,      ts_autoriz_aut,      ts_valor,      ts_saldo, ts_cheque,	ts_ssn_corr, ts_ced_ruc) --Ref RECMPS-1370 add ts_ced_ruc
  values
      (@s_ssn,      43569,      @s_ofi,      @s_user,      @s_rol,
      @s_term,      'L',      @s_srv,      @s_date,      'L',
      @e_cod_referencia,      @t_corr,      @e_cuenta,      @e_mon,      'L',
      @e_debito,      null,      null,      0,      0,
      null,      getdate(),      @e_empresa,      @e_tipo_cta,      @e_nombre_cliente,
      0,      @e_cod_respuesta,     @e_nomb_tramite,      @s_date,      @s_ssn, --Ref002:msilvag
      @e_canal,     convert(varchar,@e_comision_tot) ,     @e_efectivo,     @e_cheque, @e_cant_cheques, @t_ssn_corr, @e_ruc_cliente) --Ref002:msilvag  --Ref RECMPS-1370:KBastida


  if @@rowcount <> 1
  begin
    if @e_aplcobis = 'S'
    begin
       exec cobis..sp_cerror
        @t_from = @v_sp_name,
        @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
        @i_num = 031004,
        @i_sev = 1

        return 031004
    end
  else
      return 33005
  end

--Ref002:msilvag Inicio
if @e_comision_db > 0
	select @v_num_operacion = @e_cuenta
else
	select @v_num_operacion = @e_cod_referencia


if @e_comision_tot > 0
begin
	if @t_trn = 43569
		select  @v_trn = 3366
	else
		select  @v_trn = 3372

    --Consulta el servicio de la empresa la personalizacion
	select  @v_servicio = pe_serv_com,
			@v_servicio_costo = isnull(pe_cod_serv,'CSPR')
	from cob_pagos..pg_person_empresa
	where pe_empresa = convert(int,@e_empresa)

	if @e_tipo_cta = 'AHO'
	begin
		select @v_causal_com = b.valor
		from cobis..cl_tabla a inner join  cobis..cl_catalogo b
			on a.codigo = b.tabla
		where a.tabla = 'causa_nd_comision_servaho'
		and b.codigo = @e_empresa
		and b.estado = 'V'
		set @v_rowcount = @@rowcount
	end
	else
		if @e_tipo_cta = 'CTE'
		begin
			select @v_causal_com = b.valor
			from cobis..cl_tabla a inner join  cobis..cl_catalogo b
				on a.codigo = b.tabla
			where a.tabla = 'causa_nd_comision_servcte'
			and b.codigo = @e_empresa
			and b.estado = 'V'
			set @v_rowcount = @@rowcount
	end

	if @v_rowcount = 0 or (@v_causal_com = null or @v_causal_com = ' ')
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @v_sp_name,
			@i_sev   = 1 ,
			@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA LA COMISION',
			@i_num   = 300003517
		return 300003517
	end


	exec @v_return = cob_remesas..sp_cobro_comision_rc
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
	   @t_trn      = @v_trn,
	   @i_ubi      = @e_ubi,
	   @i_mon      = @e_mon,
	   @i_opcion   = "T",
	   @i_servicio = @v_servicio,
	   @i_causal   = @v_causal_com,
	   @i_codigo   = @e_cod_referencia,
	   @i_efectivo = @e_comision_efe,
	   @i_cheque   = @e_comision_chq,
	   @i_debito   = @e_comision_db,
	   @i_cuenta   = @e_cuenta,
	   @i_tipocta  = @e_tipo_cta,
	   @i_canal    = @e_canal,
	   @i_nomb_tramite = @e_nomb_tramite ,
	   @i_tsn      = @e_tsn
	if @v_return != 0
	begin
		exec cobis..sp_cerror
			@t_debug  = @t_debug,
			@t_file   = @t_file,
			@t_from   = @v_sp_name,
			@i_sev    = 1 ,
			@i_num    = @v_return
		return @v_return
	end

	--  busqueda de la tasa del iva parametrizada en el person
	exec  @v_return = cob_pagos..sp_verif_genera_costo
		@s_date         = @s_date,
		@i_mon          = @e_mon,
		@i_rubro        = 'IVA',
		@i_servicio     = @v_servicio_costo,
		@i_canal        = @e_canal,
		@i_tipocta      = '3',
		@o_costo        = @v_tasa out
	if @v_return <> 0
	begin
		if @@trancount > 0
			rollback tran

		return @v_return
	end

	if @v_tasa > 0
	begin
		exec @v_return = cob_cuentas..sp_cal_impuesto
		   @i_tasa         = @v_tasa,
		   @i_valor_serv   = @e_comision_tot,
		   @o_base_imp     = @v_base_imp out,
		   @o_impuesto     = @v_impuesto out
		if @v_return <> 0
		begin
			if @@trancount > 0
				rollback tran

			return @v_return
		end
		else
			select @s_base_imp = @v_base_imp, @s_impuesto = @v_impuesto, @s_tasa = @v_tasa

	end
	else
		select @s_base_imp = @e_comision_tot, @s_impuesto = 0 , @s_tasa= 0


	if @v_base_imp > 0
	begin
		--insert la trx del iva 3497 para cobro de la comision ---
		exec @v_return = cob_cuentas..sp_cont_impuesto
		   @s_ssn		= @s_ssn,
		   @t_trn       = 3497,
		   @s_date      = @s_date,
		   @t_corr      = @t_corr,
		   @t_ssn_corr  = @t_ssn_corr,
		   @s_user      = @s_user,
		   @s_term      = @s_term,
		   @s_ofi       = @s_ofi,
		   @t_rty       = @t_rty,
		   @s_org       = @s_org,
		   @i_base_imp  = @v_base_imp,
		   @i_iva       = @v_impuesto,
		   @i_total     = @e_comision_tot,
		   @i_cau       = @v_servicio,
		   @i_cta       = @v_num_operacion,
		   @i_mon       = @e_mon,
		   @i_oficina_cta = @s_ofi,
		   @i_ubi       = @e_ubi,
		   @i_canal     = @e_canal
		if @v_return <> 0
		begin
			if @@trancount > 0
				rollback tran

			return @v_return
		end
     end

end --if @e_comision_tot > 0
--Ref002:msilvag Fin

if @e_canal = 'VEN'
begin
	exec @v_return = cob_remesas..sp_upd_totales_rc
	@i_ofi            = @s_ofi,
	@i_rol            = @s_rol,
	@i_user           = @s_user,
	@i_producto       = 'CTE',
	@i_mon            = @e_mon,
	@i_ubi            = @e_ubi,
	@i_trn            = @t_trn,
	@i_nodo           = @s_srv,
	@i_tipo           = 'L',
	@i_corr           = @t_corr,
	@i_efectivo       = @e_efectivo,
	@i_cant_chq       = @e_cant_cheques,
	@i_cheque         = @e_cheque,
	@i_tipocta        = @e_tipo_cta,
	@i_otros          = @e_debito,
	@i_retencion      = 0,
	@i_causa          = @e_empresa
	if @v_return != 0
	begin
		if @e_aplcobis = 'S'
                begin
                	exec cobis..sp_cerror
                 	@t_debug         = @t_debug,
                 	@t_file          = @t_file,
                 	@t_from          = @v_sp_name,
                 	@i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                 	@i_num           = 34019 ,
                    @i_sev           = 1
                 	return 34019
		end
		else
			return 34019
	end
end

--Validar que transacci�n se encuentra activa
while @@trancount > 0
begin
    commit tran
end

select 	@s_ssn1 = @s_ssn,
	@s_horario = 'N'


return 0

go

grant execute on pa_reca_tpago_dep_linea to apl_osb_hpact
--grant execute on pa_reca_tpago_dep_linea to apl_osb_hpdes
go

if exists(select 1 from sysobjects where name='pa_reca_tpago_dep_linea' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_reca_tpago_dep_linea *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_reca_tpago_dep_linea -- ERROR -- >>>'
go
