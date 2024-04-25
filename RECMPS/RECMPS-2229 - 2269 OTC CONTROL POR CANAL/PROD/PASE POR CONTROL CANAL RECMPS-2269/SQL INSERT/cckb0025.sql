/*************************************************************************/
/*  Archivo:            cckb0025.sql                                    */
/*  Base de datos:      DB_OTC                                    		*/
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 09/05/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*Creacion de secuencia para realizar insert OTC_D_SERVICIO_CANAL       */
/************************************************************************/
/*                      MODIFICACIONES                                   */
/*  REF.  FECHA RATIONAL AUTOR         Razon                             */
/*  1    09/05/2023 Kevin Bastidas RECMPS-2269 Emision inicial           */
/*************************************************************************/
set serveroutput on;
DECLARE LV_MAX_SC_ID NUMBER := 0;
 BEGIN 
    select MAX(sc_id)+1 into LV_MAX_SC_ID from DB_OTC.OTC_D_SERVICIO_CANAL;  

    EXECUTE IMMEDIATE 'CREATE SEQUENCE DB_OTC.SQ_DSRVCANAL_SCID MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH ' || LV_MAX_SC_ID || ' NOCACHE NOORDER NOCYCLE ';

 EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
END;
 
/