use cob_pagos
go

if not exists(select 1 from db_temporal..sysobjects where name='cc_tarchivos_pagos_terc' and type = 'U')
  create table db_temporal..cc_tarchivos_pagos_terc
  (
    cod_archivo      varchar(10),
    catalogo_trx1    varchar(30),
    catalogo_causa1  varchar(30),
    -->Ref02 campos nuevos
    id_archivo       varchar(10), 
    catalogo_concep  varchar(30),
    catalogo_comision varchar(30),
    cta_contable     varchar(30),
    concepto_reca    varchar(30)
    --<--fin ref02
  )

if not exists(select 1 from db_temporal..sysobjects where name='cc_trans_pagos_terc' and type = 'U')
  create table db_temporal..cc_trans_pagos_terc
  (
    tp_tipo_trx  int,
    tp_descripcion varchar(50),
    tp_cod_archivo varchar(50),
    tp_nom_cat varchar(50)
  )

if not exists(select 1 from db_temporal..sysobjects where name='cc_causas_pagos_terc' and type = 'U')
  create table db_temporal..cc_causas_pagos_terc
  (
    cp_causa varchar(50),
    cp_cod_archivo varchar(50),
    cp_nom_cat varchar(50)
  )
  
if not exists(select 1 from db_temporal..sysobjects where name='cc_tran_servicio_tmp' and type = 'U')
    create table db_temporal..cc_tran_servicio_tmp(
        ts_secuencial       int,
        ts_tipo_transaccion int,
        ts_tsfecha          smalldatetime,
        ts_usuario          varchar(64),
        ts_oficina          smallint,
        ts_tipo             char(1),
        ts_moneda           tinyint,
        ts_causa            varchar(6),
        ts_saldo            money,
        ts_fecha_uso        smalldatetime,
        ts_monto            money,
        ts_autoriz_aut      varchar(64),
        ts_contratado       money,
        ts_valor            money,
        ts_ocasional        money,
        ts_tipo_chequera    varchar(5),
        ts_aporte_iess      money,
        ts_descuento_iess   money,
        ts_fonres_iess      money )


-- Se llena la temporal db_temporal..ah_tran_monet_tmp con las transacciones de servicios que se van a procesar
if not exists(select 1 from db_temporal..sysobjects where name='ah_tran_monet_tmp' and type = 'U')
    create table db_temporal..ah_tran_monet_tmp(
        tm_secuencial       int,
        tm_tipo_transaccion int,
        tm_fecha            smalldatetime,
        tm_usuario          varchar(64),
        tm_oficina          smallint,
        tm_moneda           tinyint,
        tm_causa            varchar(6),
        tm_valor            money )
        

-- Se llena la temporal db_temporal..cc_tran_monet_tmp con las transacciones de servicios que se van a procesar
if not exists(select 1 from db_temporal..sysobjects where name='cc_tran_monet_tmp' and type = 'U')
    create table db_temporal..cc_tran_monet_tmp(
        tm_secuencial       int,
        tm_tipo_transaccion int,
        tm_fecha            smalldatetime,
        tm_usuario          varchar(64),
        tm_oficina          smallint,
        tm_moneda           tinyint,
        tm_causa            varchar(6),
        tm_valor            money )

-->Ref02 MLR 
--se crea tabla para conceptos por ID cliente
if not exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_concepto' and type = 'U')
    create table db_temporal..cc_pag_ter_concepto(
        pt_id         varchar(15),
        pt_concepto   varchar(50) )

--se crea tabla para las comisiones por Causa
if not exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_comision' and type = 'U')
    create table db_temporal..cc_pag_ter_comision(
        pt_causa      varchar(10),
        pt_valor      varchar(64) )
        

if exists (select 1 from dbo.sysobjects where name = 'sp_reporte_mensual_sbs')
	drop procedure dbo.sp_reporte_mensual_sbs
	if exists (select 1 from sysobjects where name = 'sp_reporte_mensual_sbs')
		PRINT '<<< DROP PROCEDURE sp_reporte_mensual_sbs -- ERROR -- >>>'
	else
		PRINT '== DROP PROCEDURE sp_reporte_mensual_sbs *OK* =='
go


/************************************************************************/
/*  Archivo:            pgrptsbs.sp                                     */
/*  Motor de Base: 		SYBASE                     					    */
/*  Servidor: 			HP-ACT                                       	*/
/*  Procesamiento: 		OLTP	                                       	*/
/*  Ult.ControlTarea:   J-RECESABREC-358                         		*/
/*  Ult.Referencia:     REF 2                          			    	*/
/*  Stored procedure:   sp_reporte_mensual_sbs                          */
/*  Aplicacion: 		Cyberbank	                                	*/
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Miriam Lindao                                   */
/*  Fecha de escritura: 12-Oct-2015                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa registra en la tabla cob_cuentas..cc_inf_super la     */
/*  información preliminar que se enviará a la sbs                      */
/*  Los datos de las transacciones y causas son cargados desde el proc. */
/*  sp_con_inf_pagter_sbs                                               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*    FECHA       AUTOR          RAZON                                  */
/*    12/Oct/2015 Miriam Lindao   CTE-AS-SGC00022677 Emisión inicial    */
/*02  22/Ene/2016 Miriam Lindao   Tarea: RECA-CC-SGC00023966            */
/*03  13/May/2016 Miriam Lindao   RECA-CC-SGC00025176 Cambio %IVA       */
/*04  01/Ago/2016 Miriam Lindao   RECA-CE-SGC00026062 Comision Nuevos Servicios CNB */
/*05  02/Ago/2016 Jorge Pazminno  RECA-CC-SGC00025765 Recaud. IWS-TRB   */
/*06  23/Ene/2017 María Jo. Silva RECA-CC-SGC00027525 Cobro comision Claro*/
/*07  27/03/2017 Danny Olaya S.   RECA-CC-SGC00027972 Modificacion Reporte DBA */
/*08  23/Mar/2017 Pablo Ricaurte A.RECA-CC-SGC00027803 Debitos automaticos primax*/
/*09  01/Mar/2017 María Jo. Silva RECA-CC-SGC00027715 Cobro comision Ventanilla*/
/*10  23/Mar/2017  María José Silva    Cobro de Comisión al cliente RECA-CC-SGC00028400 */
/*11  05/May/2017  Martha Giler R. SAT-CC-28001 Comision IMPADUAN SAT   */
/*12  18/May/2017  María José Silva    Cobro de Comisión TVCABLE RECA-CC-SGC00027895  */
/*13  22/May/2017  María José Silva    Cobro de Comisión CTE RECA-CC-SGC00028146  */
/*14  18/Ago/2017  Danny Olaya S. RECA-CC-SGC00029665 Cobro de Comisión */
/*15  22/Sep/2017  María José Silva    Cobro de Comisión CNT RECA-CE-SGC00029803 */
/*16  17/Abr/2018  María José Silva    Municipios Pago con Tarjeta RECA-CE-SGC00031682 */
/*17  26/Feb/2018  María José Silva    Facturación OffLine  SGC00030409 */
/*18  31/Ago/2021  María José Silva	   Modificar extracción pago Terceros RECMPS-1143*/
/*19  24/Nov/2021  María José Silva	   Trx de diferido 3202 - RECM-444				*/
/*20  21/Nov/2022  Kevin Bastidas	ESTRUCTURA PAGO A TERCEROS PAGO CON TC RECESABREC-358*/
/************************************************************************************/


create proc dbo.sp_reporte_mensual_sbs (
@i_fecha  datetime
)
as
declare --@w_fecha        datetime,
        @w_error        int,
        @w_archivo_proc varchar(30),
        @w_sri_nombre   varchar(30),
        @w_sri_ruc      varchar(15),
        @w_sri_codigo   char(4),
        @w_sri_tipemp   char(3),
        @w_bco_nombre   varchar(30),
        @w_fecha_corte  varchar(10),
        @w_cat_trx1     varchar(50),
        @w_cat_cau1     varchar(50),
        @w_cta_contable varchar(30),
        -->Ref02 variables nuevas
        @w_id_archivo    varchar(10),
        @w_cat_comision  varchar(64),
        @w_cat_concepto  varchar(64),
        @w_concepto_reca varchar(64),
        @w_texto         varchar(64), 
        @w_texto_aux     varchar(64),
        @w_contador      int,
        --<--fin Ref02
        @v_porcIva       float, --<Ref03
        @v_concepto 	 varchar(30),  --Ref018:msilvag 
        @v_tarifa_mun	 varchar(8) ,  --Ref018:msilvag 
        @v_tarifa_sri	 varchar(8)    --Ref018:msilvag


set --@w_sri_codigo  = '1007', Ref02 MLR se obtiene desde catalogo
    @w_fecha_corte = convert(varchar(10),dateadd(day,-1,dateadd( month,1,convert(datetime,'01/' + convert(varchar,month(@i_fecha))  + '/' + convert(varchar,year(@i_fecha)),103))),103),
    @w_error = 0

--Ref018:msilvag Inicio
select @v_concepto = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'COEPT'

select @v_tarifa_mun = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'TMUPT'

select @v_tarifa_sri = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'TMAPT'
--Ref018:msilvag Fin


  --select @w_bco_nombre = substring(p_p_apellido,1,30) Ref02 MLR Se obtiene desde catálogo
  --from cobis..cl_ente where en_ced_ruc = '0990379017001'--Información del Bco.Bolivariano
-->Ref02 MLR 
--Obtener los datos generales del catalogo
select @w_sri_codigo = substring(c.valor, 1, charindex('|',c.valor)-1),
       @w_bco_nombre = substring(c.valor,  charindex('|',c.valor)+1, len(c.valor))
  from cobis..cl_tabla t, cobis..cl_catalogo c
 where t.codigo = c.tabla
   and t.tabla = 'SBS_PTERC_DGENERAL'
   and c.codigo = 'ID0'
if @@rowcount = 0
  begin
    select @w_bco_nombre = substring(p_p_apellido,1,30) ,
           @w_sri_codigo  = '1007'
      from cobis..cl_ente 
     where en_ced_ruc = '0990379017001'--Información del Bco.Bolivariano
  end
--<Ref03 Recuperar el Porcentaje IVA
select @v_porcIva = isnull(pa_float,0) + 1
  from cobis..cl_parametro 
 where pa_nemonico = 'IVA'
   and pa_producto  = 'CTE'
--Fin Ref03>
--se crea cursor con los tipos de archivos


declare cur_tipos_archivos cursor
    for
 select id_archivo,         cod_archivo,         catalogo_trx1,
        catalogo_causa1,    catalogo_concep,     catalogo_comision,
        cta_contable,       concepto_reca 
 from db_temporal..cc_tarchivos_pagos_terc
 
 open cur_tipos_archivos
 fetch cur_tipos_archivos into
      @w_id_archivo,      @w_archivo_proc,       @w_cat_trx1,
      @w_cat_cau1,        @w_cat_concepto,       @w_cat_comision,
      @w_cta_contable,    @w_concepto_reca 
 
while @@sqlstatus <> 2
  begin
     if @@sqlstatus = 1
          begin    
             close cur_tipos_archivos
             deallocate cursor cur_tipos_archivos
          end
          
--<--Fin Ref02
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   AJUSTESRI  *-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--Se comenta, este dato viene del cursor
--set @w_archivo_proc = 'AJUSTESRI',
--    @w_cta_contable = '54901019'
  -->Ref02 MLR 
  -- validar datos generales por Archivo
  
    set @w_sri_nombre = null, @w_sri_ruc = null, @w_sri_tipemp = null, @w_contador = 0
    select @w_texto = rtrim(ltrim(c.valor))
      from cobis..cl_tabla t, cobis..cl_catalogo c
     where t.codigo = c.tabla
       and t.tabla = 'SBS_PTERC_DGENERAL'
       and c.codigo = @w_id_archivo
    
    if @@rowcount != 0
     begin
        while  rtrim(ltrim(@w_texto)) is not null and @w_contador < 10
          begin
            set @w_texto_aux = substring(@w_texto, 1, charindex('|',@w_texto))
            set @w_texto = str_replace (@w_texto ,@w_texto_aux,null)
            set @w_contador = @w_contador + 1
            if @w_texto_aux is not null
              if @w_contador = 1 
                set @w_sri_ruc = str_replace (@w_texto_aux,'|',null)
              else if @w_contador = 2 
                set @w_sri_nombre = str_replace (@w_texto_aux,'|',null)
              else 
                set @w_sri_tipemp = str_replace (@w_texto_aux,'|',null) 
          end
     end
     --print '@w_sri_ruc %1! @w_sri_tipemp %2! @w_sri_nombre %3! @w_id_archivo %4! @w_texto %5!',@w_sri_ruc,@w_sri_tipemp,@w_sri_nombre,@w_id_archivo,@w_texto
    -- Llenar catalogo de conceptos por ID
    if @w_concepto_reca = 'CATALOGO'
       insert into db_temporal..cc_pag_ter_concepto (pt_id, pt_concepto)
       select substring(c.valor, 1, charindex('|',c.valor)-1),substring(c.valor,  charindex('|',c.valor)+1, len(c.valor))
            from cobis..cl_tabla t, cobis..cl_catalogo c
           where t.codigo = c.tabla
             and t.tabla = @w_cat_concepto
    else
       delete db_temporal..cc_pag_ter_concepto
    -- Comisiones 
    delete db_temporal..cc_pag_ter_comision
    insert into db_temporal..cc_pag_ter_comision (pt_causa, pt_valor)
      select c.codigo, c.valor
        from cobis..cl_tabla t, cobis..cl_catalogo c
       where t.codigo = c.tabla
         and t.tabla = @w_cat_comision
--<--Ref02

if @w_id_archivo = 'ID1' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--Ref02 MLR la información viene en el cursor
--set @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS',
--    @w_sri_ruc     = '1760013210001',
--    @w_sri_tipemp  = 'PUB'

--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
--begin
insert into cob_cuentas..cc_inf_super
          (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,is_empresa,is_ruc_empresa,
           is_tipo_empresa,is_numero_trans,is_FechTransaccion,
           is_Tunitaria_clte_cajeros,
           is_Tunitaria_emp_cajeros,
           is_Tunitaria_clte_internet,
           is_Tunitaria_emp_internet,
           is_Tunitaria_clte_oficina,
           is_Tunitaria_emp_oficina,
           is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
           is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
           is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
           is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
           is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
           is_Valor_pagado,
           is_Provincia,
           is_Canton,
           is_cuenta_contable,is_ConceptoRec,is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
    select @w_fecha_corte ,'CTA',@w_sri_codigo,@w_bco_nombre,@w_sri_nombre, @w_sri_ruc, 
           @w_sri_tipemp, ts_secuencial, convert(varchar(10),ts_tsfecha,103),
            case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, '0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end, '0,00',
            '0,00','0,00','0,00','0,00',
            --'0,00' --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
            case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
            '0,00','0,00',
            --Ref018:msilvag Inicio
            case when ts_saldo > 0 then 1 else 0 end, --is_ModPago_efec_ventanilla
            case when ts_valor > 0 then 1 else 0 end, --is_ModPago_cheque_ventanilla
            case when ts_monto > 0 then 1 else 0 end, --is_ModPago_tarjcredito_cte
            --Ref018:msilvag Fin
            0,0,0,
            --Ref018:msilvag Inicio is_ModPago_debito_pago_clte
            case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 
				when ts_usuario like '0000%' then 1
				when ts_usuario like '%CAJ00%' then 1
				when ts_ocasional > 0 then 1 
				--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
				else 0 end,
			--Ref018:msilvag Fin
			0,'0,00',
            str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_ocasional,0)),'.',','),
            (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
            (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
            @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,tp_cod_archivo,cp_causa,ts_usuario --Ref02 se agrega variable @w_concepto_reca antes valor quemado'110327'
             from db_temporal..cc_tran_servicio_tmp p, 
                  cob_remesas..re_tran_contable,
                  db_temporal..cc_trans_pagos_terc t,
                  db_temporal..cc_causas_pagos_terc c
            where ts_tipo_transaccion = t.tp_tipo_trx
              and t.tp_cod_archivo = @w_archivo_proc
              and t.tp_nom_cat = @w_cat_trx1
              and tc_causa_org = c.cp_causa
              and c.cp_cod_archivo = @w_archivo_proc
              and c.cp_nom_cat = @w_cat_cau1
              and ts_tipo_transaccion = tc_tipo_tran
              and tc_causa_org     = isnull(ts_causa,'0')
              and tc_estado       = 'V'
              and tc_contabiliza = 'ADU'
          
     if @@error <> 0
        begin
          print '********** Error en la informacion de %1! **********',@w_archivo_proc
          set @w_error = 1
          Return @w_error
        end
  end

else if @w_id_archivo in ('ID2', 'ID14') --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query ; Ref.5: Incluir ID14
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00211007 *-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00211007',  --Ref02 MLR viene desde el cursor
--    @w_cta_contable = '54901045'

--set @w_sri_ruc     = '1768152560001',
--    @w_sri_tipemp  = 'PUB'
 
--select @w_vcanal = 
	

select @w_sri_nombre = substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) 
  from cobis..cl_ente where en_ced_ruc = @w_sri_ruc

--Ref02 MLR esta info viene desde el cursor
--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
  
      insert into cob_cuentas..cc_inf_super
          (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
           is_empresa,is_ruc_empresa,
           is_tipo_empresa,is_numero_trans,is_FechTransaccion,
           is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
           is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
           is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
           is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
           is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
           is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
           is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
           is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
           is_Valor_pagado,
           is_Provincia,
           is_Canton,
           is_cuenta_contable,is_ConceptoRec,
           is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
    select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
          (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc),  pe_ruc,
          case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
          where a.tabla = 'cl_tipo_sector_cia'
          and b.tabla = a.codigo
          and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,ts_secuencial,convert(varchar(10),ts_tsfecha,103),
          case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') 
											   when 'DBA' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') --<Ref07 Se considera el canal DBA y DIR para el campo is_Tunitaria_clte_oficina para guardar la comision sin iva
											   when 'DIR' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',')  
											   else '0,00'
		  end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
          str_replace(convert(varchar,convert(money, isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0) / @v_porcIva)),'.',','),--<Ref03 str_replace(convert(varchar(4),(round((isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / (1 + 0.12)),2))),'.',','),--<Ref03 
          case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          '0,00','0,00','0,00','0,00',
          case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
          '0,00','0,00',
          --Ref017:msilvag Inicio 
          --is_ModPago_efec_ventanilla
          case when ts_valor > 0 then 1  --Ref018:msilvag 
                else 0 end ,
          --is_ModPago_cheque_ventanilla
          case when ts_saldo > 0 then 1  --Ref018:msilvag 
                else 0 end,
          --Ref017:msilvag Fin
          0,0,0,case substring(ts_tipo_chequera,1,3) when 'DBA' then 1 when 'DIR' then 1 else 0 end,--<Ref07 Si es canal DBA o DIR, se imprime 1 en campo -> is_ModPago_debito_automatico
          --Ref017:msilvag Inicio  is_ModPago_debito_pago_clte
          case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
          		when ts_usuario like '0000%' then 1
          		when ts_usuario like '%CAJ00%' then 1
          		when ts_monto > 0 then 1 
                --when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                --Ref018:msilvag Fin
               else 0 end ,
          --Ref017:msilvag Fin		  
		   0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
          (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
          (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
          @w_cta_contable,(case @w_concepto_reca when 'CATALOGO' then isnull((select @v_concepto +' ' + pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = x.pe_ruc),'RECAUDACION POR CONCEPTO DE SERVICIOS DE INSTITUCIONES PUBLICAS O PRIVADAS') else @v_concepto + ' ' + @w_concepto_reca end), --Ref02 (case x.pe_ruc when '1790053881001' then '130205' when '1768154260001' then '140301' when '0968591550001' then '190499' when '1768152560001' then '190499' when '2460002550001' then  '190499' when '0968599020001' then '190499' else 'RECAUDACION POR CONCEPTO DE SERVICIOS DE INSTITUCIONES PUBLICAS O PRIVADAS' end ),
          tp_cod_archivo ,cp_causa,ts_usuario--Ref02 se agrega causa y usuario
     from db_temporal..cc_tran_servicio_tmp p,
          --cob_remesas..re_tran_contable,  Ref019:msilvag 
          cob_pagos..pg_person_empresa x,
          db_temporal..cc_trans_pagos_terc t,
          db_temporal..cc_causas_pagos_terc c
    where ts_tipo_transaccion = t.tp_tipo_trx
      and ts_causa = c.cp_causa 				--Ref019:msilvag
      and x.pe_empresa  = convert(int,ts_causa) --Ref019:msilvag
      and t.tp_cod_archivo = @w_archivo_proc
      and t.tp_nom_cat = @w_cat_trx1
      --and tc_causa_org = c.cp_causa Ref019:msilvag 
      and c.cp_cod_archivo = @w_archivo_proc
      and c.cp_nom_cat = @w_cat_cau1
  union all
   select @w_fecha_corte ,'CTA',@w_sri_codigo,@w_bco_nombre,                                                  
          @w_sri_nombre,
          @w_sri_ruc, @w_sri_tipemp ,tm_secuencial,convert(varchar(10),tm_fecha,103),
          '0,00','0,00','0,00','0,00','0,00'
		  ,'0,00','0,00','0,00','0,00','0,00',
          '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
          1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
          (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
          (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),@w_cta_contable,(case @w_concepto_reca when 'CATALOGO' then isnull((select pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = '0000000000000'),'RECAUDACION POR CONCEPTO DE SERVICIOS DE INSTITUCIONES PUBLICAS O PRIVADAS') else @v_concepto + ' ' + @w_concepto_reca end),-- Ref02 '190499',
          tp_cod_archivo,cp_causa,tm_usuario--Ref02 se agrega causa y usuario
     from db_temporal..ah_tran_monet_tmp p,
          db_temporal..cc_trans_pagos_terc t,
          db_temporal..cc_causas_pagos_terc c
     where tm_tipo_transaccion = t.tp_tipo_trx
       and t.tp_cod_archivo = @w_archivo_proc
       and t.tp_nom_cat = (@w_cat_trx1 + '_2')
       and tm_causa = c.cp_causa
       and c.cp_cod_archivo = @w_archivo_proc
       and c.cp_nom_cat = (@w_cat_cau1+ '_2')
     union all
    select @w_fecha_corte ,'CTA',@w_sri_codigo,@w_bco_nombre,
           @w_sri_nombre,
           @w_sri_ruc, @w_sri_tipemp ,tm_secuencial,convert(varchar(10),tm_fecha,103),
           '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
           '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
           1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
           (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
           (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),@w_cta_contable,(case @w_concepto_reca when 'CATALOGO' then isnull((select pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = '0000000000000'),'RECAUDACION POR CONCEPTO DE SERVICIOS DE INSTITUCIONES PUBLICAS O PRIVADAS') else @v_concepto + ' ' + @w_concepto_reca end),-- Ref02 '190499',
           tp_cod_archivo,cp_causa,tm_usuario --Ref02 se agrega causa y usuario
      from db_temporal..cc_tran_monet_tmp p,
           db_temporal..cc_trans_pagos_terc t,
           db_temporal..cc_causas_pagos_terc c
     where tm_tipo_transaccion = t.tp_tipo_trx
       and t.tp_cod_archivo = @w_archivo_proc
       and t.tp_nom_cat = (@w_cat_trx1 + '_3')
       and tm_causa = c.cp_causa
       and c.cp_cod_archivo = @w_archivo_proc
       and c.cp_nom_cat = (@w_cat_cau1+ '_3')  
	--Ref010:msilvag Inicio comento bloque
    --union all
    --select @w_fecha_corte ,'CTA',@w_sri_codigo,@w_bco_nombre,
    --        @w_sri_nombre,
    --        @w_sri_ruc, @w_sri_tipemp ,cc_id ,convert(varchar(10),cc_fecha_debito,103),
    --        '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
    --        '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
    --        1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull((convert(money,substring(cc_total,1,10) + '.' + substring(cc_total,11,2))),0)),'.',','),
    --        (select of_provincia  from cobis..cl_oficina where of_oficina = 0),
    --        (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = 0),@w_cta_contable,(case @w_concepto_reca when 'CATALOGO' then isnull((select pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = '0000000000000'),'190499') else @w_concepto_reca end),--Ref02 se agrega variable @w_concepto_reca antes valor quemado '190499'
    --        @w_archivo_proc, 'cnt','cnt'--REf02 se agrega valores nuevos
    -- from cob_cuentas..cc_debito_cnt
    --where cc_fecha_debito = @i_fecha 
    --  and cc_estado = 'P'
	--Ref010:msilvag Fin comento bloque

     if @@error <> 0
        begin
          print '********** Error en la informacion de %1! **********',@w_archivo_proc
          set @w_error = 1
          Return @w_error
        end
  end
else if @w_id_archivo = 'ID3' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00371007 *-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00371007',   Ref02 MLR viene desde el cursor
  --  @w_cta_contable = '54901056'

--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
    insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,is_numero_trans,is_FechTransaccion,
               is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                '0,00','0,00',
                str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',','),--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',','),
                '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
                --Ref018:msilvag Inicio (is_ModPago_efec_ventanilla)
                case when ts_valor > 0 then 1  
                    else 0 end,
                --is_ModPago_cheque_ventanilla
                case when ts_saldo > 0 then 1 
                      else 0 end,
                --Ref018:msilvag Fin
                0,0,0,0,
                --Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
                case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1
					when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_monto > 0 then 1 
					--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
               		else 0 end ,
                --Ref018:msilvag Fin
                0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '50100'
                 tp_cod_archivo,cp_causa,ts_usuario --Ref02 se agrega valores de campos nuevos
            from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
                 db_temporal..cc_trans_pagos_terc t,
                 db_temporal..cc_causas_pagos_terc c
           where ts_tipo_transaccion = t.tp_tipo_trx
             and t.tp_cod_archivo = @w_archivo_proc
             and t.tp_nom_cat = @w_cat_trx1
             and tc_causa_org = c.cp_causa
             and c.cp_cod_archivo = @w_archivo_proc
             and c.cp_nom_cat = @w_cat_cau1
             and ts_tipo_transaccion = tc_tipo_tran
             and tc_causa_org      = ts_causa
           --and tc_tipo_tran in (3925,3926,3928)
           --and tc_causa_org in ('2494')
             and tc_estado       = 'V'
             and x.pe_empresa  = convert(int,ts_causa)
             and ts_usuario in ('ope998','srolese')
          union all
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                '0,00','0,00',
                '0,00',
                '0,00',str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',','),--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',','),
                '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
				case when ts_valor > 0 then 1 else 0 end,  --Ref018:msilvag (is_ModPago_efec_ventanilla)
                case when ts_saldo > 0 then 1 else 0 end,  --Ref018:msilvag is_ModPago_cheque_ventanilla
				0,0,0,0,
				--Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
                case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1
					when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_monto > 0 then 1 
					--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
               		else 0 end ,
                --Ref018:msilvag Fin
                0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '50100'
                 tp_cod_archivo,cp_causa,ts_usuario --Ref02 se agrega valores de campos nuevos
            from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
                 db_temporal..cc_trans_pagos_terc t,
                 db_temporal..cc_causas_pagos_terc c
           where ts_tipo_transaccion = t.tp_tipo_trx
             and t.tp_cod_archivo = @w_archivo_proc
             and t.tp_nom_cat = @w_cat_trx1
             and tc_causa_org = c.cp_causa
             and c.cp_cod_archivo = @w_archivo_proc
             and c.cp_nom_cat = @w_cat_cau1
             and ts_tipo_transaccion = tc_tipo_tran
             and tc_causa_org      = ts_causa
           --and tc_tipo_tran in (3925,3926,3928)
           --and tc_causa_org in ('2494')
             and tc_estado       = 'V'
             and x.pe_empresa  = convert(int,ts_causa)
             and ts_usuario not in ('ope998','srolese')
             
         if @@error <> 0
            begin
              print '********** Error en la informacion de %1! **********',@w_archivo_proc
              set @w_error = 1
              Return @w_error
            end
  end

else if @w_id_archivo = 'ID4' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00371007_SERVAR *-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00371007_SERVAR',  --Ref02 viene desde el cursor
--    @w_cta_contable = '54901058'

-- Se obtiene el nombre de los catalogos
--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
--  from db_temporal..cc_tarchivos_pagos_terc
-- where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
    insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,
               is_numero_trans,
               is_FechTransaccion,
               is_Tunitaria_clte_cajeros,
               is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,
               is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
               case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b where a.tabla = 'cl_tipo_sector_cia' and b.tabla = a.codigo and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
               ts_secuencial,
               convert(varchar(10),ts_tsfecha,103),
               case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
               '0,00',
               case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
               '0,00',
               isnull((select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa),case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0'))/ @v_porcIva)),'.',',')else '0,00' end), --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end), --Ref02 se aumenta conf. catálogo
               str_replace(convert(varchar,convert(money, isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0) / @v_porcIva)),'.',','), --<Ref03 str_replace(convert(varchar(4),(round((isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / (1 + 0.12)),2))),'.',','),
               case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
               case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
               case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
               '0,00','0,00','0,00','0,00',
               --'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
               case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
               '0,00' ,'0,00',
               --Ref017:msilvag Inicio  (is_ModPago_efec_ventanilla)
               case when ts_valor > 0 then 1 
                    else 0 end,
               --Ref017:msilvag Fin
               -- REF 14 INI (is_ModPago_cheque_ventanilla )
			   case when ts_saldo > 0 then 1 
                       else 0 end,
				-- REF 14 FIN		
			   0,0,0,0,
               --Ref017:msilvag Inicio (is_ModPago_debito_pago_clte)
               case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
					when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_monto > 0 then 1 
					--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                --Ref018:msilvag Fin
                      else 0 end ,
               --Ref017:msilvag Fin
               0,'0,00', str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca, --Ref02 se agrega variable @w_concepto_reca antes valor quemado 'RECAUDACION POR CONCEPTO DE VARIAS EMPRESARIALES'
               tp_cod_archivo,cp_causa,ts_usuario --Ref02 se agrega valores de campos nuevos
          from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
               db_temporal..cc_trans_pagos_terc t,
               db_temporal..cc_causas_pagos_terc c
         where ts_tipo_transaccion = t.tp_tipo_trx
           and t.tp_cod_archivo = @w_archivo_proc
           and t.tp_nom_cat = @w_cat_trx1
           and tc_causa_org = c.cp_causa
           and c.cp_cod_archivo = @w_archivo_proc
           and c.cp_nom_cat = @w_cat_cau1
           and ts_tipo_transaccion = tc_tipo_tran
           and tc_causa_org      = ts_causa
          -- and tc_tipo_tran in (3218,3220,3925,3926,3928)
          -- and tc_causa_org in ('337','338','81','1372','1373','335','336','333','320','664','1299','1538','2443','2445','2452','334','843','2443','2445','2452','6067','1541','1545','115','334','5994','1540','1546','1539','1543','2451','2444','118','120','156','451','13','14')
           and tc_estado       = 'V'
           and x.pe_empresa  = convert(int,ts_causa)
        union all
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,
                convert(varchar(10),ts_tsfecha,103),
                case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',')  when 'DBA' then (case (select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa) when null then '0,00' else (str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',')) end)  else '0,00' end,  --Ref8 pricaura --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
				 --Ref8 pricaura Inicio    --  dpereirv --> sum(pn_costo_recauda)/sum(pn_cont_trn)
				case (select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa) when null then (
						isnull((select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa),
						str_replace(convert(varchar,convert(money,isnull((select sum(pn_costo_recauda)/sum(pn_cont_trn) from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / @v_porcIva)),'.',',')) )  --<Ref03 str_replace(convert(varchar(4), (round((isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / (1 + 0.12)),2))),'.',',')), --Ref02 se aumenta valor conf. comisión
					else '0,00' end,
				 --Ref8 pricaura Fin
                case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                '0,00','0,00','0,00','0,00',
                --'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                '0,00' ,'0,00',
				case when ts_valor > 0 then 1 else 0 end , --case (select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa) when null then (case substring(ts_tipo_chequera,1,3) when 'DBA' then 1 else 0 end)  else 0 end,		--Ref8 pricaura
				case when ts_saldo > 0 then 1 else 0 end ,0,0,0,
				0 , --case (select pt_valor from db_temporal..cc_pag_ter_comision where pt_causa = p.ts_causa) when null then 0 else (case substring(ts_tipo_chequera,1,3) when 'DBA' then 1 else 0 end) end,		--Ref8 pricaura
				case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
									when ts_usuario like '0000%' then 1
									when ts_usuario like '%CAJ00%' then 1
									when ts_monto > 0 then 1 
									--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
				                --Ref018:msilvag Fin
                      else 0 end 
				
				,0,'0,00', str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca, --Ref02 se agrega variable @w_concepto_reca antes valor quemado 'RECAUDACION POR CONCEPTO DE VARIAS EMPRESARIALES'
                tp_cod_archivo,cp_causa,ts_usuario --Ref02 se agrega valores de campos nuevos
         from db_temporal..cc_tran_servicio_tmp p, cob_pagos..pg_person_empresa x,
              db_temporal..cc_trans_pagos_terc t,
              db_temporal..cc_causas_pagos_terc c
        where ts_tipo_transaccion = t.tp_tipo_trx
          and t.tp_cod_archivo = @w_archivo_proc
          and t.tp_nom_cat = (@w_cat_trx1 + '_2')
          and ts_causa = c.cp_causa
          and c.cp_cod_archivo = @w_archivo_proc
          and c.cp_nom_cat = (@w_cat_cau1+ '_2')
          --ts_tipo_transaccion = 3427
          --and ts_causa      in ('38','42')
          and x.pe_empresa  = convert(int,ts_causa)

        if @@error <> 0
            begin
              print '********** Error en la informacion de %1! **********',@w_archivo_proc
              set @w_error = 1
              Return @w_error
            end
  end

else if @w_id_archivo = 'ID5' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00401007_CD *-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00401007_CD',  --Ref02 MLR viene desde el cursor
--    @w_cta_contable = '549010'
                      
--set @w_sri_ruc     = '1760013210001',
--    @w_sri_tipemp  = 'PUB',
--    @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
-- Se obtiene el nombre de los catalogos --Ref02 viene desde el cursor
--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
    insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,is_numero_trans,is_FechTransaccion,
               is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
               @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
               ts_secuencial,convert(varchar(10),ts_tsfecha,103),
               '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00',
               1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
               tp_cod_archivo,cp_causa,ts_usuario
          from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,
               db_temporal..cc_trans_pagos_terc t,
               db_temporal..cc_causas_pagos_terc c
         where ts_tipo_transaccion = t.tp_tipo_trx
           and t.tp_cod_archivo = @w_archivo_proc
           and t.tp_nom_cat = @w_cat_trx1
           and tc_causa_org = c.cp_causa
           and c.cp_cod_archivo = @w_archivo_proc
           and c.cp_nom_cat = @w_cat_cau1
           and ts_tipo_transaccion = tc_tipo_tran
           and tc_causa_org       = isnull(ts_causa,'0')
           --and tc_tipo_tran = tc_tipo_tran
           --and tc_tipo_tran in (3445)
           --and tc_causa_org = '0'
           and tc_contabiliza = 'VTR'
           and tc_estado       = 'V'
       union all
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
               @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
               convert(int,da_num_for),convert(varchar(10),da_fecha_proceso,103),
               '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00',
               1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(da_valor_debito,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = 0),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = 0),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
               @w_archivo_proc,'SRI','SRI'
          from cob_servicios..sv_debitos_automaticos_sri
         where da_fecha_proceso  = @i_fecha
           and da_ced_ruc = '0990379017001'
        union all
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
               @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
               tm_secuencial,convert(varchar(10),tm_fecha,103),
               '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00',
               1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
                tp_cod_archivo,cp_causa,tm_usuario
          from db_temporal..ah_tran_monet_tmp p,
               db_temporal..cc_trans_pagos_terc t,
               db_temporal..cc_causas_pagos_terc c
         where tm_tipo_transaccion = t.tp_tipo_trx
           and t.tp_cod_archivo = @w_archivo_proc
           and t.tp_nom_cat = (@w_cat_trx1 + '_2')
           and tm_causa = c.cp_causa
           and c.cp_cod_archivo = @w_archivo_proc
           and c.cp_nom_cat = (@w_cat_cau1+ '_2')
           --tm_tipo_tran in (4264,4272)
           --and tm_causa = '226'
         union all
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
               @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
               tm_secuencial,convert(varchar(10),tm_fecha,103),
               '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
               '0,00','0,00','0,00','0,00',
               1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
               tp_cod_archivo,cp_causa,tm_usuario
          from db_temporal..cc_tran_monet_tmp p,
               db_temporal..cc_trans_pagos_terc t,
               db_temporal..cc_causas_pagos_terc c
         where tm_tipo_transaccion = t.tp_tipo_trx
           and t.tp_cod_archivo = @w_archivo_proc
           and t.tp_nom_cat = (@w_cat_trx1 + '_3')
           and tm_causa = c.cp_causa
           and c.cp_cod_archivo = @w_archivo_proc
           and c.cp_nom_cat = (@w_cat_cau1+ '_3')
           --tm_tipo_tran = 3050
           --and tm_causa in ('126','259')  
         if @@error <> 0
            begin
              print '********** Error en la informacion de %1! **********',@w_archivo_proc
              set @w_error = 1
              Return @w_error
            end
  end
else if @w_id_archivo = 'ID6' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00401007_OFP *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00401007_OFP',  --Ref02 MLR viene desde el cursor
--    @w_cta_contable = '549010'
                      
--set @w_sri_ruc     = '1760013210001',
--    @w_sri_tipemp  = 'PUB',
--    @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
-- Se obtiene el nombre de los catalogos --Ref02 MLR viene desde el cursor
--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
    insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,is_numero_trans,is_FechTransaccion,
               is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

       select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
              @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
              ts_secuencial,convert(varchar(10),ts_tsfecha,103),
              case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
              '0,00','0,00','0,00','0,00',
              --'0,00',--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
              case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
              '0,00','0,00',
              --Ref018:msilvag inicio (is_ModPago_efec_ventanilla)
              case when ts_valor > 0 then 1 
              	   when ts_contratado > 0 then 1 
              	   else 0 end , 
              --(is_ModPago_cheque_ventanilla )
			  case when ts_saldo > 0 then 1 
                       else 0 end,
			  --Ref018:msilvag Fin
				0,0,0,0,
				--Ref018:msilvag Inicio (is_ModPago_debito_pago_clte)
               case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1
					when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_aporte_iess > 0 then 1 
					else 0 end ,
               --Ref018:msilvag Fin
               0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_aporte_iess,0)+isnull(ts_contratado,0)+isnull(ts_ocasional,0)),'.',','),
              (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
              (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
                tp_cod_archivo,cp_causa,ts_usuario
         from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,
              db_temporal..cc_trans_pagos_terc t,
              db_temporal..cc_causas_pagos_terc c
        where ts_tipo_transaccion = t.tp_tipo_trx
          and t.tp_cod_archivo = @w_archivo_proc
          and t.tp_nom_cat = @w_cat_trx1
          and tc_causa_org = c.cp_causa
          and c.cp_cod_archivo = @w_archivo_proc
          and c.cp_nom_cat = @w_cat_cau1
          and ts_tipo_transaccion = tc_tipo_tran
          and tc_causa_org      = isnull(ts_causa,'0')
          --and tc_tipo_tran in (3611,3612)
          --and tc_causa_org = '0'
          and tc_contabiliza = 'VTR'
          and tc_estado       = 'V'
          --and ts_correccion = 'N'
          -- and not exists (select 1 from db_temporal..s_datos where ts_ssn_corr = p.ts_secuencial)

         if @@error <> 0
            begin
              print '********** Error en la informacion de %1! **********',@w_archivo_proc
              set @w_error = 1
              Return @w_error
            end
  end
  
else if @w_id_archivo = 'ID7' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00401007_RISE *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
--set @w_archivo_proc = 'TD00401007_RISE',  ----Ref02 MLR viene desde el cursor
--    @w_cta_contable = '549010'
                      
--set @w_sri_ruc     = '1760013210001',
--    @w_sri_tipemp  = 'PUB',
--    @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
-- Se obtiene el nombre de los catalogos --Ref02 MLR viene desde el cursor
--select @w_cat_trx1 = catalogo_trx1,
--       @w_cat_cau1 = catalogo_causa1
-- from db_temporal..cc_tarchivos_pagos_terc
--where cod_archivo = @w_archivo_proc

--if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
  --begin
    insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,is_numero_trans,is_FechTransaccion,
               is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

         select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
                ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00', --<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_fonres_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                '0,00','0,00','0,00','0,00',
                --'0,00'--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, ts_fonres_iess / @v_porcIva)),'.',',') else '0,00' end,--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                '0,00','0,00','0,00',
                --Ref017:msilvag Inicio (is_ModPago_efec_ventanilla)
                case when ts_valor > 0 then 1 
                    else 0 end,
                --is_ModPago_cheque_ventanilla
                case when ts_saldo > 0 then 1 
                      else 0 end,
                --Ref017:msilvag Fin
                0,0,0,0,
                --Ref017:msilvag Inicio (is_ModPago_debito_pago_clte)
              	case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
			  		when ts_usuario like '0000%' then 1
			  		when ts_usuario like '%CAJ00%' then 1
			  		when ts_monto > 0 then 1 
			  		--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
			        --Ref018:msilvag Fin
                    else 0 end ,
               --Ref017:msilvag Fin
                0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_aporte_iess,0)+isnull(ts_contratado,0)+isnull(ts_ocasional,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110715'
                tp_cod_archivo,cp_causa,ts_usuario
           from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,
                db_temporal..cc_trans_pagos_terc t,
                db_temporal..cc_causas_pagos_terc c
          where ts_tipo_transaccion = t.tp_tipo_trx
            and t.tp_cod_archivo = @w_archivo_proc
            and t.tp_nom_cat = @w_cat_trx1
            and tc_causa_org = c.cp_causa
            and c.cp_cod_archivo = @w_archivo_proc
            and c.cp_nom_cat = @w_cat_cau1
            and ts_tipo_transaccion = tc_tipo_tran
            and tc_causa_org       = isnull(ts_causa,'0')
            --and tc_tipo_tran in (3934,3935)
            --and tc_causa_org = '0'
            and tc_contabiliza = 'SER'
            and tc_estado       = 'V'
            --and ts_correccion = 'N'
            --and not exists (select 1 from db_temporal..s_datos where ts_ssn_corr = p.ts_secuencial)

         if @@error <> 0
            begin
              print '********** Error en la informacion de %1! **********',@w_archivo_proc
              set @w_error = 1
              Return @w_error
            end
  end
  
else if @w_id_archivo = 'ID8' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00401007_RISE_CD *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00401007_RISE_CD',  --Ref02 MLR viene desde el cursor
    --  @w_cta_contable = '54901018'
                        
  --set @w_sri_ruc     = '1760013210001',
  --    @w_sri_tipemp  = 'PUB',
  --    @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
-- Se obtiene el nombre de los catalogos --Ref02 MLR viene desde el cursor
  --select @w_cat_trx1 = catalogo_trx1,
  --       @w_cat_cau1 = catalogo_causa1
  -- from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

           select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                  @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
                  tm_secuencial,convert(varchar(10),tm_fecha,103),
                  '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
                  '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
                  '0,00','0,00','0,00','0,00',
                  1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
                  (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
                  (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),
                  @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110715'
                  tp_cod_archivo,cp_causa,tm_usuario
             from db_temporal..ah_tran_monet_tmp p,
                  db_temporal..cc_trans_pagos_terc t,
                  db_temporal..cc_causas_pagos_terc c
             where tm_tipo_transaccion = t.tp_tipo_trx
               and t.tp_cod_archivo = @w_archivo_proc
               and t.tp_nom_cat = @w_cat_trx1
               and tm_causa = c.cp_causa
               and c.cp_cod_archivo = @w_archivo_proc
               and c.cp_nom_cat = @w_cat_cau1
               --and tm_fecha = @w_fecha
               --and tm_tipo_tran = 4272
               --and tm_causa = '442'
            union all
            select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                   @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
                   tm_secuencial,convert(varchar(10),tm_fecha,103),
                   '0,00','0,00','0,00','0,00','0,36','0,00','0,00','0,00',
                   '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
                   '0,00','0,00','0,00','0,00',
                   1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull(tm_valor,0)),'.',','),
                   (select of_provincia  from cobis..cl_oficina where of_oficina = p.tm_oficina),
                   (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = p.tm_oficina),
                   @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110715'
                   tp_cod_archivo,cp_causa,tm_usuario
              from db_temporal..cc_tran_monet_tmp p,
                   db_temporal..cc_trans_pagos_terc t,
                   db_temporal..cc_causas_pagos_terc c
             where tm_tipo_transaccion = t.tp_tipo_trx
               and t.tp_cod_archivo = @w_archivo_proc
               and t.tp_nom_cat = @w_cat_trx1
               and tm_causa = c.cp_causa
               and c.cp_cod_archivo = @w_archivo_proc
               and c.cp_nom_cat = @w_cat_cau1
               --tm_fecha = @w_fecha
               --and tm_tipo_tran = 3050
               --and tm_causa = '442'

           if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end
else if @w_id_archivo = 'ID9' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00401007_SENAE *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00401007_SENAE',  --Ref02 MLR viene desde el cursor
     -- @w_cta_contable = '54901018'
                        
  --set @w_sri_ruc     = '1760013480001',
  --    @w_sri_tipemp  = 'PUB',
  --    @w_sri_nombre  = 'SERVICIO NACIONAL DE ADUANA DEL ECUADOR'
-- Se obtiene el nombre de los catalogos
--  select @w_cat_trx1 = catalogo_trx1, --Ref02 MLR viene desde el cursor
  --       @w_cat_cau1 = catalogo_causa1
  -- from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

           select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                  @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
                  ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                  case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case when substring(ts_tipo_chequera,1,3) in ('VEN', 'SAT') then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00', --Ref11:MGR SAT
                  case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03  str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  '0,00','0,00','0,00','0,00',
                  --'0,00',--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  '0,00','0,00','0,00',
                  --Ref017:msilvag Inicio (is_ModPago_efec_ventanilla)
                  case when ts_valor > 0 then 1 
                  		when ts_monto > 0 and ts_usuario not in ('srolese','SROLESE','ope998') then 1
                  		when ts_ocasional > 0 then 1
                  		when ts_contratado > 0 and ts_usuario not in ('srolese','SROLESE','ope998') then 1
                         else 0 end,
                   --is_ModPago_cheque_ventanilla
                   case when ts_saldo > 0 then 1 
                           else 0 end,
                  --Ref017:msilvag Fin
                  0,0,0,0,
                  --Ref017:msilvag Inicio  is_ModPago_debito_pago_clte
                   case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
				  		when ts_usuario like '0000%' then 1
				  		when ts_usuario like '%CAJ00%' then 1
				  		when ts_descuento_iess > 0 then 1 
				  		--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
				        --Ref018:msilvag Fin
                      else 0 end ,
                  --Ref017:msilvag Fin 
                  0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_contratado,0)+isnull(ts_ocasional,0)+isnull(ts_descuento_iess,0)),'.',','),
                  (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  @w_cta_contable, @v_concepto + ' ' +@w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '190499'
                   tp_cod_archivo,cp_causa,ts_usuario
             from db_temporal..cc_tran_servicio_tmp p,
                  db_temporal..cc_trans_pagos_terc t,
                  db_temporal..cc_causas_pagos_terc c
            where ts_tipo_transaccion = t.tp_tipo_trx
              and t.tp_cod_archivo = @w_archivo_proc
              and t.tp_nom_cat = @w_cat_trx1
              and ts_causa = c.cp_causa
              and c.cp_cod_archivo = @w_archivo_proc
              and c.cp_nom_cat = @w_cat_cau1
              --ts_tipo_transaccion in (3166,3332,43359)
              --and ts_causa = '940'
             if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end

else if @w_id_archivo = 'ID10' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00421007 *-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00421007',   --Ref02 MLR viene desde el cursor
    --  @w_cta_contable = '54901019'
                        
  --set @w_sri_ruc     = '1760013210001',
  --    @w_sri_tipemp  = 'PUB',
  --    @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
  -- Se obtiene el nombre de los catalogos
  --select @w_cat_trx1 = catalogo_trx1, --Ref02 MLR viene desde el cursor
    --     @w_cat_cau1 = catalogo_causa1
   --from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
          select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                  @w_sri_nombre  ,@w_sri_ruc, @w_sri_tipemp,
                  ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                  case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case isnull(substring(ts_tipo_chequera,1,3),'VEN') when 'VEN' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  '0,00','0,00','0,00','0,00',
                  --'0,00'--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  '0,00','0,00','0,00',
                  --Ref018:msilvag Inicio (is_ModPago_efec_ventanilla)
                  case when ts_saldo > 0 then 1 
                       else 0 end,
                   --is_ModPago_cheque_ventanilla
                   case when ts_valor > 0 then 1 
                         else 0 end,
                  --is_ModPago_tarjcredito_cte
                  case when ts_monto > 0 then 1 else 0 end,
                  --Ref018:msilvag Fin
                  0,0,0,
                  --Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
                  case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 
						when ts_usuario like '0000%' then 1
				  		when ts_usuario like '%CAJ00%' then 1
				  		when ts_ocasional > 0 then 1 
				  		--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                      else 0 end ,
                  --Ref018:msilvag Fin  
                  0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_ocasional,0)),'.',','),
                  (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
                  tp_cod_archivo,cp_causa,ts_usuario
             from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,
                  db_temporal..cc_trans_pagos_terc t,
                  db_temporal..cc_causas_pagos_terc c
            where ts_tipo_transaccion = t.tp_tipo_trx
              and t.tp_cod_archivo = @w_archivo_proc
              and t.tp_nom_cat = @w_cat_trx1
              and ts_causa = c.cp_causa
              and c.cp_cod_archivo = @w_archivo_proc
              and c.cp_nom_cat = @w_cat_cau1
              and ts_tipo_transaccion = tc_tipo_tran
              and tc_causa_org      = isnull(ts_causa,'0')
             --and tc_tipo_tran in (3295,3336)
             --and tc_causa_org = '0'
              and tc_estado       = 'V'
              and tc_contabiliza = 'ADU'

             if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end

else if @w_id_archivo = 'ID11' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00571007 *-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00571007',  --Ref02 MLR viene desde el cursor
    --  @w_cta_contable = '54901021'
                        
-- Se obtiene el nombre de los catalogos
  --select @w_cat_trx1 = catalogo_trx1,
  --       @w_cat_cau1 = catalogo_causa1
  -- from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

          select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                 (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,pe_ruc,
                 case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                 where a.tabla = 'cl_tipo_sector_cia'
                 and b.tabla = a.codigo
                 and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                 ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                 case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
                 str_replace(convert(varchar,convert(money,isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0) / @v_porcIva)),'.',','), --<Ref03 str_replace(convert(varchar(4),(round((isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / (1 + 0.12)),2))),'.',',') ,
                 case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 '0,00','0,00','0,00','0,00',
                 --'0,00',--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                 case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money,convert(money, ts_autoriz_aut) / @v_porcIva)),'.',',') else '0,00' end,--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                 '0,00','0,00','0,00',
                 --Ref018:msilvag Inicio (is_ModPago_efec_ventanilla)
                 case when ts_valor > 0 then 1 
                     else 0 end,
                 --is_ModPago_cheque_ventanilla
                 case when ts_saldo > 0 then 1 
                       else 0 end,
             	 --Ref018:msilvag Fin
                 0,
                 case when ts_contratado > 0 then 1 else 0 end, --Ref018:msilvag is_ModPago_tarjcredito_dif
                 0,0,
               --Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
               case when ts_usuario = 'ope998' and ts_monto > 0 then 1
               		when ts_usuario in ('srolese','SROLESE','sa','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
			   		when ts_usuario like '0000%' then 1
			   		when ts_usuario like '%CAJ00%' then 1
			   		when ts_monto > 0 then 1 
			   		--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                    else 0 end ,
                --Ref018:msilvag Fin  
                 0, case when ts_contratado > 0 then @v_tarifa_mun else '0,00' end , --Ref018:msilvag 
                 str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_contratado,0)),'.',','), --Ref016:msilvag
                 (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 @w_cta_contable, (case @w_concepto_reca when 'CATALOGO' then isnull((select @v_concepto +' ' + pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = x.pe_ruc),'RECAUDACION POR CONCEPTO DE IMPUESTOS PREDIALES') else @v_concepto + ' ' + @w_concepto_reca end),-- Ref02(case x.pe_ruc when '0960000220001' then '110201' when '0960000490001' then '190499' when '0160000270001' then '190499' when '0960001540001' then '190499' when '0960006340001' then '190499'  when '0960001380001' then '190499'  when '0960001460001' then '190499' when '1760003410001' then '190499' else 'RECAUDACION POR CONCEPTO DE IMPUESTOS PREDIALES' end),
                 tp_cod_archivo,cp_causa,ts_usuario --@w_concepto_reca db_temporal..cc_pag_ter_concepto (pt_id, pt_concepto)
            from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
                 db_temporal..cc_trans_pagos_terc t,
                 db_temporal..cc_causas_pagos_terc c
           where ts_tipo_transaccion = t.tp_tipo_trx
             and t.tp_cod_archivo = @w_archivo_proc
             and t.tp_nom_cat = @w_cat_trx1
             and ts_causa = c.cp_causa
             and c.cp_cod_archivo = @w_archivo_proc
             and c.cp_nom_cat = @w_cat_cau1
             and ts_tipo_transaccion = tc_tipo_tran
             and tc_causa_org     = ts_causa
             -- and tc_tipo_tran in (3218,3220,3215,4112,3221,3925,3926,3928)
             -- and tc_causa_org in ('2234','2235','2236','2237','2319','1800','1430','9','1435','1434','1433')
             and tc_estado       = 'V'
             and x.pe_empresa  = convert(int,ts_causa)
          union 
          select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
                case substring(ts_tipo_chequera,1,3) when 'IBK' then '0,00' else '0,00' end,
                case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
                case substring(ts_tipo_chequera,1,3) when 'VEN' then '0,00' else '0,00' end ,
                case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                '0,00','0,00','0,00','0,00',
                --'0,00'--Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end, --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                '0,00','0,00','0,00',
                --Ref017:msilvag Inicio (is_ModPago_efec_ventanilla)
                case when ts_valor > 0 then 1 
                     else 0 end,
                --is_ModPago_cheque_ventanilla
                case when ts_saldo > 0 then 1 
                     else 0 end,
                --is_ModPago_tarjcredito_cte
                case when ts_contratado > 0 and ts_usuario = 'ope998' then 1 else 0 end,
                --Ref018:msilvag Fin
                0,0,0,
                --Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
                case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
			   		when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_monto > 0 then 1 
					--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                    else 0 end ,
                --Ref018:msilvag Fin  
                0,'0,00',str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_contratado,0)),'.',','), --Ref016:msilvag 
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                @w_cta_contable,(case @w_concepto_reca when 'CATALOGO' then isnull((select @v_concepto + ' ' + pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = x.pe_ruc),'RECAUDACION POR CONCEPTO DE IMPUESTOS PREDIALES') else @v_concepto + ' ' + @w_concepto_reca end),-- Ref02 (case x.pe_ruc when '0960000220001' then '110201' when '0960000490001' then '190499' when '0160000270001' then '190499' when '0960001540001' then '190499' when '0960006340001' then '190499'  when '0960001380001' then '190499'  when '0960001460001' then '190499' when '1760003410001' then '190499' else 'RECAUDACION POR CONCEPTO DE IMPUESTOS PREDIALES' end),
                tp_cod_archivo,cp_causa,ts_usuario
           from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
                db_temporal..cc_trans_pagos_terc t,
                db_temporal..cc_causas_pagos_terc c
          where ts_tipo_transaccion = t.tp_tipo_trx
            and t.tp_cod_archivo = @w_archivo_proc
            and t.tp_nom_cat = (@w_cat_trx1 + '_2')
            and ts_causa = c.cp_causa
            and c.cp_cod_archivo = @w_archivo_proc
            and c.cp_nom_cat = (@w_cat_cau1  + '_2')
            and ts_tipo_transaccion = tc_tipo_tran
            and tc_causa_org     = ts_causa
            --and tc_tipo_tran in (3215,4112,3221)
            --and tc_causa_org in ('1417')
            and tc_estado       = 'V'
            and x.pe_empresa  = convert(int,ts_causa)

           if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end
  
  else if @w_id_archivo = 'ID12' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00581007 *-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00581007',  --Ref02 MLR viene desde el cursor
    --  @w_cta_contable = '54901019'
                        
   --set @w_sri_ruc     = '1760013210001',
   --   @w_sri_tipemp  = 'PUB',
   --   @w_sri_nombre  = 'SERVICIO DE RENTAS INTERNAS'
  -- Se obtiene el nombre de los catalogos
  --select @w_cat_trx1 = catalogo_trx1,--Ref02 MLR viene desde el cursor
    --     @w_cat_cau1 = catalogo_causa1
   --from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos

          select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                 @w_sri_nombre, @w_sri_ruc, @w_sri_tipemp,
                 ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                 case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,ts_descuento_iess),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                 '0,00','0,00','0,00','0,00',
                 --'0,00' --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                 case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, ts_descuento_iess / @v_porcIva)),'.',',') else '0,00' end, --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                 '0,00','0,00','0,00',
                 --Ref018:msilvag Inicio (is_ModPago_efec_ventanilla)
                 case when (ts_saldo > 0) and (ts_saldo > ts_valor) and (ts_saldo > ts_monto) and (ts_saldo > ts_ocasional) then 1 
					when ts_valor > 0 and ts_usuario = 'cnb001' then 1
                      else 0 end,
                 --is_ModPago_cheque_ventanilla
                 case when (ts_valor > 0) and (ts_valor > ts_saldo) and (ts_valor > ts_monto) and (ts_valor > ts_ocasional) and (ts_usuario != 'cnb001') then 1 
                      else 0 end,
                 --Ref018:msilvag Fin
                 0 ,
                 case when (ts_monto > 0) and (ts_monto > ts_saldo) and (ts_monto > ts_valor) and (ts_monto > ts_ocasional) then 1 
                 	  else 0 end,  --Ref018:msilvag is_ModPago_tarjcredito_dif
                 0,0,
                 --Ref018:msilvag Inicio  is_ModPago_debito_pago_clte
                 case when ts_usuario = 'ope998' and ts_ocasional > 0 then 1 
                 	when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 
				 	when ts_usuario like '0000%' then 1
				 	when ts_usuario like '%CAJ00%' then 1
				 	when (ts_ocasional > 0) and (ts_ocasional > ts_saldo) and (ts_ocasional > ts_valor) and (ts_ocasional > ts_monto) then 1 
				 	--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                      else 0 end ,
                --Ref018:msilvag Fin  
                 0, case when (ts_monto > 0) and (ts_monto > ts_saldo) and (ts_monto > ts_valor) and (ts_monto > ts_ocasional) then @v_tarifa_sri 
                 		 else '0,00' end , --Ref018:msilvag 
                 str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)+isnull(ts_ocasional,0)),'.',','),
                 (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                 @w_cta_contable, @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '110327'
                 tp_cod_archivo,cp_causa,ts_usuario
            from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,
                 db_temporal..cc_trans_pagos_terc t,
                 db_temporal..cc_causas_pagos_terc c
           where ts_tipo_transaccion = t.tp_tipo_trx
             and t.tp_cod_archivo = @w_archivo_proc
             and t.tp_nom_cat = @w_cat_trx1
             and ts_causa = c.cp_causa
             and c.cp_cod_archivo = @w_archivo_proc
             and c.cp_nom_cat = @w_cat_cau1
             and ts_tipo_transaccion = tc_tipo_tran
             and tc_causa_org     = isnull(ts_causa,'0')
             --and tc_tipo_tran in (3142,3331)
             -- and tc_causa_org = '2'
             and tc_estado       = 'V'
             and tc_contabiliza = 'ADU'
 
            if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end
  
else if @w_id_archivo = 'ID13' --> Ref02 MLR Se verifica si el Archivo de Proceso corresponde a query 
  begin
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- TD00891007 *-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*-*-*
  --set @w_archivo_proc = 'TD00891007', --Ref02 MLR viene desde el cursor  
     -- @w_cta_contable = '54901019'
                        
-- Se obtiene el nombre de los catalogos
  --select @w_cat_trx1 = catalogo_trx1,
  --       @w_cat_cau1 = catalogo_causa1
  -- from db_temporal..cc_tarchivos_pagos_terc
  --where cod_archivo = @w_archivo_proc
  
  --if @@rowcount != 0 -- Se verifica si la configuración está activa / Ref02 Se valida desde el cursor
    --begin
      insert into cob_cuentas..cc_inf_super
                (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
                 is_empresa,is_ruc_empresa,
                 is_tipo_empresa,is_numero_trans,is_FechTransaccion,
                 is_Tunitaria_clte_cajeros,is_Tunitaria_emp_cajeros,
                 is_Tunitaria_clte_internet,is_Tunitaria_emp_internet,
                 is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
                 is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
                 is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
                 is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
                 is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
                 is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
                 is_Valor_pagado,
                 is_Provincia,
                 is_Canton,
                 is_cuenta_contable,is_ConceptoRec,
                 is_tipo_archivo,is_causa,is_usuario)--Ref02 se agrega campos nuevos
          select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                 (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,pe_ruc,
                  case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                  where a.tabla = 'cl_tipo_sector_cia'
                  and b.tabla = a.codigo
                  and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                  ts_secuencial,convert(varchar(10),ts_tsfecha,103),
                  case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'VEN' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,
                  str_replace(convert(varchar,convert(money, isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0) / @v_porcIva)),'.',','), --<Ref03 str_replace(convert(varchar(4),(round((isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0.00) / (1 + 0.12)),2))),'.',','),
                  case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                  '0,00','0,00','0,00','0,00',
                  --'0,00' --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money, convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end, --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                  '0,00','0,00','0,00',
                  --Ref013:msilvag  Efectivo
                  case when ts_valor > 0 then 1 
                    else 0 end
                  --Cheque
                  ,case when ts_saldo > 0 then 1 
                       else 0 end 
                  --Ref013:msilvag Fin
                  --,0,0,0,0,				  
                  ,0,
                  case when ts_contratado > 0 then 1  /*<REF 2, KBastida ts_contratado is_ModPago_tarjcredito_cte REF 2>*/                       			  		
                      else 0 end
                  ,0,0,                  
                  --Ref013:msilvag Inicio Debito a Cuenta
                  case  when ts_contratado > 0 then 0 /*<REF 2, KBastida ts_contratado por TC REF 2>*/
						when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio 
				  		when ts_usuario like '0000%' then 1
				  		when ts_usuario like '%CAJ00%' then 1
				  		when ts_monto > 0 then 1 
				  		--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
				        --Ref018:msilvag Fin
                      else 0 end
                  --Ref013:msilvag Fin
                  ,0,
				  case  when ts_contratado > 0 then (select v_tarifa_mun = pa_char from cobis..cl_parametro where pa_nemonico = 'TMUPT')
				   else '0,00' end				  
				  , /*<REF 2, KBastida Tasa Interes Por TC REF 2>*/
				  str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_contratado,0)+isnull(ts_saldo,0)),'.',','), /*<REF 2, KBastida ts_contratado TC REF 2>*/
                  (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                  @w_cta_contable, 
                  (case @w_concepto_reca when 'CATALOGO' then isnull((select @v_concepto +' ' + pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = x.pe_ruc),'RECAUDACION POR CONCEPTO DE TRAMITES Y CITACIONES') else @v_concepto + ' ' + @w_concepto_reca end),  --Ref0018:msilvag @v_concepto + ' ' + @w_concepto_reca,--Ref02 se agrega variable @w_concepto_reca antes valor quemado '190499'
                  tp_cod_archivo,cp_causa,ts_usuario
             from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
                  db_temporal..cc_trans_pagos_terc t,
                  db_temporal..cc_causas_pagos_terc c
            where ts_tipo_transaccion = t.tp_tipo_trx
              and t.tp_cod_archivo = @w_archivo_proc
              and t.tp_nom_cat = @w_cat_trx1
              and ts_causa = c.cp_causa
              and c.cp_cod_archivo = @w_archivo_proc
              and c.cp_nom_cat = @w_cat_cau1
              and ts_tipo_transaccion = tc_tipo_tran
              and tc_causa_org      = ts_causa
              --and tc_tipo_tran in (3925,3926,3928)
              --and tc_causa_org in ('2572','6388')
              and tc_estado       = 'V'
              and x.pe_empresa  = convert(int,ts_causa)   

            if @@error <> 0
              begin
                print '********** Error en la informacion de %1! **********',@w_archivo_proc
                set @w_error = 1
                Return @w_error
              end
  end
--Ref006:msilvag Inicio
    else if @w_id_archivo = 'ID15'  --Servicios de Claro Batch
    begin

        insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,
               is_numero_trans,
               is_FechTransaccion,
               is_Tunitaria_clte_cajeros,
               is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,
               is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)
    
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,
                convert(varchar(10),ts_tsfecha,103),
                case substring(ts_tipo_chequera,1,3) when 'ATM' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'IBK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) 
                                when 'VEN' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') 
                                when 'DBA' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',')
								when 'DIR' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') --Ref010:msilvag 
                                else '0,00' end, 
                '0,00', 
                case substring(ts_tipo_chequera,1,3) when 'IVR' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'KSK' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                case substring(ts_tipo_chequera,1,3) when 'WAP' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00',--<Ref03 str_replace(convert(varchar(4),(round((isnull(convert(money,isnull(ts_autoriz_aut,'0')),0.00) / (1 + 0.12)),2))),'.',',') else '0,00' end,'0,00',
                '0,00','0,00','0,00','0,00',
                --'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                case substring(ts_tipo_chequera,1,3) when 'CNB' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') else '0,00' end,'0,00', --Ref04 MLR se remplaza el valor fijo por el campo de la comision canal cnb
                '0,00' ,'0,00',
				--Ref018:msilvag Inicio --Efectivo
                case when ts_valor > 0 then 1 else 0 end ,
				--Cheque
				case when ts_saldo > 0 then 1 else 0 end 
				--Ref018:msilvag Fin
				,0,0,0,
				--Ref010:msilvag Inicio
                case  when substring(ts_tipo_chequera,1,3) = 'DBA'  then 1 
                      when substring(ts_tipo_chequera,1,3) = 'DIR'  then 1 else 0 end ,  
				--Ref010:msilvag Fin
                --Ref009:msilvag Inicio
                --,0, --Debito
                case  when ts_usuario in ('srolese','SROLESE','ope998','WAP','wap','consola') then 1 --Ref018:msilvag Inicio
          			when ts_usuario like '0000%' then 1
          			when ts_usuario like '%CAJ00%' then 1
          			when ts_monto > 0 then 1 
                	--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
               	else 0 end  ,
				--Ref018:msilvag Fin
				0,'0,00', str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                @w_cta_contable,  @w_concepto_reca, 
                tp_cod_archivo,cp_causa,ts_usuario 
        from db_temporal..cc_tran_servicio_tmp p, cob_pagos..pg_person_empresa x,
              db_temporal..cc_trans_pagos_terc t,
              db_temporal..cc_causas_pagos_terc c
        where ts_tipo_transaccion = t.tp_tipo_trx
          and t.tp_cod_archivo = @w_archivo_proc
          and t.tp_nom_cat = (@w_cat_trx1 + '_2')
          and ts_causa = c.cp_causa
          and c.cp_cod_archivo = @w_archivo_proc
          and c.cp_nom_cat = (@w_cat_cau1+ '_2')
          --ts_tipo_transaccion = 3427
          --and ts_causa      in ('38','42')
          and x.pe_empresa  = convert(int,ts_causa)
        --Ref015:msilvag Inicio
        union all
        select @w_fecha_corte ,'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = e.pe_ruc) ,
                e.pe_ruc, 
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = e.pe_ruc) 
                    when '11' then 'FID' 
                    else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                            where a.tabla = 'cl_tipo_sector_cia'
                            and b.tabla = a.codigo
                            and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = e.pe_ruc)) end,
                cc_id ,convert(varchar(10),cc_fecha_debito,103),
                '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
                '0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00','0,00',
                1,0,0,0,0,0,0,0,'0,00',str_replace(convert(varchar,isnull((convert(money,substring(cc_total,1,10) + '.' + substring(cc_total,11,2))),0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = 0),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = 0), @w_cta_contable,  --'54060818'
                (case @w_concepto_reca when 'CATALOGO' then isnull((select pt_concepto from db_temporal..cc_pag_ter_concepto where pt_id = '0000000000000'),'190499') else @v_concepto + ' ' + @w_concepto_reca end),--Ref02 se agrega variable @w_concepto_reca antes valor quemado '190499'
                @w_archivo_proc, 'cnt','cnt'--REf02 se agrega valores nuevos
        from cob_cuentas..cc_debito_cnt c inner join cob_pagos..pg_servicios p
            on substring(c.cc_telefono,4,7) = p.ps_codigo  and  substring(c.cc_telefono,2,2) = p.ps_area
          inner join cob_pagos..pg_person_empresa e
            on convert(int,c.cc_empresacnt)  = e.pe_empresa
        where cc_fecha_debito = @i_fecha 
        and cc_estado = 'P'
        and ps_empresa_orig = 1 
        and ps_tipo = 'T' 
        and ps_cod_proveedor in (select convert(smallint,b.codigo) 
                                from cobis..cl_tabla a, cobis..cl_catalogo b
                                where a.tabla = 'cl_servicio_telefonico_bb'
                                 and a.codigo = b.tabla
                                 and convert(smallint,b.valor) = 3
                                 and estado = 'V') 
        --Ref015:msilvag Fin
        if @@error <> 0
        begin
            print '********** Error en la informacion de %1! **********',@w_archivo_proc
            set @w_error = 1
            Return @w_error
        end
            
    end
--Ref006:msilvag Fin
--Ref14:dolaya Ini
    else if @w_id_archivo = 'ID16' -- Servicios ECOTEC
    begin
        insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,
               is_numero_trans,
               is_FechTransaccion,
               is_Tunitaria_clte_cajeros,
               is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,
               is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)
        select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
                case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b
                where a.tabla = 'cl_tipo_sector_cia'
                and b.tabla = a.codigo
                and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
                ts_secuencial,
                convert(varchar(10),ts_tsfecha,103),
                '0,00','0,00',
                '0,00','0,00',
                case substring(ts_tipo_chequera,1,3) 
                                when 'VEN' then str_replace(convert(varchar,convert(money,convert(money,isnull(ts_autoriz_aut,'0')) / @v_porcIva)),'.',',') 
                                else '0,00' end, 
                '0,00', 
                '0,00','0,00',
                '0,00','0,00',
                '0,00','0,00',
                '0,00','0,00','0,00','0,00',
                '0,00','0,00',
                '0,00','0,00',
                --Ref018:msilvag Inicio
                case when ts_valor > 0 then 1 
					else 0 end
				,case when ts_saldo > 0 then 1 
                       else 0 end 
                --Ref018:msilvag Fin
				,0,0,0,
                0,
                --Ref018:msilvag Inicio
                case  when ts_usuario in ('srolese','SROLESE', 'sa','ope998','WAP','wap','consola') then 1
					when ts_usuario like '0000%' then 1
					when ts_usuario like '%CAJ00%' then 1
					when ts_monto > 0 then 1 
					--when substring(ts_tipo_chequera,1,3) = 'IBK' and convert(money,ts_autoriz_aut) > 0  then 1
                --Ref018:msilvag Fin
                      else 0 end ,
				0,'0,00', str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
                (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
                @w_cta_contable, case when exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.codigo = c.tabla 
								and t.tabla = 'SBS_PTERC_CONCEPTOS' and c.codigo = @w_id_archivo and c.valor = 'RCPOIEDU001') then 'RECAUDACIÓN POR CONCEPTO DE PENSIONES Y OTROS A INSTITUCIONES EDUCATIVAS'
								else '' end, 
                tp_cod_archivo,cp_causa,ts_usuario 
        from db_temporal..cc_tran_servicio_tmp p, cob_pagos..pg_person_empresa x,
              db_temporal..cc_trans_pagos_terc t,
              db_temporal..cc_causas_pagos_terc c
        where ts_tipo_transaccion = t.tp_tipo_trx
          and t.tp_cod_archivo = @w_archivo_proc
          and t.tp_nom_cat = (@w_cat_trx1)
          and ts_causa = c.cp_causa
          and c.cp_cod_archivo = @w_archivo_proc
          and c.cp_nom_cat = (@w_cat_cau1)
          and x.pe_empresa  = convert(int,ts_causa)
        if @@error <> 0
        begin
            print '********** Error en la informacion de %1! **********',@w_archivo_proc
            set @w_error = 1
            Return @w_error
        end
            
    end
    else if @w_id_archivo = 'ID17'  --Servicios ECOTEC - Reporta valores cobrados de la empresa
    begin
		insert into cob_cuentas..cc_inf_super
              (is_fecha_corte,is_nem_servicio,is_codigo_entidad,is_nombre_entidad,
               is_empresa,is_ruc_empresa,
               is_tipo_empresa,
               is_numero_trans,
               is_FechTransaccion,
               is_Tunitaria_clte_cajeros,
               is_Tunitaria_emp_cajeros,
               is_Tunitaria_clte_internet,
               is_Tunitaria_emp_internet,
               is_Tunitaria_clte_oficina,is_Tunitaria_emp_oficina,
               is_Tunitaria_clte_banca_elec,is_Tunitaria_emp_banca_elect,is_Tunitaria_clte_kiosko,is_Tunitaria_emp_kiosko,
               is_Tunitaria_clte_banca_cel,is_Tunitaria_emp_banca_cel,is_Tunitaria_clte_tarjdebito,
               is_Tunitaria_emp_tarjdebito,is_Tunitaria_clte_tarjcredito,is_Tunitaria_emp_tarjcredito,is_Tunitaria_clte_cnb,is_Tunitaria_emp_cnb,is_Tunitaria_clte_ventcompart,is_Tunitaria_emp_ventacompart,is_ModPago_efec_ventanilla,
               is_ModPago_cheque_ventanilla,is_ModPago_tarjcredito_cte,is_ModPago_tarjcredito_dif,
               is_ModPago_tarjdebito,is_ModPago_debito_automatico,is_ModPago_debito_pago_clte,is_ModPagoTransfInterbancaria,is_TasaInteres,
               is_Valor_pagado,
               is_Provincia,
               is_Canton,
               is_cuenta_contable,is_ConceptoRec,
               is_tipo_archivo,is_causa,is_usuario)
		select @w_fecha_corte, 'CTA',@w_sri_codigo,@w_bco_nombre,
                (select substring(p_p_apellido,1,50) + substring(p_s_apellido,1,50) from cobis..cl_ente where en_ced_ruc = x.pe_ruc)  ,
                pe_ruc,
               case (select c_tipo_compania from cobis..cl_ente where en_ced_ruc = x.pe_ruc) when '11' then 'FID' else (select substring(b.valor,1,3) from cobis..cl_tabla a , cobis..cl_catalogo b where a.tabla = 'cl_tipo_sector_cia' and b.tabla = a.codigo and b.codigo = (select c_tipo_sector from cobis..cl_ente where en_ced_ruc = x.pe_ruc)) end,
               ts_secuencial,
               convert(varchar(10),ts_tsfecha,103),
               '0,00',
               '0,00',
               '0,00',
               '0,00',
               '0,00',
               str_replace(convert(varchar,convert(money, isnull((select pn_costo_recauda/pn_cont_trn from cob_pagos..pg_control_ncrecaudacion where pn_empresa = x.pe_empresa  and pn_fecha_rec = p.ts_tsfecha and pn_costo_recauda > 0),0) / @v_porcIva)),'.',','),
               '0,00','0,00',
               '0,00','0,00',
               '0,00','0,00',
               '0,00','0,00','0,00','0,00',
               '0,00','0,00',
               '0,00' ,'0,00',1,0
			   ,0,0,0,0,0,0,'0,00', str_replace(convert(varchar,isnull(ts_valor,0)+isnull(ts_monto,0)+isnull(ts_saldo,0)),'.',','),
               (select of_provincia  from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina = isnull(p.ts_oficina,0)),
               @w_cta_contable, case when exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.codigo = c.tabla 
								and t.tabla = 'SBS_PTERC_CONCEPTOS' and c.codigo = @w_id_archivo and c.valor = 'RCPOIEDU001') then 'RECAUDACIÓN POR CONCEPTO DE PENSIONES Y OTROS A INSTITUCIONES EDUCATIVAS'
								else '' end,
               tp_cod_archivo,cp_causa,ts_usuario
          from db_temporal..cc_tran_servicio_tmp p, cob_remesas..re_tran_contable,cob_pagos..pg_person_empresa x,
               db_temporal..cc_trans_pagos_terc t,
               db_temporal..cc_causas_pagos_terc c
         where ts_tipo_transaccion = t.tp_tipo_trx
           and t.tp_cod_archivo = @w_archivo_proc
           and t.tp_nom_cat = @w_cat_trx1
           and tc_causa_org = c.cp_causa
           and c.cp_cod_archivo = @w_archivo_proc
           and c.cp_nom_cat = @w_cat_cau1
           and ts_tipo_transaccion = tc_tipo_tran
           and tc_causa_org      = ts_causa
           and tc_estado       = 'V'
           and x.pe_empresa  = convert(int,ts_causa)

        if @@error <> 0
        begin
            print '********** Error en la informacion de %1! **********',@w_archivo_proc
            set @w_error = 1
            Return @w_error
        end
            
    end
--Ref14:dolaya Fin 

  FETCH_REGISTRO:
  
 fetch cur_tipos_archivos into
      @w_id_archivo,      @w_archivo_proc,       @w_cat_trx1,
      @w_cat_cau1,        @w_cat_concepto,       @w_cat_comision,
      @w_cta_contable,    @w_concepto_reca 
end
return @w_error 
go
if exists(select 1 from db_temporal..sysobjects where name='cc_tran_monet_tmp' and type = 'U')
    drop table  db_temporal..cc_tran_monet_tmp
if exists(select 1 from db_temporal..sysobjects where name='ah_tran_monet_tmp' and type = 'U')
    drop table  db_temporal..ah_tran_monet_tmp
if exists(select 1 from db_temporal..sysobjects where name='cc_tran_servicio_tmp' and type = 'U')
    drop table  db_temporal..cc_tran_servicio_tmp
if exists(select 1 from db_temporal..sysobjects where name='cc_tarchivos_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_tarchivos_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_trans_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_trans_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_causas_pagos_terc' and type = 'U')
    drop table  db_temporal..cc_causas_pagos_terc
if exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_concepto' and type = 'U') --Ref02 MLR se elimina la tabla temporal
    drop table  db_temporal..cc_pag_ter_concepto
if exists(select 1 from db_temporal..sysobjects where name='cc_pag_ter_comision' and type = 'U') --Ref02 MLR se elimina la tabla temporal
    drop table  db_temporal..cc_pag_ter_comision
    
go

--Ref018:msilvag Inicio
if exists(select 1 from sysobjects where name='sp_reporte_mensual_sbs')
	PRINT '== CREATE PROCEDURE sp_reporte_mensual_sbs *OK* =='
else
	PRINT '<<< CREATE PROCEDURE sp_reporte_mensual_sbs -- ERROR -- >>>'
go
--Ref018:msilvag Fin



