====================PARAMETRIZACIONES DE EMPRESAS POR PRUEBAS=======================
CODIGO = 7731
DESCRIPCION = TVCABLE GUAYAQUIL (CABLE FUTURO)
tablas = 'sv_emp_grupotvcable' , 'sv_empresas_latinia'

cob_pagos..sp_helptext sp_pago_servicios_varios, null, null, showsql

select * from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo 
where c.codigo = '7731'and t.tabla = 'sv_emp_grupotvcable' and c.estado = 'V'

select * from cobis..cl_catalogo c inner join cobis..cl_tabla t on c.tabla = t.codigo 
where  c.codigo = '7731' and t.tabla = 'sv_empresas_latinia' and c.estado = 'V'
			

--@w_cliente,@w_categoria ,@w_nombre_cta 
select ah_cliente,ah_categoria ,substring(ah_nombre,1,32) from cob_ahorros..ah_cuenta
where ah_cta_banco = '0002096068'

declare
@w_return  int,
@w_telefono varchar(30),@w_correo varchar(30)
begin
 exec @w_return = cob_pagos..sp_consulta_celular       
	@i_cliente = 429, --ah_cliente
    @o_celular = @w_telefono  out,
	@o_correo=@w_correo  out     
print '%1!,%2!,%3!' , @w_return, @w_telefono, @w_correo
end

cob_pagos..sp_helptext sp_consulta_celular, null, null, showsql

select de_alert_manager,* from cobis..cl_direccion_email	
where  de_descripcion = 'jmunozd@bolivariano.com' 
order by de_fecha_modificacion desc

select * from cobis..cl_catalogo inner join  cobis..cl_tabla  on cobis..cl_tabla.codigo =  cobis..cl_catalogo.tabla
--where cobis..cl_tabla.tabla = 'sv_procesos_servicios'
--where cobis..cl_tabla.tabla = 'sv_emp_grupotvcable'
--where cobis..cl_tabla.tabla = 'sv_tvcable_online'
where valor = 'GRUPO TVCABLE'

tabla  codigo     valor                                                            estado codigo tabla                          descripcion                                                      
------ ---------- ---------------------------------------------------------------- ------ ------ ------------------------------ ---------------------------------------------------------------- 
960    4995       GRUPO TVCABLE                                                    V      960    sv_empresas_luz                Tabla de empresas para cobros de luz                             
1044   4995       GRUPO TVCABLE                                                    V      1044   sv_empresas_servicios          CODIGO DE EMPRESAS DE PAGOS SERVICIOS                            
25296  6          GRUPO TVCABLE                                                    V      25296  sv_recaudaciones               Tipo de Recaudaciones Caja                                       
25311  9          GRUPO TVCABLE                                                    V      25311  re_servicio_comision           servicios cobro de comision                                      
