/*************************************************************************/
/*  Archivo:            cckb0052.sql                                    */
/*  Base de datos:      DB_OTC                                    		*/
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 20/06/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*Creacion de secuencia para realizar insert OTC_D_SERVICIO_CANAL       */
/************************************************************************/
/*                      MODIFICACIONES                                   */
/*  REF.  FECHA RATIONAL AUTOR         Razon                             */
/*  1    20/06/2023 Kevin Bastidas RECM-733 Emision inicial           	*/
/*************************************************************************/
set serveroutput on;
DECLARE LV_MAX_SC_ID NUMBER := 0;

 BEGIN 
    
    insert into DB_OTC.OTC_D_SERVICIO_CANAL (sc_id, srv_id, can_id) values (DB_OTC.SQ_DSRVCANAL_SCID.NEXTVAL,269,5);
    
 EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
 
/

SELECT * FROM DB_OTC.OTC_D_SERVICIO_CANAL WHERE  srv_id = 269;