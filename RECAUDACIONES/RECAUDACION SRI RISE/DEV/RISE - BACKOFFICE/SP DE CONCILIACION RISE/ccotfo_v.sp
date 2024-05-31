/************************************************************************/
/*      Archivo            :  ccotfo_v.sp                               */
/*      Stored procedure   :  sp_procesa_ofp_sri_v	    				*/
/*      Base de datos      :  cob_servicios                             */
/*      Producto		   :  Cuentas Corrientes                        */
/*      Disenado por       :  German Medina	C.		                    */
/*      Fecha de escritura :  ABR/2008                                  */
/************************************************************************/
/*        IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*                           PROPOSITO                                  */
/*		Optimizacion de SP												*/
/************************************************************************/
/*                        MODIFICACIONES                                */
/*		FECHA       AUTOR           	RAZON                           */
/*		28/04/2008	GERMAN MEDINA C.	Emision inicial					*/
/*		06/10/2008	GERMAN MEDINA C.	Recaudaciones Rise				*/
/************************************************************************/



use cob_servicios
go

if exists (select 1 from sysobjects where name = 'sp_procesa_ofp_sri_v')
    drop proc sp_procesa_ofp_sri_v
go

create procedure sp_procesa_ofp_sri_v
	@i_fecha_carga   	datetime      	= null,
	@o_efec   			money			= null out,
	@o_cheque        	money			= null out,
	@o_tcredito      	money			= null out,
	@o_nota_credito  	money			= null out,
	@o_nota_debito   	money			= null out,
	@o_efecto_cobro  	money			= null out,
	@o_adhesivo_bb   	varchar(20)		= null out,
	@o_ruc_bb        	varchar(13)		= null out,
	@o_corr_bb       	char(1)			= null out,	
	@o_cta_banco     	cuenta			= null out,
	@o_tipo_cta_tmp  	char(1)			= null out,
	@o_oficina       	smallint		= null out,
	@o_canal         	varchar(5)		= null out,
	@o_usuario       	descripcion		= null out,
	@o_hora_real     	datetime		= null out,	
	@i_comprobante		varchar(20)		= null,			--gamc 06OCT08
	@i_tpago			varchar(30)		= null,			--gamc 06OCT08
	@i_ruc				varchar(15)		= null,			--gamc 06OCT08
	@i_valor			money			= null,			--gamc 06OCT08
	@i_secuencial		int				= null,			--gamc 06OCT08
	@i_codlog_monitor	varchar(30)		= null,
	@i_adhesivo			varchar(15)		= null,
	@i_modo				smallint		= 0,
	@o_respuesta     	smallint      	= 0 out
	
as
	set @o_respuesta = 1
	if @i_modo = 0
	begin	--if @i_modo = 0 - INI
		select 
			@o_efec          = isnull(ts_valor, 0), 
			@o_cheque        = isnull(ts_saldo, 0),
			@o_tcredito      = isnull(ts_fonres_iess, 0),
			@o_nota_credito  = isnull(convert(money,ts_cta_banco_dep), 0),
			@o_nota_debito   = isnull(ts_monto, 0),
			@o_efecto_cobro  = isnull(ts_contratado, 0),
			@o_adhesivo_bb   = ts_referencia,
			@o_ruc_bb        = ts_ced_ruc,
			@o_corr_bb       = isnull(ts_correccion, 'N'),
			@o_cta_banco     = ts_cta_banco,
			@o_tipo_cta_tmp  = ts_tipocta,
			@o_oficina       = ts_oficina,
			@o_canal         = ts_tipo_chequera,
			@o_usuario       = ts_usuario,
			@o_hora_real     = ts_hora
			from   cob_cuentas..cc_tran_servicio_resp --_resp
			where  ts_tipo_transaccion in (3611, 3612) and 			
				ts_tsfecha       = @i_fecha_carga  and
				(ts_campo_alt_dos = @i_codlog_monitor or
				ts_referencia    = @i_adhesivo ) and
				ts_correccion    = 'N' and
				ts_secuencial not in ( select ts_ssn_corr
									   from cob_cuentas..cc_tran_servicio_resp
										   where ts_tipo_transaccion in ( 3611, 3612 )
											 and ts_tsfecha    = @i_fecha_carga
										 and ts_correccion = 'S' )


		if @@rowcount = 0
			set @o_respuesta = 0
	end		--if @i_modo = 0 - FIN
	else
	begin	--else @i_modo = 1 - INI
		select 
			@o_efec         = isnull(ts_valor, 0), 
			@o_cheque        = isnull(ts_saldo, 0),
			@o_tcredito      = isnull(ts_fonres_iess, 0),
			@o_nota_debito   = isnull(ts_monto, 0),
			@o_efecto_cobro  = isnull(ts_contratado, 0),
			@o_adhesivo_bb   = ts_referencia,
			@o_ruc_bb        = ts_ced_ruc,
			@o_corr_bb       = isnull(ts_correccion, 'N'),
			@o_cta_banco     = ts_cta_banco,
			@o_tipo_cta_tmp  = ts_tipocta,
			@o_oficina       = ts_oficina,
			@o_canal         = ts_tipo_chequera,
			@o_usuario       = ts_usuario,
			@o_hora_real     = ts_hora
			from   cob_cuentas..cc_tran_servicio_resp --_resp
			where  ts_tipo_transaccion in (3611, 3612) and 
					ts_tsfecha       = @i_fecha_carga and
					ts_campo_alt_dos = @i_codlog_monitor and
					ts_referencia  = @i_adhesivo and
					ts_correccion = 'S'
		
		if @@rowcount = 0
			set @o_respuesta = 0
	end		--else @i_modo = 1 - FIN	
	--gamc - 06OCT08 - Se agrego nuevo metodo para RISE
	if @i_modo = 2
	begin	--if @i_modo = 2 - INI
		
		
		set @o_respuesta = 1		
		select 
			@o_efec          = isnull(ts_valor, 0), 
			@o_cheque        = isnull(ts_saldo, 0),
			@o_tcredito      = isnull(ts_fonres_iess, 0),
			@o_nota_credito  = isnull(convert(money,ts_cta_banco_dep), 0),
			@o_nota_debito   = isnull(ts_monto, 0),
			@o_efecto_cobro  = isnull(ts_contratado, 0),
			@o_adhesivo_bb   = ts_referencia,
			@o_ruc_bb        = ts_ced_ruc,
			@o_corr_bb       = isnull(ts_correccion, 'N'),
			@o_cta_banco     = ts_cta_banco,
			@o_tipo_cta_tmp  = ts_tipocta,
			@o_oficina       = ts_oficina,
			@o_canal         = ts_tipo_chequera,
			@o_usuario       = ts_usuario,
			@o_hora_real     = ts_hora
			from   cob_cuentas..cc_tran_servicio_resp
			where ts_tsfecha = @i_fecha_carga 
			and ts_tipo_transaccion in ( 3934, 3935 ) 
			and ts_stick_imp      = @i_comprobante
			and ts_campo_alt_dos  = @i_tpago
			and ts_referencia	  = @i_ruc
			and ts_valor + ts_monto + ts_saldo = @i_valor
			--and ts_secuencial = @i_secuencial
			and ts_secuencial not in ( select isnull(ts_sec_correccion, 0)
										 from cob_cuentas..cc_tran_servicio_resp
										where ts_tsfecha = @i_fecha_carga											
										  and ts_tipo_transaccion in ( 3934, 3935 ) 										  
										  and ts_correccion = "S" ) 
			and ts_correccion     = "N"       

			if @@rowcount = 0
				set @o_respuesta = 0	
	
	end		--if @i_modo = 2 - FIN

return 0
go
