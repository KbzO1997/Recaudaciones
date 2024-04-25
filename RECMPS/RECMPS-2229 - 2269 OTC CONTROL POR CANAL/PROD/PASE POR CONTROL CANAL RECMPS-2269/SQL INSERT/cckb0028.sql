/**************************************************************************/
/* Archivo:            cckb0028.sql		                                  */
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

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,500,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,500,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,500,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,501,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,501,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,501,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,502,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,502,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,502,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,503,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,503,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,503,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,504,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,504,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,504,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,505,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,505,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,505,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,506,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,506,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,506,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,507,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,507,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,507,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,508,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,508,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,508,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,509,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,509,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,509,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,510,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,510,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,510,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,511,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,511,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,511,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,512,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,512,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,512,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,513,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,513,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,513,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,514,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,514,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,514,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,515,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,515,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,515,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,516,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,516,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,516,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,517,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,517,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,517,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,518,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,518,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,518,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,519,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,519,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,519,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,520,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,520,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,520,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,521,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,521,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,521,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,522,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,522,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,522,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,523,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,523,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,523,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,524,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,524,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,524,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,525,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,525,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,525,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,526,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,526,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,526,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,527,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,527,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,527,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,528,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,528,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,528,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,529,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,529,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,529,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,530,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,530,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,530,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,531,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,531,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,531,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,532,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,532,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,532,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,533,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,533,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,533,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,534,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,534,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,534,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,535,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,535,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,535,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,536,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,536,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,536,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,537,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,537,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,537,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,538,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,538,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,538,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,539,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,539,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,539,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,540,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,540,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,540,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,541,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,541,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,541,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,542,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,542,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,542,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,543,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,543,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,543,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,544,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,544,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,544,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,545,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,545,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,545,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,548,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,548,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,548,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,549,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,549,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,549,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,550,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,550,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,550,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,551,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,551,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,551,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,552,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,552,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,552,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,553,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,553,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,553,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,554,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,554,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,554,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,555,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,555,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,555,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,556,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,556,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,556,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,557,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,557,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,557,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,558,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,558,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,558,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,559,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,559,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,559,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,560,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,560,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,560,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,561,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,561,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,561,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,562,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,562,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,562,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,563,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,563,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,563,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,564,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,564,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,564,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,565,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,565,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,565,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,568,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,568,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,568,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,569,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,569,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,569,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,570,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,570,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,570,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,571,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,571,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,571,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,572,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,572,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,572,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,573,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,573,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,573,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,574,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,574,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,574,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,575,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,575,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,575,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,576,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,576,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,576,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,577,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,577,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,577,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,578,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,578,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,578,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,579,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,579,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,579,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,580,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,580,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,580,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,581,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,581,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,581,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,582,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,582,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,582,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,583,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,583,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,583,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,584,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,584,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,584,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,585,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,585,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,585,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,586,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,586,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,586,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,587,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,587,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,587,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,588,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,588,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,588,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,589,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,589,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,589,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,590,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,590,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,590,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,591,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,591,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,591,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,592,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,592,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,592,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,593,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,593,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,593,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,594,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,594,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,594,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,595,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,595,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,595,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,596,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,596,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,596,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,597,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,597,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,597,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,598,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,598,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,598,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,599,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,599,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,599,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,600,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,600,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,600,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,601,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,601,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,601,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,602,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,602,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,602,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,603,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,603,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,603,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,604,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,604,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,604,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,605,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,605,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,605,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,608,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,608,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,608,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,609,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,609,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,609,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,610,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,610,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,610,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,611,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,611,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,611,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,612,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,612,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,612,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,613,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,613,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,613,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,614,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,614,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,614,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,615,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,615,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,615,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,616,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,616,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,616,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,617,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,617,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,617,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,618,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,618,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,618,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,619,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,619,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,619,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,622,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,622,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,622,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,623,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,623,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,623,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,624,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,624,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,624,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,625,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,625,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,625,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,626,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,626,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,626,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,627,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,627,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,627,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,628,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,628,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,628,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,629,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,629,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,629,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,630,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,630,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,630,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,631,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,631,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,631,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,632,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,632,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,632,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,633,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,633,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,633,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,634,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,634,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,634,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,635,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,635,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,635,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,637,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,637,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,637,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,638,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,638,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,638,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,639,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,639,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,639,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,640,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,640,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,640,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,641,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,641,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,641,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,642,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,642,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,642,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,643,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,643,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,643,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,644,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,644,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,644,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,645,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,645,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,645,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,648,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,648,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,648,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,649,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,649,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,649,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,651,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,651,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,651,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,652,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,652,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,652,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,653,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,653,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,653,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,654,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,654,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,654,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,655,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,655,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,655,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,656,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,656,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,656,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,657,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,657,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,657,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,658,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,658,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,658,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,659,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,659,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,659,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,660,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,660,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,660,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,661,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,661,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,661,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,662,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,662,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,662,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,663,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,663,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,663,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,664,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,664,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,664,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,665,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,665,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,665,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,666,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,666,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,666,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,667,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,667,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,667,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,668,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,668,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,668,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,669,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,669,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,669,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,670,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,670,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,670,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,671,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,671,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,671,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,672,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,672,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,672,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,673,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,673,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,673,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,674,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,674,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,674,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,675,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,675,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,675,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,676,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,676,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,676,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,677,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,677,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,677,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,678,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,678,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,678,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,679,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,679,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,679,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,680,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,680,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,680,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,681,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,681,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,681,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,682,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,682,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,682,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,683,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,683,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,683,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,684,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,684,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,684,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,685,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,685,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,685,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,686,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,686,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,686,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,687,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,687,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,687,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,688,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,688,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,688,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,689,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,689,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,689,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,690,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,690,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,690,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,691,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,691,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,691,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,692,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,692,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,692,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,693,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,693,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,693,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,694,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,694,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,694,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,695,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,695,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,695,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,696,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,696,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,696,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,697,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,697,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,697,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,698,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,698,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,698,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,699,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,699,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,699,4);

COMMIT;

        
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_D_SERVICIO_CANAL WHERE  srv_id = 699;