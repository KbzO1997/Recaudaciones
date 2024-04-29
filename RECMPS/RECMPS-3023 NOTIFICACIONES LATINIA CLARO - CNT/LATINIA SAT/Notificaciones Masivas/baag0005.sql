/*************************************************************************************/
/*      Archivo:                baag0005.sql                                         */
/*      Base de datos:          cob_internet                                         */
/*      Producto:               Servicios                                            */
/*      Disenado por:           Joffre Pita         .                                */
/*      Fecha de escritura:     04.Jul.2022                                          */
/*************************************************************************************/
/*                              IMPORTANTE                                           */
/*      Este programa es parte de los paquetes bancarios propiedad de                */
/*      "BANCO BOLIVARIANO C.A."                                                     */
/*      Su uso no autorizado queda expresamente prohibido asi como                   */
/*      cualquier alteracion o agregado hecho por alguno de sus                      */
/*      usuarios sin el debido consentimiento por escrito de la                      */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.               */
/*************************************************************************************/
/*                               PROPOSITO                                           */
/*      PoblaciÃ³n de nueva tabla cob_internet..sms_det_procesos                     */
/*************************************************************************************/
/*                            MODIFICACIONES                                         */
/*   FECHA          AUTOR                    RAZON                                   */
/* 04/07/2022       Joffre Pita       SAT-8086 Notificación ADPDS de intentos fallidos                  */
/*                                    al momento de ingresar mal la respuesta de pregunta de seguridad  */
/* 09/01/2023       Paola Gordillo    SAT-8859 Notificación EOSAT al usuario por eliminación de órdenes */
/* 08/02/2023       Paola Gordillo    SAT-9030 Notificación de Bloqueo de Usuario al usuario SAT        */ 
/*************************************************************************************/
use cob_internet
go

if exists(select 1 from cob_internet..sms_det_procesos where dp_proceso = 'BUSAT')
begin
    delete from cob_internet..sms_det_procesos where dp_proceso = 'BUSAT'
    if exists(select 1 from cob_internet..sms_det_procesos where dp_proceso = 'BUSAT')
       PRINT '<<< Delete cob_internet..sms_det_procesos Nemonico BUSAT -- ERROR -- >>>'
    else
       PRINT '== Delete cob_internet..sms_det_procesos Nemonico BUSAT *OK* =='
end 
go

insert into cob_internet..sms_det_procesos values('BUSAT','I',1,'NOMBRE_SAT',64,'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@','S','nombre_sat') --cliente
insert into cob_internet..sms_det_procesos values('BUSAT','I',2,'LOGIN',11,'@@@@@@@@@@@','S','login') -- cedula user
insert into cob_internet..sms_det_procesos values('BUSAT','I',3,'DESCCANAL',16,'@@@@@@@@@@@@@@@@','S','desccanal') -- canal
insert into cob_internet..sms_det_procesos values('BUSAT','I',4,'FECHA_TOPE',10,'&&&&&&&&&&','S','fecha_tope') -- fecha
insert into cob_internet..sms_det_procesos values('BUSAT','I',5,'FECHA1',11,'@@@@@@@@@@@','S','fecha1') -- fecha (hora)


insert into cob_internet..sms_det_procesos values('BUSAT','T',1,'NOMBRE_SAT',64,'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@','S','i_nombre') --cliente
insert into cob_internet..sms_det_procesos values('BUSAT','T',2,'LOGIN',11,'@@@@@@@@@@@','S','i_minimo') -- cedula user
insert into cob_internet..sms_det_procesos values('BUSAT','T',3,'DESCCANAL',64,'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@','S','i_planilla') -- canal
insert into cob_internet..sms_det_procesos values('BUSAT','T',4,'FECHA_TOPE',10,'&&&&&&&&&&','S','i_fecha_tope') -- fecha
insert into cob_internet..sms_det_procesos values('BUSAT','T',5,'FECHA1',11,'@@@@@@@@@@@','S','i_valor1') -- fecha(hora) 

if exists(select 1 from cob_internet..sms_det_procesos where dp_proceso = 'BUSAT')
   PRINT '== Insert cob_internet..sms_det_procesos Nemonico BUSAT *OK* =='
else
   PRINT '<<< Insert cob_internet..sms_det_procesos Nemonico BUSAT -- ERROR -- >>>'
go
