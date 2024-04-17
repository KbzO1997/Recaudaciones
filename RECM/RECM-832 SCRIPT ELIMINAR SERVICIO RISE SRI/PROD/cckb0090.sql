/**************************************************************************/
/* Archivo:            cckb0090.sql		                                    */
/* Objeto:             OTC_D_SERVICIO_CANAL                               */
/* Base de datos:      DB_OTC                                     		    */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 08/01/2024                                         */
/* Descripcion:        Script para eliminar RISE                          */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA        AUTOR                       RAZON             */
/*08/01/2024  RECM-832		  Kevin Bastidas            Emision inicial     */
/**************************************************************************/
  set serveroutput on;

DECLARE
  LV_MSG_INI VARCHAR2(100) := 'INICIO SCRIPT';
  LV_MSG_FIN VARCHAR2(100) := 'FINAL SCRIPT';
  LN_CODIGO  NUMBER := 0;
  
BEGIN
  DBMS_OUTPUT.put_line(LV_MSG_INI);

	DELETE FROM DB_OTC.OTC_D_SERVICIO_CANAL where srv_id in (226,19) and CAN_ID not in (5);
		
	DBMS_OUTPUT.put_line('ELIMINAR SRI-RISE');


  DBMS_OUTPUT.put_line(LV_MSG_FIN);  
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
	
END;
/
