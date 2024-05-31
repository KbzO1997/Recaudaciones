/****************************************************************************/
/* Archivo:            ccfa0012.sql                                    			*/
/* Objeto:             Cambiar de Ambiente 12C y 11g por Reverso del Flujo de 
  SRI en OTC																*/
/* Base de datos:      DB_OTC                                     				*/
/* Producto:           Recaudaciones                                    		*/
/* Disenado por:       Fernando Andrade                               			*/
/* Fecha de escritura: 03/Diciembre/2021                                       	*/
/* Descripcion:        Cambiar de Ambiente 12C y 11g por Reverso del Flujo de 
					   SRI en OTC 											*/
/****************************************************************************/
/*                            MODIFICACIONES                            		*/
/*   FECHA     	TAREA             AUTOR                  RAZON           		*/
/*03/Dic/2021   RECMPS-1323		Fernando Andrade       Emision inicial   		*/
/****************************************************************************/

set serveroutput on;

DECLARE
  LV_AMBIENTE VARCHAR2(10) := '11g';
BEGIN

	DBMS_OUTPUT.put_line('OBTENIENDO AMBIENTE');
	
	select END_AMBIENTE into LV_AMBIENTE from DB_OTC.OTC_M_PUNTO_FINAL where END_ID = 63; 

	IF LV_AMBIENTE = '11g' THEN 
		LV_AMBIENTE := '12c';
		DBMS_OUTPUT.put_line('AMBIENTE ACTUAL 11G CAMBIO A AMBIENTE 12C');
	ELSE 
		LV_AMBIENTE := '11g';
		DBMS_OUTPUT.put_line('AMBIENTE ACTUAL 12C CAMBIO A AMBIENTE 11G');
	END IF;


	Update DB_OTC.OTC_M_PUNTO_FINAL set END_AMBIENTE = LV_AMBIENTE
	where END_ID in (63, 64, 65);

	COMMIT;
	
	DBMS_OUTPUT.put_line('CAMBIO DE AMBIENTE EXITOSO A: '||LV_AMBIENTE);
	
  EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
	
END;
/
