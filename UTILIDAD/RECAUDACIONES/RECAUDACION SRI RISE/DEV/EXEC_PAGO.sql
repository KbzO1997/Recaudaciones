
declare @w_return           int,
		@v_ssn      int,
		@v_mensaje  varchar(80),
		@v_codigo   int


exec @w_return = cob_pagos..pa_pg_tpag_reca_varios
@e_ssn                  = 135649782,
@e_srv                  = 'SRVDESA2',
@e_user                 = 'msilvag',
@e_term                 = 'VIRTUAL_BB',
@e_date                 = '06/14/2023',
@e_ofi                  = 0,
@e_rol                  = 252,
@e_corr                 = 'N',
@e_ssn_corr             = 0,      
@e_trn                  = 3295,
@e_mon                  = 1,
@e_ruc_cliente          = '1102479522',
@e_servicio             = 'SRI-TRNF-DOM',
@e_empresa              ='9718',
@e_efectivo             = 757.75,
@e_cheque               = 0,
@e_debito               = 0,
@e_tarjeta              = 0,
@e_comision_tot         = 0.6,
@e_comision_efe         = 0.60,
@e_comision_chq         = 0,
@e_comision_db          = 0,
@e_total                = 757.75,
@e_cant_cheques         = 0,
@e_tipo_cta             = 'CTE', 
@e_cuenta               = '',
@e_nombre_cta           = '',
@e_autoriza             = 'N',
@e_canal                = 'VEN',
@e_ubi                  = 0,
@e_codigo               = '0888',  
@e_cod_referencia       = '',
@e_nombre_cliente       = '',
@e_base_imponible       = 0,
@e_factura              = '2,279.00', 
@e_cod_respuesta        = '0',
@e_cod_grupo            = '',
@e_nomb_tramite         = '',
@e_pcodigo_operacion    = '', 
@e_pcodigo_secuencia    = '', 
@e_phoralocal           = '',
@e_cod_consultora	= 0,
@s_cod_respuesta        = @v_codigo out,
@s_mensaje_respuesta    = @v_mensaje out,
@s_ssn                  = @v_ssn out

print "retorno: %1!", @w_return
print "codError: %1!", @v_codigo 
print "codMsg: %1!", @v_mensaje 
print "ssn: %1!", @v_ssn 




insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal, ts_correccion,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia, ts_saldo,		 ts_ssn_corr, ts_cta_banco,
              ts_moneda, ts_tipo, ts_valor, ts_monto,ts_contratado,ts_tsn,ts_hora, ts_endoso, ts_causa,ts_servicio,
              ts_tipocta,ts_tipo_def,ts_descripcion_ec, ts_ubicacion,
        ts_fonres_iess,  -- drodriguez CTE-CC-9217
        ts_aporte_iess,   -- drodriguez CTE-CC-9217
        ts_tipo_chequera, --Ref:4 dpereirv
        ts_autorizante  --Ref006:msilvag
       )
      values (@s_ssn, @t_trn, @s_ofi, 
	  @s_user, @s_rol, @s_term, @t_corr,
              null, 'L', @s_lsrv, @s_date, 'C', 
			  @i_codigo, @i_cheque, 		@t_ssn_corr, @i_cuenta,
              1, 'L',  @i_efectivo, @i_debito,@w_efec_com_atm, @i_tsn, getdate(),
              @w_secuencial, @i_servicio,@w_emp, @w_tipocta, @i_aplcobis,@i_codigo, @i_ubi,
              @i_tarjeta,     -- drodriguez CTE-CC-9217
              @i_cruce_dpto,   -- drodriguez CTE-CC-9217
              @i_canal, --Ref:4 dpereirv
              @i_nomb_tramite --Ref006:msilvag
       )