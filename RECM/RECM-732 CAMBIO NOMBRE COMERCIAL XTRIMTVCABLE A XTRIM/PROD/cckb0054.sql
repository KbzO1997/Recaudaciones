/**************************************************************************/
/* Archivo:            cckb0054.sql		                                  */
/* Objeto:             OTC_M_EMPRESA                                      */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 05/07/2023                                         */
/* Descripcion:        Script para editar el nombre del menu              */
/*                     TVCable.                                               */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA      AUTOR          RAZON                            */
/*05/07/2023  RECM-732		Kevin Bastidas                                */
/**************************************************************************/

 set serveroutput on;
    BEGIN
       UPDATE  DB_OTC.OTC_D_SERVICIO SET
        SRV_NOMBRE = 'Xtrim  Internet'
        WHERE SRV_ID = 201;

        UPDATE  DB_OTC.OTC_D_SERVICIO SET
        SRV_NOMBRE = 'Xtrim  TV Pagada'
        WHERE SRV_ID = 202;

        UPDATE  DB_OTC.OTC_D_SERVICIO SET
        SRV_NOMBRE = 'Xtrim  Telefono'
        WHERE SRV_ID = 204;

        UPDATE DB_OTC.OTC_M_EMPRESA 
        SET emp_nombre = 'Xtrim',
        emp_descripcion = 'Xtrim'
        WHERE emp_id = 163;

        DBMS_OUTPUT.put_line('ACTUALIZADO OK');
        COMMIT;

        
    EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_M_EMPRESA WHERE  emp_id = 163;
  