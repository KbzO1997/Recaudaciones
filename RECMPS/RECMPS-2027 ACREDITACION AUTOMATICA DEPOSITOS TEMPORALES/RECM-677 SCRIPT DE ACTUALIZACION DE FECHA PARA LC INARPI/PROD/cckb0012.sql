/************************************************************************/
/*   Archivo:  cckb0012.sql                                             */
/*   Motor de Base: 		SYBASE                     					*/
/*    Servidor: 			HP-ACT                                      */
/*   Objeto: pg_control_ncrecaudacion           		                */
/*   Base de datos:  cob_pagos                                        	*/
/*   Producto: Recaudaciones	                                       	*/
/*   Disenado por:  Kevin Bastidas                                   	*/
/*   Fecha de escritura:  01/20/2023                                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA     TAREA             AUTOR      RAZON             			*/
/*01/20/2023  RECM-677 		Kevin Bastidas  SCRIPT DE ACTUALIZACION DE FECHA EFECTIVA EN LC */
/**************************************************************************/


use cob_pagos
go

print 'Inicia Srcipt'
print 'ACTUALIZACION DE FECHA EFECTIVA EN LC'

go
	begin
		update cob_pagos..pg_control_ncrecaudacion
            set pn_fecha_efec = '01/18/2023'                
            FROM cob_pagos..pg_control_ncrecaudacion
            WHERE pn_empresa    = 8976
            and pn_sec = 255213821
            and pn_estado = 'P'
            and pn_fecha_rec = '01/18/2023'
	end
go

print 'Update OK'
go


print 'Fin Script'
go
