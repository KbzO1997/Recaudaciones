/**************************************************************************/
/* Archivo:            ccjg0001.sql		                                  */
/* Objeto:             OTC_M_CONVENIO, OTC_M_FLUJO,OTC_D_FLUJO_SERV_ENRIQ,*/
/*					   OTC_M_TIPO_IDENTIFICADOR, OTC_M_EMPRESA		      */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Jonathan Guerrero                                  */
/* Fecha de escritura: 07/27/2020                                         */
/* Descripcion:        Script para agregar a la empresa Pycca al menu de  */
/*                     tarjetas comerciales de la banca en linea BB.      */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*07/27/2020   RECMPS-222		Jonathan Guerrero       Emision inicial   */
/**************************************************************************/

DELETE from DB_OTC.OTC_M_TIPO_IDENTIFICADOR
where tid_id in (314);

DELETE from DB_OTC.OTC_D_SERVICIO_CANAL
where sc_id = 89;

DELETE from DB_OTC.OTC_D_SERVICIO
where srv_id = 835;

DELETE from DB_OTC.OTC_M_GRUPO_SERVICIO
where grp_id = 634;

DELETE from DB_OTC.OTC_D_FLUJO_SERV_ENRIQ
where FSE_ID in ('337','338','339');

DELETE from DB_OTC.OTC_M_FLUJO
where flu_id in (871, 872, 873);

DELETE from DB_OTC.OTC_M_CONVENIO
where cnv_id = 306;

DELETE from DB_OTC.OTC_M_PUNTO_FINAL
where end_id in (155, 156, 157);

DELETE from DB_OTC.OTC_M_EMPRESA 
where emp_id in(415);

DELETE from DB_OTC.OTC_M_TIPO_IDENTIFICADOR
where tid_id in (314);

commit;

--1: EMPRESAS--
INSERT INTO DB_OTC.OTC_M_EMPRESA VALUES (415,'0990000530001','PYCCA S.A.', '8460', 'PYCCA S.A.');

--2: GRUPO SERVICIO--
insert into DB_OTC.OTC_M_GRUPO_SERVICIO values (634, 415, 1, 20,1,1,0,0);

--3: CONVENIOS--
insert into DB_OTC.OTC_M_CONVENIO values (306, 8460, 1, 'PYCCA');

--4: SERVICIOS--
insert into DB_OTC.OTC_D_SERVICIO values (835, 'Pycca',634 , 306);

--5:SERVICIO CANAL--
insert into DB_OTC.OTC_D_SERVICIO_CANAL  values (89,835,1);

--6:TIPO IDENTIFICADOR--
insert into DB_OTC.OTC_M_TIPO_IDENTIFICADOR values (314,'1',null,null,1,'^([A-Z0-9]){1,20}$',null,306,'Ingrese identificación','Identificación',1);


--7:ENDPOINT--
insert into DB_OTC.OTC_M_PUNTO_FINAL values (155, 'Pycca CONSULTA', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'consulta','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PYCCA_C_IN.xsl','PYCCA_C_OUT.xsl');
insert into DB_OTC.OTC_M_PUNTO_FINAL values (156, 'Pycca PAGO', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'pago','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PYCCA_P_IN.xsl','PYCCA_P_OUT.xsl');
insert into DB_OTC.OTC_M_PUNTO_FINAL values (157, 'Pycca REVERSO', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'reverso','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PYCCA_R_IN.xsl','PYCCA_R_OUT.xsl');

--8:FLUJO--
INSERT INTO DB_OTC.OTC_M_FLUJO VALUES (871,155,306,22);
INSERT INTO DB_OTC.OTC_M_FLUJO VALUES (872,156,306,6);
INSERT INTO DB_OTC.OTC_M_FLUJO VALUES (873,157,306,23);

--9:FLUJO SERVICIO--
INSERT INTO DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('337', '1', '871');
INSERT INTO DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('338', '1', '872');
INSERT INTO DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('339', '1', '873');


COMMIT;




