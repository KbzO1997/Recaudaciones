/**************************************************************************/
/* Archivo:            cckb0016.sql		                                    */
/* Objeto:             OTC_M_EMPRESA                                      */
/* Base de datos:      DB_OTC                                     		    */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 06/03/2023                                         */
/* Descripcion:        Script para editar el nombre del menu              */
/*                     ATM.                                               */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA      AUTOR          RAZON                            */
/*06/03/2023  RECM-264		Kevin Bastidas                                  */
/**************************************************************************/

 set serveroutput on;
    DECLARE
    LV_NOMBRE	VARCHAR2(250) := 'ATM - Autoridad de Transito Municipal de Guayaquil';
    BEGIN
        update DB_OTC.otc_m_empresa
        set 
        emp_nombre = LV_NOMBRE,
        emp_descripcion = LV_NOMBRE
        where emp_id  = 25;

        DBMS_OUTPUT.put_line('ACTUALIZADO OK');
        COMMIT;

        
    EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
/

	SELECT * FROM DB_OTC.OTC_M_EMPRESA WHERE  emp_id = 25;
  