/************************************************************************/
/* Nombre script:        cckb0085.sql                                   */
/* Realizado por:        Kevin Bastidas          		                */
/* Autorizado por:       Kevin Bastidas                                 */
/* Fecha:                21/02/2024                                     */
/* Proposito:            INSERTAR PLANTILLA DAPSB                       */
/* Tarea Jira:       	 RECMPS-3023                                    */
/************************************************************************/

use cob_internet
go

print "Inicio Script..."

insert into cob_internet..sms_det_procesos (dp_proceso, dp_tipo, dp_campo, dp_descripcion, dp_longitud, dp_formato, dp_parametro, dp_valor)
select 'DAPSB', dp_tipo, dp_campo, dp_descripcion, dp_longitud, dp_formato, dp_parametro, dp_valor from cob_internet..sms_det_procesos where dp_proceso = 'PAGSB'
  
print "Fin Script..."
go