/************************************************************************/
/*      Archivo:                svpagemp.sp                             */
/*   	Motor de Base: 		SYBASE                     					*/
/*  	Servidor: 			HP-ACT                                      */
/*  	Procesamiento: 		OLTP	                                    */
/*  	Aplicacion: 		Cyberbank	                                */
/*      Stored procedure:       sp_tr_pago_empresa                      */
/*      Base de datos:          cob_pagos                               */
/*      Producto: Credito                                               */
/*      Disenado por:           Ana Mendez                              */
/*      Fecha de escritura:     05/31/2001                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO S.A.                 */
/*      o su representante.                                             */
/*                              PROPOSITO                               */
/*      Este programa realiza realiza la consulta, modificacion de los  */
/*      registros de pagos. Ejecuta el credito y genera registros para  */
/*      la contabilizacion.                                             */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*                                                                      */
/* REF FECHA       AUTOR         TAREA RATIONAL   DESCRIPCION           */
/*      05/31/2001      Ana Mendez      Emision inicial                 */
/*      03/22/2001      Fredi Eras L.   Eliminacion de PORTA-PREPAGO    */
/*      02/14/2003      R. Davila G.    Seleccion de Registro en la     */
/*                                      tabla de Pago y Actualizar el   */
/*                                      Valor de la Retencion.          */
/*      02/17/2003      R. Davila G.    Cambio para Agregar el Historico*/
/*                                      de la Tabla de Retencion        */
/*                                      Impuesto.                       */
/*      02/20/2003      R. Davila G.    Opcion de Pagineo para los Pagos*/
/*                                      por Recaudacion y Servicios.    */
/*      02/27/2003      R. Davila G.    Cambios para Centralizar los pa-*/
/*                                      gos como oficina 0 = Matriz     */
/*      09/04/2003      F. Moncayo V.   Dejar la consulta del comproban-*/
/*                                      te siempre sobre el historico.  */
/*      12/01/2003      F. Moncayo V.   Actulizar el Total Trx.         */
/*      06/Ene/2004     Galo Yanez      Aumentar campo de nombre a 100  */
/*      25/Mar/2004     W.Ramirez B.    Consideracion de his de reten   */
/*      02/Abr/2004     W.Ramirez B.    Enviar Dias de Floating         */
/*      20-Ago-2004     F. Moncayo V.   Ampliar digitos de empresas.    */
/*      17-Nov-2004     F. Moncayo V.   Control por Andinatel           */
/*      19-Ene-2007     Luis Chacha M.  Pago con Cheque de Gerencia     */
/*      29-Jun-2007     Luis Chacha M.  Parametrizar % Impuesto a la    */
/*                                      Renta a imprimir en Comprobante */
/*      20/JUL/2007     T. Cervantes Z. Obtener el porcentaje de reten- */
/*                                      cion del impuesto a la renta.   */
/*      29/Feb/2008    Miguel Aldaz     Aumente pn_valor_uno operacion=V*/
/*      29/Feb/2008    Miguel Aldaz     Aumente pn_valor_uno operacion=P*/
/*      03/Mar/2008    Miguel Aldaz    Aumente @o_valor1 paraoperacion=U*/
/*  20 05/nov/2009 Miguel Aldaz  FEL-249-CU-1408  Proyecto de factura-  */
/*                                                cion electronica.     */
/*  21 16/jun/2011 Sandra Merino   CTE-CC-10087                         */
/*  22 23/Nov/2011 Ana Mendez     CTE-CC-10837Contable forma de pago Cruce Depto   */
/*  23 20/Dic/2012 Ana Mendez     Proyecto IVA                          */
/*  24 29/Ene/2014 Daniel Pereira SGC00012170 Facturacion Electronica   */
/*  25 10/Nov/2014 Sandra Merino RECBEL-AP-SGC00016734-SGC00016735	*/
/*  26 14/Sep/2015 Miriam Lindao Tarea: RETIVA-AP-SGC00021353-SGC00021355*/
/*                               Generar Ret. Iva Bienes y Servicios     */
/*  27 28/Abr/2016 Daniel Pereira RUTPL-AP-SGC00024610-SGC00024629       */    
/*  28 20/Jun/2016 Jorge Pazminno  Facturacion Diaria                    */
/*                                      Tarea: RECA-CC-SGC00024431       */
/*  29 10/07/2016  Sandra Merino    RECA-CE-SGC00026707                  */
/*  30 11/28/2016  Jorge Pazminno   MEGA-AP-SGC00024776-SGC00024778      */
/*                                    Recaudacion Megadatos  - 1089      */
/*  31 19/Jul/2018 Daniel Pereira   RECA-CC-SGC00032446 ATIMASA          */
/*  32 20/Jul/2018 Daniel Pereira   RECA-CE-SGC00032422 NC PRIMAX        */
/*  33 12/Dic/2018 Daniel Pereira   CRSRI-1  - Códigos de Retención Imp Rent-SRI*/
/*	34 05/Jul/2019 Danny Olaya		RECMPS-39 - PAGO DE L/C CLARO POSTPAGO                      */  
/*  35 06/Sep/2019 Daniel Pereira   RECM-27 - PAGO DE L/C RECAUDACIONES PUBLICA/PRIVADA */
/*  36 09/Mar/2020 Luis Gusñay C.   RECMPS-91 (JIRA) - CLARO BATCH FINES DE SEMANA*/
/*  37 20/May/2020 Luis Gusñay C.   RECMPS-135 (JIRA) - CLARO BATCH FIJO FINES DE SEMANA*/
/*  38 17/Nov/2021 Jonathan Guerrero RECMPS-1035 Recaudacion Equifax     */
/*	40 25/08/2022  Kevin Bastidas	RECESABREC-124 TSERVI MOVISTAR CANALES DIGITALES*/
/*************************************************************************/


use cob_pagos

go
if exists(select 1 from sysobjects where name = 'sp_tr_pago_empresa' and type = 'P')
begin
   drop procedure dbo.sp_tr_pago_empresa
   if exists (select 1 from sysobjects where name = 'sp_tr_pago_empresa' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_tr_pago_empresa -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_tr_pago_empresa *OK* =='
end
go

create procedure dbo.sp_tr_pago_empresa(
   @s_ssn          int      = null,
   @s_user         login    = null,
   @s_sesn         int    = null,
   @s_term         descripcion = null,
   @s_date         datetime = null,
   @s_srv      varchar(30) = null,
   @s_lsrv     varchar(30) = null,
   @s_rol      smallint = null,
   @s_ofi          tinyint  = null,
   @s_org_err      char(1) = null,
   @s_error    int = null,
   @s_sev      tinyint = null,
   @s_msg      descripcion = '',
   @s_org      char(1) = null,
   @t_rty          char(1)  = null,
   @t_trn          int      = null,
   @t_debug        char(1)  = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   @t_corr             char(1) = 'N',
   @i_operacion    char(1)  = null,
   @i_modo         smallint = null,
   @i_empresa      int      = null,
   @i_sec_servicio int      = null,
   @i_fecha        datetime = null,
   @i_fecha_rec    datetime = null,
   @i_valor        money    = null,
   @i_valor1       money    = null,
   @i_costo_rec    money    = null,
   @i_moneda       int = 1,
   @i_registro     int      = null,
   @i_session      int      = null,
   @i_detalle      char(1)  = 'S',
   @i_sec_impres   varchar(20)  = null,          -- RDG 02/14/2003
   @i_fechaefec    datetime     = null,          -- RDG 02/14/2003
   @i_secsri       int          = null,          -- RDG 02/14/2003
   @i_retimpret    money        = null,          -- RDG 02/14/2003
   @i_secuencia    int          = null,          -- RDG 02/20/2003
   @i_tip_empresa  int          = 0,             -- RDG 03/21/2003
   @o_cta          varchar(10)  = null out,
   @o_nombre       varchar(100)  = null out,            -- GYC 2004/Ene/06
   @o_valor        money = null out,
   @o_costo_serv   money = null out,
   @o_retencion    money = null out,
   @o_recaudado    money = null out,
   @o_ruc          varchar(13) = null out,
   @o_direccion    varchar(64) = null out,
   @o_irna         varchar(12) = null out,
   @o_irbb         varchar(12) = null out,
   @o_irpd         varchar(12) = null out,
   @o_irvl         varchar(25) = null out,
   @o_sec          varchar(20) = null out,
   @o_dir_ofic     varchar(40) = null out,
   @o_retimpret    money       = null out,
   @o_razonsoc     varchar(100) = null out,         -- GYC 2004/Ene/06
   @o_dias         int         = null out,    --WRB 02ABR2004
   @i_tot_trx      int         = null,
   --@o_porc_retimp  varchar(64) = null     --lfcm 01-agosto-2007
   @o_porc_retimp  varchar(64) = null out,   --lfcm 01-agosto-2007
   @o_valor1        money = null out,         --Miguel Aldaz 02/29/2008
   -->Ref26 MLR: Se crean parametros nuevos
   @i_cont_esp      char(1) = null,
   @i_retiva_bie    money = 0,
   @i_retiva_ser    money = 0,
   --<--Fin Ref26
   @i_emp_dba	    int = null     --ref31
   ,@i_pag	        varchar(64) = null     --ref 36
)
as

declare
   @w_today             datetime,     /* fecha del dia */
   @w_return            int,          /* valor que retorna */
   @w_sp_name           varchar(32),  /* nombre stored proc*/
   @w_existe            tinyint,      /* existe el registro*/
   @w_pn_empresa        int,
   @w_pn_fecha_rec      datetime,
   @w_pn_fecha_pago     datetime,
   @w_pn_fecha_efec     datetime,
   @w_pn_valor          money,
   @w_pn_valor_uno      money,        /*Miguel Aldaz 02/29/2008 */
   @w_pn_costo          money,
   @w_pn_retencion      money,
   @w_pn_cont_trn       int,
   @w_pn_forma_pago     varchar(6),
   @w_pn_estado         varchar(1),
   @w_pe_ruc            varchar(13),
   @w_pe_direccion      descripcion,
   @w_pe_nombre         varchar(100),               -- GYC 2004/Ene/06
   @w_pe_producto       varchar(3),
   @w_pe_cuenta         cuenta,
   @w_causa_nc          varchar(5),
   @w_causa_nd          varchar(5),
   @w_ts_saldo          money,
   @w_ts_monto          money,
   @w_ts_contratado     money,
   @w_pn_retimpret      money,          -- RDG 12/30/2002
   @w_pn_diferencia     money,          -- RDG 12/30/2002
   @w_valtotret         money,          -- RDG 12/30/2002
   @w_valret            money,          -- RDG 12/30/2002
   @w_count             int,
   @w_resparch_d        char(1),        -- RDG 02/17/2003
   @w_resparch_h        char(1),        -- RDG 02/17/2003
   @w_ofi               tinyint,        -- RDG 02/27/2003
   @w_dias              int,
   @w_pe_impret         tinyint,
   @w_fec_ini_vig_aut      varchar (10), --ref21
   @w_fec_fin_vig_aut      varchar (10), --ref21
   @w_porc              float,     --lfcm 01-agosto-2007
   --@w_porc              money     --lfcm 01-agosto-2007
   @w_pe_impiva         tinyint,      -- REF 23
   @w_porc_impiva       float,        -- REF 23
   @w_base_imp          money,        -- REF 23
   @w_impuesto2         money,        -- REF 23
   @w_referencia        varchar(20),  -- REF 23
   @w_servicio          varchar(10),  -- REF 23
   @w_nro_factura       varchar(21) ,  -- REF 23
   @w_imdCost           char(1) ,    -- REF 8 smerino
   @w_cont              int, -- REF 8 smerino
   @w_canal             varchar(3), -- REF 8 smerino
   @w_usuario           varchar(15),    -- REF 8 smerino
   @w_comTotal          money,    ---Ref8 smerino
   -->Ref26 MLR: se aumentan variables
   @w_causa_nd_bie          varchar(5),
   @w_causa_nd_ser          varchar(5),
   @w_tipo_trx_retiva       int,
   @w_rpc                   varchar(80),
   --<--Fin Ref26
   --<REF 27
   @w_trn_iva		int,
   --REF 27>
   @w_fact_diaria           char(1),      -- JPM Ref.28  -->
   @w_causa_fact            varchar(6),
   @w_desc_causa_fact       varchar(64),
   @w_tabla_factdia         char(30),
   @w_tabla_causa_fact      char(30),
   @w_pto_emis              char(3),
   @w_pto_estab             char(3),
   @w_fvcsri                varchar(25),
   @w_msj_error             varchar(132),
   @w_sec                   int,
   @w_resolucion            varchar(20),
   @w_rucFirmante           varchar(25),
   @w_fact_elect            char(1),
   @w_ced_firmante          varchar(10),
   @w_numsri                char(10),
   @w_geProducto            varchar(4),
   @w_geServicio            varchar(4),
   @w_geTipoDocumento       varchar(4),
   @w_mes                   varchar(10),
   @w_posnomes              int,
   @w_validez_mes           varchar(5),
   @w_secdocu               varchar(10),
   @w_secdoctrib            varchar(30),
   @w_fecha_imp1            varchar(30),
   @w_ge_nom_archivo        varchar(100),
   @w_descri_mon            varchar(20),
   @w_nro_sec               int,
   @w_nomes                 varchar(10),
   @w_secuencia             int,
   @w_etiqueta_fact         varchar(100),
   @w_tit_adic4             varchar(50),
   @w_info_adic4            varchar(50),
   @w_tit_adic5             varchar(50),
   @w_info_adic5            varchar(50),
   @w_num_impresion         int,
   @w_producto              tinyint,
   @w_val_unit_serv         money,
   @w_val_tot_serv          money,
   @w_departamento          tinyint,       -- <-- JPM Ref.28
   @w_num_txr_canal         int,            -- JPM Ref.30
   @v_cod_ret 		    char(6),	--ref 33
   @v_causa_ret             char(8),	--ref 33
   @v_pag					numeric --ref 36

select @v_pag = NULL --ref 37
if @i_empresa = 38 or @i_empresa = 8523 -- ref 37
 	select @v_pag = convert(numeric, @i_pag ) --ref 36

if @i_tip_empresa = 0                      -- Recaudacion
   select @w_ofi   = @s_ofi                -- RDG 02/27/2003
  else
   select @w_ofi   = 0                     -- RDG 02/27/2003

select @w_today = @s_date
select @w_sp_name = 'sp_tr_pago_empresa'


-- Reporte Detallado de Servicios en Linea
if @t_trn = 3227 and @i_operacion = 'Y'
   Begin
     if @w_today = @i_fechaefec and 1 = 2 --FMONCAYOV 09/04/2003
        Begin
          execute cob_pagos..sp_retencion_det_empresa_serv               -- Diaria
                  @s_user         = @s_user,
                  @s_sesn         = @s_sesn,
                  @i_empresa      = @i_empresa,
                  @i_sec_servicio = @i_sec_servicio,
                  @i_registro     = @i_registro,
                  @i_session      = @i_session,
                  @i_detalle      = 'S',
                  @o_valtotret    = @w_valtotret out,
                  @o_valret       = @w_valret    out
        End
      Else
        Begin
         execute cob_pagos..sp_retencion_det_empresa_shis                -- RDG 02/17/2003  Historico
                  @s_user         = @s_user,
                  @s_sesn         = @s_sesn,
                  @i_empresa      = @i_empresa,
                  @i_sec_servicio = @i_sec_servicio,
                  @i_registro     = @i_registro,
                  @i_session      = @i_session,
                  @i_detalle      = 'S',
                  @o_valtotret    = @w_valtotret out,
                  @o_valret       = @w_valret    out
        End

     return 0
   end


-- Reporte Detallado de la Plancha
if @t_trn = 3227 and @i_operacion = 'Z'
   Begin
     execute cob_pagos..sp_retencion_impuesto_renta
        @s_user         = @s_user,
        @s_sesn         = @s_ssn,
        @i_empresa      = @i_empresa,
            @i_registro     = @i_registro,
            @i_session      = @i_session,
            @i_detalle      = @i_detalle,
            @i_fechaefec    = @i_fechaefec,    -- RDG 02/14/2003
            @i_secsri       = @i_secsri,       -- RDG 02/14/2003
        @o_valtotret    = @w_valtotret out,
        @o_valret       = @w_valret    out

     return 0
   end

-- Verifica si hay Archivo de Detalle
if @t_trn = 3227 and @i_operacion = 'K'
   Begin
     -- Validar si Tiene Archivo de Impuesto
     select @w_count = isnull( count(1) , 0)
     from cob_pagos..pg_impto_servicio                          -- Diaria
     where si_empresa    = @i_empresa
       and si_fecha      = @i_fecha_rec

     if @w_count is null or @w_count = 0
        Begin
          Select @w_resparch_d = 'N'
        End
      else
        Begin
          Select @w_resparch_d = 'S'
        End


    select @w_count = isnull( count(1) , 0)
     from cob_pagos..pg_impto_servicio_his                     -- Historico       RDG 02/17/2003
     where sh_fechaefec = @i_fecha_rec
       and sh_empresa   = @i_empresa

    --print 'Count %1!',@w_count
    --print 'FechaFec %1!',@i_fecha_rec
    --print 'Empresa %1!',@i_empresa

    if @w_count is null or @w_count = 0
       Begin
         Select @w_resparch_h = 'N'
       End
      else
       Begin
         Select @w_resparch_h = 'S'
       End


    if  @w_resparch_d = 'S' or @w_resparch_h = 'S'
        Select 'S'
       else
        Select 'N'

     return 0

   end


/***********************************************************/
/* Codigos de Transacciones                                */


if ((@t_trn <> 3222 and @i_operacion = 'V') or  (@t_trn <> 3227 and @i_operacion = 'P') or
    (@t_trn <> 3223 and @i_operacion = 'U'))
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 2101006
    return 1
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'V' and @i_operacion <> 'A'
begin
	if @i_empresa in (38,8688)   --ref 32 --ref 34
	begin
		SELECT top 1
			 @w_pn_fecha_rec  = pn_fecha_rec,
			 @w_pn_fecha_pago = pn_fecha_pago,
			 @w_pn_fecha_efec = pn_fecha_efec,
			 @w_pn_valor      = isnull(pn_valor,0),
			 @w_pn_retencion  = isnull(pn_retencion,0),
			 @w_pn_costo      = isnull(pn_costo_recauda,0),
			 @w_pn_cont_trn   = pn_cont_trn ,
			 @w_pn_forma_pago = pn_forma_pago,
			 @w_pn_estado     = pn_estado,
			 @w_pn_retimpret  = pn_retimpret,            
			 @w_pn_valor_uno   = isnull(pn_valor_uno,0)
		    FROM cob_pagos..pg_control_ncrecaudacion
			WHERE pn_empresa    = @i_empresa
			AND   pn_fecha_pago = @i_fecha
			and   pn_fecha_rec  = @i_fecha_rec
			and   pn_sec_servicio  = @i_emp_dba
			and   pn_sec           = isnull(@v_pag, pn_sec) --ref 36
			order by pn_sec desc			                  
	end  
	else
	begin		
		SELECT
			 @w_pn_fecha_rec  = pn_fecha_rec,
			 @w_pn_fecha_pago = pn_fecha_pago,
			 @w_pn_fecha_efec = pn_fecha_efec,
			 @w_pn_valor      = isnull(pn_valor,0),
			 @w_pn_retencion  = isnull(pn_retencion,0),
			 @w_pn_costo      = isnull(pn_costo_recauda,0),
			 @w_pn_cont_trn   = pn_cont_trn ,
			 @w_pn_forma_pago = pn_forma_pago,
			 @w_pn_estado     = pn_estado,
			 @w_pn_retimpret  = pn_retimpret,            -- RDG 12/30/2002
			 @w_pn_valor_uno   = isnull(pn_valor_uno,0)-- Miguel Aldaz 02/29/2008
		    FROM cob_pagos..pg_control_ncrecaudacion
			WHERE pn_empresa    = @i_empresa
			AND   pn_fecha_pago = @i_fecha
			and   pn_fecha_rec  = @i_fecha_rec
			and   pn_secuencial = @i_sec_impres                     -- RDG 02/14/2003		
			and   pn_sec        = isnull(@v_pag, pn_sec) --ref 37
	end

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'P' or @i_operacion = 'U'
begin
    if
         @i_empresa = NULL or
         @i_fecha = NULL

    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101001
        return 1
    end

   /**
   if  @w_pn_estado <> 'N'
       begin
             exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 2103003,
                  @i_msg = "Error Registro tiene Estado de Pagado"
                  return 1
       end
   **/

   /* FER:22Mar2002-RESTRICCION PARA PORTA PRE-PAGO*/
   /* FER:22Mar2002-INICO*/
   if  @i_empresa = 8
       begin
             exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 2103003,
                  @i_msg = "ESTA TRANSACCION NO SE PUEDE EJECUTAR A TRAVES DE ESTE MODULO"
                  return 1
       end
   /* FER:22Mar2002-INICO*/
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2105002
        return 1
    end

    begin tran
	
		--REF 34 INI
	
		if @i_empresa = 38
		begin
		update cob_pagos..pg_control_ncrecaudacion
                set pn_valor         = @i_valor,
                    pn_costo_recauda = @i_costo_rec,
                    pn_retimpret     = @i_retimpret, 
                    pn_cont_trn      = @i_tot_trx, 
                    pn_valor_uno     = @i_valor1 
                WHERE pn_empresa = @i_empresa
                AND   pn_fecha_pago = @i_fecha
                and   pn_fecha_rec = @i_fecha_rec
                and   pn_secuencial = @i_sec_impres
				and   pn_sec_servicio = isnull(@i_emp_dba,pn_sec_servicio)
				and   pn_sec           = isnull(@v_pag, pn_sec) --ref 36
		end
		else
		begin
		update cob_pagos..pg_control_ncrecaudacion
                set pn_valor         = @i_valor,
                    pn_costo_recauda = @i_costo_rec,
                    pn_retimpret     = @i_retimpret,  -- RDG 02/14/2003.
                    pn_cont_trn      = @i_tot_trx,     -- FMV 12/01/2003
                    pn_valor_uno     = @i_valor1       --Miguel Aldaz 02/29/2008 mismo valor que pn_valor en servicios
                WHERE pn_empresa = @i_empresa
                AND   pn_fecha_pago = @i_fecha
                and   pn_fecha_rec = @i_fecha_rec
                and   pn_secuencial = @i_sec_impres   -- RDG 02/14/2003
                and   pn_sec           = isnull(@v_pag, pn_sec) --ref 37
		end
		
		if @@error <> 0
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1
         end
		
		--REF 34 FIN

         /* Transaccion de Servicio   UPDATE */
         /***************************/

      -- Transaccion servicio
       insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_cod_alterno ,ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia,
              ts_moneda, ts_tipo, ts_valor,ts_hora,
              ts_saldo,ts_causa,ts_fecha,ts_fecha_aper)
      values (@s_ssn,0, @t_trn, @w_ofi, @s_user, @s_rol, @s_term,
              null, 'L', @s_lsrv, @s_date, @i_operacion, @w_pn_forma_pago,
              1, 'L',  @w_pn_valor,  getdate(),
              @w_pn_costo, convert(varchar(6),@i_empresa),@w_pn_fecha_rec,@w_pn_fecha_pago)
         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
              exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1
         end


         /* Transaccion de Servicio UPDATE NUEVOS*/
         /***************************/

      -- Transaccion servicio
      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial,ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia,
              ts_moneda, ts_tipo, ts_valor,ts_hora,
              ts_saldo, ts_causa,ts_fecha,ts_fecha_aper)
      values (@s_ssn,1, @t_trn, @w_ofi, @s_user, @s_rol, @s_term,
              null, 'L', @s_lsrv, @s_date, @i_operacion, @w_pn_forma_pago,
              1, 'L',  @i_valor,  getdate(),
               @i_costo_rec, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec)

         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1
         end
    commit tran
end


/*  Values */
/********/

if @i_operacion = 'V'
begin
    set rowcount 20
    if @i_modo = 0
    begin
        SELECT
                "Empresa" = pn_empresa,
                "F.Registro" = convert(varchar(10),pn_fecha_rec,101),
                "F.Pago" = convert(varchar(10),pn_fecha_pago,101),
                "F.Efectiva" = convert(varchar(10),pn_fecha_efec,101),
                "Valor" = pn_valor,
                "Forma de Pago" = pn_forma_pago,
                "Estado" = pn_estado,
                "Costo de Recaudacion" = isnull(pn_costo_recauda,0),
                "Retencion" = isnull(pn_retencion,0),
                "Cuenta" = isnull(pn_cta_banco," "),
                "No.Trx" = isnull(pn_cont_trn,0),
                "Costo Trx" = isnull(pn_costo_recauda,0),
                "Imp.Renta" = isnull(pn_retimpret,0),                    -- RDG 12/30/2002
                "Tipo Empresa" = pn_tipo_empresa,
                "Sec Empresa" = isnull(pn_sec_servicio,0),   --REF 35
                "Sec Comprob" = pn_secuencial,
                "Pagineo"     = pn_sec,
                "Valor Uno" = pn_valor_uno,        --Miguel Aldaz 02/29/2008 valor para imprimir comprobante de transaccion
                "Fact. Electr." = case when pn_fact_elect = 'E' then 'S' else 'N' end, --ref20
                "Autorizacion" = pn_autorizacion,
                "FechaValidez" = pn_fecval_formato, --ref20: Indicador de facturacion electronica
                "FechaAutorizacion" = pn_fecha_ini_vig  ,--ref21
                "FechaValidezsri" = pn_fecha_fin_vig,--ref21
                "Factura" = pn_nro_factura,
                -->Ref26 MLR: Se aumentan campos de la Retención del IVA
                --"BaseImponible0" = isnull(pn_baseimp0,0),
                --"BaseImponible12" = isnull(pn_baseimp12,0),
                "Cont.Especial" = pn_contrib_especial,
                "IVABienes" = isnull(pn_ivabienes,0),
                "ValorRetIVABienes" = isnull(pn_val_ret_bienes,0),
                "IVAServicios" = isnull(pn_ivaservicio,0),
                "ValorRetIVAServicio" = isnull(pn_val_ret_serv,0),
                "Exonera IVA " = isnull(pn_exonera_ivabienes,0) + isnull(pn_exonera_ivaserv, 0)
                --<--Fin Ref26
        FROM cob_pagos..pg_control_ncrecaudacion
                WHERE (pn_empresa     = @i_empresa   or @i_empresa   = null )
                AND   (pn_fecha_pago >= @i_fecha     or @i_fecha     = null )
                and   (pn_sec        >  @i_secuencia or @i_secuencia = null )
				and   (pn_sec_servicio = @i_emp_dba or @i_emp_dba = 0 or @i_emp_dba = null) --Ref 34
                ORDER BY pn_fecha_pago

        set rowcount 0
    end
    if @i_modo = 1
    begin
        SELECT
                "Empresa" = pn_empresa,
                "F.Registro" = convert(varchar(10), pn_fecha_rec ,101),
                "F.Pago"     = convert(varchar(10), pn_fecha_pago,101),
                "F.Efectiva" = convert(varchar(10), pn_fecha_efec,101),
                "Valor" = pn_valor,
                "Forma de Pago" = pn_forma_pago,
                "Estado" = pn_estado,
                "Costo de Recaudacion" = isnull(pn_costo_recauda,0),
                "Retencion" = isnull(pn_retencion,0),
                "Cuenta" = isnull(pn_cta_banco," "),
                "No.Trx" = isnull(pn_cont_trn,0),
                "Costo Trx" = isnull(pn_costo_recauda,0),
                "Imp.Renta" = isnull(pn_retimpret,0),           -- RDG 12/30/2002
                "Tipo Empresa" = pn_tipo_empresa,
                "Sec Empresa" = isnull(pn_sec_servicio,0),  --REF 35
                "Sec Comprob" = pn_secuencial,
                "Pagineo"     = pn_sec,
                "Valor Uno"   = pn_valor_uno,       --Miguel Aldaz 02/29/2008 para imprimir comprobante de transaccion
                "Fact. Electr." = case when pn_fact_elect = 'E' then 'S' else 'N' end,   --ref20
                "Autorizacion" = pn_autorizacion,
                "FechaValidez" = pn_fecval_formato, --ref20: Indicador de facturacion electronica
                "FechaAutorizacion" = pn_fecha_ini_vig  ,--ref21
                "FechaValidezsri" = pn_fecha_fin_vig,--ref21
                "Factura"         = pn_nro_factura,
                -->Ref26 MLR: Se aumentan campos de la Retención del IVA
                --"BaseImponible0" = isnull(pn_baseimp0,0),
                --"BaseImponible12" = isnull(pn_baseimp12,0),
                "Cont.Especial" = pn_contrib_especial,
                "IVABienes" = isnull(pn_ivabienes,0),
                "ValorRetIVABienes" = isnull(pn_val_ret_bienes,0),
                "IVAServicios" = isnull(pn_ivaservicio,0),
                "ValorRetIVAServicio" = isnull(pn_val_ret_serv,0),
                "Exonera IVA " = isnull(pn_exonera_ivabienes,0) + isnull(pn_exonera_ivaserv, 0)
                --<--Fin Ref26
        FROM cob_pagos..pg_control_ncrecaudacion
                WHERE pn_empresa     = @i_empresa
                AND   pn_fecha_pago >= @i_fecha
                and  (pn_sec        >  @i_secuencia or @i_secuencia = null )
				and  (pn_sec_servicio = @i_emp_dba or @i_emp_dba = 0 or @i_emp_dba = null) --Ref 34
                ORDER BY pn_fecha_pago
         set rowcount 0

    end
       
end


/* smerino belcorp */
/***************/
if @i_operacion = 'S'
begin
  set rowcount 5
  select  'Canal' = pg_canal,
          'Costo'    = pg_costo,
          'Cant..'      = pg_cant,
          'Total' =  pg_total
  from cob_pagos..pg_control_com_canal
  where pg_empresa=@i_empresa 
   and convert(varchar,pg_fecha,101) =@i_fecha_rec ---@i_fecha 
end


/*  All */
/***************/
if @i_operacion = 'A'
begin



           SELECT
                 pn_empresa,
                 pn_fecha_rec,
                 pn_fecha_pago,
                 pn_fecha_efec,
                 pn_valor,
                 pn_forma_pago,
                 pn_estado
        FROM cob_pagos..pg_control_ncrecaudacion
                ORDER BY pn_fecha_pago
    if @@rowcount = 0
    begin
        /* 'No existe Dato solicitado '*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1
    end
end


/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
    set rowcount 20



        SELECT
                "Empresa" = pn_empresa,
                "F.Registro" = pn_fecha_rec,
                "F.Pago" = pn_fecha_pago,
                "F.Efectiva" = pn_fecha_efec,
                "Valor" = pn_valor,
                "Forma de Pago" = pn_forma_pago,
                "Estado" = pn_estado,
                "Costo de Recaudacion" = isnull(pn_costo_recauda,0),
                "Retencion" = isnull(pn_retencion,0),
                "Cuenta" = isnull(pn_cta_banco," "),
                "No.Trx" = isnull(pn_cont_trn,0),
                "Costo Trx" = isnull(pn_costo_recauda,0)

        FROM cob_pagos..pg_control_ncrecaudacion
                WHERE pn_empresa = @i_empresa
                AND   pn_fecha_pago >= @i_fecha
                ORDER BY pn_fecha_pago

    set rowcount 0
end



/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
       begin
            select
                 @w_pn_empresa ,
                 @w_pn_fecha_rec ,
                 @w_pn_fecha_pago ,
                 @w_pn_fecha_efec,
                 @w_pn_valor ,
                 @w_pn_forma_pago ,
                 @w_pn_estado
       end
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1
    end
end


-- RDG 12/30/2002
-- Envia Informacion al Front-End
if @i_operacion = 'W'
Begin
     SELECT
       @w_pe_nombre     =  pe_nombre,
       @w_pe_producto   =  pe_producto,
       @w_pe_cuenta     =  pe_cuenta,
       @w_pe_ruc        =  pe_ruc,
       @w_pe_direccion  =  pe_direccion,
       @w_pe_impret     =  pe_impret,
       @w_porc          =  pe_porc_retimp,
       @w_dias          =  pe_dias
     FROM cob_pagos..pg_person_empresa
     WHERE pe_empresa = @i_empresa
	 
     if @@rowcount = 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 2103003,
            @i_msg = "Error Empresa no esta Personalizada"
            return 1
       end

    select @o_ruc        =  @w_pe_ruc
    select @o_direccion  =  @w_pe_direccion
    select @o_cta        =  @w_pe_cuenta

    select @o_dias       = @w_dias   --WRB 02ABR2004
    select @o_irna = pa_char from cobis..cl_parametro where pa_nemonico = "IRNA"

    select @o_irbb = pa_char from cobis..cl_parametro where pa_nemonico = "IRBB"
    select @o_irpd = pa_char from cobis..cl_parametro where pa_nemonico = "IRPD"
    select @o_irvl = pa_char from cobis..cl_parametro where pa_nemonico = "IRVL"
    select @o_razonsoc = @w_pe_nombre

    --print "@w_pe_impret %1! ", @w_pe_impret

    if @w_pe_impret = 1
    begin

       --print "@w_porc %1! ", @w_porc    ----lfcm

       if @w_porc is null
       begin ----lfcm

          select @w_porc = pa_float
          from cobis..cl_parametro
          where pa_nemonico = 'IMR'
            and pa_producto = 'CTE'

             --print "@w_porc [%1!] ", @w_porc    ----lfcm

       end   ----lfcm

       select @o_porc_retimp = valor
       from cobis..cl_catalogo
       where tabla in (select codigo from cobis..cl_tabla where tabla = 'sv_porc_retimp')
         --and codigo = convert(varchar(10),@w_porc)   --lfcm 08-agosto-2007
         and convert(float,codigo) = @w_porc           --lfcm 08-agosto-2007
         --and codigo = '0.002'                        --lfcm 08-agosto-2007
     and estado = 'V'

       --print "@o_porc_retimp %1! ", @o_porc_retimp   ----lfcm

    end

    select @o_dir_ofic = rtrim(ci_descripcion) + " " + rtrim(of_direccion)
    from cobis..cl_oficina, cobis..cl_ciudad where of_oficina = @s_ofi and of_ciudad = ci_ciudad


   SELECT  @o_sec       = "0",
           @o_retimpret =  0

    return 0

End


/* Registro del Pago */
/******************************/
if @i_operacion = 'P'
begin


-- Ref038 JG:INI
 if @i_empresa = 17494
	begin
	  exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
	  @t_from  = @w_sp_name,
	  @i_num   = 2103003,
	  @i_msg = "Esta Empresa no paga L/C"
	  return 1
	end
-- Ref038 JG:FIN				

if @w_pn_fecha_pago > @s_date
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 2103003,
      @i_msg = "Fecha de pago Mayor a la del D¡a"
      return 1
   end

select @w_ts_saldo = 0,
       @w_ts_monto = 0,
       @w_ts_contratado = 0


select @o_costo_serv = 0,
       @o_cta = ''


        SELECT
                 @w_pe_nombre       =  pe_nombre,
                 @w_pe_producto     =  pe_producto,
                 @w_pe_cuenta       =  pe_cuenta,
                 @w_pe_impiva       =  isnull(pe_impiva,0),    -- REF 23
                 @w_porc_impiva     =  isnull(pe_porc_impiva,0),   -- REF 23
                 @w_servicio        =   pe_serv_com,
                 @w_pe_ruc          =   pe_ruc,
                 @w_imdCost         =   pe_imdCostCanal,  -- REF 8  smerino
                 @w_fact_diaria     =  isnull(pe_fact_diaria, 'N'), -- JPM Ref.28
                 @v_cod_ret         =  pe_cod_ret   --ref 31
        FROM cob_pagos..pg_person_empresa
                WHERE pe_empresa = @i_empresa

             if @@rowcount = 0
                begin
                  exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 2103003,
                  @i_msg = "Error Empresa no esta Personalizada"
                  return 1
                end

  select @o_nombre    = @w_pe_nombre
  select @o_recaudado = @w_pn_valor + @w_pn_retencion
  select @o_retencion = @w_pn_retencion
  select @o_retimpret = @w_pn_retimpret

  if @w_pn_costo > 0
     begin
        select @o_costo_serv = @w_pn_costo

        if @o_costo_serv > @w_pn_valor
           begin
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 1111111,
                   @i_msg = "Error Valor del costo mayor al Valor a pagar"
              return 346546
           end

     -- REF 23
     -- llamar al sp que retorna el valor del iva -
     if @w_pe_impiva = 1 and @w_porc_impiva > 0
        begin
    exec @w_return = cob_cuentas..sp_cal_impuesto
    @i_tasa          = @w_porc_impiva,
    @i_valor_serv    = @w_pn_costo,
    @o_base_imp      = @w_base_imp out,
    @o_impuesto      = @w_impuesto2 out
    if @w_return <> 0
      return @w_return
         end
     else
   select  @w_base_imp = @w_pn_costo, @w_impuesto2 = 0

     -- REF 23

     end

begin tran


if @w_pn_forma_pago = 'NCRCTA'
begin


     select @w_causa_fact    = null,    -- JPM Ref.28
            @w_tabla_factdia = null     -- JPM Ref.28
     if @w_pe_producto = 'CTE'
     Begin
     	if @i_emp_dba is null   --ref31
     	begin
		-- Causa de NC para Empresa                                                    P1
			select @w_causa_nc = b.valor
			from cobis..cl_tabla a, cobis..cl_catalogo b
			where a.tabla = 'sv_nc_causas_servicios'
			and a.codigo = b.tabla
			and convert(int,b.codigo) = @i_empresa     --ref31
			and estado = 'V'
		end
		else
		begin
			if @i_empresa = 38 --ref34 Ini
			begin
				select @w_causa_nc = b.valor
				from cobis..cl_tabla a
				inner join  cobis..cl_catalogo b
				on b.tabla = a.codigo
				where a.tabla = 'sv_nc_causas_servicios'
				and convert(int,b.codigo) = @i_empresa
				and estado = 'V'
			end
			else
		    begin
				select @w_causa_nc = b.valor
				from cobis..cl_tabla a, cobis..cl_catalogo b
				where a.tabla = 'sv_nc_causas_servicios'
				and a.codigo = b.tabla
				and convert(int,b.codigo) = @i_emp_dba
				and estado = 'V'
			end --ref34 Fin
		end
            
                              
          if  @@rowcount = 0
              begin
                exec cobis..sp_cerror
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @w_sp_name,
                     @i_msg           = 'EMPRESA NO POSEE CAUSA PARA NC CTE',
                     @i_num           = 111111
                return 1
              end
          if @w_fact_diaria = 'S'                                        -- JPM Ref.28 -->
            select @w_tabla_factdia    = 'cc_causa_fact_diaria_pagemp',
                   @w_tabla_causa_fact = 'cc_causa_nd'                   -- <-- JPM Ref.28
        End

     if @w_pe_producto = 'AHO'
     Begin
     	 if @i_emp_dba is null    --ref31
     	 begin
		-- Causa de NC para Empresa                                                    
		select @w_causa_nc = b.valor
		from cobis..cl_tabla a, cobis..cl_catalogo b
		where a.tabla = 'sv_nc_aho_servicios'
		and a.codigo = b.tabla
		and convert(int,b.codigo) = @i_empresa    --ref31
		and estado = 'V'
	end
	else
	begin
		if @i_empresa = 38 --ref34 Ini
		begin
			select @w_causa_nc = b.valor
			from cobis..cl_tabla a
			inner join  cobis..cl_catalogo b
			on b.tabla = a.codigo
			where a.tabla = 'sv_nc_aho_servicios'
			and convert(int,b.codigo) = @i_empresa
			and estado = 'V'
		end
		else
		begin
			select @w_causa_nc = b.valor
			from cobis..cl_tabla a, cobis..cl_catalogo b
			where a.tabla = 'sv_nc_aho_servicios'
			and a.codigo = b.tabla
			and convert(int,b.codigo) = @i_emp_dba
			and estado = 'V'
		end --ref34 Fin
	end

          if  @@rowcount = 0
              begin
                exec cobis..sp_cerror
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @w_sp_name,
                     @i_msg           = 'EMPRESA NO POSEE CAUSA PARA NC AHO',
                     @i_num           = 111111
                return 1
              end
          if @w_fact_diaria = 'S'                                        -- JPM Ref.28 -->
            select @w_tabla_factdia    = 'ah_causa_fact_diaria_pagemp',
                   @w_tabla_causa_fact = 'ah_causa_nd'                   -- <-- JPM Ref.28
        End

        -- JPM Ref.28 -->
        if @w_fact_diaria = 'S'
        begin
          select @w_causa_fact = valor
           from cobis..cl_tabla a, cobis..cl_catalogo b
           where a.tabla = @w_tabla_factdia
             and a.codigo = b.tabla
             and convert(smallint, b.codigo) = @i_empresa
             and estado = 'V'
          if  @@rowcount = 0
          begin
            exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_num           = 3075
            return 30075
          end
          -- obtener la descripcion del causal
          select @w_desc_causa_fact = valor
           from cobis..cl_tabla a, cobis..cl_catalogo b
           where a.tabla = @w_tabla_causa_fact
             and a.codigo = b.tabla
             and b.codigo = @w_causa_fact
             and estado = 'V'
          if  @@rowcount = 0
          begin
            exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_num           = 30075
            return 30075
          end
          select @w_causa_nd = @w_causa_fact
        end
        -- <-- JPM Ref.28

   --FMV CONTROL ANDINATEL
   --SE EXCLUYE A ANDINATEL HASTA QUE SEA STANDARIZADO
   if @i_empresa <> 617
   begin
       if @w_pe_producto = 'CTE'
          begin
           exec @w_return = cob_cuentas..sp_ccndc_automatica
            @s_srv  = @s_srv,
            @s_ofi  = @w_ofi,
            @s_ssn  = @s_ssn,
            @s_user = @s_user,
            @s_term = @s_term,
            @t_trn  = 3048,
            @i_cta  = @w_pe_cuenta,
            @i_val  = @w_pn_valor,
            @i_cau  = @w_causa_nc,
            @i_mon  = @i_moneda,
            @i_fecha = @s_date

            if @w_return != 0
              begin
              exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_msg   = 'NO SE PUEDE REALIZAR EL CREDITO A LA CUENTA',
               @i_num   = 2103003

               return 2103003
             end

           select @o_cta = cc_cta_banco,
           @o_nombre = cc_nombre
           from cob_cuentas..cc_ctacte
           where cc_cta_banco = @w_pe_cuenta

          end
       if  @w_pe_producto =  'AHO'
        begin
           exec @w_return = cob_ahorros..sp_ahndc_automatica
           @s_srv  = @s_srv,
           @s_ofi  = @w_ofi,
           @s_ssn  = @s_ssn,
           @s_user = @s_user,
           @s_term = @s_term,
           @t_trn  = 4253,
           @i_cta  = @w_pe_cuenta,
           @i_val  = @w_pn_valor,
           @i_cau  = @w_causa_nc,
           @i_mon  = @i_moneda,
           @i_fecha = @s_date

           if @w_return != 0
              begin
              exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_msg   = 'NO SE PUEDE REALIZAR EL CREDITO A LA CUENTA',
               @i_num   = 2103003

               return 2103003
             end
           select @o_cta = ah_cta_banco,
           @o_nombre = ah_nombre
           from cob_ahorros..ah_cuenta
           where ah_cta_banco = @w_pe_cuenta

         end
    end

    select @w_ts_monto = @w_pn_valor

    if @w_pn_costo > 0                  --realiza el debito por costo en trx
       begin
         if @w_fact_diaria = 'N'                        -- JPM Ref.28
         begin
          if @w_pe_producto =  'CTE'
             Begin
               -- Causa de NC para Empresa                              P2
               select @w_causa_nd = b.valor
               from cobis..cl_tabla a, cobis..cl_catalogo b
               where a.tabla = 'cc_causas_nd_empresas'
                 and a.codigo = b.tabla
                 and convert(smallint,convert(smallint,b.codigo)) = @i_empresa
                 and estado = 'V'

               if @@rowcount = 0
                  begin
                    exec cobis..sp_cerror
                         @t_debug         = @t_debug,
                         @t_file          = @t_file,
                         @t_from          = @w_sp_name,
                         @i_msg           = 'EMPRESA NO POSEE CAUSA PARA ND CTE <COSTOS>',
                         @i_num           = 111112
                    return 1
                  end
             End


         if @w_pe_producto =  'AHO'
             Begin
               -- Causa de NC para Empresa                              P2
               select @w_causa_nd = b.valor
               from cobis..cl_tabla a, cobis..cl_catalogo b
               where a.tabla = 'sv_nd_aho_servicios'
                 and a.codigo = b.tabla
                 and convert(smallint,convert(smallint,b.codigo)) = @i_empresa
                 and estado = 'V'

               if @@rowcount = 0
                  begin
                    exec cobis..sp_cerror
                         @t_debug         = @t_debug,
                         @t_file          = @t_file,
                         @t_from          = @w_sp_name,
                         @i_msg           = 'EMPRESA NO POSEE CAUSA PARA ND AHO',
                         @i_num           = 111111
                    return 1
                  end
             End
          end   -- if @w_fact_diaria = 'N'                      -- JPM Ref.28


          if @w_pe_producto =  'CTE'
             Begin
               exec @w_return = cob_cuentas..sp_ccndc_automatica                               -- P3
                    @s_srv  = @s_srv,
                    @s_ofi  = @w_ofi,
                    @s_ssn  = @s_ssn,
                    @s_user = @s_user,
                    @s_term = @s_term,
                    @t_trn  = 3050,
                    @i_cta  = @w_pe_cuenta,
                    @i_val  = @w_pn_costo,
                    @i_cau  = @w_causa_nd,
                    @i_mon  = @i_moneda,
                    @i_fecha = @s_date
               if @w_return != 0
                  begin
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_msg   = 'NO SE PUEDE REALIZAR EL DEBITO DE LA COMISION',
                         @i_num   = 2103003
                    return 2103003
                  end
             end

          if @w_pe_producto =  'AHO'
             Begin
               exec @w_return = cob_ahorros..sp_ahndc_automatica                               -- P3
                    @s_srv  = @s_srv,
                    @s_ofi  = @w_ofi,
                    @s_ssn  = @s_ssn,
                    @s_user = @s_user,
                    @s_term = @s_term,
                    @t_trn  = 4264,
                    @i_cta  = @w_pe_cuenta,
                    @i_val  = @w_pn_costo,
                    @i_cau  = @w_causa_nd,
                    @i_mon  = @i_moneda,
                    @i_fecha = @s_date

               if @w_return != 0
                  begin
                    exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_msg   = 'NO SE PUEDE REALIZAR EL DEBITO DE LA COMISION',
                         @i_num   = 2103003

                    return 2103003
                  end
             end

          --REF 23
    if @w_base_imp > 0
    begin
    	select @w_referencia  = convert (varchar, @i_fecha_rec,101) + " - " + convert(varchar, @i_empresa)

         --insert la trx del iva  para cobro de la comision ---
         --<REF 27
     	if exists (select 1 from cobis..cl_catalogo a, cobis..cl_tabla b 
        	   where b.tabla = 'sv_trx_iva_comision_emp'
                   and   b.codigo = a.tabla                  
                   and   a.codigo = convert(varchar(6),@i_empresa)) 
	begin
    		select @w_trn_iva =  convert(int,a.valor )
    		from cobis..cl_catalogo a, cobis..cl_tabla b
        	   where b.tabla = 'sv_trx_iva_comision_emp'
                   and   b.codigo = a.tabla                  
                   and   a.codigo = convert(varchar(6),@i_empresa)	
       	end
       	else
       		select @w_trn_iva = 3497
    	--REF 27>
    	
    exec @w_return = cob_cuentas..sp_cont_impuesto
        @t_trn       = @w_trn_iva, /*<REF 27  3497, REF 27>*/
        @s_ssn       = @s_ssn,
        @s_date      = @s_date,
        @t_corr      = 'N', ---- @t_corr,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_ofi       = @s_ofi,
        @t_rty       = @t_rty,
        @s_org       = @s_org,
        @i_base_imp  = @w_base_imp,
        @i_iva       = @w_impuesto2,
        @i_total     = @w_pn_costo,
        @i_cau       = @w_servicio,
        @i_cta       = @w_referencia,   --referencia
        @i_mon       = @i_moneda    --Moneda
       if @w_return <> 0
       begin
          if @@trancount > 0
            rollback tran
           return @w_return
       end

    ----print "cob_cuentas..sp_factura_recaudacion -  @w_pn_costo %1! ",@w_pn_costo

    end
    --REF 23

   End  -- Fin de Costo

  End  -- Fin de NCRCTA

  -- Ref 29 Inicio SMM---  (Descomenta la validación anteriror)
  if @w_pn_forma_pago <> 'NCRCTA' and @w_pn_costo > 0  --REF 24     JPM Ref.28 (org)
  --if @w_pn_costo > 0                                               -- JPM Ref.28 (new)
   -- Ref 29 Fin SMM---
  begin
      exec @w_return = cob_cuentas..sp_factura_recaudacion
        @s_ofi            = @s_ofi,
        @s_date           = @s_date,
        @t_debug          = @t_debug,
        @t_file           = @t_file,
        @t_trn            = 4969,
        @i_operacion      = 'I', ----@w_operacion,
        @i_ssn            = @s_ssn,
        @i_ced_ruc        = @w_pe_ruc,
        @i_nombre         = @w_pe_nombre,
        @i_valor          = @w_pn_costo,
        @i_iva            = @w_impuesto2, --REF2
        @i_base_imp       = @w_base_imp,  --REF2
        @i_referencia     = @w_referencia,
        @i_servicio       = "PAGO A EMPRESA",
        @o_nro_factura    = @w_nro_factura out,
        @o_secuencia      = @w_secuencia   out          -- JPM Ref.28
        if @w_return != 0
        begin
          if @@trancount > 0
              rollback tran
          exec cobis..sp_cerror
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 035000,
          @i_msg    = 'ERROR EN FACTURA RECAUDAION'
          return 1
       end
       -- JPM Ref.28 -->
       if @w_fact_diaria = 'S'
       begin
         select @w_resolucion = convert(varchar(20),pa_int)
          from cobis..cl_parametro
          where pa_producto = 'CTE' 
           and  pa_nemonico = 'CESP'
         select @w_rucFirmante = pa_char
          from cobis..cl_parametro 
          where pa_producto = 'CTE' 
           and  pa_nemonico = 'RUCBB'
         select @w_ced_firmante = substring(valor,6,10)
          from cobis..cl_tabla a ,cobis..cl_catalogo b
          where a.codigo= b.tabla
            and a.tabla= 'cc_cedulas_firmantes_bb'
            and b.codigo = 'CCTE'
         
        exec @w_return = cob_gov..sp_cseqnos_sri
                @i_empresa     = 1,
                @i_producto    = 3,
                @i_tipo_doc    = '1',
                @i_fact_elect  = 'E',
                @o_siguiente   = @w_sec         out,
                @o_msg_error   = @w_msj_error   out
        if @w_return != 0
           return @w_return
        
        exec @w_return =  cob_gov..sp_cons_autsri
                @t_trn              = 1670025,
                @i_no_cobis         = 'N',
                @i_mensaje          = 'S',
                @i_empresa          = 1,
                @i_producto         = 3,
                @i_tipo_doc         = '1',
                @i_fecha            = @i_fecha,
                @i_fact_elect       = 'E',
                @o_pto_estab        = @w_pto_estab        out,
                @o_pto_emis         = @w_pto_emis         out,
                @o_autorizacion     = @w_numsri           out,
                @o_fecval_formato   = @w_fvcsri           out,
                @o_msj_error        = @w_msj_error        out,
                @o_fec_ini_vig_aut  = @w_fec_ini_vig_aut  out,
                @o_fec_fin_vig_aut  = @w_fec_fin_vig_aut  out
        if @w_return != 0
           return @w_return
        
        update cob_cuentas..cc_factura_recaudacion
          set fr_secuencia     = @w_sec,
              fr_pto_emis      = @w_pto_emis,
              fr_pto_estab     = @w_pto_estab,
              fr_fecha_validez = @w_fvcsri,
              fr_fecha_ini_vig = @w_fec_ini_vig_aut,
              fr_fecha_fin_vig = @w_fec_fin_vig_aut,
              fr_nautorizacion = @w_numsri,
              fr_estado        = 'O'           -- **** '<==== PARA QUE EL BATCH NO LO TOME  <Online>
         where fr_fecha = @s_date
           and fr_secuencia = @w_secuencia
           and fr_ssn = @s_ssn
        if @@error <> 0
        begin
          exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 30074
          return 1
        end
        select @w_secuencia = @w_sec
        select  @w_geProducto = 'RECA', 
                @w_geServicio = 'RECS', 
                @w_geTipoDocumento = 'FACT', 
                @w_mes = '', 
                @w_posnomes = CHARINDEX ('/',@w_fvcsri) - 1,
                @w_num_impresion = 0
        select @w_nomes = rtrim(ltrim(substring(@w_fvcsri, 1, @w_posnomes)))
        select @w_mes = case @w_nomes
                                when 'ENERO'      then  '01'
                                when 'FEBRERO'    then  '02'
                                when 'MARZO'      then  '03'
                                when 'ABRIL'      then  '04'
                                when 'MAYO'       then  '05'
                                when 'JUNIO'      then  '06'
                                when 'JULIO'      then  '07'
                                when 'AGOSTO'     then  '08'
                                when 'SEPTIEMBRE' then  '09'
                                when 'OCTUBRE'    then  '10'
                                when 'NOVIEMBRE'  then  '11'
                                when 'DICIEMBRE'  then  '12'
                        end
        select @w_validez_mes = ltrim(substring(@w_fvcsri,CHARINDEX ('/',@w_fvcsri) + 1,5))    
        select @w_mes = @w_mes || '/' || @w_validez_mes
        select @w_secdocu = right("000000000" + convert(varchar(9), @w_secuencia), 9)
        select @w_secdoctrib = @w_pto_estab || @w_pto_emis  || @w_secdocu
        select @w_fecha_imp1 = substring(convert(varchar, @s_date, 101),1,2) || substring(convert(varchar, @s_date, 101),4,2) || substring(convert(varchar, @s_date, 101),7,4)
        select @w_ge_nom_archivo = @w_geTipoDocumento + '_' + @w_secdoctrib + '_' || @w_fecha_imp1 || '_'  || @w_geProducto || '_' || @w_geServicio || '_' || @w_pe_ruc
        select @w_secdoctrib = @w_pto_estab + @w_pto_emis + @w_secdocu
        select @w_descri_mon = mo_descripcion
         from cobis..cl_moneda
         where mo_moneda = @i_moneda
        select @w_nro_sec = 0
        select @w_fact_elect = 'S'
        select @w_producto = convert(tinyint,substring(d.valor,11,3))
         from cobis..cl_tabla c,
              cobis..cl_catalogo d
         where c.tabla = 'cc_prod_serv_doc_tributario'
           and c.codigo = d.tabla
           and substring(d.valor,1,4) = @w_geProducto
           and substring(d.valor,6,4) = @w_geServicio
           and d.estado = 'V'
        
        select @w_departamento = case @w_producto
                                     when 3   then 2
                                     when 4   then 3
                                     when 16  then 25
                                     when 159 then 17
                                     when 160 then 17
                                     else 2
                                  end
        select @w_etiqueta_fact  = case @w_pe_producto when 'CTE' then 'CORRIENTE'
                                                       when 'AHO' then 'AHORRO'
                                   end,
               @w_tit_adic4      = 'SERVICIO: ',
               @w_tit_adic5      = 'FECHA REC:',
               @w_info_adic5     = convert(varchar, @i_fecha_rec, 103) + ' Cant. TRX:' + ltrim(rtrim(convert(varchar, @w_pn_cont_trn)))
        select @w_info_adic4 = valor
         from cobis..cl_tabla    a, 
              cobis..cl_catalogo b
         where a.tabla = 'sv_empresas_luz'
           and a.codigo = b.tabla
           and b.codigo = ltrim(rtrim(convert(varchar, @i_empresa)))
        select @w_val_unit_serv = @w_base_imp/@w_pn_cont_trn,
               --@w_val_iva_serv  = @w_impuesto2/@w_pn_cont_trn,
               @w_val_tot_serv  = @w_pn_costo/@w_pn_cont_trn

        execute @w_return = cob_gov..sp_cab_documento_sri
              @i_ge_producto             = @w_geProducto,
              @i_ge_servicio             = @w_geServicio,
              @i_ge_tipo_documento       = @w_geTipoDocumento,
              @i_ge_nom_archivo          = @w_ge_nom_archivo,
              @i_ge_razon_social_emi     = 'BANCO BOLIVARIANO C.A.',
              @i_ge_identificacion_emi   = '0990379017001',
              @i_ge_codigo_documento     = 1, 
              @i_ge_establecimiento      = @w_pto_estab,
              @i_ge_punto_emision        = @w_pto_emis,
              @i_ge_nro_documento        = @w_secdocu,
              @i_ge_caducidad_block      = @w_fec_fin_vig_aut,
              @i_ge_dir_matriz           = 'JUNIN 200 Y PANAMA',
              @i_ge_fecha_emision        = @s_date,
              @i_ge_razon_social_clte    = @w_pe_nombre,
              @i_ge_identificacion_clte  = @w_pe_ruc,
              @i_ge_contrib_especial     = @w_resolucion,
              @i_ge_valor_ice            = 0,
              @i_ge_base_no_objeto_iva   = 0,
              @i_ge_base_iva_cero        = 0,
              @i_ge_base_calculo_iva     = @w_base_imp,
              @i_ge_valor_iva            = @w_impuesto2,
              @i_ge_eti_adicional04      = @w_tit_adic4,
              @i_ge_info_adicional04     = @w_info_adic4,
              @i_ge_eti_adicional05      = @w_tit_adic5,
              @i_ge_info_adicional05     = @w_info_adic5,
              @i_fa_tot_sin_imptos       = @w_base_imp,
              @i_fa_tot_con_imptos       = @w_pn_costo,       --Valor total incluido impuestos en el caso de factura, tambien sirve como valor total en el caso de la Nota de Credito
              @i_fa_moneda               = @w_descri_mon,
              @i_fa_descuento            = 0,
              @i_ds_est_factelec         = @w_fact_elect,     -- Indicador de facturacion electronica
              @i_ds_fecha_autorizacion   = @w_fec_ini_vig_aut,
              @i_ge_numero_impresion     = @w_num_impresion,
              @i_ofi_at                  = 0,
              @i_dpto_at                 = @w_departamento,
              @i_producto_at             = @w_producto,
              @i_tipotrx_at              = 2,
              @o_sec_registro            = @w_nro_sec out 
        if @w_return <> 0
        begin
          exec cobis..sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 101591
          return 999999
        end
        execute @w_return = cob_gov..sp_det_documento_sri 
            @i_ge_producto             = @w_geProducto,        -- Codigo de producto COBIS desde donde se generÂ¢ el documento controlado por SRI
            @i_ge_sec_registro         = @w_nro_sec,            -- Numero secuencial asignado a la cabecera 
            @i_ge_sec_detalle          = 1,                     -- Numero de detalle del documento 
            @i_ge_tipo_detalle         = @w_causa_fact,         --'DETALLES',            -- Etiqueta para los detalles : DETALLES   MOTIVOS  DESTINATARIOS  IMPUESTOS
                                                                -- o cualquier tipo de Detalle el documento SRI.
            @i_ge_concepto             = @w_desc_causa_fact,    -- DescripciÂ¢n que indica el bien o servicio que se estÂ  comercilizando
            @i_ge_cantidad             = 1,                     -- Cantidad de unidades vendidas o entregas al cliente
            @i_ge_precio_base          = @w_base_imp,           -- Campo que contiene el precio unitario en el caso de la factura o la Base imponible si se trata de Comp. Retencion
            @i_ge_precio_total         = @w_base_imp,           -- Campo que contiene el precio_total en el caso de la factura 
            @i_ge_descuentos           = 0,                     -- Valor de descuento otorgado 
            @i_ge_det_adicional01      = @w_etiqueta_fact,      -- Contenido o valor de la etiqueta
            @i_ge_eti_adicional01      = 'Tipo Cta',            -- nombre de la etiqueta  Direccion Establecimiento">
            @i_ge_det_adicional02      = @w_pe_cuenta,
            @i_ge_eti_adicional02      = 'Numero Cta',          -- nombre de la etiqueta
            @i_fecha_emision_doc       = @s_date,
            @i_tipo_det                = 'R'
        if @w_return <> 0
        begin
          exec cobis..sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 101600
          return 101600
        end
       end
       -- <-- JPM Ref.28
  end


        if @w_pn_forma_pago = 'TRFBCE'
           begin
              select @w_ts_contratado = @w_pn_valor
           end
        if @w_pn_forma_pago = 'CHQBCE'
           begin
              select @w_ts_contratado = @w_pn_valor
           end

        if @w_pn_forma_pago = 'CHQGER'
           begin
              select @w_ts_saldo = @w_pn_valor
           end
        if @w_pn_forma_pago = 'CRDEPT'
           begin
               select @w_ts_saldo = @w_pn_valor
           end



        -- RDG
        if exists ( select 1 from cob_pagos..pg_person_empresa
           where ( pe_empresa = @i_empresa and ( pe_conta = 0 or pe_conta = null )
             and pe_impret = 1 and @w_pn_forma_pago <> 'NCRCTA' )
          or ( pe_empresa = @i_empresa and ( pe_conta = 0 or pe_conta = null)
             and ( pe_impret = 0 or pe_impret = null ) and @w_pn_forma_pago <> 'NCRCTA' ) )
           Begin

             Select @w_pn_costo     = isnull( @w_pn_costo     , 0 )
             Select @w_pn_retimpret = isnull( @w_pn_retimpret , 0 )

             if @w_pn_costo     is null Select @w_pn_costo     = 0
             if @w_pn_retimpret is null Select @w_pn_retimpret = 0


             Select @w_pn_diferencia = @w_pn_valor - @w_pn_costo - @w_pn_retimpret

             /* Transaccion servicio */
             insert into cob_cuentas..cc_tran_servicio
                (ts_secuencial, ts_tipo_transaccion, ts_oficina,
                 ts_usuario, ts_rol, ts_terminal,
                 ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
                 ts_referencia, ts_hora,
                 ts_moneda, ts_tipo, ts_valor,ts_saldo,ts_monto,
                 ts_aporte_iess, ts_causa,ts_fecha,ts_fecha_aper)
             values (@s_ssn, 3977, @w_ofi, @s_user, @s_rol, @s_term,
                 null, 'L', @s_lsrv, @s_date, @i_operacion, @w_pn_forma_pago,getdate(),
                 1, 'L',  @w_pn_diferencia, @w_pn_valor, @w_pn_retimpret,
                 @w_pn_costo, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec)
             if @@error != 0
                begin
                  exec cobis..sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 033000
                  return 033000
                end

           End


    
      
      
      -- RDG
      -- Solo Para Empresas que se debe Retener el Impuesto
      if exists ( select 1 from cob_pagos..pg_person_empresa
                  where pe_empresa = @i_empresa and pe_impret = 1 and @w_pn_forma_pago = 'NCRCTA' )
      Begin           
           if @w_pn_retimpret > 0
           Begin                
		--ini  ref 33
	        if @v_cod_ret <> ""
	        begin	              
			select @v_causa_ret = c.valor
			from cobis..cl_tabla t inner join cobis..cl_catalogo c 
			on t.codigo=c.tabla
			where t.tabla='sv_cod_retimp'
			and  c.codigo = @v_cod_ret
			and c.estado = 'V'
		end
		else	
		begin
			  exec cobis..sp_cerror
			    @t_debug = @t_debug,
			    @t_file  = @t_file,
			    @t_from  = @w_sp_name,
			    @i_num   = 141064,
			    @i_msg = "EMPRESA NO POSEE CODIGO RETENCION"
			    return 141064							       
	        end
	        --fin  ref 33
	        
                if @w_pe_producto =  'CTE'
                Begin
                     exec @w_return = cob_cuentas..sp_ccndc_automatica                 -- P4
                          @s_srv  = @s_srv,
                          @s_ofi  = @w_ofi,
                          @s_ssn  = @s_ssn,
                          @s_user = @s_user,
                          @s_term = @s_term,
                          @t_trn  = 3050,
                          @i_cta  = @w_pe_cuenta,
                          @i_val  = @w_pn_retimpret,
                          @i_cau  = @v_causa_ret, --"307",  --ref 33
                          @i_mon  = @i_moneda,
                          @i_fecha = @s_date
                     if @w_return != 0
                     begin
                          exec cobis..sp_cerror
                               @t_debug = @t_debug,
                               @t_file  = @t_file,
                               @t_from  = @w_sp_name,
                               @i_num   = 2103003
                          return 2103003
                     end
                End

               if @w_pe_producto =  'AHO'
               Begin
                     exec @w_return = cob_ahorros..sp_ahndc_automatica                 -- P4
                          @s_srv  = @s_srv,
                          @s_ofi  = @w_ofi,
                          @s_ssn  = @s_ssn,
                          @s_user = @s_user,
                          @s_term = @s_term,
                          @t_trn  = 4264,
                          @i_cta  = @w_pe_cuenta,
                          @i_val  = @w_pn_retimpret,
                          @i_cau  = @v_causa_ret, --"307",  --ref 33
                          @i_mon  = @i_moneda,
                          @i_fecha = @s_date
                     if @w_return != 0
                     begin
                          exec cobis..sp_cerror
                               @t_debug = @t_debug,
                               @t_file  = @t_file,
                               @t_from  = @w_sp_name,
                               @i_num   = 2103003
                          return 2103003
                     end
               End

           End  --if @w_pn_retimpret > 0
      End -- Fin de Cobro de Retencion


        -- RDG
        -- Solo Para Empresas que se debe Retener el Impuesto
        if exists ( select 1 from cob_pagos..pg_person_empresa where pe_empresa = @i_empresa and pe_conta = 1 )
           Begin

             Select @w_pn_costo     = isnull( @w_pn_costo     , 0 )
             Select @w_pn_retimpret = isnull( @w_pn_retimpret , 0 )

             if @w_pn_costo     is null Select @w_pn_costo = 0
             if @w_pn_retimpret is null Select @w_pn_retimpret = 0

             Select @w_pn_diferencia = @w_pn_valor - @w_pn_costo - @w_pn_retimpret

             if @w_pn_forma_pago = 'NCRCTA' and @i_empresa <> 1719 --Para el caso de Emelmanabi
             Begin
    select @w_pn_costo      = null
    select @w_pn_retimpret  = null
    select @w_pn_diferencia = null
             End

             if @w_pn_forma_pago = 'NCRCTA' and @i_empresa = 1719 --Para el caso de Emelmanabi
             Begin
    select @w_pn_costo      = null
    select @w_pn_retimpret  = null
    select @w_pn_diferencia = null
    select @o_costo_serv = 0
             End


  --lfcm 01-19-2007
  --Habilitar como forma de Pago a la Empresa: Cheque de Gerencia
  if @w_pn_forma_pago in ('CHQGER','CRDEPT')   ----- REF22 Habilitar como forma de Pago a la Empresa:Cruce Depto
  begin
    --select @w_ts_saldo = @w_pn_valor
    select @w_ts_saldo = 0
    select @w_ts_saldo = @w_pn_diferencia
    select @w_pn_diferencia = 0

  end
  
--incio smerino

  
 --- smerino 
if @w_imdCost = 'S'
begin

select @w_cont= count(1)
from cob_pagos..pg_control_com_canal
where pg_empresa=@i_empresa
and pg_fecha =@i_fecha_rec 
--and pg_estado is null
   
 while  (@w_cont >= 1)
 begin  

    
             select @w_cont= @w_cont -1
    
   
             set rowcount 1
             select @w_canal= pg_canal, @w_comTotal=pg_total,  @w_num_txr_canal = pg_cant -- JPM Ref.30: recuperar num.trx
  	     from cob_pagos..pg_control_com_canal
	     where pg_empresa=@i_empresa
	     and pg_fecha =@i_fecha_rec and pg_estado is null
	     
	     if @w_canal ='CNB'
	        select @w_usuario= 'cnb001'
	     else 
	     if @w_canal ='IBK'
	         select @w_usuario= 'ope998'
	     else 
	     if @w_canal ='VEN'
	      select @w_usuario= @s_user
       else                               -- JPM Ref.30 --> (soportar canal WAP)
       if @w_canal ='WAP'
        select @w_usuario= 'WAP'          -- <-- JPM Ref.30
	      
 
           /* Transaccion servicio */
  begin tran
      
      
      if @w_canal in ('CNB','IBK', 'WAP')       -- JPM Ref.30: incluir canal WAP
      begin
      
      if @i_empresa not in (19574,19575) --ref40 Kbastidz Compra Paquete Mov - Tuenti
        begin
		insert into cob_cuentas..cc_tran_servicio
        (ts_secuencial, ts_tipo_transaccion, ts_oficina,
        ts_usuario, ts_rol, ts_terminal,
        ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
        ts_referencia, ts_hora,
        ts_moneda, ts_tipo, ts_valor,ts_saldo,ts_monto,ts_contratado,
        ts_aporte_iess, ts_causa,ts_fecha,ts_fecha_aper, ts_descuento_iess, ts_fonres_iess,
        ts_ocasional, ts_tipo_chequera, ts_cheque)    -- JPM Ref.30: incluye num.txr
        values (@s_ssn, 43473, @w_ofi, 
          @w_usuario, @s_rol, @s_term,
            null, 'L', @s_lsrv, @s_date, @i_operacion, 
            @w_pn_forma_pago,getdate(),
            1, 'L',  0.00,0.00,@w_comTotal,0.00,
            @w_comTotal, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec, 0.00, 0.00 ,
            0.00,@w_canal, @w_num_txr_canal)          -- JPM Ref.30: incluye num.txr
           
           
           
	   
	   if @@error != 0
	      begin
		exec cobis..sp_cerror
		     @t_debug        = @t_debug,
		     @t_file         = @t_file,
		     @t_from         = @w_sp_name,
		     @i_num          = 033000
		return 033000
              end
          end
		  end
         else
            if @w_canal ='VEN'
         
             begin
             if @i_empresa not in (19574,19575) --ref40 Kbastidz Compra Paquete Mov - Tuenti
			 begin
                insert into cob_cuentas..cc_tran_servicio
                (ts_secuencial, ts_tipo_transaccion, ts_oficina,
                ts_usuario, ts_rol, ts_terminal,
                ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
                ts_referencia, ts_hora,
                ts_moneda, ts_tipo, ts_valor,ts_saldo,ts_monto,ts_contratado,
                ts_aporte_iess, ts_causa,ts_fecha,ts_fecha_aper, ts_descuento_iess, ts_fonres_iess,
                ts_ocasional, ts_tipo_chequera , ts_cheque)    -- JPM Ref.30: incluye num.txr
                values (@s_ssn, 43473, @w_ofi, 
                @w_usuario, @s_rol, @s_term,
                  null, 'L', @s_lsrv, @s_date, @i_operacion, 
                  @w_pn_forma_pago,getdate(),
                  1, 'L',  0.00,@w_comTotal,0.00,0.00,
                  @w_comTotal, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec, 0.00, 0.00 ,
                  0.00,@w_canal, @w_num_txr_canal)           -- JPM Ref.30: incluye num.txr
	                
	                
	                
	     	   
	     	   if @@error != 0
	     	      begin
	     		exec cobis..sp_cerror
	     		     @t_debug        = @t_debug,
	     		     @t_file         = @t_file,
	     		     @t_from         = @w_sp_name,
	     		     @i_num          = 033000
	     		return 033000
                        end
              end
          end
           update cob_pagos..pg_control_com_canal
           set pg_estado ='P'
           where  pg_empresa=@i_empresa 
           and pg_canal =@w_canal
           and pg_fecha =@i_fecha_rec
           --and pg_fecha =@i_fecha_rec --@i_fecha
           
           select @s_ssn=@s_ssn + 1
           

         commit tran
         
     end
  end
   /* else se comenta porque solo se va a registra la trx 43473 para recaudaciones con cobro de comisión por canal*/ 
   -- begin
    
        /* Transaccion servicio */
           

                           
           /* insert into cob_cuentas..cc_tran_servicio
	   	   (ts_secuencial, ts_tipo_transaccion, ts_oficina,
	   	    ts_usuario, ts_rol, ts_terminal,
	   	    ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
	   	    ts_referencia, ts_hora,ts_autoriz_aut,
	   	    ts_moneda, ts_tipo, ts_valor,ts_saldo,ts_monto,ts_contratado,
	   	    ts_aporte_iess, ts_causa,ts_fecha,ts_fecha_aper, ts_descuento_iess, ts_fonres_iess,
	   	    ts_ocasional, ts_tipo_chequera )
	   	values (@s_ssn, 43473, @w_ofi, 
	   	       @s_user, @s_rol, @s_term,
	   	        null, 'L', @s_lsrv, @s_date, @i_operacion, 
	   	        @w_pn_forma_pago,getdate(),@w_comTotal,
	   	        1, 'L',  0.00,0.00,0.00,0.00,
	   	        @w_comTotal, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec, 0.00, 0.00 ,
	   	        0.00,'VEN')
           
           
           
                 if @@error != 0
                    begin
                      exec cobis..sp_cerror
                           @t_debug        = @t_debug,
                           @t_file         = @t_file,
                           @t_from         = @w_sp_name,
                           @i_num          = 033000
                      return 033000
                    end*/
-- end


  
  
 -- fin de smerino

      
       /* Transaccion servicio */
       if @i_empresa not in (19574,19575) --ref40 Kbastidz Compra Paquete Mov - Tuenti
        begin
		insert into cob_cuentas..cc_tran_servicio
                       (ts_secuencial, ts_tipo_transaccion, ts_oficina,
                        ts_usuario, ts_rol, ts_terminal,
                        ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
                        ts_referencia, ts_hora,
                        ts_moneda, ts_tipo, ts_valor,ts_saldo,ts_monto,ts_contratado,
                        ts_aporte_iess, ts_causa,ts_fecha,ts_fecha_aper, ts_descuento_iess, ts_fonres_iess,
                        ts_ocasional  )
                    values (@s_ssn, @t_trn, @w_ofi, @s_user, @s_rol, @s_term,
                        null, 'L', @s_lsrv, @s_date, @i_operacion, @w_pn_forma_pago,getdate(),
                        1, 'L',  @w_pn_valor,@w_ts_saldo,@w_ts_monto,@w_ts_contratado,
                        @o_costo_serv, convert(varchar(6),@i_empresa),@i_fecha,@w_pn_fecha_rec, @w_pn_costo, @w_pn_retimpret ,
                        @w_pn_diferencia )
                    if @@error != 0
                       begin
                         exec cobis..sp_cerror
                              @t_debug        = @t_debug,
                              @t_file         = @t_file,
                              @t_from         = @w_sp_name,
                              @i_num          = 033000
                         return 033000
                       end
           End
		   end

              -->Ref26 MLR: Generación de N/D Retenciones IVA Bienes y Servicio
              if exists ( select 1  
                            from cobis..cl_tabla t,
                                 cobis..cl_catalogo c
                           where t.codigo = c.tabla
                             and t.tabla = 'pg_recaudacion_aut_retiva'
                             and c.codigo = convert(varchar,@i_empresa)) and ( @i_retiva_bie > 0 or @i_retiva_ser > 0)
                begin -- Se valida que la Empresa esté configurada en el Catalogo
                     -- Se obtiene la Transacción y Causa de las N/D
                     exec sp_obt_trx_causa_retiva
                     @s_ssn           = @s_ssn,
                      @s_srv           = @s_srv,
                      @s_lsrv          = @s_lsrv,
                      @s_user          = @s_user,
                      @s_sesn          = @s_sesn,
                      @s_term          = @s_term,
                      @s_date          = @s_date,
                      @s_ofi           = @s_ofi,
                      @s_rol           = @s_rol,
                      @t_debug         = @t_debug,
                      @t_file          = @t_file,
                      @t_trn           = @t_trn,
                      @i_cont_especial = @i_cont_esp,   -- Indicador si el cliente es contribuyente Especial (S/N) 
                      @i_tipo_cta      = @w_pe_producto, -- Tipo Cta Transf AHO o CTE
                      @o_causa_bien    = @w_causa_nd_bie out,
                      @o_causa_serv    = @w_causa_nd_ser out,
                      @o_tipo_trx      = @w_tipo_trx_retiva out
         
               if @w_pe_producto = 'CTE'
                  set @w_rpc = 'cob_cuentas..sp_ccndc_automatica'
               else
                  set @w_rpc = 'cob_ahorros..sp_ahndc_automatica'
               -- Retención IVA Bienes
               if @i_retiva_bie > 0
                begin
                  exec @w_return = @w_rpc
                               @s_srv  = @s_srv,
                               @s_ofi  = @w_ofi,
                               @s_ssn  = @s_ssn,
                               @s_user = @s_user,
                               @s_term = @s_term,
                               @t_trn  = @w_tipo_trx_retiva,
                               @i_cta  = @w_pe_cuenta,
                               @i_val  = @i_retiva_bie,
                               @i_cau  = @w_causa_nd_bie,
                               @i_mon  = @i_moneda,
                               @i_fecha = @s_date
                  if @w_return != 0
                    begin
                      exec cobis..sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_msg   = 'ERROR AL INTENTAR REALIZAR EL DEBITO DE LA RET. IVA BIENES',
                              @i_num   = 2103003
                              return 2103003
                    end
                  end -- @i_retiva_bie > 0
                  -- Retención IVA Servicios
               if @i_retiva_ser > 0
                begin
                  exec @w_return = @w_rpc
                               @s_srv   = @s_srv,
                               @s_ofi   = @w_ofi,
                               @s_ssn   = @s_ssn,
                               @s_user  = @s_user,
                               @s_term  = @s_term,
                               @t_trn   = @w_tipo_trx_retiva,
                               @i_cta   = @w_pe_cuenta,
                               @i_val   = @i_retiva_ser,
                               @i_cau   = @w_causa_nd_ser,
                               @i_mon   = @i_moneda,
                               @i_fecha = @s_date
                  if @w_return != 0
                    begin
                      exec cobis..sp_cerror
                              @t_debug = @t_debug,
                              @t_file  = @t_file,
                              @t_from  = @w_sp_name,
                              @i_msg   = 'ERROR AL INTENTAR REALIZAR EL DEBITO DE LA RET. IVA SERVICIOS',
                              @i_num   = 2103003
                              return 2103003
                    end
                  end -- @i_retiva_ser > 0
                end -- Fin de Retención IVA 
       --<--Fin Ref26

		--REF 34 INI
	   
		if @i_empresa = 38
		begin
		    update cob_pagos..pg_control_ncrecaudacion
			set	pn_fecha_efec = @s_date,
				pn_cta_banco  = @w_pe_cuenta,
				pn_estado = 'P',
				pn_nro_factura = @w_secdocu         -- JPM Ref.28: antes @w_nro_factura
			FROM cob_pagos..pg_control_ncrecaudacion
			WHERE pn_empresa    = @i_empresa
			and pn_fecha_pago = @i_fecha
			and pn_fecha_rec  = @i_fecha_rec
			and pn_secuencial = @i_sec_impres                  -- RDG 02/14/2003
			and pn_sec_servicio = isnull(@i_emp_dba,pn_sec_servicio)
			and pn_sec = isnull(@v_pag, pn_sec) --ref 36
		end
		else
		begin
			update cob_pagos..pg_control_ncrecaudacion
			set pn_fecha_efec = @s_date,
				pn_cta_banco  = @w_pe_cuenta,
				pn_estado = 'P',
				pn_nro_factura = @w_secdocu
			FROM cob_pagos..pg_control_ncrecaudacion
			WHERE pn_empresa    = @i_empresa
			and pn_fecha_pago = @i_fecha
			and pn_fecha_rec  = @i_fecha_rec
			and pn_secuencial = @i_sec_impres
			and pn_sec = isnull(@v_pag, pn_sec) --ref 37
		end
		
		if @@error <> 0
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1
         end
		
		--REF 34 FIN

       if exists (select 1 from cobis..cl_catalogo a, cobis..cl_tabla b
                  where b.tabla = 'sv_empresas_diferidos'
                  and   b.codigo = a.tabla
                  --and   a.codigo = convert(varchar(6),@i_empresa))
                  and   a.codigo = convert(varchar(6),@i_empresa))  --FMV 07/28/2004
        begin


          insert cob_pagos..pg_impto_servicio_his(sh_fechaefec,sh_empresa,sh_codigo,
                                                  sh_id_detalle,sh_valor,sh_orig,
                                                  sh_valorf,sh_retimp,sh_factura)

          select si_fecha, si_empresa,si_codigo,
                 si_id_detalle,si_valor,si_valor,
                 si_valor,si_retencion,si_factura
          from cob_pagos..pg_impto_servicio
          where si_empresa = @i_empresa
          and   si_fecha = @i_fecha_rec

          delete cob_pagos..pg_impto_servicio
          where si_empresa = @i_empresa
          and   si_fecha = @i_fecha_rec

       end





   select @o_valor      =  @w_pn_valor
   select @o_valor1     =  @w_pn_valor_uno        --Miguel Aldaz 02/29/2008

commit tran
end
return 0
go
if exists(select 1 from sysobjects where name='sp_tr_pago_empresa' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_tr_pago_empresa *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_tr_pago_empresa -- ERROR -- >>>'
go

