/**************************************************************************/
/* Archivo:            cckb0011.sql		                                    */
/* Objeto:             OTC_M_PUNTO_FINAL                                  */
/* Base de datos:      DB_OTC                                     		    */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 11/10/2022                                         */
/* Descripcion:        Script actualizar los nombres de las transformacion*/
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*10/11/2022  RECMPS-XXX 		Kevin Bastidas    Emision inicial             */
/**************************************************************************/

  set serveroutput on;


  BEGIN
    
    UPDATE DB_OTC.OTC_M_PUNTO_FINAL
    SET
    END_PETICION = 'RMS_ANT_C_IN.xsl',
    END_RESPUESTA = 'RMS_ANT_C_OUT.xsl'
    WHERE END_ID = 211;

    UPDATE DB_OTC.OTC_M_PUNTO_FINAL
    SET
    END_PETICION = 'RMS_ANT_P_IN.xsl',
    END_RESPUESTA = 'RMS_ANT_P_OUT.xsl'
    WHERE END_ID = 212;

  EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
  
END;
/
