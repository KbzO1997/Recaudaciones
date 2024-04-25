/*************************************************************************/
/*  Archivo:            cckb0032.sp                                     */
/*  Base de datos:      DB_OTC                                    		*/
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 28/04/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*Editar SP para filtrar info por canal OTC_D_SERVICIO_CANAL            */
/************************************************************************/
/*                      MODIFICACIONES                                   */
/*  REF.  FECHA RATIONAL AUTOR         Razon                             */
/*  1    28/04/2023 Kevin Bastidas RECMPS-2229 Emision inicial           */
/*************************************************************************/
set serveroutput on;
  
    create or replace PROCEDURE DB_OTC."PA_OTC_COBTIENE_IDFLUJO" (
    s_result OUT sys_refcursor
    , e_transaccion IN integer) 
    IS 
    BEGIN
        open  s_result for SELECT tf.FLU_ID as flujoId 
        , tf.END_PETICION as peticion
        , tf.END_RESPUESTA as respuesta
        FROM DB_OTC.OTC_M_TRANSFORMACION_FLUJO tf
        WHERE tf.TRANSACCION = e_transaccion;
    EXCEPTION
    WHEN OTHERS THEN
    CLOSE s_result;
    END;
 
/