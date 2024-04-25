
--ALTER TABLE cob_pagos..iess_tran_servicio DROP COLUMN forma_pago
--ALTER TABLE cob_pagos..pg_concilia_iess DROP COLUMN di_forma_pago
--ALTER TABLE cob_pagos..iess_tran_servicio DROP COLUMN di_forma_pago

ALTER TABLE cob_pagos..pg_concilia_resp_iess ADD di_forma_pago VARCHAR(3) NULL
ALTER TABLE cob_pagos..iess_tran_servicio ADD forma_pago VARCHAR(3) NULL
ALTER TABLE cob_pagos..pg_concilia_iess ADD di_forma_pago VARCHAR(3) NULL


select * from cob_cuentas..cc_tran_servicio where ts_secuencial in(60015011, 60015010)

cob_pagos..sp_helptext sp_concilia_iess, null, null, showsql
--select * from cob_pagos..pg_concilia_resp_iess

select * from cob_pagos..iess_tran_servicio
ced_ruc       sucursal rubro      num_comp         valor                      fec_cble                    fec_proceso                 num_operabco num_operaies fecha_trx_local hora_trx_local est_conciliacion usuario    nombre                                                                           tip_trx     forma_pago 
------------- -------- ---------- ---------------- -------------------------- --------------------------- --------------------------- ------------ ------------ --------------- -------------- ---------------- ---------- -------------------------------------------------------------------------------- ----------- ---------- 
2390020190001 0001     CUOCON     0000000000504346 50.00                      Oct 11 2023 12:00AM         Oct 11 2023 12:00AM         60015010     152197868    (null)          205000                          ope998     TRES M DE ECUADOR C.A.                                                           3928        TC         
2390020190001 0001     CUOCON     0000000000504346 50.00                      Oct 11 2023 12:00AM         Oct 11 2023 12:00AM         60015011     152197868    (null)          205900                          ope998     TRES M DE ECUADOR C.A.                                                           3928        TC         

select * from cob_pagos..pg_concilia_iess 
di_ced_ruc    di_sucursal di_rubro   di_num_comp      di_valor                   di_fec_cble                 di_fec_proceso              di_num_operabco di_num_operaies di_resultado  di_estatus_bco di_estatus_emp_serv di_cierre_conc di_total_pendpago          di_usuario di_hora_trn_local di_nombre                                                                        di_tip_trx  di_forma_pago 
------------- ----------- ---------- ---------------- -------------------------- --------------------------- --------------------------- --------------- --------------- ------------- -------------- ------------------- -------------- -------------------------- ---------- ----------------- -------------------------------------------------------------------------------- ----------- ------------- 
2390020190001 0001        CUOCON     0000000000504346 50.00                      Oct 11 2023 12:00AM         Oct 11 2023 12:00AM         60015010        152197868       BO            SI             NO                  S              0.00                       ope998     205000            TRES M DE ECUADOR C.A.                                                           3928        TC            
2390020190001 0001        CUOCON     0000000000504346 50.00                      Oct 11 2023 12:00AM         Oct 11 2023 12:00AM         60015011        152197868       BO            SI             NO                  S              0.00                       ope998     205900            TRES M DE ECUADOR C.A.                                                           3928        TC            

--SELECT QUE SE VE EN EL TSERVICE
select 
      'ced_ruc'       = ts_referencia,                                         
      'sucursal'        = ts_propietario,                                       --codigo de sucursal
      'rubro'       = ts_campo_alt_uno,                                         --Codigo de rubro
      'num_comp'     = ts_campo_alt_dos,                                    --Numero de comprobante
      'valor'          = (ts_saldo + ts_monto + ts_valor+ts_contratado),                  
      'fec_cble'  = ts_tsfecha,                                     --Fecha contable
      'fec_proceso'  = ts_tsfecha,                                     --Fecha proceso
      'num_operabco' = ts_secuencial,  					--secuencial del banco
      'num_operaies' = ts_stick_imp,					--secuencial del IESS
      'fecha_trx_local'  = ts_corresponsal,                                     --Fecha Transaccion Local
      'hora_trx_local'   = substring(convert(varchar(8),ts_hora,108),1,2) +
                           substring(convert(varchar(8),ts_hora,108),4,2) +
                           substring(convert(varchar(8),ts_hora,108),7,2),      --Hora Transaccion Local
      'est_conciliacion' = "",                                                  --Estado Conciliacion
      'usuario'          = ts_usuario,
      'nombre' 		 = ts_nombre,
      'tip_trx'		 = ts_tipo_transaccion,
	  'forma_pago' = CASE WHEN ts_contratado > 0 THEN 'TC'
  			ELSE ts_tipocta
			END
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (3925, 3926, 3928)
      and ts_tsfecha = '10/11/2023'      
      and ts_causa = '2494'
      and ts_correccion = 'N'


--SELECT QUE VA AL REPORTE EXCEL
select convert(varchar(10),di_fec_cble,101),
	ci_descripcion,
	of_nombre,
	'canal'= CASE lower(di_usuario) --REF 9
		 WHEN 'ope998' THEN 'INTERNET'
		 when 'srolese' then 'SAT'	--REF 6
		 when 'wap' then 'MOVIL' --REF 9
		 when 'cnb001' then 'CNB'	--REF 7
		 ELSE 'VENTANILLA' 
		 END,
	di_usuario,
	di_valor,
	ts_valor,
	ts_saldo,
	ts_monto,
	'Hora'= convert(varchar(10),di_fec_cble,101) + ' ' + substring(di_hora_trn_local,1,2) + ":" + substring(di_hora_trn_local,3,2) + ":" +  substring(di_hora_trn_local,5,2) ,
	di_ced_ruc,
	di_nombre,
	di_rubro,
	di_num_operabco,
	di_num_comp	--REF 4
	from cob_pagos..pg_concilia_iess,cob_cuentas..cc_tran_servicio,cobis..cl_oficina ,cobis..cl_ciudad
	where di_resultado in('OK','BO')
	and di_fec_cble = '10/11/2023'
	--and di_num_operabco > @i_siguiente
	and di_num_operabco = ts_secuencial
	and ts_causa ='2494'	--tc 09182009
	and ts_tipo_transaccion in(3925, 3926,  3928)		--tc 09182009
	and of_oficina = ts_oficina 
	and of_ciudad = ci_ciudad
	order by di_num_operabco