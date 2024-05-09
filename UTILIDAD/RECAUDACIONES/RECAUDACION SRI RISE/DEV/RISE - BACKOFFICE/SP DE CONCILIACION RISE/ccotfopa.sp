/************************************************************************/
/*          Archivo:          ccotfopa.sp                               */
/*          Stored procedure: sp_procesa_ofp_sri                        */
/*          Base de datos:    cob_pagos                                 */
/*          Producto:         Cuentas Corrientes                        */
/*          Disenado por:     Luis Chacha Montenegro                    */
/*          Fecha de escritura: 2005                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "BANCO BOLIVARIANO".                                            */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.  */
/************************************************************************/
/*                              PROPOSITO                               */
/*                                                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*    2005           Luis Chacha     Emision inicial     	 	        */
/*    20/Ene/2006    Daniel Gomez    Detalle de totales                 */
/*    26/Ene/2006    Daniel Gomez    Consulta historica                 */
/*    31/Ene/2006    Daniel Gomez    Consulta de trx que no vienen en   */
/*                                   malla                              */
/*    11/May/2007    Luis F Chacha M Conciliación con T.Credito         */
/*    14/May/2007    Luis F Chacha M Disminuir Numero de Filas enviadas */
/*                                   al Front-End                       */
/*    29/Abr/2008    German Medina C Optimizacion del Programa			*/
/*    08/May/2008    German Medina C Cambio para enviar fecha sin null	*/
/*    06/Oct/2008    German Medina C Recausaciones SRI-RISE             */
/*    05/Nov/2008    German Medina C Recausaciones SRI-RISE-2parte      */
/*                                                                      */
/************************************************************************/
use cob_servicios
go

if exists (select * from sysobjects where name = 'sp_procesa_ofp_sri')
   drop proc sp_procesa_ofp_sri
go



create proc sp_procesa_ofp_sri (
    @s_ssn           int,
    @s_srv           varchar(30)   = null,
    @s_lsrv          varchar(30)   = null,
    @s_user          varchar(30)   = null,
    @s_sesn          int,
    @s_term          varchar(10),
    @s_date          datetime,
    @s_org           char(1),
    @s_ofi           smallint,
    @s_rol           smallint,
    @s_org_err       char(1)       = null,
    @s_error         int           = null,
    @s_sev           tinyint       = null,
    @s_msg           varchar(255)  = null,
    @t_debug         char(1)       = 'N',
    @t_file          varchar(14)   = null,
    @t_from          varchar(32)   = null,
    @t_rty           char(1)       = 'N',
    @t_trn           int,
    @i_operacion     char(2), 
    @i_fecha_carga   datetime      = null,
    @i_sec           smallint      = 0,
    @i_referencia    varchar(15)   = '',    -- DGA 26/Ene/2006
    @i_control       int           = 1,     -- DGA 26/Ene/2006
    @i_fecha_proceso datetime      = null,  -- DGA 26/Ene/2006
    @i_proceso       varchar(10)   = null   -- gamc - 06OCT08
    
    
)
as

declare  
  @w_return             int,
  @w_sp_name            varchar(32),
  @w_estado             char(1), 
  @w_cheque             money,
  @w_tcredito           money,          --lfcm 11-mayo-2007
  @w_secuencial         varchar(20),
  @w_estado_deb         char(2),
  @w_ruc                varchar(13),
  @w_impuesto           varchar(30),
  @w_valor              money,
  @w_fecha_pago         smalldatetime,
  @w_efec               money,
  @w_nota_debito        money,
  @w_nota_credito       money,
  @w_efecto_cobro       money,
  @w_corr               char(1),
  @w_adhesivo           varchar(15),
  @w_msg_error          varchar(100),
  @w_tipo_tx            varchar(20),
  @w_valor_total        money,
  @w_registro1          int,
  @w_valor_procesado    money,
  @w_registro2          int,
  @w_valor_no_procesado money,
  @w_registro3          int,
  @w_entidad            int,
  @w_adhesivo_bb        varchar(20),
  @w_ruc_bb             varchar(13),
  @w_corr_bb            char(1),
  @w_num_carga          int,
  @w_existe             char(1),
  @w_oficial            int,
  @w_nombre_oficial     descripcion,
  @w_cta_banco          cuenta,
  @w_tipo_cta_tmp       char(1),
  @w_tipo_cta           varchar(3),
  @w_oficina            smallint,
  @w_usuario            descripcion,
  @w_hora_real          datetime,
  @w_canal              varchar(5),
  @w_fecha              datetime,
  @w_codlog_monitor     numeric,
  @w_respuesta 			smallint,			--GAMC - 28/04/2008
  @w_codlog_monitor1    varchar(30),		--GAMC - 28/04/2008
  @w_comprobante		varchar(20),		--gamc 06OCT08
  @w_secuencial2		int,				--gamc 06OCT08
  @w_secuencial_sri     varchar(20)		    --gamc 05NOV08
  

/* Capture nombre del store procedure */
select @w_sp_name = object_name(@@procid)

/* Valida codigo de transaccion */
if  @t_trn not in (3601)
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 031048
   return 1
end  



/** OPERACIONES **/   


--set rowcount 20

/* BUSCAR TODA LA INFORMACION DEPENDIENDO LA FECHA INGRESADA COMO PROCESO*/  

if @i_operacion = 'Q'
  begin
  	--gamc - 06OCT08 - Se cambio para que consulte rise tambien
	if @i_proceso = 'OFP'
  	begin
		--GAMC - 28/04/2008 - POR OPTIMIZACION
		exec sp_procesa_ofp_sri_q
			@i_fecha_carga		= @i_fecha_carga,
			@i_sec				= @i_sec,
			@i_modo				= 0
	end
	if @i_proceso = 'RISE'
	begin
		set rowcount 6
		select
				  ' ',
				  estado					= op_estado,
				  fechaPago					= convert(varchar, op_fecha_pago, 101),
				  valorDebitar				= op_valor,
				  codTranSRI				= op_cod_trx_sri,
				  codTranIFI				= op_cod_trx_bco,
				  numCompSRI				= op_comprobante,
				  tipoTx					= op_tipo_tx,
				  codTranIFIRev				= op_cod_trx_bco_rev,
				  estadoDebito				= op_debitado,
				  ruc						= op_ruc,
		  		  tipoPago					= op_tipo_pago,
		  		  usuario					= op_usuario,
		  		  mensaje					= op_error,
				  Secuencia 				= op_sec
				  
				from cob_servicios..sv_rise_sri_carga, cob_servicios..sv_rise_sri_carga_det					 
				where cg_fecha = @i_fecha_carga and
					  cg_numero = op_carga and
					  op_sec > @i_sec and
					  op_tipo_tx <> 'TX_BANCO'					  
		order by op_sec
		set rowcount 0		
	end
	
  		
  /*--GAMC - 28/04/2008 - SE COMENTO POR OPTIMIZACION
  --set rowcount 8    --lfcm 14-junio-2007
    set rowcount 6    --lfcm 14-junio-2007
    
    select
      ' ',
      Estado                   = op_estado,
      tipoTx                   = op_tipo_tx,
      codigoLogMonitor         = op_codlog_monitor,
      idEntidad                = op_entidad,
      codigoFormulario         = op_codformulario,
      numeroFormulario         = op_numformulario,
      numeroSecuencial         = op_secuencial_sri,
      codigoCabeceraFormulario = op_cabformulario,
      periodoFiscalDesde       = convert(varchar, op_periodofiscal_desde, 101),
      periodoFiscalHasta       = convert(varchar, op_periodofiscal_hasta, 101),
      fechaDeclaracion         = convert(varchar, op_fecha_declaracion, 101),
      fechaMaximaPago          = convert(varchar, op_fecha_maximopago, 101),
      numeroRuc                = op_ruc,
      razonSocial              = op_razon_social,
      codigoImpuesto           = op_codimpuesto,
      descripcionImpuesto      = op_desimpuesto,
      valorDebitar             = op_valordebito,
      claseContribuyente       = op_clase_contribuyente,
      adhesivo                 = op_adhesivo, --20
      codigoEstructuraOrganizacional = op_codestruc_org,
      fechaPago                = convert(varchar, op_fecha_pago, 101),
      estadoDebito             = op_estado_debito,
      Oficina                  = op_oficina,
      "Nombre Oficina"         = of_nombre,
      Efectivo                 = isnull(op_efectivo, 0),
      Cheque                   = isnull(op_cheque, 0),
      "T. Credito"             = isnull(op_tcredito, 0),           --lfcm 11-mayo-2007
      Efecto                   = isnull(op_efecto_cobro, 0),
      Debito                   = isnull(op_debito_cuenta, 0),
      'Tipo Cta'               = op_tipocta,
      Cuenta                   = op_cta_banco,
      Oficial                  = op_oficial,
      "Nombre Oficial"         = op_nombre_oficial,
      Canal                    = op_canal,
      Usuario                  = op_usuario,
      "Fecha Real Trx"         = convert(varchar, op_hora, 101) + ' ' + convert(varchar, op_hora, 108),
      Mensaje                  = op_error,
      Secuencia                = op_sec
    from cob_servicios..sv_ofp_sri_carga, cob_servicios..sv_otra_forma_pago_sri,
         cobis..cl_oficina
    where cg_fecha = @i_fecha_carga and --op_estado = 'N' and
          cg_numero = op_carga and
          op_sec > @i_sec and
          op_tipo_tx <> 'TX_BANCO' and -- DGA 31/Ene/2006
          op_oficina *= of_oficina
    order by op_sec
    
    set rowcount 0
    */
    return 0
  end
  
  
if @i_operacion = 'V' -- Verificar Pago
begin
	select @w_msg_error = null
     
	select @w_num_carga = cg_numero
	from   cob_servicios..sv_ofp_sri_carga
	where  cg_fecha = @i_fecha_carga
    
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33332,
		@i_msg   = 'NO EXISTE ARCHIVO DE CARGA PARA OTRAS FORMA DE PAGO SRI'
		return 33332
	end
          
	select 
	@w_estado      = op_estado,
	@w_estado_deb  = op_estado_debito,
	@w_ruc         = op_ruc,
	--@w_secuencial= op_secuencial_sri,
	--@w_entidad   = op_entidad,
	@w_adhesivo    = op_adhesivo,
	@w_impuesto    = op_codimpuesto,
	@w_valor       = op_valordebito,
	@w_fecha_pago  = op_fecha_pago,
	@w_tipo_tx     = op_tipo_tx,
	@w_codlog_monitor = convert(numeric, op_codlog_monitor)
	from cob_servicios..sv_otra_forma_pago_sri
	where op_carga    = @w_num_carga 
	  and op_sec      = @i_sec
	  and op_tipo_tx  = 'TX_DIRECTA' -- DGA 31/Ene/2006
     
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33333,
		@i_msg   = 'NO EXISTE REGISTRO SOLICITADO DE OTRA FORMA DE PAGO SRI'
		return 33333
	end
     
	if @w_estado <> 'N'
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33334,
		@i_msg   = 'REGISTRO SOLICITADO DE OTRA FORMA DE PAGO SRI YA FUE PROCESADO'
		return 33334
	end
     
	select @w_estado = 'P' -- cambiar el estado si no hay error
	/*     
	if @w_tipo_tx = 'TX_DIRECTA'
		select @w_corr = 'N'
	else
		select @w_corr = 'S'
	*/       
     -- ver si fecha es feriado
	select @w_fecha = @w_fecha_pago

	while 1 = 1
	begin
		if exists(select 1
				  from cobis..cl_dias_feriados
				  where df_ciudad = 1 and df_fecha = @w_fecha)
			select @w_fecha = dateadd(dd,1, @w_fecha)
		else
			break
	end
      
	select @w_fecha_pago = @w_fecha
     
	select @w_existe = 'S'
    /*--GAMC - 28/04/2008 - SE COMENTO POR OPTIMIZACION 
	select @w_efec          = isnull(ts_valor, 0), 
	@w_cheque        = isnull(ts_saldo, 0),
	@w_tcredito      = isnull(ts_fonres_iess, 0),       --lfcm 11-mayo-2007
	@w_nota_credito  = isnull(convert(money,ts_cta_banco_dep), 0),  -- ts_monto
	@w_nota_debito   = isnull(ts_monto, 0),         -- ts_aporte_iess       --lfcm 11-mayo-2007
	--@w_nota_debito   = isnull(ts_aporte_iess, 0),                         --lfcm 11-mayo-2007
	@w_efecto_cobro  = isnull(ts_contratado, 0),
	@w_adhesivo_bb   = ts_referencia,
	@w_ruc_bb        = ts_ced_ruc,
	@w_corr_bb       = isnull(ts_correccion, 'N'),
	@w_cta_banco     = ts_cta_banco,
	@w_tipo_cta_tmp  = ts_tipocta,
	@w_oficina       = ts_oficina,
	@w_canal         = ts_tipo_chequera,
	@w_usuario       = ts_usuario,
	@w_hora_real     = ts_hora
	from   cob_cuentas..cc_tran_servicio_resp --_resp
	where  ts_tipo_transaccion in (3611, 3612) and 
		--ts_secuencial  = @w_entidad and
		ts_tsfecha       = @w_fecha_pago  and
		( convert(numeric, ts_campo_alt_dos) = @w_codlog_monitor or
		ts_referencia    = @w_adhesivo ) and
		ts_correccion    = 'N' and
		ts_secuencial not in ( select ts_ssn_corr
	                           from cob_cuentas..cc_tran_servicio_resp
                                   where ts_tipo_transaccion in ( 3611, 3612 )
                                     and ts_tsfecha    = @w_fecha_pago
	                             and ts_correccion = 'S' )
    */
    --GAMC - 28/04/2008 - POR OPTIMIZACION
    set @w_codlog_monitor1 = convert(varchar(30), @w_codlog_monitor)
	exec sp_procesa_ofp_sri_v
		@i_fecha_carga		= @w_fecha_pago,
		@o_efec   			= @w_efec out,
		@o_cheque        	= @w_cheque out,
		@o_tcredito      	= @w_tcredito out,
		@o_nota_credito  	= @w_nota_credito out,
		@o_nota_debito   	= @w_nota_debito out,
		@o_efecto_cobro  	= @w_efecto_cobro out,
		@o_adhesivo_bb   	= @w_adhesivo_bb out,
		@o_ruc_bb        	= @w_ruc_bb out,
		@o_corr_bb       	= @w_corr_bb out,
		@o_cta_banco     	= @w_cta_banco out,
		@o_tipo_cta_tmp  	= @w_tipo_cta_tmp out,
		@o_oficina       	= @w_oficina out,
		@o_canal         	= @w_canal out,
		@o_usuario       	= @w_usuario out,
		@o_hora_real     	= @w_hora_real out,
		@i_codlog_monitor	= @w_codlog_monitor1,
		@i_adhesivo			= @w_adhesivo,
		@i_modo				= 0,
		@o_respuesta		= @w_respuesta out
	
	-- si no existe, buscar la transaccion historica
	--if @@rowcount = 0
	if @w_respuesta = 0 --GAMC - 28/04/2008
	begin
	/*--GAMC - 28/04/2008 - SE COMENTO POR OPTIMIZACION 
		select @w_efec          = isnull(hs_valor, 0), 
		@w_cheque        = isnull(hs_saldo, 0),
		@w_tcredito      = isnull(hs_fonres_iess, 0),       --lfcm 11-mayo-2007
		@w_nota_credito  = isnull(convert(money,hs_cta_banco_dep), 0),
	    @w_nota_debito   = isnull(hs_monto, 0),         --lfcm 11-mayo-2007
	    --@w_nota_debito   = isnull(hs_aporte_iess, 0), --lfcm 11-mayo-2007
		@w_nota_debito   = isnull(hs_monto, 0), 
		@w_efecto_cobro  = isnull(hs_contratado, 0),
		@w_adhesivo_bb   = hs_referencia,
		@w_ruc_bb        = hs_ced_ruc,
		@w_corr_bb       = isnull(hs_correccion, 'N'),
		@w_cta_banco     = hs_cta_banco,
		@w_tipo_cta_tmp  = hs_tipocta,
		@w_oficina       = hs_oficina,
		@w_canal         = hs_tipo_chequera,
		@w_usuario       = hs_usuario,
		@w_hora_real     = hs_hora
		from   cob_cuentas_his..cc_his_servicio
		where  hs_tipo_transaccion in (3611, 3612) and 
			--hs_secuencial = @w_entidad and
			hs_tsfecha       = @w_fecha_pago and
			( convert(numeric, hs_campo_alt_dos) = @w_codlog_monitor or
			hs_referencia    = @w_adhesivo ) and
			hs_correccion    = 'N' and
			hs_secuencial not in ( select hs_ssn_corr
								   from cob_cuentas_his..cc_his_servicio
                                       where hs_tipo_transaccion in ( 3611, 3612 )
                                         and hs_tsfecha    = @w_fecha_pago
	                                 and hs_correccion = 'S' )
	   */
	   --GAMC - 28/04/2008 - POR OPTIMIZACION
	   set @w_codlog_monitor1 = convert(varchar(30), @w_codlog_monitor)
	   	exec sp_procesa_ofp_sri_vhis
	   		@i_fecha_carga		= @w_fecha_pago,
	   		@o_efec   			= @w_efec out,
	   		@o_cheque        	= @w_cheque out,
	   		@o_tcredito      	= @w_tcredito out,
	   		@o_nota_credito  	= @w_nota_credito out,
	   		@o_nota_debito   	= @w_nota_debito out,
	   		@o_efecto_cobro  	= @w_efecto_cobro out,
	   		@o_adhesivo_bb   	= @w_adhesivo_bb out,
	   		@o_ruc_bb        	= @w_ruc_bb out,
	   		@o_corr_bb       	= @w_corr_bb out,
	   		@o_cta_banco     	= @w_cta_banco out,
	   		@o_tipo_cta_tmp  	= @w_tipo_cta_tmp out,
	   		@o_oficina       	= @w_oficina out,
	   		@o_canal         	= @w_canal out,
	   		@o_usuario       	= @w_usuario out,
	   		@o_hora_real     	= @w_hora_real out,
	   		@i_codlog_monitor	= @w_codlog_monitor1,
	   		@i_adhesivo			= @w_adhesivo,
	   		@i_modo				= 0,
			@o_respuesta		= @w_respuesta out
		
		--if @@rowcount = 0
		if @w_respuesta = 0 --GAMC - 29/04/2008
		begin
			select @w_msg_error = 'OTRA FORMA DE PAGO NO EXISTE',
			@w_estado    = 'E',
			@w_existe    = 'N',
			--@w_estado_deb = 'N0'   
			@w_estado_deb = 'NO'   -- lfcm 19-enero-2006
		end
	end

	if @w_existe = 'S' and 1 = 2
	begin
		-- buscar el reverso
		if @w_tipo_tx = 'TX_REVERSA'
		begin
		/*--GAMC - 28/04/2008 - SE COMENTO POR OPTIMIZACION 
			select @w_efec         = isnull(ts_valor, 0), 
			@w_cheque        = isnull(ts_saldo, 0),
			@w_tcredito      = isnull(ts_fonres_iess, 0),       --lfcm 11-mayo-2007
			@w_nota_debito   = isnull(ts_monto, 0),
			@w_efecto_cobro  = isnull(ts_contratado, 0),
			@w_adhesivo_bb   = ts_referencia,
			@w_ruc_bb        = ts_ced_ruc,
			@w_corr_bb       = isnull(ts_correccion, 'N'),
			@w_cta_banco     = ts_cta_banco,
			@w_tipo_cta_tmp  = ts_tipocta,
			@w_oficina       = ts_oficina,
			@w_canal         = ts_tipo_chequera,
			@w_usuario       = ts_usuario,
			@w_hora_real     = ts_hora
			from   cob_cuentas..cc_tran_servicio_resp --_resp
			where  ts_tipo_transaccion in (3611, 3612) and 
                    --ts_secuencial = @w_entidad and
                    ts_tsfecha       = @w_fecha_pago  and
                    convert(numeric, ts_campo_alt_dos) = @w_codlog_monitor and
                    ts_referencia  = @w_adhesivo and
                    ts_correccion = 'S'
		*/
			--GAMC - 28/04/2008 - POR OPTIMIZACION
			set @w_codlog_monitor1 = convert(varchar(30), @w_codlog_monitor)
			exec sp_procesa_ofp_sri_v
				@i_fecha_carga		= @w_fecha_pago,
				@o_efec   			= @w_efec out,
				@o_cheque        	= @w_cheque out,
				@o_tcredito      	= @w_tcredito out,				
				@o_nota_debito   	= @w_nota_debito out,
				@o_efecto_cobro  	= @w_efecto_cobro out,
				@o_adhesivo_bb   	= @w_adhesivo_bb out,
				@o_ruc_bb        	= @w_ruc_bb out,
				@o_corr_bb       	= @w_corr_bb out,
				@o_cta_banco     	= @w_cta_banco out,
				@o_tipo_cta_tmp  	= @w_tipo_cta_tmp out,
				@o_oficina       	= @w_oficina out,
				@o_canal         	= @w_canal out,
				@o_usuario       	= @w_usuario out,
				@o_hora_real     	= @w_hora_real out,
				@i_codlog_monitor	= @w_codlog_monitor1,
				@i_adhesivo			= @w_adhesivo,
				@i_modo				= 1,
				@o_respuesta		= @w_respuesta out
               -- si no existe, buscar la transaccion historica
          
			--if @@rowcount = 0
			if @w_respuesta = 0 --GAMC - 29/04/2008
			begin
			/*--GAMC - 28/04/2008 - SE COMENTO POR OPTIMIZACION 
				select @w_efec          = isnull(hs_valor, 0), 
				@w_cheque        = isnull(hs_saldo, 0),
				@w_tcredito      = isnull(hs_fonres_iess, 0),       --lfcm 11-mayo-2007
				@w_nota_debito   = isnull(hs_monto, 0),
				@w_efecto_cobro  = isnull(hs_contratado, 0),
				@w_adhesivo_bb   = hs_referencia,
				@w_ruc_bb        = hs_ced_ruc,
				@w_corr_bb       = isnull(hs_correccion, 'N'),
				@w_cta_banco     = hs_cta_banco,
				@w_tipo_cta_tmp  = hs_tipocta,
				@w_oficina       = hs_oficina,
				@w_canal         = hs_tipo_chequera,
				@w_usuario       = hs_usuario,
				@w_hora_real     = hs_hora
				from   cob_cuentas_his..cc_his_servicio
				where  hs_tipo_transaccion in (3611, 3612) and 
					--hs_secuencial = @w_entidad and
					hs_tsfecha  = @w_fecha_pago and
					convert(numeric, hs_campo_alt_dos) = @w_codlog_monitor and
					hs_correccion = 'S' 
			 */
			 		--GAMC - 28/04/2008 - POR OPTIMIZACION
					set @w_codlog_monitor1 = convert(varchar(30), @w_codlog_monitor)
					exec sp_procesa_ofp_sri_vhis
						@i_fecha_carga		= @w_fecha_pago,
						@o_efec   			= @w_efec out,
						@o_cheque        	= @w_cheque out,
						@o_tcredito      	= @w_tcredito out,				
						@o_nota_debito   	= @w_nota_debito out,
						@o_efecto_cobro  	= @w_efecto_cobro out,
						@o_adhesivo_bb   	= @w_adhesivo_bb out,
						@o_ruc_bb        	= @w_ruc_bb out,
						@o_corr_bb       	= @w_corr_bb out,
						@o_cta_banco     	= @w_cta_banco out,
						@o_tipo_cta_tmp  	= @w_tipo_cta_tmp out,
						@o_oficina       	= @w_oficina out,
						@o_canal         	= @w_canal out,
						@o_usuario       	= @w_usuario out,
						@o_hora_real     	= @w_hora_real out,
						@i_codlog_monitor	= @w_codlog_monitor1,
						@i_adhesivo			= @w_adhesivo,
						@i_modo				= 1,
						@o_respuesta		= @w_respuesta out
						
					--if @@rowcount = 0
					if @w_respuesta = 0 --GAMC - 29/04/2008
					begin
						select @w_msg_error = 'REGISTRO DE REVERSO DE PAGO NO EXISTE',
						@w_estado    = 'E',
						@w_existe    = 'N',
						@w_estado_deb = 'SI'
					end
			end
		end
       
		--if @w_efec + @w_cheque + @w_nota_debito + @w_efecto_cobro <> @w_valor               --lfcm 05-mayo-2007
		if @w_efec + @w_cheque + @w_tcredito + @w_nota_debito + @w_efecto_cobro <> @w_valor   --lfcm 05-mayo-2007
			select @w_msg_error = 'VALOR DE PAGO NO COINCIDE',
			@w_estado    = 'E',
			@w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
		else
			if @w_adhesivo_bb <> @w_adhesivo
				select @w_msg_error = 'NUMERO DE ADHESIVO NO COINCIDE',
				@w_estado    = 'E',
				@w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
			else
				if @w_ruc_bb <> @w_ruc
					select @w_msg_error = 'NUMERO DE RUC NO COINCIDE',
					@w_estado    = 'E',
					@w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
	end
     
	select @w_oficial        = null,
	@w_nombre_oficial = null
            
	if @w_nota_debito > 0
	begin
		if @w_tipo_cta_tmp = 'C'
		begin
			select @w_oficial = cc_oficial from cob_cuentas..cc_ctacte  where cc_cta_banco = @w_cta_banco
			if @@rowcount = 0
				select @w_msg_error = 'CUENTA CORRIENTE NO EXISTE',
				@w_cta_banco = null
			else
				select @w_tipo_cta_tmp = 'CTE'
		end
         
		if @w_tipo_cta_tmp = 'A'
		begin
			select @w_oficial = ah_oficial from cob_ahorros..ah_cuenta where ah_cta_banco = @w_cta_banco
			if @@rowcount = 0
				select @w_msg_error = 'CUENTA DE AHORRO NO EXISTE',
				@w_cta_banco = null
			else
				select @w_tipo_cta_tmp = 'AHO'
		end

		if not @w_oficial is null
		begin
			select @w_nombre_oficial = fu_nombre
			from   cobis..cc_oficial, cobis..cl_funcionario
			where  oc_funcionario = fu_funcionario and oc_oficial = @w_oficial
			if @@rowcount = 0
				select @w_msg_error  = 'OFICIAL DE CUENTA NO EXISTE',
				@w_oficial    = null
		end
	end

     -- actualizar estado de pago/sri
     update cob_servicios..sv_otra_forma_pago_sri
        set op_estado         = @w_estado,
            op_error          = @w_msg_error,
            op_oficina        = @w_oficina,
            op_estado_debito  = @w_estado_deb,
            op_debito_cuenta  = @w_nota_debito,
            op_efecto_cobro   = @w_efecto_cobro,
            op_efectivo       = @w_efec,
            op_cheque         = @w_cheque,
            op_tcredito       = @w_tcredito,     --lfcm 11-mayo-2007
            op_cta_banco      = @w_cta_banco,
            op_tipocta        = @w_tipo_cta,
            op_oficial        = @w_oficial,
            op_nombre_oficial = @w_nombre_oficial,
            op_canal          = @w_canal,
            op_usuario        = @w_usuario,
            op_hora           = @w_hora_real
     where  op_carga = @w_num_carga and op_sec = @i_sec

     if @@error <> 0 or @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33335,
            @i_msg   = 'ERROR AL ACTUALIZAR REGISTRO DE OTRAS FORMAS DE PAGO'
        return 33335
       end
  end


if @i_operacion = 'B' -- SUMA DE LOS VALORES POR PROCESAR, NO PROCESADOS Y PROCESADOS (CON ERROR INCLUIDO)
  begin
    -- total de la fecha
    select @w_num_carga = cg_numero
    from   cob_servicios..sv_ofp_sri_carga
    where  cg_fecha = @i_fecha_carga
    
     if @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33332,
            @i_msg   = 'NO EXISTE ARCHIVO DE CARGA PARA OTRAS FORMA DE PAGO SRI'
        return 33332
       end
    create table #totale_ofp (
      monto_tot           money null,
      num_tot             int null,
      monto_proc          money null,
      num_proc            int null,
      monto_noproc        money null,
      num_noproc          int null,
      debito_cta_tot      money null,
      debito_cta_proc     money null,
      efecto_tot          money null,
      efecto_proc         money null,
      num_txdir_tot       int null, -- DGA 20/Ene/2006
      mont_txdir_tot      money null, -- DGA 20/Ene/2006
      num_txdir_proc      int null, -- DGA 20/Ene/2006
      mont_txdir_proc     money null, -- DGA 20/Ene/2006
      num_txrev_tot       int null, -- DGA 20/Ene/2006
      mont_txrev_tot      money null, -- DGA 20/Ene/2006
      num_txrev_proc      int null, -- DGA 20/Ene/2006
      mont_txrev_proc     money null -- DGA 20/Ene/2006
    )
    
    insert into #totale_ofp (monto_tot, num_tot) 
    select sum(op_valordebito), count(1)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga
     and   op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006

    update #totale_ofp 
        set monto_proc = sum(op_valordebito), num_proc = count(1)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga
      and  op_estado in ('P') --, 'E')
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006
           

    update #totale_ofp 
        set monto_noproc = sum(op_valordebito), num_noproc = count(1)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga
      and  op_estado <> 'P'
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006

    update #totale_ofp 
        set debito_cta_tot = sum(isnull(op_debito_cuenta, 0))
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga 
      and  isnull(op_debito_cuenta,0) > 0
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006
           
    update #totale_ofp 
        set efecto_tot = sum(op_efecto_cobro)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga 
      and  isnull(op_efecto_cobro, 0) > 0
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006
    
    update #totale_ofp 
        set debito_cta_proc = sum(op_debito_cuenta)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga
      and  op_estado in ('P') --,'E') and 
      and  isnull(op_debito_cuenta,0) > 0
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006

    update #totale_ofp 
        set efecto_proc = sum(op_efecto_cobro)
    from   cob_servicios..sv_otra_forma_pago_sri
    where  op_carga = @w_num_carga
      and  op_estado in ('P') --, 'E') and 
      and  isnull(op_efecto_cobro, 0) > 0
      and  op_tipo_tx <> 'TX_BANCO' -- DGA 31/Ene/2006

/* DGA 20/Ene/2006  */
    update #totale_ofp
       set num_txdir_tot = count(*) -- Numero de transacciones TX_DIRECTA totales
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
       
    update #totale_ofp              -- Monto de transacciones TX_DIRECTA totales
       set mont_txdir_tot = sum(op_valordebito)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_DIRECTA'
       and  op_carga = @w_num_carga
    
    update #totale_ofp
       set num_txdir_proc = count(*) -- Numero de transacciones TX_DIRECTA procesadas
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
       and op_estado = 'P'

    update #totale_ofp               -- Monto de transacciones TX_DIRECTA procesadas
       set mont_txdir_proc = sum(op_valordebito)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
       and op_estado = 'P'
    
    update #totale_ofp               -- Numero de transacciones TX_REVERSA totales
       set num_txrev_tot = count(*)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga

    update #totale_ofp               -- Monto de transacciones TX_REVERSA totales
       set mont_txrev_tot = sum(op_valordebito)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga
       
    update #totale_ofp               -- Numero de transacciones TX_REVERSA procesadas
       set num_txrev_proc = count(*)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga
       and op_estado = 'P'

    update #totale_ofp               -- Monto de transacciones TX_REVERSA procesadas
       set mont_txrev_proc = sum(op_valordebito)
      from cob_servicios..sv_otra_forma_pago_sri
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga       
       and op_estado = 'P'
/* DGA 20/Ene/2006  */          

    set rowcount 0

    select 
        monto_tot           = isnull(monto_tot, 0),
        num_tot             = isnull(num_tot, 0),
        monto_proc          = isnull(monto_proc, 0),
        num_proc            = isnull(num_proc, 0),
        monto_noproc        = isnull(monto_noproc, 0),
        num_noproc          = isnull(num_noproc, 0),
        debito_cta_tot      = isnull(debito_cta_tot, 0),
        debito_cta_proc     = isnull(debito_cta_proc, 0),
        efecto_tot          = isnull(efecto_tot, 0),
        efecto_proc         = isnull(efecto_proc, 0),
        num_txdir_tot       = isnull(num_txdir_tot, 0), -- DGA 20/Ene/2006
        mont_txdir_tot      = isnull(mont_txdir_tot, 0), -- DGA 20/Ene/2006
        num_txdir_proc      = isnull(num_txdir_proc, 0), -- DGA 20/Ene/2006
        mont_txdir_proc     = isnull(mont_txdir_proc, 0), -- DGA 20/Ene/2006
        num_txrev_tot       = isnull(num_txrev_tot, 0), -- DGA 20/Ene/2006
        mont_txrev_tot      = isnull(mont_txrev_tot, 0), -- DGA 20/Ene/2006
        num_txrev_proc      = isnull(num_txrev_proc, 0), -- DGA 20/Ene/2006
        mont_txrev_proc     = isnull(mont_txrev_proc, 0) -- DGA 20/Ene/2006   
    from #totale_ofp    
    
    return 0
  end

--gamc - 06OCT08 - Operacion D - Consulta de los pagos de RISE  
if @i_operacion = 'D' -- SUMA DE LOS VALORES POR PROCESAR, NO PROCESADOS Y PROCESADOS (CON ERROR INCLUIDO)
begin	--if @i_operacion = 'D' - ini
    -- total de la fecha
    
    select @w_num_carga = cg_numero
    from   cob_servicios..sv_rise_sri_carga
    where  cg_fecha = @i_fecha_carga
    
    
     if @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33332,
            @i_msg   = 'NO EXISTE ARCHIVO DE CARGA PARA PAGOs DE SRI-RISE'
        return 33332
       end
            
     
    create table #totales_rise (
      monto_tot           money null,
      num_tot             int null,
      monto_proc          money null,
      num_proc            int null,
      monto_noproc        money null,
      num_noproc          int null,
      debito_cta_tot      money null,
      debito_cta_proc     money null,
      efecto_tot          money null,
      efecto_proc         money null,
      num_txdir_tot       int null, -- DGA 20/Ene/2006
      mont_txdir_tot      money null, -- DGA 20/Ene/2006
      num_txdir_proc      int null, -- DGA 20/Ene/2006
      mont_txdir_proc     money null, -- DGA 20/Ene/2006
      num_txrev_tot       int null, -- DGA 20/Ene/2006
      mont_txrev_tot      money null, -- DGA 20/Ene/2006
      num_txrev_proc      int null, -- DGA 20/Ene/2006
      mont_txrev_proc     money null -- DGA 20/Ene/2006
    )
    	
   insert into cob_servicios..#totales_rise (monto_tot, num_tot) 
	select sum(op_valor), count(1)
	from   cob_servicios..sv_rise_sri_carga_det
	where  op_carga = @w_num_carga
	 and   op_tipo_tx <> 'TX_BANCO'


    update #totales_rise
       set num_txdir_tot = count(*) -- Numero de transacciones TX_DIRECTA totales
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
    
    update #totales_rise              -- Monto de transacciones TX_DIRECTA totales
       set mont_txdir_tot = sum(op_valor)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_DIRECTA'
       and  op_carga = @w_num_carga
    
    update #totales_rise
       set num_txdir_proc = count(*) -- Numero de transacciones TX_DIRECTA procesadas
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
       and op_estado = 'P'

    update #totales_rise               -- Monto de transacciones TX_DIRECTA procesadas
       set mont_txdir_proc = sum(op_valor)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_DIRECTA'
       and op_carga = @w_num_carga
       and op_estado = 'P'
    
    update #totales_rise               -- Numero de transacciones TX_REVERSA totales
       set num_txrev_tot = count(*)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga

    update #totales_rise               -- Monto de transacciones TX_REVERSA totales
       set mont_txrev_tot = sum(op_valor)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga
       
    update #totales_rise               -- Numero de transacciones TX_REVERSA procesadas
       set num_txrev_proc = count(*)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga
       and op_estado = 'P'

    update #totales_rise               -- Monto de transacciones TX_REVERSA procesadas
       set mont_txrev_proc = sum(op_valor)
      from cob_servicios..sv_rise_sri_carga_det
     where op_tipo_tx = 'TX_REVERSA'
       and op_carga = @w_num_carga       
       and op_estado = 'P'
              
    
    update #totales_rise 
		set monto_noproc = sum(op_valor), num_noproc = count(1)
	from   cob_servicios..sv_rise_sri_carga_det
	where  op_carga = @w_num_carga
	  and  op_estado <> 'P'
      and  op_tipo_tx <> 'TX_BANCO'
    
    update #totales_rise 
		set monto_proc = sum(op_valor), num_proc = count(1)
	from   cob_servicios..sv_rise_sri_carga_det
	where  op_carga = @w_num_carga
	  and  op_estado in ('P')
      and  op_tipo_tx <> 'TX_BANCO'

    set rowcount 0

    select 
        monto_tot           = isnull(monto_tot, 0),
        num_tot             = isnull(num_tot, 0),
        monto_proc          = isnull(monto_proc, 0),
        num_proc            = isnull(num_proc, 0),
        monto_noproc        = isnull(monto_noproc, 0),
        num_noproc          = isnull(num_noproc, 0),
        debito_cta_tot      = isnull(debito_cta_tot, 0),
        debito_cta_proc     = isnull(debito_cta_proc, 0),
        efecto_tot          = isnull(efecto_tot, 0),
        efecto_proc         = isnull(efecto_proc, 0),
        num_txdir_tot       = isnull(num_txdir_tot, 0), 
        mont_txdir_tot      = isnull(mont_txdir_tot, 0),
        num_txdir_proc      = isnull(num_txdir_proc, 0),
        mont_txdir_proc     = isnull(mont_txdir_proc, 0),
        num_txrev_tot       = isnull(num_txrev_tot, 0),
        mont_txrev_tot      = isnull(mont_txrev_tot, 0), 
        num_txrev_proc      = isnull(num_txrev_proc, 0), 
        mont_txrev_proc     = isnull(mont_txrev_proc, 0) 
    from #totales_rise    
    
    return 0
end		--if @i_operacion = 'D' - fin  

--gamc 06OCT08 - RISE
if @i_operacion = 'E' -- Verificar Pago
begin	--if @i_operacion = 'E' - ini
	select @w_msg_error = null
     
	select @w_num_carga = cg_numero
	from   cob_servicios..sv_rise_sri_carga
	where  cg_fecha = @i_fecha_carga
    
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33332,
		@i_msg   = 'NO EXISTE ARCHIVO DE CARGA PARA OTRAS FORMA DE PAGO SRI-RISE'
		return 33332
	end
          
	select 
		@w_estado      		= op_estado,
		@w_estado_deb  		= op_debitado,		
		@w_valor       		= op_valor,
		@w_fecha_pago  		= op_fecha_pago,
		@w_tipo_tx     		= op_tipo_tx,
		@w_ruc 		   		= op_ruc,
		@w_codlog_monitor1	= op_tipo_pago,
		@w_comprobante		= op_comprobante,
		@w_secuencial2		= op_cod_trx_bco,
		@w_secuencial_sri	= op_cod_trx_sri --gamc 05NOV08
		
	from cob_servicios..sv_rise_sri_carga_det
	where op_carga    = @w_num_carga 
	  and op_sec      = @i_sec
	  and op_tipo_tx  = 'TX_DIRECTA'
     
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33333,
		@i_msg   = 'NO EXISTE REGISTRO SOLICITADO DE SRI-RISE'
		return 33333
	end
     
	if @w_estado <> 'N'
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 33334,
		@i_msg   = 'REGISTRO SOLICITADO DE OTRA FORMA DE PAGO SRI YA FUE PROCESADO'
		return 33334
	end
     
	select @w_estado = 'P' -- cambiar el estado si no hay error
	
     -- ver si fecha es feriado
	select @w_fecha = @w_fecha_pago

	while 1 = 1
	begin
		if exists(select 1
				  from cobis..cl_dias_feriados
				  where df_ciudad = 1 and df_fecha = @w_fecha)
			select @w_fecha = dateadd(dd,1, @w_fecha)
		else
			break
	end
      
	select @w_fecha_pago = @w_fecha
     
	select @w_existe = 'S'
   
    
	exec sp_procesa_ofp_sri_v
		@i_fecha_carga		= @w_fecha_pago,
		@o_efec   			= @w_efec out,
		@o_cheque        	= @w_cheque out,
		@o_nota_debito   	= @w_nota_debito out,
		@o_ruc_bb        	= @w_ruc_bb out,		
		@o_usuario       	= @w_usuario out,
		@o_hora_real     	= @w_hora_real out,				
		@i_modo				= 2,
		@o_respuesta		= @w_respuesta out,
		@i_comprobante		= @w_comprobante,
		@i_valor			= @w_valor,
		@i_ruc				= @w_ruc,
		@i_tpago			= @w_codlog_monitor1
		
	
	-- si no existe, buscar la transaccion historica
	if @w_respuesta = 0
	begin			    
	   	exec sp_procesa_ofp_sri_vhis
	   		@i_fecha_carga		= @w_fecha_pago,
			@o_efec   			= @w_efec out,
			@o_cheque        	= @w_cheque out,
			@o_nota_debito   	= @w_nota_debito out,
			@o_ruc_bb        	= @w_ruc_bb out,
			@o_usuario       	= @w_usuario out,
			@o_hora_real     	= @w_hora_real out,
			@i_modo				= 2,
			@o_respuesta		= @w_respuesta out,
			@i_comprobante		= @w_comprobante,
			@i_valor			= @w_valor,
			@i_ruc				= @w_ruc,
			@i_tpago			= @w_codlog_monitor1
	
		if @w_respuesta = 0
		begin			
			select @w_msg_error = 'OTRA FORMA DE PAGO RISE NO EXISTE',
			@w_estado    = 'E',
			@w_existe    = 'N',			
			@w_estado_deb = 'NO'
		end		
	end
	
	 --gamc 05NOV08
	if exists(select 1 from cob_servicios..sv_rise_sri_carga_det
			              where op_cod_trx_sri = @w_secuencial_sri
			              	and op_cod_trx_bco = @w_secuencial2
			              	and op_comprobante = @w_comprobante
			              	and op_valor = @w_valor
			              	and op_estado = 'P')
	begin
		--'REGISTRO DE PAGO SRI-RISE YA EXISTE'
		set @w_estado_deb = 'NO',
			@w_estado	  = 'E',
			@w_msg_error = 'OTRA FORMA DE PAGO RISE YA EXISTE'
	end

     -- actualizar estado de pago/sri
     update cob_servicios..sv_rise_sri_carga_det
        set op_estado         = @w_estado,
            op_error          = @w_msg_error,
            op_debitado       = @w_estado_deb,
            --op_valor          = (@w_nota_debito + @w_cheque + @w_efec),
            op_usuario        = @w_usuario,
            op_hora           = @w_hora_real
     where  op_carga = @w_num_carga and op_sec = @i_sec

     if @@error <> 0 or @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33335,
            @i_msg   = 'ERROR AL ACTUALIZAR REGISTRO DE OTRAS FORMAS DE PAGO'
        return 33335
       end
end		--if @i_operacion = 'E' - fin


if @i_operacion = 'C' -- Imprimir
  begin
  	/*--GAMC - 28/24/2008 - SE COMENTO POR OPTIMIZACION
    select cg_archivo,
        cg_cod_banco,
        cg_nombre_banco,
        cg_fecha_recauda = convert(varchar, cg_fecha_recauda, 101),
        cg_recaudacion_total,
        cg_recaudacion_pago,
        cg_recaudacion_rev,
        cg_declaraciones_total,
        cg_declaraciones_pago,
        cg_declaraciones_rev,
        -- esta columna posee los nombres de cada tag para el archivo xml: el orden corresponde
        -- a cada columna devuelta por este select desde cg_cod_banco hasta cg_declaraciones_rev
        cabecera_tags =  'codigoBanco,nombreBanco,fechaRecaudacion,montoRecaudadoPorTxPagoTxReverso,' +
                 'montoRecaudadoPorTxPago,montoRecaudadoPorTxReverso,numeroDeclaracionesPorTxPagoTxReverso,' +
                 'numeroDeclaracionesPorTxPago,numeroDeclaracionesPorTxReverso'
    from  cob_servicios..sv_ofp_sri_carga
    where cg_fecha = @i_fecha_carga
	*/
	--gamc - 06OCT08 - Se cambio para que consulte rise tambien
  	if @i_proceso = 'OFP'
  	begin	--if @i_proceso = 'OFP' - ini
		--GAMC - 28/04/2008 - POR OPTIMIZACION
		exec sp_procesa_ofp_sri_c
			@i_fecha_carga		= @i_fecha_carga, --@i_fecha_proceso,		--GAMC 08/05/2008
			@o_respuesta		= @w_respuesta out
		
		if @w_respuesta = 0
		 begin
		  exec cobis..sp_cerror
			  @t_debug = @t_debug,
			  @t_file  = @t_file,
			  @t_from  = @w_sp_name,
			  @i_num   = 33335,
			  @i_msg   = 'SE EXITE ARCHIVO DE OTRA FORMA DE PAGO SRI PARA LA FECHA SOLICITADA'
		  return 33333
		 end
	end		--if @i_proceso = 'OFP' - fin
	
	if @i_proceso = 'RISE'
	begin	--if @i_proceso = 'RISE' - ini		
		exec sp_procesa_ofp_sri_c
			@i_fecha_carga		= @i_fecha_carga,
			@i_modo				= 1,
			@o_respuesta		= @w_respuesta out

		if @w_respuesta = 0
		 begin
		  exec cobis..sp_cerror
			  @t_debug = @t_debug,
			  @t_file  = @t_file,
			  @t_from  = @w_sp_name,
			  @i_num   = 33335,
			  @i_msg   = 'NO EXITE ARCHIVO DE SRI-RISE PARA LA FECHA SOLICITADA'
		  return 33335
		 end
	end		--if @i_proceso = 'RISE' - fin
	
  end

if @i_operacion = 'R' --REVISION Y AUDITORIA DE LAS TRANSACCIONES HISTORICAS DGA 26/Ene/2006
  begin
    if @i_control = 2
      begin
      	--GAMC - 28/04/2008 - POR OPTIMIZACION
		exec sp_procesa_ofp_sri_r
			@i_fecha_carga		= @i_fecha_proceso,		
			@i_referencia		= @i_referencia
      /*--GAMC - 28/24/2008 - SE COMENTO POR OPTIMIZACION
        select
          "REFERENCIA"     = hs_referencia,
          "NOMBRE"         = hs_nombre,
          "USUARIO"        = hs_usuario,
          "EFECTIVO"       = hs_valor,
          "N/C"            = hs_cta_banco_dep,
          "CHEQUE"         = hs_saldo,
          "EFECTO COBRO"   = hs_contratado,
          "N/D"            = hs_monto,
          "N/C real"       = hs_cta_asociada,
          "TOTAL"          = (hs_valor + hs_monto + hs_saldo),
          "CORRECCION"     = hs_correccion,
          "TIPO TRAN"      = hs_tipo_transaccion,
          "REENTRY"        = hs_reentry,
          "SERVER"         = hs_nodo,
          "SEC. PAC."      = hs_remoto_ssn,
          "OFICINA"        = hs_oficina,
          "TIPO CTA"       = hs_ctacte,
          "NUM. CTA."      = hs_cta_banco,
          "CAUSA"          = hs_causa,
          "NUM. FACT"      = hs_descripcion_ec,
          "NUM. CONTRATO"  = hs_autorizante,
          "ANO FACT"       = hs_propietario,
          "LOCALIDAD"      = hs_cheque_desde,
          "PROVINCIA"      = hs_cheque_hasta,
          "CANAL"          = hs_tipo_chequera,
          "TERMINAL"       = hs_terminal
        from cob_cuentas_his..cc_his_servicio
        where hs_referencia = @i_referencia
          and hs_tsfecha    = @i_fecha_proceso
          and hs_tipo_transaccion in (3611, 3612)
      */
      end
      
      
  end

if @i_operacion = 'X' --CONSULTA DE TRANSACCIONES QUE NO VIENE EN MALLA DGA 31/Ene/2006
  begin  
  	--gamc - 06OCT08 - Se cambio para que consulte rise tambien
  	if @i_proceso = 'OFP'
  	begin
		--GAMC - 28/04/2008 - POR OPTIMIZACION
		exec sp_procesa_ofp_sri_q
			@i_fecha_carga		= @i_fecha_proceso,		
			@i_modo				= 1
	end
	if @i_proceso = 'RISE'
	begin
		exec sp_procesa_ofp_sri_q
			@i_fecha_carga		= @i_fecha_proceso,
			@i_modo				= 3
	end
  	
  	/*--GAMC - 28/24/2008 - SE COMENTO POR OPTIMIZACION
  	set rowcount 0
  	
    select
      ' ',
      Estado = op_estado,
      tipoTx = op_tipo_tx,
      codigoLogMonitor = op_codlog_monitor,
      numeroRuc = op_ruc,
      codigoImpuesto = op_codimpuesto,
      valorDebitar = op_valordebito,
      adhesivo = op_adhesivo, --20
      fechaPago = convert(varchar, op_fecha_pago, 101),
      estadoDebito = op_estado_debito,
      Oficina = op_oficina,
      "Nombre Oficina" = of_nombre,
      Efectivo = isnull(op_efectivo, 0),
      Cheque = isnull(op_cheque, 0),
      Efecto = isnull(op_efecto_cobro, 0),
      Debito = isnull(op_debito_cuenta, 0),
      'Tipo Cta' = op_tipocta,
      Cuenta = op_cta_banco,
      Oficial = op_oficial,
      "Nombre Oficial"= op_nombre_oficial,
      Canal = op_canal,
      Usuario = op_usuario,
      "Fecha Real Trx" = convert(varchar, op_hora, 101) + ' ' + convert(varchar, op_hora, 108),
      Mensaje = op_error,
      Secuencia = op_sec
    from cob_servicios..sv_ofp_sri_carga, cob_servicios..sv_otra_forma_pago_sri,
         cobis..cl_oficina
    where cg_fecha = @i_fecha_proceso and --op_estado = 'N' and
          cg_numero = op_carga and
          op_tipo_tx = 'TX_BANCO' and
          op_oficina *= of_oficina
    order by op_sec
    
    set rowcount 0
    */
    return 0
  end
  
return 0
go

