/**************************************************************************/
/* Archivo:            cckb0030.sql		                                  */
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
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,958,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,958,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,958,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,959,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,959,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,959,4);

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,960,1);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,960,3);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,960,4);

--ANT
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,958,5);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,959,5);
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,960,5); 


COMMIT;

        
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;

/