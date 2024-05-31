
DECLARE @s_comisionc float
use cob_internet
		
exec @s_comisionc =  dbo.pa_cash_cprocesar_tarifaBP 
	@e_identificacion = '1705243804',
	@e_servicio = '22289',	
	@e_id_funcionalidad = '2056',
	@e_canal = 'IBK',
	@e_codigo_empresa_proveedora  = 1929,
	@e_accion_revocatoria_ch = '',
	@e_cuenta = '5005070292',
	@e_tipo_cuenta  = 'CTE',
	@e_tipo_impuesto_fiscal = null,
	@e_codigo_empresa = 1929,
	@e_pais = NULL,
	@s_comision = 0,
	@e_se_debita = 'false'

select @s_comisionc

Variable 11 = 22289
e_id_funcionalidad 1 = 2056
e_codigo_empresa_proveedora 1 = 22289
e_tipo_cuenta 1 = CTE
s_mensaje_usuario 1 = TRANSACCION EXITOSA
                         
                     
DECLARE @s_comision float
use cob_internet
		
exec @s_comision =  dbo.pa_cash_cprocesar_tarifaBP 
	@e_identificacion = '1705243804',
	@e_servicio = '8459',	
	@e_id_funcionalidad = '2056',
	@e_canal = 'IBK',
	@e_codigo_empresa_proveedora  = 1929,
	@e_accion_revocatoria_ch = '',
	@e_cuenta = '5005070292',
	@e_tipo_cuenta  = 'CTE',
	@e_tipo_impuesto_fiscal = null,
	@e_codigo_empresa = 1929,
	@e_pais = NULL,
	@s_comision = 0,
	@e_se_debita = 'false'

select @s_comision

e_id_funcionalidad 1 = 2056
e_codigo_empresa_proveedora 1 = 8459
e_tipo_cuenta 1 = CTE
s_mensaje_usuario 1 = TRANSACCION EXITOSA
                         
select  *
from cob_internet..cash_p_tarifario_funcionalidad 
where tf_idFuncionalidad = '2056'
and tf_estado = 'A'
and tf_ambito = 'BP'	
and tf_codigoEmpresaProveedora  = 2228
and tf_tipo_cuenta = 'CTE'



--SAT
                     
DECLARE @s_comision float
use cob_internet
		
exec @s_comision =  dbo.pa_cash_cprocesar_tarifaBE 
	@e_identificacion = '0990000085001',
	@e_id_funcionalidad = '2056',
	@e_canal = 'SAT',
	@e_servicio = '22289',
	@e_codigo_empresa = NULL,
	@e_alcance = 'E',
	@e_monto  = 1,
	@e_pais = NULL,
	@e_cargo = NULL,
	@e_cuenta = '0000064323',
	@e_tipo_cuenta = 'CTE',
	@e_banco = '',
	@e_forma_pago = '',
	@e_accion_revocatoria_ch = '',
	@e_tipo_impuesto_fiscal = '',
	@e_codigo_empresa_proveedora = 1929,
	@e_se_debita = 'false'

select @s_comision

v_opcion 1 = N
v_cod_servicio v_id_servicio retorno     
-------------- ------------- ----------- 
CSPR           77            0           
Variable 1 = 0.3
                         
------------------------ 
0.0                      
