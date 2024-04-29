/************************************************************************/
/* Nombre script:        cckb0061.sql                                   */
/* Realizado por:        Kevin Bastidas          		                */
/* Autorizado por:       Kevin Bastidas                                 */
/* Fecha:                31/Octubre/2023                                */
/* Proposito:            ACTUALIZACION CLIENTES DBA CNEL EL ORO         */
/* Tarea Jira:       	 RECM-795                                		*/
/************************************************************************/

use cob_pagos
go

print "Inicio Script..."

update cob_pagos..pg_dbautomatico_servicio
set sd_codigo = '12' + RIGHT('0000000000' + CONVERT(VARCHAR, sd_codigo), 8)
where sd_empresa = 1330
  
print "Fin Script..."
go







