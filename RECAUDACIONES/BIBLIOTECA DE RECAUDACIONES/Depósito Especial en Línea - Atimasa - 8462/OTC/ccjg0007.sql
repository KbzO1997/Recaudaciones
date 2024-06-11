/**************************************************************************/
/* Archivo:            ccjg0007.sql		                                  */
/* Objeto:             OTC_M_CONVENIO, OTC_M_FLUJO,OTC_D_FLUJO_SERV_ENRIQ,*/
/*					   OTC_M_TIPO_IDENTIFICADOR, OTC_M_EMPRESA		      */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Jonathan Guerrero                                  */
/* Fecha de escritura: 10/22/2020                                         */
/* Descripcion:        Script para agregar a la empresa Atimasa al menu   */
/*                     tarjetas comerciales de la banca en linea BB.      */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*10/22/2020  RECMPS-405		Jonathan Guerrero    Emision inicial      */
/**************************************************************************/

DELETE from DB_OTC.OTC_M_TIPO_IDENTIFICADOR
where tid_id = 333;

DELETE from DB_OTC.OTC_D_SERVICIO_CANAL
where sc_id = 124;

DELETE from DB_OTC.OTC_D_SERVICIO
where srv_id = 873;

DELETE from DB_OTC.OTC_M_GRUPO_SERVICIO
where grp_id = 675;

DELETE from DB_OTC.OTC_D_FLUJO_SERV_ENRIQ
where fse_id in (385,386,387);

DELETE from DB_OTC.OTC_M_FLUJO
where flu_id in (922, 923, 924);

DELETE from DB_OTC.OTC_M_CONVENIO
where cnv_id = 325;

DELETE from DB_OTC.OTC_M_PUNTO_FINAL
where end_id in (158,159,160);

DELETE from DB_OTC.OTC_M_EMPRESA 
where emp_id = 418;

commit;

--1: EMPRESAS--

insert into DB_OTC.OTC_M_EMPRESA VALUES (418,'0991331859001','Primax Card Plus', '8462', 'Primax Card Plus');

--2: GRUPO SERVICIO--
insert into DB_OTC.OTC_M_GRUPO_SERVICIO values (675, 418, 1, 20,0,1,0,0);

--3: CONVENIOS--
insert into DB_OTC.OTC_M_CONVENIO values (325, 8462,  1, 'Primax Card Plus');

--4: SERVICIOS--
insert into DB_OTC.OTC_D_SERVICIO values (873, 'Primax Card Plus',675 , 325);

--5:SERVICIO CANAL--
insert into DB_OTC.OTC_D_SERVICIO_CANAL  values (124,873,1);

--6:TIPO IDENTIFICADOR--
insert into DB_OTC.OTC_M_TIPO_IDENTIFICADOR values (333,'1',null,null,1,'^([A-Z0-9]){1,20}$',null,325,'Ingrese código','Código',1);

--7:ENDPOINT NO APLICA--
insert into DB_OTC.OTC_M_PUNTO_FINAL values (158, 'Primax Card Plus CONSULTA', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'consulta','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PRIMAX_C_IN.xsl','PRIMAX_C_OUT.xsl');
insert into DB_OTC.OTC_M_PUNTO_FINAL values (159, 'Primax Card Plus PAGO', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'pago','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PRIMAX_P_IN.xsl','PRIMAX_P_OUT.xsl');
insert into DB_OTC.OTC_M_PUNTO_FINAL values (160, 'Primax Card Plus REVERSO', 'Recaudaciones/proxy/DepositoEnLineaLocal', 'reverso','/opt/microservices/transformaciones','/opt/microservices/transformaciones','PRIMAX_R_IN.xsl','PRIMAX_P_OUT.xsl');

--8:FLUJO-- 
insert into DB_OTC.OTC_M_FLUJO VALUES (922,158,325,22);
insert into DB_OTC.OTC_M_FLUJO VALUES (923,159,325,6);
insert into DB_OTC.OTC_M_FLUJO VALUES (924,160,325,23);

--9:FLUJO SERVICIO--
insert into DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('385', '1', '922');
insert into DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('386', '1', '923');
insert into DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID, ES_ID, FLU_ID) VALUES ('387', '1', '924');

COMMIT;


