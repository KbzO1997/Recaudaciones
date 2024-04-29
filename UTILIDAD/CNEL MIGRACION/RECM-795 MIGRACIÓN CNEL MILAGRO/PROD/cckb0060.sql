/**************************************************************************/
/* Archivo:            cckb0060.sql		                                  */
/* Objeto:             otc_m_tipo_identificador                           */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 27/10/2023                                         */
/* Descripcion:        Script Update longitd del subministro CNEL Milagro */
/*                                                                    	  */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA      AUTOR          RAZON                            */
/*27/10/2023  RECM-795		Kevin Bastidas                                */
/**************************************************************************/

set serveroutput on;

DECLARE
  LV_MASCARA VARCHAR2(25) := '';
  LV_MASCARA_ORI VARCHAR2(25) := '00000000';
  LV_REGEX VARCHAR2(40) := '^([0-9]){5,8}$';
  LN_CONVENIO NUMBER := 50;
BEGIN

	DBMS_OUTPUT.put_line('OBTENIENDO MASCARA');
	
	SELECT TID_MASCARA INTO LV_MASCARA FROM DB_OTC.OTC_M_TIPO_IDENTIFICADOR
  WHERE CNV_ID = LN_CONVENIO;

	IF LV_MASCARA = '00000000' 
  	THEN 	
		LV_MASCARA := '000000000000';
		LV_REGEX := '^([0-9]){5,12}$';
		
		UPDATE DB_OTC.OTC_M_TIPO_IDENTIFICADOR
			SET TID_MASCARA = LV_MASCARA,
			TID_REGEXP = LV_REGEX
    	WHERE CNV_ID = LN_CONVENIO;
		
		DBMS_OUTPUT.put_line('MASCARA CAMBIO A CUENTA CONTRATO');
	ELSE
		UPDATE DB_OTC.OTC_M_TIPO_IDENTIFICADOR
			SET TID_MASCARA = LV_MASCARA_ORI,
			TID_REGEXP = LV_REGEX
    	WHERE CNV_ID = LN_CONVENIO;

		DBMS_OUTPUT.put_line('MASCARA CAMBIO A CODIGO UNICO');	
	END IF;


	COMMIT;
	
	DBMS_OUTPUT.put_line('CAMBIO DE MASCARA EXITOSO DEl CONVENIO '|| LN_CONVENIO );
	
  EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
	
END;
/
  