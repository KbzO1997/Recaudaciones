/**************************************************************************/
/* Archivo:            cckb0062.sql		                                  */
/* Objeto:             OTC_D_SERVICIO_CANAL                               */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 15/11/2023                                         */
/* Descripcion:        Script para eliminar cte                           */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*15/11/2023  RECM-806		  Kevin Bastidas            Emision inicial   */
/**************************************************************************/
  set serveroutput on;

DECLARE
  LV_MSG_INI VARCHAR2(100) := 'INICIO SCRIPT';
  LV_MSG_FIN VARCHAR2(100) := 'FINAL SCRIPT';
  LN_CODIGO  NUMBER := 0;
  
BEGIN
  DBMS_OUTPUT.put_line(LV_MSG_INI);

  
  IF LN_CODIGO = 0 THEN 	

		DELETE FROM DB_OTC.OTC_D_SERVICIO_CANAL where srv_id in (26,27,232,233);
		
		DBMS_OUTPUT.put_line('ELIMINAR CTE CIT-TRA');
	ELSE
		
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,26,'1');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,26,'3');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,26,'4');

    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,27,'1');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,27,'3');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,27,'4');

    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,232,'1');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,232,'3');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,232,'4');

    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,233,'1');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,233,'3');
    INSERT INTO DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID)  VALUES (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,233,'4');
    

		DBMS_OUTPUT.put_line('REGISTRAR CTE CIT-TRA');
	END IF;

  DBMS_OUTPUT.put_line(LV_MSG_FIN);  
  
  COMMIT;
     
  
EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
	
END;
/
