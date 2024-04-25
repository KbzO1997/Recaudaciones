/**************************************************************************/
/* Archivo:            ccam014.sql		                                  */
/* Objeto:             OTC_D_SERVICIO_CANAL                               */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Angel Maquilon                                     */
/* Fecha de escritura: 02/05/2023                                         */
/* Descripcion:        Script para insertar los convenios por cada canal  */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA        AUTOR          RAZON                          */
/*  02/05/2023  RECMPS-2229 Angel Maquilon CORRECCION DE NOVEDADES        */
/*                                          SONAR-CONTROL POR CANAL CNB   */     
/**************************************************************************/
set serveroutput on;

BEGIN

insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,3,2);  --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,4,2);  --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,5,2);  --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,6,3);  --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,8,4);  --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,18,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,19,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,21,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,24,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,25,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,28,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,29,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,31,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,36,2); --OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,183,2);--OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,187,2);--OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,190,2);--OK
insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (SQ_DSRVCANAL_SCID.NEXTVAL,201,2);--OK
COMMIT;

        
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_D_SERVICIO_CANAL WHERE  srv_id = 248;