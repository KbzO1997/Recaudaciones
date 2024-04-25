/**************************************************************************/
/* Archivo:            cckb0004.sql		                                    */
/* Objeto:             OTC_M_EMPRESA,OTC_M_GRUPO_SERVICIO                 */
/*                     OTC_M_CONVENIO,OTC_D_SERVICIO,OTC_M_FLUJO          */
/*                     OTC_M_PUNTO_FINAL,OTC_M_TIPO_IDENTIFICADOR,        */
/*                     OTC_D_FLUJO_SERV_ENRIQ                             */
/* Base de datos:      DB_OTC                                     		    */
/* Producto:           Recaudaciones                                      */
/* Disenado por:       Kevin Bastidas                                     */
/* Fecha de escritura: 7/04/2022                                         */
/* Descripcion:        Script para agregar el menu de                     */
/*                     Impuestos y Servicios aduaneros  BB.               */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA     TAREA             AUTOR                  RAZON             */
/*   7/04/2022  RECM-529		Kevin Bastidas  VISUALIZAR TERCON EN 24ONLINE */
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
  LN_GRUPO_SERVICIO			NUMBER := 26;
  LV_COBIS_EMPRESA			VARCHAR2(5)  := '1929';
  LV_EMPRESA 				VARCHAR2(50) := 'Servicios logisticos';
  LV_RUC_EMPRESA			VARCHAR2(15) := '0999000000000';
  LV_FLUJO_SOA				VARCHAR2(4)  := '12c';  
  LV_EMPRESA_XSL			VARCHAR2(50) := 'Servicios logisticos';
BEGIN
  
  DBMS_OUTPUT.put_line(LV_MSG_INI);
    
  DBMS_OUTPUT.put_line('OBTENIENDO SECUENCIAS MAXIMAS TABLAS OTC');
  -- OBTENER MAXIMO CODIGO TABLAS OTC
  select MAX(EMP_ID)+1 into LN_CODIGO_EMPRESA from DB_OTC.OTC_M_EMPRESA;      
  select MAX(GRP_ID)+1 into LN_CODIGO_GRUPO from DB_OTC.OTC_M_GRUPO_SERVICIO; 
  select MAX(CNV_ID)+1 into LN_CODIGO_CONVENIO from DB_OTC.OTC_M_CONVENIO;
  select MAX(TID_ID)+1 into LN_CODIGO_IDENTIFICADOR from DB_OTC.OTC_M_TIPO_IDENTIFICADOR;
  select MAX(END_ID)+1 into LN_CODIGO_PUNTOFINAL from DB_OTC.OTC_M_PUNTO_FINAL;
  select MAX(FLU_ID)+1 into LN_CODIGO_FLUJO from DB_OTC.OTC_M_FLUJO;
  select MAX(FSE_ID)+1 into LN_CODIGO_FLUJOENRIQ from DB_OTC.OTC_D_FLUJO_SERV_ENRIQ;
  select MAX(SRV_ID)+1 into LN_CODIGO_SERVICIO from DB_OTC.OTC_D_SERVICIO;

    --*** REEMPLAZAR DATOS DE LA EMPRESA
    --1: EMPRESAS -- *****
    Insert into DB_OTC.OTC_M_EMPRESA (EMP_ID,EMP_IDENTIFICACION,EMP_NOMBRE,EMP_CODIGO,EMP_DESCRIPCION) 
    values (LN_CODIGO_EMPRESA,LV_RUC_EMPRESA,LV_EMPRESA,LV_COBIS_EMPRESA,LV_EMPRESA);
    DBMS_OUTPUT.put_line('INSERTAR EMPRESA OK');
    
    --*** REEMPLAZAR DATOS DEL MENU
    --2: GRUPO SERVICIO--
    Insert into DB_OTC.OTC_M_GRUPO_SERVICIO (GRP_ID, EMP_ID, CT_ID_TIPO_BANCA, CT_ID_TIPO_SERV, GRP_CONVENIO_VISIBLE,GRP_MATRICULABLE,GRP_MATRIC_MULTIPLE,GRP_VALIDABLE) 
    values (LN_CODIGO_GRUPO,LN_CODIGO_EMPRESA,'1',LN_GRUPO_SERVICIO,'1','0','0','0');
    DBMS_OUTPUT.put_line('INSERTAR GRUPO SERVICIO OK');
    
    --*** REEMPLAZAR CODIGO DE LA EMPRESA
    --3: CONVENIOS--
    Insert into DB_OTC.OTC_M_CONVENIO (CNV_ID,CNV_CODIGO,CNV_VISIBLE,CNV_ETIQUETA_CODIGO) 
    values (LN_CODIGO_CONVENIO,'0','1',LV_EMPRESA);    
    DBMS_OUTPUT.put_line('INSERTAR CONVENIO OK');  
  
    --*** ACTUALIZAR EL GRUPO DE SERVICIO DE LA EMPRESA TERCON
    --4: SERVICIO--
    update DB_OTC.OTC_D_SERVICIO set GRP_ID = LN_CODIGO_GRUPO where SRV_NOMBRE = '8989';
    DBMS_OUTPUT.put_line('ACTUALIZO GRUPO SERVICIO CONVENIO OK');
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
/

    SELECT * FROM  DB_OTC.OTC_M_GRUPO_SERVICIO WHERE GRP_ID = 728;