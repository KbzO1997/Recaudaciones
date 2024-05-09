use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_tr_recaudacion_luz' and type = 'P')
begin
   drop procedure dbo.sp_tr_recaudacion_luz
   if exists (select 1 from sysobjects where name = 'sp_tr_recaudacion_luz' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_tr_recaudacion_luz -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_tr_recaudacion_luz *OK* =='
end
go
/************************************************************************/
/*  Archivo:            svtreluz.sp                                     */
/*  Motor de Base: 		  SYBASE                     					            */
/*  Base de datos: 		  cob_pagos                                       */
/*  Servidor: 			    HP-ACT                                          */
/*  Aplicacion: 		    Cyberbank	                                      */
/*  Stored procedure:   sp_tr_recaudacion_luz                           */
/*  Procesamiento: 		  OLTP	                                       	  */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Ricardo Egas                                    */
/*  Fecha de escritura: Oct-2000                                        */
/************************************************************************/
/*                                IMPORTANTE                            */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.  */
/************************************************************************/
/*                           PROPOSITO                                  */
/*      Programa permite consultar movimientos diarios de recaudaciones */
/*      de luz para su verificacion                                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/* REF FECHA       AUTOR         TAREA RATIONAL   DESCRIPCION           */
/*    13/Dic/2000    C.Montesdeoca     Ingreso oficinas de 3 digitos    */
/*    13/Mar/2001    R. Egas           Considerar codigo de empresas    */
/*    05/31/2001     Ana Mendez        Cambiar la accion de Credito por */
/*                                     Guardar registro de pago y gene_ */
/*                                     rar los archivos carga  en los   */
/*                                     diferentes formatos              */
/*    28/Ago/2001    R. Egas           Control de error para insercion  */
/*    12/Sep/2001    R. Castillo       Para la Empresa Interagua Adicion*/
/*                                     el campo de retenciones en la    */
/*                                     generacion del archivo.          */
/*    21/Dic/2001    R. Egas           Actualizacion de reversos de atm */
/*                                     se los realizara ala verf de ofic*/
/*    14/Nov/2002    W. Ramirez        Enviar columnas completas Migra  */
/*    24/Dic/2002    R. Davila G.      Agregar Esquema Impuesto Renta   */
/*    10/Feb/2002    R. Davila G.      Verificacion de Archivo de Impues*/
/*                                     to para Retenciones              */
/*    20/Feb/2003    R. Davila G.      Enmascarar Secuencial Segun SRI  */
/*    24/Feb/2003    F. Moncayo V.     Controlar Historico de Caja, sa- */
/*                                     lida a producción Sybase12       */
/*    25/Feb/2003    F. Moncayo V.     Controlar Verificacion de User.  */
/*    26/Feb/2003    R. Davila G.      Cambiar la Personalizacion al    */
/*                                     1/100 o  1/1000.                 */
/*    29/Nov/2004    W. Ramirez        Quitar comision en archivos      */
/*    03/Dic/2004    F. Moncayo V.     Quitar comision de totales       */
/*    29/Dic/2004    F. Moncayo V.     Indicador de Fin de Anio         */
/*    20/Jun/2005    Hugo Yépez        Considerar la retención solo para*/
/*                                     la empresa 1127 canal DBA        */
/*    03/Oct/2005    Daniel Gómez A.   Control para Empresa Electrica   */
/*                                     Quito                            */
/*    03/Ene/2006    Daniel Gómez A.   Control para Municipio de Quito  */
/*                                     Las empresas en                  */
/*                                     pg_recaudacion_automatica no ne- */
/*                                     cesitan verif de user y oficina  */
/*    11/Ene/2006    Daniel Gómez A.   No generar linea de credito para */
/*                                     empresas en                      */
/*                                     pg_recaudacion_automatica        */
/*    09/mayo/2006   Luis Chacha M.    Calculo B.Imponible de Emelgur   */
/*    13/Juli/2006   Luis Chacha M     No considerar Andinatel en el    */
/*                                     cierre de Pacifictel.            */
/*    12/Enero/2007  Luis Chacha M.    Considerar EMELMANABI            */
/*    05/Febrero/07  Luis Chacha M.    Considerar TvCable               */
/*    Jun 27/2007  Galo Yanez        Parametrizar impuesto a la renta   */
/*    02/Jul/2007    Luis Chacha M.    Pacifictel                       */
/*    20/JUL/2007    T. Cervantes Z.   Obtener el porcentaje de reten-  */
/*                                     cion de impuesto a la renta.     */
/*    03/Oct/2007    Luis Chacha M.    Modificar nombre del campo de sec*/
/*    26/Nov/2007    Luis Chacha M.    Consulta de los Movimientos de la*/
/*                                     Empresa CORPEI                   */
/* Feb/29/2008   Miguel Aldaz    campo  pn_valor_uno contendra pn_valor */
/*    07/Mar/2008    German Medina C.  Consulta de Movimientos para el  */
/*                                     Municipio de Samborondon         */
/*    21/Abr/2008    German Medina C.  Consulta de Movimientos para el  */
/*                                     Municipio de Salinas             */
/*    30/Abr/2008    German Medina C.  Consulta de Movimientos para el  */
/*                                     Municipio de Santa Elena         */
/*    26/May/2008    German Medina C.  Consulta de Movimientos SOAT     */
/*    18/Jul/2008    Tania Cumbicus A. Consulta de Movmientos IESS      */
/*    04/Ago/2008    German Medina C.  Consulta de Movimientos CTG      */
/*    15/Ago/2008    Tania Cumbicus A. Aumento campo fecha diferido en Consulta de Movmientos IESS  */
/*    03/Sep/2008    Luis F. Chacha M. Disminuir data devuelta al FE por*/
/*                                     por perdida de parametros de OUT */
/*    05/sep/2008    Wise Computer.    Consulta dey Movimientos para el */
/*                                     Municipio de Libertad            */
/*    11/sep/2008    Wise Computer.    Consulta de Movimientos para EMEPE */
/*    10/Nov/2008    Guillermo Martillo Archivode Respuesta De Prati    */
/*    27/oct/2008    Luis F. Chacha M. Municipio Libertad. Archivo de   */
/*                                     Respuesta                        */
/*    30/oct/2008    Luis F. Chacha M. Interagua: agregar en archivo de */
/*                                     respuesta campos Fecha y Hora    */
/*    29/jul/2009    Tania Cumbicus  Deprati: agregar campo de cedula en consulta*/
/*    20/NOV/2009    Tania Cumbicus  cntttsv: archivo de respuesta*/
/*  46 15/OCT/2009     Ana Mendez      Backoffice recaudacion Porta PORTA-250-CU-1423*/
/*  47 04/nov/2009 Miguel Aldaz  FEL-249-CU-1408  Proyecto de factura-  */
/*                                                 cion electronica.    */
/*  48 01/mar/2010 Tania Cumbicus  CTE-CC-8446  Recaudacion TRIPLEORO   */
/*  49 01/mar/2010 Ana Mendez  DTV-CU-1659  Recaudacion DIRECTV         */
/*  50 29/Jul/2010 Ana Mendez  CTE-CC-10425.   Autoimpresores           */
/*  51 28/Abr/2011   Raul Altamirano   Migracion Sybase 15              */
/*  51 18/Agos/2011 Daniel Pereira V. CTR-CC-10305 Recaudacion Municipio de Daule*/
/*  52 22/Agosto/2011 Sandra Merino    ATMFULL-286-CU-1720              */
/*  53 22/Sept/2011 Daniel Pereira V. MTAC-CU-1730 Movimientos de Claro */
/*  54 12/Marz/2012 German Medina C . MGL-309-CU-1830 Marglobal         */
/*  55 14/Feb/2012 Daniel Pereira V. CNEL-308-CU-1817 Movimientos de CNEL*/
/*  56 02/Mar/2012 Daniel Pereira    CNEL-308-CU-1818                   */
/*  57 30/May/2012 Daniel Pereira    CTE-CC-11287                       */
/*  58 19/Jun/2012 Daniel Pereira    CTE-CC-10524                       */
/*  58 27/Ene/2012 Daniel Pereira V. CTE-CC-10665 Cobro debitos Claro   */
/*  59 20/Jul/2012 Daniel Pereira    CTE-SGC00002999 - Comision Interagua*/
/*  60 03/Oct/2012 Daniel Pereira    CTE-CE-SGC00004765 - Validacion Interagua*/
/*  61 13/Mar/2013  María Jo. Silva  SGC00006336  Cobro de Comision Emp. Elec. Quito*/
/*  62 03/Abr/2013  María Jo. Silva  CTE-CC-SGC00007264 - Comision EMAAP QAMAGUA AGUAPEN*/
/*  63 03/abril/2013 Sandra Merino. TVCABW-SGC00007822 */
/*  62 14/Ene/2013 Daniel Pereira    SGC00005781 CNT SERVICIOS MOVILES*/
/*  63 10/Jun/2013   Daniel Pereira  SGC00009050 Proceso Back Office Ecutel*/
/*  64 04/Sep/2013   Daniel Pereira  SGC00010841 BACKOFFICE CONECEL TV SATELITAL*/
/*  65 29/Ene/2014   Daniel Pereira SGC00012170 Facturacion Electronica */
/*  66 03/Mar/2015  Daniel Pereira  RECA-CC-21099 Migración EEQ a CNEL  */
/*  67 10/Nov/2014   Sandra Merino  RECBEL-AP-SGC00016734-SGC00016735 	*/
/*  68 31/Jul/2015   María Jo. Silva  ETAPA-AP-SGC00018437-SGC00018454   */
/*  69 10/Nov/2014   Sandra Merino  RECBEL-AP-SGC00016734-SGC00016735 	 */
/*  70 17/Marz/2016  Sandra Merino  RECA-CE-SGC00024594                */
/*  71 21/Marz/2016  Sandra Merino  CENSUR-AP-SGC00019459-SGC00023829   */
/*  72 17/JUL/2016  Jorge Pazminno  RECA-CC-SGC00025765                 */
/*                                    Tasa Recoleccion Basura (IWS)     */
/*  73 26/Ago/2016  Jorge Pazminno  RECA-CE-SGC00026315                 */
/*                                  Recuperacion param.output varchar   */
/*                                  como resulset. Opcion 'G' Generacion*/
/*  74 14/Sep/2016  Daniel Pereira  DEPTEM-AP-SGC00025705-SGC00025712   */
/*  75  17/NOV/2017  Sandra Merino M.  RECA-CC-SGC00027078 Fusion con conecel*/
/*  76  25/Sep/2016  Jorge Pazminno  MEGA-AP-SGC00024776-SGC00024778     */
/*                                    Recaudacion Megadatos - 1089      */
/*  77 13/Ene/2017  Daniel Pereira  RECA-CE-SGC00027731                 */
/*  78 07/Dic/2016  Jorge Pazminno  RECA-CC-SGC00026811-Dep.TemporalesII*/
/*  79  06/Dic/2016  Vanessa Miranda MEER-AP-SGC00026606-SGC00026618 Considerar Empresas*/
/*                   que pasen por el flujo MEER                                        */
/*  80 03/Mar/2017  Pablo Ricaurte A. RECA-CC-SGC00027803 Debitos automaticos
					 primax*/
/* 81  06/01/2017     María José Silva G.  RECA-CC-SGC00028146 Cobro de Comision CTE  */
/*  82 06/Feb/2017  Pablo Ricaurte A. SGC00027271 Interagua online */
/*  83 06/Feb/2017  Pablo Ricaurte A. RECA-CE-SGC00028936 Interagua total cabecera */
/*84 07/Jun/2017 Danny Olaya  RECA-CC-SGC00027998 Traslado comision VEN DIRECTV*/
/*85 30/Nov/2015   María Jo. Silva  SGC00022258  Municipio Guayaquil - CEP*/
/*86 14/Ago/2017  Pablo Ricaurte A. RECA-CE-SGC00029489 Interagua online archivo cuando*/
/*					no transacciones en bd.*/
/*87 18/Ago/2017   Danny Olaya S.  RECA-CC-SGC00029665 ECOTEC*/
/*88 14/Mar/2018   Daniel Pereira 	RECA-CE-SGC00031094*/
/*89 22/May/2018   María José Silva URGENTE */
/*90 12/Oct/2018   Danny Olaya S. RECA-CC-SGC00033000 UEES */
/*91 16/Ene/2019   Danny Olaya S. RECA-CE-SGC00034240 */
/*92 28/07/2022   Kevin Bastidas  RECESABREC-124 CONCILIACION*/
/****************************************************************************************/



use cob_pagos
go

if exists (select 1 from sysobjects where name = 'sp_tr_recaudacion_luz')
        drop proc sp_tr_recaudacion_luz

go
create proc dbo.sp_tr_recaudacion_luz (
    @s_ssn          int,
    @s_lsrv         varchar(30),
    @s_srv          varchar(30) = null,
    @s_user         varchar(30) = null,
    @s_sesn         int = null,
    @s_term         varchar(10) ,
    @s_date         datetime,
    --@s_ofi          tinyint = 1,     CMH 13Dic2000
    @s_ofi          smallint = 1,
    @s_rol          smallint = 1,
    @s_org_err      char(1)  = null,  /* Origen de error: [A], [S] */
    @s_error    int   = null,
    @s_sev          tinyint  = null,
    @s_msg          mensaje  = null,
    @s_org          char(1),
    @t_corr         char(1) = 'N',
    @t_ssn_corr     int   = null,  /* Trans a ser reversada */
    @t_debug    char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          int,
    @i_empresa      smallint = null,
    @i_oficina      smallint = null,
    @i_usuario      varchar(10) = null,
    @i_codigo       int = 0,
    @i_opcion       char(1),
    @i_mon          tinyint = null,
    @i_tipo         char(2) = null,
    @i_ubi          int  = null,              --- ame 11/13/2003
    @o_mas_mov      char(1) = 'N' out,
    @o_total        money = null out,
    @o_total_ofi    smallint = null out,
    @o_nombre       varchar(40) = null out,
    @o_cta          varchar(10)   = null out,
    @o_recaudacion  money = null out,
    @o_retencion    money = null out,
    @o_impues       money = null out,
    @o_comision     money = null out,  --FMV 12/03/2004
    @o_cont_rec     int   = null out   -- JPM Ref.72




)
as
declare 
        @w_sp_name      varchar(30),
        @w_srv_local    descripcion,
        @w_val_n        money,
        @w_val_s        money,
        @w_can_n        money,
        @w_can_s        money,
        @w_com_n        money,
        @w_com_s        money,
        @w_total        money,
        @w_total_ofi    smallint,
        @w_total_usu    smallint,
        @w_verific      char(1),
        @w_trn          int,
        @w_control_nc   char(1),
        @w_fech_ult_labo smalldatetime,
        @w_valor_n        money,
        @w_valor_s        money,
        @w_val_ret_n      money,
        @w_val_ret_s      money,
        @w_pe_dias        int,
        @w_pe_laborables  char(1),
        @w_pe_fpago       varchar(6),
        @w_pe_costo       money,
        @w_pn_valor       money,
        @w_fecha_pago     datetime,
        @w_total_trn      int,
        @w_retencion      money,
        @w_costo_recauda  money,
        @w_cont           int,
        @w_tabla          int,
        @w_sec            int,               -- RDG 24/12/2002
        @w_pn_retimpret   money,             -- RDG 24/12/2002
        @w_pe_cuenta      cuenta,            -- RDG 24/12/2002
        @w_fecha_efec     datetime,          -- RDG 24/12/2002
        @w_valtotret      money,             -- RDG 24/01/2003
        @w_valret         money,             -- RDG 24/01/2003
        @w_valtotgra      money,             -- RDG 24/01/2003
        @w_valtotgrabi    money,             -- lfcm 07-abril-2008
        @w_count          int,               -- RDG 02/10/2003
        @w_sec_mas        varchar(20),       -- RDG 02/20/2003
        @w_porcentaje     int,               -- RDG 02/26/2003
        @w_historico      char(1),           -- RDG 02/26/2003
        @w_valida         smallint,
        @w_retencion_mov  money,  --hy-20-junio-2005
        @w_val_ret_mov_n  money,  --hy-20-junio-2005
        @w_val_ret_mov_s  money,  --hy-20-junio-2005
        @w_canal_val      varchar(10),
        
        @w_sec_servicio SMALLINT,
        --@w_porc      tinyint    -- GYC 2007/Jun/27 por --Miguel Aldaz 03-17-2008
        
        @w_porc     float,    --Miguel Aldaz 03-17-2008
        @w_pe_impret      tinyint,    --lfcm 02-agosto-2007 puesta por --Miguel Aldaz 03-17-2008
        @w_fecha_pro      smalldatetime,   ---varchar(10),  --lfcm 22-mayo-2008

        @w_cliente              int,         --ref47
        @w_ind_factelect        char(1),
      
        @w_producto             char(4),
        @w_servicio             char(4),
        
        @w_autorizacion     varchar(30),
        @w_validez          varchar(30),    --ref47: Indicador de facturacion electronica
        @w_fec_ini_vig_aut       varchar (10), --ref50
        @w_fec_fin_vig_aut       varchar (10),  --ref50
       
        @w_acedita_grp    char(1),  --ref55: DAPV/CNEL
        @w_cod_grupo      char(6),   --ref55: DAPV/CNEL
        @w_imdCost        char(1) ,    -- REF 8 smerino
        @w_costCanal      money, -- REF 8 smerino
        @w_canalC         char(3) ,  -- REF 8 smerino     
           
	@w_val_ret_c      money,   -- REF 8 smerino    
	@w_val_ret_c1      money,   -- REF 8 smerino   
	@w_val_ret_c2      money,   -- REF 8 smerino   
        @w_val_c          money,  -- REF 8 smerino    
        @w_val_c1          money,  -- REF 8 smerino  
        @w_val_c2          money,  -- REF 8 smerino  
        @w_can_c          money, -- REF 8 smerino 
        @w_can_c1          money, -- REF 8 smerino 
        @w_can_c2          money, -- REF 8 smerino 
        @w_fecha_anterior  datetime ,  --REF 8 smerino
        @w_flag           char(1), --REF 8 smerino
        @w_fecha_proceso  datetime,    --REF 8 smerino
        @w_feriado   varchar(10),      --REF 8 smerino
        
        @w_grupo_emp      int          -- JPM Ref.77

/*  Captura nombre de Stored Procedure  */
select  @w_srv_local = @s_lsrv
select  @w_sp_name = 'sp_tr_recaudacion_luz'

select @w_porc = 0        -- GYC 2007/Jun/27

select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso

------Saca la fecha del dia anterior habil---
select @w_flag = 'N'
 

select @w_fecha_proceso = @w_fecha_pro

while @w_flag = 'N'
begin
select @w_fecha_proceso= convert(varchar(10),DATEADD(day, -1, @w_fecha_proceso),101) 

 exec  cob_cuentas..sp_identificadia
         @i_fechahoy   = @w_fecha_proceso,
          
@i_tipo       = 'S',
         @o_compensa   = @w_feriado  out

  if @w_feriado = 'NO'
    select  @w_flag = 'N'
  else
  begin
    select  @w_flag = 'S'
    select @w_fecha_anterior=@w_fecha_proceso
  end
  
end 
----- fin del dia anterior habil----


if @i_opcion = 'M' -- Totales por Medios ¢ Canal de Comunicaci¢n
begin
            truncate table cob_pagos..pg_monitor_medios_tmp   ---REF  53

        if @i_empresa not in (118,219, 222, 2234, 2319, 1, 2237, 2235, 2572,2575, 2494, 2236,120,1430,39,451,4994,38,8688,156,8521,42,5994,7256,7749) --,144) --Ref085:msilvag--Ref80 pricaura  -- Ref.71: 144 CS REF:75 SMM, ref79 codigo 144 contemplado en catalogo
        and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo --REF 63 64
                               where tabla in (select codigo from cobis..cl_tabla
                                               where tabla = 'sv_tvcable_online')
                              			and valor = 'S')  -- SMERINO NEW TVCABLE 
        and @i_empresa not in (select pe_empresa from cob_pagos..pg_person_empresa
                          	where pe_cod_grupo = 4994)  --CNEL/CATEG
        and @i_empresa not in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')        
        begin
        --smerino aumentar campo ts_contratado
            insert into cob_pagos..pg_monitor_medios_tmp
            (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
            select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                'CORR.'     = ts_correccion,
                'CONECCION' = substring(ts_tipo_chequera,4,2),
                'VALOR A GUARDAR' = (case @i_empresa              --GAMC - 16/05/2008 - SOAT
                      when 862 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0)-- - isnull(convert(money,ts_autoriz_aut),0)
                      when 115 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0) -- REF 47
                      when 114 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0) -- REF 48
                      when 1371 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)  --Ref061:msilvag
                      when 5482 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0)
                      --Ref062:msilvag Inicio
                      when 360 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      when 361 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)--ref87
		      when   3 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)--ref87
                      when 4 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      when 6 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      --Ref062:msilvag Fin
                      --Ref068:msilvag Inicio
                        when 1707 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                        when 1708 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                        when 6951 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                        when 6952 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
						when 6087 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0) -- ref87
						when 1125 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0) -- ref90
                      --Ref068:msilvag Fin
                        when 1089 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)                               -- JPM Ref.7. Megadatos
                      else isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0) - isnull(convert(money,ts_autoriz_aut),0)
                          end),
                'RETENCION' = isnull(ts_ocasional,0),
                'TOTAL   ' = (case @i_empresa             --GAMC - 16/05/2008 - SOAT
                        when 862 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)
                        when 1371 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0) --Ref061:msilvag
                        when 5482 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0)
                        --Ref062:msilvag Inicio
                        when 360 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)
                        when 4 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)
                        when 6 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)
                        --Ref062:msilvag Fin
                        --Ref068:msilvag Inicio
                      when 1707 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      when 1708 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      when 6951 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
                      when 6952 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)
					  when 6087 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0) -- ref87
					  when 1125 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0) -- ref90
                      --Ref068:msilvag Fin
                      when 1089 then isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)                               -- JPM Ref.76: megadatos
                        else isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)
                        end),
                'COMISION' = isnull(convert(money,ts_autoriz_aut),0)
           from cob_cuentas..cc_tran_servicio
           where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
           and ts_causa = convert(varchar,@i_empresa)
           and ts_usuario = isnull(@i_usuario,ts_usuario)
           
           if @@error <> 0  --REF 63
           begin
              exec cobis..sp_cerror
                   @t_debug  = @t_debug,
                   @t_file   = @t_file,
                   @t_from   = @w_sp_name,
                   @i_num    = 2103001,
                   @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
              return 2103001
           end

        end

          ---SMERINO NEW TVCABLE
         if  @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo
                                                       where tabla in (select codigo from cobis..cl_tabla
                                                         where tabla = 'sv_tvcable_online')
                                                          and valor = 'S')
         begin

            --smerino aumentar campo ts_contratado
             insert into cob_pagos..pg_monitor_medios_tmp
             (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
             select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                    'CORR.'     = ts_correccion,
                    'CONECCION' = substring(ts_tipo_chequera,4,2),
                    'VALOR A GUARDAR' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0) ,-- - isnull(convert(money,ts_autoriz_aut),0)
                    'RETENCION' = isnull(ts_ocasional,0),
                    'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                    'COMISION' = isnull(convert(money,ts_autoriz_aut),0)

               from cob_cuentas..cc_tran_servicio
               where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                              and a.codigo = b.tabla
                                              and estado = 'V')
               and ts_causa = convert(varchar,@i_empresa)
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_tsfecha = @w_fecha_pro

               if @@error <> 0  --REF 63
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 2103001,
                       @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                  return 2103001
               end

          end
          --- FIN SMERINO


    --GAMC - 04/08/2008 - CTG - ini
    if @i_empresa in (2572,2575)
    begin
      insert into cob_pagos..pg_monitor_medios_tmp
      (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
      select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
        'CORR.'     = ts_correccion,
        'CONECCION' = substring(ts_tipo_chequera,4,2),
        'VALOR A GUARDAR' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0),0),
        'RETENCION' = isnull(ts_ocasional,0),
        'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0),0),
        'COMISION' = isnull(convert(money,ts_autoriz_aut),0) --Ref081:msilvag isnull(ts_aporte_iess,0)

      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                     and a.codigo = b.tabla
                                     and estado = 'V')
      and ts_causa = convert(varchar,@i_empresa)

       if @@error <> 0  --REF 63
       begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 2103001,
               @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
          return 2103001
       end
   end
        --GAMC - 04/08/2008 - CTG - fin


        if @i_empresa in (2234, 2319, 2237, 2235, 2236,1430, 7749 ) --Ref085:msilvag   ----DAPV 18/08/2011 M. Daule = 1430  Wise - 05/sep/2008 M. Libertad = 2236 
        begin
            insert into cob_pagos..pg_monitor_medios_tmp
            (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
            select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                'CORR.'     = ts_correccion,
                'CONECCION' = substring(ts_tipo_chequera,4,2),
                'VALOR A GUARDAR' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0),
                'RETENCION' = isnull(ts_ocasional,0),
                'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                'COMISION' = isnull(convert(money,ts_autoriz_aut),0)

            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                          from cobis..cl_tabla a, cobis..cl_catalogo b
                                          where a.tabla = 'sv_trx_nordif'
                                          and a.codigo = b.tabla
                                          and estado = 'V')
            and ts_causa = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)

             if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
             end

        end

        if @i_empresa in (1)   --lfcm 22-feb-2008   CATEG(Pestaña TOTALES POR MEDIO)
        --smerino aumentar campo ts_contratado
        begin
            select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008
            insert into cob_pagos..pg_monitor_medios_tmp
             (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
             select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                'CORR.'     = ts_correccion,
                'CONECCION' = substring(ts_tipo_chequera,4,2),
                'VALOR A GUARDAR' =isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0),
                'RETENCION' = isnull(ts_ocasional,0),
                'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                'COMISION' = isnull(convert(money,ts_autoriz_aut),0)

             from cob_cuentas..cc_tran_servicio
             where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                           from cobis..cl_tabla a, cobis..cl_catalogo b
                                           where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
             and ts_causa = convert(varchar,@i_empresa)
             and ts_fecha = @w_fecha_pro

             if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end
        end

        if @i_empresa in (2494,118,120,39,451,156,8521,5994,7256)   --REF 63 64 REF:75 SMM
        begin
            select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008
            
            
            insert into cob_pagos..pg_monitor_medios_tmp
            (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
            select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                'CORR.'     = ts_correccion,
                'CONECCION' = substring(ts_tipo_chequera,4,2),
                'VALOR A GUARDAR' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0),
                'RETENCION' = isnull(ts_ocasional,0),
                'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                'COMISION' = isnull(convert(money,ts_autoriz_aut),0)

           from cob_cuentas..cc_tran_servicio
           where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                         from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
           and ts_causa = convert(varchar,@i_empresa)
           and ts_tsfecha = @w_fecha_pro

           if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end

        end

        -- Ref.71 CS.-->
        --if @i_empresa = 144   --REF SMERINO registros conciliados con cnb --ref79 comentado, 144 considerado en catálogo
          if @i_empresa in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
        begin
             insert into cob_pagos..pg_monitor_medios_tmp
                    (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
             select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                    'CORR.'     = ts_correccion,
                    'CONECCION' = substring(ts_tipo_chequera,4,2),
                    'VALOR A GUARDAR' = ( isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)),--- isnull(convert(money,ts_autoriz_aut),0)),
                    'RETENCION' = isnull(ts_ocasional,0),
                    'TOTAL   '  = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)),
                    'COMISION'  = isnull(convert(money,ts_autoriz_aut),0)
              from cob_cuentas..cc_tran_servicio
              where ts_tipo_transaccion in (select convert(int,b.codigo)
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V')
                and ts_causa = convert(varchar,@i_empresa)
                and ts_tipo_chequera <> 'CNB' 
                and ts_tsfecha = @w_fecha_pro 
             if @@error <> 0  --REF 63
             begin
               exec cobis..sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 2103001,
                    @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
               return 2103001
             end
             
             insert into cob_pagos..pg_monitor_medios_tmp
                    (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
             select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                    'CORR.'     = ts_correccion,
                    'CONECCION' = substring(ts_tipo_chequera,4,2),
                    'VALOR A GUARDAR' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0),
                    'RETENCION' = isnull(ts_ocasional,0),
                    'TOTAL   '  = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                    'COMISION'  = isnull(convert(money,ts_autoriz_aut),0)
              from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb  
              where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V')
                and ts_causa = convert(varchar,@i_empresa)
                and ts_tipo_chequera='CNB'
                and ts_tsfecha = @w_fecha_pro
                and cc_fecha=ts_tsfecha
                and cc_conciliada='SI'
                and cc_sec_trans=ts_secuencial
                and cc_causa = ts_causa --Ref089:msilvag 
				and ts_terminal = cc_terminal --ref091
				
             if @@error <> 0  --REF 63
             begin
               exec cobis..sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 2103001,
                    @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
               return 2103001
             end
             
             insert into cob_pagos..pg_monitor_medios_tmp
                    (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
             select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                    'CORR.'     = ts_correccion,
                    'CONECCION' = substring(ts_tipo_chequera,4,2),
                    'VALOR A GUARDAR' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0),
                    'RETENCION' = isnull(ts_ocasional,0),
                    'TOTAL   '  = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                    'COMISION'  = isnull(convert(money,ts_autoriz_aut),0)
              from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb  
              where ts_tipo_transaccion in (select convert(int,b.codigo)
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V')
                and ts_causa = convert(varchar,@i_empresa)
                and ts_tipo_chequera='CNB'
                and ts_tsfecha = @w_fecha_pro 
                and cc_fecha=@w_fecha_anterior
                and cc_conciliada='SI'
                and cc_sec_trans=ts_secuencial   ---SACA LAS DIFERIDAS DEL RECAUDO
                and cc_causa = ts_causa --Ref089:msilvag 
				and ts_terminal = cc_terminal --ref091
				
             if @@error <> 0  --REF 63
             begin
               exec cobis..sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 2103001,
                    @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
               return 2103001
             end
        end
        -- <-- Ref.71 CS
        
        if @i_empresa = 4994   --ref55: DAPV/CNEL
        begin
           insert into cob_pagos..pg_monitor_medios_tmp
           (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
           select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                  'CORR.'     = ts_correccion,
                  'CONECCION' = substring(ts_tipo_chequera,4,2),
                  'VALOR A GUARDAR' = ( isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)),--- isnull(convert(money,ts_autoriz_aut),0)),
                  'RETENCION' = isnull(ts_ocasional,0),
                  'TOTAL   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)),
                  'COMISION' = isnull(convert(money,ts_autoriz_aut),0)
             from cob_cuentas..cc_tran_servicio
             where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                          from cobis..cl_tabla a, cobis..cl_catalogo b
                                          where a.tabla = 'sv_trx_nordif'
                                          and a.codigo = b.tabla
                                          and estado = 'V')
               and ts_propietario = convert(varchar,@i_empresa)
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_tsfecha = @w_fecha_pro

             if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end
        end

/*
        -- Ref.71: CS -->
        if @i_empresa in (144) --ref55: smerino CS
        begin
          set rowcount 20
          select 'CODIGO'      = ts_referencia,
                 'SUCURSAL'    = convert(varchar(4),ts_oficina),
                 'VALOR'       = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
                 'FEC_CBLE'    = ts_tsfecha,
                 'FEC_PROCESO' = ts_tsfecha,
                 'USUARIO'     = ts_usuario,
                 'NOMBRE'      = ts_nombre,
                 'TIP_TRX'     = ts_tipo_transaccion,
                 'CTA_BCO'     = ts_cta_banco ,
                 'MONTO_CTA'   = ts_monto,
                 'CEDULA'      = ts_campo_alt_dos,
                 'SECUENCI'    = ts_secuencial
           from cob_cuentas..cc_tran_servicio a
           where ts_tipo_transaccion  in (select convert(int,b.codigo)
                                           from cobis..cl_tabla a, cobis..cl_catalogo b
                                           where a.tabla = 'sv_trx_nordif'
                                             and a.codigo = b.tabla
                                             and estado = 'V')
             and ts_causa = convert(varchar,@i_empresa)
             and ts_correccion = 'N'
             and not exists (select 1
                              from cob_cuentas..cc_tran_servicio
                              where ts_tipo_transaccion in (select convert(int,b.codigo)
                                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                                             where a.tabla = 'sv_trx_nordif'
                                                               and a.codigo = b.tabla
                                                               and estado = 'V')
                                and ts_causa = convert(varchar,@i_empresa)
                                and ts_correccion = 'S'
                                and a.ts_secuencial = ts_ssn_corr)
             and (ts_secuencial > @i_codigo)
           order by ts_secuencial
          
          if @@rowcount = 20
            select @o_mas_mov = 'S'
          else
            select @o_mas_mov = 'N'
          set rowcount 0
        end
        -- <-- Ref.71: CS
*/

        --if @i_empresa in (825,1127,1719,1330,331,4981,4977,4978,4979,4980)--ref55: DAPV/CNEL
        if @i_empresa in (select pe_empresa from cob_pagos..pg_person_empresa
                          where pe_cod_grupo = 4994) --CNEL/CATEG
        begin

          insert into cob_pagos..pg_monitor_medios_tmp
           (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
           select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                  'CORR.'     = ts_correccion,
                  'CONECCION' = substring(ts_tipo_chequera,4,2),
                  'VALOR A GUARDAR' = ( isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0),0)), --- isnull(convert(money,ts_autoriz_aut),0)),
                  'RETENCION' = isnull(ts_ocasional,0),
                  'TOTAL   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)),
                  'COMISION' = isnull(convert(money,ts_autoriz_aut),0)
             from cob_cuentas..cc_tran_servicio
             where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
               and ts_causa = convert(varchar,@i_empresa)
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_tsfecha = @w_fecha_pro

             if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end
        end


     if @i_empresa in (219, 222)
     begin
         insert into cob_pagos..pg_monitor_medios_tmp
         (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
         select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                'CORR.'     = ts_correccion,
                'CONECCION' = substring(ts_tipo_chequera,4,2),
                'VALOR A GUARDAR' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0),0),
                'RETENCION' = isnull(ts_ocasional,0),
                'TOTAL   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ,0),
                'COMISION' = isnull(convert(money,ts_autoriz_aut),0)
           from cob_cuentas..cc_tran_servicio
           where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
             and ts_causa = convert(varchar,@i_empresa)

             if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end
        end


        --If @i_empresa = 38 --PortaCelular  #Ref:54 DAPV
        If @i_empresa in (38,42,8688) --Ref80 pricaura --REF 63
        begin
          insert into cob_pagos..pg_monitor_medios_tmp
         (mt_medios, mt_corr, mt_cone, mt_valgua, mt_rete, mt_total, mt_comision)
          select 'MEDIOS'    = substring(ts_tipo_chequera,1,3),
                 'CORR.'     = ts_correccion,
                 'CONECCION' = substring(ts_tipo_chequera,4,2),
                 'VALOR A GUARDAR' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0),0),
                 'RETENCION' = isnull(ts_ocasional,0),
                 'TOTAL   '  = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0),
                 'COMISION'  = isnull(convert(money,ts_autoriz_aut),0)
           from cob_cuentas..cc_tran_servicio
           where ts_tipo_transaccion in (3427,43545)	--Ref80 pricaura
           and ts_causa = convert(varchar,@i_empresa)
           and ts_tsfecha = @w_fecha_pro

           if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR TEMPORAL'
                return 2103001
            end
        end

                  /* Solo para Transacciones Pacifictel */

           Select 'mt_medios'=isnull(mt_medios,""),
                  'mt_corr'  =isnull(mt_corr,""),
                  'mt_cone'  =isnull(mt_cone,""),
                  'mt_valgua'=isnull(sum(mt_valgua),0),
                  'mt_rete'  =isnull(sum(mt_rete),0),
                  'mt_total' =isnull(sum(mt_total),0),
                  'mt_cant'  =count(1),
                  'mt_comision' = isnull(sum(mt_comision),0)
           from cob_pagos..pg_monitor_medios_tmp
           where ( mt_cone like @i_tipo+'%' or @i_tipo is null )
           group by mt_medios, mt_corr, mt_cone
           order by mt_medios, mt_corr, mt_cone   --REF51: REAM MIGRACION

           if @@rowcount = 0
              begin
                exec cobis..sp_cerror
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_msg           = 'NO HAY REGISTROS QUE PRESENTAR',
                @i_num           = 169505
                return 1
              end

           Select @w_val_s       = isnull(sum(mt_valgua),0),
                  @w_val_ret_s   = isnull(sum(mt_rete),0),
                  @w_valor_s     = isnull(sum(mt_total),0),
                  @w_can_s       = count(1),
                  @w_com_s       = isnull(sum(mt_comision),0)
           from cob_pagos..pg_monitor_medios_tmp
           where mt_corr = "S"
             and ( mt_cone like @i_tipo+'%' or @i_tipo is null )

           Select @o_total       = isnull(sum(mt_valgua),0),
                  @o_retencion   = isnull(sum(mt_rete),0),
                  @o_recaudacion = isnull(sum(mt_total),0),
                  @o_total_ofi   = count(1),
                  @o_comision    = isnull(sum(mt_comision),0)
           from cob_pagos..pg_monitor_medios_tmp
           where mt_corr = "N"
             and ( mt_cone like @i_tipo+'%' or @i_tipo is null )

           select @o_total        = @o_total       - @w_val_s
           select @o_recaudacion  = @o_recaudacion - @w_valor_s
           select @o_retencion    = @o_retencion   - @w_val_ret_s
           select @o_total_ofi    = @o_total_ofi   - @w_can_s
           select @o_comision     = @o_comision    - @w_com_s

   end


if @i_opcion = 'C'              -- CONSULTA DE PAGOS. PESTAÑA DETALLE FORMA FTRAN594 DEL TSERVI
begin
   -- JPM Ref.77 -->
   select @w_grupo_emp = 0
   select @w_grupo_emp = pe_cod_grupo
    from cob_pagos..pg_person_empresa
    where pe_empresa = convert(int, @i_empresa)
   -- <-- JPM Ref.77
                            
    if @o_mas_mov = '1'       -- retorna los totales de la oficina
    begin
     --MOSTRAR TOTALES DE LOS PAGOS.
       if @i_empresa not in (7749, 118,1417, 2234, 1719, 334, 335, 336, 337, 338, 843, 320, 1299, 1538, 3, 219, 222, 2319, 2237, 2235, 2572,2575, 2236, 825,120,1430,39,451,4994,38,8688,156,8521,42,5994,7256 ) --, 144) --Ref085:msilvag --Ref80 pricaura --REF 63 64; REF 71: 144 CS REF:75 SMM --ref79 comentado empresa 144
       and @i_empresa not in (select pe_empresa from cob_pagos..pg_person_empresa
                              where pe_cod_grupo = 4994) --CNEL/CATEG
       and @i_empresa not in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')       
       begin
          if @i_oficina is null and @i_usuario is null --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA ',
              sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
              sum(isnull(cj_efectivo,0)),
              sum(isnull(cj_cheque,0)),
              sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
              sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where cj_producto = 'CTE'
                and cj_transaccion  = convert(int,b.codigo)
                and a.tabla = 'sv_trx_nor'
                and a.codigo = b.tabla
                and estado = 'V'
                and cj_causa = convert(varchar,@i_empresa)
          end
          else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_oficina = @i_oficina
                    and cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)
              end
              else
              if @i_oficina is null
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)
                    and cj_operador = @i_usuario
              end
              else
              begin  --REF 63
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_oficina = @i_oficina
                    and cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)
                    and cj_operador = @i_usuario
              end

          select @w_fech_ult_labo = max(hc_fecha)
          from cob_remesas..re_his_caja

          if @i_oficina is null and @i_usuario is null  --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO',
              sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
              sum(isnull(hc_efectivo,0)),
              sum(isnull(hc_cheque,0)),
              sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
              sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where hc_producto = 'CTE'
              and hc_transaccion = convert(int,b.codigo)
              and a.tabla = 'sv_trx_dif'
              and a.codigo = b.tabla
              and estado = 'V'
              and hc_fecha = @w_fech_ult_labo
              and hc_causa = convert(varchar,@i_empresa)
          end
          else
          if @i_usuario is null --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO',
              sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
              sum(isnull(hc_efectivo,0)),
              sum(isnull(hc_cheque,0)),
              sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
              sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where hc_oficina = @i_oficina
              and hc_producto = 'CTE'
              and hc_transaccion = convert(int,b.codigo)
              and a.tabla = 'sv_trx_dif'
              and a.codigo = b.tabla
              and estado = 'V'
              and hc_fecha = @w_fech_ult_labo
              and hc_causa = convert(varchar,@i_empresa)
          end
          else
          if @i_oficina is null
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO',
              sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
              sum(isnull(hc_efectivo,0)),
              sum(isnull(hc_cheque,0)),
              sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
              sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where hc_producto = 'CTE'
              and hc_transaccion = convert(int,b.codigo)
              and a.tabla = 'sv_trx_dif'
              and a.codigo = b.tabla
              and estado = 'V'
              and hc_operador = @i_usuario
              and hc_fecha = @w_fech_ult_labo
              and hc_causa = convert(varchar,@i_empresa)
          end
          else
          begin   --REF 63
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO',
              sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
              sum(isnull(hc_efectivo,0)),
              sum(isnull(hc_cheque,0)),
              sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
              sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where hc_oficina = @i_oficina
              and hc_producto = 'CTE'
              and hc_transaccion = convert(int,b.codigo)
              and a.tabla = 'sv_trx_dif'
              and a.codigo = b.tabla
              and estado = 'V'
              and hc_operador = @i_usuario
              and hc_fecha = @w_fech_ult_labo
              and hc_causa = convert(varchar,@i_empresa)
          end

       end --if @i_empresa not in

        --GAMC - 04/08/2008 - CTG --tc 20/11/2009 cntttsv
        if @i_empresa in (2572,2575)
        begin
            if @i_oficina is null and @i_usuario is null --REF 63
            begin
                select ' ',
                ' ',
                'TOTALES OFICINA ',
                sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) + sum(isnull(cj_tarjetas,0)) ,
                sum(isnull(cj_efectivo,0)),
                sum(isnull(cj_cheque,0)),
                sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                sum(isnull(cj_tarjetas,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where cj_producto = 'CTE'
                  and cj_transaccion  = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_nor'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and cj_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) + sum(isnull(cj_tarjetas,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_tarjetas,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_oficina = @i_oficina
                    and cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) + sum(isnull(cj_tarjetas,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_tarjetas,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_operador = @i_usuario
                    and cj_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) + sum(isnull(cj_tarjetas,0)) ,
                    sum(isnull(cj_efectivo,0)),
                    sum(isnull(cj_cheque,0)),
                    sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                    sum(isnull(cj_tarjetas,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where cj_oficina = @i_oficina
                      and cj_producto = 'CTE'
                      and cj_transaccion  = convert(int,b.codigo)
                      and a.tabla = 'sv_trx_nor'
                      and a.codigo = b.tabla
                      and estado = 'V'
                      and cj_operador = @i_usuario
                      and cj_causa = convert(varchar,@i_empresa)
                  end

            select @w_fech_ult_labo = max(hc_fecha)
            from cob_remesas..re_his_caja

            if @i_oficina is null and @i_usuario is null --REF 63
            begin
                select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO',
                sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                sum(isnull(hc_efectivo,0)),
                sum(isnull(hc_cheque,0)),
                sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                sum(isnull(hc_tarjetas,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where hc_producto = 'CTE'
                and hc_transaccion = convert(int,b.codigo)
                and a.tabla = 'sv_trx_dif'
                and a.codigo = b.tabla
                and estado = 'V'
                and hc_fecha = @w_fech_ult_labo
                and hc_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO',
                  sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                  sum(isnull(hc_efectivo,0)),
                  sum(isnull(hc_cheque,0)),
                  sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                  sum(isnull(hc_tarjetas,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where hc_oficina = @i_oficina
                  and hc_producto = 'CTE'
                  and hc_transaccion = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_dif'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and hc_fecha = @w_fech_ult_labo
                  and hc_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA DIFERIDO',
                    sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                    sum(isnull(hc_efectivo,0)),
                    sum(isnull(hc_cheque,0)),
                    sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                    sum(isnull(hc_tarjetas,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_operador = @i_usuario
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA DIFERIDO',
                    sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                    sum(isnull(hc_efectivo,0)),
                    sum(isnull(hc_cheque,0)),
                    sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                    sum(isnull(hc_tarjetas,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where hc_oficina = @i_oficina
                    and hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_operador = @i_usuario
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
                  end

        end   --if @i_empresa in (2572,2575)


        --Personalizado solo para pacifictel.
        if @i_empresa  = 3
        begin
            if @i_oficina is null and @i_usuario is null --REF 63
            begin
                select ' ',
                ' ',
                'TOTALES OFICINA ',
                sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,   --cj_ndcc
                sum(isnull(cj_efectivo,0)),
                sum(isnull(cj_cheque,0)),
                sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where cj_producto = 'CTE'
                  and cj_transaccion  = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_nor'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and cj_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,   --cj_ndcc
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_oficina = @i_oficina
                    and cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,   --cj_ndcc
                    sum(isnull(cj_efectivo,0)),
                    sum(isnull(cj_cheque,0)),
                    sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                    sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where cj_producto = 'CTE'
                      and cj_transaccion  = convert(int,b.codigo)
                      and a.tabla = 'sv_trx_nor'
                      and a.codigo = b.tabla
                      and estado = 'V'
                      and cj_operador = @i_usuario
                      and cj_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                      select ' ',
                      ' ',
                      'TOTALES OFICINA ',
                      sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,   --cj_ndcc
                      sum(isnull(cj_efectivo,0)),
                      sum(isnull(cj_cheque,0)),
                      sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                      sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' '
                      from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                      where cj_oficina = @i_oficina
                        and cj_producto = 'CTE'
                        and cj_transaccion  = convert(int,b.codigo)
                        and a.tabla = 'sv_trx_nor'
                        and a.codigo = b.tabla
                        and estado = 'V'
                        and cj_operador = @i_usuario
                        and cj_causa = convert(varchar,@i_empresa)
                  end


          select @w_fech_ult_labo = max(hc_fecha)
          from cob_remesas..re_his_caja

            if @i_oficina is null and @i_usuario is null --REF 63
            begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO',
              sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
              sum(isnull(hc_efectivo,0)),
              sum(isnull(hc_cheque,0)),
              sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
              sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
              where hc_producto = 'CTE'
              and hc_transaccion = convert(int,b.codigo)
              and a.tabla = 'sv_trx_dif'
              and a.codigo = b.tabla
              and estado = 'V'
              and hc_fecha = @w_fech_ult_labo
              and hc_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO',
                  sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                  sum(isnull(hc_efectivo,0)),
                  sum(isnull(hc_cheque,0)),
                  sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                  sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where hc_oficina = @i_oficina
                  and hc_producto = 'CTE'
                  and hc_transaccion = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_dif'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and hc_fecha = @w_fech_ult_labo
                  and hc_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO',
                  sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                  sum(isnull(hc_efectivo,0)),
                  sum(isnull(hc_cheque,0)),
                  sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                  sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where hc_producto = 'CTE'
                  and hc_transaccion = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_dif'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and hc_operador = @i_usuario
                  and hc_fecha = @w_fech_ult_labo
                  and hc_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA DIFERIDO',
                    sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                    sum(isnull(hc_efectivo,0)),
                    sum(isnull(hc_cheque,0)),
                    sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                    sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where hc_oficina = @i_oficina
                    and hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_operador = @i_usuario
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
                 end

        end -- if @i_empresa  = 3

        /* --> DGA 03/ENE/2006  SOLO PARA MUNICIPIO DE QUITO */
        if @i_empresa = 1417
        begin
            if @i_oficina is null and @i_usuario is null --REF 63
            begin
              select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  ' ',
                  ' ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_producto = 'CTE'
                  and cj_transaccion  = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_nor'
                  and a.codigo = b.tabla
                  and estado = 'V'
                  and cj_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                select ' ',
                ' ',
                'TOTALES OFICINA ',
                ' ',
                ' ',
                sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                sum(isnull(cj_efectivo,0)),
                sum(isnull(cj_cheque,0)),
                sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where cj_oficina = @i_oficina
                and cj_producto = 'CTE'
                and cj_transaccion  = convert(int,b.codigo)
                and a.tabla = 'sv_trx_nor'
                and a.codigo = b.tabla
                and estado = 'V'
                and cj_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                  select ' ',
                  ' ',
                     'TOTALES OFICINA ',
                  ' ',
                  ' ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where  cj_producto = 'CTE'
                  and cj_transaccion  = convert(int,b.codigo)
                  and a.tabla = 'sv_trx_nor'
                  and a.codigo = b.tabla
                  and cj_operador = @i_usuario
                  and estado = 'V'
                  and cj_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    ' ',
                    ' ',
                    sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                    sum(isnull(cj_efectivo,0)),
                    sum(isnull(cj_cheque,0)),
                    sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                    sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where cj_oficina = @i_oficina
                    and cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_operador = @i_usuario
                    and cj_causa = convert(varchar,@i_empresa)
                  end


          select @w_fech_ult_labo = max(hc_fecha)
          from cob_remesas..re_his_caja

          if @i_oficina is null and @i_usuario is null --REF 63
          begin
               select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO',
                ' ',
                ' ',
                sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                sum(isnull(hc_efectivo,0)),
                sum(isnull(hc_cheque,0)),
                sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where hc_producto = 'CTE'
                and hc_transaccion = convert(int,b.codigo)
                and a.tabla = 'sv_trx_dif'
                and a.codigo = b.tabla
                and estado = 'V'
                and hc_fecha = @w_fech_ult_labo
                and hc_causa = convert(varchar,@i_empresa)
          end
          else
            if @i_usuario is null --REF 63
            begin
                select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO',
                ' ',
                ' ',
                sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                sum(isnull(hc_efectivo,0)),
                sum(isnull(hc_cheque,0)),
                sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where hc_oficina = @i_oficina
                and hc_producto = 'CTE'
                and hc_transaccion = convert(int,b.codigo)
                and a.tabla = 'sv_trx_dif'
                and a.codigo = b.tabla
                and estado = 'V'
                and hc_fecha = @w_fech_ult_labo
                and hc_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_oficina is null --REF 63
              begin
                select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO',
                ' ',
                ' ',
                sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                sum(isnull(hc_efectivo,0)),
                sum(isnull(hc_cheque,0)),
                sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                where hc_producto = 'CTE'
                and hc_transaccion = convert(int,b.codigo)
                and a.tabla = 'sv_trx_dif'
                and a.codigo = b.tabla
                and estado = 'V'
                and hc_operador = @i_usuario
                and hc_fecha = @w_fech_ult_labo
                and hc_causa = convert(varchar,@i_empresa)
              end
              else --REF 63
                begin
                  select ' ',
                    ' ',
                    'TOTALES OFICINA DIFERIDO',
                    ' ',
                    ' ',
                    sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                    sum(isnull(hc_efectivo,0)),
                    sum(isnull(hc_cheque,0)),
                    sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                    sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where hc_oficina = @i_oficina
                    and hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_operador = @i_usuario
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
                end

        end -- if @i_empresa = 1417
        /* <-- DGA 03/ENE/2006  */


            -->Totales de la Empresa CORPEI
       if @i_empresa in (219, 222)
       begin

            --TOTALES DEL HORARIO NORMAL

            if @i_oficina is null --REF 63
            begin
               select ' ',
                        ' ',
                        'TOTALES OFICINA ',
                        ' ',
                        ' ',
                        sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
                        sum(isnull(ts_saldo,0)),
                        sum(isnull(ts_valor,0)),
                        sum(isnull(ts_monto,0)),
                        ' ',
                        ' ',
                        ' ',
                        ' ',
                        ' ',
                        ' ',
                        ' ',
                        ' '
                        from cob_cuentas..cc_tran_servicio a --REF 63
                        where ts_tipo_transaccion  in (3967)
                        and (ts_usuario = @i_usuario or @i_usuario = null)
                        and ts_causa = convert(varchar,@i_empresa)
                                  and ts_correccion = 'N'
                                  and  not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                            where ts_tipo_transaccion in (3967) and ts_causa = convert(varchar,@i_empresa)
                                                            and ts_correccion = 'S'
                                                            and a.ts_secuencial = ts_ssn_corr) --REF 63
            end
            else
              begin
                  select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    ' ',
                    ' ',
                    sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
                    sum(isnull(ts_saldo,0)),
                    sum(isnull(ts_valor,0)),
                    sum(isnull(ts_monto,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_cuentas..cc_tran_servicio a --REF 63
                    where ts_tipo_transaccion  in (3967)
                    and ts_oficina = @i_oficina
                    and (ts_usuario = @i_usuario or @i_usuario = null)
                    and ts_causa = convert(varchar,@i_empresa)
                              and ts_correccion = 'N'
                              and  not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                        where ts_tipo_transaccion in (3967) and ts_causa = convert(varchar,@i_empresa)
                                                        and ts_correccion = 'S'
                                                        and a.ts_secuencial = ts_ssn_corr) --REF 63
              end



           --TOTALES DEL HORARIO DIFERIDO
            if @i_oficina is null  --REF 63
            begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO ',
              ' ',
              ' ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a --REF 63
              where ts_tipo_transaccion  in (3334)
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = convert(varchar,@i_empresa)
              and ts_correccion = 'N'
                        and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                  where ts_tipo_transaccion in (3334) and ts_causa = convert(varchar,@i_empresa)
                                                  and ts_correccion = 'S'
                                                  and a.ts_secuencial = ts_ssn_corr) --REF 63
            end
            else
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO ',
                  ' ',
                  ' ',
                  sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
                  sum(isnull(ts_saldo,0)),
                  sum(isnull(ts_valor,0)),
                  sum(isnull(ts_monto,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_cuentas..cc_tran_servicio a --REF 63
                  where ts_tipo_transaccion  in (3334)
                  and ts_oficina = @i_oficina
                  and (ts_usuario = @i_usuario or @i_usuario = null)
                  and ts_causa = convert(varchar,@i_empresa)
                  and ts_correccion = 'N'
                    and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                              where ts_tipo_transaccion in (3334) and ts_causa = convert(varchar,@i_empresa)
                                              and ts_correccion = 'S'
                                              and a.ts_secuencial = ts_ssn_corr) --REF 63
              end
       end ---if @i_empresa in (219, 222)
            --<Totales de la Empresa CORPEI

            -->Totales de la Empresa CATEG    CATEG(TOTALES-Pestaña Destalles en TSERVI) 27-marzo-2008
      if @i_empresa = 1
      begin
            --TOTALES DEL HORARIO NORMAL
            --smerino aumenta ts_contratado
          if @i_oficina is null  --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA ',
              sum(isnull(ts_contratado,0))+ sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
              sum(isnull(ts_valor,0)) +  sum(isnull(ts_contratado,0)) ,
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a --REF 63
              where ts_tipo_transaccion  in (3173, 3916)
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = convert(varchar,@i_empresa)
                      and ts_correccion = 'N'
                      and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                where ts_tipo_transaccion in (3173, 3916) and ts_causa = convert(varchar,@i_empresa)
                                                and ts_correccion = 'S'
                                                and a.ts_secuencial = ts_ssn_corr) --REF 6
          end
          else
          begin
            select ' ',
              ' ',
              'TOTALES OFICINA ',
              sum(isnull(ts_contratado,0))+ sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
              sum(isnull(ts_valor,0)) +  sum(isnull(ts_contratado,0)) ,
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a --REF 63
              where ts_tipo_transaccion  in (3173, 3916)
              and ts_oficina = @i_oficina
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = convert(varchar,@i_empresa)
                      and ts_correccion = 'N'
                      and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                where ts_tipo_transaccion in (3173, 3916) and ts_causa = convert(varchar,@i_empresa)
                                                and ts_correccion = 'S'
                                                and a.ts_secuencial = ts_ssn_corr) --REF 6
          end

                    --TOTALES DEL HORARIO DIFERIDO
          if @i_oficina is null  --REF 63
          begin
                select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO ',
                sum(isnull(ts_contratado,0)) + sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
                sum(isnull(ts_valor,0)) + sum(isnull(ts_contratado,0)),
                sum(isnull(ts_saldo,0)),
                sum(isnull(ts_monto,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_cuentas..cc_tran_servicio a --REF 63
                where ts_tipo_transaccion  in (3202, 3917, 3919)
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and ts_causa = convert(varchar,@i_empresa)
                and ts_correccion = 'N'
                          and not exists (select 1 from cob_cuentas..cc_tran_servicio --REF 63
                                                    where ts_tipo_transaccion in (3202, 3917, 3919) and ts_causa = convert(varchar,@i_empresa)
                                                    and ts_correccion = 'S'
                                                    and a.ts_secuencial = ts_ssn_corr) --REF 63
          end
          else
          begin
              select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO ',
                sum(isnull(ts_contratado,0)) + sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)),
                sum(isnull(ts_valor,0)) + sum(isnull(ts_contratado,0)),
                sum(isnull(ts_saldo,0)),
                sum(isnull(ts_monto,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_cuentas..cc_tran_servicio a --REF 63
                where ts_tipo_transaccion  in (3202, 3917, 3919)
                and ts_oficina = @i_oficina
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and ts_causa = convert(varchar,@i_empresa)
                and ts_correccion = 'N'
                          and not exists (select 1 from cob_cuentas..cc_tran_servicio --REF 63
                                                    where ts_tipo_transaccion in (3202, 3917, 3919) and ts_causa = convert(varchar,@i_empresa)
                                                    and ts_correccion = 'S'
                                                    and a.ts_secuencial = ts_ssn_corr) --REF 63
          end
      end --if @i_empresa = 1
      --<Totales de la Empresa CATEG 27-marzo-2008

            -->Municipio de Ibarra lfcm 18-diciembre-2007
      if @i_empresa in (2234, 2319, 2237, 2235, 2236,1430,7749) --Ref085:msilvag /* Wise - 05/sep/2008 - M. Libertad = 2236 */--DAPV 18/08/2011 M. Daule = 1430
      begin

        --TOTALES DEL HORARIO NORMAL
        if @i_oficina is null  --REF 63
        begin
              select ' ',
              ' ',
              'TOTALES OFICINA ',
              ' ',
              ' ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_contratado,0)) + sum(isnull(convert(money,ts_autoriz_aut),0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              sum(isnull(ts_contratado,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              sum(isnull(convert(money,ts_autoriz_aut),0)),
                      sum(isnull(convert(money,isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) ),0)),
              ' '
              from cob_cuentas..cc_tran_servicio a --REF 63
              where ts_tipo_transaccion  in (3215)
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = convert(varchar,@i_empresa)
              and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                            where ts_tipo_transaccion in (3215) and ts_causa = convert(varchar,@i_empresa)
                            and ts_correccion = 'S'
                            and a.ts_secuencial = ts_ssn_corr --REF 63
                            )
                      and ts_correccion = 'N'
        end
        else
          begin
              select ' ',
                ' ',
                'TOTALES OFICINA ',
                ' ',
                ' ',
                sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_contratado,0)) + sum(isnull(convert(money,ts_autoriz_aut),0)),
                sum(isnull(ts_valor,0)),
                sum(isnull(ts_saldo,0)),
                sum(isnull(ts_monto,0)),
                sum(isnull(ts_contratado,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                sum(isnull(convert(money,ts_autoriz_aut),0)),
                        sum(isnull(convert(money,isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) ),0)),
                ' '
                from cob_cuentas..cc_tran_servicio a --REF 63
                where ts_tipo_transaccion  in (3215)
                and ts_oficina = @i_oficina
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and ts_causa = convert(varchar,@i_empresa)
                and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                            where ts_tipo_transaccion in (3215) and ts_causa = convert(varchar,@i_empresa)
                            and ts_correccion = 'S'
                            and a.ts_secuencial = ts_ssn_corr --REF 63
                            )
                      and ts_correccion = 'N'
          end



        --TOTALES DEL HORARIO DIFERIDO
        if @i_oficina is null  --REF 63
        begin
            select ' ',
            ' ',
            'TOTALES OFICINA DIFERIDO ',
            ' ',
            ' ',
            sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_contratado,0)) + sum(isnull(convert(money,ts_autoriz_aut),0)),
            sum(isnull(ts_valor,0)),
            sum(isnull(ts_saldo,0)),
            sum(isnull(ts_monto,0)),
            sum(isnull(ts_contratado,0)),
            ' ',
            ' ',
            ' ',
            ' ',
            sum(isnull(convert(money,ts_autoriz_aut),0)),
                    sum(isnull(convert(money,isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) ),0)),
            ' '
            from cob_cuentas..cc_tran_servicio a --REF 63
            where ts_tipo_transaccion  in (3221,4112)
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and ts_causa = convert(varchar,@i_empresa)
            and ts_correccion = 'N'
            and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                          where ts_tipo_transaccion in (3221,4112) and ts_causa = convert(varchar,@i_empresa)
                          and ts_correccion = 'S'
                          and a.ts_secuencial = ts_ssn_corr  --REF 63
                          )
        end
        else
        begin
            select ' ',
            ' ',
            'TOTALES OFICINA DIFERIDO ',
            ' ',
            ' ',
            sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_contratado,0)) + sum(isnull(convert(money,ts_autoriz_aut),0)),
            sum(isnull(ts_valor,0)),
            sum(isnull(ts_saldo,0)),
            sum(isnull(ts_monto,0)),
            sum(isnull(ts_contratado,0)),
            ' ',
            ' ',
            ' ',
            ' ',
            sum(isnull(convert(money,ts_autoriz_aut),0)),
                    sum(isnull(convert(money,isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) ),0)),
            ' '
            from cob_cuentas..cc_tran_servicio a --REF 63
            where ts_tipo_transaccion  in (3221,4112)
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and ts_causa = convert(varchar,@i_empresa)
            and ts_correccion = 'N'
            and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                          where ts_tipo_transaccion in (3221,4112) and ts_causa = convert(varchar,@i_empresa)
                          and ts_correccion = 'S'
                          and a.ts_secuencial = ts_ssn_corr  --REF 63
                          )
        end



      end -- if @i_empresa in (2234, 231


    --Grupo TvCable SMERINO NEW TVCABLE
    --SMERINO NEW TVCABLE
    if @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo
                        where tabla in (select codigo from cobis..cl_tabla
                         where tabla = 'sv_tvcable_online')
                      and valor = 'S')
        begin

            if @i_oficina is null and @i_usuario is null --REF 63
            begin
                select ' ',
                  ' ',
                  'TOTALES OFICINA ',
                  ' ',
                  ' ',
                  sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                  sum(isnull(cj_efectivo,0)),
                  sum(isnull(cj_cheque,0)),
                  sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                  sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where cj_producto = 'CTE'
                    and cj_transaccion  = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_nor'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and cj_causa = convert(varchar,@i_empresa)   -- lfcm 12-enero-2007
            end
            else
              if @i_usuario is null --REF 63
              begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    ' ',
                    ' ',
                    sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                    sum(isnull(cj_efectivo,0)),
                    sum(isnull(cj_cheque,0)),
                    sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                    sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where cj_oficina = @i_oficina
                      and cj_producto = 'CTE'
                      and cj_transaccion  = convert(int,b.codigo)
                      and a.tabla = 'sv_trx_nor'
                      and a.codigo = b.tabla
                      and estado = 'V'
                      and cj_causa = convert(varchar,@i_empresa)   -- lfcm 12-enero-2007
              end
              else
                if @i_oficina is null --REF 63
                begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA ',
                    ' ',
                    ' ',
                    sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                    sum(isnull(cj_efectivo,0)),
                    sum(isnull(cj_cheque,0)),
                    sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                    sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where cj_producto = 'CTE'
                      and cj_transaccion  = convert(int,b.codigo)
                      and a.tabla = 'sv_trx_nor'
                      and a.codigo = b.tabla
                      and estado = 'V'
                      and cj_operador = @i_usuario
                      and cj_causa = convert(varchar,@i_empresa)   -- lfcm 12-enero-2007
                end
                else --REF 63
                  begin
                      select ' ',
                      ' ',
                      'TOTALES OFICINA ',
                      ' ',
                      ' ',
                      sum(isnull(cj_efectivo,0)) + sum(isnull(cj_cheque,0)) + sum(isnull(cj_chq_locales,0))+ sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)) + sum(isnull(cj_retencion,0))+ sum(isnull(cj_otros,0)) ,
                      sum(isnull(cj_efectivo,0)),
                      sum(isnull(cj_cheque,0)),
                      sum(isnull(cj_ndah,0) + isnull(cj_ndcc,0)+isnull(cj_chq_locales,0)),
                      sum(isnull(cj_retencion,0)+isnull(cj_otros,0)),
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' '
                      from cob_remesas..re_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                      where cj_oficina = @i_oficina
                        and cj_producto = 'CTE'
                        and cj_transaccion  = convert(int,b.codigo)
                        and a.tabla = 'sv_trx_nor'
                        and a.codigo = b.tabla
                        and estado = 'V'
                        and cj_operador = @i_usuario
                        and cj_causa = convert(varchar,@i_empresa)   -- lfcm 12-enero-2007
                  end

          select @w_fech_ult_labo = max(hc_fecha)
          from cob_remesas..re_his_caja

            if @i_oficina is null and @i_usuario is null --REF 63
            begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO',
                  ' ',
                  ' ',
                  sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                  sum(isnull(hc_efectivo,0)),
                  sum(isnull(hc_cheque,0)),
                  sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                  sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
            end
            else
              if @i_usuario is null --REF 63
              begin
                  select ' ',
                  ' ',
                  'TOTALES OFICINA DIFERIDO',
                  ' ',
                  ' ',
                  sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                  sum(isnull(hc_efectivo,0)),
                  sum(isnull(hc_cheque,0)),
                  sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                  sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' ',
                  ' '
                  from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                  where hc_oficina = @i_oficina
                    and hc_producto = 'CTE'
                    and hc_transaccion = convert(int,b.codigo)
                    and a.tabla = 'sv_trx_dif'
                    and a.codigo = b.tabla
                    and estado = 'V'
                    and hc_fecha = @w_fech_ult_labo
                    and hc_causa = convert(varchar,@i_empresa)
              end
              else
                if @i_oficina is null --REF 63
                begin
                    select ' ',
                    ' ',
                    'TOTALES OFICINA DIFERIDO',
                    ' ',
                    ' ',
                    sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                    sum(isnull(hc_efectivo,0)),
                    sum(isnull(hc_cheque,0)),
                    sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                    sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' ',
                    ' '
                    from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                    where hc_producto = 'CTE'
                      and hc_transaccion = convert(int,b.codigo)
                      and a.tabla = 'sv_trx_dif'
                      and a.codigo = b.tabla
                      and estado = 'V'
                      and hc_operador = @i_usuario
                      and hc_fecha = @w_fech_ult_labo
                      and hc_causa = convert(varchar,@i_empresa)
                end
                else --REF 63
                  begin
                      select ' ',
                      ' ',
                      'TOTALES OFICINA DIFERIDO',
                      ' ',
                      ' ',
                      sum(isnull(hc_efectivo,0)) + sum(isnull(hc_cheque,0)) + sum(isnull(hc_chq_locales,0))+ sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)) + sum(isnull(hc_retencion,0))+ sum(isnull(hc_otros,0)),
                      sum(isnull(hc_efectivo,0)),
                      sum(isnull(hc_cheque,0)),
                      sum(isnull(hc_ndah,0) + isnull(hc_ndcc,0)+ isnull(hc_chq_locales,0)),
                      sum(isnull(hc_retencion,0)+isnull(hc_otros,0)),
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' ',
                      ' '
                      from cob_remesas..re_his_caja, cobis..cl_tabla a, cobis..cl_catalogo b
                      where hc_oficina = @i_oficina
                        and hc_producto = 'CTE'
                        and hc_transaccion = convert(int,b.codigo)
                        and a.tabla = 'sv_trx_dif'
                        and a.codigo = b.tabla
                        and estado = 'V'
                        and hc_operador = @i_usuario
                        and hc_fecha = @w_fech_ult_labo
                        and hc_causa = convert(varchar,@i_empresa)
                  end

        end
        /*<--lfcm 12-enero-2007 (Fin) Solo para los totales de Grupo TvCable*/

------REF49

if @i_empresa = 120  --DIRECTV
begin
  select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso

  if @i_usuario = ""
    select @i_usuario = null

          if @i_oficina is null --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA 120 ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_descuento_iess,0)) + sum(isnull(ts_contratado, 0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a  --REF 63
              where ts_tipo_transaccion  in (3925,3926)
              and ts_tsfecha = @w_fecha_pro
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = '120'
                        and ts_correccion = 'N'
                        and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                  where ts_tipo_transaccion in (3925,3926)
                                                  and ts_tsfecha = @w_fecha_pro
                                                  and ts_causa = '120'
                                                  and ts_correccion = 'S'
                                                  and a.ts_secuencial = ts_ssn_corr) --REF 63
          end
          else
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA 120 ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_descuento_iess,0)) + sum(isnull(ts_contratado, 0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a  --REF 63
              where ts_tipo_transaccion  in (3925,3926)
              and ts_tsfecha = @w_fecha_pro
              and ts_oficina = @i_oficina
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = '120'
                        and ts_correccion = 'N'
                        and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                  where ts_tipo_transaccion in (3925,3926)
                                                  and ts_tsfecha = @w_fecha_pro
                                                  and ts_causa = '120'
                                                  and ts_correccion = 'S'
                                                  and a.ts_secuencial = ts_ssn_corr) --REF 63
          end

          --TOTALES DEL HORARIO DIFERIDO
          if @i_oficina is null --REF 63
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO 120 ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_descuento_iess,0)) + sum(isnull(ts_contratado, 0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a  --REF 63
              where ts_tipo_transaccion  in (3928,3926)
              and ts_tsfecha = @w_fecha_pro
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = '120'
              and ts_correccion = 'N'
              and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                                  where ts_tipo_transaccion in (3928)
                                                  and ts_tsfecha = @w_fecha_pro
                                                  and ts_causa = '120'
                                                  and ts_correccion = 'S'
                                                  and a.ts_secuencial = ts_ssn_corr) --REF 63
          end
          else
          begin
              select ' ',
              ' ',
              'TOTALES OFICINA DIFERIDO 120 ',
              sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_descuento_iess,0)) + sum(isnull(ts_contratado, 0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a  --REF 63
              where ts_tipo_transaccion  in (3928)
                                                       and ts_tsfecha = @w_fecha_pro
              and ts_oficina = @i_oficina
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = '120'
              and ts_correccion = 'N'
              and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                              where ts_tipo_transaccion in (3928)
                                              and ts_tsfecha = @w_fecha_pro
                                              and ts_causa = '120'
                                              and ts_correccion = 'S'
                                              and a.ts_secuencial = ts_ssn_corr) --REF 63
          end

 end  --if @i_empresa = 120

------REF49

    -- ref: 54
    if @i_empresa in (451 ,7256) --MARGLOBAL
    begin

        select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
       
        if @i_usuario = ""
            select @i_usuario = null

        if @i_oficina is null --REF 63
        begin
            select ' ',
            ' ',
            'TOTALES OFICINA 451 ',
                                        sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_contratado, 0)),
            sum(isnull(ts_valor,0)),
            sum(isnull(ts_saldo,0)),
            sum(isnull(ts_monto,0)),
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' '
            from cob_cuentas..cc_tran_servicio a --REF 63
            where ts_tipo_transaccion  in (3925,3926)
              and ts_tsfecha = @w_fecha_pro
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and ts_causa = convert(varchar,@i_empresa)
              and ts_correccion = 'N'
              and not exists (select 1 from cob_cuentas..cc_tran_servicio --REF 63
                                              where ts_tipo_transaccion in (3925,3926)
                                              and ts_tsfecha = @w_fecha_pro
                                              and ts_causa = convert(varchar,@i_empresa)
                                              and ts_correccion = 'S'
                                              and a.ts_secuencial = ts_ssn_corr) --REF 63
        end
      else
        begin
              select ' ',
              ' ',
              'TOTALES OFICINA 451 ',
                                          sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) +  sum(isnull(ts_contratado, 0)),
              sum(isnull(ts_valor,0)),
              sum(isnull(ts_saldo,0)),
              sum(isnull(ts_monto,0)),
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' ',
              ' '
              from cob_cuentas..cc_tran_servicio a --REF 63
              where ts_tipo_transaccion  in (3925,3926)
                and ts_tsfecha = @w_fecha_pro
                and ts_oficina = @i_oficina
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and ts_causa = convert(varchar,@i_empresa) -- '451' smerino belcorp
                and ts_correccion = 'N'
                and not exists (select 1 from cob_cuentas..cc_tran_servicio --REF 63
                                          where ts_tipo_transaccion in (3925,3926)
                                          and ts_tsfecha = @w_fecha_pro
                                          and ts_causa = convert(varchar,@i_empresa) -- '451' smerino belcorp
                                          and ts_correccion = 'S'
                                          and a.ts_secuencial = ts_ssn_corr) --REF 63
        end
        --TOTALES DEL HORARIO DIFERIDO
        if @i_oficina is null --REF 63
        begin
            select ' ',
            ' ',
            'TOTALES OFICINA DIFERIDO 451 ',
            sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) + sum(isnull(ts_contratado, 0)),
            sum(isnull(ts_valor,0)),
            sum(isnull(ts_saldo,0)),
            sum(isnull(ts_monto,0)),
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' ',
            ' '
            from cob_cuentas..cc_tran_servicio a --REF 63
            where ts_tipo_transaccion  in (3928)
            and ts_tsfecha = @w_fecha_pro
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and ts_causa = convert(varchar,@i_empresa)  ---smerino belcorp
            and ts_correccion = 'N'
            and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                          where ts_tipo_transaccion in (3928)
                                          and ts_tsfecha = @w_fecha_pro
                                          and ts_causa = convert(varchar,@i_empresa)  ---smerino belcorp
                                          and ts_correccion = 'S'
                                          and a.ts_secuencial = ts_ssn_corr) --REF 63
       end
       else
        begin
            select ' ',
                ' ',
                'TOTALES OFICINA DIFERIDO 451 ',
                sum(isnull(ts_saldo,0)) + sum(isnull(ts_valor,0)) + sum(isnull(ts_monto,0)) + sum(isnull(ts_ocasional,0)) + sum(isnull(ts_contratado, 0)),
                sum(isnull(ts_valor,0)),
                sum(isnull(ts_saldo,0)),
                sum(isnull(ts_monto,0)),
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' ',
                ' '
                from cob_cuentas..cc_tran_servicio a --REF 63
                where ts_tipo_transaccion  in (3928)
                and ts_tsfecha = @w_fecha_pro
                and ts_oficina = @i_oficina
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and ts_causa = convert(varchar,@i_empresa)
                and ts_correccion = 'N'
                and not exists (select 1 from cob_cuentas..cc_tran_servicio  --REF 63
                                          where ts_tipo_transaccion in (3928)
                                          and ts_tsfecha = @w_fecha_pro
                                          and ts_causa = convert(varchar,@i_empresa)
                                          and ts_correccion = 'S'
                                          and a.ts_secuencial = ts_ssn_corr) --REF 63
        end

   end --MARGLOBAL


    return 0
end
     if @i_empresa = 4994 --ref55: DAPV/CNEL
      begin
         set rowcount 20
         select
            'CODIGO'           = ts_referencia,               --numero de celular
            'REGIONAL'         = ts_causa,
            'SUCURSAL'         = convert(varchar(4),ts_oficina),
            'VALOR'            = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
            'FEC_CBLE'         = ts_tsfecha,                                     --Fecha contable
            'FEC_PROCESO'      = ts_tsfecha,                                     --Fecha proceso
            'USUARIO'          = ts_usuario,
            'NOMBRE'     = ts_nombre,
            'TIP_TRX'    = ts_tipo_transaccion  ,
            'CTA_BCO'    = ts_cta_banco ,
            'MONTO_CTA'  = ts_monto,
            'CEDULA'     = ts_campo_alt_dos,
            'SECUENCI'= ts_secuencial
        from cob_cuentas..cc_tran_servicio a --REF 63
        where ts_tipo_transaccion  in (select convert(int,b.codigo)
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_propietario = convert(varchar,@i_empresa)
        and ts_correccion = 'N'
        and ts_tsfecha = @w_fecha_pro
        and not exists (select 1  --REF 63
                               from cob_cuentas..cc_tran_servicio
                               where ts_tipo_transaccion in (select convert(int,b.codigo)
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
                               and ts_propietario = convert(varchar,@i_empresa)
                               and ts_correccion = 'S'
                               and a.ts_secuencial = ts_ssn_corr  --REF 63
                               and ts_tsfecha = @w_fecha_pro)
        and (ts_secuencial > @i_codigo)
        order by ts_secuencial

          if @@rowcount = 20
            select @o_mas_mov = 'S'
          else
             select @o_mas_mov = 'N'

       set rowcount 0
      end
      
      -- Ref.71 CS -->
      --if @i_empresa in (144) --ref79  empresa considerada en catálogo MEER
      if @i_empresa in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
      begin
        set rowcount 20
        select 'CODIGO'           = ts_cta_asociada, -- ts_referencia  --numero de celular -- ref87
               'SUCURSAL'         = convert(varchar(4),ts_oficina),
               'VALOR'            = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
               'FEC_CBLE'         = ts_tsfecha,                                     --Fecha contable
               'FEC_PROCESO'      = ts_tsfecha,                                     --Fecha proceso
               'USUARIO'          = ts_usuario,
               'NOMBRE'     = ts_nombre,
               'TIP_TRX'    = ts_tipo_transaccion  ,
               'CTA_BCO'    = ts_cta_banco ,
               'MONTO_CTA'  = ts_monto,
               'CEDULA'     = ts_campo_alt_dos,
               'SECUENCI'= ts_secuencial
         from cob_cuentas..cc_tran_servicio a --REF 63
         where ts_tipo_transaccion  in (select convert(int,b.codigo)
                                         from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
           and ts_causa = convert(varchar,@i_empresa)
           and ts_correccion = 'N'
and ts_tsfecha = @w_fecha_pro
           and not exists (select 1  --REF 63
                            from cob_cuentas..cc_tran_servicio
                            where ts_tipo_transaccion in (select convert(int,b.codigo)
                                                           from cobis..cl_tabla a, cobis..cl_catalogo b
                                                           where a.tabla = 'sv_trx_nordif'
                                                             and a.codigo = b.tabla
                                                             and estado = 'V')
                              and ts_causa = convert(varchar,@i_empresa)
                              and ts_correccion = 'S'
                              and a.ts_secuencial = ts_ssn_corr  --REF 63
                              ---and ts_tsfecha = @w_fecha_pro
                              )
           and (ts_secuencial > @i_codigo)
         order by ts_secuencial
        if @@rowcount = 20
          select @o_mas_mov = 'S'
        else
          select @o_mas_mov = 'N'
        set rowcount 0
      end
      -- <-- Ref.71 CS

      --if @i_empresa in (825,1127,1719,1330,331,4981,4977,4978,4979,4980)--ref55: DAPV/CNEL
      if @i_empresa in (select pe_empresa from cob_pagos..pg_person_empresa
                        where pe_cod_grupo = 4994) ---CNEL/CATEG
      begin


         set rowcount 20
         select
            'CODIGO'           = ts_referencia,               --numero de celular
            'GRUPO'            = ts_propietario,
            'SUCURSAL'         = convert(varchar(4),ts_oficina),
            'VALOR'            = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
            'FEC_CBLE'         = ts_tsfecha,                                     --Fecha contable
            'FEC_PROCESO'      = ts_tsfecha,                                     --Fecha proceso
            'USUARIO'          = ts_usuario,
            'NOMBRE'     = ts_nombre,
            'TIP_TRX'    = ts_tipo_transaccion  ,
            'CTA_BCO'    = ts_cta_banco ,
            'MONTO_CTA'  = ts_monto,
            'CEDULA'     = ts_campo_alt_dos,
            'SECUENCI'= ts_secuencial
        from cob_cuentas..cc_tran_servicio a  --REF 63
        where ts_tipo_transaccion  in (select convert(int,b.codigo)
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_causa = convert(varchar,@i_empresa)
        and ts_correccion = 'N'
        and ts_tsfecha = @w_fecha_pro
        and not exists (select 1  --REF 63
                               from cob_cuentas..cc_tran_servicio
                               where ts_tipo_transaccion in (select convert(int,b.codigo)
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
                               and ts_causa = convert(varchar,@i_empresa)
                               and ts_correccion = 'S'
                               and a.ts_secuencial = ts_ssn_corr  --REF 63
                               and ts_tsfecha = @w_fecha_pro)
        and (ts_secuencial > @i_codigo)
        order by ts_secuencial

          if @@rowcount = 20
            select @o_mas_mov = 'S'
          else
             select @o_mas_mov = 'N'

       set rowcount 0
      end


      if @i_empresa = 39  --Ref #53: DAPV 22/Sept/2011 - 39 -Claro
      begin
        set rowcount 20
        select
        'codigo'           = ts_referencia,        --numero de celular
        'sucursal'         = convert(varchar(4),ts_oficina),
        'valor'            = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
        'fec_cble'         = ts_tsfecha,                                     --Fecha contable
        'fec_proceso'      = ts_tsfecha,                                     --Fecha proceso
        'sec_bco'          = ts_secuencial,           --secuencial del banco
        'sec_porta'        = ts_propietario,          --secuencial del Claro
        'fecha_trx_local'  = ts_corresponsal,                                     --Fecha Transaccion Local
        'hora_trx_local'   = substring(convert(varchar(8),ts_hora,108),1,2) +
                             substring(convert(varchar(8),ts_hora,108),4,2) +
                             substring(convert(varchar(8),ts_hora,108),7,2),      --Hora Transaccion Local
        'est_conciliacion' = "",                                                  --Estado Conciliacion
        'usuario'          = ts_usuario,
        'nombre'     = ts_nombre,
        'tip_trx'    = ts_tipo_transaccion  ,
        'cta_bco'    = ts_cta_banco ,
        'monto_cta'  = ts_monto,
        'cedula'     = ts_campo_alt_dos
        from cob_cuentas..cc_tran_servicio a  --REF 63
        where ts_tipo_transaccion  in (select convert(int,b.codigo)
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
        and ts_causa = '39'
        and ts_correccion = 'N'
        and not exists (select 1  --REF 63
                               from cob_cuentas..cc_tran_servicio
                               where ts_tipo_transaccion in (select convert(int,b.codigo)
                                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                                              where a.tabla = 'sv_trx_nordif'
                                                                and a.codigo = b.tabla
                                                                and estado = 'V')
                               and ts_causa = '39'
                               and ts_correccion = 'S'
                               and a.ts_secuencial = ts_ssn_corr)  --REF 63
        order by ts_secuencial

          if @@rowcount = 20
            select @o_mas_mov = 'S'
          else
              select @o_mas_mov = 'N'

       set rowcount 0
      end

      --MOSTRAR DETALLE DE LOS PAGOS.
      ---smerino aumenta campo ts_contratado isnull(ts_contratado,0),0)

      if @i_empresa not in (7749, 1417, 2234, 1719, 334, 335, 336, 337, 338, 843, 320, 1299, 1538,2494 ,3, 219, 222, 2319, 1, 2237, 2235, 2572,2575, 2236,120,1430,39,451,4994,38,8688,42,7256) --, 144) --Ref085:msilvag    --Ref80 pricaura -- Ref.71: 144 CS 'ref79 empresa144 considerado catalogo MEER
      and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo
                             where tabla in (select codigo from cobis..cl_tabla
                                             where tabla = 'sv_tvcable_online')
                             and valor = 'S')  --SMERINO NEW TVCABLE --DAPV/03142012/CNEL
      and  @i_empresa not in (select pe_empresa from cob_pagos..pg_person_empresa
          			 where pe_cod_grupo = 4994) --CNEL/CATEG
     and @w_grupo_emp not in (8466)
     and @i_empresa not in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')     
      begin
        set rowcount 20        
        if @i_oficina is null --REF 63
        begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                --'CODIGO  '= case @i_empresa when 1928 then ts_autorizante else substring(ts_referencia,1,datalength(ts_referencia)) end, --REF: 74  -- Ref.77 (antes)
                'CODIGO  '= case @w_grupo_emp when 8466 then ts_autorizante else substring(ts_referencia,1,datalength(ts_referencia)) end, --Ref: 77: validacion es por todo grupo contecom
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0),
                'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
                'CHEQUE  '= ts_saldo,
                'ND      '= (case @i_empresa                          --GAMC - 16/05/2008 - SOAT
                        when 862 then isnull(ts_monto,0) + isnull(ts_descuento_iess,0)
                        else isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0)
                        end),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= (case @i_empresa        -- REF 47
                        when 115 then isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)  -- REF 47
                        when 114 then isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0)  -- REF 48 smerino
                        when 1371 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) -- Ref061:msilvag
                        --Ref062:msilvag Inicio
                        when 360 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
                        when 4 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
                        when 6 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
						when 6087 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) -- Ref87
						when 1125 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) -- Ref90
                        --Ref062:msilvag Fin
                        else isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0) -- REF 47 smerino
                end)  -- REF 47
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                    on  ts_oficina = of_oficina --REF 63
                    left join cob_pagos..pg_control_usuario   --REF 63
                    on ts_causa = convert(varchar,cu_empresa) --REF 63
                    and ts_oficina = cu_oficina --REF 63
                    and ts_usuario = cu_usuario --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_endoso > @i_codigo)
               order by ts_hora, ts_endoso
         end
         else
         begin
            select
                'ESTADO  '= isnull(cu_estado,'N'),
                --'CODIGO  '= case @i_empresa when 1928 then ts_autorizante else substring(ts_referencia,1,datalength(ts_referencia)) end,  --REF: 74. Ref.77: antes
                'CODIGO  '= case @w_grupo_emp when 8466 then ts_autorizante else substring(ts_referencia,1,datalength(ts_referencia)) end,  --Ref.77: validacion es por todo grupo contecom
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0),
                'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
                'CHEQUE  '= ts_saldo,
                'ND      '= (case @i_empresa                          --GAMC - 16/05/2008 - SOAT
                        when 862 then isnull(ts_monto,0) + isnull(ts_descuento_iess,0)
                        else isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0)
                        end),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= (case @i_empresa        -- REF 47
                        when 115 then isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)  -- REF 47
                        when 114 then isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0)  -- REF 48 smerino
                        when 1371 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) -- Ref061:msilvag
                        when 360 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
                        when 4 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
                        when 6 then isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
                        else isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0) -- REF 47 smerino
                end)  -- REF 47
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                    on  ts_oficina = of_oficina --REF 63
                    left join cob_pagos..pg_control_usuario   --REF 63
                    on ts_causa = convert(varchar,cu_empresa) --REF 63
                    and ts_oficina = cu_oficina --REF 63
                    and ts_usuario = cu_usuario --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and ts_oficina = @i_oficina
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_endoso > @i_codigo)
               order by ts_hora, ts_endoso
         end

        if @@rowcount = 20
            select @o_mas_mov = 'S'
        else
           select @o_mas_mov = 'N'
        set rowcount 0
    end --if @i_empresa not in (1417

      if @w_grupo_emp = 8466
        begin 
        	set rowcount 20
        	select
                        'ESTADO  '= 'N',                      
                        'CODIGO  '=  ts_autorizante ,
                        'NOMBRE  '= substring(ts_nombre,1,30),
                        'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0),
                        'EFECTIVO'= isnull(ts_valor,0) ,
                        'CHEQUE  '= isnull(ts_saldo,0) ,
                        'ND      '= isnull(ts_monto,0) ,
                        'RETENC  '= ts_ocasional,
                        'CORREC  '= ts_correccion,
                        'USUARIO '= substring(ts_usuario,1,10),
                        'HORA    '= ts_hora,
                        'COMPROB '= ts_secuencial,
                        'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                        'TOTEMESA'=  isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0)                      
                       from cob_cuentas..cc_tran_servicio 
                       where (ts_tipo_transaccion in (select convert(int,b.codigo) 
                                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                                     where a.tabla = 'sv_trx_nordif'
                                                       and a.codigo = b.tabla
                                                       and estado = 'V'))
                         and ts_causa = convert(varchar,@i_empresa)                
                         and (ts_secuencial > @i_codigo)
                 order by ts_secuencial
                 
                 if @@rowcount = 20
  		   select @o_mas_mov = 'S'
  	       else
  		  select @o_mas_mov = 'N'
          	set rowcount 0
      end




      --if @i_empresa = 38  --Ref #54: DAPV
      if @i_empresa in (38,42,8688)  --Ref80 pricaura --REF 63
      begin
        set rowcount 20
        select
        'CODIGO'       = ts_referencia,
        'CTA_BCO'      = ts_cta_banco,
        'CEDULA'       = ts_campo_alt_dos,
        'NOMBRE'       = ts_nombre,
        'VALOR'        = (isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0)),
        'SUCURSAL'     = convert(varchar(4),ts_oficina),
        'FEC_PROCESO'  = ts_tsfecha,
        'USUARIO'      = ts_usuario,
        'TIP_TRX'      = ts_tipo_transaccion  ,
        'SEC_FILE'     = ts_endoso,
        'CANAL'        = isnull(ts_tipo_chequera,'DBA'),
        'SECUENCIAL'   = ts_secuencial
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion  in (3427,43545)	--Ref80 pricaura
        and ts_causa = convert(varchar,@i_empresa)
        and ts_correccion = 'N'
        and ts_tsfecha = @w_fecha_pro
        and (ts_secuencial > @i_codigo)
        order by ts_secuencial

          if @@rowcount = 20
            select @o_mas_mov = 'S'
          else
              select @o_mas_mov = 'N'

       set rowcount 0
      end

/* --> DGA 03/ENE/2006  SOLO PARA MUNICIPIO DE QUITO */
      if @i_empresa = 1417
      begin
        set rowcount 20
        if @i_oficina is null --REF 63
        begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'PRED/RUB'= ts_propietario,
                'AÑO     '= ts_stick_imp,
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0),
                'SECUENCI'= ts_secuencial
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                    on  ts_oficina = of_oficina  --REF 63
                    left join cob_pagos..pg_control_usuario --REF 63
                    on ts_causa = convert(varchar,cu_empresa) --REF 63
                    and ts_oficina = cu_oficina  --REF 63
                    and ts_usuario = cu_usuario  --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_secuencial > @i_codigo)
               order by ts_hora, ts_secuencial
       end
       else
        begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'PRED/RUB'= ts_propietario,
                'AÑO     '= ts_stick_imp,
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0),
                'SECUENCI'= ts_secuencial
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                    on  ts_oficina = of_oficina  --REF 63
                    left join cob_pagos..pg_control_usuario --REF 63
                    on ts_causa = convert(varchar,cu_empresa) --REF 63
                    and ts_oficina = cu_oficina  --REF 63
                    and ts_usuario = cu_usuario  --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
                 and ts_oficina = @i_oficina
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_secuencial > @i_codigo)
               order by ts_hora, ts_secuencial
       end


      if @@rowcount = 20
        select @o_mas_mov = 'S'
      else
         select @o_mas_mov = 'N'
      set rowcount 0
    end
/* <-- DGA 03/ENE/2006  */

	--Ref085:msilvag Inicio Municipio GYE - CEP
    if @i_empresa = 7749
    begin 
        --select @w_fecha_pro = '12/09/2015'
        set rowcount 20
        if @i_oficina is null
        begin
            select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0),
                'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ,
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_campo_alt_uno , --ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'SECUENCI'= ts_secuencial
            from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina 
                on  ts_oficina = of_oficina 
              left join cob_pagos..pg_control_usuario   
                on ts_causa = convert(varchar,cu_empresa) and ts_oficina = cu_oficina and ts_usuario = cu_usuario 
            where (ts_tipo_transaccion in (select convert(int,b.codigo) 
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V'))
            and ts_causa = convert(varchar,@i_empresa)
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro --Ref068:msilvag prueba
            order by ts_hora, ts_endoso
        end
        else
        begin
            select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+ isnull(ts_contratado,0),
                'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ,
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_campo_alt_uno , --ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'SECUENCI'= ts_secuencial
            from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina 
                on  ts_oficina = of_oficina 
              left join cob_pagos..pg_control_usuario   
                on ts_causa = convert(varchar,cu_empresa) and ts_oficina = cu_oficina and ts_usuario = cu_usuario
            where (ts_tipo_transaccion in (select convert(int,b.codigo) 
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V'))
            and ts_causa = convert(varchar,@i_empresa)
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro --Ref068:msilvag prueba
            order by ts_hora, ts_endoso
        end
    
        if @@rowcount = 20
            select @o_mas_mov = 'S'
        else
           select @o_mas_mov = 'N'
        
        set rowcount 0
    end
    --Ref085:msilvag Fin
    -->Municipio de Ibarra   lfcm 18-diciembre-2007
    if @i_empresa in (2234, 2319, 2237, 2235, 2236,1430) -- Wise - 05/sep/2008 - M. Libertad = 2236 --DAPV 18/08/2011 M. Daule = 1430
    begin
        set rowcount 20

        if @i_oficina is null --REF 63
        begin
              select
              'ESTADO  '= isnull(cu_estado,'N'),
              --GAMC - 26/02/2008 - Municipio de Samborondon
              'CODIGO  '= (case @i_empresa
                    when 2234 then substring(ts_referencia,1,datalength(ts_referencia))
                    when 2319 then substring(ts_descripcion_ec,1,datalength(ts_descripcion_ec))
                    when 2237 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --GAMC - 18/03/2008 - Municipio de Salinas
                    when 2235 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --GAMC - 23/04/2008 - Municipio de Santa Elena
                    when 2236 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) /* Wise - 05/sep/2008 - M. Libertad = 2236 */
                    when 1430 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --DAPV 18/08/2011 M. Daule = 1430
                    end),

              'NOMBRE  '= substring(ts_nombre,1,30),
              'PRED/RUB'= ts_propietario,
              'AÑO     '= ts_stick_imp,
              'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_autoriz_aut),0),
              'EFECTIVO'= ts_valor,
              'CHEQUE  '= ts_saldo,
              'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
              'TARJETA '= isnull(ts_contratado,0),
              'CORREC  '= ts_correccion,
              'USUARIO '= substring(ts_usuario,1,10),
              'HORA    '= ts_hora,
              'COMPROB '= ts_endoso,
              'COM'     = isnull(convert(money,ts_autoriz_aut),0),
              'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
              'SECUENCI'= ts_secuencial
              from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                   on  ts_oficina = of_oficina --REF 63
                   left join cob_pagos..pg_control_usuario --REF 63
                   on ts_causa = convert(varchar,cu_empresa) --REF 63
                   and ts_oficina = cu_oficina  --REF 63
                   and ts_usuario = cu_usuario --REF 63
              where (ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                             and a.codigo = b.tabla
                                               and estado = 'V'))
              and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and (ts_secuencial > @i_codigo)
              order by ts_hora, ts_secuencial
        end
        else
          begin
              select
              'ESTADO  '= isnull(cu_estado,'N'),
              'CODIGO  '= (case @i_empresa
                    when 2234 then substring(ts_referencia,1,datalength(ts_referencia))
                    when 2319 then substring(ts_descripcion_ec,1,datalength(ts_descripcion_ec))
                    when 2237 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --GAMC - 18/03/2008 - Municipio de Salinas
                    when 2235 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --GAMC - 23/04/2008 - Municipio de Santa Elena
                    when 2236 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) /* Wise - 05/sep/2008 - M. Libertad = 2236 */
                    when 1430 then substring(ts_campo_alt_dos,1,datalength(ts_campo_alt_dos)) --DAPV 18/08/2011 M. Daule = 1430
                    end),
              'NOMBRE  '= substring(ts_nombre,1,30),
              'PRED/RUB'= ts_propietario,
              'AÑO     '= ts_stick_imp,
              'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_autoriz_aut),0),
              'EFECTIVO'= ts_valor,
              'CHEQUE  '= ts_saldo,
              'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
              'TARJETA '= isnull(ts_contratado,0),
              'CORREC  '= ts_correccion,
              'USUARIO '= substring(ts_usuario,1,10),
              'HORA    '= ts_hora,
              'COMPROB '= ts_endoso,
              'COM'     = isnull(convert(money,ts_autoriz_aut),0),
              'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
              'SECUENCI'= ts_secuencial
              from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                   on  ts_oficina = of_oficina --REF 63
                   left join cob_pagos..pg_control_usuario --REF 63
                   on ts_causa = convert(varchar,cu_empresa) --REF 63
                   and ts_oficina = cu_oficina  --REF 63
                   and ts_usuario = cu_usuario --REF 63
              where (ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                             and a.codigo = b.tabla
                                               and estado = 'V'))
              and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
              and ts_oficina = @i_oficina
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and (ts_secuencial > @i_codigo)
              order by ts_hora, ts_secuencial
          end


        if @@rowcount = 20
          select @o_mas_mov = 'S'
        else
            select @o_mas_mov = 'N'

       set rowcount 0
    end --if @i_empresa in (2234


    --<Municipio de Ibarra   lfcm 18-diciembre-2007

    --GAMC - 04/08/2008 - CTG
    if @i_empresa in (2572,2575)
  begin
    set rowcount 20
    if @i_oficina is null --REF 63
    begin
          select
          'ESTADO  '= isnull(cu_estado,'N'),
          'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
          'NOMBRE  '= substring(ts_descripcion_ec, 19,15),
          'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
          'EFECTIVO'= ts_valor,
          'CHEQUE  '= ts_saldo,
          'ND      '= isnull(ts_monto,0),
          'CREDITO '= isnull(ts_contratado, 0),
          'CORREC  '= ts_correccion,
          'USUARIO '= substring(ts_usuario,1,10),
          'HORA    '= ts_hora,
          'COMPROB '= ts_endoso,
          'COM'     = isnull(convert(money,ts_autoriz_aut),0), --Ref081:msilvag isnull(ts_aporte_iess,0),
          'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
          from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                 on  ts_oficina = of_oficina   --REF 63
                 left join cob_pagos..pg_control_usuario --REF 63
                 on ts_causa = convert(varchar,cu_empresa) --REF 63
                 and ts_oficina = cu_oficina   --REF 63
                 and ts_usuario = cu_usuario  --REF 63
          where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
              from cobis..cl_tabla a, cobis..cl_catalogo b
               where a.tabla = 'sv_trx_nordif'
               and a.codigo = b.tabla
               and estado = 'V'))
          and ts_causa = convert(varchar,@i_empresa)
          and (ts_usuario = @i_usuario or @i_usuario = null)
          and (ts_endoso > @i_codigo)
          order by ts_hora, ts_endoso
    end
    else
    begin
        select
          'ESTADO  '= isnull(cu_estado,'N'),
          'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
          'NOMBRE  '= substring(ts_descripcion_ec, 19,15),
          'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
          'EFECTIVO'= ts_valor,
          'CHEQUE  '= ts_saldo,
          'ND      '= isnull(ts_monto,0),
          'CREDITO '= isnull(ts_contratado, 0),
          'CORREC  '= ts_correccion,
          'USUARIO '= substring(ts_usuario,1,10),
          'HORA    '= ts_hora,
          'COMPROB '= ts_endoso,
          'COM'     = isnull(convert(money,ts_autoriz_aut),0) , --Ref081:msilvag isnull(ts_aporte_iess,0),
          'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
          from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                 on  ts_oficina = of_oficina   --REF 63
                 left join cob_pagos..pg_control_usuario --REF 63
                 on ts_causa = convert(varchar,cu_empresa) --REF 63
                 and ts_oficina = cu_oficina   --REF 63
                 and ts_usuario = cu_usuario  --REF 63
          where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
              from cobis..cl_tabla a, cobis..cl_catalogo b
               where a.tabla = 'sv_trx_nordif'
               and a.codigo = b.tabla
               and estado = 'V'))
          and ts_causa = convert(varchar,@i_empresa)
          and ts_oficina = @i_oficina
          and (ts_usuario = @i_usuario or @i_usuario = null)
          and (ts_endoso > @i_codigo)
          order by ts_hora, ts_endoso
    end


    if @@rowcount = 20
    select @o_mas_mov = 'S'
    else
    select @o_mas_mov = 'N'
    set rowcount 0
  end

      -->Consulta de Movimientos de las Empresas CORPEI
      if @i_empresa in (219, 222)
      begin
        set rowcount 20
        if @i_oficina is null --REF 63
        begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'PRED/RUB'= ts_propietario,
                'AÑO     '= ts_stick_imp,
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= '',
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= ' ',
                'SECUENCI'= ts_secuencial
                 from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                     on  ts_oficina = of_oficina  --REF 63
                     left join cob_pagos..pg_control_usuario  --REF 63
                     on ts_causa = convert(varchar,cu_empresa)  --REF 63
                     and ts_oficina = cu_oficina  --REF 63
                     and ts_usuario = cu_usuario  --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_secuencial > @i_codigo)
               order by ts_hora, ts_secuencial
       end
       else
       begin
               select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'PRED/RUB'= ts_propietario,
                'AÑO     '= ts_stick_imp,
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= '',
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= ' ',
                'SECUENCI'= ts_secuencial
                 from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                     on  ts_oficina = of_oficina  --REF 63
                     left join cob_pagos..pg_control_usuario  --REF 63
                     on ts_causa = convert(varchar,cu_empresa)  --REF 63
                     and ts_oficina = cu_oficina  --REF 63
                     and ts_usuario = cu_usuario  --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and ts_oficina = @i_oficina
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_secuencial > @i_codigo)
               order by ts_hora, ts_secuencial
       end

      if @@rowcount = 20
       select @o_mas_mov = 'S'
      else
         select @o_mas_mov = 'N'

      set rowcount 0
      end --if @i_empresa in (219, 222)

      --<Consulta de Movimientos de las Empresas CORPEI

     -->lfcm 22-feb-2008 CATEG(Pestaña Destalles en TSERVI)
     if @i_empresa = 1
     --smerino aumenta el campo ts_contratado
     begin

           select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008

           set rowcount 20
           if @i_oficina is null --REF 63
           begin
                   select
                     'ESTADO  '= isnull(cu_estado,'N'),
                     'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                     'NOMBRE  '= substring(ts_nombre,1,30),
                     'TOTAL   '= isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                     'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
                     'CHEQUE  '= ts_saldo,
                     'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
                     'RETENC  '= ts_ocasional,
                     'CORREC  '= ts_correccion,
                     'USUARIO '= substring(ts_usuario,1,10),
                     'HORA    '= ts_hora,
                     'COMPROB '= ts_endoso,
                     'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                     'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+isnull(ts_contratado,0) --smerino

                    from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                         on  ts_oficina = of_oficina  --REF 63
                         left join cob_pagos..pg_control_usuario --REF 63
                         on ts_causa = convert(varchar,cu_empresa) --REF 63
                         and ts_oficina = cu_oficina  --REF 63
                         and ts_usuario = cu_usuario --REF 63
                    where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                   from cobis..cl_tabla a, cobis..cl_catalogo b
                                                  where a.tabla = 'sv_trx_nordif'
                                                    and a.codigo = b.tabla
                                                    and estado = 'V'))
                      and ts_causa = convert(varchar,@i_empresa)
                      and (ts_usuario = @i_usuario or @i_usuario = null)
                      and (ts_endoso > @i_codigo)
                      and ts_fecha = @w_fecha_pro   --lfcm 22-mayo-2008
                    order by ts_hora, ts_endoso
           end
         else
          begin
             select
             'ESTADO  '= isnull(cu_estado,'N'),
             'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
             'NOMBRE  '= substring(ts_nombre,1,30),
             'TOTAL   '= isnull(ts_contratado,0)+isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
             'EFECTIVO'= ts_valor + isnull(ts_contratado,0),
             'CHEQUE  '= ts_saldo,
             'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
             'RETENC  '= ts_ocasional,
             'CORREC  '= ts_correccion,
             'USUARIO '= substring(ts_usuario,1,10),
             'HORA    '= ts_hora,
             'COMPROB '= ts_endoso,
             'COM'     = isnull(convert(money,ts_autoriz_aut),0),
             'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)+isnull(ts_contratado,0) --smerino
            from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                 on  ts_oficina = of_oficina  --REF 63
                 left join cob_pagos..pg_control_usuario --REF 63
                 on ts_causa = convert(varchar,cu_empresa) --REF 63
                 and ts_oficina = cu_oficina  --REF 63
                 and ts_usuario = cu_usuario --REF 63
            where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                           from cobis..cl_tabla a, cobis..cl_catalogo b
                                          where a.tabla = 'sv_trx_nordif'
                                            and a.codigo = b.tabla
                                            and estado = 'V'))
              and ts_causa = convert(varchar,@i_empresa)
              and ts_oficina = @i_oficina
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and (ts_endoso > @i_codigo)
              and ts_fecha = @w_fecha_pro   --lfcm 22-mayo-2008
            order by ts_hora, ts_endoso
          end



         if @@rowcount = 20
           select @o_mas_mov = 'S'
         else
            select @o_mas_mov = 'N'
         set rowcount 0
         end --if @i_empresa = 1

     --<lfcm 22-feb-2008 CATEG


      --> lfcm 02-julio-2007  SOLO PARA PACIFICTEL
      if @i_empresa = 3
      begin
        set rowcount 20
        if @i_oficina is null --REF 63
        begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)

               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                     on  ts_oficina = of_oficina  --REF 63
                     left join cob_pagos..pg_control_usuario --REF 63
                     on ts_causa = convert(varchar,cu_empresa) --REF 63
                     and ts_oficina = cu_oficina  --REF 63
                     and ts_usuario = cu_usuario --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_endoso > @i_codigo)
               order by ts_hora, ts_endoso
            end
            else
            begin
              select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre,1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0),
                'RETENC  '= ts_ocasional,
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_endoso,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0)
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                     on  ts_oficina = of_oficina  --REF 63
                     left join cob_pagos..pg_control_usuario --REF 63
                     on ts_causa = convert(varchar,cu_empresa) --REF 63
                     and ts_oficina = cu_oficina  --REF 63
                     and ts_usuario = cu_usuario --REF 63
               where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                 and ts_causa = convert(varchar,@i_empresa)
                 and ts_oficina = @i_oficina
                 and (ts_usuario = @i_usuario or @i_usuario = null)
                 and (ts_endoso > @i_codigo)
               order by ts_hora, ts_endoso
            end



      if @@rowcount = 20
         select @o_mas_mov = 'S'
      else
         select @o_mas_mov = 'N'
      set rowcount 0
      end --if @i_empresa = 3
            --< lfcm 02-julio-2007


  /* <-- lfcm 12-enero-2007 (Inicio)  Solo Emelmanabi */
  -- smerino aumentar el campo ts_contratado


      if @i_empresa in (120) --DIRECTV
      begin

         select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
                set rowcount 20
         if @i_oficina is null --REF 63
         begin
              select
              'ESTADO  '= isnull(cu_estado,'N'),
              'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
              'NOMBRE  '= substring(ts_nombre, 1,30),
              'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
              'EFECTIVO'= ts_valor,
              'CHEQUE  '= ts_saldo,
              'ND      '= isnull(ts_monto,0),
              'CREDITO '= isnull(ts_contratado, 0),
              'CORREC  '= ts_correccion,
              'USUARIO '= substring(ts_usuario,1,10),
              'HORA    '= ts_hora,
              'COMPROB '= ts_secuencial,
              'COM'     = isnull(convert(money,ts_autoriz_aut),0),
              'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
                   from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina ---REF 63
                         on  ts_oficina = of_oficina  --REF 63
                         left join cob_pagos..pg_control_usuario  --REF 63
                         on ts_causa = convert(varchar,cu_empresa) --REF 63
                         and ts_oficina = cu_oficina  --REF 63
                         and ts_usuario = cu_usuario --REF 63
                   where (ts_tipo_transaccion in (3925,3926,3928))
                     and ts_causa = '120'
                     and (ts_usuario = @i_usuario or @i_usuario = null)
                     and (ts_secuencial > @i_codigo)
                     and ts_tsfecha = @w_fecha_pro
              order by ts_hora, ts_secuencial
          end
          else
          begin
                select
                'ESTADO  '= isnull(cu_estado,'N'),
                'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                'NOMBRE  '= substring(ts_nombre, 1,30),
                'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
                'EFECTIVO'= ts_valor,
                'CHEQUE  '= ts_saldo,
                'ND      '= isnull(ts_monto,0),
                'CREDITO '= isnull(ts_contratado, 0),
                'CORREC  '= ts_correccion,
                'USUARIO '= substring(ts_usuario,1,10),
                'HORA    '= ts_hora,
                'COMPROB '= ts_secuencial,
                'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
                     from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina ---REF 63
                           on  ts_oficina = of_oficina  --REF 63
                           left join cob_pagos..pg_control_usuario  --REF 63
                           on ts_causa = convert(varchar,cu_empresa) --REF 63
                           and ts_oficina = cu_oficina  --REF 63
                           and ts_usuario = cu_usuario --REF 63
                     where (ts_tipo_transaccion in (3925,3926,3928))
                       and ts_causa = '120'
                       and ts_oficina = @i_oficina
                       and (ts_usuario = @i_usuario or @i_usuario = null)
                       and (ts_secuencial > @i_codigo)
                       and ts_tsfecha = @w_fecha_pro
                order by ts_hora, ts_secuencial
          end

      if @@rowcount = 20
         select @o_mas_mov = 'S'
      else
         select @o_mas_mov = 'N'
      set rowcount 0
      end  ---- DIRECTV

    -- rer: 54
    if @i_empresa in (451,7256) -- MARGLOBAL BELCORP
    begin

        select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
       
        set rowcount 20
        if @i_oficina is null --REF 63
        begin
              select
                  'ESTADO  '= isnull(cu_estado,'N'),
                  'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                  'NOMBRE  '= substring(ts_nombre, 1,30),
                  'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
                  'EFECTIVO'= ts_valor,
                  'CHEQUE  '= ts_saldo,
                  'ND      '= isnull(ts_monto,0),
                  'CREDITO '= isnull(ts_contratado, 0),
                  'CORREC  '= ts_correccion,
                  'USUARIO '= substring(ts_usuario,1,10),
                  'HORA    '= ts_hora,
                  'COMPROB '= ts_secuencial,
                  'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                  'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
              from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                   on  ts_oficina = of_oficina   --REF 63
                   left join cob_pagos..pg_control_usuario --REF63
                   on ts_causa = convert(varchar,cu_empresa) --REF 63
                   and ts_oficina = cu_oficina   --REF 63
                   and ts_usuario = cu_usuario  --REF 63
              where (ts_tipo_transaccion in (3925,3926,3928))
              and ts_causa = convert(varchar,@i_empresa)  ---'451' SMERINO COMENTA
              and (ts_usuario = @i_usuario or @i_usuario = null)
              and (ts_secuencial > @i_codigo)
              and ts_tsfecha = @w_fecha_pro
          order by ts_hora, ts_secuencial
        end
        else
         begin
                    select
                    'ESTADO  '= isnull(cu_estado,'N'),
                    'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                    'NOMBRE  '= substring(ts_nombre, 1,30),
                    'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
                    'EFECTIVO'= ts_valor,
                    'CHEQUE  '= ts_saldo,
                    'ND      '= isnull(ts_monto,0),
                    'CREDITO '= isnull(ts_contratado, 0),
                    'CORREC  '= ts_correccion,
                    'USUARIO '= substring(ts_usuario,1,10),
                    'HORA    '= ts_hora,
                    'COMPROB '= ts_secuencial,
                    'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                    'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)-- - isnull(convert(money,ts_autoriz_aut),0)
                from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                     on  ts_oficina = of_oficina   --REF 63
                     left join cob_pagos..pg_control_usuario --REF63
                     on ts_causa = convert(varchar,cu_empresa) --REF 63
                     and ts_oficina = cu_oficina   --REF 63
                     and ts_usuario = cu_usuario  --REF 63
                where (ts_tipo_transaccion in (3925,3926,3928))
                and ts_causa = convert(varchar,@i_empresa)  ---'451' SMERINO COMENTA'451'
                and ts_oficina = @i_oficina
                and (ts_usuario = @i_usuario or @i_usuario = null)
                and (ts_secuencial > @i_codigo)
                and ts_tsfecha = @w_fecha_pro
              order by ts_hora, ts_secuencial
         end

        if @@rowcount = 20
            select @o_mas_mov = 'S'
        else
            select @o_mas_mov = 'N'

        set rowcount 0

    end  ---- MARGLOBAL

    -- Ref.71 CS -->
    --if @i_empresa = 144 --ref79 empresa considerada en catálogo MEER
    if @i_empresa in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
    begin
      set rowcount 20
      if @i_oficina is null
      begin
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_cuentas..cc_tran_servicio
                inner join cobis..cl_oficina
                  on  ts_oficina = of_oficina
                left join cob_pagos..pg_control_usuario
                  on ts_causa = convert(varchar,cu_empresa)
                 and ts_oficina = cu_oficina
                 and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_tipo_chequera <> 'CNB' 
            and ts_causa = convert(varchar,@i_empresa)
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro
        UNION
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
               inner join cobis..cl_oficina
                  on  ts_oficina = of_oficina
               left join cob_pagos..pg_control_usuario
                  on ts_causa = convert(varchar,cu_empresa)
                 and ts_oficina = cu_oficina
                 and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_tipo_chequera ='CNB' 
            and ts_causa = convert(varchar,@i_empresa)
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro
            and cc_fecha= ts_tsfecha
            and cc_conciliada='SI'
            and cc_sec_trans=ts_secuencial
            and cc_causa = ts_causa --Ref089:msilvag 
			and ts_terminal = cc_terminal --ref091			
        UNION
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
               inner join cobis..cl_oficina
                  on  ts_oficina = of_oficina
               left join cob_pagos..pg_control_usuario
                  on ts_causa = convert(varchar,cu_empresa)
                 and ts_oficina = cu_oficina
                 and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_tipo_chequera ='CNB' 
            and ts_causa = convert(varchar,@i_empresa)
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
          and ts_tsfecha = @w_fecha_pro
          and cc_fecha= @w_fecha_anterior
            and cc_conciliada='SI'
            and cc_sec_trans=ts_secuencial
            and cc_causa = ts_causa --Ref089:msilvag 
			and ts_terminal = cc_terminal --ref091
            order by ts_hora, ts_secuencial
            
      end
      else
      begin
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_cuentas..cc_tran_servicio
                inner join cobis..cl_oficina
                  on  ts_oficina = of_oficina 
                left join cob_pagos..pg_control_usuario
                  on ts_causa = convert(varchar,cu_empresa)
                  and ts_oficina = cu_oficina
                  and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_causa = convert(varchar,@i_empresa)
            and ts_tipo_chequera <> 'CNB' 
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro
        UNION
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
               inner join cobis..cl_oficina
                  on  ts_oficina = of_oficina
               left join cob_pagos..pg_control_usuario
                  on ts_causa = convert(varchar,cu_empresa)
                 and ts_oficina = cu_oficina
                 and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_causa = convert(varchar,@i_empresa)
            and ts_tipo_chequera = 'CNB'
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro
            and cc_fecha= ts_tsfecha
            and cc_conciliada='SI'
            and cc_sec_trans=ts_secuencial
            and cc_causa = ts_causa --Ref089:msilvag 
			and ts_terminal = cc_terminal --ref091			
        UNION
        select 'ESTADO  '= isnull(cu_estado,'N'),
               'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
               'NOMBRE  '= substring(ts_nombre, 1,30),
               'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0),
               'EFECTIVO'= ts_valor,
               'CHEQUE  '= ts_saldo,
               'ND      '= isnull(ts_monto,0),
               'CREDITO '= isnull(ts_contratado, 0),
               'CORREC  '= ts_correccion,
               'USUARIO '= substring(ts_usuario,1,10),
               'HORA    '= ts_hora,
               'COMPROB '= ts_secuencial,
               'COM'     = isnull(convert(money,ts_autoriz_aut),0),
               'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(ts_contratado, 0)
         from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
               inner join cobis..cl_oficina
                 on  ts_oficina = of_oficina
               left join cob_pagos..pg_control_usuario
                 on ts_causa = convert(varchar,cu_empresa)
                 and ts_oficina = cu_oficina
                 and ts_usuario = cu_usuario
         where (ts_tipo_transaccion in (3925,3926,3928))
            and ts_causa = convert(varchar,@i_empresa)
            and ts_tipo_chequera = 'CNB' 
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tsfecha = @w_fecha_pro
            and cc_fecha= @w_fecha_anterior
            and cc_conciliada='SI'
            and cc_sec_trans=ts_secuencial
            and cc_causa = ts_causa --Ref089:msilvag 
			and ts_terminal = cc_terminal --ref091			
        order by ts_hora, ts_secuencial
      end
      
      if @@rowcount = 20
        select @o_mas_mov = 'S'
      else
        select @o_mas_mov = 'N'
      set rowcount 0
    end  ---- SMERINO CENTRO SUR Y BELCORP
    -- <-- Ref.71: CS
    
      if @i_empresa in (2494) --TC - 07/21/2008 -IESS
      begin
         select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008
        set rowcount 20
        if @i_oficina is null --REF 63
        begin
                select
                  'ESTADO  '= isnull(cu_estado,'N'),
                  'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                  'NOMBRE  '= substring(ts_nombre,1,30),
                  'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                  'EFECTIVO'= ts_valor,
                  'CHEQUE  '= ts_saldo,
                  'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
                  'RETENC  '= ts_ocasional,
                  'CORREC  '= ts_correccion,
                  'USUARIO '= substring(ts_usuario,1,10),
                  'HORA    '= ts_hora,
                  'COMPROB '= ts_secuencial,
                  'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                  'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0)
                 from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                       on  ts_oficina = of_oficina  --REF 63
                       left join cob_pagos..pg_control_usuario --REF 63
                       on ts_causa = convert(varchar,cu_empresa) --REF 63
                       and ts_oficina = cu_oficina  --REF 63
                       and ts_usuario = cu_usuario --REF 63
                      inner join cobis..cl_catalogo a --REF 63
                        on ts_tipo_transaccion = convert(int,a.codigo) --REF 63
                      inner  join cobis..cl_tabla b --REF 63
                        on a.tabla =  b.codigo --REF 63
                      and b.tabla = 'sv_trx_nordif' --REF 63
                 where ts_causa = convert(varchar,@i_empresa)
                   and (ts_usuario = @i_usuario or @i_usuario = null)
                   and (ts_secuencial > @i_codigo)
                   and ts_fecha = @w_fecha_pro   --tc 08/15/2008
                 order by ts_hora, ts_endoso
         end
         else
         begin
            select
                  'ESTADO  '= isnull(cu_estado,'N'),
                  'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                  'NOMBRE  '= substring(ts_nombre,1,30),
                  'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0),
                  'EFECTIVO'= ts_valor,
                  'CHEQUE  '= ts_saldo,
                  'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
                  'RETENC  '= ts_ocasional,
                  'CORREC  '= ts_correccion,
                  'USUARIO '= substring(ts_usuario,1,10),
                  'HORA    '= ts_hora,
                  'COMPROB '= ts_secuencial,
                  'COM'     = isnull(convert(money,ts_autoriz_aut),0),
                  'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0)
                 from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina --REF 63
                       on  ts_oficina = of_oficina  --REF 63
                       left join cob_pagos..pg_control_usuario --REF 63
                       on ts_causa = convert(varchar,cu_empresa) --REF 63
                       and ts_oficina = cu_oficina  --REF 63
                       and ts_usuario = cu_usuario --REF 63
                 where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                from cobis..cl_tabla a, cobis..cl_catalogo b
                                               where a.tabla = 'sv_trx_nordif'
                                                 and a.codigo = b.tabla
                                                 and estado = 'V'))
                   and ts_causa = convert(varchar,@i_empresa)
                   and ts_oficina = @i_oficina
                   and (ts_usuario = @i_usuario or @i_usuario = null)
                   and (ts_secuencial > @i_codigo)
                   and ts_fecha = @w_fecha_pro   --tc 08/15/2008
                 order by ts_hora, ts_endoso
         end

      if @@rowcount = 20
         select @o_mas_mov = 'S'
      else
         select @o_mas_mov = 'N'
      set rowcount 0
      end

  /* <-- lfcm 05-febrero-2007 (Inicio)  Solo Grupo TVCABLE */
  if  @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo
                          where tabla in (select codigo from cobis..cl_tabla
                           where tabla = 'sv_tvcable_online')
                      and valor = 'S')
  begin
    set rowcount 20
    if @i_oficina is null --REF 63
    begin
              select
                      'ESTADO  '= isnull(cu_estado,'N'),
                      'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                      'NOMBRE  '= substring(ts_descripcion_ec,1,30),
                      '',
                      '',
                      'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0),
                      'EFECTIVO'= ts_valor,
                      'CHEQUE  '= ts_saldo,
                      'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
                      'RETENC  '= ts_ocasional,
                      'CORREC  '= ts_correccion,
                      'USUARIO '= substring(ts_usuario,1,10),
                      'HORA    '= ts_hora,
                      'COMPROB '= ts_endoso,
                      'COM'     = isnull(convert(money,ts_autoriz_aut),0 ), --Ref081:msilvag isnull(convert(money,ts_aporte_iess),0 ),
                      'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_aporte_iess),0 ),
                      'SECUENCI'= ts_secuencial
                     from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                           on  ts_oficina = of_oficina   --REF 63
                           left join cob_pagos..pg_control_usuario --REF 63
                           on ts_causa = convert(varchar,cu_empresa) --REF 63
                           and ts_oficina = cu_oficina --REF 63
                           and ts_usuario = cu_usuario --REF 63
                    where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                                 where a.tabla = 'sv_trx_nordif'
                                                   and a.codigo = b.tabla
                                                   and estado = 'V'))
                      and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
                      and (ts_usuario = @i_usuario or @i_usuario = null)
                      and (ts_secuencial > @i_codigo)
                      and ts_tipo_chequera = 'VEN'

                      union all

                      select
                            'ESTADO  '= isnull(cu_estado,'N'),
                            'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                            'NOMBRE  '= substring(ts_descripcion_ec,1,30),
                            '',
                            '',
                            'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) ,---SMERINO
                            'EFECTIVO'= ts_valor,
                            'CHEQUE  '= ts_saldo,
                            'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
                            'RETENC  '= ts_ocasional,
                            'CORREC  '= ts_correccion,
                            'USUARIO '= substring(ts_usuario,1,10),
                            'HORA    '= ts_hora,
                            'COMPROB '= ts_endoso,
                            'COM'     = isnull(convert(money,ts_autoriz_aut),0 ),
                            'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_aporte_iess),0 ),
                            'SECUENCI'= ts_secuencial
                          from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                               on  ts_oficina = of_oficina   --REF 63
                               left join cob_pagos..pg_control_usuario --REF 63
                               on ts_causa = convert(varchar,cu_empresa) --REF 63
                               and ts_oficina = cu_oficina --REF 63
                               and ts_usuario = cu_usuario --REF 63
                          where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                                       where a.tabla = 'sv_trx_nordif'
                                                         and a.codigo = b.tabla
                                                         and estado = 'V'))
                            and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
                            and (ts_usuario = @i_usuario or @i_usuario = null)
                            and (ts_secuencial > @i_codigo)
                      and ts_tipo_chequera <> 'VEN'
                    order by ts_secuencial, ts_hora
    end
    else
    begin
        select
            'ESTADO  '= isnull(cu_estado,'N'),
            'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
            'NOMBRE  '= substring(ts_descripcion_ec,1,30),
            '',
            '',
            'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0),
            'EFECTIVO'= ts_valor,
            'CHEQUE  '= ts_saldo,
            'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
            'RETENC  '= ts_ocasional,
            'CORREC  '= ts_correccion,
            'USUARIO '= substring(ts_usuario,1,10),
            'HORA    '= ts_hora,
            'COMPROB '= ts_endoso,
            'COM'     = isnull(convert(money,ts_autoriz_aut),0 ), --Ref081:msilvag isnull(convert(money,ts_aporte_iess),0 ),
            'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_aporte_iess),0 ),
            'SECUENCI'= ts_secuencial
           from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                 on  ts_oficina = of_oficina   --REF 63
                 left join cob_pagos..pg_control_usuario --REF 63
                 on ts_causa = convert(varchar,cu_empresa) --REF 63
                 and ts_oficina = cu_oficina --REF 63
                 and ts_usuario = cu_usuario --REF 63
          where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V'))
            and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
            and ts_oficina = @i_oficina
            and (ts_usuario = @i_usuario or @i_usuario = null)
            and (ts_secuencial > @i_codigo)
            and ts_tipo_chequera = 'VEN'

            union all

            select
                  'ESTADO  '= isnull(cu_estado,'N'),
                  'CODIGO  '= substring(ts_referencia,1,datalength(ts_referencia)),
                  'NOMBRE  '= substring(ts_descripcion_ec,1,30),
                  '',
                  '',
                  'TOTAL   '= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) ,---SMERINO
                  'EFECTIVO'= ts_valor,
                  'CHEQUE  '= ts_saldo,
                  'ND      '= isnull(ts_monto,0) + isnull(ts_descuento_iess,0),
                  'RETENC  '= ts_ocasional,
                  'CORREC  '= ts_correccion,
                  'USUARIO '= substring(ts_usuario,1,10),
                  'HORA    '= ts_hora,
                  'COMPROB '= ts_endoso,
                  'COM'     = isnull(convert(money,ts_autoriz_aut),0 ),
                  'TOTEMESA'= isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_ocasional,0) +  isnull(ts_descuento_iess,0) + isnull(convert(money,ts_aporte_iess),0 ),
                  'SECUENCI'= ts_secuencial
                from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                     on  ts_oficina = of_oficina   --REF 63
                     left join cob_pagos..pg_control_usuario --REF 63
                     on ts_causa = convert(varchar,cu_empresa) --REF 63
                     and ts_oficina = cu_oficina --REF 63
                     and ts_usuario = cu_usuario --REF 63
                where (ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V'))
                  and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
                  and ts_oficina = @i_oficina
                  and (ts_usuario = @i_usuario or @i_usuario = null)
                  and (ts_secuencial > @i_codigo)
                  and ts_tipo_chequera <> 'VEN'
                 order by ts_secuencial, ts_hora
    end

    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'
    set rowcount 0
  end
  /* <-- lfcm 05-febrero-2007 (Fin)  Solo Grupo TVCABLE */
   end

if @i_opcion = 'P'              -- Graba Registro para el Credito por el total recaudado
   begin
    /* --> DGA 11/ENE/2006  */
      -- PARA NO GUARDAR LINEA DE CREDITO DE EMPRESAS QUE ESTAN EN CATALOGO
        if exists( select 1 --REF 63
                   from cob_cuentas..cc_tran_servicio
                  where ts_causa in (select b.codigo
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'pg_recaudacion_automatica'
                                        and a.codigo = b.tabla
                                        and estado = 'V'
                                        and b.codigo = convert(varchar,@i_empresa)))
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 033333,
                 @i_msg   = 'PARA ESTA EMPRESA EL REGISTRO DE CREDITO ES AUTOMATICO'
            return 1
         end
    /* <-- DGA 11/ENE/2006  */

            SELECT
                 @w_pe_dias       =  pe_dias,
                 @w_pe_laborables =  pe_laborables,
                 @w_pe_fpago      =  pe_fpago,
                 @w_pe_costo      =  pe_costo,
                 @w_pe_cuenta     =  pe_cuenta,     -- RDG
                 @w_porcentaje    =  pe_porcentaje,  -- RDG 02/26/2003
                 @w_pe_impret     =  pe_impret,      -- Miguel Aldaz 03/17/2008
                 @w_porc          =  pe_porc_retimp,  -- Miguel Aldaz 03/17/2008
                 @w_cod_grupo     =  convert(char(6),pe_cod_grupo),  --ref55: DAPV/CNEL                 
                 @w_imdCost       =  pe_imdCostCanal  -- REF 8 smerino                                  
            FROM cob_pagos..pg_person_empresa
                WHERE pe_empresa = @i_empresa
             if @@rowcount = 0
                begin
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 111111,
                  @i_msg = "Error Empresa no esta Personalizada"
                  return 1
                end


            if  @w_imdCost = 'S'
             begin
             
                     
                     
                select    @w_canalC = pg_canal,
	                  @w_costCanal = pg_costo
	         from cob_pagos..pg_costo_com_canal
                 where pg_empresa=@i_empresa
                 
                 if @@rowcount = 0
		 begin
		   exec cobis..sp_cerror
		   @t_debug = @t_debug,
		   @t_file  = @t_file,
		   @t_from  = @w_sp_name,
		   @i_num   = 111111,
		   @i_msg = "Error Costo por canal no esta Parametrizado"
		   return 1
                 end
                 
		  
                 ---smerino aumenta conciliacion cnb belcorp 02152016
                 select @w_can_c1 = count(1)
		 from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
		 where ts_tsfecha=cc_fecha
		 and ts_secuencial=cc_sec_trans
		 and cc_conciliada='NO'
		 and ts_tipo_transaccion in (select convert(int,b.codigo) 
								 from cobis..cl_tabla a, cobis..cl_catalogo b
								where a.tabla = 'sv_trx_nordif'
								and a.codigo = b.tabla
						and estado = 'V')
		    --and cc_estatus_bco='SI' and cc_estatus_emp_serv='NO'
		 and ts_causa = convert(varchar,@i_empresa)  
		 and ts_tsfecha = @w_fecha_pro
		 --fin smerino aumnta belcorp
		 and ts_terminal = cc_terminal --ref091
		 
		 
		 ---smerino aumenta conciliacion cnb belcorp 02152016 3928
		  select @w_can_c2 = count(1)
		 from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
		 where ts_tsfecha = @w_fecha_pro
		 and ts_secuencial=cc_sec_trans
		 and ts_tipo_transaccion in (3928)
		 and cc_conciliada='NO'
	         and ts_causa = convert(varchar,@i_empresa)  
		 and cc_fecha= @w_fecha_anterior
		 --fin smerino aumnta belcorp
		 and ts_terminal = cc_terminal --ref091
		 
		 select @w_can_c=  isnull(@w_can_c1,0) +  isnull(@w_can_c2,0)
		 
		 
                 
                 insert into  cob_pagos..pg_control_com_canal (pg_empresa,pg_fecha,pg_canal,pg_cant,pg_costo,pg_total)
		 select convert(int,ts_causa),
		         @w_fecha_pro,   
		         ts_tipo_chequera,
		         (case ts_tipo_chequera                      
			                         when 'CNB' then count(ts_secuencial) - isnull(@w_can_c,0)
			                         else count(ts_secuencial)
                        end),
                        pg_costo , 
		        (case ts_tipo_chequera                         
						 when 'CNB' then (pg_costo * (count(ts_secuencial) - isnull(@w_can_c,0)) ) 
						 else (pg_costo * (count(ts_secuencial)) ) 
                        end)
		 from cob_cuentas..cc_tran_servicio,cob_pagos..pg_costo_com_canal
		 where ts_tsfecha = @w_fecha_pro    --  el mayor solo por prueba
		 and ts_causa= convert(varchar,@i_empresa)
		 and ts_correccion ='N'
		 and ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                             where a.tabla = 'sv_trx_nordif'
                                               and a.codigo = b.tabla
                                               and estado = 'V')
		 and ts_secuencial not in ( select isnull(ts_ssn_corr,0)   
		 	                                     from  cob_cuentas..cc_tran_servicio 
		 	                                     where ts_tsfecha = @w_fecha_pro   
		 	                                      and ts_correccion = "S"  and  ts_causa=convert(varchar,@i_empresa)
		 	                                      and ts_tipo_transaccion in (select convert(int,b.codigo) 
		 	                                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                             			                          where a.tabla = 'sv_trx_nordif'
                                              			                          and a.codigo = b.tabla
                                               			                          and estado = 'V')) 
		 and  ts_causa= convert(varchar,pg_empresa)
		 and  pg_canal=ts_tipo_chequera
		 group by ts_tipo_chequera,ts_causa,pg_costo 
		 
		 if @@rowcount = 0  --REF 63
		 begin
		      exec cobis..sp_cerror
			    @t_debug  = @t_debug,
			    @t_file   = @t_file,
			    @t_from   = @w_sp_name,
			    @i_num    = 044444,
			    @i_msg    = 'ERROR AL INSERTAR COMISION POR CANAL '
			return 1
                 end

           end
              ---REF 8 smerino belcorp


            if @w_cod_grupo is null --ref55: DAPV/CNEL
            begin
                select  @w_acedita_grp = isnull(pe_acedita_grp,'N')
                from cob_pagos..pg_person_empresa
                where pe_empresa = convert(int,@i_empresa)
            end
            else
            begin
                select  @w_acedita_grp = isnull(pe_acedita_grp,'N')
                from cob_pagos..pg_person_empresa
                where pe_empresa = convert(int,@w_cod_grupo)
            end

            if @w_porcentaje is null Select @w_porcentaje = 100
            if @w_porcentaje  = null Select @w_porcentaje = 100

        if @w_pe_impret = 1 and @w_porc is null  -- Miguel Aldaz 03/17/2008
           select @w_porc = pa_float
           from cobis..cl_parametro
           where pa_nemonico = 'IMR'
           and pa_producto = 'CTE'               -- Miguel Aldaz 03/17/2008

      SELECT  pn_empresa, pn_fecha_rec--*  --REF 63
      FROM cob_pagos..pg_control_ncrecaudacion
                WHERE pn_empresa   = @i_empresa
                AND   pn_fecha_rec = @s_date
            if @@rowcount <> 0
               begin
               exec cobis..sp_cerror
                    @t_debug         = @t_debug,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @i_msg           = 'REGISTRO PARA EL CREDITO YA EXISTE',
                    @i_num           = 111111
               return 1
               end
             else
                  if exists( select 1  --REF 63
                             from cobis..cl_tabla a, cobis..cl_catalogo b
                             where a.tabla = 'sv_nc_servicios'
                             and a.codigo = b.tabla
                             and convert(smallint,convert(int,b.codigo)) = @i_empresa
                             and estado = 'V'  )
                    begin
                         update cobis..cl_catalogo
                            set valor = 'N'
                           from cobis..cl_tabla a,
                                cobis..cl_catalogo b
                          where a.tabla = 'sv_nc_servicios'
                          and   a.codigo = b.tabla
                          and convert(smallint,convert(int,b.codigo)) = @i_empresa
                          and estado = 'V'

                           if @@rowcount = 0  --REF 63
                           begin
                              exec cobis..sp_cerror
                                   @t_debug  = @t_debug,
                                   @t_file   = @t_file,
                                   @t_from   = @w_sp_name,
                                   @i_num    = 044444,
                                   @i_msg    = 'ERROR EN ACTUALIZACION DE CATALOGO SERVICIO'
                               return 1
                          end
                    end

       if @i_empresa = 4994 --ref55: DAPV/CNEL   --- 08/09/2012
      begin
        if @w_acedita_grp = 'S'
        begin
            select
              @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)  + isnull(ts_contratado,0)  ),0),
              @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_n     = count(1)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'N'
            and rtrim(ts_propietario)     = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            and ts_tsfecha = @w_fecha_pro
            and ts_fecha = @w_fecha_pro

            select
              @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)  + isnull(ts_contratado,0)  ),0),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s     = count(1)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'S'
            and rtrim(ts_propietario)     = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            and ts_tsfecha = @w_fecha_pro
            and ts_fecha = @w_fecha_pro
        end
      else
        begin
          exec cobis..sp_cerror
                    @t_debug         = @t_debug,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @i_msg           = 'NO ESTA PARAMETRIZADO COMO ACREDITACIÒN GRUPO',
                    @i_num           = 111111
               return 1
        end
     end


     -- if @i_empresa in (825,1127,1719,1330,331,4981,4977,4978,4979,4980)--ref55: DAPV/CNEL   --- 05/09/2012
     if @i_empresa in (select pe_empresa from cob_pagos..pg_person_empresa
         	      where pe_cod_grupo = 4994) ---CNEL/CATEG
     begin
        if @w_acedita_grp = 'N'
        begin
            select
              @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0)   ),0),
              @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_n     = count(1)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'N'
            and rtrim(ts_causa)     = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            and ts_tsfecha = @w_fecha_pro
            and ts_fecha = @w_fecha_pro

            select
              @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)  + isnull(ts_contratado,0) ),0),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s     = count(1)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'S'
            and rtrim(ts_causa)     = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            and ts_tsfecha = @w_fecha_pro
            and ts_fecha = @w_fecha_pro
        end
        else
        begin
            exec cobis..sp_cerror
                    @t_debug         = @t_debug,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @i_msg           = 'ESTA PARAMETRIZADO COMO ACREDITACIÒN GRUPO',
                    @i_num           = 111111
               return 1
        end
     end




      -- obtengo el monto para guardar registro de la NC
      if @i_empresa in (3,115,114) --REF 47  --REF 48
      ---smerino aumenta el campo ts_contratado
        begin
                select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0) ),0),
                   @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
                   @w_can_n = count(1)
              from cob_cuentas..cc_tran_servicio
             where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                            where a.tabla = 'sv_trx_nordif'
                                              and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                              and estado = 'V')
               and ts_correccion = 'N'
               and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006

            select @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
                   @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
                   @w_can_s = count(1)
              from cob_cuentas..cc_tran_servicio
             where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                            where a.tabla = 'sv_trx_nordif'
                                              and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                              and estado = 'V')
               and ts_correccion = 'S'
               and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006

        end


   -- smerino belcorp
     if @i_empresa in (7256) --REF smerino
     begin
	    select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0) ),0),
	       @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
	       @w_can_n = count(1)
	  from cob_cuentas..cc_tran_servicio
	 where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
					 from cobis..cl_tabla a, cobis..cl_catalogo b
					where a.tabla = 'sv_trx_nordif'
					  and a.codigo = b.tabla
					  --and convert(smallint,b.valor) = @i_empresa
					  and estado = 'V')
	   and ts_correccion = 'N'
	   and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
	   
	select @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
	       @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
	       @w_can_s = count(1)
	  from cob_cuentas..cc_tran_servicio
	 where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
					 from cobis..cl_tabla a, cobis..cl_catalogo b
					where a.tabla = 'sv_trx_nordif'
					  and a.codigo = b.tabla
					  --and convert(smallint,b.valor) = @i_empresa
					  and estado = 'V')
	   and ts_correccion = 'S'
	   and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
	   
	   
	   ---SMERINO AUMENTA POR CONCILIACION DE CNB---
	 select @w_val_c1 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
	   	@w_val_ret_c1 = isnull(sum(isnull(ts_ocasional,0)),0),
	   	@w_can_c1 = count(1)
	  from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
	 where ts_tsfecha=cc_fecha
	   and ts_secuencial=cc_sec_trans
	   and ts_tipo_transaccion in (select convert(int,b.codigo)   
					 from cobis..cl_tabla a, cobis..cl_catalogo b
					where a.tabla = 'sv_trx_nordif'
					and a.codigo = b.tabla
					and estado = 'V')
	   and cc_conciliada='NO'
	   --and cc_estatus_bco='SI' and cc_estatus_emp_serv='NO'
	   and ts_causa = convert(varchar,@i_empresa)   
	   --and ts_tsfecha = @w_fecha_pro
	   and ts_terminal = cc_terminal --ref091
	   
	  	   
	   ---SMERINO AUMENTA POR CONCILIACION DE CNB TRX DE AJUSTE---
	 select @w_val_c2 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
		@w_val_ret_c2 = isnull(sum(isnull(ts_ocasional,0)),0),
		@w_can_c2 = count(1)
	  from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
	 where ts_tsfecha=@w_fecha_pro
	   and ts_secuencial=cc_sec_trans
	   and ts_tipo_transaccion in (3928)
	   and ts_causa = convert(varchar,@i_empresa)  
	   and cc_conciliada='NO'
	   and cc_fecha= @w_fecha_anterior
	   and ts_terminal = cc_terminal --ref091
	   
	   
	   select @w_val_c = isnull(@w_val_c1,0) + isnull(@w_val_c2,0),
	   	  @w_val_ret_c =  isnull(@w_val_ret_c1,0) + isnull(@w_val_ret_c2,0),
	   	  @w_can_c =  isnull(@w_can_c1,0) + isnull(@w_can_c2,0)
	   	
	          
	          
     end
    -- fin smerino belcorp

    
    if @i_empresa not in(3,115,114,4994,7256) --,144) --REF 47  --REF 48 --smerino aumenta campo ts_contratado; Ref.71: 144 CS --ref79 empresa 144 considerada en cat?logo MEER
    and @i_empresa not in (select pe_empresa
                          	from cob_pagos..pg_person_empresa
                          	where pe_cod_grupo = 4994) --CNEL/CATEG
    and @i_empresa not in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')    
    begin
        select @w_val_n = case @i_empresa
                          when 361 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
                          when 8269 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)   -- JPM Ref.72
                          when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0) --Ref061:msilvag
                            --Ref062:msilvag Inicio
          when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
          when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
          when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
                          --Ref062:msilvag Fin
                          else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0) - isnull(convert(money,ts_autoriz_aut),0)),0) end,
             @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
             @w_can_n = count(1)
        from cob_cuentas..cc_tran_servicio
       where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
         and ts_correccion = 'N'
         and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006

      select @w_val_s = case @i_empresa
                        when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
                        when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)   -- JPM Ref.72
                      when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0) --Ref061:msilvag
                       --Ref062:msilvag Inicio
          when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
          when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
          when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+  isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)),0)
                      --Ref062:msilvag Fin
                      else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0)  - isnull(ts_aporte_iess,0)- isnull(convert(money,ts_autoriz_aut),0)),0) end,
             @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
             @w_can_s = count(1)
        from cob_cuentas..cc_tran_servicio
       where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
         and ts_correccion = 'S'
         and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
end

      -- Ref.71: CS -->
      --if @i_empresa = 144 --ref79 empresa considerada en catálogo MEER
      if @i_empresa in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
      begin
      
        select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0)   ),0),
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n     = count(1)
         from cob_cuentas..cc_tran_servicio
         where ts_tipo_transaccion in (select convert(int, codigo)
                                        from cobis..cl_catalogo
                                        where tabla = (select codigo
                                                        from cobis..cl_tabla
                                                        where tabla = "pg_trx_emp_rec_autom"))
           and ts_correccion       = 'N'
           and rtrim(ts_causa)     = convert(varchar,@i_empresa)
           and ts_tipo_chequera <> 'CNB'
           and ts_usuario = isnull(@i_usuario,ts_usuario)
           and ts_tsfecha = @w_fecha_pro
        
        select @w_val_n     = @w_val_n + isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0)   ),0),
               @w_val_ret_n = @w_val_ret_n + isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n     = @w_can_n + count(1)
         from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
         where ts_tipo_transaccion in (select convert(int, codigo)
                                        from cobis..cl_catalogo
                                         where tabla = (select codigo
                                                         from cobis..cl_tabla
                                                         where tabla = "pg_trx_emp_rec_autom"))
           and ts_correccion       = 'N'
           and rtrim(ts_causa)     = convert(varchar,@i_empresa)
           and ts_tipo_chequera = 'CNB'
           and ts_usuario = isnull(@i_usuario,ts_usuario)
           and ts_tsfecha=cc_fecha
           and ts_secuencial=cc_sec_trans
           and cc_conciliada='SI'
           and ts_tsfecha = @w_fecha_pro
           and cc_causa = ts_causa --Ref089:msilvag 
           --- busca las trx de diferido de cnb  conciliadas para agregarlas en la linea de credito
		   and ts_terminal = cc_terminal --ref091
          
        select @w_val_n     = @w_val_n + isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_contratado,0)   ),0),
               @w_val_ret_n = @w_val_ret_n + isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n     = @w_can_n + count(1)
         from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
         where ts_tipo_transaccion in (select convert(int, codigo)
                                        from cobis..cl_catalogo
                                        where tabla = (select codigo
                                                        from cobis..cl_tabla
                                                        where tabla = "pg_trx_emp_rec_autom"))
           and ts_correccion       = 'N'
           and rtrim(ts_causa)     = convert(varchar,@i_empresa)
           and ts_tipo_chequera = 'CNB'
           and ts_usuario = isnull(@i_usuario,ts_usuario)
           and cc_fecha = @w_fecha_proceso ---fecha del anterior dia laborable smerino cs
           and ts_secuencial=cc_sec_trans
           and cc_conciliada='SI'
           and cc_causa = ts_causa --Ref089:msilvag 
		   and ts_terminal = cc_terminal --ref091		   
           
        
        select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)  + isnull(ts_contratado,0) ),0),
               @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_s     = count(1)
          from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (select convert(int, codigo)
                                         from cobis..cl_catalogo
                                         where tabla = (select codigo
                                                        from cobis..cl_tabla
                                                        where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'S'
            and rtrim(ts_causa)     = convert(varchar,@i_empresa)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            and ts_tipo_chequera <> 'CNB'
            and ts_tsfecha = @w_fecha_pro
      end
      -- <-- Ref.71: CS

      select @w_total     = @w_val_n - @w_val_s - isnull(@w_val_c,0)   -- 1,247.55 smerino belcorp
      select @w_total_trn = @w_can_n - @w_can_s  - isnull(@w_can_c ,0)   -- 1,247.55 smerino belcorp
      select @w_retencion = @w_val_ret_n - @w_val_ret_s -  isnull(@w_val_ret_c,0)  -- 1,247.55 smerino belcorp
      
      -->hy-20-junio-2005
      select @w_val_ret_mov_n = 0
      select @w_val_ret_mov_s = 0
      select @w_retencion_mov = 0
      select @w_sec_servicio  = null

      if @i_empresa in (1127, 617, 1371) --! DGA 03/OCT/2005
      begin

         select @w_sec_servicio = 1
         if @i_empresa in (1127, 1371) --! DGA 03/OCT/2005
          select @w_canal_val = 'DBA'
         else
          select @w_canal_val = null

         select @w_val_ret_mov_n = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0)
         from cob_cuentas..cc_tran_servicio
         where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
           and ts_correccion = 'N'
           and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
           and (substring(ts_tipo_chequera,1,3) = @w_canal_val or @w_canal_val is null)      --lfcm 04-abril-2008

         select @w_val_ret_mov_s = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0)
         from cob_cuentas..cc_tran_servicio
         where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
           and ts_correccion = 'S'
           and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
           and (substring(ts_tipo_chequera,1,3) = @w_canal_val or @w_canal_val is null)     --lfcm 04-abril-2008

         select @w_retencion_mov = @w_val_ret_mov_n - @w_val_ret_mov_s

      end
      --<hy-20-junio-2005

      -- Verificacion de NC realizada
      select @w_control_nc = isnull(b.valor,'N')
        from cobis..cl_tabla a, cobis..cl_catalogo b
       where a.tabla = 'sv_nc_servicios'
         and a.codigo = b.tabla
         and convert(smallint,convert(int,b.codigo)) = @i_empresa
         and estado = 'V'

      if @@rowcount = 0
      begin
          select @w_tabla = codigo
          from cobis..cl_tabla
          where tabla = 'sv_nc_servicios'

          insert into cobis..cl_catalogo values(@w_tabla, convert(varchar(10), @i_empresa), 'S', 'V')
          if @@error <> 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 2103001,
                     @i_msg    = 'ERRROR EN REGISTRAR CATALOGO'
                return 2103001
            end
      end

      if @w_control_nc = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'REGISTRO PARA EL PAGO YA FUE GRABADO',
                 @i_num           = 111111
            return 1
         end


      if @w_control_nc = 'N'
          begin
             update cobis..cl_catalogo
                set valor = 'S'
             from cobis..cl_tabla a,
             cobis..cl_catalogo b
             where a.tabla = 'sv_nc_servicios'
             and   a.codigo = b.tabla
             and convert(smallint,convert(int,b.codigo)) = @i_empresa
             and estado = 'V'

             if @@rowcount = 0  --REF 63
             begin
                exec cobis..sp_cerror
                     @t_debug  = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 044444,
                     @i_msg    = 'ERROR EN ACTUALIZACION DE CATALOGO SERVICIO'
                 return 1
            end
          end

      -- para guardar registro de NC se debe confirmar la verificacion de todas las oficinas
      select @w_total_ofi = count(distinct ts_oficina)
        from cob_cuentas..cc_tran_servicio
       where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
         and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006

      select @w_total_usu = count(1)
        from cob_pagos..pg_control_verificacion
       where cv_estado = 'S'
         and cv_empresa = @i_empresa

      select @w_valida = pa_smallint
    from cobis..cl_parametro
    where pa_producto  = "CTE"
      and pa_nemonico  = "PDFA"

      IF @@rowcount = 0
         select @w_valida = 0

     if @w_total_ofi <> @w_total_usu and @w_valida  = 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 055555,
                 @i_msg    = 'OFICINAS NO VERIFICADAS EN SU TOTALIDAD'
            return 1
         end

     if @w_pe_laborables = 'N'
        begin
           select @w_fecha_pago = dateadd(dd,@w_pe_dias,@s_date)
            while exists (select 1 from cobis..cl_dias_feriados --REF 63
                  where df_ciudad = 1
                  and df_fecha = @w_fecha_pago)
            begin
                select @w_fecha_pago = dateadd(dd, +1, @w_fecha_pago)
            end
        end
     else
        begin
          select @w_fecha_pago = @s_date
          select @w_cont = 0

          while @w_cont < @w_pe_dias   --REF 63
          begin
            select  @w_fecha_pago = dateadd(dd, 1, @w_fecha_pago)
            if not exists (select df_fecha
                              from  cobis..cl_dias_feriados
                              where df_fecha = @w_fecha_pago
                              and df_ciudad = 1 )
                 select @w_cont = @w_cont + 1
          end
        end


      Select @w_pe_cuenta    = null
      Select @w_pn_retimpret = null
      Select @w_sec          = null
      Select @w_fecha_efec   = null

       -- RDG 02/01/2003
       -- Adicionada 3 Variables a el Insert de la Tabla cob_pagos..pg_control_ncrecaudacion
       if exists ( select 1 from cob_pagos..pg_person_empresa
                   where pe_empresa = @i_empresa and pe_conta = 1 and pe_impret = 1 )
          Begin

            -- RDG 02/10/2003
            -- Validar si Tiene Archivo de Impuesto
            select @w_count = isnull( count(1) , 0)
            from cob_pagos..pg_impto_servicio
            where si_empresa    = @i_empresa
              and si_fecha      = @s_date

            if @w_count is null or @w_count = 0
               select @w_historico = 'N'
              else
               select @w_historico = 'S'

             -- Eliminar Datos de la Tabla Temporal
             set rowcount 0
             delete from cob_pagos..pg_impto_servicio_tmp where st_usuario = @s_user and st_session = @s_sesn
             delete from cob_pagos..cc_tmp                where ct_usuario = @s_user and ct_session = @s_sesn

             execute cob_pagos..sp_retencion_impuesto_renta
                     @s_user         = @s_user,
                     @s_sesn         = @s_sesn,
                     @i_fecha        = @s_date,
                     @i_historico    = @w_historico,
                     @i_empresa      = @i_empresa,
                     @i_detalle      = 'N',
                     @o_valtotret    = @w_valtotret out,
                     @o_valret       = @w_valret    out


             -- Eliminar Datos de la Tabla Temporal
             set rowcount 0
             delete from cob_pagos..pg_impto_servicio_tmp where st_usuario = @s_user and st_session = @s_sesn
             delete from cob_pagos..cc_tmp                where ct_usuario = @s_user and ct_session = @s_sesn

             if @w_valtotret is null select @w_valtotret = 0
             if @w_valret    is null select @w_valret    = 0

             select @w_pn_retimpret = @w_valret


          End


      begin tran
      -- RDG 02/01/2003
      -- Adicionada 3 Variables a el Insert de la Tabla cob_pagos..pg_control_ncrecaudacion
      if exists ( select 1 from cob_pagos..pg_person_empresa
                    where pe_empresa = @i_empresa and pe_conta = 1 and pe_impret = 1 )
         Begin

           --ref47
     select @w_cliente=(select en_ente from cobis..cl_ente where en_ced_ruc = a.pe_ruc)
     from cob_pagos..pg_person_empresa a
           where  pe_empresa = @i_empresa and pe_conta = 1 and pe_impret = 1

             select @w_producto = 'RECA',
                    @w_servicio = 'RECS'
            /* exec @w_return = cobis..pa_cons_fact_electronica
          @t_trn           = 1460,
          @i_mensaje       = 'N',
          @i_select_ind    = 'N',
          @i_producto      = @w_producto,
          @i_servicio      = @w_servicio,
          @i_ente          = @w_cliente,
          @o_ind_factelect = @w_ind_factelect out,
          @o_msj_error     = @w_msj_error out
         if @w_return != 0
         begin
            if @@trancount > 0   --REF 63
              rollback
            return @w_return
         end


       exec @w_return = cob_gov..sp_cseqnos_sri
        @i_empresa     = 1,
        @i_producto    = 3,
        @i_tipo_doc    = '7',
        @i_fact_elect  = @w_ind_factelect,
        @o_siguiente   = @o_secuencia  out,
        @o_msg_error   = @w_msj_error out
         if @w_return != 0
         begin
            if @@trancount > 0   --REF 63
              rollback
            return @w_return
         end



      exec @w_return =  cob_gov..sp_cons_autsri
       @t_trn           = 1670025,
       @i_no_cobis      = 'N',
       @i_mensaje       = 'S',
       @i_empresa       = 1,
       @i_producto      = 3,
       @i_tipo_doc      = '7',
       @i_fecha         = @s_date,
       @i_fact_elect    = @w_ind_factelect,
       @o_pto_estab       = @w_pto_estab out,
       @o_pto_emis        = @w_pto_emis  out ,
       @o_autorizacion    = @w_autorizacion    out,
       -----@o_fecha_validez  = @w_fecha_val      out,
       @o_fecval_formato   = @w_validez  out,
       @o_msj_error       = @w_msj_error      out,
       @o_fec_ini_vig_aut  = @w_fec_ini_vig_aut out, --ref50
       @o_fec_fin_vig_aut  = @w_fec_fin_vig_aut out  --ref50

       if @w_return != 0
       begin
          if @@trancount > 0   --REF 63
            rollback
          return @w_return
       end

*/


       -- select @w_sec_mas = @w_pto_estab + '-' +  @w_pto_emis + '-'  + right( "000000000"+convert(varchar(9), @o_secuencia) , 9)  --Miguel Aldaz 03-19-2008 --ref50

                  --ref47: Indicador de facturacion electronica
     /******************************/
					 select @w_ind_factelect = 'E' --REF 65
           Select @w_fecha_efec = DATEADD(day, @w_pe_dias, @s_date)

           if @w_pe_fpago <> 'NCRCTA'
              Select @w_pe_cuenta = null

         End

      select @w_costo_recauda = round((isnull(@w_pe_costo,0) * isnull(@w_total_trn,0)),2)


    -- RDG 02/10/2003
    -- Validar si Tiene Archivo de Impuesto
     select @w_count = isnull( count(1) , 0)
     from cob_pagos..pg_impto_servicio
     where si_empresa    = @i_empresa
       and si_fecha      = @s_date

     if @w_count is null or @w_count = 0
        Begin
          Select 'N'
          Select @w_valtotgra    = @w_total
          if exists ( select 1 from cob_pagos..pg_person_empresa
                      where pe_empresa = @i_empresa and pe_conta = 1 and pe_impret = 1 )

            Select @w_pn_retimpret = round(@w_valtotgra * @w_porc, 2)    --Miguel Aldaz 03/17/2008
        End
      else
        Begin
          Select 'S'
          Select @w_valtotgra = @w_valtotret
        End

      -- Verificar En el Caso de que venga null las Variables
      if @w_valtotgra    is null select @w_valtotgra    = 0
      if @w_pn_retimpret is null select @w_pn_retimpret = 0

      -->hy-20-junio-2005
      if @i_empresa in (1371) --! DGA 03/OCT/2005
      begin
         select @w_pn_retimpret = round(@w_retencion_mov * @w_porc, 2) --Miguel Aldaz 03/17/2008
      end

      -->lfcm Mayo/09/2006
      --Forma Inicial:
      --Cambios realizados:
      if @i_empresa in (617)
        select @w_pn_retimpret = round(@w_retencion_mov, 2)

      --Emelgur
      if @i_empresa in (1127)
      begin
        select @w_pn_retimpret = round(@w_retencion_mov, 2)
        select @w_retencion_mov = round(@w_retencion_mov * 100, 2)        --lfcm 24-abril-2008
      end
      --<lfcm Mayo/09/2006


      --Miguel Aldaz 02-29-2008 pn_valor_uno guarda lo mismo que pn_valor

      -->Para la empresa 1371 EEQ debe grabar el valor de la Base Imponible, no el total   lfcm 07-abril-2008
      --if @i_empresa in (1371, 1127)      --lfcm 24-abril-2008
      --begin
        -- select @w_valtotgrabi = @w_retencion_mov
      --end
      --else
         select @w_valtotgrabi = @w_valtotgra
      --<Para la empresa 1371 EEQ debe grabar el valor de la Base Imponible, no el total   lfcm 07-abril-2008

      if  @w_imdCost = 'S'   --REF8 SMERINO BELCORP
      begin
            
             select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
              --- saca el valor total de comision por los canales
	     select @w_costo_recauda=sum(pg_total) 
	     from cob_pagos..pg_control_com_canal
	     where pg_empresa=@i_empresa
	     and pg_fecha    =@w_fecha_pro  --se  debe de validar fechas
       end
            
      insert cob_pagos..pg_control_ncrecaudacion
             (pn_empresa,pn_fecha_rec,pn_fecha_pago,pn_valor,pn_retencion,pn_costo_recauda,pn_cont_trn,
              pn_forma_pago, pn_estado, pn_secuencial, pn_retimpret, pn_cta_banco,
              pn_fecha_efec, pn_tipo_empresa, pn_sec_servicio , pn_valor_uno, pn_fact_elect, pn_autorizacion, pn_fecval_formato, pn_fecha_ini_vig, pn_fecha_fin_vig) --ref47: Indicador de facturacion electronica
      values (@i_empresa,@s_date, @w_fecha_pago, @w_valtotgra ,@w_retencion,@w_costo_recauda,@w_total_trn,
              @w_pe_fpago,   'N', @w_sec_mas, @w_pn_retimpret, @w_pe_cuenta, null , 0, @w_sec_servicio , @w_valtotgrabi,@w_ind_factelect,@w_autorizacion,@w_validez, @w_fec_ini_vig_aut, @w_fec_fin_vig_aut)    --ref47: Indicador de facturacion electronica

      if @@rowcount = 0
       begin
          if @@trancount > 0  --REF 63
              rollback tran
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 2103001,
               @i_msg    = 'ERROR EN TABLA DE NC A EMPRESAS'
          return 2103001
       end

      --! FMV BASE IMPONIBLE
      if @i_empresa in (1127, 617, 1371)
      begin

        select @w_pe_cuenta = "ROLBAN." + convert(varchar, @i_empresa) + "." + convert(varchar, convert(datetime, @s_date), 112)

  insert into cob_pagos..pg_impto_servicio_his
  ( sh_fechaefec, sh_empresa, sh_codigo, sh_id_detalle, sh_valor,
    sh_orig, sh_valorf, sh_retimp, sh_factura )
  values
  ( @s_date, @i_empresa, @w_pe_cuenta, 1, @w_valtotgra,
    0, @w_retencion_mov, @w_pn_retimpret, @w_pe_cuenta )

      if @@error <> 0
      begin
            if @@trancount > 0  --REF 63
              rollback tran
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 2103001,
                 @i_msg    = 'ERRRO EN RESGISTRAR IMPUESTO'
            return 2103001
      end

      end




     commit tran


   end


if @i_opcion = 'T'              -- Consulta de totales
   begin

    if @i_empresa not in (118,1719, 3, 219, 222, 2234, 2319, 1, 2237, 2235, 2572, 2575,2494, 2236,1430,39,4994,38,8688,42 , 7749) -- ,144) --Ref085:msilvag  --ref80 pricaura   -- Ref.71: 144 CS, --ref79 empresa con siderada en catálogo MEER
    and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo  --REF 63 64
                           where tabla in (select codigo from cobis..cl_tabla
                                           where tabla = 'sv_tvcable_online')
                                           and valor = 'S')  --SMERINO NEW TVCABLE --ref55: DAPV/CNEL
    and @i_empresa not in (select pe_empresa from cob_pagos..pg_person_empresa
         		   where pe_cod_grupo = 4994) ---CNEL/CATEG
    --smerino aumenta campo ts_contratado
    and @i_empresa not in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')    
    begin

    select '   ' = ts_oficina,
    'OFICINA ' = substring(of_nombre,1,15),
    'CORR.' = ts_correccion,
    'VERIFICADO' = isnull(cv_estado,'N'),
    'VALOR A GUARDAR' = (case @i_empresa                --GAMC - 16/05/2008 - SOAT
              when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- - isnull(convert(money,ts_autoriz_aut),0)),0)
              when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- REF 47
              when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- REF 48
                      when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 54
              when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 59
              when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0) --Ref061:msilvag
              when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
              --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)
        --Ref062:msilvag Fin
        when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
        when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- REF: 75 SMM
        when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
		--Ref068:msilvag Inicio
        when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
        when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
        when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
        when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
        when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)               -- JPM Ref.76: megadatos
  when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- JPM Ref.72 TRB IWS
        --Ref068:msilvag Fin
              else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
              end),
    'RETENCION' = isnull(sum(ts_ocasional),0),
    'TOTAL   ' = (case @i_empresa                   --GAMC - 16/05/2008 - SOAT
            when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- isnull(convert(money,ts_autoriz_aut),0)),0)
            when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- REF 47
            when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- REF 48
                  when 451 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- ref: 54
                  when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- REF 59
                  when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)  ),0) --Ref061:msilvag
                  when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 61
                --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)  ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)  ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)  ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)
    --Ref062:msilvag Fin
    when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
    when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0) --REF: 75 SMM
    when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
   --Ref068:msilvag Inicio
    when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)--- JPM Ref.72 TRB IWS
    when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)               -- JPM Ref.76: megadatos
	when 120 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) --Ref084:DOLAYA
    --Ref068:msilvag Fin
            else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
            end),
    'CANTIDAD' = count(1),
    'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
     from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
    and ts_usuario = isnull(@i_usuario,ts_usuario)
   group by ts_oficina, of_nombre, ts_correccion, cv_estado
    order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

    select @w_val_n = (case @i_empresa                    --GAMC - 16/05/2008 - SOAT
              when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)
              when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 47
              when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 48
                      when 451 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) -- ref: 54
              when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 59
              when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)  --Ref061:msilvag
              when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 61
              --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)
    --Ref062:msilvag Fin
    when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
    when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- REF:75 SMM
    when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
--Ref068:msilvag Inicio
    when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)               -- JPM Ref.76: megadatos
	when 6087 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref87
	when 1125 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref90
    --Ref068:msilvag Fin
    when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --JPM Ref.72
	when 120 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --Ref084:DOLAYA
              else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0)),0)
              end),
    @w_valor_n = (case @i_empresa                   --GAMC - 16/05/2008 - SOAT
            when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- - isnull(convert(money,ts_autoriz_aut),0)),0)
            when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- REF 47
            when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- REF 48
                  when 451 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- ref: 54
            when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- REF 59
            when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0) --Ref061:msilvag
            when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 61
              --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)    
    --Ref062:msilvag Fin
    when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
     when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)  -- REF:75 SMM
    when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
   --Ref068:msilvag Inicio
    when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)     -- JPM Ref.76: megadatos
	when 6087 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)     -- ref87
	when 1125 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)     -- ref90
    --Ref068:msilvag Fin
    when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0)-- JPM Ref.72
	when 120 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)     --Ref084:DOLAYA
            else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
            end),
    @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_n = count(1),
    @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
     and ts_correccion = 'N'
    and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006  
    and ts_usuario = isnull(@i_usuario,ts_usuario)
    

    select @w_val_s = --isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0)),0),
              (case @i_empresa                    --GAMC - 16/05/2008 - SOAT
              when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)
              when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 47
              when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 48
                      when 451 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) -- ref: 54
              when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 59
              when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) --Ref061:msilvag
              when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 61
                --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)    
    --Ref062:msilvag Fin
    when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
    when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- REF: 75 SMM
    when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
    --Ref068:msilvag Inicio
    when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)             -- JPM Ref.76: megadatos
	when 6087 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref87
	when 1125 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref90
    --Ref068:msilvag Fin
    when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --JPM Ref.72
              else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0)),0)
              end),
    @w_valor_s = --isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0),
          (case @i_empresa                    --GAMC - 16/05/2008 - SOAT
            when 862 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0)-- - isnull(convert(money,ts_autoriz_aut),0)),0)
            when 115 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0)-- REF 47
            when 114 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0)-- REF 48
                  when 451 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0)-- ref: 54
            when 361 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --REF 59
            when 1371 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)  --Ref061:msilvag
            when 5482 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)-- ref: 61
             --Ref062:msilvag Inicio
    when 360 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 4 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 6 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0)
    when 7256 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0) ),0)
    --Ref062:msilvag Fin
    when 156 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 61
    when 8521 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- REF: 75 SMM
    when 5994 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0)-- ref: 64
    --Ref068:msilvag Inicio
    when 1707 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1708 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6951 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 6952 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)
    when 1089 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0)           -- JPM Ref.76: megadatos
	when 6087 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref87
	when 1125 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0) -- ref90
    --Ref068:msilvag Fin
    when 8269 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) --JPM Ref.72
            else isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
            end),
    @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_s = count(1),
    @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and ts_correccion = 'S'
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006   
    and ts_usuario = isnull(@i_usuario,ts_usuario)


   
    ---AUMENTA SMERINO BELCOPR 2 01/28/2016
   --select @w_val_cnb = sum(isnull(cc_mont_trx ,0)),
	    --@w_can_cnb = count(1)
    --from cob_pagos..pg_concil_cnb
    --where cc_fecha=@w_fecha_pro
    --and cc_conciliada='NO'
    --and cc_estatus_bco='NO' and cc_estatus_emp_serv='SI'
    --and cc_cod_serv='0901'   --SERVICIO BELCORP CNB
  --
     
  /*
  -- Ref.71: CS -->
  if  @i_empresa = 144
  begin
    select '   ' = ts_oficina,
           'OFICINA ' = substring(of_nombre,1,15),
           'CORR.' = ts_correccion,
           'VERIFICADO' = isnull(cv_estado,'N'),
           'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
           'RETENCION' = isnull(sum(ts_ocasional),0),
           'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
           'CANTIDAD' = count(1),
           'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
     from cob_cuentas..cc_tran_servicio
           inner join cobis..cl_oficina
               on  ts_oficina = of_oficina
           left join cob_pagos..pg_control_verificacion
               on ts_causa = convert(varchar,cv_empresa)
              and ts_oficina = cv_oficina
     where ts_tipo_transaccion in (select convert(int,b.codigo)
                                    from cobis..cl_tabla a, cobis..cl_catalogo b
                                    where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
      and  ts_causa = convert(varchar,@i_empresa)
      and  ts_usuario = isnull(@i_usuario,ts_usuario)
      and  ts_tipo_chequera <> 'CNB'
      and ts_tsfecha = @w_fecha_pro
     group by ts_oficina, of_nombre, ts_correccion, cv_estado
    UNION ALL
    select '   ' = ts_oficina,
           'OFICINA ' = substring(of_nombre,1,15),
           'CORR.' = ts_correccion,
           'VERIFICADO' = isnull(cv_estado,'N'),
           'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
           'RETENCION' = isnull(sum(ts_ocasional),0),
           'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
           'CANTIDAD' = count(1),
           'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
            inner join cobis..cl_oficina
              on  ts_oficina = of_oficina
            left join cob_pagos..pg_control_verificacion
              on ts_causa = convert(varchar,cv_empresa)
             and ts_oficina = cv_oficina
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                          where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tipo_chequera = 'CNB'
        and ts_tsfecha = @w_fecha_pro
        and ts_tsfecha=cc_fecha
        and ts_secuencial=cc_sec_trans
        and cc_conciliada='SI'
      group by ts_oficina, of_nombre, ts_correccion, cv_estado

     select @w_val_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_n = count(1),
            @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
          and ts_correccion = 'N'
          and ts_tipo_chequera <> 'CNB'
          and ts_causa = convert(varchar,@i_empresa)
          and ts_usuario = isnull(@i_usuario,ts_usuario)
          and ts_tsfecha = @w_fecha_pro
     
     select @w_val_n =  @w_val_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_n = @w_valor_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_n = @w_val_ret_n + isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_n = @w_can_n  + count(1),
            @w_com_n =  @w_com_n + isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V')
        and ts_correccion = 'N'
        and ts_tipo_chequera = 'CNB'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        and ts_tsfecha=cc_fecha
        and ts_secuencial=cc_sec_trans
        and cc_conciliada='SI'
    
     select @w_val_s     = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_s   = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_s     = count(1),
            @w_com_s     = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
          from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                          from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
          and ts_correccion = 'S'
          and ts_tipo_chequera <> 'CNB'
          and ts_causa = convert(varchar,@i_empresa)
          and ts_usuario = isnull(@i_usuario,ts_usuario)
          and ts_tsfecha = @w_fecha_pro
          
      end
  -- <-- Ref.71: CS
  */
  
   if @i_empresa =7256  --smerino belcorp
   begin
    ---AUMENTA SMERINO BELCOPR 2
    select @w_val_c1 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
           @w_val_ret_c1 = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_can_c1 = count(1)
    from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
    where ts_tsfecha=cc_fecha
    and ts_secuencial=cc_sec_trans
    and cc_conciliada='NO'
    and ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
       						 from cobis..cl_tabla a, cobis..cl_catalogo b
       						where a.tabla = 'sv_trx_nordif'
       						and a.codigo = b.tabla
						and estado = 'V')
      ---and cc_estatus_bco='SI' and cc_estatus_emp_serv='NO'
    and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
    and ts_tsfecha = @w_fecha_pro
	and ts_terminal = cc_terminal --ref091

    ---AUMNETA POR LAS TRX 3928 EN LA CONCILIACION CNB ESTAN CON FECHA ANTERIOR---
    
    select @w_val_c2 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0)),0),
	   @w_val_ret_c2 = isnull(sum(isnull(ts_ocasional,0)),0),
	   @w_can_c2 = count(1)
	from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
	where ts_tsfecha = @w_fecha_pro
	and ts_secuencial=cc_sec_trans
	and ts_tipo_transaccion in (3928)
	and ts_causa = convert(varchar,@i_empresa)   
	and cc_fecha= @w_fecha_anterior
	and cc_conciliada='NO'
	and ts_terminal = cc_terminal --ref091
	
	
      select @w_val_c =  isnull(@w_val_c1,0)  +  isnull(@w_val_c2,0),
             @w_val_ret_c =  isnull(@w_val_ret_c1,0) + isnull(@w_val_ret_c2,0),
             @w_can_c = isnull(@w_can_c1,0) +  isnull(@w_can_c2,0) 
      
     end
      
	
    end

  -- Ref.71: CS -->
--if  @i_empresa = 144 --ref79 empresa considerada en catálogo MEER
    if @i_empresa in (select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo --ref79 empresas MEER
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')  
  begin
    select '   ' = ts_oficina,
           'OFICINA ' = substring(of_nombre,1,15),
           'CORR.' = ts_correccion,
           'VERIFICADO' = isnull(cv_estado,'N'),
           'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
           'RETENCION' = isnull(sum(ts_ocasional),0),
           'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
           'CANTIDAD' = count(1),
           'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
     from cob_cuentas..cc_tran_servicio
           inner join cobis..cl_oficina
               on  ts_oficina = of_oficina
           left join cob_pagos..pg_control_verificacion
               on ts_causa = convert(varchar,cv_empresa)
              and ts_oficina = cv_oficina
     where ts_tipo_transaccion in (select convert(int,b.codigo)
                                    from cobis..cl_tabla a, cobis..cl_catalogo b
                                    where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
      and  ts_causa = convert(varchar,@i_empresa)
      and  ts_usuario = isnull(@i_usuario,ts_usuario)
      and  ts_tipo_chequera <> 'CNB'
      and ts_tsfecha = @w_fecha_pro
     group by ts_oficina, of_nombre, ts_correccion, cv_estado
    UNION ALL
    select '   ' = ts_oficina,
           'OFICINA ' = substring(of_nombre,1,15),
           'CORR.' = ts_correccion,
           'VERIFICADO' = isnull(cv_estado,'N'),
           'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
           'RETENCION' = isnull(sum(ts_ocasional),0),
           'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
           'CANTIDAD' = count(1),
           'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_pagos..pg_concil_cnb,cob_cuentas..cc_tran_servicio
            inner join cobis..cl_oficina
              on  ts_oficina = of_oficina
            left join cob_pagos..pg_control_verificacion
              on ts_causa = convert(varchar,cv_empresa)
             and ts_oficina = cv_oficina
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                          where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tipo_chequera = 'CNB'
        and ts_tsfecha = @w_fecha_pro
        and ts_tsfecha=cc_fecha
        and ts_secuencial=cc_sec_trans
        and cc_conciliada='SI'
        and cc_causa = ts_causa --Ref089:msilvag 
		and ts_terminal = cc_terminal --ref091
      group by ts_oficina, of_nombre, ts_correccion, cv_estado

     select @w_val_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_n = count(1),
            @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
          and ts_correccion = 'N'
          and ts_tipo_chequera <> 'CNB'
          and ts_causa = convert(varchar,@i_empresa)
          and ts_usuario = isnull(@i_usuario,ts_usuario)
          and ts_tsfecha = @w_fecha_pro
     
     select @w_val_n =  @w_val_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_n = @w_valor_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_n = @w_val_ret_n + isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_n = @w_can_n  + count(1),
            @w_com_n =  @w_com_n + isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
      where ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V')
        and ts_correccion = 'N'
        and ts_tipo_chequera = 'CNB'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        and ts_tsfecha=cc_fecha
        and ts_secuencial=cc_sec_trans
        and cc_conciliada='SI'
        and cc_causa = ts_causa --Ref089:msilvag 
		and ts_terminal = cc_terminal --ref091		
        
        --ini ref 88
        select      @w_val_n =  @w_val_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
		            @w_valor_n = @w_valor_n + (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
		            @w_val_ret_n = @w_val_ret_n + isnull(sum(isnull(ts_ocasional,0)),0),
		            @w_can_n = @w_can_n  + count(1),
		            @w_com_n =  @w_com_n + isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
		      from cob_cuentas..cc_tran_servicio,cob_pagos..pg_concil_cnb
		      where ts_tipo_transaccion in (select convert(int,b.codigo)
		                                     from cobis..cl_tabla a, cobis..cl_catalogo b
		                                     where a.tabla = 'sv_trx_nordif'
		                                       and a.codigo = b.tabla
		                                       and estado = 'V')
		        and ts_correccion = 'N'
		        and ts_tipo_chequera = 'CNB'
		        and ts_causa = convert(varchar,@i_empresa)
		        and ts_usuario = isnull(@i_usuario,ts_usuario)
		        and ts_tsfecha = @w_fecha_pro
		        and cc_fecha = @w_fecha_anterior
		        and ts_secuencial=cc_sec_trans
        and cc_conciliada='SI'
        and cc_causa = ts_causa --Ref089:msilvag 
		and ts_terminal = cc_terminal --ref091		
        
        --fin ref 88
    
     select @w_val_s     = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
            @w_valor_s   = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
            @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
            @w_can_s     = count(1),
            @w_com_s     = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
          from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                          from cobis..cl_tabla a, cobis..cl_catalogo b
                                         where a.tabla = 'sv_trx_nordif'
                                           and a.codigo = b.tabla
                                           and estado = 'V')
          and ts_correccion = 'S'
          and ts_tipo_chequera <> 'CNB'
          and ts_causa = convert(varchar,@i_empresa)
          and ts_usuario = isnull(@i_usuario,ts_usuario)
          and ts_tsfecha = @w_fecha_pro
          
      end
  -- <-- Ref.71: CS

    if @i_empresa = 4994 --ref55: DAPV/CNEL  --- 05/09/2012
    begin
      select '   ' = ts_oficina,
          'OFICINA ' = substring(of_nombre,1,15),
          'CORR.' = ts_correccion,
          'VERIFICADO' = isnull(cv_estado,'N'),
          'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
          'RETENCION' = isnull(sum(ts_ocasional),0),
          'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
          'CANTIDAD' = count(1),
          'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                 on  ts_oficina = of_oficina   --REF 63
                 left join cob_pagos..pg_control_verificacion --REF 63
                 on ts_causa = convert(varchar,cv_empresa) --REF 63
                 and ts_oficina = cv_oficina --REF 63
        where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and  ts_propietario = convert(varchar,@i_empresa)
        and  ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        group by ts_oficina, of_nombre, ts_correccion, cv_estado

        select @w_val_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
               @w_valor_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n = count(1),
               @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_correccion = 'N'
        and ts_propietario = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro

        select @w_val_s =
              (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
              @w_valor_s =
              (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s = count(1),
              @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_correccion = 'S'
        and ts_propietario = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
    end

    --if @i_empresa in (825,1127,1719,1330,331,4981,4977,4978,4979,4980)--ref55: DAPV/CNEL    ---- 05/09/2012
    if @i_empresa in (select pe_empresa from cob_pagos..pg_person_empresa
         	      where pe_cod_grupo = 4994) ---CNEL/CATEG
    begin
      select '   ' = ts_oficina,
          'OFICINA ' = substring(of_nombre,1,15),
          'CORR.' = ts_correccion,
          'VERIFICADO' = isnull(cv_estado,'N'),
          'VALOR A GUARDAR' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
          'RETENCION' = isnull(sum(ts_ocasional),0),
          'TOTAL   ' = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
          'CANTIDAD' = count(1),
          'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
             on  ts_oficina = of_oficina   --REF 63
             left join cob_pagos..pg_control_verificacion --REF 63
             on ts_causa = convert(varchar,cv_empresa) --REF 63
             and ts_oficina = cv_oficina --REF 63
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and  ts_causa = convert(varchar,@i_empresa)
        and  ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        and ts_fecha = @w_fecha_pro
        group by ts_oficina, of_nombre, ts_correccion, cv_estado

        select @w_val_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
               @w_valor_n = (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n = count(1),
               @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_correccion = 'N'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        and ts_fecha = @w_fecha_pro

        select @w_val_s =
              (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0)),
              @w_valor_s =
              (isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0)),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s = count(1),
              @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                       where a.tabla = 'sv_trx_nordif'
                                         and a.codigo = b.tabla
                                         and estado = 'V')
        and ts_correccion = 'S'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
        and ts_fecha = @w_fecha_pro
    end


    if @i_empresa = 39 --Ref #53: DAPV 22/Sept/2011 - 39 -Claro
    begin

        select '   ' = ts_oficina,
          'OFICINA ' = substring(of_nombre,1,15),
          'CORR.' = ts_correccion,
          'VERIFICADO' = isnull(cv_estado,'N'),
          'VALOR A GUARDAR' = (case @i_empresa
                                    when 39 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                                end),
          'RETENCION' = isnull(sum(ts_ocasional),0),
          'TOTAL   ' = (case @i_empresa
                             when 39 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                        end),
          'CANTIDAD' = count(1),
          'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
             on  ts_oficina = of_oficina   --REF 63
             left join cob_pagos..pg_control_verificacion --REF 63
             on ts_causa = convert(varchar,cv_empresa) --REF 63
             and ts_oficina = cv_oficina --REF 63
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
        and  ts_causa = convert(varchar,@i_empresa)
        and  ts_usuario = isnull(@i_usuario,ts_usuario)

        group by ts_oficina, of_nombre, ts_correccion, cv_estado

        select @w_val_n = (case @i_empresa
                                when 39 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                           end),
               @w_valor_n = (case @i_empresa
                                  when 39 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                             end),
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n = count(1),
               @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
        and ts_correccion = 'N'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)


        select @w_val_s =
              (case @i_empresa
                    when 39 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
               end),
              @w_valor_s =
              (case @i_empresa
                    when 39 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
               end),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s = count(1),
              @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
        and ts_correccion = 'S'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)

    end

    if @i_empresa in (38,42,8688) --Ref80 pricaura	--REF 63
    begin

    select 'COD OFIC' = ts_oficina,
           'OFICINA ' = substring(of_nombre,1,15),
           'CORR.' = ts_correccion,
           'VERIFICADO' = isnull(cv_estado,'N'),
           'VALOR A GUARDAR' = (case @i_empresa
                                    when 38 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                                    when 42 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
									when 8688 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
                                end),
           'RETENCION' = isnull(sum(ts_ocasional),0),
           'TOTAL   ' = (case @i_empresa
                             when 38 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                             when 42 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
							 when 8688 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
                        end),
          'CANTIDAD' = count(1),
          'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
             on  ts_oficina = of_oficina   --REF 63
             left join cob_pagos..pg_control_verificacion --REF 63
             on ts_causa = convert(varchar,cv_empresa) --REF 63
             and ts_oficina = cv_oficina --REF 63
        where ts_tipo_transaccion in (3427,43545)	--Ref80 pricaura
        and  ts_causa = convert(varchar,@i_empresa) --REF 63
        and  ts_usuario = isnull(@i_usuario,ts_usuario)
        and  ts_tsfecha = @w_fecha_pro

        group by ts_oficina, of_nombre, ts_correccion, cv_estado

        select @w_val_n = (case @i_empresa
                                when 38 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                                when 42 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
								when 8688 then  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
                           end),
               @w_valor_n = (case @i_empresa
                                  when 38 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                                  when 42 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
								  when 8688 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
                             end),
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n = count(1),
               @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (3427,43545)	--Ref80 pricaura
        and ts_correccion = 'N'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro





        select @w_val_s =
              (case @i_empresa
                    when 38 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                    when 42 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
					when 8688 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
               end),
              @w_valor_s =
              (case @i_empresa
                    when 38 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0)
                    when 42 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --REF 63
					when 8688 then isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),0) --Ref80 pricaura Primax
               end),
              @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_can_s = count(1),
              @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (3427,43545) --Ref80 pricaura Primax
        and ts_correccion = 'S'
        and ts_causa = convert(varchar,@i_empresa)
        and ts_usuario = isnull(@i_usuario,ts_usuario)
        and ts_tsfecha = @w_fecha_pro
    end

    -->lfcm 22-feb-2008  CATEG(Pestaña TOTALES)
        if @i_empresa = 1   --lfcm 22-feb-2008
      begin
          select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008

      select '   ' = ts_oficina,
      'OFICINA ' = substring(of_nombre,1,15),
      'CORR.' = ts_correccion,
      'VERIFICADO' = isnull(cv_estado,'N'),
      'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0),
      'RETENCION' = isnull(sum(ts_ocasional),0),
      'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
      'CANTIDAD' = count(1),
      'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
      where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                         from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                          and a.codigo = b.tabla
                                          and estado = 'V')
      and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
      and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008
      group by ts_oficina, of_nombre, ts_correccion, cv_estado
      order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

      select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
      @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
      @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_can_n = count(1),
      @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                         from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                          and a.codigo = b.tabla
                                          and estado = 'V')
      and ts_correccion = 'N'
      and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008
      and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006

      select @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0),
      @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
      @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_can_s = count(1),
      @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                         from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                          and a.codigo = b.tabla
                                          and estado = 'V')
      and ts_correccion = 'S'
      and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008
      and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
      end

    --<lfcm 22-feb-2008  Consulta TOTALES CATEG

    if @i_empresa in (2494)   --TC 08/15/2008 IESS
    begin
                select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso    --lfcm 22-mayo-2008
    select '   ' = ts_oficina,
    'OFICINA ' = substring(of_nombre,1,15),
    'CORR.' = ts_correccion,
    'VERIFICADO' = isnull(cv_estado,'N'),
    'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0) ,
    'RETENCION' = isnull(sum(ts_ocasional),0),
    'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    'CANTIDAD' = count(1),
    'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
    and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008
    group by ts_oficina, of_nombre, ts_correccion, cv_estado
    order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

    select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0) ,
    @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0) ,
    @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_n = count(1),
    @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and ts_correccion = 'N'
    and ts_fecha = @w_fecha_pro    --TC 08/15/2008
    and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006



    select @w_val_s =
      isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0) ,
    @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_s = count(1),
    @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and ts_correccion = 'S'
    and ts_fecha = @w_fecha_pro    --TC 08/15/2008
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006

    end

    -->Municipio de Ibarra     lfcm 18-diciembre-2007
    if @i_empresa in (2234, 2319, 2237, 2235, 2236,1430, 7749 ) --Ref085:msilvag  --Wise - 05/sep/2008 - M. Libertad = 2236
    begin
    select '   ' = ts_oficina,
    'OFICINA ' = substring(of_nombre,1,15),
    'CORR.' = ts_correccion,
    'VERIFICADO' = isnull(cv_estado,'N'),
    'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0),
    'RETENCION' = isnull(sum(ts_ocasional),0),
    'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0), -- - isnull(convert(money,ts_autoriz_aut),0)),0), --GAMC - 29/02/2008 - Municipio de Samborondon
    'CANTIDAD' = count(1),
    'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
    and ts_usuario = isnull(@i_usuario,ts_usuario)
    group by ts_oficina, of_nombre, ts_correccion, cv_estado
    order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

    select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
    @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_n = count(1),
    @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and ts_correccion = 'N'
    and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006
    --<Municipio de Ibarra     lfcm 18-diciembre-2007
    and ts_usuario = isnull(@i_usuario,ts_usuario)

    select @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ),0),
    @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
    @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_s = count(1),
    @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
    and ts_correccion = 'S'
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    and ts_usuario = isnull(@i_usuario,ts_usuario)
    end


  --GAMC - 04/08/2008 - CTG - ini
  if @i_empresa in (2572,2575)
  begin
    select '   ' = ts_oficina,
      'OFICINA ' = substring(of_nombre,1,15),
      'CORR.' = ts_correccion,
      'VERIFICADO' = isnull(cv_estado,'N'),
      'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) +  isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      'RETENCION' = isnull(sum(ts_ocasional),0),
      'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      'CANTIDAD' = count(1),
      'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0) -- Ref081:msilvag sum(isnull(ts_aporte_iess, 0)) ----isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
      where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                       from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_trx_nordif'
                      and a.codigo = b.tabla
                      and estado = 'V')
      and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006


      group by ts_oficina, of_nombre, ts_correccion, cv_estado
      order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

      select @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_can_n = count(1),
      @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                       from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_trx_nordif'
                      and a.codigo = b.tabla
                      and estado = 'V')
      and ts_correccion = 'N'
      and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006



      select @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0), -- GAMC - 04/08/2008 - CTG,
      @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_can_s = count(1),
      @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                       from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_trx_nordif'
                      and a.codigo = b.tabla
                      and estado = 'V')
      and ts_correccion = 'S'

    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    end
  --GAMC - 04/08/2008 - CTG - fin


     -->Consulta de Totales de CORPEI lfcm 26-nov-2007
    if @i_empresa in (219, 222)
    begin
        select '   ' = ts_oficina,
        'OFICINA ' = substring(of_nombre,1,15),
        'CORR.' = ts_correccion,
        'VERIFICADO' = isnull(cv_estado,'N'),
        'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0),
        'RETENCION' = isnull(sum(ts_ocasional),0),
        'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0),
        'CANTIDAD' = count(1),
        'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
           on  ts_oficina = of_oficina   --REF 63
           left join cob_pagos..pg_control_verificacion --REF 63
           on ts_causa = convert(varchar,cv_empresa) --REF 63
           and ts_oficina = cv_oficina --REF 63
        where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
        and  ts_causa = convert(varchar,@i_empresa)
        group by ts_oficina, of_nombre, ts_correccion, cv_estado
        order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION

        select
        @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0),
        @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0),
        @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
        @w_can_n = count(1),
        @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
        and ts_correccion = 'N'
        and ts_causa = convert(varchar,@i_empresa)

        select
        @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)),0),
        @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)),0),
        @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
        @w_can_s = count(1),
        @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
        and ts_correccion = 'S'
        and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    end
    --<Consulta de Totales de CORPEI


      if @i_empresa = 3   -- PACIFICTEL     lfcm 12-enero-2007
  begin
    select '   ' = ts_oficina,
    'OFICINA ' = substring(of_nombre,1,15),
    'CORR.' = ts_correccion,
    'VERIFICADO' = isnull(cv_estado,'N'),
    'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0),
    'RETENCION' = isnull(sum(ts_ocasional),0),
    'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    'CANTIDAD' = count(1),
    'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
         on  ts_oficina = of_oficina   --REF 63
         left join cob_pagos..pg_control_verificacion --REF 63
         on ts_causa = convert(varchar,cv_empresa) --REF 63
         and ts_oficina = cv_oficina --REF 63
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                                and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                                and estado = 'V')
    and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
    group by ts_oficina, of_nombre, ts_correccion, cv_estado
    order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION


    select --@w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0)),0),
    @w_val_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    @w_valor_n = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
    @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_n = count(1),
    @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                                and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                                and estado = 'V')
    and ts_correccion = 'N'
    and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006

    select --@w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0)),0),
    @w_val_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
    @w_valor_s = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),
    @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
    @w_can_s = count(1),
    @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                                and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                                and estado = 'V')
    and ts_correccion = 'S'
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    end


     ---SMERINO TVCABLE--------------------------
           if @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo
                                      where tabla in (select codigo from cobis..cl_tabla
                                      where tabla = 'sv_tvcable_online')
                                        and valor = 'S') --SMERINO NEW TVCABLE

           begin


            select '   ' = ts_oficina,
               'OFICINA ' = substring(of_nombre,1,15),
               'CORR.' = ts_correccion,
               'VERIFICADO' = isnull(cv_estado,'N'),
               'VALOR A GUARDAR' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) +  isnull(ts_contratado,0)),0),-- - isnull(convert(money,ts_autoriz_aut),0)),0)
               'RETENCION' = isnull(sum(ts_ocasional),0),
               'TOTAL   ' = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),--- isnull(convert(money,ts_autoriz_aut),0)),0)
               'CANTIDAD' = count(1),
               'COMISION' = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
               from cob_cuentas..cc_tran_servicio inner join cobis..cl_oficina  --REF 63
                   on  ts_oficina = of_oficina   --REF 63
                   left join cob_pagos..pg_control_verificacion --REF 63
                   on ts_causa = convert(varchar,cv_empresa) --REF 63
                   and ts_oficina = cv_oficina --REF 63
               where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                                 where a.tabla = 'sv_trx_nordif'
                                                   and a.codigo = b.tabla
                                                   and estado = 'V')
               and  ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_fecha = @w_fecha_pro
               group by ts_oficina, of_nombre, ts_correccion, cv_estado
               order by ts_oficina, of_nombre, ts_correccion, cv_estado  --REF51: REAM MIGRACION


               select @w_val_n =isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
                      @w_valor_n =isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0),-- - isnull(convert(money,ts_autoriz_aut),0)),0)
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_n = count(1),
               @w_com_n = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
               from cob_cuentas..cc_tran_servicio
               where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                                 where a.tabla = 'sv_trx_nordif'
                                                   and a.codigo = b.tabla
                                                   --and convert(smallint,b.valor) = @i_empresa
                                                   and estado = 'V')
                and ts_correccion = 'N'
               and ts_causa = convert(varchar,@i_empresa)  --lfcm 13-julio-2006
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_fecha = @w_fecha_pro  ---smerino

               select @w_val_s =  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),0),
               @w_valor_s =  isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0),-- - isnull(convert(money,ts_autoriz_aut),0)),0)
               @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_can_s = count(1),
               @w_com_s = isnull(sum(isnull(convert(money,ts_autoriz_aut),0)), 0)
               from cob_cuentas..cc_tran_servicio
               where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                                 where a.tabla = 'sv_trx_nordif'
                                                   and a.codigo = b.tabla
                                                   --and convert(smallint,b.valor) = @i_empresa
                                                   and estado = 'V')
               and ts_correccion = 'S'
               and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
               and ts_usuario = isnull(@i_usuario,ts_usuario)
               and ts_fecha = @w_fecha_pro


          end
     -----fin smerino

--Calculo de Totales
      select @o_total       = @w_val_n     - @w_val_s  - isnull(@w_val_c,0)     --SMERINO BELCOP2
      select @o_recaudacion = @w_valor_n   - @w_valor_s - isnull(@w_val_c,0)    --SMERINO BELCOP2
      select @o_retencion   = @w_val_ret_n - @w_val_ret_s -  isnull(@w_val_ret_c,0) --SMERINO BELCOP2
      select @o_total_ofi   = @w_can_n     - @w_can_s - isnull(@w_can_c ,0)    -- 1,247.55 smerino belcorp
      select @o_comision    = @w_com_n     - @w_com_s

   end

if @i_opcion = 'G'              -- Datos para la generacion de archivo
begin
    -->lfcm 10-noviembre-2007
    --Si empresa consta en este Catálogo no genera archivo de respuesta
  if exists(select 1 from cobis..cl_catalogo
        where tabla in (select codigo from cobis..cl_tabla where tabla = 'sv_emp_no_genera_archivo')
        and estado = 'V'
        and codigo = convert(varchar(5),@i_empresa)) --Ref92 se agrega varchar(5)
  begin
      exec cobis..sp_cerror
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @w_sp_name,
      @i_msg           = 'ESTA EMPRESA NO GENERA ARCHIVO DE RESPUESTA',
      @i_num           = 111111
      return 1
  end
  --<lfcm 10-noviembre-2007

      if @i_codigo = 0
         begin
           select @w_trn = convert(int,b.codigo)
             from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'sv_trx_nor'
              and a.codigo = b.tabla
              and convert(smallint,b.valor) = @i_empresa
              and estado = 'V'

           exec cob_cuentas..sp_cambia_reverso
                @i_trn = @w_trn
         end

      create table #tmp_servicio_luz (ssn_corr int  null)

      insert into #tmp_servicio_luz (ssn_corr)
      select ts_ssn_corr
        from cob_cuentas..cc_tran_servicio
       where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
         and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
         and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
         and ts_correccion = 'S'
         and ts_ssn_corr <> null
         and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
         and ts_usuario = isnull(@i_usuario,ts_usuario)



/* --> DGA 03/ENE/2006 PARA EMPRESAS EXCEPTO MUNICIPIO DE QUITO <-- */
      if @i_empresa not in (1417, 2234, 1719, 334, 335, 336, 337, 338, 843, 320, 1299, 1538, 3, 2319, 2237, 2235, 115, 2236, 361,114,120,1430, 8269)   --lfcm 18-nov-2008  --REF 48 --REF 49  -- JPM Ref.72: 8269

       begin
         set rowcount 20
         select 'OFICINA' = ts_oficina,
          'CODIGO ' = (case @i_empresa
              when 825 then ts_referencia
                else substring(ts_referencia,1,(datalength(ts_referencia) - 1))
              end), /* Wise Emepe 09/12/2008  */

          'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
            'PAGO   ' = (case @i_empresa
                  when 862 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0))
                  when 2572 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) -- GAMC - 04/08/2008
                  when 2575 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) -- TC - 20/11/2009 CNTTTSV
                  when 2494 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --TC 07/21/2008 IESS
                  when 118 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --AME 10/15/2008 Ref46
                  when 156 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --REF 63
                  when 8521 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --REF 75 SMM
                  when 5994 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --REF 64
                  when 1371 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0 )) --Ref061:msilvag
      --Ref062:msilvag Inicio
      when 360 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0 ))
      when 4 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0 ))
      when 6 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0 ))
      --Ref062:msilvag Fin
                  else (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0))
                  end),
            'COMPRO ' = ts_endoso,
            'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
            'USUARIO' = ts_usuario,
            'PROCESO' = ts_clase,
            'FECHA'   = convert(varchar(10), ts_hora, 101),
            'SEC CORR' = isnull(ts_ssn_corr,0),
            'LOC     ' = ts_cheque_desde,
            'PROV    ' = ts_cheque_hasta,
            'FFACT   ' = ts_propietario,
            'REC     ' = isnull(ts_tipo_chequera,'VEN'),
            'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
            'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
            'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
            'BASE IMP' = ts_stick_imp, -- DGA 03/Oct/2005
            'SEM COBR' = ts_autorizante, -- DGA 29/Dic/2005
            'SECUENCI' = ts_secuencial, -- DGA 29/Dic/2005
            'TSFECHA ' = convert(varchar(10),ts_tsfecha, 101) -- DGA 29/Dic/2005

           from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                         from cobis..cl_tabla a, cobis..cl_catalogo b
                        where a.tabla = 'sv_trx_nordif'
                        and a.codigo = b.tabla
                        and estado = 'V')
          and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
          and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
          and ts_correccion = 'N'
          and (ts_endoso > @i_codigo)
          and ts_secuencial not in (select ssn_corr
                        from #tmp_servicio_luz)
          and ts_usuario = isnull(@i_usuario,ts_usuario)

          order by ts_endoso
        if @@rowcount = 20
       select @o_mas_mov = 'S'
        else
         select @o_mas_mov = 'N'
        set rowcount 0
       end

/* -- gmartillo 11/10/2008 Archivo de Respuesta para De Prati  */
      if @i_empresa = 115
      begin
        set rowcount 20

           select 'OFICINA' = ts_oficina,
            'CODIGO ' =  ts_referencia, --REF 47
            'DIGVER ' =  substring(ts_referencia,(datalength(ts_referencia)),1),
            'PAGO   ' =  isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) ,0), --REF 47
            'COMPRO ' = ts_endoso,
            'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
            'USUARIO' = ts_usuario,
            'PROCESO' = ts_clase,
            'FECHA'   = convert(varchar(10), ts_hora, 112) + convert(varchar(10), ts_hora, 108),
            'SEC CORR' = isnull(ts_ssn_corr,0),
            'LOC     ' = ts_cheque_desde,
            'PROV    ' = ts_cheque_hasta,
            'FFACT   ' = ts_propietario,
            'REC     ' = isnull(ts_tipo_chequera,'VEN'),
            'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
            'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
            'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
            'BASE IMP' = ts_stick_imp, -- DGA 03/Oct/2005
            'SEM COBR' = ts_autorizante, -- DGA 29/Dic/2005
            'SECUENCI' = ts_secuencial, -- DGA 29/Dic/2005
            'TSFECHA ' = convert(varchar(10),ts_tsfecha, 101), -- DGA 29/Dic/2005
            'CEDULA' = ts_descripcion_ec  --REF 47
             from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                           from cobis..cl_tabla a, cobis..cl_catalogo b
                          where a.tabla = 'sv_trx_nordif'
                          and a.codigo = b.tabla
                          and estado = 'V')
            and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
            and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
            and ts_correccion = 'N'
            and (ts_endoso > @i_codigo)
            and ts_secuencial not in (select ssn_corr
                          from #tmp_servicio_luz)

            order by ts_endoso
          if @@rowcount = 20
         select @o_mas_mov = 'S'
          else
           select @o_mas_mov = 'N'
        set rowcount 0

      end


--> lfcm 30-octubre-2008 Interagua: Se agrega el campo Fecha y Hora en el archivo de respuesta.
if @i_empresa = 361
begin
   set rowcount 20
   select 'OFICINA' = ts_oficina,
   'CODIGO ' = (case @i_empresa
   when 825 then ts_referencia
   else substring(ts_referencia,1,(datalength(ts_referencia) - 1))
   end), /* Wise Emepe 09/12/2008  */
   'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
   'PAGO   ' = (case @i_empresa
   when 862 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0))
   when 2572 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) -- GAMC - 04/08/2008
   when 2575 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) -- TC - 20/11/2009 CNTTTSV
   when 2494 then (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)) --TC 07/21/2008 IESS
   when 361 then  (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) ,0)) --REF 59
   else (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0))
   end),
   'COMPRO '    = ts_endoso,
   'CTABANCO'   = isnull(ts_cta_banco, '0000000000'),
   'USUARIO'    = ts_usuario,
   'PROCESO'    = ts_clase,
   'FECHA'      = convert(varchar(10), ts_hora, 101),
   'SEC CORR'   = isnull(ts_ssn_corr,0),
   'LOC     '   = ts_cheque_desde,
   'PROV    '   = ts_cheque_hasta,
   'FFACT   '   = ts_propietario,
   'REC     '   = isnull(ts_tipo_chequera,'VEN'),
   'RETEN   '   = isnull(ts_ocasional, 0),
   'PLANILLA'   = isnull(ts_agente, '0'),
   'NOMBRE  '   = ts_nombre,
   'BASE IMP'   = ts_stick_imp,
   'SEM COBR'   = ts_autorizante,
   'SECUENCI'   = ts_secuencial,
   'TSFECHA '   = convert(varchar(10),ts_tsfecha, 101),
   'FECHA_REAL' = convert(varchar(10),ts_hora,101),   --lfcm 30-octubre-2008
   'HORA_REAL'  = convert(varchar(10),ts_hora,108)    --lfcm 30-octubre-2008
   from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                 from cobis..cl_tabla a, cobis..cl_catalogo b
                                 where a.tabla = 'sv_trx_nordif'
                                 and a.codigo = b.tabla
                                 and estado = 'V')
   and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
   and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
   and ts_correccion = 'N'
   and (ts_endoso > @i_codigo)
   and ts_secuencial not in (select ssn_corr
   from #tmp_servicio_luz)
   --Ref086 and ts_clase = 'F'  --Ref082 pricaura
   order by ts_endoso

   if @@rowcount = 20
      select @o_mas_mov = 'S'
   else
      select @o_mas_mov = 'N'
   set rowcount 0
end
--< lfcm 30-octubre-2008 Interagua: Se agrega el campo Fecha y Hora en el archivo de respuesta.

-->REF 48  DATOS DE TRIPLE ORO INICIO
-- smerino aumneta campo ts_contratado
if @i_empresa = 114
begin
   set rowcount 20
   select 'OFICINA' = ts_oficina,
   'CODIGO ' =  ts_referencia,
   'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
   'PAGO   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0)+ isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) ,0),
   'COMPRO '    = ts_endoso,
   'CTABANCO'   = isnull(ts_cta_banco, '0000000000'),
   'USUARIO'    = ts_usuario,
   'PROCESO'    = ts_clase,
   'FECHA'      = convert(varchar(10), ts_hora, 101),
   'SEC CORR'   = isnull(ts_ssn_corr,0),
   'LOC     '   = ts_cheque_desde,
   'PROV    '   = ts_cheque_hasta,
   'FFACT   '   = ts_propietario,
   'REC     '   = isnull(ts_tipo_chequera,'VEN'),
   'RETEN   '   = isnull(ts_ocasional, 0),
   'PLANILLA'   = isnull(ts_agente, '0'),
   'NOMBRE  '   = ts_nombre,
   'BASE IMP'   = ts_stick_imp,
   'SEM COBR'   = ts_autorizante,
   'SECUENCI'   = ts_secuencial,
   'TSFECHA '   = convert(varchar(10),ts_tsfecha, 101),
   'FECHA_REAL' = convert(varchar(10),ts_hora,101),
   'HORA_REAL'  = convert(varchar(10),ts_hora,108)
   from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                                 from cobis..cl_tabla a, cobis..cl_catalogo b
                                 where a.tabla = 'sv_trx_nordif'
                                 and a.codigo = b.tabla
                                 and estado = 'V')
   and ts_causa = convert(varchar,@i_empresa)
   and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
   and ts_correccion = 'N'
   and (ts_endoso > @i_codigo)
   and ts_secuencial not in (select ssn_corr
   from #tmp_servicio_luz)
   order by ts_endoso

   if @@rowcount = 20
      select @o_mas_mov = 'S'
   else
      select @o_mas_mov = 'N'
   set rowcount 0
end
-->REF 48  DATOS DE TRIPLE ORO FIN


-->REF 49  DATOS DE DIRECTV PREPAGO INICIO
if @i_empresa = 120
begin
   set rowcount 20
   select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
   select
   'OFICINA' = ts_oficina,
   'CODIGO ' =  ts_referencia,
   'AUT.'    = ts_campo_alt_uno,
   'PAGO   ' = isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) ,0),
   'SECUENCI'   = ts_secuencial,
   'PRE_AUT.'   = isnull(ts_agente, '0'),
   'CTABANCO'   = isnull(ts_cta_banco, '0000000000'),
   'USUARIO'    = ts_usuario,
   'REC     '   = isnull(ts_tipo_chequera,'VEN'),
   'RETEN   '   = isnull(ts_ocasional, 0),
   'NOMBRE  '   = ts_nombre,
   'SEM COBR'   = ts_autorizante,
   'PROCESO'    = ts_clase,
   'SEC CORR'   = isnull(ts_ssn_corr,0),
   'FECHA CONTABLE'   = convert(varchar(10),ts_tsfecha, 101),
   'FECHA_REAL' = convert(varchar(10),ts_hora,101),
   'HORA_REAL'  = convert(varchar(10),ts_hora,108)
   from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (3925,3926,3928)
   and ts_causa = '120'
   and ts_correccion = 'N'
   and ts_tsfecha = @w_fecha_pro
   and (ts_secuencial > @i_codigo)
   and ts_secuencial not in (select ssn_corr from #tmp_servicio_luz)
   order by ts_secuencial

   if @@rowcount = 20
      select @o_mas_mov = 'S'
   else
      select @o_mas_mov = 'N'
   set rowcount 0
end
-->REF 49  DATOS DE DIRECTV PREPAGO FIN


/* --> DGA 03/ENE/2006  SOLO PARA MUNICIPIO DE QUITO - GENERACION DE ARCHIVO */
      if @i_empresa = 1417
       begin
         set rowcount 20
         select 'OFICINA' = ts_oficina,
          'CODIGO ' = ts_referencia,
          'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
            'PAGO   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)),
            'COMPRO ' = ts_endoso,
            'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
            'USUARIO' = ts_usuario,
            'PROCESO' = ts_clase,
            'FECHA'   = convert(varchar(10), ts_hora, 101),
            'SEC CORR' = isnull(ts_ssn_corr,0),
            'LOC     ' = ts_cheque_desde,
            'PROV    ' = ts_cheque_hasta,
            'FFACT   ' = ts_propietario,
            'REC     ' = isnull(ts_tipo_chequera,'VEN'),
            'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
            'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
            'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
            'BASE IMP' = ts_stick_imp, -- DGA 03/Oct/2005
            'SEM COBR' = ts_autorizante, -- DGA 29/Dic/2005
            'SECUENCI' = ts_secuencial, -- DGA 29/Dic/2005
            'TSFECHA ' = convert(varchar(10),ts_tsfecha, 101) -- DGA 29/Dic/2005

           from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                         from cobis..cl_tabla a, cobis..cl_catalogo b
                        where a.tabla = 'sv_trx_nordif'
                        and a.codigo = b.tabla
                        and estado = 'V')
          and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
          and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
          and ts_correccion = 'N'
          and (ts_secuencial > @i_codigo)
          and ts_secuencial not in (select ssn_corr
                        from #tmp_servicio_luz)
          order by ts_secuencial
        if @@rowcount = 20
       select @o_mas_mov = 'S'
        else
         select @o_mas_mov = 'N'
        set rowcount 0
       end
/* <-- DGA 03/ENE/2006  */

    -->lfcm 12-dic-2007 Municipio de Ibarra
    if @i_empresa = 2234
    begin
        set rowcount 20
        select
        'TipoIdentificacion'   = ts_servicio,
        'NumeroIdentificacion' = ts_ced_ruc,
        'ClaveCatastral'       = ts_campo_alt_uno,
        'Referencia'           = ts_campo_alt_dos,
        'CodigoImpuesto'       = ts_propietario,
        'AnioTributacionFecha' = ts_stick_imp,
        'SecuenciaDividendo'   = ts_autorizante,
        'ValorTotal'           = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
        'EstadoPago'           = "P",
        'CodigoBanco'          = "037",
        'ReferenciaBanco'      = ts_secuencial,
        'FechaCobro'           = convert(varchar(10),ts_tsfecha,101),
        'CodigoCanal'          = ts_tipo_chequera
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                      from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                      and a.codigo = b.tabla
                                      and estado = 'V')
                                      and ts_causa = convert(varchar,@i_empresa)
        and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
        and ts_correccion = 'N'
        and (ts_secuencial > @i_codigo)
        and ts_secuencial not in (select ssn_corr
                                  from #tmp_servicio_luz)
        order by ts_secuencial

        if @@rowcount = 20
            select @o_mas_mov = 'S'
        else
            select @o_mas_mov = 'N'

        set rowcount 0
       end

-- DAPV -- 18/08/2011 M. Daule= 1430 Genera Archivo para Municipio.
          if @i_empresa = 1430
         begin
            set rowcount 20
            select
                'NumeroPredio'      = ts_campo_alt_uno,
                'CodigoImpuesto'    = ts_propietario,
                'AnioTributacion'   = ts_stick_imp,
                'SemestreCobro'     = ts_autorizante,
                'Valor_Total'       = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
                'CodigoPago'        = 'P',
                'Codigobanco'       = ts_cod_banco,
                'TransaccionBanco'= ts_secuencial,
                'FechaPago'     = ts_tsfecha,
                'CodigoCanal'       = ts_tipo_chequera,
                'Cod_Predial'       = ts_campo_alt_dos,
                'Referencia'        = ts_referencia
            from
                cob_cuentas..cc_tran_servicio a
            where ts_tipo_transaccion in (3221, 3215,4112)
            and ts_causa = convert(varchar,@i_empresa)
            and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
            and ts_correccion = 'N'
            and (ts_secuencial > @i_codigo)
            and ts_secuencial not in (select ssn_corr
                                          from #tmp_servicio_luz)
            and ts_usuario = isnull(@i_usuario,ts_usuario)
            order by ts_secuencial

            if @@rowcount = 20
                select @o_mas_mov = 'S'
            else
                select @o_mas_mov = 'N'

            set rowcount 0

  end





    --<lfcm 12-dic-2007 Municipio de Ibarra
  --GAMC - 26/02/2008 - Municipio de Samborondon - INI
  if @i_empresa = 2319
  begin
    set rowcount 20
      select
          'NumeroPredio'        = ts_campo_alt_uno,
          'CodigoImpuesto'      = ts_propietario,
          'AnnoTributacion'     = ts_stick_imp,
          'SemestreCobro'       = ts_autorizante,
          'ValorTotal'        = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
          'CodigoPago'        = 'P',
          'CodigoBanco'       = '037',
          'TransaccionBanco'      = ts_secuencial,
          'FechaPago'         = ts_tsfecha,
          'CodigoCanal'       = ts_tipo_chequera,
          'CodigoCatastral'     = substring(ts_descripcion_ec, 1, 60),
          'Referencia'        = ts_campo_alt_dos
    from
        cob_cuentas..cc_tran_servicio
      where
        ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                        from cobis..cl_tabla a, cobis..cl_catalogo b
                                        where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
      and ts_causa = convert(varchar,@i_empresa)
      and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
      and ts_correccion = 'N'
      and (ts_secuencial > @i_codigo)
    and ts_secuencial not in (select ssn_corr
                                    from #tmp_servicio_luz)
    order by ts_secuencial

    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'


    set rowcount 0
   end
  --GAMC - 26/02/2008 - Municipio de Samborondon - FIN

  --GAMC - 18/03/2008 - Municipio de Salinas - INI
  if @i_empresa = 2237
  begin
    set rowcount 20
    select
      'Cod_Iden'        = ts_servicio,
      'Doc_Iden'        = substring(ts_descripcion_ec, 31, 14),
      'Nombres'       = ts_nombre,
      'Clave_Catastral'   = ts_campo_alt_dos,
      'Pri_Orden'       = ts_default,
      'Cod_Imp'       = ts_propietario,
      'AnnoTributacion'   = ts_stick_imp,
      'TransaccionBanco'    = ts_secuencial,
      'SemestreCobro'     = ts_autorizante,
      --SE AGREGARON CUATRO CAMPOS MAS PARA EL ARCHIVO DE SALIDA
      'Tip_Cuenta'      = (case a.ts_cta_banco
                    when null then ' '
                    else substring(a.ts_tipocta, 1, 1)
                    end),
      'Cuenta'        = substring(ts_cta_banco, 1, 14),
      'Localidad'       = (select of_ciudad from cobis..cl_oficina
                    where of_oficina = a.ts_oficina),
      'Canal'         = (case a.ts_tipo_chequera
                    when 'VEN' then 'VENT'
                    when 'ATM' then 'ATM'
                    when 'IBK' then 'BVIR'
                    when 'IVR' then 'BVIR'
                    when 'KSK' then 'BELE'
                    end),
      --
      'Valores'       = substring(ts_descripcion_ec, 1, 30),
      'Valor_Total'     = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
      'Clave_Cont'      = ts_campo_alt_uno

    from
      cob_cuentas..cc_tran_servicio a
    where
      ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_trx_nordif'
                      and a.codigo = b.tabla
                      and estado = 'V')
    and ts_causa = convert(varchar,@i_empresa)
    and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
    and ts_correccion = 'N'
    and (ts_secuencial > @i_codigo)
    and ts_secuencial not in (select ssn_corr
                    from #tmp_servicio_luz)
    order by ts_secuencial

    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'


    set rowcount 0
   end

       /* Wise 05/sep/2008 M.Libertad = 2236 Genera Archivo para Municipio.*/
    if @i_empresa = 2236
   begin
    set rowcount 20
    select
      'NumeroPredio'    = ts_campo_alt_uno,
      'CodigoImpuesto'  = ts_propietario,
      'AnioTributacion' = ts_stick_imp,
      'SemestreCobro'   = ts_autorizante,
      'Valor_Total'   = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
      'CodigoPago'    = 'P',
      'Codigobanco'   = ts_cod_banco,
      'TransaccionBanco'  = ts_secuencial,
      'FechaPago'   = ts_tsfecha,
      'CodigoCanal'   = ts_tipo_chequera,
      'Cod_Predial'   = ts_campo_alt_dos,
      'Referencia'    = ts_referencia
    from
      cob_cuentas..cc_tran_servicio a
    where
      ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_trx_nordif'
                      and a.codigo = b.tabla
                      and estado = 'V')
    and ts_causa = convert(varchar,@i_empresa)
    and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
    and ts_correccion = 'N'
    and (ts_secuencial > @i_codigo)
    and ts_secuencial not in (select ssn_corr
                    from #tmp_servicio_luz)
    order by ts_secuencial


    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'

    set rowcount 0
          end
         /* En Wise */

   --GAMC - 18/03/2008 - Municipio de Salinas - FIN
   --GAMC - 23/04/2008 - Municipio de Santa Elena - INI
    if @i_empresa = 2235
    begin
      set rowcount 20
      select
        'NumeroPredio'        = ts_campo_alt_uno,
        'CodigoImpuesto'      = ts_propietario,
        'AnnoTributacion'     = ts_stick_imp,
        'SemestreCobro'       = ts_autorizante,
        'ValorTotal'        = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
        'CodigoPago'        = 'P',
        'CodigoBanco'       = '037',
        'TransaccionBanco'      = ts_secuencial,
        'FechaPago'         = ts_tsfecha,
        'CodigoCanal'       = ts_tipo_chequera,
        'CodigoCatastral'     = substring(ts_campo_alt_dos, 1, 20),
        'Referencia'        = substring(ts_descripcion_ec, 1, 20)
      from
        cob_cuentas..cc_tran_servicio
      where
      ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag
                        from cobis..cl_tabla a, cobis..cl_catalogo b
                        where a.tabla = 'sv_trx_nordif'
                        and a.codigo = b.tabla
                        and estado = 'V')
      and ts_causa = convert(varchar,@i_empresa)
      and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
      and ts_correccion = 'N'
      and (ts_secuencial > @i_codigo)
      and ts_secuencial not in (select ssn_corr
                      from #tmp_servicio_luz)
      order by ts_secuencial

      if @@rowcount = 20
        select @o_mas_mov = 'S'
      else
        select @o_mas_mov = 'N'


      set rowcount 0
      end
  --GAMC - 23/04/2008 - Municipio de Santa Elena - FIN

-->04-julio-2007
if @i_empresa = 3
begin
   set rowcount 20
   select 'OFICINA' = ts_oficina,
   'CODIGO ' = substring(ts_referencia,1,(datalength(ts_referencia) - 1)),
   'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
   'PAGO   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0) - isnull(convert(money,ts_autoriz_aut),0),0)),
   'COMPRO ' = ts_endoso,
   'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
   'USUARIO' = ts_usuario,
   'PROCESO' = ts_clase,
   'FECHA'   = convert(varchar(10), ts_hora, 101),
   'SEC CORR' = isnull(ts_ssn_corr,0),
   'LOC     ' = ts_cheque_desde,
   'PROV    ' = ts_cheque_hasta,
   'FFACT   ' = ts_propietario,
   'REC     ' = isnull(ts_tipo_chequera,'VEN'),
   'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
   'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
   'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
   'BASE IMP' = ts_stick_imp -- DGA 03/Oct/2005
   from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                from cobis..cl_tabla a, cobis..cl_catalogo b
                                where a.tabla = 'sv_trx_nordif'
                                and a.codigo = b.tabla
                                and estado = 'V')
   and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006
   and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
   and ts_correccion = 'N'
   and (ts_endoso > @i_codigo)
   and ts_secuencial not in (select ssn_corr
                            from #tmp_servicio_luz)
   order by ts_endoso
   if @@rowcount = 20
      select @o_mas_mov = 'S'
   else
      select @o_mas_mov = 'N'

   set rowcount 0
end
--<04-julio-2007


---SMERINO NEW TVCABLE
  if @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo
                      where tabla in (select codigo from cobis..cl_tabla
                       where tabla = 'sv_tvcable_online')
                      and valor = 'S')   ---SMERINO NEW TVCABLE

  begin
    set rowcount 20
    select  'OFICINA' = ts_oficina,
        'CODIGO ' = ts_referencia,
            'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
                'PAGO   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)),
                'COMPRO ' = ts_endoso,
                'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
                'USUARIO' = ts_usuario,
                'PROCESO' = ts_clase,
                'FECHA'   = convert(varchar(10), ts_hora, 101),
                'SEC CORR' = isnull(ts_ssn_corr,0),
                'LOC     ' = ts_cheque_desde,
                'PROV    ' = ts_cheque_hasta,
                'FFACT   ' = ts_propietario,
                'REC     ' = isnull(ts_tipo_chequera,'VEN'),
                'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
                'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
                'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
                'BASE IMP' = ts_stick_imp, -- DGA 03/Oct/2005
                'SEM COBR' = ts_autorizante, -- DGA 29/Dic/2005
                'SECUENCI' = ts_secuencial, -- DGA 29/Dic/2005
                'TSFECHA ' = convert(varchar(10),ts_tsfecha, 101) -- DGA 29/Dic/2005
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                                and a.codigo = b.tabla
                                              --and convert(smallint,b.valor) = @i_empresa
                                                and estado = 'V')
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
    and ts_correccion = 'N'
    and (ts_secuencial > @i_codigo)
    and ts_secuencial not in (select ssn_corr
                                          from #tmp_servicio_luz)
        and ts_tipo_chequera = 'VEN'

    union all

    select 'OFICINA' = ts_oficina,
        'CODIGO ' = ts_referencia,
        'DIGVER ' = substring(ts_referencia,(datalength(ts_referencia)),1),
        'PAGO   ' = (isnull(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(convert(money,ts_autoriz_aut),0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0),0)),
        'COMPRO ' = ts_endoso,
        'CTABANCO' = isnull(ts_cta_banco, '0000000000'),
        'USUARIO' = ts_usuario,
        'PROCESO' = ts_clase,
        'FECHA'   = convert(varchar(10), ts_hora, 101),
        'SEC CORR' = isnull(ts_ssn_corr,0),
        'LOC     ' = ts_cheque_desde,
        'PROV    ' = ts_cheque_hasta,
        'FFACT   ' = ts_propietario,
        'REC     ' = isnull(ts_tipo_chequera,'VEN'),
        'RETEN   ' = isnull(ts_ocasional, 0),  -- RCA 12/Sep/2001
        'PLANILLA' = isnull(ts_agente, '0'), --CRR 30/May/2005 (ts_carta, 0)
        'NOMBRE  ' = ts_nombre, -- DGA 03/Oct/2005
        'BASE IMP' = ts_stick_imp, -- DGA 03/Oct/2005
        'SEM COBR' = ts_autorizante, -- DGA 29/Dic/2005
        'SECUENCI' = ts_secuencial, -- DGA 29/Dic/2005
        'TSFECHA ' = convert(varchar(10),ts_tsfecha, 101) -- DGA 29/Dic/2005
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                        from cobis..cl_tabla a, cobis..cl_catalogo b
                        where a.tabla = 'sv_trx_nordif'
                        and a.codigo = b.tabla
                        and estado = 'V')
    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
    and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
    and ts_correccion = 'N'
    and (ts_secuencial > @i_codigo)
    and ts_secuencial not in (select ssn_corr
                  from #tmp_servicio_luz)
    and ts_tipo_chequera <> 'VEN'

    order by ts_secuencial

    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'

    set rowcount 0
  end

  -- JPM Ref.72 -->
  -- IWS TRB (Ini)
  if @i_empresa = 8269
  begin
    set rowcount 20
    select 'TipoCobro'  = 'F',        -- pendiente definir
           'ValorPago'  = isnull(ts_saldo, 0) + isnull(ts_monto, 0) + isnull(ts_contratado, 0) + isnull(ts_valor, 0),
           'CtaBanco'   = ts_cta_banco,
           'CtaCliente' = ts_referencia,
           'NumeroRef'  = '0',
           'FechaPago'  = convert(varchar, ts_tsfecha, 101),
           'FormaPago'  = 'VEN',
           'Secuencial'  = ts_secuencial
     from cob_cuentas..cc_tran_servicio
     where ts_tipo_transaccion in (select convert(int,b.codigo)
                                 from cobis..cl_tabla a, cobis..cl_catalogo b
                                 where a.tabla = 'sv_trx_nordif'
                                 and a.codigo = b.tabla
                                 and estado = 'V')
       and ts_causa = convert(varchar,@i_empresa)
       and ts_correccion = 'N'
       and (ts_secuencial > @i_codigo)
       and ts_secuencial not in (select ssn_corr
                                  from #tmp_servicio_luz)
     order by ts_secuencial

    if @@rowcount = 20
      select @o_mas_mov = 'S'
    else
      select @o_mas_mov = 'N'


    set rowcount 0
   end
  -- IWS TRB (FIN)
  -- <-- JPM Ref.72

      if @i_codigo = 0       -- solo se envian estos datos en la primera llamada
         begin
  /* --> DGA 03/ENE/2006 */
           if not exists( select 1  --REF 63
                        from cob_cuentas..cc_tran_servicio
                       where ts_causa in (select b.codigo
                                            from cobis..cl_tabla a, cobis..cl_catalogo b
                                           where a.tabla = 'pg_recaudacion_automatica'
                                             and a.codigo = b.tabla
                                             and estado = 'V'
                                             and b.codigo = convert(varchar,@i_empresa)))
              begin
                 SELECT @w_pn_valor = pn_valor,
                        @o_cont_rec = pn_cont_trn        -- JPM Ref.72
                   FROM cob_pagos..pg_control_ncrecaudacion
                  WHERE pn_empresa = @i_empresa
                    AND   pn_fecha_rec = @s_date

                 if @@rowcount = 0
                    begin
                       exec cobis..sp_cerror
                            @t_debug         = @t_debug,
                            @t_file          = @t_file,
                            @t_from          = @w_sp_name,
                            @i_msg           = 'REGISTRO PARA EL CREDITO NO EXISTE',
                            @i_num           = 111111
                      select @o_mas_mov = 'N'
                      return 1
                    end
              end
           else
              return 1

            -- se obtiene detalles de la cta y credito para comprobante
            select @o_cta = b.valor
              from cobis..cl_tabla a, cobis..cl_catalogo b
             where a.tabla = 'sv_cuentas_luz'
               and a.codigo = b.tabla
               and convert(smallint,convert(int,b.codigo)) = @i_empresa
               and estado = 'V'


            select @o_total = isnull(@w_pn_valor,0)
            if @o_total > 0
               select @o_nombre = cc_nombre
                 from cob_cuentas..cc_ctacte
                where cc_cta_banco = @o_cta

            if  @i_empresa  in (361,8269)                                         -- JPM Ref.73 -->
              select @o_recaudacion = sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)),
                     @o_retencion   = sum(isnull(ts_ocasional,0))
               from cob_cuentas..cc_tran_servicio
               where ts_tipo_transaccion in (select convert(int,b.codigo)
                                              from cobis..cl_tabla a, cobis..cl_catalogo b
                                              where a.tabla = 'sv_trx_nordif'
                                                and a.codigo = b.tabla
                                                and estado = 'V')
                 and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)
                 and ts_causa = convert(varchar,@i_empresa)
                 and ts_correccion = 'N'
                 and ts_secuencial not in (select ssn_corr
                                            from #tmp_servicio_luz)
				and ts_clase='F' --ref083 pricaura
            else
              select @o_recaudacion =  sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_ocasional,0) + isnull(ts_contratado,0)- isnull(convert(money,ts_autoriz_aut),0)),    -- <-- JPM Ref.73
                     @o_retencion   = sum(isnull(ts_ocasional,0))
               from cob_cuentas..cc_tran_servicio
               where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                             from cobis..cl_tabla a, cobis..cl_catalogo b
                                            where a.tabla = 'sv_trx_nordif'
                                              and a.codigo = b.tabla
                                              and estado = 'V')
               and (substring(ts_tipo_chequera, 4, 2) = @i_tipo or @i_tipo = null)   -- EAS 2-May-2002
               and ts_causa = convert(varchar,@i_empresa) --lfcm 13-julio-2006
               and ts_correccion = 'N'
               and ts_secuencial not in (select ssn_corr
                                           from #tmp_servicio_luz)
           
           -- retorna parametros de output varchar como resulset
           select nombre = @o_nombre,    -- JPM Ref.73
                  cuenta = @o_cta        -- JPM Ref.73
          end
   end


if @i_opcion = 'V' or @i_opcion = 'A'             -- Verficacion de oficinas (supervisores) -- Opcion de cambio de estado en verificaciones (especial)
   begin
   /*
/* --> DGA 03/ENE/2006  */
      -- PARA NO VERIFICAR LAS OFICINAS QUE ESTAN EN CATALOGO

      if exists( select 1  --REF 63
                   from cob_cuentas..cc_tran_servicio
                  where ts_causa in (select b.codigo
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'pg_recaudacion_automatica'
                                        and a.codigo = b.tabla
                                        and estado = 'V'
                                        and b.codigo = convert(varchar,@i_empresa)))
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 033333,
                 @i_msg   = 'PARA ESTA EMPRESA LAS OFICINAS NO NECESITAN VERIFICACION'
            return 1
         end
/* <-- DGA 03/ENE/2006  */
*/

      if @s_ofi <> @i_oficina and @i_opcion = 'V'
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 033333,
                 @i_msg    = 'NO PUEDE VERIFICAR MOVIMIENTOS DE OTRAS OFICINAS'
            return 1
         end

      -- para verificar la oficina necesito que esten verificados todos los usuarios
      select @w_total_ofi = count(distinct ts_usuario)
        from cob_cuentas..cc_tran_servicio
       where ts_tipo_transaccion in (select convert(int,b.codigo) --Ref061:msilvag
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
         and ts_oficina = @i_oficina
         and ts_causa = convert(varchar,@i_empresa)   --lfcm 13-julio-2006


      select @w_total_usu = count(1)
        from cob_pagos..pg_control_usuario
       where cu_oficina = @i_oficina
         and cu_estado = 'S'
         and cu_empresa = @i_empresa


      if (isnull(@w_total_ofi,0) <> isnull(@w_total_usu,0)) or isnull(@w_total_ofi,0) < 1
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 055555,
                 @i_msg    = 'OFICINA NO HA PROCEDIDO A LA VERIFICACION TOTAL DE LOS CAJEROS'
            return 1
         end

      select @w_verific = cv_estado
        from cob_pagos..pg_control_verificacion
       where cv_oficina = @i_oficina
         and cv_empresa = @i_empresa
      if @@rowcount = 0
         begin
            insert into cob_pagos..pg_control_verificacion
            values(@i_empresa, @i_oficina, 'S')
            if @@rowcount = 0
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 033333,
                       @i_msg    = 'ERROR EN VERIFICACION DE MOVIMIENTOS DE LA OFICINA'
                  return 1
               end
            select @o_mas_mov = 'S'
            return 0
         end

      select @o_mas_mov = @w_verific
      if @i_opcion = 'V'
         if @w_verific = 'S'
            -- si la oficina ya se encuentra verificada no se procede con la mod.
            return 0


      if @w_verific = 'N'
         if @i_opcion = 'V'
            select @w_verific = 'S'
         else
            -- la verificacion de la oficina le corresponde a cada supervisor
            return 0
      else
         select @w_verific = 'N'   --lfcm

      select @o_mas_mov = @w_verific

      update cob_pagos..pg_control_verificacion
         set cv_estado = @w_verific
       where cv_oficina = @i_oficina
         and cv_empresa = @i_empresa
      if @@rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 044444,
                 @i_msg    = 'ERROR EN ACTUALIZACION DE VERIFICACION DE OFICINAS'
             return 1
      end


      if @w_verific = 'S'
         exec cob_cuentas..sp_cambia_reverso
              @i_trn = @w_trn


   end

if @i_opcion = 'U'              -- Verficacion de usuarios
   begin
/* --> DGA 03/ENE/2006  */
      -- PARA NO VERIFICAR LAS USUARIOS QUE ESTAN EN CATALOGO
      if exists( select 1  --REF 63
                   from cob_cuentas..cc_tran_servicio
                  where ts_causa in (select b.codigo
                                       from cobis..cl_tabla a, cobis..cl_catalogo b
                                      where a.tabla = 'pg_recaudacion_automatica'
                                        and a.codigo = b.tabla
                                        and estado = 'V'
                                        and b.codigo = convert(varchar,@i_empresa)))
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 033333,
                 @i_msg   = 'PARA ESTA EMPRESA LOS USUARIOS NO NECESITAN VERIFICACION'
            return 1
         end
 /* <-- DGA 03/ENE/2006  */

      if @s_ofi <> @i_oficina
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 033333,
                 @i_msg    = 'NO PUEDE VERIFICAR MOVIMIENTOS DE OTRAS OFICINAS'
            return 1
         end

      -- La ver de usuario se puede dar mientras no se verifique la oficina
      select @w_verific = isnull(cv_estado,'N')
        from cob_pagos..pg_control_verificacion
       where cv_oficina = @s_ofi
         and cv_empresa = @i_empresa
      if @w_verific = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 033333,
                 @i_msg    = 'OFICINA VERIFICADA.. NO PUEDE PROCEDER'
            return 1
         end

      if not exists (select 1
                   from cob_cuentas..cc_tran_servicio
                  where ts_oficina = @s_ofi
                    and ts_usuario = @i_usuario
                    and ts_causa = convert(varchar,@i_empresa)    --lfcm 13-julio-2006
                    and ts_tipo_transaccion in (select convert(int,b.codigo)  --Ref061:msilvag       --VER X TRANSACCIONES
                                       from cobis..cl_tabla a, cobis..cl_catalogo b     --FMV 25/FEB/2003
                                      where a.tabla = 'sv_trx_nordif'
                                        and a.codigo = b.tabla
                                        and estado = 'V')
                    )
         return 0


      select @w_verific = cu_estado
        from cob_pagos..pg_control_usuario
       where cu_oficina = @s_ofi
         and cu_usuario = @i_usuario
         and cu_empresa = @i_empresa
      if @@rowcount = 0
         begin
            insert into cob_pagos..pg_control_usuario
              values(@i_empresa ,@s_ofi, @i_usuario, 'S')
            if @@rowcount = 0
               begin
                  exec cobis..sp_cerror
                       @t_debug  = @t_debug,
                       @t_file   = @t_file,
                       @t_from   = @w_sp_name,
                       @i_num    = 033333,
                       @i_msg    = 'ERROR EN VERIFICACION DE MOVIMIENTOS DEL USUARIO'
                  return 1
               end

            return 0
         end

      if @w_verific = 'N'
         select @w_verific = 'S'
      else
         select @w_verific = 'N'

      update cob_pagos..pg_control_usuario
         set cu_estado = @w_verific
       where cu_oficina = @s_ofi
         and cu_usuario = @i_usuario
         and cu_empresa = @i_empresa
      if @@rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 044444,
                 @i_msg    = 'ERROR EN ACTUALIZACION DE VERIFICACION DEL USUARIO'
             return 1
         end


   end

return 0
go
if exists(select 1 from sysobjects where name='sp_tr_recaudacion_luz' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_tr_recaudacion_luz *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_tr_recaudacion_luz -- ERROR -- >>>'
go
