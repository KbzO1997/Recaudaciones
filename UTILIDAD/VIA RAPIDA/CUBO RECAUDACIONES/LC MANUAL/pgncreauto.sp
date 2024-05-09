use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_nc_rec_automatica' and type = 'P')
begin
   drop procedure dbo.sp_nc_rec_automatica
   if exists (select 1 from sysobjects where name = 'sp_nc_rec_automatica' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_nc_rec_automatica -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_nc_rec_automatica *OK* =='
end
go

/*-----------------------------------------------------------------------*/
/*  Archivo:            pgncreauto.sp                                    */
/*  Motor de Base:      SYBASE                                           */
/*  Servidor:           HP-ACT                                           */
/*  Aplicacion:         RECAUDOS                                      	 */
/*  Procesamiento:      OLTP                              			     */
/*  Ult.ControlTarea:   J-B-RECM-634                          		     */
/*  Ult.Referencia:     REF 65                          			     */
/*  Stored procedure:   sp_nc_rec_automatica                             */
/*  Base de datos:      cob_pagos                                        */
/*  Producto:           Cuentas Corrientes                               */
/*  Disenado por:       Franklin Moncayo V.                              */
/*  Fecha de escritura: 15-Nov-2003                                      */
/*-----------------------------------------------------------------------*/
/*                            IMPORTANTE                                 */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      BANCO BOLIVARIANO S.A.                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante .  */
/*-----------------------------------------------------------------------*/
/*                            PROPOSITO                                  */
/*  Este programa realiza la acreditación del servicio de empresas auto- */
/*  maticas, se inicia con corpei                                        */
/*-----------------------------------------------------------------------*/
/*                          MODIFICACIONES                               */
/* REF FECHA       AUTOR         TAREA RATIONAL    DESCRIPCION           */
/*  15/NOV/2003  Franklin Moncayo V. Emision inicial                     */
/*  13/Ene/2004 Galo Yanez       Personalizar Telecsa          */
/*  08/NOV/2004  Franklin Moncayo V. Personalizar Andinatel              */
/*  29/Nov/2004  Jorge Pazminno    Restar comision por pago de servicio  */
/*  21/Sep/2005  Hugo Yépez         Considerar la retención ya calculada */
/*                                  solo para el caso de andinatel (617) */
/*  19/Sep/2006  Luis F. Chacha M.  No descontar el costo de la Comision */
/*  24/Oct/2006  Luis F. Chacha M.  Incluir el valor de pago con Tarjeta */
/*                                  en registro de credito a generar     */
/*  04/Ene/2007  Luis F. Chacha M.  Quitar campo ts_contratado para em-  */
/*                                  presas distintas a Municipios        */
/*  02/Feb/2007  Luis F. Chacha M.  Recaudacion TVCABLE                  */
/*  02/Mar/2007  Luis F. Chacha M.  Incluir empresas TVCABLE 335, 337    */
/*  09/Abr/2007  Luis F. Chacha M.  Municipio de Cuenca 1800             */
/*  27/Jun/2007  Galo Yanez         Parametrizar impuesto a la renta */
/*  20/JUL/2007  T. Cervantes Z.    Obtener el porcentaje de retencion   */
/*                                  del impuesto a la renta.             */
/*  07/Ago/2007  Luis F. Chacha M.  TVCABLE personalizar en Catálogos    */
/*  26/Nov/2007  Luis F. Chacha M.  Linea de Credito de la CORPEI        */
/*  27/Dic/2007  Luis F. Chacha M.  Generar Línea de Crédito M. Ibarra   */
/*  29/Feb/2008  Miguel Aldaz       Campo pn_valor_uno contendra pn_valor*/
/*  27/Mar/2008  Luis F. Chacha M.  Linea de Credito de la CATEG         */
/*  21/Abr/2008  German Medina C.   Linea de Credito Samborondon-Salinas */
/*  30/Abr/2008  German Medina C.   Linea de Credito Santa Elena   */
/*  18/Jul/2008  Tania Cumbicus A.  Linea de Credito IESS    */
/*  04/Ago/2008  German Medina C.   Linea de Credito de CTG        */
/*  15/Ago/2008  Tania Cumbicus A.  Aumento campo fecha diferido Linea de Credito IESS     */
/*  08/Sep/2008  Wise Computer D.   Linea de Credito M.Libertad    */
/*  11/Sep/2008  Wise Computer D.   Linea de Credito EMEPE     */
/*  19/Sep/2008  Wise Computer D.   Correció Query L.Credito EMEPE   */
/*  02/Oct/2008  Guillermo Martillo Separa linea de credito del IESS   */
/*            para generarla el mismo día de la  */
/*            recaudación        */
/*  02/Dic/2008  Luis F. Chacha M.  Validar si # Trx es cero que no      */
/*                                  inserte registro de crédito          */
/*  28/May/2009  Luis F. Chacha M.  Generación de Registro de CNEL       */
/*  20/NOV/2009  Tania Cumbicus     Generación de Registro de CNTTTSV    */
/*31 16/OCT/2009  Ana Mendez         Backoffice recaudacion PORTA-250-CU-1423 */
/*  32 04/nov/2009 Miguel Aldaz  FEL-249-CU-1408 Proyecto de facturacion */
/*                                               electronica             */
/* 33 01/Mar/2010  Tania Cumbicus   CTE-CC-8446 Recaudacion TRIPLE ORO  */
/* 34 09/Mar/2010  T.Cervantes Z.   CTE-6512    Validar si el cliente    */
/*                                              existe.                  */
/* 35 10/mar/2010  T.Cervantes Z.   CTE-6519    Correccion en la genera- */
/*                               cion del numero de comprobante.         */
/* 36 14/Mar/2011   Ana Mendez  CTE-CC-9737 MIMG- Mercados              */
/* 37 14/Mar/2011   Ana Mendez  DTV-CU-1659 DIRECTV-PREPAGO             */
/* 38 16/jun/2011   sandra Merino CTE-CC-10087                          */
/* 39 19/Agt/2011   Daniel Pereira CTE-CC-10305 Municipio de Daule      */
/* 40 22/Agosto/2011 Sandra Merino  ATMFULL-286-CU-1720                 */
/* 41 23/Sep/2011   Daniel Pereira MTAC-CU-1730 Linea de Credito Claro  */
/* 42  09/02/2012    Ana Mendez   CTE-CC-11121 Base imponible CLARO     */
/* 43 16/Feb/2012   German Medina  MGL-309-CU-1830 MARGLOBAL            */
/* 44 25/Nov/2011   Daniel Pereira  CTE-CC-10665 Batch Debitos Automaticos Claro*/
/* 45 03/abril/2013 Sandra Merino. Emision Inicial  TVCABW-SGC00007822 */
/* 46 14/Ene/2013   Daniel Pereira  SGC00005781 CNT SERVICIOS MOVILES*/
/* 47 10/Jun/2013   Daniel Pereira  SGC00009050 Proceso Back Office Ecutel*/
/* 48 02/Sep/2013   Daniel Pereira  SGC00010841 BACKOFFICE CONECEL TV SATELITAL*/
/* 49 29/Ene/2014   Daniel Pereira  SGC00012170 Facturacion Electronica  */
/* 50 15/Sep/2015   Miriam Lindao   Tarea: RETIVA-AP-SGC00021353-SGC00021355*/
/*                                  Retención IVA Bienes y Servicios        */
/* 51 17/NOV/2017  Sandra Merino M.  RECA-CC-SGC00027078 Fusion con conecel*/
/* 52 07/DIC/2017  Sandra Merino M.  RECA-CE-SGC00027303		    */
/* 53 05/Ene/2017  Jorge Pazminno  MEGA-AP-SGC00024776-SGC00024779         */
/*                                  Diferenciacion cobro comision LC x canal*/
/* 54 24/Nov/2015   María Jo. Silva SGC00022258 Municipio GYE CEP  */
/* 55 23/May/2018  Pablo Ricaurte  RECA-CC-SGC00031994 Gen y pago automatico
									de LC de primax.*/
/* 56 19/Jul/2018  Daniel Pereira  RECA-CC-SGC00032446 ATIMASA              */
/* 57 16/Ene/2019  Danny Olaya  RECA-CE-SGC00034240              */
/* 58 17/Dic/2018  María José Silva  CLAPAQ-AP-SGC00032311-SGC00032313 Claro PAQUETES*/
/* 59 23/May/2019  Danny Olaya S.  RRCYT - RECARGAS CNT, TUENTI Y MOVISTAR*/
/* 60 04/Jul/2019  Danny Olaya S.  RECMPS-39 - CLARO POSTPAGO - GENERACION DE L/C  */
/* 61 09/Mar/2020  Luis Gusñay C.  RECMPS-91 (JIRA) - CLARO BATCH FINES DE SEMANA*/
/* 62 05/May/2020  Luis Gusñay C.  RECMPS-133 (JIRA) - NUEVO CORTE PRIMAX*/
/* 63 20/May/2020  Luis Gusñay C.  RECMPS-135 (JIRA) - CLARO BATCH FIJO FINES DE SEMANA*/
/* 64 11/Jun/2020  Luis Gusñay C.  RECM-145 PROCESO DE ACREDITACION DE RECAUDACION AUTOMATICA*/
/* 65 11/Jun/2020  Jonathan Guerrero RECM-65 CONCILIACION BROADNET COMPRA PAQUETE*/
/*--------------------------------------------------------------------------*/



create proc dbo.sp_nc_rec_automatica (
    @i_empresa    int,
    @i_emp_dba    int = null,      --ref56
	@i_fec_hora   varchar(26) = null  --ref61
)
as

declare @w_fecha_pro       varchar(10),
		@w_fecha_hoy       varchar(10), --lgusnayc ref063
        @w_return          int,
        @w_flag            int,
        @w_cont            int,  
        @w_sec_mas         varchar(20),
        @w_pe_laborables   char(1),
        @w_pe_fpago        varchar(6),
        @w_pe_dias         int,
        @w_pe_costo        money,
        @w_pe_porcentaje   money,
        @w_pe_cuenta       varchar(24),
        @w_pe_impret       tinyint,
        @w_fecha_pago      datetime,
        @w_val_n           money,
        @w_val_s           money,
        @w_can_n           money,
        @w_can_s           money,      
        @w_b_imponible_n   money,
        @w_b_imponible_s   money,
        @w_v_retencion_n   money,
        @w_v_retencion_s   money,
        @w_val_ret_n       money,
        @w_val_ret_s       money,
        @w_val_ret_1       money,  --hy-21-sep-2005
        @w_val_ret_2       money,  --hy-21-sep-2005
        @w_ret_impto       money,  --hy-21-sep-2005
        @w_total_trn       int,
        @w_retencion       money,
        @w_val_retencion   money,
        @w_costo_diario    money,
        @w_total           money,
        @w_tipo_empresa    tinyint,   -- GYC 2004/Ene/13
        @w_carga           int,
        @w_base            money,
        @w_porc            float,  -- Miguel Aldaz 03-14-2008
        @w_val_n_emn1            money,     -- lfcm 27-mayo-2009
        @w_val_ret_n_emn1        money,     -- lfcm 27-mayo-2009
        @w_val_ret_1_emn1        money,     -- lfcm 27-mayo-2009
        @w_can_n_emn1            money,     -- lfcm 27-mayo-2009
        @w_b_imponible_n_emn1    money,     -- lfcm 27-mayo-2009
        @w_v_retencion_n_emn1    money,     -- lfcm 27-mayo-2009
        @w_val_s_emn1            money,     -- lfcm 27-mayo-2009
        @w_val_ret_s_emn1        money,     -- lfcm 27-mayo-2009
        @w_val_ret_2_emn1        money,     -- lfcm 27-mayo-2009
        @w_can_s_emn1            money,     -- lfcm 27-mayo-2009
        @w_b_imponible_s_emn1    money,     -- lfcm 27-mayo-2009
        @w_v_retencion_s_emn1    money,     -- lfcm 27-mayo-2009
        @w_val_n_emn2            money,     -- lfcm 27-mayo-2009
        @w_val_ret_n_emn2        money,     -- lfcm 27-mayo-2009
        @w_val_ret_1_emn2        money,     -- lfcm 27-mayo-2009
        @w_can_n_emn2            money,     -- lfcm 27-mayo-2009
        @w_b_imponible_n_emn2    money,     -- lfcm 27-mayo-2009
        @w_v_retencion_n_emn2    money,     -- lfcm 27-mayo-2009
        @w_val_s_emn2            money,     -- lfcm 27-mayo-2009
        @w_val_ret_s_emn2        money,     -- lfcm 27-mayo-2009
        @w_val_ret_2_emn2        money,     -- lfcm 27-mayo-2009
        @w_can_s_emn2            money,     -- lfcm 27-mayo-2009
        @w_b_imponible_s_emn2    money,     -- lfcm 27-mayo-2009
        @w_v_retencion_s_emn2    money,     -- lfcm 27-mayo-2009
        @w_val_retencion1        money,     -- lfcm 27-mayo-2009
        @w_val_retencion2        money,     -- lfcm 27-mayo-2009     
        @w_cliente               int,         --ref32
        @w_ind_factelect         char(1),
        @w_producto              char(4),
        @w_servicio              char(4),      
        @w_autorizacion          varchar(30),
        @w_validez               varchar(30),--ref32: Indicador de facturacion electronica
        @w_fec_ini_vig_aut       varchar (10), --ref38
        @w_fec_fin_vig_aut       varchar (10), --ref38
        @w_base_impo             money, --REF 33
        @w_acedita_grp           char(1), --REF45
        @w_cod_grupo             char(6),  --REF45
        @w_cont_especial         char(2),
        @w_baseimp0              money,
        @w_baseimp12             money,
        @w_val_ivabienes         money,
        @w_val_ivaserv           money,
        @w_ret_ivabienes         money,
        @w_ret_ivaserv           money,
        @w_exo_ivabienes         money,
        @w_exo_ivaserv           money,      
        @w_msn_error             varchar(100),
        @w_porc_ret_ivabienes    money,
        @w_porc_ret_ivaserv      money,
        @v_indCost               char(1),         -- JPM Ref.53 -->
        @v_can_c                 money,
        @v_can_c1                money,
        @v_can_c2                money,       
        @v_fecha_anterior        datetime,
        @v_ciudad                smallint,         -- <-- JPM Ref.53
        @v_sum_pn_valor          money,
        @v_sum_pn_costo_recauda  money,
        @v_sum_pn_cont_trn       int,
        @v_sum_pn_valor_uno      money,
        @v_sesn               int,
        @v_term             varchar(30),
        @v_ofi              smallint,
        @v_srv              varchar(30),
        @v_lsrv             varchar(30),
        @v_user             login,
        @v_org              char(1),
        @v_rol              smallint,
        @v_ssn              int,
		@v_iva				float,
		@v_por_ret			float,
		@v_emp_rec			int --ref59
		
select @w_flag = 0

select @w_fecha_pro = convert(varchar(10),fp_fecha, 101) from cobis..ba_fecha_proceso
select @w_fecha_pro = '04/12/2024'
-- JPM Ref.53 -->
select @v_ciudad = pa_smallint
 from cobis..cl_parametro
 where pa_nemonico = 'CFN'
   and pa_producto = 'CTE'
if @@rowcount = 0
 select @v_ciudad = 1
-- calcular fecha del dia anterior habil
select @v_fecha_anterior = max(dl_fecha)
 from cob_cuentas..cc_dias_laborables
 where dl_ciudad = @v_ciudad
   and dl_num_dias = -1
if @@rowcount <> 1
 begin
    print 'ERROR EN LECTURA DE FECHA ANTERIOR LABORABLE'
    return 1
 end
   
-- <-- JPM  Ref.53

select @w_porc = 0        -- GYC 2007/Jun/27

    SELECT pn_empresa
    FROM cob_pagos..pg_control_ncrecaudacion
    WHERE pn_empresa   = @i_empresa
    AND pn_fecha_rec = @w_fecha_pro

    if @@rowcount <> 0 and @i_empresa<>8688 and @i_empresa <> 38 and @i_empresa <> 8523 --pricaura Ref055 --ref060 --lgusnayc ref063
    begin
      print "YA EXISTE REGISTRO DE PAGO"
    end
    else
      select @w_flag = 1


--Ref058:msilvag Inicio
select @v_iva =  pa_float 
from cobis..cl_parametro
where pa_producto = 'CTE' 
and pa_nemonico = 'PIVA'
--Ref058:msilvag Fin

if @w_flag = 1
begin
  --PARAMETROS DE LA EMPRESA
  select @w_pe_fpago      = pe_fpago,
         @w_pe_cuenta     = pe_cuenta,
         @w_pe_dias       = pe_dias,
         @w_pe_costo      = pe_costo,
         @w_pe_porcentaje = pe_porcentaje,
         @w_pe_laborables = pe_laborables,
         @w_pe_impret     = pe_impret,
         @w_porc          = pe_porc_retimp,  --Miguel Aldaz 03/17/2008
         @w_cod_grupo     =  convert(char(6),pe_cod_grupo), --REF45 Empresas Grupos
         @v_indCost       = pe_imdCostCanal                 -- JPM Ref.53
  from cob_pagos..pg_person_empresa
  where pe_empresa = @i_empresa

  if @@rowcount = 0
  Begin
       print "ERROR REGISTRO DE PERSONALIZACION NO EXISTE <1001>"
       /*
       exec cobis..sp_cerror
      @t_debug= "S",
      @t_file = "svnccorpei.sp",
      @t_from = "cob_pagos",
      @i_num  = 170100,
      @i_msg  = "ERROR REGISTRO DE PERSONALIZACION NO EXISTE <1001>"
             */
       return 1
  End

  if @w_cod_grupo is null --REF 45 Empresas Grupos
  begin
      select  @w_acedita_grp = isnull(pe_acedita_grp,'N')
      from cob_pagos..pg_person_empresa
      where pe_empresa = @i_empresa  --ref 47
  end
  else
  begin
      select  @w_acedita_grp = isnull(pe_acedita_grp,'N')
      from cob_pagos..pg_person_empresa
      where pe_empresa = convert(int,@w_cod_grupo)
  end

  if @w_pe_impret = 1 and @w_porc is null   --Miguel Aldaz 03-17-2008
     select @w_porc = pa_float
     from cobis..cl_parametro
     where pa_nemonico = 'IMR'
     and pa_producto = 'CTE'             --Miguel Aldaz 03-17-2008


  if @w_pe_fpago <> 'NCRCTA'
     select @w_pe_cuenta = null

  if @i_empresa in (1417, 1433, 1800,1435 , 7749) --Ref054:msilvag  --lfcm 09-abril-2007    ---REF 36
  begin --> Inicio de Empresas 1417 y 1433
    --SE OBTIENE EL VALOR DE LA RECAUDACION
    select
           @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0)),0), --lfcm 24-octubre-2006
           @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),  --hy-21-septiembre-2005
           @w_can_n      = count(1),
           @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int, codigo)
                                  from cobis..cl_catalogo
                                  where tabla = (select codigo
                                                 from cobis..cl_tabla
                                                 where tabla = "pg_trx_emp_rec_autom"))
    and ts_correccion       = 'N'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47
    and ts_tsfecha = @w_fecha_pro


    select
         @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) + isnull(ts_contratado,0) ),0),  --lfcm 24-octubre-2006
         @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0), --hy-21-septiembre-2005
         @w_can_s     = count(1),
         @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (select convert(int, codigo)
                                  from cobis..cl_catalogo
                                  where tabla = ( select codigo
                                                  from cobis..cl_tabla
                                                  where tabla = "pg_trx_emp_rec_autom"))
    and ts_correccion       = 'S'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47
    and ts_tsfecha = @w_fecha_pro

  end --< Fin de Empresas 1417 y 1433

    -->Municipio de Ibarra. Pago del Horario Normal del dia en curso y Diferido del Dia Anterior. lfcm 18-dic-2007
  if @i_empresa = 2234 or @i_empresa = 2319 or @i_empresa = 2237 or @i_empresa = 2235 or @i_empresa = 2236 or @i_empresa = 1430 /*DAPV -19/08/2011 -M. Daule*/ /* Wise - 06/Sep/2008 - M.Libertad */
  begin --> Inicio de Empresas 1417 y 1433
    select
      @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0),
      @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
      @w_can_n      = count(1),
      @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (3221, 3215,4112)   ---REF 36
    and ts_correccion       = 'N'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47

    select
      @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0) ),0),
      @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
      @w_can_s     = count(1),
      @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (3221, 3215,4112) ---REF 36
    and ts_correccion       = 'S'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47

  end
    --<Municipio de Ibarra. Pago del Horario Normal del dia en curso y Diferido del Dia Anterior. lfcm 18-dic-2007

     /*L. Credito Emepe */
  if @i_empresa = 825 /*Emepe*/
  --smerino aumentar campo ts_contratado
  begin
    select
      @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0)),0),
      @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
      @w_can_n      = count(1),
      @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (3173,3213)
    and ts_correccion       = 'N'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47

    select
      @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) + isnull(ts_contratado,0) ),0),
      @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
      @w_can_s     = count(1),
      @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (3173,3213)
    and ts_correccion       = 'S'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47

  end
  /*Fin L. Credito Emepe  */


    -->Generar el Cálculo para las empresas de CORPEI
    if @i_empresa in (219, 222)  --lfcm 09-abril-2007
    begin --> Inicio de Empresas 1417 y 1433
        --SE OBTIENE EL VALOR DE LA RECAUDACION
        select
          @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)),0),
          @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
          @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),  --hy-21-septiembre-2005
          @w_can_n      = count(1),
          @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = (select codigo
                                                     from cobis..cl_tabla
                                                     where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'N'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro

        select
          @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0)),0),
          @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
          @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0), --hy-21-septiembre-2005
          @w_can_s     = count(1),
          @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = (select codigo
                                                     from cobis..cl_tabla
                                                     where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'S'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro

  end --< Fin de Empresas 1417 y 1433
  --<Generar el Cálculo para las empresas de CORPEI

    -->Generar el Cálculo para CATEG
    if @i_empresa in (1)  --lfcm 22-feb-2008
    begin --> Inicio de Empresa 1
    ---smerino aumentar el campo ts_contratado
        --SE OBTIENE EL VALOR DE LA RECAUDACION
        select
          @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
          @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
          @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
          @w_can_n      = count(1),
          @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = (select codigo
                                                     from cobis..cl_tabla
                                                     where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'N'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro
        and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008

        select
          @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0)),0),
          @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
          @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
          @w_can_s     = count(1),
          @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
        from cob_cuentas..cc_tran_servicio
        where ts_tipo_transaccion in (select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = (select codigo
                                                     from cobis..cl_tabla
                                                     where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'S'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro
        and ts_fecha = @w_fecha_pro    --lfcm 22-mayo-2008

  end --< Fin de Empresas 1
  --<Generar el Cálculo para CATEG


  --if @i_empresa in (334,336,338,843,320,1299,335,337)
  if @i_empresa in (select convert(int, codigo) from cobis..cl_catalogo                               --lfcm 03-julio-2007
                      where tabla in (select codigo from cobis..cl_tabla                  --lfcm 03-julio-2007
                       where tabla = 'sv_tvcable_online')                                 --lfcm 03-julio-2007
                      and valor = 'S')
  begin
    --SE OBTIENE EL VALOR DE LA RECAUDACION
    select
      @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) ),0),    --lfcm 02-02-2007 SMERINO NEW TVCABLE smerino - isnull(convert(money,ts_autoriz_aut),0)
      @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),  --hy-21-septiembre-2005
      @w_can_n      = count(1),
      @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0), --SOLO ANDINATEL
      @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                    from cobis..cl_catalogo
                    where tabla = ( select codigo
                            from cobis..cl_tabla
                            where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'N'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
      and ts_tsfecha = @w_fecha_pro

    select
      @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0)  ),0),      -- SMERINO NEW TVCABLEisnull(convert(money,ts_autoriz_aut),0)lfcm 02-02-2007
      @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
      @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0), --hy-21-septiembre-2005
      @w_can_s     = count(1),
      @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),  --SOLO ANDINATEL
      @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                    from cobis..cl_catalogo
                    where tabla = ( select codigo
                            from cobis..cl_tabla
                            where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'S'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
      and ts_tsfecha = @w_fecha_pro

  end


    if @i_empresa not in (8688,86881,86882,86883,118,1417, 2234, 1433, 1800, 219, 222, 1,2494, 2319, 2237, 2235, 862, 2572, 2575,2236, 825, 1127,1435,120,1430,39,451,38,5482,5479,3,156,8521,42,8523,5994, 40,1342,8456,8457, 19574, 19575) and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo  /*<REF 65>*/
                                                                 where tabla in (select codigo from cobis..cl_tabla     --lfcm 03-julio-2007
                                                                                 where tabla = 'sv_tvcable_online')     --lfcm 03-julio-2007
                                                                 and valor = 'S')                                   --lfcm 03-julio-2007
  begin --> Inicio de Empresas <> 1417 y 1433
  --SE OBTIENE EL VALOR DE LA RECAUDACION

  select
         @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),    --lfcm 04-enero-2007
         @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),  --hy-21-septiembre-2005
         @w_can_n      = count(1),
         @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0), --SOLO ANDINATEL
         @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
  from cob_cuentas..cc_tran_servicio
  where ts_tipo_transaccion in (  select convert(int, codigo)
                                  from cobis..cl_catalogo
                                  where tabla = ( select codigo
                                                  from cobis..cl_tabla
                                                  where tabla = "pg_trx_emp_rec_autom"))
    and ts_correccion       = 'N'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47
    and ts_tsfecha = @w_fecha_pro

  select
         @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),      --lfcm 04-enero-2007
         @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0), --hy-21-septiembre-2005
         @w_can_s     = count(1),
         @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),  --SOLO ANDINATEL
         @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
  from cob_cuentas..cc_tran_servicio
  where ts_tipo_transaccion in (  select convert(int, codigo)
                                  from cobis..cl_catalogo
                                  where tabla = ( select codigo
                                                  from cobis..cl_tabla
                                                  where tabla = "pg_trx_emp_rec_autom"))
    and ts_correccion       = 'S'
    and ts_causa     = convert(varchar,@i_empresa) --REF 47
          and ts_tsfecha = @w_fecha_pro
  end --< Fin de Empresas <> 1417 y 1433


  if @i_empresa in (8688,86881,86882,86883)  --ref56 --ref62
  begin        
  
  	if @i_emp_dba is null
 		select @i_emp_dba = @i_empresa 
  	
	select
	         @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),   
	         @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
	         @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),  
	         @w_can_n      = count(1),
	         @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0), 
	         @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0) 
	  from cob_cuentas..cc_tran_servicio
	  where ts_tipo_transaccion in (  select convert(int, codigo)
	                                  from cobis..cl_catalogo
	                                  where tabla = ( select codigo
	                                                  from cobis..cl_tabla
	                                                  where tabla = "pg_trx_emp_rec_autom"))
	    and ts_correccion       = 'N'
	    and ts_causa     = convert(varchar,@i_empresa)
	    and ts_tsfecha = @w_fecha_pro
	    and ts_default = @i_emp_dba	   
	
	  select
	         @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),  
	         @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
	         @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0), 
	         @w_can_s     = count(1),
	         @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),  
	         @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       
	  from cob_cuentas..cc_tran_servicio
	  where ts_tipo_transaccion in (  select convert(int, codigo)
	                                  from cobis..cl_catalogo
	                                  where tabla = ( select codigo
	                                                  from cobis..cl_tabla
	                                                  where tabla = "pg_trx_emp_rec_autom"))
          and ts_correccion       = 'S'
	  and ts_causa     = convert(varchar,@i_empresa)
          and ts_tsfecha = @w_fecha_pro
          and ts_default = @i_emp_dba

   end --if @i_empresa in (8688,86881,86882)

   if @i_empresa = 1127
   begin
        --smerino aumenta campo ts_contratado
     select
       @w_val_n_emn1     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),   --lfcm 04-enero-2007
       @w_val_ret_n_emn1 = isnull(sum(isnull(ts_ocasional,0)),0),
       @w_val_ret_1_emn1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
       @w_can_n_emn1      = count(1),
       @w_b_imponible_n_emn1 = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
       @w_v_retencion_n_emn1 = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
     from cob_cuentas..cc_tran_servicio
     where ts_tipo_transaccion in (   select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
     and ts_correccion       = 'N'
     and ts_causa     = convert(varchar,@i_empresa) --REF 47
     and ts_tsfecha = @w_fecha_pro
     and ts_fecha = @w_fecha_pro
     and ts_stick_imp > '0'

     select
       @w_val_s_emn1     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),     --lfcm 04-enero-2007
       @w_val_ret_s_emn1 = isnull(sum(isnull(ts_ocasional,0)),0),
       @w_val_ret_2_emn1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
       @w_can_s_emn1     = count(1),
       @w_b_imponible_s_emn1 = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
       @w_v_retencion_s_emn1 = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
     from cob_cuentas..cc_tran_servicio
     where ts_tipo_transaccion in (   select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
     and ts_correccion       = 'S'
     and ts_causa     = convert(varchar,@i_empresa) --REF 47
     and ts_tsfecha = @w_fecha_pro
     and ts_fecha = @w_fecha_pro
     and ts_stick_imp > '0'

     select @w_val_retencion1 = @w_val_ret_1_emn1 + @w_val_ret_2_emn1

     select
       @w_val_n_emn2     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),   --lfcm 04-enero-2007
       @w_val_ret_n_emn2 = isnull(sum(isnull(ts_ocasional,0)),0),
       @w_val_ret_1_emn2 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) ),0),
       @w_can_n_emn2      = count(1),
       @w_b_imponible_n_emn2 = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
       @w_v_retencion_n_emn2 = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
     from cob_cuentas..cc_tran_servicio
     where ts_tipo_transaccion in (   select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
     and ts_correccion       = 'N'
     and ts_causa     = convert(varchar,@i_empresa) --REF 47
     and ts_tsfecha = @w_fecha_pro
     and ts_fecha = @w_fecha_pro
     and (ts_stick_imp = '0.00' or ts_stick_imp = '0' OR ts_stick_imp is null)

     select
        @w_val_s_emn2     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),     --lfcm 04-enero-2007
        @w_val_ret_s_emn2 = isnull(sum(isnull(ts_ocasional,0)),0),
        @w_val_ret_2_emn2 = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) ),0),
        @w_can_s_emn2     = count(1),
        @w_b_imponible_s_emn2 = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
        @w_v_retencion_s_emn2 = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
     from cob_cuentas..cc_tran_servicio
     where ts_tipo_transaccion in (   select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
     and ts_correccion       = 'S'
     and ts_causa     = convert(varchar,@i_empresa) --REF 47
     and ts_tsfecha = @w_fecha_pro
     and ts_fecha = @w_fecha_pro
     and (ts_stick_imp = '0' or ts_stick_imp is null)

      select @w_val_retencion2 = round((@w_val_ret_1_emn2 - @w_val_ret_2_emn2) * @w_porc, 2)   --Calcularporcentaje personalizado cuando no se obtiene el valor en el pago.

       select @w_val_n = @w_val_n_emn1 + @w_val_n_emn2
       select @w_val_s = @w_val_s_emn1 + @w_val_s_emn2
       select @w_can_n = @w_can_n_emn1 + @w_can_n_emn2
       select @w_can_s = @w_can_s_emn1 + @w_can_s_emn2
       select @w_val_ret_n = @w_val_ret_n_emn1 + @w_val_ret_n_emn1
       select @w_val_ret_s = @w_val_ret_s_emn1 + @w_val_ret_s_emn2
       select @w_val_ret_1 = @w_val_ret_1_emn1 + @w_val_ret_1_emn2
       select @w_val_ret_2 = @w_val_ret_2_emn1 + @w_val_ret_2_emn2

  end

  --GAMC - 16/05/2008 - SOAT
  if @i_empresa in (862) and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo
                                                where tabla in (select codigo from cobis..cl_tabla
                                                                where tabla = 'sv_tvcable_online')
                                                and valor = 'S')
    begin --INICIO SOAT - INI
    --SE OBTIENE EL VALOR DE LA RECAUDACION
    select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0)),0),
         @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
         @w_can_n      = count(1),
         @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0), --SOLO ANDINATEL
         @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                                    from cobis..cl_catalogo
                                    where tabla = ( select codigo
                                                    from cobis..cl_tabla
                                                    where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'N'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
      and ts_tsfecha = @w_fecha_pro


    select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0)),0),
         @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
         @w_can_s     = count(1),
         @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),  --SOLO ANDINATEL
         @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                                    from cobis..cl_catalogo
                                    where tabla = ( select codigo
                                                    from cobis..cl_tabla
                                                    where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'S'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro

  end   --INICIO SOAT - FIN


  if @i_empresa in (120,118,2572,2575,156,5994,8521) and @i_empresa not in (select convert(int, codigo) from cobis..cl_catalogo --REF 47 48 REF51 SMM    
                                                                  where tabla in (select codigo from cobis..cl_tabla
                                                                                  where tabla = 'sv_tvcable_online')
                                                                  and valor = 'S')
          begin --INICIO CTG - INI
    --SE OBTIENE EL VALOR DE LA RECAUDACION


    select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
         @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_1 = 0,
         @w_can_n      = count(1),
         @w_b_imponible_n =  0,  --SOLO ANDINATEL
         @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)      --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                                    from cobis..cl_catalogo
                                    where tabla = ( select codigo
                                                    from cobis..cl_tabla
                                                    where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'N'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
      and ts_tsfecha = @w_fecha_pro

    select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
         @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
         @w_val_ret_2 = 0, --isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
         @w_can_s     = count(1),
         @w_b_imponible_s = 0,  --SOLO ANDINATEL
         @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)       --SOLO ANDINATEL
    from cob_cuentas..cc_tran_servicio
    where ts_tipo_transaccion in (  select convert(int, codigo)
                                    from cobis..cl_catalogo
                                    where tabla = ( select codigo
                                                    from cobis..cl_tabla
                                                    where tabla = "pg_trx_emp_rec_autom"))
      and ts_correccion       = 'S'
      and ts_causa     = convert(varchar,@i_empresa) --REF 47
      and ts_tsfecha = @w_fecha_pro


  end   --INICIO CTG - FIN

  ----REF 42
    if @i_empresa in ( 39 , 40 , 1342,8456,8457, 19574, 19575)  /*<REF 65>*/
       begin       --SE OBTIENE EL VALOR DE LA RECAUDACION

      --ref59 Ini
	  if @i_empresa = 1342
		select @v_emp_rec = 103
	   else
		select @v_emp_rec = @i_empresa
	  --ref59 Fin
	   
	   
      select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_1 = 0,
           @w_can_n      = count(1),
           @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_aut),0)),0),
           @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                    from cobis..cl_tabla
                                                    where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'N'
        and ts_causa     = convert(varchar,@v_emp_rec) --REF 47--ref59
        and ts_tsfecha = @w_fecha_pro

      select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_2 = 0,
           @w_can_s     = count(1),
           @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_aut),0)),0),
           @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'S'
        and ts_causa     = convert(varchar,@v_emp_rec) --REF 47 -- ref59
        and ts_tsfecha = @w_fecha_pro


      end
  ----REF 42
  -- ref: 43
  if @i_empresa in (451)
  begin -- MARGLOBAL - INI
      --SE OBTIENE EL VALOR DE LA RECAUDACION
      select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_1 = 0,
           @w_can_n      = count(1),
           @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
           @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'N'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro

      select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_2 = 0, --isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
           @w_can_s     = count(1),
           @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
           @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'S'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro



  end   -- MARGLOBAL - FIN

  ---REF 44
    --if @i_empresa = 38
    if @i_empresa in (42,8523) --REF 47 REF52 SMM --REF 60 
    begin       --SE OBTIENE EL VALOR DE LA RECAUDACION
	--ini lgusnayc ref063
	select @w_fecha_hoy = '01/01/1990' --lgusnayc ref064
	if @i_empresa in (8523)
		select @w_fecha_hoy = convert(varchar(10), getdate(), 101) --lgusnayc ref064
	--fin lgusnayc ref063	
		
      select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_1 = 0,
           @w_can_n      = count(1),
           @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
           @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'N'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro
		and ts_hora > @w_fecha_hoy --lgusnayc ref063 ref064

     select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
           @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
           @w_val_ret_2 = 0,
           @w_can_s     = count(1),
           @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
           @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
      from cob_cuentas..cc_tran_servicio
      where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
        and ts_correccion       = 'S'
        and ts_causa     = convert(varchar,@i_empresa) --REF 47
        and ts_tsfecha = @w_fecha_pro
		and ts_hora > @w_fecha_hoy --lgusnayc ref063 ref064
    end

	--REF 60 INI
	
	if @i_empresa in (38) 
    begin
	
	  select @w_carga = @i_emp_dba

	  if @w_carga > 0	
	  begin	
		select @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
				@w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
				@w_val_ret_1 = 0,
				@w_can_n      = count(1),
				@w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
				@w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
			from cob_cuentas..cc_tran_servicio
			where ts_tipo_transaccion in (select convert(int, codigo)
												from cobis..cl_catalogo
												where tabla = ( select codigo
															from cobis..cl_tabla
															where tabla = "pg_trx_emp_rec_autom"))
			and ts_correccion       = 'N'
			and ts_causa     = convert(varchar,@i_empresa)
			and ts_tsfecha = @w_fecha_pro
			and ts_default = @w_carga
			and ts_hora >= isnull(@i_fec_hora, ts_hora) --ref61

		select @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0)),0),
				@w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
				@w_val_ret_2 = 0,
				@w_can_s     = count(1),
				@w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
				@w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
			from cob_cuentas..cc_tran_servicio
			where ts_tipo_transaccion in (  select convert(int, codigo)
                                      from cobis..cl_catalogo
                                      where tabla = ( select codigo
                                                      from cobis..cl_tabla
                                                      where tabla = "pg_trx_emp_rec_autom"))
			and ts_correccion       = 'S'
			and ts_causa     = convert(varchar,@i_empresa)
			and ts_tsfecha = @w_fecha_pro
			and ts_default = @w_carga
			and ts_hora >= isnull(@i_fec_hora, ts_hora) --ref61
		end
		else
		begin
			select @w_val_n = 0
			select @w_val_s = 0
		end
		
    end
	
	--REF 60 FIN

      if @i_empresa = 5479 --ref45
      begin
        if @w_acedita_grp = 'S'
        begin
            select
              @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),    --lfcm 04-enero-2007
              @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
              @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
              @w_can_n      = count(1),
              @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
              @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                            from cobis..cl_catalogo
                                            where tabla = ( select codigo
                                                            from cobis..cl_tabla
                                                            where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'N'
            and rtrim(ts_propietario)     = convert(varchar,@i_empresa)
            and ts_tsfecha = @w_fecha_pro

            select
                   @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),      --lfcm 04-enero-2007
                   @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
                   @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
                   @w_can_s     = count(1),
                   @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
                   @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
          from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'S'
            and rtrim(ts_propietario)     = convert(varchar,@i_empresa)
            and ts_tsfecha = @w_fecha_pro
        end
      else
        begin
          exec cobis..sp_cerror
                    @t_debug         = "N",
                    @t_file          = "ncreauto",
                    @t_from          = "sp_ncorpei",
                    @i_msg           = 'NO ESTA PARAMETRIZADO COMO ACREDITACIÒN GRUPO',
                    @i_num           = 111111
               return 1
        end
     end



     if @i_empresa in (5482,3)--ref45
     begin
        if @w_acedita_grp = 'N'
        begin
            select
               @w_val_n     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),    --lfcm 04-enero-2007
               @w_val_ret_n = isnull(sum(isnull(ts_ocasional,0)),0),
               @w_val_ret_1 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
               @w_can_n      = count(1),
               @w_b_imponible_n = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
               @w_v_retencion_n = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
            from cob_cuentas..cc_tran_servicio
            where ts_tipo_transaccion in (  select convert(int, codigo)
                                            from cobis..cl_catalogo
                                            where tabla = ( select codigo
                                                            from cobis..cl_tabla
                                                            where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'N'
            and ts_causa     = convert(varchar,@i_empresa) --REF 47
            and ts_tsfecha = @w_fecha_pro

            select
                   @w_val_s     = isnull(sum(isnull(ts_saldo,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)+ isnull(ts_monto,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) ),0),      --lfcm 04-enero-2007
                   @w_val_ret_s = isnull(sum(isnull(ts_ocasional,0)),0),
                   @w_val_ret_2 = isnull(sum(isnull(convert(money,ts_stick_imp),0)),0),
                   @w_can_s     = count(1),
                   @w_b_imponible_s = isnull(sum(isnull(convert(money, ts_autoriz_anula),0)),0),
                   @w_v_retencion_s = isnull(sum(isnull(convert(money, ts_ccontable),0)),0)
          from cob_cuentas..cc_tran_servicio
          where ts_tipo_transaccion in (  select convert(int, codigo)
                                          from cobis..cl_catalogo
                                          where tabla = ( select codigo
                                                          from cobis..cl_tabla
                                                          where tabla = "pg_trx_emp_rec_autom"))
            and ts_correccion       = 'S'
            and ts_causa     = convert(varchar,@i_empresa) --REF 47
            and ts_tsfecha = @w_fecha_pro
        end
        else
        begin
            exec cobis..sp_cerror
                    @t_debug         = "N",
                    @t_file          = "ncreauto",
                    @t_from          = "sp_ncorpei",
                    @i_msg           = 'ESTA PARAMETRIZADO COMO ACREDITACIÒN GRUPO',
                    @i_num           = 111111
               return 1
        end
     end

    
    -->Ref50 MLR: Calculo de la Retención IVA Bienes Servicio
    set @w_baseimp0      = 0,
        @w_baseimp12     = 0,
        @w_val_ivabienes = 0,
        @w_val_ivaserv   = 0,
        @w_ret_ivabienes = 0,
        @w_ret_ivaserv   = 0,
        @w_exo_ivabienes = 0,
        @w_exo_ivaserv   = 0
    if exists ( select 1  -- Se valida si la empresa está configurada para la Retención del IVA Bienes y Servicios
                     from cobis..cl_tabla t,
                          cobis..cl_catalogo c
                    where t.codigo = c.tabla
                      and t.tabla = 'pg_recaudacion_aut_retiva'
                      and c.codigo = convert(varchar,@i_empresa))  --and ( @w_ret_ivabienes > 0 or @w_ret_ivaserv > 0))
    begin
      -- Se valida si existe registro de Retención IVA en tabla pg_tran_servicio_ret
       if exists ( select 1 
                     from cob_pagos..pg_tran_servicio_ret r
                    where ts_causa = convert(varchar,@i_empresa)
                      and ts_fecha = @w_fecha_pro
                      and exists( select 1  
                                    from cobis..cl_tabla t,
                                         cobis..cl_catalogo c
                                   where t.codigo = c.tabla
                                     and t.tabla = 'pg_trx_emp_rec_autom'
                                     and c.codigo = convert(varchar, r.ts_tipo_transaccion)))
       begin
		  --REF 60 INI
		  if @i_empresa = 38
		  begin
			select
                 @w_baseimp0      = sum(ts_baseimp0  * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_baseimp12     = sum(ts_baseimp12 * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_val_ivabienes = sum(ts_ivabienes * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_val_ivaserv   = sum(ts_ivaservicio * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_exo_ivabienes = sum(ts_exonera_ivabienes * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_exo_ivaserv   = sum(ts_exonera_ivaserv * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end)
            from cob_pagos..pg_tran_servicio_ret r,
                 cob_cuentas..cc_tran_servicio s
           where r.ts_secuencial = s.ts_secuencial
             and r.ts_cod_alterno = s.ts_cod_alterno 
             and r.ts_tipo_transaccion = s.ts_tipo_transaccion
             and r.ts_clase = s.ts_clase
             and r.ts_causa = '38'
			 and s.ts_default = @i_emp_dba
             and r.ts_fecha = @w_fecha_pro
			 and s.ts_hora >= isnull(@i_fec_hora, s.ts_hora) --ref 61
             and exists(select 1  
                          from cobis..cl_tabla t,
                               cobis..cl_catalogo c
                         where t.codigo = c.tabla
                           and t.tabla = 'pg_trx_emp_rec_autom'
                           and c.codigo = convert(varchar, r.ts_tipo_transaccion))
		  end
		  else
		  begin
			select --@w_cont_especial = ts_contrib_especial,
                 @w_baseimp0      = sum(ts_baseimp0  * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),--Si es Reverso se multiplica el valor por -1 para que se reste
                 @w_baseimp12     = sum(ts_baseimp12 * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_val_ivabienes = sum(ts_ivabienes * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_val_ivaserv   = sum(ts_ivaservicio * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_exo_ivabienes = sum(ts_exonera_ivabienes * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end),
                 @w_exo_ivaserv   = sum(ts_exonera_ivaserv * case when isnull(ts_correccion,'N') = 'N' then 1 else -1 end)
            from cob_pagos..pg_tran_servicio_ret r,
                 cob_cuentas..cc_tran_servicio s
           where r.ts_secuencial = s.ts_secuencial
             and r.ts_cod_alterno = s.ts_cod_alterno 
             and r.ts_tipo_transaccion = s.ts_tipo_transaccion
             and r.ts_clase = s.ts_clase
             and r.ts_causa = convert(varchar,@i_empresa)
             and r.ts_fecha = @w_fecha_pro
             and exists(select 1  
                          from cobis..cl_tabla t,
                               cobis..cl_catalogo c
                         where t.codigo = c.tabla
                           and t.tabla = 'pg_trx_emp_rec_autom'
                           and c.codigo = convert(varchar, r.ts_tipo_transaccion))
			--REF 60 FIN
		  end

           -- Obtención de la Retención del IVA Bienes y Servicio
           exec @w_return  = cob_pagos..sp_obt_porc_retiva_bieser 
                 @i_cod_cliente  = @i_empresa,
                 @o_cont_especial= @w_cont_especial out,
                 @o_por_ret_bie  = @w_porc_ret_ivabienes out,
                 @o_por_ret_ser  = @w_porc_ret_ivaserv out
          
          if @w_return != 0
           begin
               set @w_msn_error = 'ERROR AL OBTENER PORC. RET.IVA BIENES Y SERVICIOS ' + convert(varchar,@i_empresa)
               exec cobis..sp_cerror
                         @t_debug      = "N",
                         @t_file       = "ncreauto",
                         @t_from       = "sp_ncorpei",
                         @i_msg        = @w_msn_error, -- convert(varchar,@i_empresa),
                         @i_num        = @w_return
               return @w_return
           end
           -- Calculo de la Retención del IVA Bienes y Servicio
           set @w_ret_ivabienes = isnull(@w_val_ivabienes,0) * (isnull(@w_porc_ret_ivabienes,0)/100),
               @w_ret_ivaserv   = isnull(@w_val_ivaserv,0) * (isnull(@w_porc_ret_ivaserv,0)/100)
    
      end
    end
    --<--Fin Ref50
  select @w_total     = @w_val_n - @w_val_s
  select @w_total_trn = isnull(@w_can_n,0) - isnull(@w_can_s,0)   ---lfcm 02-dic-2008
  
  select @w_retencion = @w_val_ret_n - @w_val_ret_s
  select @w_ret_impto = @w_val_ret_1 - @w_val_ret_2  --hy-21-septiembre-2005
  select @w_base = @w_total


  if @i_empresa in (114,39,451,38,42,8523,1342,8456,8457, 19574, 19575)  /*<REF 65>*/
    select @w_base_impo = @w_b_imponible_n - @w_b_imponible_s --REF 33

  if @i_empresa in (39,38,42,8523,1342,8456,8457, 19574, 19575)  /*<REF 65>*/
     select @w_base = @w_base_impo ---- REF 42 
	 
  if @w_total_trn = 0
  begin
        print "NO EXISTE REGISTROS DE RECAUDACIONES"
        return 1
  end

	--Ref058:msilvag Inicio
	if @i_empresa in (39, 40, 103,1342,8456,8457, 19574, 19575)   /*<REF 65>*/
	begin
		select @w_base = @w_total / @v_iva
		
		select @v_por_ret = pe_porc_retimp
		from cob_pagos..pg_person_empresa
		where pe_empresa = @i_empresa
		
		select @w_val_retencion = (@w_base * @v_por_ret) --/ @w_total_trn
		--select @w_val_retencion = @w_ret_ivaserv
		--@w_ret_ivaserv   @w_total_trn
	end
	--Ref058:msilvag Fin
	
  --ref060 Ini
  
  if @i_empresa = 38
  begin
	select @w_carga = @i_emp_dba
  end
  else
  begin
	select @w_carga = null
  end
  
  --ref060 Fin
  
  select @w_tipo_empresa = 0

  create table ##rev_tran_pagos (ssn_corr        int     null)

BEGIN TRAN
  -- JPM Ref.53 -->
  -- diferenciacion de comision por canal
  if  @v_indCost = 'S'
   begin
     if not exists(select 1
                from cob_pagos..pg_costo_com_canal
                where pg_empresa = @i_empresa)
     begin
       rollback tran
       print "Error Costo por canal no esta Parametrizado"
       return 1
     end
     select @v_can_c1 = count(1)
      from cob_cuentas..cc_tran_servicio,
           cob_pagos..pg_concil_cnb
      where ts_tsfecha = cc_fecha
        and ts_secuencial = cc_sec_trans
        and cc_conciliada='NO'
        and ts_tipo_transaccion in (select convert(int,b.codigo) 
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V')
        and ts_causa = convert(varchar,@i_empresa)
        and ts_tsfecha = @w_fecha_pro
		and ts_terminal = cc_terminal --ref057
     ---aumenta conciliacion cnb
     select @v_can_c2 = count(1)
      from cob_cuentas..cc_tran_servicio,
           cob_pagos..pg_concil_cnb
      where ts_tsfecha = @w_fecha_pro
        and ts_secuencial = cc_sec_trans
        and ts_tipo_transaccion in (3928)
        and cc_conciliada = 'NO'
        and ts_causa = convert(varchar,@i_empresa)  
        and cc_fecha = @v_fecha_anterior
		and ts_terminal = cc_terminal --ref057
     
     select @v_can_c = isnull(@v_can_c1,0) +  isnull(@v_can_c2,0)
     insert into  cob_pagos..pg_control_com_canal
            (pg_empresa, pg_fecha, pg_canal, pg_cant, pg_costo, pg_total)
     select convert(int,ts_causa),
            @w_fecha_pro,
            ts_tipo_chequera,
            (case ts_tipo_chequera
                when 'CNB' then count(ts_secuencial) - isnull(@v_can_c,0)
                else count(ts_secuencial)
             end),
             pg_costo,
            (case ts_tipo_chequera
               when 'CNB' then (pg_costo * (count(ts_secuencial) - isnull(@v_can_c,0)) ) 
               else (pg_costo * (count(ts_secuencial)) ) 
             end)
      from cob_cuentas..cc_tran_servicio,
           cob_pagos..pg_costo_com_canal
      where ts_tsfecha = @w_fecha_pro
        and ts_causa = convert(varchar,@i_empresa)
        and ts_correccion ='N'
        and ts_tipo_transaccion in (select convert(int,b.codigo)
                                     from cobis..cl_tabla a, cobis..cl_catalogo b
                                     where a.tabla = 'sv_trx_nordif'
                                       and a.codigo = b.tabla
                                       and estado = 'V')
        and ts_secuencial not in (select isnull(ts_ssn_corr,0)
                                   from  cob_cuentas..cc_tran_servicio 
                                   where ts_tsfecha = @w_fecha_pro   
                                     and ts_correccion = "S"  and  ts_causa=convert(varchar,@i_empresa)
                                     and ts_tipo_transaccion in (select convert(int,b.codigo) 
                                                                  from cobis..cl_tabla a, cobis..cl_catalogo b
                                                                  where a.tabla = 'sv_trx_nordif'
                                                                    and a.codigo = b.tabla
                                                                    and estado = 'V')) 
        and  ts_causa = convert(varchar,pg_empresa)
        and  pg_canal =ts_tipo_chequera
     group by ts_tipo_chequera, ts_causa, pg_costo
     
     if @@rowcount = 0
     begin
      rollback tran
      print 'ERROR AL INSERTAR COMISION POR CANAL '
      return 1
     end
  end
  -- <-- JPM Ref.53
  
  if @i_empresa = 3
  begin


    select @w_tipo_empresa = 1

                --TOMAR LOS VALORES DE RECAUDACION DE IMPUESTOS
                --FMV 08-NOV-2004
    exec @w_return = cob_pagos..sp_nc_imp_rec_automatica
        @i_fecha_pro = @w_fecha_pro,
        @i_empresa   = @i_empresa,
        @o_sec_carga = @w_carga out

    if @w_return != 0
    begin
         rollback tran
         exec cobis..sp_cerror
        @t_debug = "N",
        @t_file  = "ncreauto",
        @t_from  = "ncreauto",
        @i_num   = 170600,
        @i_msg   = "ERROR AL REGISTRA BASES IMPONIBLES"
         return @w_return
    end

  end

  if @w_pe_impret = 1
     begin      -- personalizacion x Andinatel y Telecsa  -- GYC 2004/Ene/13
       if exists (select 1
          from cob_pagos..pg_roles_imp_empresa_his
          where rh_empresa    = @i_empresa
          and rh_tipo_impto in ("IDA", "RIB")
          and rh_fecha      = @w_fecha_pro )
         begin
            select @w_base = sum(rh_valor),
                   @w_carga = rh_seccarga
            from cob_pagos..pg_roles_imp_empresa_his
            where rh_empresa    = @i_empresa
            and rh_tipo_impto in ("IDA", "RIB")
            and rh_fecha      = @w_fecha_pro
            group by rh_seccarga

            select @w_tipo_empresa = 1
          end
         else
            select @w_base = @w_total


		--Ref058:msilvag Inicio
		if @i_empresa in (39, 103, 40,1342,8456,8457, 19574, 19575) /*<REF 65>*/
			select @w_base = @w_total / @v_iva
		--Ref058:msilvag Fin

             --<hy-21-septiembre-2005
         if @i_empresa = 617
             select @w_val_retencion = @w_ret_impto
         else

          if @i_empresa = 1127                      --lfcm 28-mayo-2009
             select @w_val_retencion = @w_val_retencion1 + @w_val_retencion2  --lfcm 28-mayo-2009
          else                                                                --lfcm 28-mayo-2009
          --Ref058:msilvag Inicio
          begin
			if @i_empresa not in (39,40,103,1342,8456,8457, 19574, 19575) /*<REF 65>*/
             select @w_val_retencion = round(@w_total * @w_porc, 2)  --Miguel Aldaz 03-17-2008
		  end 
		  --Ref058:msilvag Fin
		  
          if @i_empresa in (114,451,38,42,8523)  and @w_base_impo   > 0  --REF 47 REF52 SMM 
              select @w_val_retencion = round(@w_base_impo * @w_porc, 2),   --REF 33
                     @w_base =  @w_base_impo



       --<hy-21-septiembre-2005
     end
  else
     select @w_val_retencion = 0

  select @w_costo_diario  = round((isnull(@w_pe_costo,0) * isnull(@w_total_trn,0)),2)

                   --ref32
             select @w_cliente=(select en_ente from cobis..cl_ente where en_ced_ruc = a.pe_ruc)
             from cob_pagos..pg_person_empresa a
             where  pe_empresa = @i_empresa

               select @w_producto = 'RECA',
                      @w_servicio = 'RECS'

         
                      select @w_ind_factelect = 'E'


           
              --ref32: Indicador de facturacion electronica


  --CHEQUEO DE LOS DIAS LABORABLES
  --PRINT "%1!", @w_pe_laborables

  if @w_pe_laborables = 'N'
  begin
    select @w_fecha_pago = dateadd(dd,@w_pe_dias,@w_fecha_pro)
    while exists (select 1 from cobis..cl_dias_feriados --REF 47
                  where df_ciudad = 1
                  and df_fecha = @w_fecha_pago)
    begin
        select @w_fecha_pago = dateadd(dd, +1, @w_fecha_pago)
    end
  end
  else
  begin
    select @w_fecha_pago = @w_fecha_pro
    select @w_cont = 0
          --print "NUM DIAS %1!", @w_pe_dias

    while @w_cont < @w_pe_dias   --REF 47
    begin
      select  @w_fecha_pago = dateadd(dd, 1, @w_fecha_pago)
      if not exists (select 1
                        from  cobis..cl_dias_feriados
                        where df_fecha = @w_fecha_pago
                        and df_ciudad = 1 )
           select @w_cont = @w_cont + 1

     end

  end


  ---INSERCION DE LOS REGISTROS
  --select @w_sec_mas = @w_pto_estab + '-' +  @w_pto_emis + '-'  + right( "000000000"+convert(varchar(9), @o_secuencia),9)  --ref35: numero de comprobante de retencion --ref32secuencia a 9
  	  if  @v_indCost = 'S'   --REF8 SMERINO BELCORP		-- JPM Ref.53 -->
      begin
        select @w_fecha_pro = convert(varchar(10),fp_fecha,101) from cobis..ba_fecha_proceso
        --- saca el valor total de comision por los canales
        select @w_costo_diario = isnull(sum(pg_total), 0)
         from cob_pagos..pg_control_com_canal
         where pg_empresa = @i_empresa
           and pg_fecha   = @w_fecha_pro  --se  debe de validar fechas
      end
      else											-- <-- JPM Ref.53
        select @w_costo_diario = round((isnull(@w_pe_costo,0) * isnull(@w_total_trn,0)),2)

        --pricaura ini Ref055 Generacion de LC diferencial
        if(@i_empresa=8688)
        begin
            select @w_carga = @i_emp_dba  --ref56
            select @v_sum_pn_valor=sum(pn_valor),
               @v_sum_pn_costo_recauda=sum(pn_costo_recauda),
               @v_sum_pn_cont_trn=sum(pn_cont_trn),
               @v_sum_pn_valor_uno=sum(pn_valor_uno)
            from cob_pagos..pg_control_ncrecaudacion
            where pn_empresa   = 8688
            and pn_fecha_rec = @w_fecha_pro
            and pn_sec_servicio = @i_emp_dba  --ref56	
	
	if(@v_sum_pn_valor is not null)
               select @w_total=@w_total-@v_sum_pn_valor, 
                   @w_costo_diario=@w_costo_diario-@v_sum_pn_costo_recauda, 
                   @w_total_trn=@w_total_trn-@v_sum_pn_cont_trn,
                   @w_base=@w_base-@v_sum_pn_valor_uno
            --pn_valor=@w_total pn_costo_recauda=@w_costo_diario pn_cont_trn=@w_total_trn	pn_valor_uno=@w_base			
            
			--Calculo de la LC no generó una nueva LC
            if(@w_total=0)
			begin
				rollback tran
				return 0
			end	
			
        end
		--pricaura fin Ref055 Generacion de LC diferencial

      insert cob_pagos..pg_control_ncrecaudacion    --Miguel Aldaz 03-17-2008
  ( pn_empresa,   pn_fecha_rec,  pn_fecha_pago,  pn_valor,      pn_retencion,     pn_costo_recauda,
    pn_cont_trn,  pn_forma_pago, pn_estado,      pn_secuencial, pn_retimpret,     pn_cta_banco,
    pn_fecha_efec,pn_tipo_empresa, pn_sec_servicio, pn_valor_uno, pn_fact_elect, pn_autorizacion, pn_fecval_formato, pn_fecha_ini_vig, pn_fecha_fin_vig,   --ref32: Indicador de facturacion electronica -ref38
    /*<Ref50 INI*/ pn_contrib_especial, pn_baseimp0, pn_baseimp12, pn_ivabienes, pn_ivaservicio, pn_exonera_ivabienes, pn_exonera_ivaserv, pn_val_ret_bienes, pn_val_ret_serv ) /* fin Ref50>*/
        values
        ( @i_empresa,   @w_fecha_pro,  @w_fecha_pago,  @w_total,      @w_retencion,     @w_costo_diario,
          @w_total_trn, @w_pe_fpago,   'N',            @w_sec_mas,    @w_val_retencion, @w_pe_cuenta,
          null, @w_tipo_empresa, @w_carga, @w_base,@w_ind_factelect,@w_autorizacion,@w_validez, @w_fec_ini_vig_aut, @w_fec_fin_vig_aut,   --ref32: Indicador de facturacion electronica -ref38
          --Miguel Aldaz 03-17-2008
         /*<Ref50 INI*/ @w_cont_especial, @w_baseimp0, @w_baseimp12, @w_val_ivabienes, @w_val_ivaserv, @w_exo_ivabienes, @w_exo_ivaserv, @w_ret_ivabienes, @w_ret_ivaserv) /* fin Ref50>*/

        if @@rowcount = 0
        begin
            rollback tran             -- JPM Ref.53
            exec cobis..sp_cerror
      @t_debug = "N",
            @t_file  = "nccorpei.sp",
            @t_from  = "sp_ncorpei",
      @i_num   = 170600,
                  @i_msg    = 'ERROR EN TABLA DE NC A EMPRESAS'
            return 2103001
         end
		 
		--pricaura ini Ref055 Pago automatico de LC diferencial
		if(@i_empresa=8688)
        begin
			exec @w_return = cobis..pa_CanalesNoCobis_interfase 
			@i_canal            ='DBA',
			@s_ssn              = @v_ssn out,
			@s_user             = @v_user out,
			@s_sesn             = @v_sesn  out,
			@s_term             = @v_term out,
			@s_srv              = @v_srv out,
			@s_lsrv             = @v_lsrv out,
			@s_ofi              = @v_ofi out,
			@s_rol              = @v_rol out,
			@s_org              = @v_org out
			
			if(@w_return!=0)
			begin
				rollback tran
				exec cobis..sp_cerror
				  @t_debug = "N",
				  @t_file  = "nccorpei.sp",
				  @t_from  = "sp_ncorpei",
				  @i_num   = 170600,
				  @i_msg    = 'ERROR EN CANALES NO COBIS'
				return 2103001
            end
			
			--realiza el pago automático de la LC
			exec @w_return = cob_pagos..sp_tr_pago_empresa
			 @i_empresa             = 8688,
			 @s_sesn                = @v_sesn,
			 @s_term                = @v_term,
			 @i_fecha               = @w_fecha_pro,
			 @i_operacion           = 'P',
			 @s_date                = @w_fecha_pro,
			 @s_ofi                 = @v_ofi,
			 @i_moneda              = 1,
			 @s_srv                 = @v_srv,
			 @t_trn                 = 3227,
			 @i_secuencia           = 8688,
			 @s_user                = @v_user,
			 @i_valor               = @w_total,
			 @s_lsrv                = @v_lsrv,
			 @s_org                 = @v_org,
			 @i_fecha_rec           = @w_fecha_pro,
			 @s_rol                 = @v_rol,
			 @s_ssn                 = @v_ssn,
			 @t_corr                = 'N',
			 @i_emp_dba		= @i_emp_dba   --ref56
		
			if(@w_return!=0)
			begin
				rollback tran
				exec cobis..sp_cerror
				  @t_debug = "N",
				  @t_file  = "nccorpei.sp",
				  @t_from  = "sp_ncorpei",
				  @i_num   = 170600,
				  @i_msg    = 'ERROR EN PAGO LC PRIMAX'
				return 2103001
            end
		
		end
		--pricaura fin Ref055 Pago automatico de LC diferencial
		 
COMMIT TRAN
end



return 0

go
if exists(select 1 from sysobjects where name='sp_nc_rec_automatica' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_nc_rec_automatica *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_nc_rec_automatica -- ERROR -- >>>'
go
