/*************************************************************************/
/*  Archivo:            cckb0033.sp                                    */
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
  
    create or replace PROCEDURE DB_OTC."PA_OTC_CFORMAPAGO_TIPCNV" (
  idTIP in DB_OTC.OTC_D_FORMA_PAGO.TID_ID%TYPE,
  idCNV in DB_OTC.OTC_D_FORMA_PAGO.CNV_ID%TYPE,
  S_RESPUESTA OUT sys_refcursor
) IS
BEGIN
		OPEN S_RESPUESTA FOR 
			select 
				FPA_ID as id,
				FPA_NOMBRE as nombre,
				FPA_INTERES as interes,
				FPA_CUOTAS as cuotas,
				FPA_MEDIO as medio,
				FPA_ETIQUETA as etiqueta,
				TID_ID as tipoId,
				CNV_ID as convenioId
			from DB_OTC.otc_d_forma_pago
			where TID_ID = idTIP
				and CNV_ID = idCNV;
		EXCEPTION
			WHEN OTHERS THEN
			CLOSE S_RESPUESTA;
END;
/* RECUPERA FORMA DE PAGO BASDO EN DOS PARAMETROS */
 
/