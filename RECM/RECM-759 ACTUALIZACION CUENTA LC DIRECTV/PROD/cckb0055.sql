/************************************************************************/
/*   Archivo:  cckb0055.sql                                             */
/*   Motor de Base: 		SYBASE                     					*/
/*   Servidor: 			HP-ACT                                          */
/*   Objeto: pg_control_ncrecaudacion           		                */
/*   Base de datos:  cob_pagos                                          */
/*   Producto: Diario Operaciones                                       */
/*   Disenado por:  Kevin Bastidas                                   	*/
/*   Fecha de escritura:  07/08/2023                                    */
/************************************************************************/
/*                            PROPOSITO                                 */
/*Actualizar numero de cuenta de los pagos LC Fecha 1,2,3   		    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  REF FECHA           AUTOR        RAZON         Tarea			    */
/*   1  07/08/2023  Kevin Bastidas	RECM-759 ACTUALIZACION CUENTA L/C DIRECTV*/
/************************************************************************/


use cob_pagos
go

print 'Inicia Srcipt'
print 'Update Ini'

go

    update cob_pagos..pg_control_ncrecaudacion 
    set pn_cta_banco = '0005341494'
    where pn_empresa = 5488 and pn_fecha_rec in ('08/01/2023','08/02/2023','08/03/2023') and pn_estado = 'N'
go
    update cob_pagos..pg_control_ncrecaudacion 
    set pn_cta_banco = '0005341494'
    where pn_empresa = 120 and pn_fecha_rec in ('08/01/2023','08/02/2023','08/03/2023')	and pn_estado = 'N'

go

print 'Update OK'
go


print 'Fin Script'
go
