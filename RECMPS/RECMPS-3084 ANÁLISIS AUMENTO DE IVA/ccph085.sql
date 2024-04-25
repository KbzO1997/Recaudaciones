/*************************************************************************/
/*            Archivo:  ccph085.sql                                      */
/*            Objeto:   cob_cuentas                                      */
/*            Base de datos: cob_cuentas		                 */
/*            Producto:      CUENTAS CORRIENTES		                 */
/*            Disenado por:  Pablo Holguin	                         */
/*            Fecha de escritura:  05/16/2017                            */
/*************************************************************************/
/*             PROPOSITO   						 */
/*Modificacion Rubros IVA,Tarifas y Comisiones del Person		 */
/*                                                                       */
/*                          MODIFICACIONES				 */
/*            FECHA            RATIONAL   AUTOR     RAZON		 */
/*16/May/2017  CTE-SD-SGC00028636   Pablo Holguin  Emision inicial 	 */
/*************************************************************************/

use cob_cuentas
go

print 'Comienza script modificacion IVA del 14 al 12'
go

update cobis..cl_parametro
set pa_float =0.12
where pa_nemonico='IVA'
and pa_producto ='CTE'
go

------------------- script 1 -------------------
------------------------------------------------

update cob_remesas..pe_costo
set co_val_medio=12,co_minimo=12,co_maximo=12
from
cob_remesas..pe_servicio_per c,
cob_remesas..pe_costo e
where e.co_servicio_per= c.sp_servicio_per
and c.sp_producto in (3,4,12)
and c.sp_rubro='IVA'
and c.sp_servicio_dis in (2,7,8,9,10,11,12,13,38,41,48,49,50,57,58,59,65,71,72,74,76,77,78,79,83,90,92,94,96,97,
98,99,103,105,106,107,108,109,110,111,119,120,121,123,124,126,128,129,130,131,132,133,134,136,137,138,139,
142,143,144  --adicionales
)


go

-----------------------------------------------
print 'Comienza script modificacion tarifas '
go
------------------script 2 --------------------

update cob_remesas..pe_costo
set
co_val_medio =ROUND((ROUND ((co_val_medio/1.14),2)*(1.12)),2),
    co_minimo=ROUND((ROUND ((co_minimo/1.14),2)*(1.12)),2),
    co_maximo=ROUND((ROUND ((co_minimo/1.14),2)*(1.12)),2)
from
cob_remesas..pe_servicio_dis a,
cob_remesas..pe_var_servicio b,
cob_remesas..pe_servicio_per c,
cob_remesas..pe_costo e,
cob_remesas..pe_pro_final f
where a.sd_servicio_dis=b.vs_servicio_dis
and b.vs_servicio_dis=c.sp_servicio_dis
and e.co_servicio_per= c.sp_servicio_per
and c.sp_rubro=b.vs_rubro
and c.sp_producto in (3,4,7,12)
and c.sp_rubro!='IVA'
and f.pf_mercado = c.sp_mercado
and f.pf_producto = c.sp_producto
and f.pf_moneda = c.sp_moneda
and f.pf_tipo = c.sp_tipo
and a.sd_servicio_dis in (2,7,8,9,10,11,12,13,38,41,48,49,50,57,58,59,61,62,65,71,
72,74,76,77,78,79,82,83,85,86,90,92,94,96,97,98,99,103,105,106,107,108,109,110,111,
119,120,121,123,124,126,128,
--129,130,131,132,133,134, --ya no estan
136,137,139,
--138,  	--ya no estan
142,143,144   	--adicionales
)
and pf_moneda in (1,17)
and pf_mercado  not in (9,10)

go

--------------------------------------------------------------
print 'Comienza script modificacion corrientes personalizados'
go
-------------------script 3 ----------------------------------

update cob_remesas..pe_val_contratado
set vc_valor_con=ROUND((ROUND ((vc_valor_con/1.14),2)*(1.12)),2)
        from  cob_remesas..pe_val_contratado a,
	      cob_remesas..pe_servicio_per,
	      cob_remesas..pe_var_servicio,
	      cob_remesas..pe_rango,
	      cob_cuentas..cc_ctacte r,
            cob_remesas..pe_servicio_dis
       where  sp_servicio_per = a.vc_servicio_per
	and sp_servicio_dis = sd_servicio_dis  --
	 and vc_codigo = cc_default
         and  sp_producto = 3
         and  vs_servicio_dis = sp_servicio_dis --
         and  vs_rubro = sp_rubro  --
         and  ra_tipo_rango = a.vc_tipo_rango
         and  ra_grupo_rango = a.vc_grupo_rango
         and  ra_rango = a.vc_rango
         and  convert(char(10),a.vc_fecha,101) in
              (select convert(char(10),max(b.vc_fecha),101)
                 from cob_remesas..pe_val_contratado b
                where b.vc_servicio_per = a.vc_servicio_per
                  and b.vc_categoria = a.vc_categoria
                  and b.vc_tipo_rango = a.vc_tipo_rango
                  and b.vc_grupo_rango = a.vc_grupo_rango
                  and b.vc_rango = a.vc_rango
                and b.vc_tipo_default = a.vc_tipo_default
                  and b.vc_rol = a.vc_rol
                  and b.vc_codigo = a.vc_codigo
                  and b.vc_producto = a.vc_producto
		  and b.vc_canal = isnull( a.vc_canal, null))
         and  a.vc_secuencial in
              (select max(c.vc_secuencial)
                 from cob_remesas..pe_val_contratado c
                where c.vc_servicio_per = a.vc_servicio_per
                  and c.vc_categoria = a.vc_categoria
                  and c.vc_tipo_rango = a.vc_tipo_rango
                  and c.vc_grupo_rango = a.vc_grupo_rango
                  and c.vc_rango = a.vc_rango
                  and c.vc_tipo_default = a.vc_tipo_default
                  and c.vc_rol = a.vc_rol
                  and c.vc_codigo = a.vc_codigo
                  and c.vc_producto = a.vc_producto
		  and c.vc_canal = isnull( a.vc_canal, null))
--and sp_servicio_dis in (2,7,8,9,10,11,12,13,38,57,58,59,65,79,82,92,98,107,124
and sp_servicio_dis in (7,9,57,58,65,76,79,98,107,110,111,119,124,142
)

and vc_valor_con>0

go
---------------Script AHORROS PERSONALIZADOS 4 ----------------------------
print 'Comienza script modificacion ahorros personalizados'
go
---------------------------------------------------------------------------

update cob_remesas..pe_val_contratado
set vc_valor_con=ROUND((ROUND ((vc_valor_con/1.14),2)*(1.12)),2)
  from  cob_remesas..pe_val_contratado a,
	cob_remesas..pe_servicio_per,
	cob_remesas..pe_var_servicio,
	cob_remesas..pe_rango,
	cob_ahorros..ah_cuenta r,
	cob_remesas..pe_servicio_dis
       where  sp_servicio_per = a.vc_servicio_per
	 and sp_servicio_dis = sd_servicio_dis
	 and vc_codigo = ah_default
         and  sp_producto = 4
         and  vs_servicio_dis = sp_servicio_dis
         and  vs_rubro = sp_rubro
         and  ra_tipo_rango = a.vc_tipo_rango
         and  ra_grupo_rango = a.vc_grupo_rango
         and  ra_rango = a.vc_rango
         and  convert(char(10),a.vc_fecha,101) in
              (select convert(char(10),max(b.vc_fecha),101)
                 from cob_remesas..pe_val_contratado b
                where b.vc_servicio_per = a.vc_servicio_per
                  and b.vc_categoria = a.vc_categoria
                  and b.vc_tipo_rango = a.vc_tipo_rango
                  and b.vc_grupo_rango = a.vc_grupo_rango
                  and b.vc_rango = a.vc_rango
                and b.vc_tipo_default = a.vc_tipo_default
                  and b.vc_rol = a.vc_rol
                  and b.vc_codigo = a.vc_codigo
                  and b.vc_producto = a.vc_producto
		  and b.vc_canal = isnull( a.vc_canal, null))
         and  a.vc_secuencial in
              (select max(c.vc_secuencial)
                 from cob_remesas..pe_val_contratado c
                where c.vc_servicio_per = a.vc_servicio_per
                  and c.vc_categoria = a.vc_categoria
                  and c.vc_tipo_rango = a.vc_tipo_rango
                  and c.vc_grupo_rango = a.vc_grupo_rango
                  and c.vc_rango = a.vc_rango
                  and c.vc_tipo_default = a.vc_tipo_default
                  and c.vc_rol = a.vc_rol
                  and c.vc_codigo = a.vc_codigo
                  and c.vc_producto = a.vc_producto
		  and c.vc_canal = isnull( a.vc_canal, null))
--and sp_servicio_dis in (2,7,8,9,10,11,12,13,38,57,58,59,65,79,82,92,98,107,124
and sp_servicio_dis in(38,57,58,65,98)
and vc_valor_con>0
go

print 'eliminar codigos oficinas daminificadas en catalogo'
go

delete  cobis..cl_catalogo where tabla in (select codigo from cobis..cl_tabla where tabla='cl_of_damnificados')
go

print 'Elimina tabla pg_p_rubro_ser_dam'
truncate table cob_pagos..pg_p_rubro_ser_dam
go

