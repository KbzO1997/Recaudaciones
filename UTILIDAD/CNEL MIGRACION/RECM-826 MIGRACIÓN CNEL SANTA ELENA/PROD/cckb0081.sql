/************************************************************************/
/* Nombre script:        cckb0081.sql                                   */
/* Realizado por:        Kevin Bastidas          		                */
/* Autorizado por:       Kevin Bastidas                                 */
/* Fecha:                01/03/2024                                     */
/* Proposito:            ACTUALIZACION CLIENTES DBA CNEL STelena        */
/* Tarea Jira:       	 RECM-836                                		*/
/************************************************************************/

use cob_pagos
go

print "Inicio Script..."

update cob_pagos..pg_dbautomatico_servicio
set sd_codigo = '16' + RIGHT('0000000000' + CONVERT(VARCHAR, sd_codigo), 8)
where sd_empresa = 825
  
print "Fin Script..."
go







