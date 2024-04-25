/**************************************************************************/
/* Archivo:            cckb0027.sql		                                  */
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

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,251,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,251,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,251,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,252,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,252,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,252,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,253,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,253,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,253,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,261,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,261,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,261,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,262,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,262,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,262,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,265,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,265,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,265,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,267,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,267,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,268,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,268,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,268,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,269,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,269,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,270,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,270,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,271,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,271,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,272,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,272,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,272,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,273,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,273,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,273,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,274,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,274,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,274,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,275,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,275,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,275,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,276,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,276,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,276,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,277,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,277,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,277,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,278,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,278,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,278,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,279,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,279,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,279,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,280,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,280,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,280,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,281,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,281,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,281,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,282,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,282,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,282,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,283,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,283,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,283,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,284,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,284,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,284,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,285,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,285,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,285,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,286,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,286,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,286,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,287,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,287,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,287,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,288,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,288,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,288,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,289,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,289,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,289,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,290,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,290,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,290,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,291,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,291,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,291,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,292,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,292,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,292,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,293,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,293,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,293,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,294,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,294,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,294,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,295,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,295,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,295,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,296,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,296,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,296,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,297,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,297,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,297,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,298,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,298,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,298,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,299,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,299,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,299,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,300,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,300,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,300,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,301,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,301,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,301,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,302,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,302,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,302,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,303,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,303,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,303,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,304,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,304,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,304,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,305,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,305,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,305,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,306,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,306,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,306,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,307,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,307,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,307,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,308,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,308,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,308,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,309,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,309,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,309,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,310,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,310,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,310,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,311,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,311,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,311,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,312,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,312,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,312,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,313,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,313,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,313,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,314,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,314,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,314,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,315,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,315,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,315,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,316,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,316,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,316,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,317,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,317,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,317,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,318,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,318,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,318,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,319,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,319,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,319,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,320,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,320,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,320,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,321,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,321,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,321,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,322,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,322,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,322,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,323,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,323,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,323,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,324,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,324,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,324,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,325,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,325,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,325,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,326,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,326,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,326,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,327,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,327,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,327,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,328,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,328,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,328,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,329,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,329,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,329,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,330,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,330,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,330,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,331,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,331,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,331,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,332,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,332,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,332,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,333,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,333,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,333,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,334,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,334,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,334,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,335,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,335,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,335,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,336,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,336,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,336,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,337,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,337,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,337,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,342,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,342,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,342,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,343,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,343,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,343,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,344,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,344,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,344,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,345,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,345,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,345,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,346,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,346,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,346,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,347,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,347,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,347,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,348,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,348,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,348,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,349,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,349,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,349,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,350,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,350,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,350,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,351,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,351,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,351,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,352,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,352,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,352,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,353,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,353,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,353,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,354,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,354,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,354,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,355,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,355,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,355,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,356,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,356,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,356,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,357,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,357,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,357,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,358,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,358,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,358,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,359,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,359,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,359,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,360,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,360,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,360,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,361,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,361,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,361,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,362,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,362,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,362,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,363,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,363,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,363,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,364,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,364,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,365,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,365,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,365,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,366,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,366,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,366,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,367,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,367,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,367,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,368,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,368,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,368,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,369,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,369,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,369,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,370,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,370,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,370,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,371,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,371,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,371,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,372,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,372,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,372,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,373,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,373,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,373,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,374,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,374,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,374,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,375,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,375,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,375,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,376,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,376,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,376,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,377,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,377,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,377,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,378,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,378,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,378,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,379,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,379,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,379,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,380,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,380,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,380,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,381,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,381,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,381,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,382,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,382,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,382,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,383,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,383,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,383,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,384,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,384,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,384,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,385,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,385,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,385,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,386,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,386,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,386,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,387,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,387,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,387,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,388,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,388,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,388,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,389,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,389,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,389,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,390,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,390,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,390,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,391,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,391,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,391,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,392,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,392,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,392,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,393,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,393,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,393,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,394,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,394,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,394,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,395,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,395,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,395,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,396,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,396,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,396,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,397,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,397,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,397,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,398,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,398,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,398,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,399,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,399,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,399,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,402,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,402,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,402,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,403,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,403,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,403,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,404,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,404,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,404,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,405,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,405,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,405,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,406,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,406,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,406,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,407,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,407,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,407,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,408,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,408,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,408,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,409,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,409,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,409,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,410,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,410,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,410,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,411,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,411,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,411,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,412,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,412,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,412,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,413,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,413,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,413,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,414,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,414,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,414,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,415,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,415,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,415,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,416,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,416,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,416,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,417,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,417,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,417,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,418,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,418,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,418,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,419,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,419,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,419,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,420,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,420,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,420,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,421,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,421,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,421,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,422,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,422,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,422,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,423,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,423,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,423,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,424,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,424,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,424,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,425,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,425,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,425,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,426,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,426,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,426,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,427,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,427,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,427,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,428,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,428,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,428,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,429,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,429,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,429,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,430,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,430,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,430,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,431,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,431,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,431,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,432,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,432,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,432,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,433,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,433,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,433,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,434,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,434,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,434,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,435,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,435,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,435,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,436,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,436,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,436,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,437,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,437,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,437,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,438,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,438,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,438,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,439,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,439,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,439,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,440,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,440,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,440,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,441,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,441,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,441,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,442,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,442,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,442,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,443,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,443,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,443,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,444,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,444,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,444,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,445,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,445,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,445,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,446,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,446,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,446,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,447,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,447,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,447,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,448,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,448,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,448,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,449,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,449,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,449,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,450,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,450,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,450,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,451,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,451,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,451,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,454,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,454,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,454,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,455,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,455,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,455,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,456,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,456,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,456,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,457,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,457,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,457,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,458,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,458,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,458,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,459,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,459,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,459,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,460,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,460,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,460,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,461,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,461,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,461,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,462,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,462,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,462,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,463,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,463,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,463,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,464,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,464,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,464,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,465,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,465,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,465,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,466,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,466,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,466,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,467,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,467,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,467,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,468,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,468,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,468,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,469,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,469,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,469,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,470,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,470,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,470,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,471,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,471,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,471,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,472,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,472,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,472,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,473,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,473,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,473,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,474,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,474,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,474,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,475,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,475,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,475,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,476,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,476,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,476,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,477,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,477,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,477,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,480,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,480,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,480,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,481,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,481,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,481,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,482,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,482,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,482,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,483,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,483,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,483,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,484,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,484,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,484,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,485,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,485,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,485,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,490,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,490,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,490,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,491,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,491,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,491,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,492,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,492,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,492,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,493,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,493,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,493,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,494,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,494,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,494,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,495,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,495,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,495,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,496,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,496,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,496,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,497,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,497,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,497,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,498,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,498,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,498,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,499,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,499,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,499,4);

COMMIT;

        
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_D_SERVICIO_CANAL WHERE  srv_id = 499;