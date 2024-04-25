/****************************************************************************/
/* Nombre script:        cckb0099.sql									    */
/* Realizado por:        Kevin Bastidas 								    */
/* Autorizado por:       Dario Barco                                        */
/* Fecha:                14/Marz/2024                                      	*/
/* Proposito:            Script de Aumento IVA              				*/
/* Tarea Jira:           RECM-880                                            */
/****************************************************************************/

use cob_pagos
go

print "Inicio Script..."

update cob_pagos..pg_person_empresa set
pe_porc_impiva = 0.15
WHERE pe_porc_impiva = 0.12

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)
VALUES (26862, '0.15', '15%', 'V')

update cob_pagos..pg_costo_com_canal
set 
pg_costo = ROUND((ROUND ((pg_costo/1.12),2)*(1.15)),2)

update cob_pagos..pg_person_empresa
set 
pe_costo = ROUND((ROUND ((pe_costo/1.12),2)*(1.15)),2)
where pe_empresa in(120,783,1372,1373,5488,8090,8688)

print "Fin Script..."
go
