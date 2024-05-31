update cobis..cl_parametro
set pa_datetime = '05/14/2023'
where pa_nemonico = 'FCA06'

select * from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
and cd_tipo_servicio = 'TA01610000'
and cd_canal='O'

--delete from cob_super..cc_detalle_a06 where cd_fecha_corte = '05/15/2023'
--delete from cob_ahorros_acum..ah_his_mov_a06

select * from cob_super..cc_a06_causa where ac_canal = 'O' and ac_causa  = '645'
cob_super..cc_a06_causa where ac_canal = 'O' and ac_causa  = '645'

--SE REALIZABA UN PROBLEMA CUANDO EXISTIAN TRX D TODOS LOS CANALES Y ERAN 5 TRX EN ATX Y APARECIAN 8 
--PARECIA Q ERAN CON LAS TRX D DEB Y CC ENTONCS SE ELINO D ESTA TABLA
delete from cob_super..cc_a06_causa where ac_canal = 'O' and ac_causa = '645'



cd_producto cd_fecha_corte              cd_canal cd_tipo_servicio cd_tipo_producto cd_descripcion                                                                                       cd_tipo_tarjeta cd_clase_tarjeta cd_tipo_tarifa cd_tipo_cliente cd_numero_trans cd_tarifa                cd_ingreso_total         cd_tasa_ponderada          cd_cta_contable      cd_prop_canal cd_cod_provincia cd_cod_canton cd_cargo_porcentaje        cd_ingreso_neto            cd_monto_base              cd_base_imponible          cd_iva_pagado              
----------- --------------------------- -------- ---------------- ---------------- ---------------------------------------------------------------------------------------------------- --------------- ---------------- -------------- --------------- --------------- ------------------------ ------------------------ -------------------------- -------------------- ------------- ---------------- ------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- 
3           May 15 2023 12:00AM         I        TA01610000                        Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             4               0.27                     1.08                     (null)                     540608                                                            0.00                       1.08                       0.00                       1.08                       0.12                       
3           May 15 2023 12:00AM         M        TA01610000                        Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             2               0.27                     0.54                     (null)                     540608                                                            0.00                       0.54                       0.00                       0.54                       0.06                       
3           May 15 2023 12:00AM         C        TA01610000                        Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             0               0.27                     0.0                      (null)                     540608               P             09               01            0.00                       0.00                       0.00                       0.00                       0.00                       
3           May 15 2023 12:00AM         O        TA01610000                        Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             0               0.0                      0.0                      (null)                     540608                                                            0.00                       0.00                       0.00                       0.00                       0.00                       
3           May 15 2023 12:00AM         N        TA01610000                        Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas     (null)          (null)           TA                             0               0.51                     0.0                      (null)                     540608               P             09               01            0.00                       0.00                       0.00                       0.00                       0.00                       
3           May 15 2023 12:00AM         O        TA01610000                        Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas II  (null)          (null)           TA                             5               0.51                     2.54                     (null)                     540608               P             09               01            0.00                       2.54                       0.00                       2.54                       0.31                       
