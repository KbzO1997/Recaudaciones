/********************************************************************************/
/*  Archivo:       	 ccgyiva01.sql                  	       		*/
/*  Motor de Base:       SYBASE				       	       		*/
/*  Base de datos:	 cob_remesas				       		*/
/*  Servidor:		 HP-ACT					       		*/
/*  Aplicacion:	         Person					       		*/
/*  Script:              ccgyiva01       		       			*/
/*  Procesamiento:	 BATCH					       		*/
/*  Dise?ado por:        Galo Yanez C.             		       		*/
/*  Fecha de escritura:  13/Mar/2024				       		*/
/*  Ult.ControlTarea:    R-PER-SD-SGC00048891  	 			       	*/
/*  Ult.Referencia:      REF 1				               		*/
/********************************************************************************/
/*  			PROPOSITO                                    		*/
/*  Script para modificar tarifa IVA en Person de 12% a 15%			*/
/*  a los servicios indicados por E&P						*/
/*  			MODIFICACIONES                                       	*/
/*  FECHA            RATIONAL   	    AUTOR       RAZON       		*/
/*  Mar 13/2024     PER-SD-SGC00048891    Galo Yanez	Emision inicial		*/ 
/********************************************************************************/

use cob_remesas
go

select getdate()
go

----------------------------------------------------------
-------------------   PARA IVA  15%    -------------------
----------------------------------------------------------

print 'Comienza script modificacion IVA del 12 al 15'
go

-- Parametro general de IVA 

select * from cobis..cl_parametro
--set pa_float = 0.15		-- antes 0.12
where pa_nemonico = 'IVA'
  and pa_producto = 'CTE'
go

----------------------------------------------------------
------------------- PARA SERVICIOS IVA -------------------
----------------------------------------------------------

-----------------------------------------------------
print 'Comienza script modificacion tarifas = IVA'
go
-----------------------------------------------------

select * 
from cob_remesas..pe_servicio_per c,
	cob_remesas..pe_costo e
where e.co_servicio_per = c.sp_servicio_per
  and c.sp_producto in (3,4,12)
  and c.sp_rubro = 'IVA'
  and c.sp_servicio_dis in (2,7,8,9,10,11,12,13,38,41,48,49,50,57,58,59,65,71,72,74,76,77,78,79,83,90,92,94,96,97,
			    98,99,103,105,106,107,108,109,110,111,119,120,121,123,124,126,128,129,130,131,132,133,
			    134,136,137,138,139,142,143,144,145,147,156,158)
go



----------------------------------------------------------
------------- PARA SERVICIOS DIFERENTES DE IVA -----------
----------------------------------------------------------

----------------------------------------------------
print 'Comienza script modificacion tarifas <> IVA'
go
----------------------------------------------------

select * --from cob_remesas..pe_costo
-- set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis in (9,59,65,71,72,74,76,77,78,79,82,83,85,86,90,92,94,96,97,99,103,105,106,108,109,
  			    110,111,119,120,121,123,124,126,128,135,136,137,138,141,144)
go

-- Considerar los registros por los servicios personalizados (sp_servicio_per) no a todos ...

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 2		-- SOLICITUD DE CHEQUERA
  and c.sp_servicio_per in (77,78,79,80,81,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,438,439)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 7		-- CHEQUES DEVUELTOS
  and c.sp_servicio_per in (133,134,324,325,342,343,344,345,378,379,405,406,583,584,590,591,933,1127,1171,1176,1195,1275,1280,1297,2071)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select * 
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 8		-- REVOCATORIA DE CHEQUES
  and c.sp_servicio_per in (157,159)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select * 
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 10		-- SOLICITUD DE ESTADO DE CUENTA
  and c.sp_servicio_per in (125,126,571,572,949,1141,1191,1294,2072)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select * 
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 11		-- ANULACION DE CHEQUE
  and c.sp_servicio_per in (141,142,347,349,351,353)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select * 
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 12		-- PROTESTO DE CHEQUE
  and c.sp_servicio_per in (515,516,2009,2010)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 13		-- EMISION ESTADO DE CUENTA
  and c.sp_servicio_per in (508,758,759,760,761,794)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 38		-- EMISION DE TARJETA
  and c.sp_servicio_per in (468,469,487,488,538,539,1181,1182,1285,1286,2076)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 41		-- REPOSICION DE LA TARJETA
  and c.sp_servicio_per in (473,491,492,494,540,541,1185,1186,1289,1290,2078)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 48		-- TRANSACCIONES DE CAJERO
  and c.sp_servicio_per in (474,475,476,477,478,483,484,485,486,493,542,543,544,545,546,803,805,820,821,1011,1012,1013,1014,1015,1177,
 			    1178,1179,1180,1187,1281,1282,1283,1284,1291,1943,2080,2081,2082,2083,2084)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 50		-- ASIGNACION LIBRETAS DE AHORROS
  and c.sp_servicio_per in (332,333,1173,1277)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 53		-- INTERNET PAGO DE SERVICIOS
  and c.sp_servicio_per in (551,553,556,557,558,559)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 57		-- INTERBANCARIO BCE
  and c.sp_servicio_per in (596,597,599,600,1196,1298,2087)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 58		-- INTERBANCARIO COMEX BCE
  and c.sp_servicio_per in (620,622,624,625,1198,1300)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 60		-- ENVIO ESTADO CUENTA FAX
  and c.sp_servicio_per in (638,640,641)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 61		-- CASILLERO DE SEGURIDAD
  and c.sp_servicio_per in (642,643,644,646,647,648,652,653,654,656,657,658,1201,1202,1203,1303,1304,1305) 
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 98		-- TRANSFERENCIAS ENVIADAS
  and c.sp_servicio_per in (848,849,850,851,852,853,855,856,857,859,860,861,862,863,864,866,867,868,869,871,872,873,874,875,876,878,879,919,920,921,936,937,
 			    938,939,940,1130,1131,1132,1133,1134,1230,1231,1232,1233,1234,1333,1334,1335,1336,1337,1478,1479,1480,1481,1482,1483,1484,1485,
 			    1508,1509,1510,1511,1512,1513,1514,1516,1998,1999,2000,2001,2002,2003,2005,2006,2433)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 104		-- COBRO COMISION IMPUEST ARANCEL
  and c.sp_servicio_per in (986,988,989,1244,1346)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 107		-- COMISION DE IMPUESTOS ARANCELA
  and c.sp_servicio_per in (1018,1019,1020,1021,1143,1144,1145,1146,1250,1268,1352,1371)
go

--update cob_remesas..pe_costo
--set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
--    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
--    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 139		-- DECLARAR SIN EFECTO CHEQUE
  and c.sp_servicio_per in (1968,1970)
go

-- Considerar los registros por los servicios personalizados (sp_servicio_per) , quemar valor porque con calculo se pasa del valor maximo

--update cob_remesas..pe_costo
--set co_val_medio = 0.90,
--    co_minimo    = 0.90,
--    co_maximo    = 0.90
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 49		-- RENOVACION DE TARJETA
  and c.sp_servicio_per in (470,472,489,490,1183,1184,1287,1288)
go

--update cob_remesas..pe_costo
--set co_val_medio = 0.00,
--    co_minimo    = 0.00,
--    co_maximo    = 0.00
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     = 4	
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 49		-- RENOVACION DE TARJETA
  and c.sp_servicio_per in (470,472,489,490,1183,1184,1287,1288)
  and e.co_categoria in ('U','F')
go

--update cob_remesas..pe_costo
--set co_val_medio = 0.00,
--    co_minimo    = 0.00,
--    co_maximo    = 0.00
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     = 12
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 49		-- RENOVACION DE TARJETA
  and c.sp_servicio_per in (470,472,489,490,1183,1184,1287,1288)
  and e.co_categoria in ('N','R')
go

--update cob_remesas..pe_costo
--set co_val_medio = 30.80,
--    co_minimo    = 30.80,
--    co_maximo    = 30.80
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 61		-- CASILLERO DE SEGURIDAD
  and c.sp_servicio_per in (645,649,655,659,1204,1306)
go

--update cob_remesas..pe_costo
--set co_val_medio = 1.96,
--    co_minimo    = 1.96,
--    co_maximo    = 1.96
select *
from cob_remesas..pe_servicio_dis a,
     cob_remesas..pe_var_servicio b,
     cob_remesas..pe_servicio_per c,
     cob_remesas..pe_costo e,
     cob_remesas..pe_pro_final f
where a.sd_servicio_dis = b.vs_servicio_dis
  and b.vs_servicio_dis = c.sp_servicio_dis
  and e.co_servicio_per = c.sp_servicio_per
  and c.sp_rubro        = b.vs_rubro
  and c.sp_producto     in (3,4,7,12)
  and c.sp_rubro        <> 'IVA'
  and f.pf_mercado      = c.sp_mercado
  and f.pf_producto     = c.sp_producto
  and f.pf_moneda       = c.sp_moneda
  and f.pf_tipo         = c.sp_tipo
  and a.sd_servicio_dis = 147
go

----------------------------------------------------------
------------- PARA CUENTAS PERSONALIZADAS	----------
----------------------------------------------------------

--------------------------------------------------------------
print 'Comienza script modificacion corrientes personalizados'
go
--------------------------------------------------------------

--update cob_remesas..pe_val_contratado
--set vc_valor_con = ROUND((ROUND ((vc_valor_con/1.12),2)*(1.15)),2)
select *
        from  cob_remesas..pe_val_contratado a,
	      cob_remesas..pe_servicio_per,
	      cob_remesas..pe_var_servicio,
	      cob_remesas..pe_rango,
	      cob_cuentas..cc_ctacte r,
	      cob_remesas..pe_servicio_dis
       where  sp_servicio_per = a.vc_servicio_per
	 and sp_servicio_dis = sd_servicio_dis
	 and vc_codigo = cc_default
         and  sp_producto = 3
         and  vs_servicio_dis = sp_servicio_dis
         and  vs_rubro = sp_rubro
         and  ra_tipo_rango = a.vc_tipo_rango
         and  ra_grupo_rango = a.vc_grupo_rango
         and  ra_rango = a.vc_rango
         and  r.cc_estado in ('A','I')
         and  convert(char(10),a.vc_fecha,101) in
              (select convert(char(10),max(b.vc_fecha),101)
                 from pe_val_contratado b
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
	and vc_valor_con > 0
	and vs_servicio_dis in (7,9,57,58,65,76,77,79,110,111,119,123,124)	-- no considerar 98
go


--update cob_remesas..pe_val_contratado
--set vc_valor_con = ROUND((ROUND ((vc_valor_con/1.12),2)*(1.15)),2)
select *
        from  cob_remesas..pe_val_contratado a,
	      cob_remesas..pe_servicio_per,
	      cob_remesas..pe_var_servicio,
	      cob_remesas..pe_rango,
	      cob_cuentas..cc_ctacte r,
	      cob_remesas..pe_servicio_dis
       where  sp_servicio_per = a.vc_servicio_per
	 and sp_servicio_dis = sd_servicio_dis
	 and vc_codigo = cc_default
         and  sp_producto = 3
         and  vs_servicio_dis = sp_servicio_dis
         and  vs_rubro = sp_rubro
         and  ra_tipo_rango = a.vc_tipo_rango
         and  ra_grupo_rango = a.vc_grupo_rango
         and  ra_rango = a.vc_rango
         and  r.cc_estado in ('A','I')
         and  convert(char(10),a.vc_fecha,101) in
              (select convert(char(10),max(b.vc_fecha),101)
                 from pe_val_contratado b
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
	and vc_valor_con > 0
	and vs_servicio_dis = 98
	and sp_rubro <> 'TOUR'
go

---------------------------------------------------------------------------
print 'Comienza script modificacion ahorros personalizados'
go
---------------------------------------------------------------------------

--update cob_remesas..pe_val_contratado
--set vc_valor_con=ROUND((ROUND ((vc_valor_con/1.12),2)*(1.15)),2)
select *
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
                 from pe_val_contratado b
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
	and vc_valor_con > 0
	and vs_servicio_dis = 98 
	and sp_rubro <> 'TOUR'
go

print 'Fin de script ............  OK'
go

select getdate()
go


