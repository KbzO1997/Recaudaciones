/************************************************************************/
/* Nombre script:        cckb0096.sql                                   */
/* Realizado por:        Kevin Bastidas          		                */
/* Autorizado por:       Kevin Bastidas                                 */
/* Fecha:                01/03/2024                                     */
/* Proposito:            ACTUALIZACION CLIENTES DBA CNEL LosRios        */
/* Tarea Jira:       	 RECMPS-3103                                    */
/************************************************************************/

use cob_pagos
go

print "Inicio Script..."

update cob_pagos..pg_dbautomatico_servicio
set sd_codigo = '10' + RIGHT('0000000000' + CONVERT(VARCHAR, sd_codigo), 8)
where sd_empresa = 4981
  
print "Fin Script..."
go