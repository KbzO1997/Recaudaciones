/*************************************************************************/
/*  Archivo:            cckb0051.sp                                     */
/*  Base de datos:      DB_OTC                                          */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 19/05/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*  Editar informacion de la tabla OTC_M_PUNTO_FINAL ECUTEL             */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  REF.  FECHA     RATIONAL AUTOR Razon                                */
/*  1    29/05/2023 Kevin Bastidas RECMPS-2193 MIGRACION MICROSERVICIO CLARO SERVICIOS FIJOS */
/************************************************************************/
set serveroutput on;

DECLARE
  LV_AMBIENTE VARCHAR2(10) := 'RMS';
  LV_C_PETICION VARCHAR2(100) := '';
  LV_C_RESPUESTA VARCHAR2(100) := '';

  LV_P_PETICION VARCHAR2(100) := '';
  LV_P_RESPUESTA VARCHAR2(100) := '';

  LV_R_PETICION VARCHAR2(100) := '';
  LV_R_RESPUESTA VARCHAR2(100) := '';

  LV_PUNTO_FINAL VARCHAR2(100) := '';
  
BEGIN

	DBMS_OUTPUT.put_line('OBTENIENDO AMBIENTE');
	
	select END_AMBIENTE into LV_AMBIENTE from DB_OTC.OTC_M_PUNTO_FINAL where END_ID IN(128); 

	IF LV_AMBIENTE = '12c' THEN 
		LV_AMBIENTE := 'RMS';
        LV_C_PETICION := 'RMS_ECUT_C_IN.xsl';
        LV_C_RESPUESTA := 'RMS_ECUT_C_OUT.xsl';

        LV_P_PETICION := 'RMS_ECUT_P_IN.xsl';
        LV_P_RESPUESTA := 'RMS_ECUT_P_OUT.xsl';
        
        LV_R_PETICION := 'RMS_ECUT_R_IN.xsl';
        LV_R_RESPUESTA := 'RMS_ECUT_R_OUT.xsl';
        
        LV_PUNTO_FINAL := 'Recaudaciones/Microservicio';

		DBMS_OUTPUT.put_line('AMBIENTE ACTUAL 12c CAMBIO A AMBIENTE RMS');
	ELSE 
		LV_AMBIENTE := '12c';
        LV_C_PETICION := 'ECUT_C_IN.xsl';
        LV_C_RESPUESTA := 'ECUT_C_OUT.xsl';

        LV_P_PETICION := 'ECUT_P_IN.xsl';
        LV_P_RESPUESTA := 'ECUT_P_OUT.xsl';
        
        LV_R_PETICION := 'ECUT_R_IN.xsl';
        LV_R_RESPUESTA := 'ECUT_R_OUT.xsl';

        LV_PUNTO_FINAL := 'CSPRouter/proxy/CSPRouterLocal';
        
		DBMS_OUTPUT.put_line('AMBIENTE ACTUAL RMS CAMBIO A AMBIENTE 12c');
	END IF;

    update DB_OTC.OTC_M_PUNTO_FINAL 
        set 
        end_peticion   = LV_C_PETICION,
        end_respuesta  = LV_C_RESPUESTA,
        end_punto_final= LV_PUNTO_FINAL,
        end_ambiente = LV_AMBIENTE
        where end_id = 128;

        update DB_OTC.OTC_M_PUNTO_FINAL 
        set 
        end_peticion   = LV_P_PETICION, 
        end_respuesta  = LV_P_RESPUESTA,
        end_punto_final = LV_PUNTO_FINAL,
        end_ambiente = LV_AMBIENTE
        where end_id = 129;

        update DB_OTC.OTC_M_PUNTO_FINAL 
        set 
        end_peticion   = LV_R_PETICION, 
        end_respuesta  = LV_R_RESPUESTA,
        end_punto_final = LV_PUNTO_FINAL,
        end_ambiente = LV_AMBIENTE
        where end_id = 130;    

        COMMIT;
        DBMS_OUTPUT.put_line('CAMBIO DE AMBIENTE EXITOSO A: '||LV_AMBIENTE);
	
  EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
	
END;

/