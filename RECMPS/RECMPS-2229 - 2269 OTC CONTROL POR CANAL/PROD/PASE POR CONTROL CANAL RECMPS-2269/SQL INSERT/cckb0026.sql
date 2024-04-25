/**************************************************************************/
/* Archivo:            cckb0026.sql		                                  */
/* Objeto:             OTC_D_SERVICIO_CANAL                               */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 13/04/2023                                         */
/* Descripcion:        Script para insertar los convenios por cada canal  */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA        AUTOR          RAZON                          */
/*  13/04/2023  RECMPS-2229 Kevin Bastidas  CORRECCION DE NOVEDADES       */
/*                                          SONAR-CONTROL POR CANAL       */     
/**************************************************************************/
set serveroutput on;

BEGIN

insert into DB_OTC.OTC_M_CANAL (CAN_ID, CAN_NOMBRE, CAN_CODIGO, CAN_DESCRIPCION, CTD_ID_MEDIO_ACC) values (3,'WAP','WAP','C',5);
insert into DB_OTC.OTC_M_CANAL (CAN_ID, CAN_NOMBRE, CAN_CODIGO, CAN_DESCRIPCION, CTD_ID_MEDIO_ACC) values (4,'SAT','SAT','C',5);
insert into DB_OTC.OTC_M_CANAL (CAN_ID, CAN_NOMBRE, CAN_CODIGO, CAN_DESCRIPCION, CTD_ID_MEDIO_ACC) values (5,'VEN','VEN','C',5);


insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,1,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,1,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,1,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,2,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,2,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,3,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,3,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,4,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,4,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,5,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,5,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,6,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,6,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,8,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,8,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,9,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,9,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,9,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,10,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,10,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,10,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,18,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,18,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,19,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,19,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,20,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,20,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,21,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,21,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,22,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,22,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,23,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,23,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,24,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,24,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,25,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,25,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,26,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,26,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,27,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,27,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,28,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,28,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,29,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,29,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,30,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,30,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,31,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,31,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,32,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,32,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,33,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,33,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,34,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,34,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,35,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,35,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,36,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,36,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,37,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,37,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,38,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,38,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,39,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,39,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,50,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,50,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,50,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,182,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,182,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,183,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,183,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,187,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,187,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,190,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,190,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,190,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,191,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,191,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,192,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,192,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,192,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,193,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,193,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,194,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,194,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,195,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,195,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,196,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,196,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,197,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,197,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,198,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,198,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,201,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,201,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,201,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,202,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,202,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,202,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,203,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,203,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,203,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,204,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,204,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,204,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,205,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,205,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,206,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,206,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,206,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,207,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,207,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,207,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,208,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,208,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,208,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,210,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,210,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,211,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,211,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,212,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,212,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,212,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,213,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,213,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,213,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,214,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,214,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,214,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,215,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,215,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,215,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,217,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,217,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,217,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,218,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,218,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,218,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,219,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,219,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,219,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,220,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,220,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,220,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,221,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,221,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,221,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,222,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,222,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,222,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,223,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,223,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,223,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,224,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,224,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,224,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,226,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,226,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,226,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,227,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,227,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,227,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,228,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,228,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,228,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,229,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,229,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,229,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,230,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,230,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,230,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,231,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,231,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,231,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,232,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,232,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,232,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,233,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,233,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,233,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,234,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,234,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,234,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,235,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,235,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,235,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,236,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,236,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,236,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,237,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,237,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,237,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,238,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,238,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,238,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,239,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,239,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,239,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,240,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,240,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,240,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,241,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,241,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,241,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,242,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,242,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,242,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,243,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,243,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,243,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,244,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,244,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,244,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,245,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,245,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,245,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,246,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,246,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,246,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,247,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,247,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,247,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,248,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,248,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,248,4);

COMMIT;

        
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_D_SERVICIO_CANAL WHERE  srv_id = 248;