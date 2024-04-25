﻿/**************************************************************************/
/* Archivo:            ccjg0020.sql		                                  */
/* Objeto:             OTC_M_CONVENIO, OTC_M_FLUJO,OTC_D_FLUJO_SERV_ENRIQ,*/
/*					   OTC_M_TIPO_IDENTIFICADOR, OTC_M_EMPRESA		      */
/* Base de datos:      DB_OTC                                     		  */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Jonathan Guerrero                                  */
/* Fecha de escritura: 10/22/2020                                         */
/* Descripcion:        Script para agregar a la empresa U Catolica  menu  */
/*                     tarjetas comerciales de la banca en linea BB.      */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*03/26/2021  RECMPS-553		Jonathan Guerrero    Emision inicial      */
/**************************************************************************/


set serveroutput on;
DECLARE
  LV_MSG_INI VARCHAR2(100) := 'INICIO SCRIPT';
  LV_MSG_FIN VARCHAR2(100) := 'FINAL SCRIPT';
  LN_CODIGO_EMPRESA         NUMBER := 0;
  LN_CODIGO_GRUPO           NUMBER := 0;
  LN_CODIGO_CONVENIO        NUMBER := 0;
  LN_CODIGO_SERVICIO        NUMBER := 0;
  LN_CODIGO_CANAL           NUMBER := 0;
  LN_CODIGO_IDENTIFICADOR   NUMBER := 0;
  LN_CODIGO_PUNTOFINAL      NUMBER := 0;
  LN_CODIGO_FLUJO           NUMBER := 0;
  LN_CODIGO_FLUJOENRIQ      NUMBER := 0;
  LN_GRUPO_SERVICIO			NUMBER := 14;  --EDUCACION
  LV_COBIS_EMPRESA			VARCHAR2(4)  := '1348';
  LV_EMPRESA 				VARCHAR2(50) := 'UNIV. CATOLICA DE CUENCA 1348';
  LV_RUC_EMPRESA			VARCHAR2(15) := '0190032981001';
  LV_FLUJO_SOA				VARCHAR2(4)  := '11g';
  LV_PUNTO_FINAL 			VARCHAR2(50) := 'Recaudaciones/proxy/DepositoEnLineaLocal';
  LV_REPOSITORIO_PETICION	VARCHAR2(50) := '/opt/microservices/transformaciones';
  LV_EMPRESA_XSL			VARCHAR2(50) := 'UCATOLICA';
BEGIN
  
  DBMS_OUTPUT.put_line(LV_MSG_INI);
  
  DBMS_OUTPUT.put_line('ELIMINAR U CATILICA ANTERIOR');
  delete DB_OTC.OTC_D_SERVICIO where  grp_id = 590;
  delete DB_OTC.OTC_M_GRUPO_SERVICIO where emp_id = 364;
  delete DB_OTC.OTC_M_EMPRESA where emp_id = 364 and emp_codigo = 263;
  
  
  
  DBMS_OUTPUT.put_line('OBTENIENDO SECUENCIAS MAXIMAS TABLAS OTC');
  -- OBTENER MAXIMO CODIGO TABLAS OTC
  select MAX(EMP_ID)+1 into LN_CODIGO_EMPRESA from DB_OTC.OTC_M_EMPRESA;      
  select MAX(GRP_ID)+1 into LN_CODIGO_GRUPO from DB_OTC.OTC_M_GRUPO_SERVICIO; 
  select MAX(CNV_ID)+1 into LN_CODIGO_CONVENIO from DB_OTC.OTC_M_CONVENIO;
  select MAX(SRV_ID)+1 into LN_CODIGO_SERVICIO from DB_OTC.OTC_D_SERVICIO;
  select MAX(SC_ID)+1 into LN_CODIGO_CANAL from DB_OTC.OTC_D_SERVICIO_CANAL;
  select MAX(TID_ID)+1 into LN_CODIGO_IDENTIFICADOR from DB_OTC.OTC_M_TIPO_IDENTIFICADOR;
  select MAX(END_ID)+1 into LN_CODIGO_PUNTOFINAL from DB_OTC.OTC_M_PUNTO_FINAL;
  select MAX(FLU_ID)+1 into LN_CODIGO_FLUJO from DB_OTC.OTC_M_FLUJO;
  select MAX(FSE_ID)+1 into LN_CODIGO_FLUJOENRIQ from DB_OTC.OTC_D_FLUJO_SERV_ENRIQ;
    
    --*** REEMPLAZAR DATOS DE LA EMPRESA
    --1: EMPRESAS -- *****
    Insert into DB_OTC.OTC_M_EMPRESA (EMP_ID,EMP_IDENTIFICACION,EMP_NOMBRE,EMP_CODIGO,EMP_DESCRIPCION) 
    values (LN_CODIGO_EMPRESA,LV_RUC_EMPRESA,LV_EMPRESA,LV_COBIS_EMPRESA,LV_EMPRESA);
    DBMS_OUTPUT.put_line('INSERTAR EMPRESA OK');
    
    --*** REEMPLAZAR DATOS DEL MENÚ
    --2: GRUPO SERVICIO--
    Insert into DB_OTC.OTC_M_GRUPO_SERVICIO (GRP_ID,EMP_ID,CT_ID_TIPO_BANCA,CT_ID_TIPO_SERV,GRP_CONVENIO_VISIBLE,GRP_MATRICULABLE,GRP_MATRIC_MULTIPLE,GRP_VALIDABLE) 
    values (LN_CODIGO_GRUPO,LN_CODIGO_EMPRESA,'1',LN_GRUPO_SERVICIO,'0','1','0','0');
    DBMS_OUTPUT.put_line('INSERTAR GRUPO SERVICIO OK');
    
    --*** REEMPLAZAR CODIGO DE LA EMPRESA
    --3: CONVENIOS--
    Insert into DB_OTC.OTC_M_CONVENIO (CNV_ID,CNV_CODIGO,CNV_VISIBLE,CNV_ETIQUETA_CODIGO) 
    values (LN_CODIGO_CONVENIO,LV_COBIS_EMPRESA,'1',LV_EMPRESA);
    DBMS_OUTPUT.put_line('INSERTAR CONVENIO OK');
    
    --*** REEMPLAZAR NOMBRE DE LA EMPRESA
    --4: SERVICIOS--
    Insert into DB_OTC.OTC_D_SERVICIO (SRV_ID,SRV_NOMBRE,GRP_ID,CNV_ID) 
    values (LN_CODIGO_SERVICIO,LV_COBIS_EMPRESA,LN_CODIGO_GRUPO,LN_CODIGO_CONVENIO);
    DBMS_OUTPUT.put_line('INSERTAR SERVICIO OK');
    
    --5:SERVICIO CANAL--
    Insert into DB_OTC.OTC_D_SERVICIO_CANAL (SC_ID,SRV_ID,CAN_ID) 
    values (LN_CODIGO_CANAL,LN_CODIGO_SERVICIO,'1');
    DBMS_OUTPUT.put_line('INSERTAR SERVICIO CANAL OK');
    
    --*** REEMPLAZAR MENSAJE INFORMATIVO Y EXPRESION REGULAR PARA CONTROL DEL INSUMO A MATRICULAR
    --6:TIPO IDENTIFICADOR--
    Insert into DB_OTC.OTC_M_TIPO_IDENTIFICADOR (TID_ID,TID_CODIGO,TID_CONCAT_REGIONAL_AREA,TID_MASCARA,TID_MATRICULABLE,TID_REGEXP,TID_FLUJO_AYUDA,CNV_ID,TID_TEXTO_AYUDA,TID_ETIQUETA_CODIGO,TID_PROGRAMABLE) 
    values (LN_CODIGO_IDENTIFICADOR,'1',null,'0000000000','1','^([0-9]){10}$',null,LN_CODIGO_CONVENIO,'Ingrese su Cédula','Identificación','1');
    DBMS_OUTPUT.put_line('INSERTAR IDENTIFICADOR OK');
    
    --*** REEMPLAZAR RUTA DEL PROXY LOCAL A CONSUMIR Y NOMBRES DE LAS TRANSFORMACIONES
    --*** EN CASO DE NECESITAR EL REVERSO AUMENTAR EN EL SCRIPT
    --7:ENDPOINT --
    Insert into DB_OTC.OTC_M_PUNTO_FINAL (END_ID,END_NOMBRE,END_PUNTO_FINAL,END_OPERACION,END_REPOSITORIO_PETICION,END_REPOSITORIO_RESPUESTA,END_PETICION,END_RESPUESTA, END_AMBIENTE) 
    values (LN_CODIGO_PUNTOFINAL,LV_EMPRESA || ' CONSULTA',LV_PUNTO_FINAL,'Consultar',LV_REPOSITORIO_PETICION,LV_REPOSITORIO_PETICION,LV_EMPRESA_XSL || '_C_IN.xsl', LV_EMPRESA_XSL || '_C_OUT.xsl',LV_FLUJO_SOA);
    DBMS_OUTPUT.put_line('INSERTAR PUNTO FINAL CONSULTA OK');
    
	Insert into DB_OTC.OTC_M_PUNTO_FINAL (END_ID,END_NOMBRE,END_PUNTO_FINAL,END_OPERACION,END_REPOSITORIO_PETICION,END_REPOSITORIO_RESPUESTA,END_PETICION,END_RESPUESTA, END_AMBIENTE) 
    values (LN_CODIGO_PUNTOFINAL+1,LV_EMPRESA || ' PAGO',LV_PUNTO_FINAL,'Pagar',LV_REPOSITORIO_PETICION,LV_REPOSITORIO_PETICION, LV_EMPRESA_XSL || '_P_IN.xsl', LV_EMPRESA_XSL || '_P_OUT.xsl',LV_FLUJO_SOA);
    DBMS_OUTPUT.put_line('INSERTAR PUNTO FINAL PAGAR OK');
        
    --** CONSIDERACIONES:
    --** 22 => CONSULTA
    --** 6  => PAGO
	--** 23 => REVERSO
    --8:FLUJO-- 
    Insert into DB_OTC.OTC_M_FLUJO (FLU_ID,END_ID,CNV_ID,CTD_ID_OPERACION) 
    values (LN_CODIGO_FLUJO,LN_CODIGO_PUNTOFINAL,LN_CODIGO_CONVENIO,'22');
    DBMS_OUTPUT.put_line('INSERTAR FLUJO CONSULTA OK');
    Insert into DB_OTC.OTC_M_FLUJO (FLU_ID,END_ID,CNV_ID,CTD_ID_OPERACION) 
    values (LN_CODIGO_FLUJO+1,LN_CODIGO_PUNTOFINAL+1,LN_CODIGO_CONVENIO,'6');
    DBMS_OUTPUT.put_line('INSERTAR FLUJO PAGO OK');
    
    -- 9:FLUJO SERVICIO ENRIQ --
    Insert into DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID,ES_ID,FLU_ID) 
    values (LN_CODIGO_FLUJOENRIQ,'1',LN_CODIGO_FLUJO);
    DBMS_OUTPUT.put_line('INSERTAR FLUJO ENRIQ CONSULTA OK');
    Insert into DB_OTC.OTC_D_FLUJO_SERV_ENRIQ (FSE_ID,ES_ID,FLU_ID) 
    values (LN_CODIGO_FLUJOENRIQ+1,'1',LN_CODIGO_FLUJO+1);
    DBMS_OUTPUT.put_line('INSERTAR FLUJO ENRIQ PAGO OK');
    
    -- CONFIRMAR
    COMMIT;
    
    DBMS_OUTPUT.put_line('******************* DATOS INSERTADOS **************************');
    DBMS_OUTPUT.put_line('CODIGO EMPRESA : '||LN_CODIGO_EMPRESA);
    DBMS_OUTPUT.put_line('CODIGO GRUPO SERVICIO : '||LN_CODIGO_GRUPO);
    DBMS_OUTPUT.put_line('CODIGO CONVENIO : '||LN_CODIGO_CONVENIO);
    DBMS_OUTPUT.put_line('CODIGO SERVICIO : '||LN_CODIGO_SERVICIO);
    DBMS_OUTPUT.put_line('SERVICIO CANAL : '||LN_CODIGO_CANAL);
	DBMS_OUTPUT.put_line('CODIGO SERVICIO CANAL : '||LN_CODIGO_CANAL);
    DBMS_OUTPUT.put_line('CODIGO IDENTIFICADOR : '||LN_CODIGO_IDENTIFICADOR);
    DBMS_OUTPUT.put_line('CODIGO PUNTO FINAL CONSULTAR : '||LN_CODIGO_PUNTOFINAL);
    DBMS_OUTPUT.put_line('CODIGO PUNTO FINAL PAGAR : '||TO_CHAR(LN_CODIGO_PUNTOFINAL+1));
    DBMS_OUTPUT.put_line('CODIGO FLUJO CONSULTA : '||LN_CODIGO_FLUJO);
    DBMS_OUTPUT.put_line('CODIGO FLUJO PAGO : '||LN_CODIGO_FLUJO);
    DBMS_OUTPUT.put_line('CODIGO FLUJO ENRIQ CONSULTA : '||LN_CODIGO_FLUJOENRIQ);
    DBMS_OUTPUT.put_line('CODIGO FLUJO ENRIQ PAGO : '||TO_CHAR(LN_CODIGO_FLUJOENRIQ+1));
        
	
    
  DBMS_OUTPUT.put_line(LV_MSG_FIN);
  
  EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
  
END;



