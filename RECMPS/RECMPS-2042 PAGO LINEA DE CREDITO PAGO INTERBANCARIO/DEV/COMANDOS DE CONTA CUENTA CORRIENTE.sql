PROCESO DE CONTABILIDAD CUENTAS CORRIENTES

cd /fuentes/cobis/cuentas/ctacte/batch/fuentes

sqr cctotser_TESTjose3.sqr -debug crodrigm/Pcrouez+14
Parametro Prueba #1:  1
Parametro Prueba #2:  Fecha proceso
Parametro Prueba #3:  Usuario        (Opcional)


--Verificar si existen cotizaciones
Select * from cob_conta..cb_cotizacion where ct_fecha = '11/14/2019' and ct_moneda = 0


sqr cctotmon_TEST.sqr -debug crodrigm/Pcrouez+14
Parametro Prueba #1:  1
Parametro Prueba #2:  Fecha proceso
Parametro Prueba #3:  Usuario        (Opcional)

--Verifica el ingreso de la data luego de ejecutar cctotmon
SELECT * from cob_cuentas..cc_control_contabilidad

--Verificar que exista información con este select
Select * from cob_cuentas..cc_control_contabilidad 
where cc_fecha = '11/14/2019' and cc_producto = 3 and cc_transaccion = 'S'

sqr ccgencom.sqr -debug crodrigm/Pcrouez+14
Parametro Prueba #1:  1
Parametro Prueba #2:  Fecha proceso

sqr cccontable.sqr -debug crodrigm/Pcrouez+14
Parametro Prueba #1:  3
Parametro Prueba #2:  Fecha proceso

--Genera los reportes (cccontable.lis, ccgencom.lis).