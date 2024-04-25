/********************************************************************************/
/*  Archivo:       	 ccmliva02.sql                  	       		*/
/*  Motor de Base:       SYBASE				       	       		*/
/*  Base de datos:	 cob_remesas				       		*/
/*  Servidor:		 HP-ACT					       		*/
/*  Aplicacion:	         Person					       		*/
/*  Script:              ccmliva02       		       			*/
/*  Procesamiento:	 BATCH					       		*/
/*  Diseñado por:        Miriam Lindao             		       		*/
/*  Fecha de escritura:  19/Mar/2024				       		*/
/*  Ult.ControlTarea:    R-PER-SD-SGC00012345  	 			       	*/
/*  Ult.Referencia:      REF 1				               		*/
/********************************************************************************/
/*  			PROPOSITO                                    		*/
/*  Script para modificar tarifa IVA en Person de 12% a 15%			*/
/*  a los servicios indicados por E&P						*/
/*  			MODIFICACIONES                                       	*/
/*  FECHA            RATIONAL   	    AUTOR       RAZON       		*/
/*  Mar 19/2024     PER-SD-SGC00048936    Miriam Lindao Emision inicial     */ 
/********************************************************************************/

use cob_remesas
go

select getdate()
go


----------------------------------------------------------
------------- PARA SERVICIOS DIFERENTES DE IVA -----------
----------------------------------------------------------

----------------------------------------------------
print 'Comienza script modificacion tarifas <> IVA' -- alcance a script original
go
----------------------------------------------------

update cob_remesas..pe_costo
set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
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
  and c.sp_servicio_per in (158,160)
go

update cob_remesas..pe_costo
set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
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
  and c.sp_servicio_per in (355,357)
go

update cob_remesas..pe_costo
set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
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
  and a.sd_servicio_dis = 67		-- 
  and c.sp_servicio_per in (686,687,951,1211,1313)
go

update cob_remesas..pe_costo
set co_val_medio = ROUND((ROUND ((co_val_medio/1.12),2)*(1.15)),2),
    co_minimo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2),
    co_maximo    = ROUND((ROUND ((co_minimo/1.12),2)*(1.15)),2)
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
  and c.sp_servicio_per in (1969,1971)
go

print 'Fin de script ............  OK'
go

select getdate()
go


