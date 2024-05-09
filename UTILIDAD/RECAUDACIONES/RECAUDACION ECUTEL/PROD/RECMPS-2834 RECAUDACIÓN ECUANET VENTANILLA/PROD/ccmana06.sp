/************************************************************************/
/*  Archivo:            ccmana06.sp                                     */
/*  Motor de Base: 	    SYBASE                     					      */
/*  Base de datos:      cob_super                                       */
/*  Servidor: 			HP-ACT                                             */
/*  Aplicacion: 		Cyberbank	                                       */
/*  Stored procedure:   sp_procesos_manuales_a06                        */
/*  Procesamiento: 	    OLTP	                                          */
/*  Ult.ControlTarea:   J-RECMPS-2834                            */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       German Medina Cevallos                          */
/*  Fecha de escritura: 07-Diciembre-2009                               */
/*  Ult.Referencia:     REF 74                                          */
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
/*      Saca los procesos manuales del a06                              */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA          AUTOR              RAZON                             */
/*  07/DIC/2009    German Medina C.   Emision Inicial                   */
/*2 12/MAR/2010    German Medina C.   CTE-CC-8434 - Tasa Ponderada      */
/*3 29/MAY/2010    German Medina C.   Agregar Servicios                 */
/*                                    CTE-CC-8888                       */
/*4 10/JUN/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-8977                       */
/*5 25/JUN/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-9092                       */
/*6 25/JUN/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-9130                       */
/*7 26/JUL/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-9200                       */
/*8 20/DIC/2010    German Medina C.   Optimizacion Sp                   */
/*                                    CTE-CC-9680                       */
/*9 04/MAY/2012    German Medina C.   Optimizacion AHO-CC-11398         */
/*10 08/Sep/2014   Sandra Merino.     RECBEL-AP-SGC00016734-SGC00016735	*/
/*11 28-Abr-2015  Maria Jose Silva    RECA-CC-SGC00020190  Cobro de comisión IESS*/
/*12 15-Sep-2015  Pablo Holguin V.    CTE-CC-SGC00022250 Modificaciones */
/*14 15-Sep-2015  Juan Camilo Vélez.  SAT-SD-SGC00020798 Modificaciones */
/*15 03/Dic/2015  Galo Yanez	      Considerar trx de comision de 	*/
/*				      protesto de cheques		*/
/*				      Tarea: CTE-CC-SGC00023186		*/
/*16 14/Dic/2015  Galo Yanez	      Considerar trx de comision de 	*/
/*				      envio de estados de cuentas	*/
/*				      Tarea: CTE-CC-SGC00023169		*/
/*17 05/Ene/2016  Galo Yanez	      Considerar trx de transferencias	*/
/*				      reportarlas por rango		*/
/*				      Tarea: CTE-CC-SGC00023366		*/
/*18 25-May-2015  María José Silva  ETAPA-AP-SGC00018437-SGC00018451 Comisión de Etapa*/
/*19 16-Feb-2016  Pablo Holguin V.    RECA-CC-SGC00024111 		*/
/*					Considerar Depositos especiales */
/*20 21-Mar-2016  Miriam Lindao      CNB-316-SGC00017506                    */
/*                                   Transacciones de Servicio Canal CNB (N)*/
/*21 23/May/2016  Luis Banda Pozo     SAT-CC-SGC00024751 Se agrega transacciones */
/*                                    TD00371007 para empresa 861 y 538 de SAT   */
/*22 28/Abr/2016  Jorge Pazminno    CENSUR-AP-SGC00019459-SGC00023829    */
/*23 04/ABR/2016  Daniel Pereira       DTVPOS-AP-SGC00023777-SGC00023778/DTVPOS-AP-SGC00023777-SGC00023780 */
/*24 07-Jul-2016  Miriam Lindao      CNBNV-AP-SGC00022685-SGC00023549            */
/*                                   Aumentar causas recaudaciones Canal CNB (N) */
/*                                   y consolidar cambios Basica de VMiranda     */
/*25 01/Mar/2016  Galo Yanez	      Considerar trx de comision de 		*/
/*				      envio de estados de cuentas mt940		*/
/*				      via swift					*/
/*				      Tarea: CTE-CC-SGC00024364			*/
/*				      (Ref.:25)					*/
/*26 02-Ago-2016  Jorge Pazminno     RECA-CC-SGC00025765 - Nueva Recaudacion    */
/*                                   Tasa Recoleccion Basura - Interagua 8269   */
/*27 22-Ago-2016  Jonathan Lopez Torres BTNPAG-AP-SGC00021274 - Nueva Recaudacion    */
/*                                   Boton de Pago   */
/*28 21-Sep-2016  Miriam Lindao      CNBF3-AP-SGC00026410 Manejar avances en    */
/*                                   efectivo sin causa Canal CNB (N)           */
/*29 18-Nov-2016  Vanessa Miranda MEER-AP-SGC00026606-SGC00026614 Ajuste para que se cuenten*/
/*              todas las transacciones y se sume los valores monetarios de transacciones   */
/*              que tengan comisión                                                         */
/*30 30-Dic-2016  Pablo Holguin V.    CTE-CE-SGC00027521 		 */
/*					 Modificacion de Servicio	 */
/*31 05-Ene-2017  Jorge Pazminno     MEGA-AP-SGC00024776-SGC00024778            */
/*                                    Recaudacion Megadatos  - 1089             */
/*32 16-Dic-2016  Vanessa Miranda     MEER-AP-SGC00026606-SGC00026623           */
/*33 16-Feb-2017  Daniel Pereira     RECA-CC-SGC00027934  Cobro comisión ND Ventanilla */
/*34 16/mar/2017 T.Cervantes Z. CTE-CE-SGC00028202 Seleccionar registros en ba-      */
/*        se a tabla temporal que contiene el catalogo "pg_reca_tran_meer_a06".      */
/* 35 13/Abr/2017 Pablo Ricaurte A.  RECA-CC-SGC00027803 Debitos automaticos Primax  */
/* 36 11/Abr/2017 María Jo. Silva G. RECA-CC-SGC00027715 Servicios Claro	     */
/* 37 14-Mar-2017 Pablo Holguin      CTE-CC-SGC00028182 Modificacion de servicios    */
/* 38 21/Abr/2017 Miriam Lindao   SAT-CC-SGC00028083 Reportar comisión efectivo o cheque Colegios*/
/* 39 24/Abr/2017 Danny Olaya Soriano RECA-CC-RECA-CC-SGC00028468 Debito Automatico EEQ	*/
/* 41 11/May/2017 Jonathan Lopez Torres SGC00026597   Renovacion de Token              	*/
/* 42 18/May/2017 María José Silva RECA-CC-SGC00028461  Cobro de comision de TVCABLE   	*/
/* 43 18/May/2017 María José Silva RECA-CC-SGC00027998  Traslado comision VEN DIRECTV  	*/
/* 44 04/JUL/2017 Vanessa Miranda INRECL-AP-SGC00027264-SGC00027269  Reportar en A06   	*/
/*    las transacciones de WAP que no tengan comisión, solo contrar las transacciones  	*/
/*    porque las que tiene comisión están parametrizadas                               	*/
/* 45 25/Jul/2017 Daniel pereira  CAJ-CC-SGC00028304  cobro comision por canal ATM     	*/
/**************************************************************************************	*/
/* 46 16/Ago/2017 Vanessa Miranda MEER-AP-SGC00026606-SGC00028066                      	*/
/*     Para los servicios básicos considerar que si está parametrizado el cobro de     	*/
/*     comisión no debería salir estas transacciones en el ccmana06, solo considerar las*/
/*     transacciones realizadas en efectivo que no incurren movimientos de cuentas ,   	*/
/*     cuando el campo  and hs_valor > 0 significa que el pago es en efectivo, solo en 	*/
/*     este caso el A06 manual debe extraer la información                             	*/
/* 47 09/Feb/2018 Miriam Lindao   ALM-CC-SGC00030126  Causa Suscripcion Avisos24 React 	*/
/* 48 07/May/2018 Pablo Holguin   CTE-CC-SGC00031711  Adicionar Campo Cuenta contable  	*/
/* 49 21/JUN/2018 Paul Hoyos V.   FACOFF-AP-SGC00029747-SGC00030151 ComisionCert.Cheque	*/
/* 50 03/26/2019  Pablo Holguiv    CTE-CC-SGC00034569 Nuevos campos	      		*/
/* 51 07/29/2019  Pablo Holguiv    CTE-CE-SGC00036151 Correcion script genera montos    */
/* 52 07/29/2020  David Villavicencio BMK-1454 VALIDACION A06 PAGO INMEDIATO TC  	*/
/* 53 07/02/2020  Danny Quimis    CAJ-CC-SGC00035061 Pago TC desde ATM Multifuncion    */
/* 54 10/25/2019  Pablo Holguiv    CTE-CC-SGC00036628 Modificaciones A06	       	*/
/* 55 07/Oct/2021 Jonathan Guerrero RECM-353 A06-RECAUDACION EN 24MOVIL                	*/
/* 56 29/Oct/2021 Jonathan Guerrero RECM-419 A06-DIRECTV PREPAGO                    	*/
/* 57 09/Nov/2021  Dario Espinosa   RECM-408-REPORTAR TRANSACCIONES TRB EN A06 */
/* 58 16/Nov/2021 Maria Jo. Silva   RECM-441 TRANSACCIONES A06 */
/* 59 20/Oct/2021 Pablo Holguiv	    CTE-CC-SGC00042730 Migracion servicio Transferencias	*/
/* 60 26/05/2022  Kevin Bastidas    RECMPS-14782 PAGO TERCON - TERMINAL DE CONTENEDORES EN VENTANILLA*/
/* 61 22/Nov/2022 Kevin Bastidas 	RECESABREC-86 A06 AGENCIA NACIONAL DE TRANSITO 24ONLINE Y 24MOVIL*/
/* 62 12/Ene/2023 Jonathan Guerrero	RECMPS-2035 - RECAUDACION DE UNIVERSIDADES EN EL A06*/
/* 63 01/Feb/2023 Ariana Rivas      ESTCON-AP-SGC00040620-SGC00046076 Automatización de Servicios del A06 ATM*/
/* 64 22/Feb/2023 Jonathan Guerrero	RECM-692 - COBRO COMISION CLIENTE FINAL BELCORP     */
/* 65 28/Feb/2023 Luis Cepeda F.	RECMPS-1950 - BACKOFFICE BANCO PAGO MUNICIPIO CON TC EN SAT     */
/* 66 22/Mar/2023 Kevin Bastidas 	RECESABREC-86 A06 AGENCIA NACIONAL DE TRANSITO 24ONLINE Y 24MOVIL*/
/* 67 24/Abr/2023 Kevin Lizano(Gizlo)	ESTCON-AP-SGC00040620-SGC00046188: Administrador de Tarjeta - Token Virtual*/
/* 68 25/Abr/2023 Tomas Hernandez 	SATM-1860 Incluir trx y causas HD PpagoDirecto	*/
/* 69 29/05/2023 Kevin Bastidas 	RECMPS-2232 MIGRACION CSP A MICRO SRI TRANSFERENCIA DE DOMINIO CAUSA 50*/
/* 70 24/Mar/2023 Kevin Lizano(Gizlo)	ESTCON-AP-SGC00040620-SGC00046187: Caso de uso Cuentas*/
/* 71 07/Jul/2023 Kevin Bastidas	RECMPS-1351 MIGRACION CSP A MICRO TRANSFERENCIA DE DOMINIO*/
/* 72 25/Jul/2023 Kevin Lizano	Correccion servicios BD-R-CTE-CE-SGC00047480           */
/* 73 08/Ago/2023 Kevin Lizano	Regularizacion BD-R-CTE-CE-SGC00047651                 */
/* 74 27/Nov/2023 Kevin Bastidas	RECMPS-2834 ECUANET VENTANILLA A06 */
/****************************************************************************************/


use cob_super
go
if exists (select 1 from sysobjects where name = 'sp_procesos_manuales_a06' and type = 'P' )
  drop procedure dbo.sp_procesos_manuales_a06
  if exists (select 1 from sysobjects where name = 'sp_procesos_manuales_a06' and type = 'P' )
    print 'DROP PROCEDURE sp_procesos_manuales_a06 <<ERROR>>'
  else
    print 'DROP PROCEDURE sp_procesos_manuales_a06 <<OK>>'
go

create proc dbo.sp_procesos_manuales_a06
(
  @i_fecha_ini                smalldatetime,                    -- JPM Ref.20: antes opcioneales (default null)
  @i_fecha_fin                smalldatetime                     -- JPM Ref.20: antes opcioneales (default null)
)

as

--< Script para sacar la Info del A06 de los procesos manuales >--

--< Variables
declare
	@i_producto		smallint,
	@i_canal		char(1),
	@i_servicio     	varchar(10),
	@i_tipo_producto	varchar(10),
	@i_tipo_cliente		char(1),
	@i_descripcion		varchar(100),
	@i_tarifa		money,
	@i_comision		money, --Ref056:jg
	@cont			int,
	@cont2			int,
	@cont4			int,
	@cont5			int, --Ref055:jg
	@cont6			int, --Ref056:jg
	@valor			money,
	@valor2			money,
	@valor3             	money,
	@valor4             	money,
	@valor5             	money,  --Ref055:jg
	@valor6             	money,  --Ref056:jg
	@valorIESS  		money ,  --Ref011:msilvag
	--< ref: 12 >-- Agrega variables
	@w_error			int,
	@w_tipo_tarjeta 	char (2),
	@w_clase_tarjeta 	char (2),
	@w_tipo_tarifa 		char (2),
	--Ref018:msilvag Inicio
	@i_cant_etapa       	int  ,
	@valorEtapa         	money,
	--Ref018:msilvag Fin
	@w_porcIva           	float,	--Ref20
	@v_defla_iva         	int ,   --Ref27
	@v_cta_contable		varchar(20),  --Ref48
	@w_Iva			float    --Ref50

print 'Inicia Sp de Procesos Manuales!!!'
print 'Fecha_proceso: %1!', @i_fecha_fin


select @valor2 =0 --Ref24 Cambio cta básica VMT
--< Temporales

create table ##correccion
(
hs_ssn_corr	int	null
)

--create	nonclustered index  i_correccion_01  on ##correccion (hs_ssn_corr)


create table ##datos
(
 cuenta      varchar(10)  null,
 valor       money        null
)

create table ##datos_transf
(
 cuenta      varchar(10)  null,
 valor       money        null,
 comision    money	  null
)

create table ##1datos
(
 cuenta      varchar(10)  null,
 cantidad    int          null
)
create table ##res_1datos
(
 categoria   varchar(10)  null,
 cliente     char(1)  null,
 cantidad    int      null,
 valor       money    null,--< ref: 5>--
 iva	     money    null --< ref: 5>--
)
create table ##2datos
(
  cantidad    int          null,
  valor       money        null
)
create table #comision
 (
    num_operacion           int                 null,
    monto_pago              numeric(15, 2)       null
 )

--Ref50 temporal datos SIB
create table ##datos_sib
(
 cuenta      varchar(10)  null,
 valor       money        null,
 oficina     int,
 provincia   char(2)  null,
 canton	     char(2)  null
 )
create table ##3datos
(
  cantidad    int          null,
  valor       money        null,
  provincia   char(2)  null,
  canton      char(2)  null
)
create table ##3datos_resp
(
  cantidad    int          null,
  valor       money        null,
  provincia   char(2)  null,
  canton      char(2)  null
)
--<REF 72 Temporal para IVA
if object_id('tempdb.dbo.##3datos2') is not null
begin
      drop table tempdb.dbo.##3datos2
end
create table ##3datos2
(
  cantidad    int          null,
  valor       money        null,
  provincia   char(2)  null,
  canton      char(2)  null,
  iva          money null 
)
--REF 72>
create table ##temp_resporder
(
  cantidad    int          null,
  valor       money        null,
  provincia   char(2)  null,
  canton      char(2)  null,
  tarifa	  money null,
  iva          money null -- REF 72

)
--Ref50 --Catalogo de Porvincia SIB
select of_provincia provincia,
       substring(of_canton,3,2) canton ,
       of_oficina
into #tmp_lugar_sib from cobis..cl_oficina

-- Se obtiene el % del IVA
select @w_porcIva = pa_float + 1,
       @w_Iva =pa_float
from cobis..cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'IVA'

--> ********** <--
--> ********** <--
--> TA00030000 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TA00030000',
	@i_descripcion		= 'Debito a la cuenta del girador, al momento en que este o el beneficiario solicitan la certificacion',
	@i_tarifa		= 1.79  --Ref54 modifica tarifa --2

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3667)
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end
--return 0
--< Saca registros validos
truncate table ##datos

insert into ##datos
select 	hs_cta_banco, isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3667
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  --< Sacar reversos
  truncate table ##correccion
  insert into ##correccion
  select hs_ssn_corr
  from cob_cuentas_his..cc_his_servicio
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3032)
    and hs_causa = '18'
    and hs_correccion = 'S'

   if @@error <> 0
      begin
         print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
         return 9991
     end

insert into ##datos
select 	hs_cta_banco, isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3032
  and hs_causa = '18'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table ##datos, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end



--< CC0001

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'', isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  0,
 	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##datos, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end


insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total, cd_tasa_ponderada,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017',  @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), /*(case cc_tipo_contable when '3' then @valor2 else @valor end),*/ 0,
     	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

--< Si no hay datos se llenan con cero


--PHOYOSV INI REF_49 20180618
select @i_servicio      = 'TA00030000',
       @i_descripcion   = 'Debito a la cuenta del girador, al momento en que este o el beneficiario solicitan la certificacion',
       @i_tarifa        = 1.79,  --Ref54 modifica tarifa -- 2,
       @i_tipo_cliente  = '',
       @i_canal         = 'O'
--lleno informacion para cuentas corrientes
select @i_producto      = 3,
       @i_tipo_producto = 'CC0001'
select @cont=0, @cont2=0, @cont4=0, @valor=0, @valor2=0, @valor4=0
select @cont  = isnull(count(1), 0),
       @valor = isnull(sum(isnull(hm_valor,0)),0)
from cob_cuentas_his..cc_his_movimiento
where hm_fecha    >= @i_fecha_ini
  and hm_fecha    <= @i_fecha_fin
  and hm_tipo_tran = 3050
  and hm_causa     = '10'

select @cont2  = isnull(count(1), 0),
       @valor2 = isnull(sum(isnull(hm_valor,0)),0)
from cob_cuentas_his..cc_his_movimiento
where hm_fecha    >= @i_fecha_ini
  and hm_fecha    <= @i_fecha_fin
  and hm_tipo_tran = 3048
  and hm_causa     = '411'

select @valor4 = @valor - @valor2,
       @cont4  = @cont  - @cont2

if not exists (select 1 from cob_super..cc_detalle_a06
               where cd_fecha_corte   = @i_fecha_fin
                 and cd_tipo_servicio = @i_servicio
                 and cd_canal         = @i_canal
                 and cd_tipo_producto = @i_tipo_producto
                 and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
                 and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50
                 )
begin
   insert into cob_super..cc_detalle_a06
         ( cd_producto, cd_fecha_corte, cd_canal,
           cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
           cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
           cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
           cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	 )
   values( @i_producto, @i_fecha_fin, @i_canal,
           @i_servicio, @i_tipo_producto, @i_descripcion,
           null, null, substring(@i_servicio, 1, 2),
           @i_tipo_cliente, @cont4, @i_tarifa, round(isnull(@valor4,0)/@w_porcIva,2),
           'P','09','01',round(isnull(@valor4,0)/@w_porcIva,2),round(isnull(@valor4,0)/@w_porcIva,2),(isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))  --Ref50
           )

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end
end
else
begin
   update cob_super..cc_detalle_a06
     set cd_numero_trans   = cd_numero_trans + @cont4,
         cd_ingreso_total  = cd_ingreso_total + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_ingreso_neto   = cd_ingreso_neto + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_base_imponible = cd_base_imponible + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_iva_pagado = cd_iva_pagado + (isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))
   where cd_fecha_corte   = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio
     and cd_canal         = @i_canal
     and cd_tipo_producto = @i_tipo_producto
     and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
     and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

   if @@error <> 0
   begin
      print 'ERROR AL ACTUALIZAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9992
   end
end
--lleno informacion para cuentas de ahorros
select @i_producto      = 4,
       @i_tipo_producto = 'CA0001'
select @cont=0, @cont2=0, @cont4=0, @valor=0, @valor2=0, @valor4=0
select @cont  = isnull(count(1), 0),
       @valor = isnull(sum(isnull(hm_valor,0)),0)
from cob_ahorros_his..ah_his_movimiento
where hm_fecha    >= @i_fecha_ini
  and hm_fecha    <= @i_fecha_fin
  and hm_tipo_tran = 4272
  and hm_causa     = '10'

select @cont2  = isnull(count(1), 0),
       @valor2 = isnull(sum(isnull(hm_valor,0)),0)
from cob_ahorros_his..ah_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_tipo_tran = 4253
  and hm_causa     = '411'

select @valor4 = @valor - @valor2,
       @cont4  = @cont  - @cont2

if not exists (select 1 from cob_super..cc_detalle_a06
               where cd_fecha_corte   = @i_fecha_fin
                 and cd_tipo_servicio = @i_servicio
                 and cd_canal         = @i_canal
                 and cd_tipo_producto = @i_tipo_producto
                 and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
                 and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50
                 )
begin
   insert into cob_super..cc_detalle_a06
         ( cd_producto, cd_fecha_corte, cd_canal,
           cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
           cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
           cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
           cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
           )
   values( @i_producto, @i_fecha_fin, @i_canal,
           @i_servicio, @i_tipo_producto, @i_descripcion,
           null, null, substring(@i_servicio, 1, 2),
           @i_tipo_cliente, @cont4, @i_tarifa, round(isnull(@valor4,0)/@w_porcIva,2),
           'P','09','01',round(isnull(@valor4,0)/@w_porcIva,2),round(isnull(@valor4,0)/@w_porcIva,2),(isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))  --Ref50
           )

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9993
   end
end
else
begin
   update cob_super..cc_detalle_a06
     set cd_numero_trans  = cd_numero_trans + @cont4,
         cd_ingreso_total  = cd_ingreso_total + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_ingreso_neto   = cd_ingreso_neto + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_base_imponible = cd_base_imponible + round(isnull(@valor4,0)/@w_porcIva,2),
         cd_iva_pagado = cd_iva_pagado + (isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))
   where cd_fecha_corte   = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio
     and cd_canal         = @i_canal
     and cd_tipo_producto = @i_tipo_producto
     and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
     and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

   if @@error <> 0
   begin
      print 'ERROR AL ACTUALIZAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9994
   end
end
--lleno informacion para cuentas basicas
--print 'entro a cargar basica'
select @i_producto      = 12,
       @i_tipo_producto = 'CB0003'
select @cont=0, @cont2=0, @cont4=0, @valor=0, @valor2=0, @valor4=0
select @cont  = isnull(count(1), 0),
       @valor = isnull(sum(isnull(hm_valor,0)),0)
from cob_virtuales_his..vi_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_tipo_tran = 120060
  and hm_causa     = '10'

select @cont2  = isnull(count(1), 0),
       @valor2 = isnull(sum(isnull(hm_valor,0)),0)
from cob_virtuales_his..vi_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_tipo_tran = 120059
  and hm_causa     = '10'

select @valor4 = @valor - @valor2,
       @cont4  = @cont - @cont2
--print '@cont4=%1!,@valor4=%2!',@cont4,@valor4
if not exists (select 1 from cob_super..cc_detalle_a06
               where cd_fecha_corte   = @i_fecha_fin
                 and cd_tipo_servicio = @i_servicio
                 and cd_canal         = @i_canal
                 and cd_tipo_producto = @i_tipo_producto
                 and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
                 and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50
                 )
begin
   insert into cob_super..cc_detalle_a06
         ( cd_producto, cd_fecha_corte, cd_canal,
           cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
           cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
           cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
           cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
           )
   values( @i_producto, @i_fecha_fin, @i_canal,
           @i_servicio, @i_tipo_producto, @i_descripcion,
           null, null, substring(@i_servicio, 1, 2),
           @i_tipo_cliente, @cont4, @i_tarifa, round(isnull(@valor4,0)/@w_porcIva,2),
            'P','09','01',round(isnull(@valor4,0)/@w_porcIva,2),round(isnull(@valor4,0)/@w_porcIva,2),(isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))  --Ref50
           )

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9995
   end
end
else
begin
   update cob_super..cc_detalle_a06
     set cd_numero_trans  = cd_numero_trans + @cont4,
         cd_ingreso_total  = cd_ingreso_total + round(isnull(@valor4,0)/@w_porcIva,2),				--Ref50
         cd_ingreso_neto   = cd_ingreso_neto + round(isnull(@valor4,0)/@w_porcIva,2),				--Ref50
         cd_base_imponible = cd_base_imponible + round(isnull(@valor4,0)/@w_porcIva,2),				--Ref50
         cd_iva_pagado = cd_iva_pagado + (isnull(@valor4,0) - round(isnull(@valor4,0)/@w_porcIva,2))		--Ref50
   where cd_fecha_corte   = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio
     and cd_canal         = @i_canal
     and cd_tipo_producto = @i_tipo_producto
     and isnull(cd_tipo_cliente,'') = @i_tipo_cliente
     and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'					--Ref50

   if @@error <> 0
   begin
      print 'ERROR AL ACTUALIZAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9996
   end
end
--PHOYOSV FIN REF_49 20180618

--> ********** <--
--> ********** <--
--> TA00940000 <--
--> ********** <--
--> ********** <--


select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00940000',--'TA00060000' --< ref: 12 >--  se comenta este codigo por su homologado
	@i_descripcion		= 'Servicio de emision de un cheque propio de la entidad financiera',
	@i_tarifa		= 2.23 ---Ref54 cambio tarifa -- 2.50

--> Sacar reversos
truncate table ##correccion
truncate table ##datos

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('14', '472', '34', '39')
  and hm_correccion = 'S'

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end


select @cont = 0, @valor = 0

select
    @cont = isnull(count(1), 0),
    @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega is null, cambio Cta. Basica VMT
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('14', '472', '34', '39')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)


--< ref: 5 >--
--< CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  hm_valor
from     cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('14', '472', '34', '39')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

--< SACA DATOS DE LA TABLAS DE AHORROS

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264, 4262,120060) --Ref24 se agrega transacción cta básica VMT
  and hm_causa in ('57', '472', '0')
  and hm_correccion = 'S'

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end


select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(hm_valor), 0) + @valor
from
    cob_ahorros_acum..ah_his_mov_a06  mov
where hm_tipo_tran in (4272, 4264, 4262,120060) --Ref24 se agrega transaccion 120060 cta básica VMT
  and hm_causa in ('57', '472', '0')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)


--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--
--truncate table ##2datos

insert into ##2datos
select count(1),  hm_valor
from     cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262,120060) --Ref24 se agrega trx cta básica VMT
  and hm_causa in ('57', '472', '0')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##2datos, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

--< ref: 6 >--
--< SACA DATOS DE LA TABLAS DE SERVICIOS

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('43')
  and hs_correccion = 'S'

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

select
    @cont = isnull(count(1), 0) + @cont ,
    @valor = isnull(sum(isnull(hs_saldo, 0)), 0) + isnull(sum(isnull(hs_valor, 0)), 0) + @valor
from cob_cuentas_his..cc_his_servicio a (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('43')
  and hs_correccion = 'N'
  and not exists (select 1 from ##correccion where hs_ssn_corr = a.hs_secuencial)


--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--
--truncate table ##2datos

insert into ##2datos
select count(1),  isnull(hs_valor, 0) + isnull(hs_saldo, 0)
from cob_cuentas_his..cc_his_servicio a (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('43')
  and hs_correccion = 'N'
  and not exists (select 1 from ##correccion where hs_ssn_corr = a.hs_secuencial)
  group by hs_valor + hs_saldo

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##2datos, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    round(isnull(@valor,0)/@w_porcIva,2), 0,/*isnull(@valor2, 0)*/
    'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

--< CC0011
--> ********** <--
--> ********** <--
--> TA00240000 <--
--> TA01250000 <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TB01250000',---< ref: 12 > Nuevo codigo de servicio
	@i_descripcion		= 'Generacion y envio de estados de cuenta corrientes a los clientes',
	@i_tarifa       	= 0 ---< ref: 12 >--Colocar la tarifa 0 segun requerimiento

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('325', '21', '8')
  and hm_correccion = 'S'
  and hm_valor = 0.30

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('325', '21', '8')
  and hm_correccion = 'N'
  and hm_valor = 0.30
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

if @@error <> 0
begin
    print 'ERROR AL INSERTAR en table cc_his_movimiento, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
    return 9991
end


--< CC0001

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',/*(case cc_tipocta when 'C' then 'J' else 'N' end),*/ isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
	 'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')

  if @@error <> 0
  begin
      print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
end


--< CC0017 - CC0018
insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'', isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TA00180000 <--
--> TA01250000 <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TB01250000',---< ref: 12 > Nuevo codigo de servicio
	@i_descripcion		= 'Generacion y envio de estados de cuenta corrientes a los clientes',
    	@i_tarifa       	= 0 ---< ref: 12 >--Colocar la tarifa 0 segun requerimiento

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('325', '8', '21') --< ref: 6 >--
  and hm_correccion = 'S'
  and hm_valor <> 0.30  --< ref: 6 >--

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end


insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('325', '8', '21')  --< ref: 6 >--
  and hm_correccion = 'N'
  and hm_valor <> 0.30  --< ref: 6 >--
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end


--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',/*(case cc_tipocta when 'C' then 'J' else 'N' end),*/ isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end


insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017' , @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'', isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte, ##datos
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table cc_detalle_a06, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TD00101007 <--
--> TA00270000 <--
--> ********** <--

--Ref50 Agrega validacion con el nuevo servicio

--< DEBE CORRERSE DESPUES DEL AUTOMATICO >--
--< PARA OBTENER LA CANTIDAD, HAY QUE DIVIDIR EL VALOR TOTAL PARA LA COMISION >--
--< ACTIVACION CHEQUE VOUCHER

select	@i_servicio     	= 'TA00270000' --'TD00101007'   --Ref50 modificar servicio

update cob_super..cc_detalle_a06
set cd_numero_trans = round((cd_ingreso_total / cd_tarifa),0)  --< ref: 12 >--agregar redondeo  round()
where cd_tipo_servicio = @i_servicio
  and cd_fecha_corte = @i_fecha_fin


 if @@error <> 0
   begin
      print 'ERROR AL ACTUALIZAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9996
   end

--> ********** <--
--> ********** <--
--> TA00270000 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TA00270000',
	@i_descripcion		= 'Provision de chequeras para el manejo de cuentas corrientes',
	@i_tarifa		= 0.27 --Ref54 Modificacion Tarifa 0.30

truncate table ##correccion
truncate table ##datos
truncate table ##1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##1datos
select
    hs_cta_banco,
    hs_num_cheques
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3003)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table ##1datos, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3003)
  --and hm_causa in ('12')  --< ref: 5 >--
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3003)
  --and hm_causa in ('12')  --< ref: 5 >--
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0001 - CC0011
--< ref:2 >--
--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - INI >--
select @valor =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
   where hm_fecha >= @i_fecha_ini
     and hm_fecha <= @i_fecha_fin
     and hm_cta_banco = cc_cta_banco
     and hm_oficina >= 0
     and hm_moneda = 1
     and hm_tipo_tran = 3003
     and hm_correccion = 'N'
     and cc_categoria not in ('R')
     and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
     and cc_tipocta = 'P'
     group by (isnull(hm_valor, 0))

select @valor2 =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
      where hm_fecha >= @i_fecha_ini
        and hm_fecha <= @i_fecha_fin
        and hm_cta_banco = cc_cta_banco
        and hm_oficina >= 0
        and hm_moneda = 1
        and hm_tipo_tran = 3003
        and hm_correccion = 'N'
        and cc_categoria not in ('R')
        and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
        and cc_tipocta = 'C'
     group by (isnull(hm_valor, 0))

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - FIN >--


--< ref: 7 >-- Se agraga trx y causa 3050 - 12, 386
truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('12', '386')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('12', '386')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
--< ref: 7 >--

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	(case cc_tipocta when 'C' then 'J' else 'N' end), isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), (case cc_tipocta when 'C' then @valor2 else @valor end),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte  (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0001', (case cc_tipocta when 'C' then 'J' else 'N' end), isnull(sum(isnull(cantidad, 0)),0), null,null  --< ref: 5 >--
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
group by cc_tipocta
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end
--< GAMC - 22FEB2010 - INI
--< SE AGREGA TRANSACCION DE CREDITO HAY QUE RESTAR EL RESULTADO FINAL - TIPO CUENTA NORMAL
set @cont = 0
select
    @cont = isnull(sum(hs_num_cheques), 0)
from cob_cuentas_his..cc_his_servicio, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_cta_banco = cc_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'P'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cantidad, 0) - @cont
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0001'
  and a.cd_tipo_cliente = 'N'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5>--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0001', (case cc_tipocta when 'C' then 'J' else 'N' end), null, round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))-- isnull(sum(isnull(valor, 0)),0)
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		--ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor = 0
select
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte  (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'P'

--< ACTUALIZA LA VALOR DE CHEQUES

update cob_super..cc_detalle_a06
set 	cd_ingreso_total	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
	cd_ingreso_neto   	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
	cd_base_imponible 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
	cd_iva_pagado 		= isnull(iva, 0) - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))		--Ref50
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0001'
  and a.cd_tipo_cliente = 'N'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - FIN


--< GAMC - 22FEB2010 - INI
--< SE AGREGA TRANSACCION DE CREDITO HAY QUE RESTAR EL RESULTADO FINAL - TIPO CUENTA ROL
--< ref: 5 >--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0001', (case cc_tipocta when 'C' then 'J' else 'N' end), isnull(sum(isnull(cantidad, 0)),0), null,null
from cob_cuentas..cc_ctacte  (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

set @cont = 0
select
    @cont = isnull(sum(hs_num_cheques), 0)
from cob_cuentas_his..cc_his_servicio, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_cta_banco = cc_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cantidad, 0) - @cont
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0001'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5>--
--< ref: 5>--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0001', (case cc_tipocta when 'C' then 'J' else 'N' end), null,round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  --Ref50 agrega deflataccion
(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))	-- isnull(sum(isnull(valor, 0)),0)
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select @valor = 0
select
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'

--< ACTUALIZA LA VALOR DE CHEQUES

update cob_super..cc_detalle_a06
set
   cd_ingreso_total = isnull(valor, 0)  - round(isnull(@valor,0)/@w_porcIva,2),					--Ref50
   cd_ingreso_neto = isnull(valor, 0)   - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
   cd_base_imponible = isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
   cd_iva_pagado = isnull(iva, 0) -  (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))			--Ref50
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0001'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'

    if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
     end


--< GAMC - 22FEB2010 - FIN


--< CC0001 - CC0011
--< ref:2 >--
--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - INI >--
select @valor =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
   where hm_fecha >= @i_fecha_ini
     and hm_fecha <= @i_fecha_fin
     and hm_cta_banco = cc_cta_banco
     and hm_oficina >= 0
     and hm_moneda = 1
     and hm_tipo_tran = 3003
     and hm_correccion = 'N'
     and cc_categoria in ('R')
     and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
     and cc_tipocta = 'P'
     group by (isnull(hm_valor, 0))

select @valor2 =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
      where hm_fecha >= @i_fecha_ini
        and hm_fecha <= @i_fecha_fin
        and hm_cta_banco = cc_cta_banco
        and hm_oficina >= 0
        and hm_moneda = 1
        and hm_tipo_tran = 3003
        and hm_correccion = 'N'
        and cc_categoria in ('R')
        and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
        and cc_tipocta = 'C'
     group by (isnull(hm_valor, 0))

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - FIN >--

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0011', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'N', isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), (case cc_tipocta when 'C' then @valor2 else @valor end),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0011', (case cc_tipocta when 'C' then 'J' else 'N' end), isnull(sum(isnull(cantidad, 0)),0), null,null --< ref: 5 >--
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria in ('R')
group by cc_tipocta
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - INI
--< SE AGREGA TRANSACCION DE CREDITO HAY QUE RESTAR EL RESULTADO FINAL - TIPO CUENTA ROL
set @cont = 0
select
    @cont = isnull(sum(hs_num_cheques), 0)
from cob_cuentas_his..cc_his_servicio, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_cta_banco = cc_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3504)
  and cc_categoria in ('R')
  and cc_tipocta = 'P'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cantidad, 0) - @cont
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0011'
  and a.cd_tipo_cliente = 'N'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5>--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0011', (case cc_tipocta when 'C' then 'J' else 'N' end), null,round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  --Ref50 agrage deflatacion,
(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)) -- isnull(sum(isnull(valor, 0)),0)
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria in ('R')
group by cc_tipocta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor = 0
select
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3504)
  and cc_categoria in ('R')
  and cc_tipocta = 'P'

--< ACTUALIZA LA VALOR DE CHEQUES

update cob_super..cc_detalle_a06
set cd_ingreso_total 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),					--Ref50
    cd_ingreso_neto 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
    cd_base_imponible 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),				--Ref50
    cd_iva_pagado 	= isnull(iva, 0) - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))		--Ref50
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0011'
  and a.cd_tipo_cliente = 'N'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - FIN


--< CC0017 - CC0018
--< ref:2 >--
--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - INI >--
select @valor =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
   where hm_fecha >= @i_fecha_ini
     and hm_fecha <= @i_fecha_fin
     and hm_cta_banco = cc_cta_banco
     and hm_oficina >= 0
     and hm_moneda = 1
     and hm_tipo_tran = 3003
     -- and hm_causa in ('12')  --< ref: 5 >--
     and hm_correccion = 'N'
     and cc_categoria not in ('R')
     and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
     and cc_tipo_contable = '4'
     group by (isnull(hm_valor, 0))

select @valor2 =
   sum
   (
     (
       ((isnull(hm_valor, 0)))
       *
       count(1)
     )
     /
     sum(count(1))
   )
   from cob_cuentas_his..cc_his_movimiento mov, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
      where hm_fecha >= @i_fecha_ini
        and hm_fecha <= @i_fecha_fin
        and hm_cta_banco = cc_cta_banco
        and hm_oficina >= 0
        and hm_moneda = 1
        and hm_tipo_tran = 3003
        and hm_correccion = 'N'
        and cc_categoria not in ('R')
        and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
        and cc_tipo_contable = '3'
     group by (isnull(hm_valor, 0))

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - FIN >--


insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total, cd_tasa_ponderada,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
       )

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, (case cc_tipo_contable when '3' then 'CC0017' else 'CC0018' end), @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	(case cc_tipocta when 'C' then 'J' else 'N' end), isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), (case cc_tipo_contable when '3' then @valor2 else @valor end) ,
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')
group by cc_tipocta, cc_tipo_contable

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5 >--
truncate table ##res_1datos

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0017', 'J', isnull(sum(isnull(cantidad, 0)),0), null,null
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable = '3'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - INI
--< SE AGREGA TRANSACCION DE CREDITO HAY QUE RESTAR EL RESULTADO FINAL - TIPO CUENTA ROL
set @cont = 0
select
    @cont = isnull(sum(hs_num_cheques), 0)
from cob_cuentas_his..cc_his_servicio, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_cta_banco = cc_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'
  and cc_tipo_contable = '3'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cantidad, 0) - @cont
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0017'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5>--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0017', 'J', isnull(sum(isnull(cantidad, 0)),0), null,null
from cob_cuentas..cc_ctacte  (index cc_ctacte_Key), ##1datos
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable = '3'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor = 0
select
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'
  and cc_tipo_contable = '3'

--< ACTUALIZA LA VALOR DE CHEQUES

update cob_super..cc_detalle_a06
set    	cd_ingreso_total	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_ingreso_neto 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_base_imponible 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_iva_pagado 		= isnull(iva, 0) -  (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))			--Ref50

from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0017'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5 >--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0018', 'J', isnull(sum(isnull(cantidad, 0)),0), null,null
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable = '4'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - INI
--< SE AGREGA TRANSACCION DE CREDITO HAY QUE RESTAR EL RESULTADO FINAL - TIPO CUENTA ROL
set @cont = 0
select
    @cont = isnull(sum(hs_num_cheques), 0)
from cob_cuentas_his..cc_his_servicio, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_cta_banco = cc_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'
  and cc_tipo_contable = '4'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cantidad, 0) - @cont
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0018'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5>--
truncate table ##res_1datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##res_1datos
select 'CC0018', 'J', isnull(sum(isnull(cantidad, 0)),0), null,null
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##1datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable = '4'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor = 0
select @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3504)
  and cc_categoria not in ('R')
  and cc_tipocta = 'C'
  and cc_tipo_contable = '4'

--< ACTUALIZA LA VALOR DE CHEQUES

update cob_super..cc_detalle_a06
set    	cd_ingreso_total	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_ingreso_neto 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_base_imponible 	= isnull(valor, 0) - round(isnull(@valor,0)/@w_porcIva,2),						--Ref50
   	cd_iva_pagado 		= isnull(iva, 0) -  (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))			--Ref50
from ##res_1datos, cob_super..cc_detalle_a06 a
where a.cd_fecha_corte = @i_fecha_fin
  and a.cd_tipo_servicio = @i_servicio
  and a.cd_canal = @i_canal
  and a.cd_tipo_producto = 'CC0018'
  and a.cd_tipo_cliente = 'J'
  and cliente = a.cd_tipo_cliente
  and categoria = a.cd_tipo_producto
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'				--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TA00350000 <--
--> ********** <--
--> ********** <--

--< ref: 5 >--
--> Modificaciones para obtener los datos de ATM

select
	@i_producto		= 3,
	@i_canal		= 'C',
	@i_servicio     	= 'TA00350000'
/*<REF 63  @i_descripcion		= 'Servicio de retiro de dinero en cajeros automaticos propios de clientes de una entidad de red local',
  @i_tarifa		= 0.50
REF 63>*/	 

/*truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end
*/
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--<REF 63
Exec @w_error = cob_atm..pa_atm_iestructuraA06
	 @e_producto = @i_producto,
	 @e_canal    = @i_canal,
	 @e_servicio =@i_servicio ,
	 @e_porcIva   = @w_porcIva,
	 @e_fecha_ini = @i_fecha_ini,
	 @e_fecha_fin = @i_fecha_fin

 if @@error!= 0 or @w_error!= 0
    begin
      print 'ERROR AL llamar sp pa_atm_iestructuraA06 servicio TA00350000'
      return 9999  --salimos por error
    end
	
--REF 63>

/*<REF 63		 
select @cont = 0, @valor = 0

select @cont = count(1), @valor = sum(hm_monto_4)
from cob_atm..at_his_mov_srv
where hm_fecha_de_conciliacion >= convert(varchar(8), @i_fecha_ini, 112)
and hm_fecha_de_conciliacion <= convert(varchar(8), @i_fecha_fin, 112)
and hm_codigo_de_resultado =  '0000'
and hm_fi_adquirente = '1007'
and hm_tipo_de_mensaje = 'TR'
and hm_fi_emisor <> '1007'
and hm_proceso_destino = '02'
and hm_monto_4 = 0.50


--< NO TIENE PRODUCTO - ES PARA TODOS>--

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(@cont, 0), @i_tarifa,
        round(isnull(@valor,0)/@w_porcIva,2),
        'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

REF 63>*/

--> ********** <--
--> ********** <--
--> TB00230000 <--
--> TB00970000 <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'C',
	@i_servicio     	= 'TB00970000', --< ref: 12 >-- Nuevo codigo de servicio homologado segun Requerimiento
	@i_descripcion		= 'Transaccion fallida',
	@i_tarifa		= 0,
	@i_tipo_producto	= ""


select @cont = count(1)
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_terminal = 'ATMB'
  and hm_correccion = 'S'

select @cont = @cont + count(1)
from cob_ahorros_acum..ah_his_mov_a06
where hm_terminal = 'ATMB'
  and hm_correccion = 'S'


insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton					--Ref50
	)
values(	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, @i_tipo_producto, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	@i_tipo_cliente, isnull(@cont, 0), @i_tarifa, 0,
	'P','09','01'									--Ref50
	)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TB00580000 <--
--> TB00900000 <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TB00900000', --< ref: 12 >-- Colocar nuevo numero homologado segun Requerimiento
	@i_descripcion		= 'Transferencia de fondos solicitada por clientes de la entidad a otra cuenta de la entidad',
	@i_tarifa		= 0

/* REF 70
truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3404, 3405)
  and hm_causa = '01'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3404, 3405)
  and hm_causa = '01'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton   			--Ref50 agregar campos ubicacion
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	isnull(sum(isnull(valor, 0)), 0),'','',''			--Ref50 agregar campos ubicacion
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0017 - CC0018
insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton   			--Ref50 agregar campos ubicacion
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, (case cc_tipo_contable when '3' then 'CC0017' else 'CC0018' end), @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	isnull(sum(isnull(valor, 0)), 0),'','',''			--Ref50 agregar campos ubicacion
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')
group by cc_tipo_contable

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
	@i_producto		= 4

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4405, 4404)
  and hm_causa = '01'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4405, 4404)
  and hm_causa = '01'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton   			--Ref50 agregar campos ubicacion
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	isnull(sum(isnull(valor, 0)), 0),'','',''			--Ref50 agregar campos ubicacion
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K') --in ('R', 'H', 'K')   --Ref50 se comenta la categoria R debido que se lo genera en un solo script

    if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
     end

--< CA0001 - CA0021
 REF 70 */
--< CANAL ATM >--

select	@i_canal	= 'C'

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end
	 

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (16519, 16820)
  and hm_causa = NULL
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (16519, 16820)
  and hm_causa = NULL
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< CC0017 - CC0018
insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, (case cc_tipo_contable when '3' then 'CC0017' else 'CC0018' end), @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')
group by cc_tipo_contable

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select
	@i_producto		= 4

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (16237, 16239)
  and hm_causa is NULL
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (16237, 16239)
  and hm_causa is NULL
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      	cd_ingreso_total,
      	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K')--, 'R')		--Ref50 comentar-se lo realzia en un solo script

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021
 /* REF 70

select	@i_canal = 'O'


truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3519, 3520)
  and hm_causa = NULL
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3519, 3520)
  and hm_causa = NULL
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      	cd_ingreso_total,
      	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0017 - CC0018
insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, (case cc_tipo_contable when '3' then 'CC0017' else 'CC0018' end), @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')
group by cc_tipo_contable

if @@error <> 0
begin
 print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
 return 9991
end

select	@i_producto	= 4

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4237, 4239)
  and hm_causa is NULL
  and hm_correccion = 'S'
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    @i_tarifa
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4237, 4239)
  and hm_causa is NULL
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
     	cd_ingreso_total,
     	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
     	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta
  and ah_categoria not in ('K', 'H') --, 'R')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021
--< Si no hay datos se llenan con cero
REF 70 */
--> ********** <--
--> ********** <--
--> TB00590000 <--
--> TB00950000 <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TB00950000',--< ref: 12 >-- Colocar nuevo numero homologado segun Requerimiento
	@i_descripcion		='Bloqueo, anulacion o cancelacion de tarjetas debito/pago/credito/electronica/prepago', --< ref:37 >-- Modificacion Descripcion
	@i_tarifa		= 0

select @cont = 0

truncate table ##correccion
truncate table ##datos

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050, 3048)
  and hm_causa in ('421', '30')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = count(1)
from cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050, 3048)
  and hm_causa in ('421', '30')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)


truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran = 4272
  and hm_causa in ('22', '330')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = @cont + count(1)
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran = 4272
  and hm_causa in ('22', '330')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)


insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton			--Ref50
	)
values(	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(@cont, 0), @i_tarifa, 0,
	 'P','09','01'							--Ref50
	)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--> ********** <--
--> ********** <--
--> TD00321007 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00321007',
	@i_descripcion		= 'Servicio que se ofrece a los clientes para colocar toda la correspondencia emitida por el banco',
	@i_tarifa		= 30


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3461, 4351, 3188, 3032)     --< ref: 5 >--
  and hs_causa in ('78', '53', '77', '0')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos

select @cont = 0, @valor = 0
select
    @cont = isnull(count(1), 0),
    @valor = sum(isnull(hs_valor, 0))
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3461, 4351, 3188, 3032)     --< ref: 5 >--
  and hs_causa in ('78', '53', '77', '0')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

--< CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3461, 4351, 3188, 3032)
  and hs_causa in ('78', '53', '77', '0')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
group by isnull(hs_valor, 0)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_ahorros_his..ah_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_moneda = 1
  and hs_tipo_transaccion in (4351, 4188) --< ref: 7 >--
  and hs_causa in ('178')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'S'
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(isnull(hs_valor, 0)), 0) + @valor
from cob_ahorros_his..ah_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_moneda = 1
  and hs_tipo_transaccion in (4351, 4188) --< ref: 7 >--
  and hs_causa in ('178')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


--< CALCULO DE TASA PONDERADA >--
--truncate table ##2datos

insert into ##2datos
select count(1),  isnull(hs_valor, 0)
from cob_ahorros_his..ah_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_moneda = 1
  and hs_tipo_transaccion in (4351, 4188) --< ref: 7 >--
  and hs_causa in ('178')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  group by isnull(hs_valor, 0)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor2 =
sum
   (
     (
       valor
       *
       cantidad
     )
     /
     sum(cantidad)
   )
from ##2datos

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    round(isnull(@valor,0)/@w_porcIva,2), isnull(@valor2, 0),
    'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--> ********** <--
--> ********** <--
--> TD00331007 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00331007',
	@i_descripcion		= 'Servicio a todos los clientes que deseen mantener en un locker de seguridad o documentos',
	@i_tarifa		= 89.29 --Ref54 cambio tarifa --100


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3460, 3188)
  and hs_causa in ('78', '52')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
select @cont = 0, @valor = 0
select
    @cont = isnull(count(1), 0),
    @valor = sum(isnull(hs_valor, 0))
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3460, 3188)
  and hs_causa in ('78', '52')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

--< CALCULO DE TASA PONDERADA >--
truncate table ##2datos

insert into ##2datos
select count(1),  isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3460, 3188)
  and hs_causa in ('78', '52')    --< ref: 7 >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
group by isnull(hs_valor, 0)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_ahorros_his..ah_his_servicio (index ah_his_servicio_Key )		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_moneda = 1
  and hs_tipo_transaccion in (4266, 4350, 4188)
  and hs_causa in ('0', '4')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
truncate table ##datos

select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(isnull(hs_valor, 0)), 0) + @valor
from cob_ahorros_his..ah_his_servicio (index ah_his_servicio_Key)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_moneda = 1
  and hs_tipo_transaccion in (4266, 4350, 4188)
  and hs_causa in ('0', '4')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


--< CALCULO DE TASA PONDERADA >--

insert into ##2datos
select count(1),  isnull(hs_valor, 0)
from cob_ahorros_his..ah_his_servicio (index ah_his_servicio_Key)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (4266, 4350, 4188)
  and hs_causa in ('0', '4')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  group by isnull(hs_valor, 0)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    isnull(@valor, 0), 0,--isnull(@valor2, 0)
    'P','09','01',isnull(@valor, 0), isnull(@valor, 0),(round(isnull(@valor, 0) * @w_Iva,2))
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--> ********** <--
--> ********** <--
--> TD00341007 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00341007',
	@i_descripcion		= 'El servicio aplica cuando el cliente solicita observar un video sobre una transaccion especifica',
	@i_tarifa		= 4.46 --Ref54 cambio tarifa --5


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_causa = '51'
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
truncate table ##datos

insert into ##datos
select 	hs_cta_banco, isnull(hs_saldo, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_causa = '51'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hm_causa = '322'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos

insert into ##datos
select 	hm_cta_banco, isnull(hm_valor, 0)
from cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
     and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hm_causa = '322'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4372)
  and hm_causa = '322'
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos

insert into ##datos
select 	hm_cta_banco, isnull(hm_valor, 0)
from cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4372)
  and hm_causa = '322'
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	isnull(sum(isnull(valor, 0)), 0)
from ##datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TD00351007 <--
--> ********** <--
--> ********** <--

--< ref: 5 >--
--> Modificaciones para obtener los datos de ATM

select
	@i_producto		= 3,
	@i_canal		= 'C',
	@i_servicio     	= 'TD00351007'
/*<REF 63  @i_descripcion		= 'Servicio de retiro de dinero a no clientes del Banco, de instituciones financieras del exterior',
  @i_tarifa		= 2
REF 63>*/

--truncate table ##correccion
--<REF 63
Exec @w_error = cob_atm..pa_atm_iestructuraA06
	 @e_producto = @i_producto,
	 @e_canal    = @i_canal,
	 @e_servicio =@i_servicio ,
	 @e_porcIva   = @w_porcIva,
	 @e_fecha_ini = @i_fecha_ini,
	 @e_fecha_fin = @i_fecha_fin

 if @@error!= 0 or @w_error!= 0
    begin
      print 'ERROR AL llamar sp pa_atm_iestructuraA06 servicio TD00351007'
      return 9999  --salimos por error
    end
	
--REF 63>

/*<REF 63 select @cont = 0, @valor = 0

select @cont = count(1), @valor = sum(hm_monto_4)
from cob_atm..at_his_mov_srv
where hm_fecha_de_conciliacion >= convert(varchar(8), @i_fecha_ini, 112)
and hm_fecha_de_conciliacion <= convert(varchar(8), @i_fecha_fin, 112)
and hm_codigo_de_resultado =  '0000'
and hm_fi_adquirente = '1007'
and hm_tipo_de_mensaje = 'TR'
and hm_proceso_destino = '14'
and hm_monto_4 in (1.50, 2.00)

--< NO TIENE PRODUCTO - ES PARA TODOS>--

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(@cont, 0), @i_tarifa,
    round(isnull(@valor,0)/@w_porcIva,2),
    'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end
REF 63>*/

--> ********** <--
--> ********** <--
--> TD00371007 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00371007',
	@i_descripcion		= 'Recaudaciones varias Empresariales',
	@i_tarifa		= 0.89 --Ref54  --1

-- La tarifa se coloca de 1 dolar pero se la cobre 0.50
set @cont = 0, @valor = 0

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)      -- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372) --Ref011:msilvag (3925, 3926, 3927)
    and hs_causa in (select codigo from cobis..cl_catalogo
  		   where tabla in (select codigo  from cobis..cl_tabla
  				   where tabla = 'causas_a06_sv_TD00371007')  --REF20
    		   and estado = 'V')
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE','WAP')--Ref058:msilvag  --Ref011:msilvag --Ref20 MLR incluir user cnb001
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = count(1),@valor = sum(isnull(hs_valor,0)) + sum(isnull(hs_saldo,0))  --Ref011:msilvag * 0.50
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)      -- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372) ----Ref011:msilvag (3925, 3926, 3927)
    and hs_causa in (select codigo from cobis..cl_catalogo
  		   where tabla in (select codigo  from cobis..cl_tabla
  				   where tabla = 'causas_a06_sv_TD00371007')--REF20
    		   and estado = 'V')
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE','WAP')--Ref058:msilvag --Ref011:msilvag --Ref20 MLR incluir user cnb001
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

 --- Cobro de comisión a la empresa utpl
/*<REF 62>*/
/*select @cont =  isnull(@cont,0) + sum(pn_cont_trn), @valor = isnull(@valor,0) +  sum(isnull(hm_valor,0))
from cob_cuentas_his..cc_his_movimiento, cob_pagos..pg_control_ncrecaudacion
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '743'
  and pn_fecha_efec = hm_fecha
  and pn_empresa  = 8090
  and pn_costo_recauda = hm_valor
  */


---smerino belcorp, JPM Megadatos causas: '31' (trx 3366, 3372); '1089' (trx 43473)
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE') --Ref20 MLR incluir user cnb001
  and hs_causa in ('29', '31')            -- JPM Ref.31: incluir causa Megadatos 31
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont2 = count(1), @valor3 = sum(isnull(hs_valor, 0)) + sum(isnull(hs_monto, 0))
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE') --Ref20 MLR incluir user cnb001
  and hs_causa in ('29', '31')            -- JPM Ref.31: incluir causa Megadatos 31
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

 --- Cobro de comisión a la empresa por canal ven

  select @cont4 = sum(hs_cheque), @valor4 = sum(isnull(hs_saldo, 0))                  -- JPM Ref.31: recuperar num.txr por SUM y no COUNT
  from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (43473)
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'WAP', 'SROLESE')        -- JPM Ref.31: Megadatos: incluir WAP
    and hs_causa in ('1089') 
	/*and hs_causa in ('7256', '1089')*/ /*<REF 64>*/


   
 --  ref055 JG ini

 truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (43569)
  --KBastida se agrega condicion para proceso A06 TERCON
  and hs_causa in (select c.codigo from cobis..cl_catalogo c
                                    inner join  cobis..cl_tabla t 
                                       on c.tabla = t.codigo
                                    where c.estado = 'V'  and t.tabla = 'sv_cobro_comision_diaria')
  --and hs_usuario not in ('WAP')  --Ref058:msilvag
  --KBastida
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


  select @cont5=0, @valor5=0

  select @cont5 = (
				select count(1)
				from cob_cuentas_his..cc_his_servicio
				where hs_tsfecha >= @i_fecha_ini
				and hs_tsfecha <= @i_fecha_fin
				and hs_tipo_transaccion = 43569
				and hs_correccion = 'N'
            --Add
            and hs_causa in (select c.codigo from cobis..cl_catalogo c
                                    inner join  cobis..cl_tabla t 
                                       on c.tabla = t.codigo
                                    where c.estado = 'V'  and t.tabla = 'sv_cobro_comision_diaria')   
				--add
            --and hs_usuario not in ('WAP') --Ref058:msilvag
				and hs_secuencial not in (select hs_ssn_corr from ##correccion))
  , @valor5 = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0)
  from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3188)
    and hs_usuario in ('sa')
    and hs_causa in ('778')
	and hs_correccion = 'N'
 --  ref055 JG fin



 --  ref056 JG ini

 truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925, 3926, 3927)
  and hs_causa in ('120')
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


  select @cont6=0, @valor6=0, @i_comision = 0

  select @i_comision  = isnull(pe_costo,0) from cob_pagos..pg_person_empresa where pe_empresa = 120

  select @cont6 = count(1),
		 @valor6 = count(1) * @i_comision
  from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925, 3926, 3927)
    and hs_causa in ('120')
	and hs_correccion = 'N'
	and hs_secuencial not in (select hs_ssn_corr from ##correccion)


 --  ref056 JG fin

  select @cont = isnull(@cont,0)  + isnull(@cont2,0)  + isnull(@cont4, 0)  + isnull(@cont5, 0) + isnull(@cont6, 0),
         @valor= isnull(@valor,0) + isnull(@valor3,0) + isnull(@valor4,0)  + isnull(@valor5,0) + isnull(@valor6,0)-- JPM Ref.31: incluir @cont4  ref055:jg  ref056:jg


---fin smerino belcorp

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
values(	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, @i_tipo_producto, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	@i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor,0)/@w_porcIva,2),
	'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50
	)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

-->Ref20 MLR Servicio Privado Belcorp` canal CNB
set @i_producto     = 3,
    @i_canal        = 'N',
    @i_servicio     = 'TD00371007',
    @i_descripcion  = 'Recaudaciones varias Empresariales',
    @i_tarifa       = 0.89, --Ref54 cambio tarifa --,
    @cont           = 0,
    @valor          = 0

truncate table ##correccion

insert into ##correccion
    select hs_ssn_corr
      from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
     where hs_tsfecha >= @i_fecha_ini
       and hs_tsfecha <= @i_fecha_fin
       and hs_oficina >= 0
       and hs_moneda = 1
       and hs_tipo_transaccion in (3366, 3372)--,3050,4272)
       and hs_usuario = 'cnb001'
       and hs_causa = '29'--,'572','148')
       and hs_correccion = 'S'

if @@error<>0
  begin
    print 'ERROR AL INSERTAR TRX DE CORRECCION EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end

select @cont = count(1), @valor = sum(isnull(hs_valor, 0))
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)--,3050,4272)
  and hs_usuario = 'cnb001'
  and hs_causa  = '29'--,'572','148')
  and hs_correccion = 'N'
  and hs_valor > 0  -- Solo pagos en efectivo
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


if @valor2 > 0 --requiere que al final del cálculo de la tarifa promedio ponderada se realice la deflactación considerando el parámetro de IVA
  begin
    -- Se obtiene el % del IVA
    select @w_porcIva = pa_float + 1
      from cobis..cl_parametro
     where pa_producto = 'CTE'
       and pa_nemonico = 'IVA'
    --
    set @valor2 = @valor2 / isnull(@w_porcIva,1)
  end

insert into cob_super..cc_detalle_a06
    (cd_producto,       cd_fecha_corte,     cd_canal,
     cd_tipo_servicio,  cd_tipo_producto,   cd_descripcion,
     cd_tipo_tarjeta,   cd_clase_tarjeta,   cd_tipo_tarifa,
     cd_tipo_cliente,   cd_numero_trans,    cd_tarifa,
     cd_ingreso_total,  cd_tasa_ponderada,
     cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
     )
values
    (@i_producto,       @i_fecha_fin,       @i_canal,
     @i_servicio,       @i_tipo_producto,   @i_descripcion,
     null,              null,               substring(@i_servicio, 1, 2),
    @i_tipo_cliente,    isnull(@cont, 0),   @i_tarifa ,
    round(isnull(@valor,0)/@w_porcIva,2),  0,--@valor2,
    'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50
    )
if @@error<>0
  begin
    print 'ERROR AL INSERTAR DETALLE A06 EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end
--<--Fin Ref20
-- JPM Ref.31 -->
select
  @i_producto   = 3,
  @i_canal    = 'I',
  @i_servicio       = 'TD00371007',
  @i_descripcion    = 'Recaudaciones varias Empresariales',
  @i_tarifa   = 0.89 --Ref54 cambio tarifa 1

-- La tarifa se coloca de 1 dolar pero se la cobre 0.50
set @cont = 0, @valor = 0

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
  and hs_causa = '31'
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont2 = count(1), @valor3 = sum(isnull(hs_valor, 0)) + sum(isnull(hs_monto, 0))
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
  and hs_causa = '31'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

 --- Cobro de comisión a la empresa por canal internet
  select @cont4 = sum(hs_cheque), @valor4 = sum(isnull(hs_monto, 0))
  from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (43473)
    and hs_usuario in ('ope998', 'srolese', 'SAT', 'WAP', 'SROLESE')
    and hs_causa = '1089'

  select @cont= isnull(@cont,0) + isnull(@cont2,0) + isnull(@cont4, 0), @valor= isnull(@valor,0) + isnull(@valor3,0) + isnull(@valor4,0)

insert into cob_super..cc_detalle_a06
  (cd_producto, cd_fecha_corte, cd_canal,
  cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
  cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
  cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
  cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado			--Ref50 agregar campos
  )
values( @i_producto, @i_fecha_fin, @i_canal,
  @i_servicio, @i_tipo_producto, @i_descripcion,
  null, null, substring(@i_servicio, 1, 2),
  @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor,0) /@w_porcIva,2),
  '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2),isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2) --Ref50 agregar campos
  )

if @@error<>0
  begin
    print 'ERROR AL INSERTAR DETALLE A06 EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end
-- <-- JPM Ref.31



-- Ref35 pricaura debitos automaticos primax -->
select
  @i_producto   = 3,
  @i_canal    = 'O',
  @i_servicio       = 'TD00371007',
  @i_descripcion    = 'Recaudaciones varias Empresariales',
  @i_tarifa	    = 0.89 --Ref54 cambio tarifa -- 0.63

set @cont = 0, @valor = 0

--Si se realiza el debito por comision a Primax entonces se reporta los valores bajo el servicio respectivo
select @cont =  isnull(@cont,0) + sum(pn_cont_trn), @valor = isnull(@valor,0) +  sum(isnull(hm_valor,0))
from cob_cuentas_his..cc_his_movimiento, cob_pagos..pg_control_ncrecaudacion
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050 and hm_causa = '717'
  and pn_fecha_efec = hm_fecha
  and pn_empresa  = 8688
  and pn_costo_recauda = hm_valor
if @@error<>0
  begin
    print 'ERROR AL CONSULTAR PAGO DE LC PRIMAX. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end

  select @i_tipo_producto='CC0001'

insert into cob_super..cc_detalle_a06
  (cd_producto, cd_fecha_corte, cd_canal,
  cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
  cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
  cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
  cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
  )
values( @i_producto, @i_fecha_fin, @i_canal,
  @i_servicio, @i_tipo_producto, @i_descripcion,
  null, null, substring(@i_servicio, 1, 2),
  @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor,0)/@w_porcIva,2),
  'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50
  )

if @@error<>0
  begin
    print 'ERROR AL INSERTAR DETALLE A06 EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end
-- <-- Ref35 pricaura


--> ********** <--
--> ********** <--
--> TD00381007 <--
--> ********** <--
--> ********** <--

--> SAT

/*********************************REF21: Inicio LBP*********************************/

select
    @i_producto	        = 12,
    @i_canal            = 'I',
    @i_servicio         = 'TD00371007',
    @i_descripcion      = 'Recaudaciones varias Empresariales',
    @i_tarifa	        = 0.89 --Ref54 cambio tarifa --

declare @tarifa_pond money
select @cont = 0, @valor = 0, @tarifa_pond = 0

create table ##tmp_tran_monet (ssn_corr        int     null)

insert into ##tmp_tran_monet  (ssn_corr)
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and hm_tipo_tran in (3288,3289,3040,3553)
and hm_correccion = 'S'
and hm_sec_correccion <> null
if @@error <> 0
begin
   exec cobis..sp_cerror
   @i_msg    = 'ERROR AL INSERTAR EN TABLA TEMPORAL',
   @i_num    = 300003377
   return 300003377
end

select @cont = count(1) --Obtengo Cantidad de Transacciones de Empresas SAT con REE que se registra en Cuentas
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini	and hm_fecha <= @i_fecha_fin
and hm_tipo_tran in (3288,3289,3040,3553)
and hm_correccion = 'N'
and hm_causa in (select a.codigo
                 from cobis..cl_catalogo a,cobis..cl_tabla b
                 where b.tabla = 'cc_emp_com_diaria'
                 and   b.codigo = a.tabla and a.estado = 'V')
and not exists (select 1 from ##tmp_tran_monet where ssn_corr=cob_cuentas_his..cc_his_movimiento.hm_secuencial)
and not exists (select 1 from db_biz_admempresa..ba_catalogo, cob_pagos..pg_relacion_empresa_sat
  			where ct_cod_tabla = (select tb_cod_tabla
  					      from db_biz_admempresa..ba_tabla
  					      where tb_nom_tabla ='ad_emp_dep_especial')
  			and ct_est_catalogo = 'A'
  			and es_empresa_sat= convert(int,ct_otro_campo_catalogo)
                        --<REF 34
  			and isnumeric(ct_otro_campo_catalogo) = 1
                        --REF 34>
  			and es_empresa =convert(int,cob_cuentas_his..cc_his_movimiento.hm_causa)
  			and isnumeric(es_empresa) = 1
               )

create table ##tmp_tran_monet_cta (cuenta        varchar(20)     null)

insert into ##tmp_tran_monet_cta -- Obtengo las cuentas a las que se van a acreditar las comisiones
select hm_cta_banco
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and hm_tipo_tran in (3288,3289,3040,3553)
and hm_correccion = 'N'
and hm_causa in (select a.codigo
                 from cobis..cl_catalogo a,cobis..cl_tabla b
                 where b.tabla = 'cc_emp_com_diaria'
                 and   b.codigo = a.tabla and a.estado = 'V')
and not exists (select 1 from ##tmp_tran_monet where ssn_corr=cob_cuentas_his..cc_his_movimiento.hm_secuencial)
and not exists (select 1 from db_biz_admempresa..ba_catalogo, cob_pagos..pg_relacion_empresa_sat
  			where ct_cod_tabla = (select tb_cod_tabla
  					      from db_biz_admempresa..ba_tabla
  					      where tb_nom_tabla ='ad_emp_dep_especial')
  			and ct_est_catalogo = 'A'
  			and es_empresa_sat= convert(int,ct_otro_campo_catalogo)
                        --<REF 34
  			and isnumeric(ct_otro_campo_catalogo) = 1
                        --REF 34>
  			and es_empresa =convert(int,cob_cuentas_his..cc_his_movimiento.hm_causa)
  			and isnumeric(es_empresa) = 1
  		     )
group by hm_cta_banco
if @@error <> 0
begin
   exec cobis..sp_cerror
   @i_msg    = 'ERROR AL INSERTAR EN TABLA TEMPORAL',
   @i_num    = 300003377
   return 300003377
end

select @valor = sum(hm_valor) -- Obtengo el valor total de las comisiones para cuadrar con las del SAT
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini	and hm_fecha <= @i_fecha_fin
and hm_tipo_tran in (3050) --Transaccion con que se registra cobro comision de SAT en Cuentas
and hm_causa in ('288') --Causal con que se registra cobro comision de SAT en Cuentas
and hm_correccion = 'N'
and not exists (select 1 from ##tmp_tran_monet where ssn_corr=cob_cuentas_his..cc_his_movimiento.hm_secuencial)
and exists (select 1 from ##tmp_tran_monet_cta where cuenta = cob_cuentas_his..cc_his_movimiento.hm_cta_banco)
and hm_usuario = 'sa' and hm_terminal = 'consola' --Usuario y Terminal con la que siempre se registra cobro comision de SAT en Cuentas
order by hm_hora

select @tarifa_pond = isnull(isnull(@valor, 0) / NULLIF(isnull(@cont, 0),0),0) -- Obtengo Tarifa Ponderada en caso que existan transacciones en SAT


insert into cob_super..cc_detalle_a06
     (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tasa_ponderada, cd_ingreso_total,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado
      )
values (@i_producto, @i_fecha_fin, @i_canal,
      @i_servicio, null, @i_descripcion,
      null, null, substring(@i_servicio, 1, 2),
      null, isnull(@cont, 0), isnull(@tarifa_pond,0), round((isnull(@valor ,0))/@w_porcIva,2),
      '','','',round((isnull(@valor ,0))/@w_porcIva,2),round((isnull(@valor ,0))/@w_porcIva,2),(isnull(@valor ,0))- round((isnull(@valor ,0))/@w_porcIva,2)  --Ref50 base imponible,neto e iva pagado
      )
if @@error <> 0
begin
    exec cobis..sp_cerror
    @i_msg     = 'ERROR AL INSERTAR TD00371007 861',
    @i_num     = 99999
    return 99999
end
--end

-- JPM Ref.31: Megadatos -->
-- Seccion 1: obtencion de las comisiones cobradas el <<cliente>> (valor comision > 0)
 truncate table ##correccion
 insert into ##correccion
 select hs_ssn_corr
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
   and hs_tsfecha <= @i_fecha_fin
   and hs_oficina >= 0
   and hs_moneda = 1
   and hs_tipo_transaccion in (3925, 3926, 3927) and hs_causa = '1089'   -- por comision en pago empresa
   and hs_correccion = 'S'
union
 select hs_ssn_corr
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
   and hs_tsfecha <= @i_fecha_fin
   and hs_oficina >= 0
   and hs_moneda = 1
   and hs_tipo_transaccion in (3366, 3372) and hs_causa = '31'
   and hs_correccion = 'S'
union
 select hs_ssn_corr
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
   and hs_tsfecha <= @i_fecha_fin
   and hs_oficina >= 0
   and hs_moneda = 1
   and hs_tipo_transaccion in (3188) and hs_causa = '725'
   and hs_correccion = 'S'

-- formato de query que permite: - contabilizar las transacciones de "comsion" (aunque hayan sido 0), en base a las recaudaciones,
--                               - sumarizar los montos de comision (solo validos)
-- Q:    contabiliza las comisiones (trx recaudacion) por reportarse al A06
-- SubQ: totaliza los montos comisiones por reportarse al A06
 select secuencial = hs_secuencial,
        canal     = case when hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE')
                                then 'O'
                         when hs_usuario in ('cnb001')
                                then 'N'
                         when hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
                                then 'I'
                         when hs_usuario in ('WAP')
                                then 'M'
                    end,
        tipo_cta  = case hs_tipocta when 'A' then 4 when 'C' then 3 end,
        cta_banco = hs_cta_banco,
        cont      = 1,                        -- contar solo por trx recaudacion
        valor     = isnull((select isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0)      -- sumar montos por trx comision
                             from cob_cuentas_his..cc_his_servicio b
                             where a.hs_tsfecha = b.hs_tsfecha
                               and a.hs_oficina = b.hs_oficina
                               and a.hs_moneda = b.hs_moneda
                               and ((b.hs_tipo_transaccion in (3366, 3372) and hs_causa = '31')
                                 or (b.hs_tipo_transaccion = 3188 and hs_causa = '725'))
                               and a.hs_secuencial = b.hs_secuencial)
                           , 0)
   into #trx_mdt
 from cob_cuentas_his..cc_his_servicio a
 where hs_tsfecha >= @i_fecha_ini
   and hs_tsfecha <= @i_fecha_fin
   and hs_oficina >= 0
   and hs_moneda = 1
   and hs_tipo_transaccion in (3925, 3926, 3927) and hs_causa = '1089'
   and hs_correccion = 'N'
   and not exists(select 1 from ##correccion where a.hs_secuencial = hs_ssn_corr)

 select
   @i_tipo_producto = null,
   @i_servicio      = 'TD00371007',
   @i_descripcion   = 'Recaudaciones varias Empresariales',
      @i_tarifa	    = 0.89 --Ref54 cambio tarifa --1

 -- Q1: comisiones x vent no cobra por deb.cta: <<sin producto>>
 -- Q2: comisiones x deb cta aho: <<producto depende de la categoria. Canal Interner, Mobil>>
 insert into cob_super..cc_detalle_a06
        (cd_producto, cd_fecha_corte, cd_canal,
         cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
         cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
         cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total, cd_tasa_ponderada)
 select tipo_cta, @i_fecha_fin, canal,                                                    -- Grupo1: Producto default
        @i_servicio, null, @i_descripcion,
        null, null, substring(@i_servicio, 1, 2),
        null, sum(cont), @i_tarifa,
        valor,
        ponderado = isnull(valor, 0) * count(1)/sum(count(1))
  from #trx_mdt
  where canal = 'O'
    and valor > 0
  group by tipo_cta, canal, valor
UNION
  select tipo_cta, @i_fecha_fin, canal,                                               -- Grupo2: Productos Ahorros
         @i_servicio, case when ah_categoria not in ('H', 'K', 'R')
                                      then 'CA0001'
                                    when ah_categoria in ('H', 'K')
                                      then 'CA0007'
                                    when ah_categoria = 'R'
                                      then 'CA0021'
                                    when ah_tipocta = 'C'
                                      then 'CA0005'
                      end, @i_descripcion,
        null, null, substring(@i_servicio, 1, 2),
        null, sum(cont), @i_tarifa, isnull(sum(valor), 0), null    -- ahorros no considera tasa ponderada
  from #trx_mdt
       inner join cob_ahorros..ah_cuenta on cta_banco = ah_cta_banco
  where tipo_cta = 4
    and canal in ('I', 'M')
    and valor > 0
   group by tipo_cta, canal,
	case when ah_categoria not in ('H', 'K', 'R')
                                      then 'CA0001'
                                    when ah_categoria in ('H', 'K')
                                      then 'CA0007'
                                    when ah_categoria = 'R'
                                      then 'CA0021'
                                    when ah_tipocta = 'C'
                                      then 'CA0005'
                      end

 -- Q3: comisiones x deb cta cte Roles, Sector Financiero, Publico: <<producto depende de categoria/tipo_contable. Canal Interner, Mobil>>
 -- Q4: comisiones x deb cta cte normal: <<producto unico. Canal Interner, Mobil>>
 -- aplican tasa ponderada --
  --select @i_tarifa = 2
 insert into cob_super..cc_detalle_a06
        (cd_producto, cd_fecha_corte, cd_canal,
         cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
         cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
         cd_tipo_cliente, cd_numero_trans, cd_tarifa,
         cd_ingreso_total, cd_tasa_ponderada)
  select tipo_cta, @i_fecha_fin, canal,  -- 'R' ?                                     -- Grupo3: Producto Corrientes, categorizado
         @i_servicio, case when cc_categoria in ('R')
                               then 'CC0011'
                           when cc_categoria not in ('R') and cc_tipo_contable = '3'
                               then 'CC0017'
                           when cc_categoria not in ('R') and cc_tipo_contable = '4'
                               then 'CC0018'
                      end, @i_descripcion,
         null, null, substring(@i_servicio, 1, 2),
         (case cc_tipocta when 'C' then 'J' else 'N' end),
                    isnull(sum(cont), 0), @i_tarifa,
         isnull(valor, 0),
         ponderado = isnull(valor, 0) * count(1)/sum(count(1))
   from #trx_mdt
       inner join cob_cuentas..cc_ctacte on cta_banco = cc_cta_banco
   and (cc_categoria in ('R') or
        (cc_categoria not in ('R') and cc_tipo_contable in ('3', '4'))
       )
   where tipo_cta = 3
     and canal in ('I', 'M')
     and valor > 0
   group by tipo_cta, canal,
            case when cc_categoria in ('R')
                     then 'CC0011'
                 when cc_categoria not in ('R') and cc_tipo_contable = '3'
                     then 'CC0017'
                 when cc_categoria not in ('R') and cc_tipo_contable = '4'
                     then 'CC0018'
            end,
            (case cc_tipocta when 'C' then 'J' else 'N' end), valor
  union
   select tipo_cta, @i_fecha_fin, canal,                                              -- Grupo4: Producto Corrientes no categorizado
          @i_servicio, 'CC0001', @i_descripcion,
          null, null, substring(@i_servicio, 1, 2),
          (case cc_tipocta when 'C' then 'J' else 'N' end),
                isnull(sum(cont), 0), @i_tarifa,
          isnull(valor,0),
          ponderado = isnull(valor, 0) * count(1)/sum(count(1))
   from #trx_mdt
        inner join cob_cuentas..cc_ctacte on cta_banco = cc_cta_banco
   where tipo_cta = 3
     and canal in ('I', 'M')
     and valor > 0
   group by tipo_cta, canal, (case cc_tipocta when 'C' then 'J' else 'N' end), valor
-- <-- JPM Ref.31: Megadatos

/*********************************REF21: Fin LBP*********************************/
----------------------------------------------------------------------------------
--<Ref38 MLR Comisiones en Efectivo / Cheque SAT
select
        @i_producto             = 12,
        @i_canal                = 'O',
        @i_servicio             = 'TA01610000',
        @i_descripcion          = 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas',
        @i_tarifa               = 0.51,--Ref54 modifica tarifa --0.54,
        @i_tipo_producto        = null

set @cont = 0, @valor = 0

    -- Se obtiene el % del IVA
    select @w_porcIva = pa_float + 1
      from cobis..cl_parametro
     where pa_producto = 'CTE'
       and pa_nemonico = 'IVA'

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
    and hs_causa in (select c.codigo
                       from cobis..cl_tabla t, cobis..cl_catalogo c
                      where t.codigo = c.tabla
                        and t.tabla = 'sat_causas_comision_efechq'
                        and c.estado = 'V')
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE','WAP') --Ref058:msilvag
  and hs_correccion = 'S'
  and hs_monto = 0 -- Solo comisiones cobradas en efectivo o chque
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = count(1),@valor = sum(isnull(hs_valor,0)) + sum(isnull(hs_saldo,0))
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in (select c.codigo
                       from cobis..cl_tabla t, cobis..cl_catalogo c
                      where t.codigo = c.tabla
                        and t.tabla = 'sat_causas_comision_efechq'
                        and c.estado = 'V')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001', 'SROLESE','WAP') --Ref058:msilvag
  and hs_correccion = 'N'
  and hs_monto = 0
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
            'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end


--Fin ref38>
----------------------------------------------------------------------------------

--> ********** <--
--> ********** <--
--> TD00421007 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01610000', --'TD00421007', --Ref19 Homologacion del codigo de servicio
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas',	---< ref:37 >--Nueva descripcion por cambio de codigo de servicio
	@i_tarifa		= 0.51, --Ref54 Modifca tarfia 0.54, --0.50 Ref19 cambio de tarifa por servicio homologado
	@i_tipo_producto    	= null, --Ref19
    	@i_tipo_cliente     	= null  --Ref19

-- INI REF 39 Se obtiene el % del IVA
select @w_porcIva = isnull(pa_float,0) + 1
from cobis..cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'IVA'
-- FIN REF 39

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa = '3'
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = count(1), @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0) + isnull(sum(hs_monto), 0) /*<REF 71>*/
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa = '3'
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
   and hs_terminal <> 'ATMB'  --ref 45


insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
	)
values(	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, @i_tipo_producto, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	@i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),0, --@valor2,
	'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))   --Ref50 campos valores
	)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

-- JPM TRB IWS -->
-- CANAL OFICINA
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372, 3497)
  and hs_causa in ('38')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

if @@error<>0
  return 9999

-- contar trx a partir de las trx servicio recaudacion (tengan o no comision)
-- sumarizar comision solo de trx con valor de comision
select @cont  = sum(case when hs_tipo_transaccion in (3925, 3926, 3927) then 1 else  0 end),
       @valor = sum(case when hs_tipo_transaccion in (3366, 3372) then isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0) else  0 end)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and ((hs_tipo_transaccion in (3925, 3926, 3927) and hs_causa = '8269')
    or (hs_tipo_transaccion in (3366, 3372) and hs_causa = '38'))
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'  --ref 45


   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
    	   'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))   --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end
--end
-------

-- <-- JPM TRB IWS

--Ref036:msilvag Inicio

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('24','40','9','46','16') --Ref043:msilvag --Ref042:msilvag
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')  --REF34 se excluye usuario CNB Y WAP ya que su canal es N y M
  and hs_correccion = 'S'
   and hs_terminal not in ('ATMB', 'MOVIL') --Ref058:msilvag --ref 45

if @@error<>0
    return 9999

insert into ##correccion
select hs_secuencial
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
and hs_tsfecha <= @i_fecha_fin
and hs_oficina >= 0
and hs_moneda = 1
and hs_tipo_transaccion in (3366,3372)
and hs_causa in ('24','40','9','46','16') --Ref043:msilvag --Ref042:msilvag
and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')  --REF34 se excluye usuario CNB Y WAP ya que su canal es N y M
and hs_monto > 0
and hs_terminal not in ('ATMB', 'MOVIL') --Ref058:msilvag   --ref 45

if @@error<>0
    return 9999

select @cont = count(1), @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('24','40','9','46','16') --Ref043:msilvag --Ref042:msilvag
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')  --REF34 se excluye usuario CNB Y WAP ya que su canal es N y M
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal not in ('ATMB', 'MOVIL') --Ref058:msilvag   --ref 45

---Ref50 agrega validacion de existencia


   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
	    'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))   --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end
--end


-- JPM CS -->

--- ini REF 40  cnt movil
truncate table ##correccion

insert into ##correccion

select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366,3372,43548)
  and hs_causa in ('43','182')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error<>0
  return 9999

select @cont  = sum(case when hs_tipo_transaccion in (3366, 3372) then 0 else  1 end),
       @valor = isnull(sum(case when hs_tipo_transaccion in (3366, 3372) then round((isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0))/@w_porcIva,2) else  0 end),0)
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
and hs_tipo_transaccion in (3366,3372,43548)
  and hs_causa in ('43','182')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error<>0
    return 9999

--sumar los valores al servicio
    insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
	    'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))   --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end

--- fin REF 40  cnt movil

-- CANAL OFICINA

--<REF 34
create table #tmp_catalogo
(
codigo_cat	int	null
)

insert into #tmp_catalogo (codigo_cat)
select convert(int,c.codigo)
from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla
where t.tabla='pg_reca_tran_meer_a06'
and isnumeric(c.codigo) = 1
--REF 34>


truncate table ##correccion

insert into ##correccion

--ref29 inicio
---SE CUENTAN TODAS LAS TRANSACCIONES Y SE SUMAN SOLO LAS QUE TENGAN comisión

select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  --<REF 34
  and hs_tipo_transaccion in (select codigo_cat from #tmp_catalogo)
  --REF 34>
  and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
                or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))  --REF: 33
	)
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')--se excluye usuario CNB ya que su canal es N
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45


  if @@error<>0
  return 9999
-->RECORDAR QUE LAS COMISIONES QUE FUERON PAGADAS POR DEBITO A CUENTA , SON EXTRAIDAS POR EL A06 AUTOMATICO, EN EL A06 AUTOMATICO SE PARAMETRIZA
-->LA CAUSA DE LA COMISION

-->ref46 inicio-->PARA CONTAR LAS TRANSACCIONES QUE NO TENGAN COMISION, AQUI NO IMPORTA EL VALOR, PORQUE EL VALOR SOLO SE CONSIDERA CUANDO HAY COMISION
  select @cont = isnull(sum(count(1)),0)
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (SELECT codigo_cat FROM #tmp_catalogo)
    and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
                or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))  --REF: 33
        )
    and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')--se excluye usuario CNB ya que su canal es N
    and hs_correccion = 'N'
    and hs_terminal <> 'ATMB'
    and hs_causa <> '3' /*<REF 71>*/
    and hs_secuencial not in (select hs_ssn_corr from ##correccion)
    GROUP BY hs_secuencial having count (1)=1-->CUANDO UNA transacción NO TIENE comisión SOLO SE GENERA UN REGISTRO.
-->ref46 fin

-->PARA CONTAR LAS TRANSACCIONES QUE TIENEN COMISION QUE FUE PAGADA EN EFECTIVO hs_valor > 0
select @cont  = @cont + isnull(count(1),0),
       @valor = isnull(sum(round((isnull(hs_valor, 0)+ isnull(hs_saldo, 0)+ isnull(hs_monto, 0))/@w_porcIva,2)),0)-->ref45 se solicita deflactar iva
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
   --<REF 34
  and hs_tipo_transaccion in (select codigo_cat from #tmp_catalogo)
  --REF 34>
  and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
               or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))   --REF: 33
      )
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')--se excluye usuario CNB ya que su canal es N
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'   --ref 45
  and hs_tipo_transaccion in(3366,3372) --ref46
  and hs_causa <> '3' /*<REF 71>*/
  and hs_valor > 0--ref46
   
--ref29 fin

--ref46 inicio
 -->PARA CONTAR LAS TRANSACCIONES QUE TIENEN COMISION QUE FUE PAGADA EN CHEQUE hs_saldo > 0
select @cont  = @cont + isnull(count(1),0),
       @valor = @valor+ isnull(sum(round((isnull(hs_valor, 0)+ isnull(hs_saldo, 0)+ isnull(hs_monto, 0))/@w_porcIva,2)),0)-->ref45 se solicita deflactar iva
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
               or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))   --REF: 33
	)
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cnb001','WAP', 'SROLESE')--se excluye usuario CNB ya que su canal es N
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'
  and hs_tipo_transaccion in(3366,3372)
  and hs_causa <> '3' /*<REF 71>*/
  and hs_saldo > 0
--ref46 fin


--  CALCULO DE TASA PONDERADA >--
	insert into cob_super..cc_detalle_a06
	      (cd_producto, cd_fecha_corte, cd_canal,
	       cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	       cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	       cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
	       cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
	       )

	values (@i_producto, @i_fecha_fin, @i_canal,
	      @i_servicio, @i_tipo_producto, @i_descripcion,
	      null, null, substring(@i_servicio, 1, 2),
	      @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
	    'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))   --Ref50 campos valores
	      )
	if @@error <> 0
	begin
	  exec cobis..sp_cerror
	    @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
	    @i_num     = 99999
	  return 99999
	end


-- 2 CANAL INTERNET
select @i_canal    = 'I' ,
       @i_tarifa   = 0.27, --Ref54 Modifca tarfia 0.31,    	    --< Ref:37 >-- Se agrega la nueva tarifa para canal I
       @i_tipo_producto	 = null     --< Ref:37 >-- Se agrega la nueva tarifa para canal I

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1

--ref32 inicio

  --<REF 34
  and hs_tipo_transaccion in (select codigo_cat from #tmp_catalogo)
  --REF 34>
  and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
               or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))  --REF: 33
	)
--ref32 fin
  and hs_usuario in ('srolese', 'SAT', 'SROLESE')--ref45 se excluye 'ope998'
  and hs_correccion = 'S'
if @@error<>0
  return 9999

--********************ref32 inicio

---CONTAR TODAS LAS TRANSACCIONES, TENGAN O NO comisión Y SUMAR MONETARIAMENTE SOLO LAS TRANSACCIONES QUE TENGAN comisión
select @cont  = isnull(sum(case when hs_tipo_transaccion in (3366, 3372) then 0 else  1 end),0),--ref46,
       @valor = round(isnull(sum(case when hs_tipo_transaccion in (3366, 3372) then isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0) else  0 end),0)/@w_porcIva,2)
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  --<REF 34
  and hs_tipo_transaccion in (select codigo_cat from #tmp_catalogo)
  --REF 34>
  and (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='pg_reca_emp_elect_meer' and c.codigo=s.hs_causa)
               or    (exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla where t.tabla='cl_servicios_reportar'  and c.codigo=s.hs_causa))   --REF: 33
	)
  and hs_usuario in ( 'srolese', 'SAT', 'SROLESE')--ref45 se excluye 'ope998'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

--********************ref32 fin

--  CALCULO DE TASA PONDERADA >--
select @valor2 =
sum
   (
     (
       ((isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0) ))
       *
       count(1)
     )
     /
     sum(count(1))
   )
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366) --3916
  and hs_causa in ('6')
  and hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  group by isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0)

---< Ref:37 >--- Validacion creacion registro
if exists (select 1 from cob_super..cc_detalle_a06 where cd_fecha_corte = @i_fecha_fin and cd_tipo_servicio = @i_servicio
								and cd_canal = @i_canal
								and cd_tipo_producto = @i_tipo_producto
								and cd_tipo_cliente = @i_tipo_cliente)
begin
  Update cob_super..cc_detalle_a06
  Set  cd_numero_trans	= cd_numero_trans + isnull(@cont, 0),
       cd_ingreso_total   = cd_ingreso_total   + round((isnull(@valor ,0))/@w_porcIva,2),
       cd_ingreso_neto    = cd_ingreso_neto    + round((isnull(@valor ,0))/@w_porcIva,2),			--Ref50 ingeso neto
       cd_base_imponible  = cd_base_imponible  + round((isnull(@valor ,0))/@w_porcIva,2),			--Ref50 base imponible
       cd_iva_pagado      = cd_iva_pagado      + isnull(@valor,0) - round((isnull(@valor,0))/@w_porcIva,2)  	--Ref50 Iva pagado neto
  Where
  cd_canal		= @i_canal		and
  cd_tipo_producto	= @i_tipo_producto 	and
  cd_tipo_servicio 	= @i_servicio		and
  cd_fecha_corte 	= @i_fecha_fin

  if @@error<>0
  return 9999
 end
else
begin


--insertar los valores al servicio
insert into cob_super..cc_detalle_a06
  (cd_producto, cd_fecha_corte, cd_canal,
  cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
  cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
  cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total, cd_tasa_ponderada,
  cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
  )

values( @i_producto, @i_fecha_fin, @i_canal,
  @i_servicio, @i_tipo_producto, @i_descripcion,
  null, null, substring(@i_servicio, 1, 2),
  @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2), @valor2,
  '','','',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)
  )
 if @@error<>0
   return 9999
end

--Ref042:msilvag Inicio
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925,3926,3927)
  and hs_causa in (select c.codigo from cobis..cl_catalogo c inner join cobis..cl_tabla t
                        on c.tabla = t.codigo
                    where t.tabla = 'sv_tvcable_locali_emp'
                    and c.estado = 'V')
  and hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
  and hs_correccion = 'S'
  and isnull(hs_autoriz_aut, '0.00') = '0.00'
if @@error<>0
    return 9999


select @cont = count(1), @valor = 0
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925,3926,3927)
  and hs_causa in (select c.codigo from cobis..cl_catalogo c inner join cobis..cl_tabla t
                          on c.tabla = t.codigo
                      where t.tabla = 'sv_tvcable_locali_emp'
                      and c.estado = 'V')
  and hs_usuario in ('ope998', 'srolese', 'SAT', 'SROLESE')
  and hs_correccion = 'N'
  and isnull(hs_autoriz_aut, '0.00') = '0.00'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


Update cob_super..cc_detalle_a06
  Set  cd_numero_trans    = cd_numero_trans + isnull(@cont, 0),
       cd_ingreso_total   = cd_ingreso_total   + round((isnull(@valor ,0))/@w_porcIva,2),
       cd_ingreso_neto    = cd_ingreso_neto    + round((isnull(@valor ,0))/@w_porcIva,2),			--Ref50 ingeso neto
       cd_base_imponible  = cd_base_imponible  + round((isnull(@valor ,0))/@w_porcIva,2),			--Ref50 base imponible
       cd_iva_pagado      = cd_iva_pagado      + isnull(@valor,0) - round((isnull(@valor,0))/@w_porcIva,2)  	--Ref50 Iva pagado neto
  Where
  cd_fecha_corte  = @i_fecha_fin and
  cd_producto   = @i_producto   and
  cd_canal    = @i_canal    and
  cd_tipo_producto  = @i_tipo_producto  and
  cd_tipo_servicio  = @i_servicio


  if @@error<>0
    return 9999


--Ref042:msilvag Fin

---< Ref:37 >--- Fin Validacion creacion registro

-- <-- JPM CS
--> ********** <--
--> ********** <--
--> TD00581007 <--
--> TA01370000 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--

--<REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66 
select
	@i_producto		   	= 3,
	@i_canal		    = 'O',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		   	= 0, --TC No Cobra Tarifa
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925)
  and hs_tipocta = 'T'
  and hs_contratado > 0
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925)
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, 0, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66>

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01610000',  ---< ref:37 >-- Modificacion de servicio
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepcion de recaudaciones de tributos pagados con tarjetas',	---< ref:37 >--Nueva descripcion
	@i_tarifa		= 0.51, --Ref54 modifica tarifa --0.54, --0.50 Ref19 cambia la tasa para el nuevo servicio
	@i_tipo_producto    	= null, --Ref19
    	@i_tipo_cliente     	= null  --Ref19

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('2')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','WAP', 'SROLESE') --ref055 jg
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

select @cont = count(1), @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('2')
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','WAP', 'SROLESE') --ref055 jg
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--

--Ref19 se suman los valores al servicio ya procesado

---Ref50 agrega validacion de existencia

   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round((isnull(@valor, 0))/@w_porcIva,2),
            'P','09','01',round((isnull(@valor, 0))/@w_porcIva,2),round((isnull(@valor, 0))/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end


--Ref19 pholguiv


--Jlopez 08/22/2016 INICIO REF 27
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

--> ********** <--
--> ********** <--
--> TD00951007 <--
--> ********** <--
--> ********** <--

--Cuando la Empresa Asume la comision
select
@i_producto=3,
@i_canal= 'O',
@i_servicio= 'TD00951007', --Las trx de este servicio se agregaran al nuevo servicio
@i_descripcion= 'VEINTI4Compras',
@v_defla_iva=0


select hm_sec_correccion
into #correccionbp1
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('221')
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cpv001', 'SROLESE')
  and hm_correccion = 'S'

if @@error<>0
  return 9999

select hm_cta_banco,cont = pn_cont_trn, valor = isnull(sum(isnull(hm_valor, 0)), 0)
into #tranemp
from cob_cuentas_his..cc_his_movimiento , cob_pagos..pg_control_ncrecaudacion r
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('221')
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','cpv001', 'SROLESE')
  and hm_correccion = 'N'
  and hm_secuencial not in (select hm_sec_correccion from #correccionbp1)
  and pn_fecha_efec = hm_fecha
  and exists (select 1 from cob_pagos..pg_pbtnpago where  bp_estado='1' and bp_codigo = r.pn_empresa)
  and pn_costo_recauda = hm_valor
group by hm_cta_banco,pn_cont_trn

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#correccionbp1') is not null
    begin
         drop table #correccionbp1
    end


--Se buscan las parametrizaciones de la empresa
if exists (select 1 from cob_super..cc_a06_no_comision where an_transaccion =3050 and an_causa ='221')
    select @v_defla_iva=1

select (valor/cont) pe_costo,
       cont,
       valor,
       (select pa_float
       from cobis..cl_parametro p
       where pa_producto = 'CTE'
       and pa_nemonico = 'IVA') + 1 pe_porc_impiva,
       round(((valor/cont)/((select pa_float
                             from cobis..cl_parametro p
                             where pa_producto = 'CTE'
                             and pa_nemonico = 'IVA')+1)),2) comi_deflat,
       i_tipo_producto=(case cc_tipo_contable
                       when '3'
                       then 'CC0017'
                       when '4'
                       then 'CC0018'
                       else 'CC0001' end)
into #tarifaempresa
from #tranemp e
inner join
cob_cuentas..cc_ctacte c
on c.cc_cta_banco = e.hm_cta_banco

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranemp') is not null
    begin
         drop table #tranemp
    end


select i_tipo_producto,
       sum(cont) cont ,
       sum(isnull ( case @v_defla_iva when 0 then valor else (comi_deflat * cont) end , 0)) valor
into #tranfinal
from #tarifaempresa
group by i_tipo_producto

if @@error<>0
  return 9999

--se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tarifaempresa') is not null
    begin
         drop table #tarifaempresa
    end


Update cob_super..cc_detalle_a06
       Set  cd_numero_trans	=  isnull(cont, 0),
           cd_ingreso_total =  isnull ( valor , 0)--,
      from #tranfinal , cob_super..cc_detalle_a06
      Where
      cd_producto       = @i_producto and
      cd_canal          = @i_canal    and
      cd_tipo_producto  = i_tipo_producto and
      cd_tipo_servicio  = @i_servicio   and
      cd_fecha_corte    = @i_fecha_fin

if @@error<>0
  return 9999

  --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranfinal') is not null
    begin
         drop table #tranfinal
    end

--> ********** <--
--> ********** <--
--> TA01410000 <--
--> ********** <--
--> ********** <--

select
@i_producto=3,
@i_canal= 'O',
@i_servicio= 'TA01410000', --Las trx de este servicio se agregaran al nuevo servicio
@i_descripcion= 'Renovacion Token Fisico',
@v_defla_iva=0

--Cuenta Corriente
select hm_sec_correccion
into #correccionren
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('685')
  and hm_correccion = 'S'

if @@error<>0
  return 9999

select hm_cta_banco,cont = count(1), valor = isnull(sum(isnull(hm_valor, 0)), 0)
into #tranren
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('685')
  and hm_correccion = 'N'
  and hm_secuencial not in (select hm_sec_correccion from #correccionren)
group by hm_cta_banco

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#correccionren') is not null
    begin
         drop table #correccionren
    end


--Se buscan las parametrizaciones
if exists (select 1 from cob_super..cc_a06_no_comision where an_transaccion =3050 and an_causa in ('685'))
    select @v_defla_iva=1

select (valor/cont) pe_costo,
       cont,
       valor,
       (select pa_float
       from cobis..cl_parametro p
       where pa_producto = 'CTE'
       and pa_nemonico = 'IVA') + 1 pe_porc_impiva,
       round(((valor/cont)/((select pa_float
                             from cobis..cl_parametro p
                             where pa_producto = 'CTE'
                             and pa_nemonico = 'IVA')+1)),2)*cont comi_deflat,
       i_tipo_producto=(case
                       when cc_categoria='R'
                       then 'CC0011'
                       when cc_tipo_contable ='3'
                       then 'CC0017'
                       when cc_tipo_contable ='4'
                       then 'CC0018'
                       else 'CC0001' end)
into #tarifaren
from #tranren e
inner join
cob_cuentas..cc_ctacte c
on c.cc_cta_banco = e.hm_cta_banco

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranren') is not null
    begin
         drop table #tranren
    end



select i_tipo_producto,
       sum(cont) cont ,
       sum(isnull ( case @v_defla_iva when 0 then valor else (comi_deflat) end , 0)) valor
into #tranfinalren
from #tarifaren
group by i_tipo_producto

if @@error<>0
  return 9999

--se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tarifaren') is not null
    begin
         drop table #tarifaren
    end

Update cob_super..cc_detalle_a06
       Set  cd_numero_trans	= isnull(cont, 0),
            cd_ingreso_total 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_ingreso_neto 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_base_imponible 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_iva_pagado 	= isnull ( valor , 0) -  round(isnull ( valor , 0)/@w_porcIva,2) --, --Ref50 Iva pagado
      from #tranfinalren , cob_super..cc_detalle_a06
      Where cd_fecha_corte    = @i_fecha_fin and
      cd_producto       = @i_producto and
      cd_canal          = @i_canal    and
      cd_tipo_producto  = i_tipo_producto and
      cd_tipo_servicio  = @i_servicio


if @@error<>0
  return 9999

  --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranfinalren') is not null
    begin
         drop table #tranfinalren
    end

--Cuenta Ahorros
set @i_producto=4
select hm_sec_correccion
into #correccionrenaho
from cob_ahorros_his..ah_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (4272)
  and hm_causa in ('216')
  and hm_correccion = 'S'

if @@error<>0
  return 9999

select hm_cta_banco,cont = count(1), valor = isnull(sum(isnull(hm_valor, 0)), 0)
into #tranrenho
from cob_ahorros_his..ah_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (4272)
  and hm_causa  in ('216')
  and hm_correccion = 'N'
  and hm_secuencial not in (select hm_sec_correccion from #correccionrenaho)
group by hm_cta_banco

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#correccionrenaho') is not null
    begin
         drop table #correccionrenaho
    end

--Se buscan las parametrizaciones
if exists (select 1 from cob_super..cc_a06_no_comision where an_transaccion =4272 and an_causa in ('216'))
    select @v_defla_iva=1

select (valor/cont) pe_costo,
       cont,
       valor,
       (select pa_float
       from cobis..cl_parametro p
       where pa_producto = 'AHO'
       and pa_nemonico = 'IVA') + 1 pe_porc_impiva,
       round(((valor/cont)/((select pa_float
                             from cobis..cl_parametro p
                             where pa_producto = 'CTE'
                             and pa_nemonico = 'IVA')+1)),2)*cont comi_deflat,
       i_tipo_producto=(case
                       when ah_categoria  not in ('K', 'H', 'R')
                       then 'CA0001'
                       when ah_categoria in ('H', 'K')
                       then 'CA0007'
                       when ah_categoria in ('R')
                       then 'CA0021' end)
into #tarifarenho
from #tranrenho e
inner join
cob_ahorros..ah_cuenta c
on c.ah_cta_banco = e.hm_cta_banco

if @@error<>0
  return 9999

    --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranrenho') is not null
    begin
         drop table #tranrenho
    end



select i_tipo_producto,
       sum(cont) cont ,
       sum(isnull ( case @v_defla_iva when 0 then valor else (comi_deflat) end , 0)) valor
into #tranfinalrenho
from #tarifarenho
group by i_tipo_producto

if @@error<>0
  return 9999

--se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tarifarenho') is not null
    begin
         drop table #tarifarenho
    end

Update cob_super..cc_detalle_a06
       Set  cd_numero_trans	=  isnull(cont, 0),
            cd_ingreso_total 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_ingreso_neto 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_base_imponible 	= round(isnull ( valor , 0)/@w_porcIva,2) ,		--Ref50  deflactar
            cd_iva_pagado 	= isnull ( valor , 0) -  round(isnull ( valor , 0)/@w_porcIva,2) --, --Ref50 Iva pagado
           -- cd_tarifa        = isnull((valor/cont), 0),
           -- cd_tasa_ponderada= isnull((valor/cont), 0)
      from #tranfinalrenho , cob_super..cc_detalle_a06
      Where cd_fecha_corte    = @i_fecha_fin and
      cd_producto       = @i_producto and
      cd_canal          = @i_canal    and
      cd_tipo_producto  = i_tipo_producto and
      cd_tipo_servicio  = @i_servicio


if @@error<>0
  return 9999

  --se realiza el control de la eliminacion de la tabla temporal
  if object_id('tempdb.dbo.#tranfinalrenho') is not null
    begin
         drop table #tranfinalrenho
    end

--Jlopez 05/11/2017 FIN REF 41
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

--> ********** <--
--> ********** <--
--> TA00040000 <--
--> ********** <--
--> ********** <--

--< SE SACA DE TODOS LOS USUARIOS

--< OJO HAY QUE AGREGAR 3335 3032 - 14

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TA00040000',
	@i_descripcion		= 'Cheque devuelto por forma, firma o fondos cuando este se encuentra fuera del pais',
	@i_tarifa		= 2.89  --Ref54 modifica tarifa --3.24

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos

  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('931', '123', '33') --< ref: 7 >--
  and hm_correccion = 'S'
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  -- and hm_causa in ('931', '123') --< ref: 7 >--
  and hm_causa in ('931', '123', '33') --< ref: 7 >--
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'', isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2) , 0,
       'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total, cd_tasa_ponderada,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',isnull(count(1), 0), @i_tarifa,
    	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),0 ,
       'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select	@i_producto		= 4

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4262, 4264)
  and hm_causa = '931' --< ref: 7 >--
  and hm_correccion = 'S'

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4262, 4264)
  and hm_causa = '931' --< ref: 7 >--
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001

set 	@i_canal		= 'H',
	@i_producto		= 4

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - FIN >--

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), 0,
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta
group by ah_tipocta
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

--> ********** <--
--> ********** <--
--> TA00050000 <--
--> ********** <--
--> ********** <--

--< SE SACA DE TODOS LOS USUARIOS
--< SACAR A MANO LA TRX Y CAUSA DEL CREDITO 3048 - 13

select
	@i_producto		= 3,
	@i_canal		= 'R',
	@i_servicio     	= 'TA00050000',
	@i_descripcion		= 'Registro y envio al depositante, de un cheque que fue devuelto  por el Banco girado',
	@i_tarifa		= 2.49  --Ref54 modifica tarifa --2.79

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('411', '615', '18', '996')
  and hm_correccion = 'S'
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('411', '615', '18', '996')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - FIN >--

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'', isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), 0,
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< ref: 6 >--
--> CREDITO A LAS CUENTAS

set @cont = 0, @valor = 0,@valor2=0
select
    @cont = count(1),
    @valor = round(isnull(sum(hm_valor), 0)/@w_porcIva,2),
    @valor2= isnull(sum(hm_valor), 0) - round(isnull(sum(hm_valor), 0)/@w_porcIva,2)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('13')
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('3', '4')

--< ACTUALIZA VALORES

update cob_super..cc_detalle_a06
set cd_numero_trans   = isnull(cd_numero_trans, 0)   - @cont,
    cd_ingreso_total  = isnull(cd_ingreso_total, 0)  - @valor,
    cd_ingreso_neto   = isnull(cd_ingreso_neto, 0)   - @valor,
    cd_base_imponible = isnull(cd_base_imponible, 0) - @valor,
    cd_iva_pagado     = isnull(cd_iva_pagado, 0) - @valor2
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< CC0001 - CC0011

--< ref: 6 >--
--> CREDITO A LAS CUENTAS

set @cont = 0, @valor = 0,@valor2=0
select
    @cont = count(1),
    @valor = round(isnull(sum(hm_valor), 0)/@w_porcIva,2),						--Ref50
    @valor2= isnull(sum(hm_valor), 0) - round(isnull(sum(hm_valor), 0)/@w_porcIva,2)			--Ref50

from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('13')
  and cc_categoria in ('R')
  and cc_tipo_contable not in ('3', '4')

--< ACTUALIZA VALORES

update cob_super..cc_detalle_a06
set cd_numero_trans   = isnull(cd_numero_trans, 0)   - @cont,
    cd_ingreso_total  = isnull(cd_ingreso_total, 0)  - @valor,				--Ref50
    cd_ingreso_neto   = isnull(cd_ingreso_neto, 0)   - @valor,				--Ref50
    cd_base_imponible = isnull(cd_base_imponible, 0) - @valor,				--Ref50
    cd_iva_pagado     = isnull(cd_iva_pagado, 0) - @valor2				--Ref50
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'			--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< CC0017 - CC0018

insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total, cd_tasa_ponderada,
      cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
      )
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  0,
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3', '4')

    if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
       end


--< ref: 6 >--
--> CREDITO A LAS CUENTAS

set @cont = 0, @valor = 0,@valor2=0
select
    @cont = count(1),
    @valor = round(isnull(sum(hm_valor), 0)/@w_porcIva,2),						--Ref50
    @valor2= isnull(sum(hm_valor), 0) - round(isnull(sum(hm_valor), 0)/@w_porcIva,2)			--Ref50
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('13')
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('3')

--< ACTUALIZA VALORES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0)     - @cont,
    cd_ingreso_total  = isnull(cd_ingreso_total, 0)  - @valor,				--Ref50
    cd_ingreso_neto   = isnull(cd_ingreso_neto, 0)   - @valor,				--Ref50
    cd_base_imponible = isnull(cd_base_imponible, 0) - @valor,				--Ref50
    cd_iva_pagado     = isnull(cd_iva_pagado, 0)     - @valor2				--Ref50
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'			--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< ref: 6 >--
--> CREDITO A LAS CUENTAS

set @cont = 0, @valor = 0,@valor2=0
select
    @cont = count(1),
    @valor = round(isnull(sum(hm_valor), 0)/@w_porcIva,2),						--Ref50
    @valor2= isnull(sum(hm_valor), 0) - round(isnull(sum(hm_valor), 0)/@w_porcIva,2)			--Ref50
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('13')
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('4')

--< ACTUALIZA VALORES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0) - @cont,
    cd_ingreso_total  = isnull(cd_ingreso_total, 0)  - @valor,				--Ref50
    cd_ingreso_neto   = isnull(cd_ingreso_neto, 0)   - @valor,				--Ref50
    cd_base_imponible = isnull(cd_base_imponible, 0) - @valor,				--Ref50
    cd_iva_pagado     = isnull(cd_iva_pagado, 0)     - @valor2				--Ref50
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'  -- 'CC0018'  --Ref50
  and cd_prop_canal='P' and cd_cod_provincia='09' and cd_cod_canton='01'			--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select
	@i_producto		= 4

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4262, 4264, 4272)
  and hm_causa in ('14', '996')
  and hm_correccion = 'S'

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4262, 4264, 4272)
  and hm_causa in ('14', '996')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

set 	@i_canal		= 'H',
	@i_producto		= 4


insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'',isnull(count(1), 0), @i_tarifa,
        round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  0,
        'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

/*******************************************************************
 *******************************************************************
 NUEVAS TRANSACCIONES, CAUSAS Y CATEGORIAS AGREGADAS A LOS SERVICIOS
*******************************************************************
*******************************************************************/


--> ********** <--
--> ********** <--
--> TA00010000 <--
--> ********** <--
--> ********** <--

--> SOLO PAGOS EN EFECTIVO, LOS PAGOS CON DEBITO A CUENTA SE SACAN EN  EL AUTOMATICO

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00010000',
	@i_descripcion		= 'Emision de certificados solicitados por los clientes sobre diferentes productos en el Banco',
	@i_tarifa		= 2.25 --Ref54 modifica tarifa --2.37 --2.65 Ref50 cambiar comision segun lo solictado


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('36', '56', '61', '72')
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
truncate table ##datos_sib

insert into ##datos_sib
select 	hs_cta_banco, isnull(hs_saldo, 0),hs_oficina,				 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hs_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hs_oficina)   	  ---Ref50 agrega canton
from cob_cuentas_his..cc_his_servicio a
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('36', '56', '61', '72')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),0,/* @valor,*/ 'P',provincia,canton,round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)
from ##datos_sib
group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Si no hay datos se llenan con cero

--< ref: 5 >--
--> CREDITO A LAS CUENTAS DEBE CORRERSE DESPUES DEL AUTOMATICO

--< Saca registros validos
truncate table ##3datos
truncate table ##3datos_resp

insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),					--Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,		--Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)  		--Ref50 agrega canton

from cob_cuentas_his..cc_his_movimiento a, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('262', '95')
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('3', '4')
group by hm_oficina

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad),sum(valor) ,provincia,canton
 from ##3datos
 group by provincia,canton
--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) - isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2) )	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos
truncate table ##3datos_resp

insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_cuentas_his..cc_his_movimiento a, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('262', '95')
  and cc_categoria in ('R')
  and cc_tipo_contable not in ('3', '4')
group by hm_oficina

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad),sum(valor) ,provincia,canton
 from ##3datos
 group by provincia,canton

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06

   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2)) 	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_prop_canal = 'P'
  and cd_tipo_producto = 'CC0011'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos
truncate table ##3datos_resp

insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_cuentas_his..cc_his_movimiento a, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('262', '95')
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3')
group by hm_oficina

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad)cant,sum(valor) valor,provincia,canton
 from ##3datos
 group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2)) 	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos
truncate table ##3datos_resp

--set @cont = 0, @valor = 0
--select
   -- @cont = count(1),
   -- @valor = isnull(sum(hm_valor), 0)
insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_cuentas_his..cc_his_movimiento a, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3048)
  and hm_causa in ('262', '95')
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('4')
group by hm_oficina

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad)cant,sum(valor) valor,provincia,canton
 from ##3datos
 group by provincia,canton

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2) )	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0018'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##3datos
truncate table ##3datos_resp

insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_ahorros_acum..ah_his_mov_a06 a
where hm_tipo_tran in (4253)
  and hm_causa in ('262')
  and ah_categoria not in ('R', 'H', 'K')
group by hm_oficina

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad)cant,sum(valor) valor,provincia,canton
 from ##3datos
 group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2))	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0001'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos
truncate table ##3datos_resp


insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_ahorros_acum..ah_his_mov_a06 a
where hm_tipo_tran in (4253)
  and hm_causa in ('262')
  and ah_categoria in ('H', 'K')
group by hm_oficina
--< ACTUALIZA LA CANTIDAD DE CHEQUES

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--Ref50 valores sumados
insert into  ##3datos_resp
 select sum(cantidad)cant,sum(valor) valor,provincia,canton
 from ##3datos
 group by provincia,canton

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2)) 	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0007'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##3datos
truncate table ##3datos_resp

insert into ##3datos
select count(1),isnull(sum(hm_valor), 0),			 --Ref50 agrega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_ahorros_acum..ah_his_mov_a06 a
where hm_tipo_tran in (4253)
  and hm_causa in ('262')
  and ah_categoria in ('R')
group by hm_oficina
--< ACTUALIZA LA CANTIDAD DE CHEQUES

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--Ref50 valores sumados

insert into  ##3datos_resp
 select sum(cantidad)cant,sum(valor) valor,provincia,canton
 from ##3datos
 group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ACTUALIZA LA CANTIDAD DE CHEQUES
update cob_super..cc_detalle_a06
   set cd_numero_trans = isnull(cd_numero_trans, 0) -isnull(cantidad,0),
       cd_ingreso_total = isnull(cd_ingreso_total, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_ingreso_neto = isnull(cd_ingreso_neto, 0) - round((isnull(valor,0)/@w_porcIva),2),			--Ref50 ingreso deflactacion
       cd_base_imponible = isnull(cd_base_imponible, 0) - round((isnull(valor,0)/@w_porcIva),2),		--Ref50 ingreso deflactacion
       cd_iva_pagado = isnull(cd_iva_pagado, 0) - (isnull(valor,0)-round((isnull(valor,0)/@w_porcIva),2)) 	--Ref50 ingreso deflactacion
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0021'
  and cd_prop_canal = 'P'
  and cd_cod_provincia = provincia
  and cd_cod_canton = canton

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TA00960000 <--		-- GYC 2015/Dic/03
--> ********** <--
--> ********** <--

--> TRANSACCIONES DE ELIMINACION DE PROTESTO DE CHEQUES: TRX 3048 CAUSA 17

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TB01510000', --Ref30 Agregar Nuevo Servicio,
	@i_tarifa		= 0.00 		--< Ref:37 >-- Colocar la nueva tarifa 0

-- Actualizar reversos de comision protestos N/C 3048 causa 17

set @cont = 0, @valor = 0

select @cont = count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3511
  and cc_categoria <> 'R'
  and cc_tipo_contable not in ('3', '4')

select @cont = @cont - count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3510
  and cc_categoria <> 'R'
  and cc_tipo_contable not in ('3', '4')


select
    @cont = @cont + count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3511
  and cc_categoria = 'R'
  and cc_tipo_contable not in ('3', '4')

select
    @cont = @cont - count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3510
  and cc_categoria = 'R'
  and cc_tipo_contable not in ('3', '4')

select
     @cont = @cont + count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3511
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4') --Ref54

select
    @cont = @cont - count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3510
  and cc_categoria <> 'R'
  and cc_tipo_contable in ( '3','4')  --Ref54 Agrea tipo contable

--Ref54 Comentar
/*
select
     @cont =  @cont + count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3511
  and cc_categoria <> 'R'
  and cc_tipo_contable = '4'*/


/*select
     @cont =  @cont - count(1)
from cob_cuentas_his..cc_his_servicio,cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hs_tsfecha>=convert(datetime,@i_fecha_ini)
and hs_tsfecha<= convert(datetime,@i_fecha_fin)
and cc_cta_banco = hs_cta_banco
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3510
  and cc_categoria <> 'R'
  and cc_tipo_contable = '4'*/


--Ref50 ingresar la cantidad total
insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,cd_tipo_servicio, cd_tipo_producto,
	cd_descripcion,cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,cd_tipo_cliente,
	cd_numero_trans,cd_tarifa,cd_ingreso_total, cd_tasa_ponderada,cd_prop_canal,
	cd_cod_provincia,cd_cod_canton,	cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)
values 	(@i_producto, @i_fecha_fin, @i_canal,@i_servicio, null,
	 @i_descripcion, null, null, substring(@i_servicio, 1, 2),null,
	 isnull(@cont, 0), @i_tarifa,0,0, 'P',
	 '09','01',0,0,0
	)

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN INSERTAR REGISTRO MANUAL TB01510000',
          @i_num     = 99999
      return 99999
   end
--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set
    cd_ingreso_total =0,
    cd_ingreso_neto = 0,
    cd_base_imponible = 0,
    cd_iva_pagado=0
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ACTUALIZACION CC0018 3048 17',
          @i_num     = 99999
      return 99999
   end



--> ********** <--
--> ********** <--
--> TA01100000 <--		-- GYC 2015/Dic/14
--> ********** <--
--> ********** <--
--> TB01500000 <--		-- Pholguiv 2016/Dic/30
--> ********** <--

--> TRANSACCIONES DE ELIMINACION DE PROTESTO DE CHEQUES: TRX 3048 CAUSA 202

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TB01500000',  	 --Ref:30 nuevo servicio
	@i_tarifa		= 0.00, 		 --< Ref:37 >-- Colocar la nueva tarifa 0
	@i_descripcion		= 'Emision y entrega de estados de cuenta de todo tipo de cuenta y tipo de tarjeta por medios electroni'

-- Actualizar reversos de comision protestos N/C 3048 causa 202

set @cont = 0, @valor = 0

--< Ref:37 >--- Agregar nueva trx de servicio
------------------------------------------------------------
select @cont=0

select @cont = count(1)
from  cob_cuentas..cc_cabecera_grupo_ec
inner join cob_cuentas..cc_ctacte on cc_cta_banco = cg_cta_banco
where
  cg_fecha >= @i_fecha_ini
  and cg_fecha <= @i_fecha_fin
  and cc_tipo_dir in ('D','C')
  and cg_imprime ='S'
  and cc_tipo_contable not in ('3', '4')

--Ref50 Realizo un solo script para grabar la trx segun reglamente de nuevo caso de uso
select @cont2=0
select @cont2 = count(1)
from  cob_cuentas..cc_cabecera_grupo_ec
inner join cob_cuentas..cc_ctacte on  cc_cta_banco = cg_cta_banco
where -- cc_cta_banco = cg_cta_banco
  --and
  cg_fecha >= @i_fecha_ini
  and cg_fecha <= @i_fecha_fin
  and cc_tipo_dir in ('D','C')
  and cg_imprime ='S'
and cc_categoria <> 'R'
and cc_tipo_contable  in ('3','4')


select @cont=isnull(@cont,0) + isnull(@cont2,0)

--Ref 50 en el caso que no exista la trx no colcocar
if exists (select 1 from cob_super..cc_detalle_a06
               where cd_fecha_corte   = @i_fecha_fin
                 and cd_tipo_servicio = @i_servicio
                 and cd_canal         = @i_canal
                 and cd_tipo_producto = 'CC0001'
                 and cd_prop_canal    = 'P'
                 and cd_cod_provincia = '09'
                 and cd_cod_canton    = '01'					--Ref50
                 )
begin

	update cob_super..cc_detalle_a06
	set cd_numero_trans = isnull(cd_numero_trans, 0) + @cont,
	    cd_ingreso_total =0	,cd_ingreso_neto=0, cd_base_imponible=0,cd_iva_pagado=0						 --Colocar 0 porque la nueva tarifa es 0
	from cob_super..cc_detalle_a06
	where cd_fecha_corte = @i_fecha_fin
	  and cd_tipo_servicio = @i_servicio
	  and cd_canal = @i_canal
	  and cd_tipo_producto = 'CC0001'
	  and cd_prop_canal    = 'P'
	  and cd_cod_provincia = '09'
	  and cd_cod_canton    = '01'

	if @@error <> 0
	   begin
	      exec cobis..sp_cerror
		  @i_msg     = 'ERROR EN ACTUALIZACION CC0001 TB01500000',
		  @i_num     = 99999
	      return 99999
	   end

end
else
begin

	insert into cob_super..cc_detalle_a06
		(cd_producto, cd_fecha_corte, cd_canal,
		cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
		cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
		cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
		cd_prop_canal,cd_cod_provincia,cd_cod_canton)
	values(	@i_producto, @i_fecha_fin, @i_canal,
		@i_servicio, @i_tipo_producto, @i_descripcion,
		null, null, substring(@i_servicio, 1, 2),
		'', @cont, @i_tarifa, 0,'P','09','01')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

end

----> 'CC0011'
--< Ref:37 >---fin agregar nueva trx de servicio

--> ********** ********** ********** ********** <--
--> ********** ********** ********** ********** <--
--> TA00970000 TA00980000 TA00990000 TA01000000 <--		-- GYC 2016/Ene/05
--> ********** ********** ********** ********** <--
--> ********** ********** ********** ********** <--

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000
-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000
-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000
-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

delete cob_super..cc_detalle_a06
where cd_fecha_corte >= @i_fecha_ini
  and cd_fecha_corte <= @i_fecha_fin
  and cd_tipo_servicio in ('TA00440000','TA00970000','TA00980000','TA00990000','TA01000000')

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ELIMINACION TRANSFERENCIAS ENVIADAS',
          @i_num     = 99999
      return 99999
   end

--===========================================================================
-- CANAL = "O"	-- Usuarios <> ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR')
-- TRX	 = 3050
-- CAUSA = 958 / 841
--===========================================================================

truncate table ##datos_transf

insert into ##datos_transf
select 	im_cta_banco,
	im_monto,
	im_comision
from cob_cuentas..cc_inf_msg, cob_comext..ce_control_swift
where
      cs_fecha >= @i_fecha_ini --ref38
  and cs_fecha <= @i_fecha_fin --ref38
  and im_numero = cs_numero
  and cs_toper = 'TRAENV'
  and cs_estado not in ('R','X')
  and cs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and im_prod_cta = 3

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION CANAL O CTE',
	  @i_num     = 99999
      return 99999
   end

---------------------
-- ====> CC0001
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa --55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega correcion
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref51

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
   and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #1',
	  @i_num     = 99999
      return 99999
   end


-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa --55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega correcion
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
    and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #2',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #3',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  --and cc_categoria <> 'R'		--Ref50
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #4',
	  @i_num     = 99999
      return 99999
   end

--------------------------
-- ====> CC0017	/ CC0018
--------------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 										--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #9/3',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #10',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --  95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ( '3','4')
  and valor > 5000 and valor <= 10000


if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #11/3',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #12/3',
	  @i_num     = 99999
      return 99999
   end

--> ********** <--
--> ********** <--
--> TD00851007 <--		-- Ref: 25 -- GYC 2016/Mar/01
--> ********** <--
--> ********** <--

--> TRANSACCIONES DE REVERSO DE COBRO DE COMISION POR ENVIO MT940 SWIFT (3048 CAUSA 586)

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00851007'


-- Actualizar reversos de comision envio MT940 Swift N/C 3048 causa 586

set @cont = 0, @valor = 0
select
    @cont = count(1),
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hm_fecha >= convert(datetime,@i_fecha_ini)
  and hm_fecha <= convert(datetime,@i_fecha_fin)
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3048
  and hm_causa = '586'
  and cc_categoria <> 'R'
  and cc_tipo_contable not in ('3', '4')

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0) - @cont,
    cd_ingreso_total = isnull(cd_ingreso_total, 0) - @valor
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ACTUALIZACION CC0001 3048 586',
          @i_num     = 99999
      return 99999
   end

set @cont = 0, @valor = 0
select
    @cont = count(1),
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hm_fecha >= convert(datetime,@i_fecha_ini)
  and hm_fecha <= convert(datetime,@i_fecha_fin)
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3048
  and hm_causa = '586'
  and cc_categoria = 'R'
  and cc_tipo_contable not in ('3', '4')

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0) - @cont,
    cd_ingreso_total = isnull(cd_ingreso_total, 0) - @valor
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0011'

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ACTUALIZACION CC0011 3048 586',
          @i_num     = 99999
      return 99999
   end


set @cont = 0, @valor = 0
select
    @cont = count(1),
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hm_fecha >= convert(datetime,@i_fecha_ini)
  and hm_fecha <= convert(datetime,@i_fecha_fin)
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3048
  and hm_causa = '586'
  and cc_categoria <> 'R'
  and cc_tipo_contable = '3'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0) - @cont,
    cd_ingreso_total = isnull(cd_ingreso_total, 0) - @valor
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ACTUALIZACION CC0017 3048 586',
          @i_num     = 99999
      return 99999
   end


set @cont = 0, @valor = 0
select
    @cont = count(1),
    @valor = isnull(sum(hm_valor), 0)
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)
where hm_fecha >= convert(datetime,@i_fecha_ini)
  and hm_fecha <= convert(datetime,@i_fecha_fin)
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3048
  and hm_causa = '586'
  and cc_categoria <> 'R'
  and cc_tipo_contable = '4'

--< ACTUALIZA LA CANTIDAD DE CHEQUES

update cob_super..cc_detalle_a06
set cd_numero_trans = isnull(cd_numero_trans, 0) - @cont,
    cd_ingreso_total = isnull(cd_ingreso_total, 0) - @valor
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0018'

if @@error <> 0
   begin
      exec cobis..sp_cerror
          @i_msg     = 'ERROR EN ACTUALIZACION CC0018 3048 586',
          @i_num     = 99999
      return 99999
   end

--===========================================================================
-- CANAL = "I"	-- Usuarios = ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR')
-- TRX	 = 3050
-- CAUSA = 497 / 841 / 887 / 888
--===========================================================================

truncate table ##datos_transf

insert into ##datos_transf
select 	im_cta_banco,
	im_monto,
	im_comision
from cob_cuentas..cc_inf_msg, cob_comext..ce_control_swift
where
      cs_fecha >= @i_fecha_ini --ref38
  and cs_fecha <= @i_fecha_fin --ref38
  and im_numero = cs_numero
  and cs_toper = 'TRAENV'
  and cs_estado not in ('R','X')
  and cs_usuario in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and im_prod_cta = 3

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION CANAL I CTE',
	  @i_num     = 99999
      return 99999
   end


---------------------
-- ====> CC0001
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        '','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
    and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #13',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 									--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
   and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #14',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 										--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #15',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 											--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
   and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #16',
	  @i_num     = 99999
      return 99999
   end

--------------------------
-- ====> CC0017	- CC0018
--------------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 0 and valor <= 1000


if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #21/3',
	  @i_num     = 99999
      return 99999
   end


-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #22/3',
	  @i_num     = 99999
      return 99999
   end


-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000
select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #23/3',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 3,
	@i_canal		= 'I',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0017', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2), 0,
        '','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_transf
where cc_cta_banco = cuenta
  and cc_categoria <> 'R'
  and cc_tipo_contable in ('3','4')
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #24/3',
	  @i_num     = 99999
      return 99999
   end

--===========================================================================
-- CANAL = "O"	-- Usuarios <> ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR')
-- TRX	 = 4262 / 4264 / 4272
-- CAUSA = 841 / 847 / 848 / 958
--===========================================================================


truncate table ##datos_transf

insert into ##datos_transf
select 	im_cta_banco,
	im_monto,
	im_comision
from cob_cuentas..cc_inf_msg, cob_comext..ce_control_swift
where
      cs_fecha >= @i_fecha_ini --ref38
  and cs_fecha <= @i_fecha_fin --ref38
  and im_numero = cs_numero
  and cs_toper = 'TRAENV'
  and cs_estado not in ('R','X')
  and cs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and im_prod_cta = 4

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION CANAL O AHO',
	  @i_num     = 99999
      return 99999
   end


---------------------
-- ====> CA0001
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 0 and valor <= 1000


if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #25',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #26',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #27',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 10000


if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #28',
	  @i_num     = 99999
      return 99999
   end

---------------------
-- ====> CA0021
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #29',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #30',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
        'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
        round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #31',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 4,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'P','09','01',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #32',
	  @i_num     = 99999
      return 99999
   end


--===========================================================================
-- CANAL = "I"	-- Usuarios = ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR')
-- TRX	 = 4264
-- CAUSA = 437 / 570 / 571 / 841
--===========================================================================

truncate table ##datos_transf

insert into ##datos_transf
select 	im_cta_banco,
	im_monto,
	im_comision
from cob_cuentas..cc_inf_msg, cob_comext..ce_control_swift
where
      cs_fecha >= @i_fecha_ini --ref38
  and cs_fecha <= @i_fecha_fin --ref38
  and im_numero = cs_numero
  and cs_toper = 'TRAENV'
  and cs_estado not in ('R','X')
  and cs_usuario in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and im_prod_cta = 4

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION CANAL I AHO',
	  @i_num     = 99999
        return 99999
   end

---------------------
-- ====> CA0001
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000
select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #33',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #34',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #35',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria not in ('H', 'K', 'R')
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #36',
	  @i_num     = 99999
      return 99999
   end

---------------------
-- ====> CA0021
---------------------

-- Si el monto de la transferencia está entre $0.01 y $1,000.00 	--> TA00970000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00970000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos menores o iguales a $1.000,00',
	@i_tarifa		= 49.54 --Ref54 cambio tarifa -- 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 0 and valor <= 1000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #37',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $1,000.01 y $5,000.00 	--> TA00980000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00980000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $1.000,00 y menores (o iguales) a $5.000,00',
	@i_tarifa		= 66.36 --Ref54 cambio tarifa 55.48

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 1000 and valor <= 5000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #38',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia está entre $5,000.01 y $10,000.00	--> TA00990000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA00990000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $5.000,00 y menores (o iguales) a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa -- 95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 5000 and valor <= 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #39',
	  @i_num     = 99999
      return 99999
   end

-- Si el monto de la transferencia es superior a $10,000.00 		--> TA01000000

select
	@i_producto		= 4,
	@i_canal		= 'I',
	@i_servicio     	= 'TA01000000',
	@i_descripcion		= 'Transferencias enviadas al exterior por montos mayores a $10.000,00',
	@i_tarifa		= 85.18 --Ref54 cambio tarifa --95.40

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_monto_base,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CA0021', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	'T', isnull(count(1), 0), @i_tarifa,
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),
	'','','',isnull(sum(isnull(valor, 0)), 0), 			--Ref51 agrega suma
	round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2),(isnull(sum(isnull(comision, 0)), 0) - round((isnull(sum(isnull(comision, 0)), 0))/@w_porcIva,2))  --Ref50
from cob_ahorros..ah_cuenta (index ah_cuenta_Key), ##datos_transf
where ah_cta_banco = cuenta
  and ah_categoria = 'R'
  and valor > 10000

if @@error <> 0
   begin
      exec cobis..sp_cerror
	  @i_msg     = 'ERROR EN INSERCION #40',
	  @i_num     = 99999
      return 99999
   end


--> ********** ********** ********** ********** <--
--> ********** ********** ********** ********** <--
--> TA00970000 TA00980000 TA00990000 TA01000000 <--		-- GYC 2016/Ene/05
--> ********** ********** ********** ********** <--
--> ********** ********** ********** ********** <--

-- FIN


--> ********** <--
--> ********** <--
--> TD00281007 <--
--> ********** <--
--> ********** <--

--> SOLO PAGOS EN EFECTIVO, LOS PAGOS CON DEBITO A CUENTA SE SACAN EN  EL AUTOMATICO

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00281007',
    	@i_descripcion      	= 'Solicitud de copia digitalizada o microfilmica de algun documento especifico, todo tipo de cuenta',  --<ref: 3>--
	@i_tarifa		= 2.68 --Ref54 cambio tarifa -- 3


--< Sacar reversos
truncate table ##correccion


insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa = '46'
  and hs_correccion = 'S'
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< Saca registros validos
--truncate table ##datos

select @cont = 0, @valor = 0  --< ref: 6 >--

--< ref: 6 >--
select 	--hs_cta_banco, isnull(hs_valor, 0) + isnull(hs_saldo, 0)
        @cont = count(1),
        @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa = '46'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


--< ref: 6 >--
truncate table ##2datos

insert into ##2datos
select count(1),  isnull(hs_valor, 0) + isnull(hs_saldo, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3032, 3335)
  and hs_causa in ('46')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  group by isnull(hs_valor, 0) + isnull(hs_saldo, 0)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('83', '320', '76')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(hm_valor), 0) + @valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('83', '320', '76')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

insert into ##2datos
select count(1),  hm_valor
from     cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('83', '320', '76')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< SACA DATOS DE LA TABLAS DE AHORROS

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select
    hm_sec_correccion
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('184', '320', '993')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL insertar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(hm_valor), 0) + @valor
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('184', '320', '993')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--

insert into ##2datos
select count(1),  hm_valor
from     cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('184', '320', '993')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor2 =
sum
   (
     (
       valor
       *
       cantidad
     )
     /
     sum(cantidad)
   )
from ##2datos

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada)
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    isnull(@valor, 0), isnull(@valor2, 0)
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TA00480000 <--
--> ********** <--
--> ********** <--

--> Agrupar en un solo registro todo el canal oficina
--> Cambio para presentar los codigos TA00520000 y TA00480000 en uno solo con TD00091007

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00480000',
	@i_descripcion		= 'Servicio de transferencia de fondos a una cuenta en otro Banco.',
	@i_tarifa		= 2

--< ref: 6 >--
--> Procesar Adicional
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3491)
  and hs_causa = '7'
  and hs_correccion = 'S'


--select @cont = isnull(count(1), 0) + @cont, @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0) + @valor   --< ref: 6 >--
select @cont = isnull(count(1), 0), @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0)    --< ref: 6 >--
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3491)
  and hs_causa = '7'
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)


insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)
values(	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, @cont, @i_tarifa, round(isnull(@valor,0)/@w_porcIva,2),
	'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50
	)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TD00211007 <--
--> TA01370000 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--

-- OJO quitar los reversos porque arroja cero despues
--> Canal Oficina

--<REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66 
select
	@i_producto		   	= 3,
	@i_canal		    = 'O',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		   	= 0, --TC No Cobra Tarifa
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925)
  and hs_tipocta = 'T'
  and hs_contratado > 0
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925)
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, 0, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66>

select
	@i_producto		 = 3,
	@i_canal		 = 'O',
	@i_servicio      = 'TA01610000' , --'TA01370000', --'TD00211007', --Ref19 homologar nuevo codigo  ---< ref:37 >--Modificar codigo servicio
	@i_descripcion	 = 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas' ,--'Aplica cuando el cliente accede a diversos servicios de instituciones publicas o privadas', ---< ref:37 >--Moficacion descripcion
	@i_tarifa		 = 0.51, --Ref54 Modifca tarfia --0.54, --0.70,--Ref19  colocar la tarfia del servicio homologado
    --Ref018:msilvag Inicio
    @valorEtapa      = 0,
    @i_cant_etapa    = 0,
    @valorIESS       = 0,
    --Ref018:msilvag Fin
	@i_tipo_producto = null, --Ref19
    @i_tipo_cliente  = null  --Ref19

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('297','440', '241', '110', '289', '242', '447')--ref46 sacan las causas(149,466,229)se comenta causa que tiene comisiones parametrizadas en Automático
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hm_correccion = 'S'
  and hm_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
--truncate table ##datos
set @cont = 0, @valor = 0

select @cont = count(1)
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('297','440', '241', '110', '289', '242', '447')--ref46 sacan las causas(149,466,229)se comenta causa que tiene comisiones parametrizadas en Automático
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hm_correccion = 'N'
  and hm_terminal <> 'ATMB'  --ref 45
  --and hm_sec_correccion not in (select hs_ssn_corr from ##correccion)


--<ref: 3>--
insert into ##correccion
select hs_sec_correccion
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('8')
  and isnull(hs_autorizante,'') = '' --Ref018:msilvag
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
--<ref: 3>--
select @cont = @cont + count(1)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('8')
  and isnull(hs_autorizante,'') = '' --Ref018:msilvag
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hs_correccion = 'N'
  and hs_terminal <> 'ATMB'  --ref 45

  --< Sacar reversos
  truncate table ##correccion

  insert into ##correccion
  select hm_sec_correccion
  from cob_ahorros_acum..ah_his_mov_a06
  where hm_tipo_tran in (4264)
    and hm_causa in ('297', '114', '130', '440', '21', '58', '289', '67', '447')
    and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
    and hm_correccion = 'S'
    and hm_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

  --< Saca registros validos
  --truncate table ##datos

  select @cont = @cont + count(1)
  from cob_ahorros_acum..ah_his_mov_a06
  where hm_tipo_tran in (4264)
    and hm_causa in ('297', '114', '130', '440', '21', '58', '289', '67', '447')
    and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
    and hm_correccion = 'N'
    and hm_sec_correccion not in (select hs_ssn_corr from ##correccion)
    and hm_terminal <> 'ATMB'  --ref 45


--Ref018:msilvag Inicio Etapa
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
and hs_tsfecha <= @i_fecha_fin
and hs_oficina >= 0
and hs_moneda = 1
and hs_tipo_transaccion in (3366, 3372)
and hs_causa in ('7','30','31','8') --('30','31')
and isnull(hs_autorizante,'') = '2'
and hs_usuario not in ('ope998')
and hs_correccion = 'S'
and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select @i_cant_etapa = count(1),@valorEtapa = sum(isnull(hs_valor,0)) + sum(isnull(hs_saldo,0)) + sum(isnull(hs_monto,0))
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
where hs_tsfecha >= @i_fecha_ini
and hs_tsfecha <= @i_fecha_fin
and hs_oficina >= 0
and hs_moneda = 1
and hs_tipo_transaccion in (3366, 3372)
and hs_causa in ('7','30','31','8') --('30','31')
and isnull(hs_autorizante,'') = '2'
and hs_usuario not in ('ope998')
and hs_correccion = 'N'
and hs_secuencial not in (select hs_ssn_corr from ##correccion)
and hs_terminal <> 'ATMB'  --ref 45


select @valor = isnull(@valorEtapa,0) + isnull((@i_cant_etapa * @i_tarifa),0) --ref29 se multiplica solo la cantidad de registros de etapa

select @cont = isnull(@cont,0) + isnull(@i_cant_etapa ,0)
--Ref018:msilvag Fin

/*<REF 62 INI>*/

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)		-- ref: 9
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366,3372)
  and hs_causa in ('743','39','33','57')  /*<REF 64 INI>*/
  and hs_tipo_chequera = 'VEN'
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9992
     end

  select @cont = isnull(@cont,0) + count(1) ,
         @valor = isnull(@valor, 0) + isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0) + isnull(sum(hs_monto), 0)
  from cob_cuentas_his..cc_his_servicio (index cc_his_servicio_Key1)
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3366,3372)
    and hs_causa in ('743','39','33','57') /*<REF 64 INI>*/
	and hs_tipo_chequera = 'VEN'
	and hs_correccion = 'N'
	and hs_secuencial not in (select hs_ssn_corr from ##correccion) 

/*<REF 62 FIN>*/

---Ref50 agrega validacion de existencia

   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
            'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)    --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end
--end
--Ref19

--> ********** <--
--> ********** <--
--> TD00571007 <--
--> TA01370000 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--

--<REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66 
select
	@i_producto		   	= 3,
	@i_canal		    = 'O',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		   	= 0, --TC No Cobra Tarifa
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925)
  and hs_tipocta = 'T'
  and hs_contratado > 0
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925)
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, 0, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66>

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01610000',--'TA01370000',--'TD00571007', Ref19 las trx de este servicio se agregaran al servicio homologado ---< ref:37 >--Modificar codigo servicio
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas',  ---< ref:37 >--Nueva descripcion
	@i_tarifa		= 0.51, --Ref54 Modifca tarfia --0.54, --0.50,Ref19 se comenta la anterior tasa para colcoar la tasa de la tarifa maxima
        @cont			= 0, --Ref19 inicializa variable
        @valor			= 0, --Ref19 inicializa variable
	@i_tipo_producto    	= null, --Ref19
    	@i_tipo_cliente     	= null  --Ref19

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)        --< GAMC - 22FEB2010 SE CAMBIO LAS TRXS >--
  and hs_causa in ('4')                          --< GAMC - 22FEB2010 SE CAMBIO LAS CAUSAS >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'S'
  and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

Select @cont = count(1), @valor = isnull(sum(isnull(hs_valor, 0)),0) --Ref19 agregar variables para los totales
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)        --< GAMC - 22FEB2010 SE CAMBIO LAS TRXS >--
  and hs_causa in ('4')                          --< GAMC - 22FEB2010 SE CAMBIO LAS CAUSAS >--
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko', 'SROLESE')
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'  --ref 45

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--

   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round((isnull(@valor, 0))/@w_porcIva,2),
            'P','09','01',round((isnull(@valor, 0))/@w_porcIva,2),round((isnull(@valor, 0))/@w_porcIva,2),isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)  --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end
--end
-->Ref20 MLR Nuevo canal CNB

select
    @i_producto     = 3,
    @i_canal        = 'N',
    @i_servicio     = 'TA01610000' , --'TA01370000', --'TD00211007' --< ref:37 >--Nuevo codigo
    @i_descripcion  = 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas' , --< ref:37 >--Modificacion descripcion
    @i_tarifa       = 0.51, --Ref54 Modifca tarfia --0.54,
    @cont           = 0,
    @valor          = 0,
    @i_tipo_producto = null,
    @i_tipo_cliente  = null

--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  --<Ref24 se aumenta catalogo para leer las causas
  --Ref28 and hs_causa in (select c.codigo
  and exists (select 1 --Ref28 manejar avances en efectivo sin causa
                     from cobis..cl_tabla t, cobis..cl_catalogo c
                    where t.codigo = c.tabla
                      and t.tabla = 'cc_cau_a06_cnb_TA01370000'
                      and c.codigo = isnull(s.hs_causa,'0') --Ref28 validar campo causa nulo
                      and c.estado = 'V') --Ref28 se agrega estado
  --Fin Ref24>
  and hs_usuario = 'cnb001'
  and hs_correccion = 'S'
  and hs_valor > 0
if @@error<>0
  begin
    print 'ERROR AL INSERTAR TRX DE CORRECCION EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
    return 9999
  end

--< Saca registros validos
Select @cont = count(1),
       @valor = sum(isnull(hs_valor, 0))
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and exists (select 1 --Ref28 manejar avances en efectivo sin causa
                     from cobis..cl_tabla t, cobis..cl_catalogo c
                    where t.codigo = c.tabla
                      and t.tabla = 'cc_cau_a06_cnb_TA01370000'
                      and c.codigo = isnull(s.hs_causa,'0') --Ref28 validar campo causa nulo
                      and c.estado = 'V') --Ref28 se agrega estado
  --Fin Ref24>
  and hs_usuario = 'cnb001'
  and hs_correccion = 'N'
  and hs_valor > 0 -- sólo lee los pagos en efectivo
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

       insert into cob_super..cc_detalle_a06
            (cd_producto,       cd_fecha_corte,     cd_canal,
             cd_tipo_servicio,  cd_tipo_producto,   cd_descripcion,
             cd_tipo_tarjeta,   cd_clase_tarjeta,   cd_tipo_tarifa,
             cd_tipo_cliente,   cd_numero_trans,    cd_tarifa,
             cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
	    )
        values
           ( @i_producto,       @i_fecha_fin,       @i_canal,
             @i_servicio,       @i_tipo_producto,   @i_descripcion,
             null,              null,               substring(@i_servicio, 1, 2),
             @i_tipo_cliente,   @cont,              @i_tarifa,
             round(isnull(@valor, 0)/@w_porcIva,2),
             'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),(isnull(@valor, 0) - round(isnull(@valor, 0)/@w_porcIva,2))  --Ref50 campos valores
	    )

        if @@error<>0
          begin
            print 'ERROR AL INSERTAR DETALLE A06 EN MANUALES. Canal: %1!, Producto: %2! Servicio: %3!', @i_canal, @i_producto,@i_servicio
            return 9999
          end


--<-- Fin Ref20
--> ********** <--
--> ********** <--
--> TD00631007 <--
--> TA01580000 <--
--> ********** <--
--> ********** <--

--> SOLO PAGOS EN EFECTIVO, LOS PAGOS CON DEBITO A CUENTA SE SACAN EN  EL AUTOMATICO

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01580000', --'TD00631007', --< Ref:37 >--Modificacion Homologacion codigo
	@i_descripcion		= 'Emisión de plastico de tarjeta prepago no recargable con banda lectora (incluye la carga)',  --< ref:37 >--Modificacion descripcion
	@i_tarifa		= 0.84 --Ref54 Modificacion Tarifa --0.89   --1  --< ref:37 >--Modificacion Tarifa


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 7 >--
  and hs_causa = '10'                           --< ref: 7 >--
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
truncate table ##datos

insert into ##datos
select  hs_cta_banco, isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0)    --< ref: 7 >--
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 7 >--
  and hs_causa = '10'                           --< ref: 7 >--
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	isnull(sum(isnull(valor, 0)), 0)
from ##datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--< Si no hay datos se llenan con cero


--> ********** <--
--> ********** <--
--> TD00641007 <--
--> ********** <--
--> ********** <--

--> SOLO PAGOS EN EFECTIVO, LOS PAGOS CON DEBITO A CUENTA SE SACAN EN  EL AUTOMATICO

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00641007',
	@i_descripcion		= 'Valor fijo cobrado por la recarga de la tarjeta prepago',
	@i_tarifa		= 0.50


--< Sacar reversos
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 7 >--
  and hs_causa = '11'                           --< ref: 7 >--
  and hs_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Saca registros validos
truncate table ##datos

insert into ##datos
select  hs_cta_banco, isnull(hs_valor, 0) + isnull(hs_saldo, 0) + isnull(hs_monto, 0)    --< ref: 7 >--
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 7 >--
  and hs_causa = '11'                           --< ref: 7 >--
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50

	)
select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, null, @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
	round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
	 'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from ##datos

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< Si no hay datos se llenan con cero

--> ********** <--
--> ********** <--
--> TD00011007 <--
--> ********** <--
--> ********** <--


select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TD00011007',
	@i_descripcion		= 'El servicio cubre: consultas sobre urgencias medicas y primeros auxilios y asistencias exequiales',
	@i_tarifa		= 1.95

--> Sacar reversos
truncate table ##correccion
--truncate table ##datos

--< ref: 12 >--inicio modificacion
--Segun Requerimiento se debe ingresar un solo registro con datos ceros en los campos Cantidad y Valor total
--vacios los campos Tipo Producto y Tasa Ponderada.

--> ********** <--
--> ********** <--
--> TB00670000 <--
--> TB00850000 <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'O', --'R', --< ref: 12 >--Canal debe ser O Segun Requerimiento
    @i_servicio     = 'TB00850000',  --< ref: 12 >-- Colocar nuevo numero homologado segun Requerimiento
    @i_descripcion  = 'El servicio se aplica cuando se realiza alguna apertura de Cuenta corriente o una Cuenta de ahorros',
    @i_tarifa       = 0,
    @i_tipo_cliente = null, --'N', --< ref: 12 >-- Tipo cliente vacio
    @i_tipo_producto = null

--< ref: 12 >--Agregar segmento de codigo para registrar un solo registro
select @cont = 0

select @cont = isnull(count(1), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3001
--group by hs_tipocta

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
     cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
     cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
     cd_tipo_cliente, cd_numero_trans, cd_tarifa,cd_ingreso_total,
     cd_prop_canal,cd_cod_provincia,cd_cod_canton			--Ref50
     )
select  @i_producto, @i_fecha_fin, @i_canal,
    	@i_servicio, null, @i_descripcion,
    	null, null, substring(@i_servicio, 1, 2),
    	'', isnull(count(1), 0) + @cont, @i_tarifa, 0,
    	'P','09','01'							--Ref50
from cob_ahorros_his..ah_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_tipo_transaccion = 4201

    if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
       end

--< ref: 12 >--Agregar segmento -Fin

--> ********** <--
--> ********** <--
--> TD00731007 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 4,
    @i_canal        = 'O',
    @i_servicio     = 'TD00731007',
    @i_descripcion  = 'Aquisicion de la cubierta de la cartola',
    @i_tarifa       = 0

--> Sacar reversos
truncate table ##correccion
truncate table ##datos

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4262)
  and hm_causa = '314'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4262)
  and hm_causa = '314'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, 'CA0001', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
    'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TD00401007 <--
--> TA01370000 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--

--> OJO - UREGENTE - ESTE SERVICIO TD00401007 - SE SACA LA PONDERACION PARA ANLALIZAR EL LUNES

select
    @i_producto         = 3,
    @i_canal            = 'O',
    @i_servicio         = 'TA01610000', --'TA01370000' ,--'TD00401007', --Ref19 Cambiar codigo servicio Diferenciada por la Maxima ---< ref:37 >--Homologar nuevo servicio
    @i_descripcion      = 'Recaudaciones de pagos a terceros, a excepcion de recaudaciones de tributos pagados con tarjetas', ---< ref:37 >--Nueva descripcion
    @i_tarifa           = 0.51, --Ref54 Modifca tarfia --0.54,--0.75, --Ref19 Cambiar tarifa para el nuevo servicio TA01370000
    @i_tipo_producto    = null, --Ref19
    @i_tipo_cliente     = null  --Ref19

--truncate table ##correccion
--truncate table ##datos

select @cont = 0, @valor = 0

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 6 >--
  and hs_causa = "1"
  and hs_correccion = 'S'
   and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--select @cont = @cont + count(1)       --< ref: 6 >--
select  @cont = isnull(count(1), 0),
        @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_monto), 0) + isnull(sum(hs_saldo), 0)     --< ref: 6 >--
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)       --< ref: 6 >--
  and hs_causa = "1"
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_terminal <> 'ATMB'   --ref 45



--KBastida Desarrollo para proceso A06 TERCON Ini Cobro comision al cliente
truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (43569) 
  and hs_causa not in(select c.codigo from cobis..cl_catalogo c
                                    inner join  cobis..cl_tabla t 
                                       on c.tabla = t.codigo
                                    where c.estado = 'V'  and t.tabla = 'sv_cobro_comision_diaria') 
  and hs_correccion = 'S'
  and hs_tipo_chequera = 'VEN'  

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select  @cont =  @cont + isnull(count(1), 0),
        @valor = @valor + isnull(sum(convert(money,hs_autoriz_aut)), 0)    
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (43569) 
  and hs_causa not in (select c.codigo from cobis..cl_catalogo c
                                    inner join  cobis..cl_tabla t 
                                       on c.tabla = t.codigo
                                    where c.estado = 'V'  and t.tabla = 'sv_cobro_comision_diaria') 
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
  and hs_tipo_chequera = 'VEN' 



--KBastida Desarrollo para proceso A06 TERCON Fin Cobro comision al cliente

truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  --and hm_causa = '146'                --< ref: 6 >--
  and hm_causa in ('448', '509')        --< ref: 6 >--
  and hm_correccion = 'S'
and hm_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select @cont = @cont + isnull(count(1), 0), @valor = @valor + isnull(sum(hm_valor) ,0)      --< ref: 6 >--
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('448', '509')        --< ref: 6 >--
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  and hm_terminal <> 'ATMB'  --ref 45

truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4262, 4264)--< ref: 6 >--
  and hm_causa in ('448', '509')        --< ref: 6 >--
  and hm_correccion = 'S'
and hm_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = @cont + isnull(count(1), 0), @valor = @valor + isnull(sum(hm_valor) ,0)      --< ref: 6 >--
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4262, 4264)--< ref: 6 >--
  and hm_causa in ('448', '509')        --< ref: 6 >--
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  and hm_terminal <> 'ATMB'  --ref 45


--Ref19 se suman los valores al servicio
---Ref50 agrega validacion de existencia

   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
            'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2),isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)  --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end
--end


--Ref19 pholguiv

--< GAMC - 22FEB2010 - Agregar Servicios - TA00280000

--> ********** <--
--> ********** <--
--> TA00280000 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 4,
    @i_canal            = 'O' ,--'H', ---< ref: 12 >-- Los canales 'H' y 'R' se homologan a 'O'
    @i_servicio         = 'TA00280000',
    @i_descripcion      = 'Costo reposicion de libreta / cartola/ estado de cuenta por perdida, robo o deterioro',
    @i_tarifa           =  0.76, --Ref54 --1,	---< ref: 12 >--Colocar la tarifa 1 segun requerimiento
    @i_tipo_producto    = "",
    @i_tipo_cliente     = null  --"N", ---< ref: 12 >--Tipo cliente N y J pasan a ser nullos

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran = 4272
  and hm_causa = '154'
  and hm_correccion = 'S'

    if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
       end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran = 4272
  and hm_causa = '154'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< CA0001 - CA0021

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado   --Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    @i_tipo_cliente , isnull(count(1), 0), @i_tarifa, ---< ref: 12 >--Agregar Tipo cliente
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
    'P','09','01', round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),  round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)   --Ref50
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - Agregar Servicios - TA00560000

--> ********** <--
--> ********** <--
--> TA00560000 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'R',
    @i_servicio         = 'TA00560000',
    @i_descripcion      = 'Cheques consideracion camara de compensacion',
    @i_tarifa           = 2.68, --Ref54 Modifca tarfia --3.00,
    @i_tipo_producto    = "",
    @i_tipo_cliente     = "N"

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '617'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '617'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA - INI >--

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado			--Ref50 agrega nuevos campos
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), 0,
    'P','09','01', round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2) --Ref50 agrega nuevos campos
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end



--> ********** <--
--> ********** <--
--> TA00570000 <--
--> TA00830000 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'R',
    @i_servicio         = 'TA00830000',--'TA00570000',									--< Ref:37 >--Modificaicon Homologacion codigo
    @i_descripcion      = 'Suspensión transitoria del pago de cheque(s) (por evento para uno o varios cheques)',	--< Ref:37 >--Modificaicon Descripcion codigo
    @i_tarifa           = 2.68, --3.00, --< Ref:37 >--Nueva tarifa
    @i_tipo_producto    = "",
    @i_tipo_cliente     = "N"

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('140', '142')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('140', '142')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '' , isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
     'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2))  --Ref50

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--> ********** <--
--> ********** <--
--> TA00580000 <--
--> TA00850000 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'R',
    @i_servicio         = 'TA00850000' , --'TA00580000', 									--< Ref:37 >--Modificacion Homologacion codigo
    @i_descripcion      = 'Revocatoria de cheque(s) (por evento para uno o varios cheques)' , 					--< Ref:37 >--Modificaicon descripcion
    @i_tarifa           = 2.68, --3.00, --< Ref:37 >--Modificaicon tarifa
    @i_tipo_producto    = "",
    @i_tipo_cliente     = "N"

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '40'
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '40'
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
    'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), isnull(sum(isnull(valor, 0)), 0)- round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2) 	--Ref50 colocar Campos nuevo y deflactado

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref:9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--> ********** <--
--> ********** <--
--> TA00590000 <--
--> TA00840000 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'R',
    @i_servicio         = 'TA00840000',---'TA00590000',  							--< Ref:37 >--Modificacion Homologacion codigo
    @i_descripcion      = 'Anulacion de formularios de cheque(s) (por evento para uno o varios cheques)', 	--< Ref:37 >--Modificacion Descripcion
    @i_tarifa           = 2.68, --3.00, --< Ref:37 >--Modificacion tarifa
    @i_tipo_producto    = "",
    @i_tipo_cliente     = "N"

truncate table ##correccion
truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('46', '1')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##datos
select
    hm_cta_banco,
    hm_valor
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('46', '1')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
     )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '',isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),
    'P','09','01',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), isnull(sum(isnull(valor, 0)), 0)- round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2) 	--Ref50 colocar Campos nuevo y deflactado

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos		-- ref: 9
where cc_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TD00801007 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'M',
    @i_servicio         = 'TD00801007',
    @i_descripcion      = 'Servicio Medio VEINTI4 BANCA/SIN HORARIOS - VEINTI4 MOVIL',
    @i_tarifa           = 1.34, --1.50, Ref50 por solicitud del usuario cambiar tasa
    @i_tipo_producto    = ""
    --@i_tipo_cliente     = "N"

truncate table ##correccion
truncate table ##datos

  if @@error <> 0
     begin
        print 'ERROR AL ELIMINAR  en ##datos , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050, 3750, 3757)
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = count(1),
    @valor = sum(isnull(hm_valor,0))--Ref24 se agrega is null VMT
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050, 3750, 3757)
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL ELIMINAR en ##2datos , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  hm_valor
from     cob_cuentas_his..cc_his_movimiento mov

where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050, 3750, 3757)
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< SACA DATOS DE LA TABLAS DE AHORROS
set @cont = isnull(@cont,0), @valor = isnull(@valor,0) --ref47

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264, 4262, 4372,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = count(1) + @cont,
    @valor = isnull(sum(hm_valor),0) + @valor -- Ref24 se agrega is null VMT
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262, 4372,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--

insert into ##2datos
select count(1),  hm_valor
from     cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262, 4372, 120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('945', '946', '947')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @valor2 =
sum
   (
     (
       valor
       *
       cantidad
     )
     /
     sum(cantidad)
   )
from ##2datos


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,cd_prop_canal,cd_cod_provincia,cd_cod_canton)   --Ref50
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, @i_tarifa, @valor, @valor2, '','',''					--Ref50

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select  @i_tipo_producto    = null,
        @i_tipo_cliente     = null


--> ********** <--
--> ********** <--
--> TD00811007 <--
--> ********** <--
--> ********** <--

select
    @i_producto         = 3,
    @i_canal            = 'M',
    @i_servicio         = 'TD00811007',
    @i_descripcion      = 'Servicio Medio VEINTI4 BANCA/SIN HORARIOS - AVISOS 24',
    @i_tarifa           = 1.56,--1.75, --ref47
    @i_tipo_producto    = ""

truncate table ##correccion
/*truncate table ##datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end
*/
insert into ##correccion
select
    hm_sec_correccion
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('928','777') --ref47 se aumenta causa 777
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @cont = count(1),
    @valor = sum(round(isnull(hm_valor,0)/@w_porcIva,2))--Ref24 se agrega is null VMT
from
    cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('928','777') --ref47 se aumenta causa 777
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  hm_valor
from     cob_cuentas_his..cc_his_movimiento mov

where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('928','777')--ref47 se aumenta causa 777
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< SACA DATOS DE LA TABLAS DE AHORROS
set @cont = isnull(@cont,0), @valor = isnull(@valor,0) --ref47
truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select
    hm_sec_correccion
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('928','877')--ref47 se aumenta causa 877
  and hm_correccion = 'S'

select
    @cont = count(1) + @cont,
    @valor = isnull(sum(round(isnull(hm_valor,0)/@w_porcIva,2)) + @valor,0) --Ref24 se agrega isnull VMT
from
    cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('928','877')--ref47 se aumenta causa 877
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

--< GAMC - 22FEB2010 - CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  hm_valor
from     cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4264, 4262,120060)--Ref24 se agrega trx cta básica VMT
  and hm_causa in ('928', '877') --ref47 se aumenta causa 877
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)			--Ref50
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, @i_tarifa, @valor, 0, '','','',@valor,@valor, round(isnull(@valor, 0) * @w_Iva,2)		--Ref50  --Segun Usuario solicta que el valor iva pagado para este servicio nose deflacte ,se debe generar el iva en base al monto

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


--<ref: 3>--
--> ********** <--
--> ********** <--
--> TD00431007 <--
--> ********** <--
--> ********** <--

select
    @i_producto     	= 3,
    @i_canal        	= 'O',
    @i_servicio         = 'TD00431007',
    @i_descripcion      = 'Servicio transportacion de valores cuyo costo se calcula por la tarifa basica mas costo adicional',
    @i_tarifa       	= 17.86, --Ref54 cambio tarifa 20,
    @i_tipo_producto    = ""


--< ref: 6 >--

truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('125', '439')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

set @valor = 0, @cont = 0

select @cont = count(1), @valor = isnull(sum(isnull(hm_valor, 0)), 0)       --<ref: 2>--
from cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('125', '439')                                    --< ref: 6 >--
  and hm_correccion = 'N'                                           --< ref: 6 >--
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)   --< ref: 6 >--

--< ref: 6 >--

truncate table ##correccion

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (4272, 4262, 4264, 4372)
  and hm_causa in ('208', '144')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = @cont + count(1), @valor = @valor + isnull(sum(isnull(hm_valor, 0)), 0)  --<ref: 2>--
from cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4272, 4262, 4264, 4372)                      --< ref: 6 >--
  and hm_causa in ('208', '144')                                    --< ref: 6 >--
  and hm_correccion = 'N'                                           --< ref: 6 >--
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)   --< ref: 6 >--

--< ref: 12 >--El numero de transacciones sera el resultado del valor total dividido para la tarifa
Select @cont = round((@valor/@i_tarifa),0)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total)
values( @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, @i_tipo_producto, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, @valor)

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5 >--
--> ********** <--
--> ********** <--
--> TD00891007 <--
--> TA01370000 <--
--> TA01610000 <--
--> ********** <--
--> ********** <--
--<REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66 
select
	@i_producto		   	= 3,
	@i_canal		    = 'O',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		   	= 0, --TC No Cobra Tarifa
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925)
  and hs_tipocta = 'T'
  and hs_contratado > 0
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925)
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, 0, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 66, KBastida Reporte A06 Canal O Por TC INI Ref66>

select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio     = 'TA01610000', --'TA01370000',--'TD00891007',--Ref19 Cambia al nuevo servicio ---< ref:37 >-- Modificacion servicio
    @i_descripcion  = 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas' ,--'Pago de tramite y citaciones', --< ref:37 >--Modificacion descripcion
    @i_tarifa       =  0.51, --Ref54 Modifca tarfia --0.54, --0.50 Ref19 Se coloca la tasa del nuevo servicio y se comenta la anterior
    @i_tipo_producto   = null, --Ref19
    @i_tipo_cliente    = null  --Ref19

truncate table ##correccion

insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('14', '15', '50','59') /*<REF 74, (69 Add Causa 50 Claro Srv Fijos) (76 Add Causa 59 Ecuanet) REF 74>*/
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','WAP', 'SROLESE') -- ref055 jg
  and hs_correccion = 'S'
   and hs_terminal <> 'ATMB'  --ref 45

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = count(1), @valor = isnull(sum(hs_valor), 0) + isnull(sum(hs_saldo), 0) + isnull(sum(hs_monto), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366, 3372)
  and hs_causa in ('14', '15' , '50','59') /*<REF 76, (69 Add Causa 50 Claro Srv Fijos) (76 Add Causa 59 Ecuanet) REF 76>*/
  and hs_usuario not in ('ope998', 'SAT', 'srolese', 'IVR', 'kiosko','WAP', 'SROLESE') -- ref055 jg
  and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)
   and hs_terminal <> 'ATMB'  --ref 45

   insert into cob_super..cc_detalle_a06
            (cd_producto, cd_fecha_corte, cd_canal,
             cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
             cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
             cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
             cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado		 --Ref50 campos valores
             )

    values (@i_producto, @i_fecha_fin, @i_canal,
            @i_servicio, @i_tipo_producto, @i_descripcion,
            null, null, substring(@i_servicio, 1, 2),
            @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor, 0)/@w_porcIva,2),
            'P','09','01',round(isnull(@valor, 0)/@w_porcIva,2),round(isnull(@valor, 0)/@w_porcIva,2), isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)  --Ref50 campos valores
            )
   if @@error <> 0
     begin
        exec cobis..sp_cerror
          @i_msg     = 'ERROR AL INSERTAR TA01610000 - SAT',
          @i_num     = 99999
        return 99999
     end


--Ref19 pholguiv

--< ref: 5 >--
--> ********** <--
--> ********** <--
--> TD00941007 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio         = 'TD00941007',
    @i_descripcion      = 'Transaccion  que realiza transferencias hacia USA y  la entrega es realizada por cheque a domicilio',
    @i_tarifa       = 0.5,
    @i_tipo_producto    = ""


set @valor = 0, @cont = 0


truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('529')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = count(1), @valor = isnull(sum(isnull(hm_valor, 0)), 0)
from cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('529')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)


truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4264, 4262, 4272)
  and hm_causa in ('529')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = @cont + count(1), @valor = @valor + isnull(sum(isnull(hm_valor, 0)), 0)
from cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4264, 4262, 4272)
  and hm_causa in ('529')
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50

    )
values( @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, @i_tipo_producto, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    @i_tipo_cliente, isnull(@cont, 0), @i_tarifa, round(isnull(@valor,0)/@w_porcIva,2),									--Ref50 colocar valor deflactado
    'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),isnull(@valor,0)- round(isnull(@valor,0)/@w_porcIva,2) 	--Ref50 colocar Campos nuevo y deflactado
    )

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5 >--
--> ********** <--
--> ********** <--
--> TA00510000 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio         = 'TA00510000',
    @i_descripcion      = 'Servicio de  transferencias en linea via swift.',
    @i_tarifa       = 2,
    @i_tipo_producto    = ""


truncate table #comision

insert into #comision
select num_operacion, monto_pago
from cambio..hist_pagos_mixtos
where fecha >= @i_fecha_ini
  and fecha <= @i_fecha_fin
  and forma_pago = 228
  and recibe_entrega = 'E'

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CC0001', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),((isnull(@i_tarifa * isnull(count(1), 0), 0)) - round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2))  --Ref50
from cambio..hist_pagos_mixtos a, cob_cuentas..cc_ctacte (index cc_ctacte_Key), #comision c		-- ref: 9
where a.forma_pago = 32
  and descripcion = cc_cta_banco
  and a.num_operacion = c.num_operacion
  and cc_tipo_contable in ('1', '2','3','4')--in ('1', '2')  --Ref50

  if @@error <> 0
       begin
          print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
       end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CA0001', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2),((isnull(@i_tarifa * isnull(count(1), 0), 0)) - round((isnull(@i_tarifa * isnull(count(1), 0), 0))/@w_porcIva,2))  --Ref50
from cambio..hist_pagos_mixtos a, cob_ahorros..ah_cuenta, #comision c
where a.forma_pago = 24
  and descripcion = ah_cta_banco
  and a.num_operacion = c.num_operacion

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 5 >--
--> ********** <--
--> ********** <--
--> TD00781007 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio         = 'TD00781007',
    @i_descripcion      = 'El Stop Payment de cheque requiere una gestion de aviso a los corresponsales  para que no se pague',
    @i_tarifa       = 50,
    @i_tipo_producto    = ""

truncate table #comision

insert into #comision
select num_operacion, monto_pago
from cambio..hist_pagos_mixtos
where fecha >= @i_fecha_ini
  and fecha <= @i_fecha_fin
  and forma_pago = 203
  and recibe_entrega = 'E'

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CC0001', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),((isnull(sum(convert(money, c.monto_pago)), 0)) - round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2))  --Ref50


from cambio..hist_pagos_mixtos a, cob_cuentas..cc_ctacte (index cc_ctacte_Key), #comision c		-- ref: 9
where a.forma_pago = 32
  and descripcion = cc_cta_banco
  and a.num_operacion = c.num_operacion
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('1', '2')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CC0011', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),((isnull(sum(convert(money, c.monto_pago)), 0)) - round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2))  --Ref50

from cambio..hist_pagos_mixtos a, cob_cuentas..cc_ctacte (index cc_ctacte_Key), #comision c		-- ref: 9
where a.forma_pago = 32
  and descripcion = cc_cta_banco
  and a.num_operacion = c.num_operacion
  and cc_categoria in ('R')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CC0017', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),((isnull(sum(convert(money, c.monto_pago)), 0)) - round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2))  --Ref50

from cambio..hist_pagos_mixtos a, cob_cuentas..cc_ctacte (index cc_ctacte_Key), #comision c		-- ref: 9
where a.forma_pago = 32
  and descripcion = cc_cta_banco
  and a.num_operacion = c.num_operacion
  and cc_tipo_contable in ('3')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CC0018', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),((isnull(sum(convert(money, c.monto_pago)), 0)) - round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2))  --Ref50
from cambio..hist_pagos_mixtos a, cob_cuentas..cc_ctacte (index cc_ctacte_Key), #comision c		-- ref: 9
where a.forma_pago = 32
  and descripcion = cc_cta_banco
  and a.num_operacion = c.num_operacion
  and cc_tipo_contable in ('4')

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, 'CA0001', @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(count(1), 0), @i_tarifa, round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),
       'P','09','01',round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2),((isnull(sum(convert(money, c.monto_pago)), 0)) - round((isnull(sum(convert(money, c.monto_pago)), 0))/@w_porcIva,2))  --Ref50
from cambio..hist_pagos_mixtos a, cob_ahorros..ah_cuenta, #comision c
where a.forma_pago = 24
  and descripcion = ah_cta_banco
  and a.num_operacion = c.num_operacion

  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 6 >--
--> ********** <--
--> ********** <--
--> TA00340000 <--
--> ********** <--BB2020pre
--> ********** <--

--> DEBE DE CORRERSE DESPUES DEL AUTOMATICO PORQUE SE SACAN LOS REVERSOS Y SE LOS DEBITA

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega isnull VMT
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 16670
  and hm_causa in ('198')
  and hm_correccion = 'S'
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('3', '4')

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CC0001'

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega isnull VMT
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 16670
  and hm_causa in ('198')
  and hm_correccion = 'S'
  and cc_categoria in ('R')
  and cc_tipo_contable not in ('3', '4')

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CC0011'


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0))--Ref24 se agrega isnull VMT
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 16670
  and hm_causa in ('198')
  and hm_correccion = 'S'
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3')

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CC0017'

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega isnull VMT
from cob_cuentas_his..cc_his_movimiento, cob_cuentas..cc_ctacte (index cc_ctacte_Key)	-- ref: 9
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_cta_banco = cc_cta_banco
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 16670
  and hm_causa in ('198')
  and hm_correccion = 'S'
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('4')

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CC0018'


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega isnull
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran = 16669
  and hm_causa in ('190')
  and ah_categoria not in ('R', 'K', 'H')
  and hm_correccion = 'S'


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CA0001'


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0)) --Ref24 se agrega isnull VMT
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran = 16669
  and hm_causa in ('190')
  and ah_categoria in ('K', 'H')
  and hm_correccion = 'S'


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CA0007'

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0), @valor = sum(isnull(hm_valor,0))--Ref24 se agrega isnull VMT
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran = 16669
  and hm_causa in ('190')
  and ah_categoria in ('R')
  and hm_correccion = 'S'


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(@valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - @cont
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = 'TA00340000'
  and cd_tipo_producto = 'CA0021'


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< ref: 7 >-- Agregar nuevos servicios
--> ********** <--
--> ********** <--
--> TA00520000 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'I',
    @i_servicio     = 'TA00520000',
    @i_descripcion  = 'Servicio de transferencia de fondos a una cuenta en otro Banco.',
    @i_tarifa       = 0.36 --Ref54 Modifica tarifa --0.45 --0.5 --< ref:37 >--cambiar tarifa

select @valor = 0, @cont = 0

truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('820','823','825','828','667','669','693','695','492', '568' , '494' ) /*<REF 68>*/ /*< ref:37 >agregar causas a la trx 3050*/   /*< ref:52 >*/
  and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')			  --< ref:37 >--agregar solo los usuarios
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos

insert into ##datos
select hm_cta_banco, isnull(hm_valor, 0)
from cob_cuentas_his..cc_his_movimiento mov
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('820','823','825','828','667','669','693','695','492','910') --< ref:37 >--agregar causas a la trx 3050   --< ref:52 >
  and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')   			  --< ref:37 >--agregar solo los usuarios
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

/*truncate table ##correccion

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end*/


insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref51 agrega campos nuevos
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, 'CC0001', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), @i_tarifa,
    '','','',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)) --Ref51 agrega campos nuevos
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('3', '4')


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref51 agrega campos nuevos
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, 'CC0011', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), @i_tarifa,
    '','','',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)) --Ref51 agrega campos nuevos

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos
where cc_cta_banco = cuenta
  and cc_categoria in ('R')

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref51 agrega campos nuevos
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, 'CC0017', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), @i_tarifa,
    '','','',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)) --Ref51 agrega campos nuevos

from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos
where cc_cta_banco = cuenta
  and cc_categoria in ('N')	--('R')   	--< Ref:37 >-- Cambiar la categoria a N segun CU
  and cc_tipo_contable in ('3','4')


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

set @i_producto = 4

truncate table ##correccion
--truncate table ##datos

  if @@error <> 0
     begin
        print 'ERROR AL eliminar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##correccion
select hm_sec_correccion
from cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4264, 4272 , 4262 )						  /*<REF 68>*/
  and hm_causa in ('820','825','823','828','667','669','693','695','560', '500' , '562' ) /*<REF 68>*/   /*< ref:52 >*/
  and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')			  --< ref:37 >--agregar solo los usuarios
  and hm_correccion = 'S'


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##datos

insert into ##datos
select hm_cta_banco, isnull(hm_valor, 0)
from cob_ahorros_acum..ah_his_mov_a06 mov
where hm_tipo_tran in (4264, 4272)
  and hm_causa in ('820','825','823','828','667','669','693','695','560','910')   --< ref:52 >
  and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')			  --< ref:37 >--agregar solo los usuarios
  and hm_correccion = 'N'
  and not exists(select 1 from ##correccion  where hs_ssn_corr = mov.hm_secuencial)

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

/*truncate table ##correccion
  if @@error <> 0
     begin
        print 'ERROR AL eliminar en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end*/

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref51 agrega campos nuevos
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, 'CA0001', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, isnull(count(1), 0), @i_tarifa,
    round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2), @i_tarifa,
     '','','',round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2),(isnull(sum(isnull(valor, 0)), 0) - round(isnull(sum(isnull(valor, 0)), 0)/@w_porcIva,2)) --Ref51 agrega campos nuevos
from cob_ahorros..ah_cuenta, ##datos
where ah_cta_banco = cuenta

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--Ref014:JCV - inicio cambios para el servicio TA00520000
--para la transacción 3050

--> ********** <--
--> ********** <--
--> TD00271007 <--
--> ********** <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio     = 'TD00271007',
    @i_descripcion  = 'Servicio emision de cheque sobre instituciones bancarias del exterior en que el Banco tiene cuenta',
    @i_tarifa       = 5.36, --Ref54 cambio tarifa --6,
    @i_tipo_producto    = '',
    @i_tipo_cliente     = ''

--> Sacar reversos
--truncate table ##correccion
--truncate table ##datos

select @cont = 0, @valor = 0

select
    @cont = isnull(count(1), 0),
    @valor = sum(isnull(hm_valor,0))--Ref24 se agrega isnull VMT

from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '959'
  and hm_correccion = 'S'

select
    @cont = isnull(count(1), 0) - @cont,
    @valor = sum(isnull(hm_valor,0)) - @valor --Ref24 se agrega isnull VMT
from
    cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '959'
  and hm_correccion = 'N'

--< CALCULO DE TASA PONDERADA >--
truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

insert into ##2datos
select count(1),  hm_valor
from     cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa = '959'
  and hm_correccion = 'N'
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--< SACA DATOS DE LA TABLAS DE AHORROS

select
    @cont = @cont - isnull(count(1), 0),
    @valor = @valor - sum(hm_valor)
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264)
  and hm_causa in ('959')
  and hm_correccion = 'S'

select
    @cont = isnull(count(1), 0) + @cont,
    @valor = isnull(sum(hm_valor), 0) + @valor
from
    cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264)
  and hm_causa in ('959')
  and hm_correccion = 'N'

insert into ##2datos
select count(1),  hm_valor
from     cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4272, 4264)
  and hm_causa in ('959')
  and hm_correccion = 'N'
  group by hm_valor

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end


select @valor2 =
sum
   (
     (
       valor
       *
       cantidad
     )
     /
     sum(cantidad)
   )
from ##2datos

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada)
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    isnull(@valor, 0), isnull(@valor2, 0)


  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

--> ********** <--
--> ********** <--
--> TA00460000 <--
--> ********** <--
--> ********** <--

--> Se saca solo los reversos para restarlos, los valores originales se saca en el automatico
select
    @i_producto     = 3,
    @i_canal        = 'O',
    @i_servicio     = 'TA00460000'

truncate table ##datos_sib   --Ref50 cambiar tabla de trabajo

insert into ##datos_sib							--Ref50
select hm_cta_banco, isnull(hm_valor, 0),hm_oficina,
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton

from cob_cuentas_his..cc_his_movimiento a
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (3050)
  and hm_causa in ('940')
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hm_correccion = 'S'

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos_resp						--Ref50
insert into ##3datos_resp						--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('4', '3')
group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad

from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib			-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria in ('R')
  and cc_tipo_contable not in ('4', '3')
group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad

from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0011'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3')
group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL insertar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad

from cob_super..cc_detalle_a06, ##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('4')
  group by provincia,canton

   if @@error <> 0
      begin
         print 'ERROR AL insertar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
         return 9991
     end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad

from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0018'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

select
    @i_producto     = 4,
    @i_canal        = 'O',
    @i_servicio     = 'TA00440000'

truncate table ##datos_sib

insert into ##datos_sib
select hm_cta_banco, isnull(hm_valor, 0),hm_oficina,    --Ref50 arega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_ahorros_acum..ah_his_mov_a06  a
where hm_tipo_tran in (4264, 4272)
  and hm_causa in ('940')
  and hm_usuario not in ('ope998', 'SAT', 'srolese', 'kiosko', 'IVR', 'SROLESE')
  and hm_correccion = 'S'


    if @@error <> 0
       begin
          print 'ERROR AL modificar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
          return 9991
     end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria not in ('R', 'H', 'K')
  group by provincia,canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06, ##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0001'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

  if @@error <> 0
     begin
        print 'ERROR AL modificar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria in ('R')
group by provincia,canton

if @@error <> 0
    begin
        print 'ERROR AL insertar ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0021'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria in ('H', 'K')
  group by provincia,canton

if @@error <> 0
    begin
        print 'ERROR AL insertar  ##3datos_resp , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0007'
  and cd_tipo_cliente = 'T'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

--> ********** <--
--> ********** <--
--> TA00250000 <--
--> ********** <--
--> ********** <--

--> Se saca solo los reversos para restarlos, los valores originales se saca en el automatico
select
    @i_producto     = 4,
    @i_canal        = 'C',
    @i_servicio     = 'TA00250000'

truncate table ##datos_sib

insert into ##datos_sib
select hm_cta_banco, isnull(hm_valor, 0),hm_oficina,    --Ref50 arega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_ahorros_acum..ah_his_mov_a06 a
where hm_tipo_tran in (16663, 16673)
  and hm_correccion = 'S'

if @@error <> 0
    begin
        print 'ERROR AL insertar ##datos_sib , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria not in ('R', 'H', 'K')
  group by provincia,canton


if @@error <> 0
    begin
        print 'ERROR AL insertar ##datos_sib , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0001'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton


if @@error <> 0
    begin
        print 'ERROR AL modificar cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

--Ref50 agrega filtro canton
truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria in ('H', 'K')
  group by provincia,canton

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0007'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton
if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_ahorros..ah_cuenta, ##datos_sib
where ah_cta_banco = cuenta
  and ah_categoria in ('R')
group by provincia,canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CA0021'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

select
    @i_producto     = 3,
    @i_canal        = 'C',
    @i_servicio     = 'TA00250000'

truncate table ##datos_sib			--Ref50 modifica nombre tabla temporal

insert into ##datos_sib				--Ref50 modifica nombre tabla temporal
select hm_cta_banco, isnull(hm_valor, 0),hm_oficina,    --Ref50 arega oficina
(select provincia from #tmp_lugar_sib where of_oficina=a.hm_oficina) ,   --Ref50 agrega provincia
(select canton from #tmp_lugar_sib where of_oficina=a.hm_oficina)   	  ---Ref50 agrega canton
from cob_cuentas_his..cc_his_movimiento a
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran in (16664, 16674)
  and hm_correccion = 'S'
if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end


truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp							--Ref50
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref:9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable not in ('4', '3')
  group by provincia,canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0001'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton
if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton		--Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria in ('R')
  and cc_tipo_contable not in ('4', '3')
 group by provincia,canton									--Ref50 agrega agrupacion provincia y canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0011'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton		--Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('3')
 group by provincia,canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end


update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0017'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

truncate table ##3datos_resp							--Ref50
insert into ##3datos_resp
select isnull(count(1), 0),isnull(sum(valor), 0),provincia,canton		--Ref50
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos_sib		-- ref: 9
where cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipo_contable in ('4')

update cob_super..cc_detalle_a06
set cd_ingreso_total  = cd_ingreso_total  - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_ingreso_neto   = cd_ingreso_neto   - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_base_imponible = cd_base_imponible - round(isnull(valor,0)/@w_porcIva,2),			--Ref50 deflactacion de valores
    cd_iva_pagado     = cd_iva_pagado 	  - (isnull(valor,0) - round(isnull(valor,0)/@w_porcIva,2)),	--Ref50 deflactacion de iva
    cd_numero_trans = cd_numero_trans - cantidad
from cob_super..cc_detalle_a06,##3datos_resp
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio
  and cd_canal = @i_canal
  and cd_tipo_producto = 'CC0018'
  and cd_tipo_cliente = 'T'
  and cd_prop_canal='P'
  and cd_cod_provincia = provincia								--Ref50 agrega filtro provincia
  and cd_cod_canton = canton									--Ref50 agrega filtro canton

if @@error <> 0
    begin
        print 'ERROR AL cc_detalle_a06 cc_detalle_a06 , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
    end

--< ref: 7 >-- Agregar nuevos servicios - fin


---< ref:37 >---pholguiv 2017/03/22 Agregar nuevos servicios TB01480000 , TA01630000 y TB01350000


---Ref54 --Consumos internacionales
--Extraer tran15 medianet

select hl_tsfecha, hl_cuenta1, hl_valor,convert(int,isnull(substring(b.hl_referencia5,12,15),'0')) referencia into #log_tran_15
from cob_atm..at_his_logtran b
inner join cob_atm..at_ptl_ruteo_tran c on rt_trn=hl_trn
where hl_tsfecha>=@i_fecha_ini and hl_tsfecha<=@i_fecha_fin
 and rt_proceso_origen ='15' and rt_sp='sp_at_ptl_compra' and substring(rt_codigo_de_transaccion,1,2)='00'

 if @@error!= 0
    begin
      print 'ERROR AL insertar log_tran_15'
      return 9999  --salimos por error
    end

--Extraer tran14 Credimatic

select hl_tsfecha, hl_cuenta1, hl_valor  into #log_tran_14
from cob_atm..at_his_logtran b
inner join cob_atm..at_ptl_ruteo_tran  c on rt_trn=hl_trn
where hl_tsfecha>=@i_fecha_ini and hl_tsfecha<=@i_fecha_fin
and rt_proceso_origen ='14' and rt_sp='sp_at_ptl_compra' and substring(rt_codigo_de_transaccion,1,2)='00'

 if @@error!= 0
    begin
      print 'ERROR AL insertar log_tran_14'
      return 9999  --salimos por error
    end

------------------------------------------------
--- Crea indice a la tabla Temp --< Ref : 3 >---
------------------------------------------------
create nonclustered index i_movi_cost_prod_tmp on #log_tran_15 (hl_cuenta1,hl_tsfecha)
create nonclustered index i_movi_cost_prod_temp2 on #log_tran_14 (hl_cuenta1,hl_tsfecha)

--------------------------------------------------------------------------------
--Llamar al sp de extracion detalle de datos para los costeos   --< Ref : 3 >---
--------------------------------------------------------------------------------

Exec @w_error =pa_i_consumo_tarjeta06
    @e_fecha_ini   =@i_fecha_ini,
    @e_fecha_fin   =@i_fecha_fin

 if @@error!= 0 or @w_error!= 0
    begin
      print 'ERROR AL llamar sp pa_i_consumo_tarjeta06'
      return 9999  --salimos por error
    end


--Ref54 Ini -consumos internacionales



--> ********** <--
--> TA01630000 <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'I',
    @i_servicio     = 'TA01630000',
    @i_descripcion  = 'Pagos por obligaciones contraidas con tarjetas de credito, realizados en canales de otra entidad',
    @i_tarifa       = 0.34, --Ref54 modifica tarifa --0.45,
    @i_tipo_producto    = null,
    @i_tipo_cliente     = 'T'

--> Sacar reversos
--truncate table ##correccion
--truncate table ##datos

select @cont = 0, @valor = 0

select @cont  = count(1),
       @valor = isnull(sum(isnull(hm_valor,0)),0)
from cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('791','795','793','797','494')
  and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'S'

select @cont = isnull(count(1), 0) - isnull(@cont,0),
       @valor = isnull(sum(isnull(hm_valor,0)),0) - @valor
from  cob_cuentas_his..cc_his_movimiento
where hm_fecha >= @i_fecha_ini
  and hm_fecha <= @i_fecha_fin
  and hm_oficina >= 0
  and hm_moneda = 1
  and hm_tipo_tran = 3050
  and hm_causa in ('791','795','793','797','494' ,  '500' , '910' )	/*<REF 68 thernanp REF 68>*/
   and hm_usuario in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'N'

--< SACA DATOS DE LA TABLAS DE AHORROS y BASICA >--

select @cont  = @cont - isnull(count(1), 0),
       @valor = @valor - isnull(sum(isnull(hm_valor,0)),0)
from  cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (120060 ,4272 )
  and hm_causa  in ('791','795')
  and hm_usuario  in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'S'

select @cont = isnull(count(1), 0) + @cont,
       @valor = @valor + isnull(sum(isnull(hm_valor,0)),0)
from  cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (120060 ,4272 )
  and hm_causa in ('791','795')
  and hm_usuario  in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'N'


select @cont = @cont - isnull(count(1), 0),
       @valor = @valor - isnull(sum(isnull(hm_valor,0)),0)
from  cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4264  ,4272 )
  and hm_causa in ('793','797','562')
  and hm_usuario  in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'S'

select @cont = isnull(count(1), 0) + @cont,
       @valor =  @valor + isnull(sum(isnull(hm_valor,0)),0)
from  cob_ahorros_acum..ah_his_mov_a06
where hm_tipo_tran in (4264  ,4272 )
  and hm_causa in ('793','797','562',  '504' , '910' )		/*<REF 68 thernanp REF 68>*/
  and hm_usuario  in ('ope998','srolese', 'cpv001','WAP', 'SROLESE')
  and hm_correccion = 'N'


-- Ingreso de trx en A06 --
insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado  --Ref51 valor deflactado
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    round(isnull(@valor,0)/@w_porcIva,2), 0,							--Ref51 valor deflactado
    '','','',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2)) --Ref51 valor deflactado

if @@error<>0
   return 9999


--> ********** <--
--> TB01350000 <--
--> ********** <--

select
    @i_producto     = 3,
    @i_canal        = 'I',
    @i_servicio     = 'TB01350000',
    @i_descripcion  = 'Pagos por obligaciones contraidas con tarjetas de credito realizadas por cualquier canal de la entidad emisora.',
    @i_tarifa       = 0.00,
    @i_tipo_producto    = null,
    @i_tipo_cliente     = 'T'

--> Sacar reversos
--truncate table ##correccion
--truncate table ##datos

select @cont = 0, @valor = 0

select @cont = isnull(@cont,0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
  and isnull(hs_causa,'0') in ( '0','24','51')
  and hs_usuario in  ('WAP','ope998','srolese', 'SROLESE')
  and hs_correccion = 'S'

select @cont = isnull(count(1), 0) - @cont
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
  and isnull(hs_causa,'0') in ( '0','24','51')
  and hs_usuario in  ('WAP','ope998','srolese', 'SROLESE')
  and hs_correccion = 'N'

  select @cont = @cont - isnull(count(1), 0)
  from cob_cuentas_his..cc_his_servicio
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
    and isnull(hs_causa,'0') in ( '0','24','51')
    and hs_usuario in  ('rutaatm')
    and hs_servicio = 'BPD'
    and hs_correccion = 'S'

 select @cont = isnull(count(1), 0) + @cont
  from cob_cuentas_his..cc_his_servicio
  where hs_tsfecha >= @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
    and isnull(hs_causa,'0') in ( '0','24','51')
    and hs_usuario in  ('rutaatm')
    and hs_servicio = 'BPD'
    and hs_correccion = 'N'


-- Ingreso de trx en A06 --
insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado  --Ref51 valor deflactado
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, @i_tipo_producto, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    isnull(@valor, 0), 0,
    '','','',0,0,0 --Ref51 valor deflactado


if @@error<>0
   return 9999


select  @i_canal        = 'O'

--> Sacar reversos
--truncate table ##correccion
--truncate table ##datos

select @cont = 0, @valor = 0

select @cont = isnull(count(1), 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion  in (3177,3333 ,3413 ,16642 ,16643 )
  and isnull(hs_causa,'0') in ( '0','24','51')
  and hs_usuario in (select fu_login from cobis..cl_funcionario)
  and hs_usuario not in ('WAP','ope998','srolese','rutaatm', 'SROLESE')
  and hs_correccion = 'S'

select @cont = isnull(count(1), 0) - @cont
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion  in (3177,3333 ,3413 ,16642 ,16643)
  and isnull(hs_causa,'0') in ( '0','24','51')
  and hs_usuario in (select fu_login from cobis..cl_funcionario)
  and hs_usuario not in ('WAP','ope998','srolese','rutaatm', 'SROLESE')
  and hs_correccion = 'N'

-- Ingreso de trx en A06 --
insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
    )
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, @i_tipo_producto, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    '', isnull(@cont, 0), @i_tarifa,
    round(isnull(@valor,0)/@w_porcIva,2), 0,
     'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50



if @@error<>0
   return 9999


   select  @i_canal        = 'C'
   --> Sacar reversos
   --truncate table ##correccion
   --truncate table ##datos

   select @cont = 0, @valor = 0

  select @cont =isnull(count(1), 0)
     from cob_cuentas_his..cc_his_servicio
     where hs_tsfecha >= @i_fecha_ini
       and hs_tsfecha <= @i_fecha_fin
       and hs_oficina >= 0
       and hs_moneda = 1
       and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
       and isnull(hs_causa,'0') in ( '0','24','51')
       and hs_usuario in  ('rutaatm')
       and hs_servicio = 'ATM'
       and hs_correccion = 'S'

 select @cont = isnull(count(1), 0) - @cont
     from cob_cuentas_his..cc_his_servicio
     where hs_tsfecha >= @i_fecha_ini
       and hs_tsfecha <= @i_fecha_fin
       and hs_oficina >= 0
       and hs_moneda = 1
       and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
       and isnull(hs_causa,'0') in ( '0','24','51')
       and hs_usuario in  ('rutaatm')
       and hs_servicio = 'ATM'
       and hs_correccion = 'N'


   -- Ingreso de trx en A06 --
   insert into cob_super..cc_detalle_a06
       (cd_producto, cd_fecha_corte, cd_canal,
       cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
       cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
       cd_tipo_cliente, cd_numero_trans, cd_tarifa,
       cd_ingreso_total, cd_tasa_ponderada,
       cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
       )
   select  @i_producto, @i_fecha_fin, @i_canal,
       @i_servicio, @i_tipo_producto, @i_descripcion,
       null, null, substring(@i_servicio, 1, 2),
       '', isnull(@cont, 0), @i_tarifa,
       round(isnull(@valor,0)/@w_porcIva,2), 0,
       'P','09','01',round(isnull(@valor,0)/@w_porcIva,2),round(isnull(@valor,0)/@w_porcIva,2),(isnull(@valor,0) - round(isnull(@valor,0)/@w_porcIva,2))  --Ref50

   if @@error<>0
   return 9999


 select  @i_canal  = 'E'
   --> Sacar reversos
 --truncate table ##correccion
 --truncate table ##datos

 select @cont = 0, @valor = 0

select @cont = count(1)
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
 and hs_tsfecha <= @i_fecha_fin
 and hs_oficina >= 0
 and hs_moneda = 1
 and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
 and isnull(hs_causa,'0') in ( '0','24','51')
 and hs_usuario in ('SPAGOS')
 and hs_correccion = 'S'

select @cont = isnull(count(1), 0) - isnull(@cont,0)
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
 and hs_tsfecha <= @i_fecha_fin
 and hs_oficina >= 0
 and hs_moneda = 1
 and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
 and isnull(hs_causa,'0') in ( '0','24','51')
 and hs_usuario in ('SPAGOS')
 and hs_correccion = 'N'


-- Ingreso de trx en A06 --
insert into cob_super..cc_detalle_a06
 (cd_producto, cd_fecha_corte, cd_canal,
 cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
 cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
 cd_tipo_cliente, cd_numero_trans, cd_tarifa,
 cd_ingreso_total, cd_tasa_ponderada)
 select  @i_producto, @i_fecha_fin, @i_canal,
 @i_servicio, @i_tipo_producto, @i_descripcion,
 null, null, substring(@i_servicio, 1, 2),
 '', isnull(@cont, 0), @i_tarifa,
 isnull(@valor, 0), 0

 if @@error<>0
    return 9999

select  @i_canal  = 'N'
   --> Sacar reversos
 --truncate table ##correccion
 --truncate table ##datos

 select @cont = 0, @valor = 0

select @cont = count(1)
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
 and hs_tsfecha <= @i_fecha_fin
 and hs_oficina >= 0
 and hs_moneda = 1
 and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
 and isnull(hs_causa,'0') in ( '0','24','51')
 and hs_usuario in ('cnb001')
 and hs_correccion = 'S'

select @cont = isnull(count(1), 0) - isnull(@cont,0)
 from cob_cuentas_his..cc_his_servicio
 where hs_tsfecha >= @i_fecha_ini
 and hs_tsfecha <= @i_fecha_fin
 and hs_oficina >= 0
 and hs_moneda = 1
 and hs_tipo_transaccion in (3177,3333 ,3413 ,16642 ,16643 )
 and isnull(hs_causa,'0') in ( '0','24','51')
 and hs_usuario in ('cnb001')
 and hs_correccion = 'N'


-- Ingreso de trx en A06 --
insert into cob_super..cc_detalle_a06
 (cd_producto, cd_fecha_corte, cd_canal,
 cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
 cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
 cd_tipo_cliente, cd_numero_trans, cd_tarifa,
 cd_ingreso_total, cd_tasa_ponderada)
 select  @i_producto, @i_fecha_fin, @i_canal,
 @i_servicio, @i_tipo_producto, @i_descripcion,
 null, null, substring(@i_servicio, 1, 2),
 '', isnull(@cont, 0), @i_tarifa,
 isnull(@valor, 0), 0

 if @@error<>0
    return 9999


---< ref:37 >--- fin agregar nuevos servicios

---< ref: 12 >---Agregar, Modificaciones y eliminacion de servicios luego de todo el proceso, segun requerimiento
-----------------------------------------------------------------------------------------------------------------

--Si el tipo producto es CA0016 y son de tarifas basicas TB entoces colocar valor 0 en el campo Ingreso Total
update cob_super..cc_detalle_a06
set cd_ingreso_total = 0,
    cd_ingreso_neto = 0,		--Ref50 encerar valores
    cd_base_imponible = 0, 		--Ref50 encerar valores
    cd_iva_pagado = 0		--Ref50 encerar valores
where cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio like 'TB%'

 if @@error<>0
   return 9999


---Ingreso Manual de registro con valores en cero

--> ********** <--
--> ********** <--
--> TB00880000 <--
--> ********** <--
--> ********** <--

--Eliminacion del registro con canal 'D' segun requerimiento.
select @cont=5000,@w_error=0
set rowcount 5000

while @cont=5000
begin

	delete  from cc_detalle_a06 where cd_fecha_corte = @i_fecha_fin
	and cd_canal ='D' and cd_producto!=155  --< Ref:37 > se eliminan solo los que son diferentes de producto tarjeta

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0

--Para todos las tarifas valor null se colocaran valor cero
select @cont=5000,@w_error=0
set rowcount 5000

while @cont=5000
begin

	update cob_super..cc_detalle_a06
	set cd_tarifa = 0
	where  cd_fecha_corte = @i_fecha_fin
	and cd_tarifa is null

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0

--Para todos las valor_total que tengan valor null se colocaran valor cero
select @cont=5000,@w_error=0
set rowcount 5000

while @cont=5000
begin

	update cob_super..cc_detalle_a06
	set cd_ingreso_total = 0
	where  cd_fecha_corte = @i_fecha_fin
	and cd_ingreso_total  is null

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0


--Se debe dejar un solo registro para el servicio TD00251007 con datos en cero
Select @i_servicio  = 'TD00251007',@cont=0

Select @cont = count(1) from cob_super..cc_detalle_a06
where  cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio

if @cont >0
begin

   select @cont = @cont-1
   set rowcount @cont

   --Eliminamos dejando solo un registro del servicio
   delete from cob_super..cc_detalle_a06
	where  cd_fecha_corte = @i_fecha_fin
  	and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

   set rowcount 0

   --Enceramos los valores del registro
   update cob_super..cc_detalle_a06
    set cd_ingreso_total = 0,
        cd_numero_trans  = 0,
	cd_ingreso_neto = 0,		--Ref50 encerar valores
	cd_base_imponible = 0, 		--Ref50 encerar valores
	cd_iva_pagado = 0,		--Ref50 encerar valores
        cd_tipo_producto = null,
	cd_tasa_ponderada = null
   where cd_fecha_corte = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

end


--Se debe dejar un solo registro para el servicio TB00870000 con datos en cero
Select @i_servicio  = 'TB00870000',@cont=0

Select @cont = count(1) from cob_super..cc_detalle_a06
where  cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio

if @cont >0
begin

   select @cont = @cont-1
   set rowcount @cont

   --Eliminamos dejando solo un registro del servicio
   delete from cob_super..cc_detalle_a06
	where  cd_fecha_corte = @i_fecha_fin
  	and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

   set rowcount 0

   --Enceramos los valores del registro
   update cob_super..cc_detalle_a06
    set cd_ingreso_total = 0,
        cd_ingreso_neto = 0,		--Ref50 encerar valores
        cd_base_imponible = 0, 		--Ref50 encerar valores
        cd_iva_pagado = 0,		--Ref50 encerar valores
        cd_numero_trans  = 0,
        cd_tipo_producto = null,
	cd_tasa_ponderada = null
   where cd_fecha_corte = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

end


--Se debe dejar un solo registro para el servicio TB01000000 con datos en cero
Select @i_servicio  = 'TB01000000',@cont=0

Select @cont = count(1) from cob_super..cc_detalle_a06
where  cd_fecha_corte = @i_fecha_fin
  and cd_tipo_servicio = @i_servicio

if @cont >0
begin

   select @cont = @cont-1
   set rowcount @cont

   --Eliminamos dejando solo un registro del servicio
   delete from cob_super..cc_detalle_a06
	where  cd_fecha_corte = @i_fecha_fin
  	and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

   set rowcount 0

   --Enceramos los valores del registro
   update cob_super..cc_detalle_a06
     set cd_tipo_producto  = null,
	 cd_tasa_ponderada = null
   where cd_fecha_corte = @i_fecha_fin
     and cd_tipo_servicio = @i_servicio

   if @@error<>0
   return 9999

end


--Modificar los canales 'H' y 'R' con el codigo 'O'
select @cont=5000,@w_error=0
set rowcount 5000

while @cont=5000
begin

	update cob_super..cc_detalle_a06
	set cd_canal ='O' where cd_canal in ('H' , 'R') and cd_fecha_corte = @i_fecha_fin

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0


--Ref50 Modificar Ingreso neto,bruto e imponible son iguales
select @cont=1000,@w_error=0
set rowcount 1000

while @cont=1000
begin
	update cob_super..cc_detalle_a06
	set cd_ingreso_neto= round(isnull(cd_ingreso_total,0)/@w_porcIva,2),
	    cd_base_imponible = round(isnull(cd_ingreso_total,0)/@w_porcIva,2),
	    cd_iva_pagado= isnull(cd_ingreso_total,0) - round(isnull(cd_ingreso_total,0)/@w_porcIva,2),
	    cd_ingreso_total = round(isnull(cd_ingreso_total,0)/@w_porcIva,2),
	    cd_prop_canal='P',
	    cd_cod_provincia='09',
	    cd_cod_canton='01'
	    where cd_fecha_corte = @i_fecha_fin and cd_ingreso_total> 0
	    and cd_ingreso_neto=0
	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0

--Ref50 Modificar Ingreso neto,bruto e imponible son iguales
select @cont=2000,@w_error=0
set rowcount 2000

while @cont=2000
begin

	update cob_super..cc_detalle_a06
	set cd_prop_canal = '',cd_cod_provincia='',cd_cod_canton='', cd_tipo_cliente ='..'
	where cd_fecha_corte = @i_fecha_fin and cd_canal in ('I','F','M') and isnull(cd_tipo_cliente,'') != '..'

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0

--Ref50 Modificar Ingreso neto,bruto e imponible son iguales
select @cont=2000,@w_error=0
set rowcount 2000

while @cont=2000
begin

	update cob_super..cc_detalle_a06
	set cd_prop_canal = 'P'
	where cd_fecha_corte = @i_fecha_fin and cd_canal ='T' and cd_prop_canal not in ('O','P') and cd_cod_provincia!=''

	select @cont = @@rowcount,@w_error = @@error

	if @w_error<>0
	return 9999
end
set rowcount 0


--------------------------------------------------------------------------ref44 inicio
/*POR EL CANAL WAP SE HAN PARAMETRIZADO TRANSACCIONES QUE TIENE comisión PERO NO SE está OBTENIENDO LAS TRANSACCIONES
 QUE NO TIENEN comisión LAS CUALES HAY QUE CONTAR, POR TAL MOTIVO SE VA A INGRESAR UN REGISTRO PARA CONTEMPLAR LAS
 TRANSACCIONES SIN comisión.

*/
--Ref500 segun lo indicado por usuario no se debe realizar

------------------------------------------------------

--Incluir Nuevo servicio
--> ********** <--
--> ********** <--
--> TA00950000 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00950000',
	@i_descripcion		= '(Declaración sin efecto de cheque(s))(por evento para uno o varios cheques)',
	@i_tarifa		=  2.68 --Ref54 cambio tarifa  3


--< Saca registros validos,para estas trx no hay reversos
truncate table ##datos

insert into ##datos
select 	hs_cta_banco, isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 3581

if @@error<>0
return 9999


insert into ##datos
select 	hs_cta_banco, isnull(hs_valor, 0)
from cob_cuentas_his..cc_his_servicio
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion = 43468
  and hs_causa = '0'


if @@error<>0
return 9999

--< CC0001

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total, cd_tasa_ponderada,cd_prop_canal,
	cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado     --Ref50 agrega nuevos campos de valores
	)

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null, isnull(count(1), 0), @i_tarifa,
    	round(isnull(sum(isnull(valor, 0)), 0) /@w_porcIva,2), null,
    	'P','09','01',round(isnull(sum(isnull(valor, 0)), 0) /@w_porcIva,2),round(isnull(sum(isnull(valor, 0)), 0) /@w_porcIva,2),isnull(sum(isnull(valor, 0)), 0)- round(isnull(sum(isnull(valor, 0)), 0) /@w_porcIva,2)   --Ref50 agrega nuevos campos de valores
from cob_cuentas..cc_ctacte (index cc_ctacte_Key), ##datos
where cc_cta_banco = cuenta
  and cc_tipocta  in ('P','C')


if @@error<>0
return 9999

--------------------------------------------------------------------------ref44 fin
 --<REF 61, KBastida Reporte A06 Canal I Por TC INI Ref61 
select
	@i_producto		   	= 3,
	@i_canal		    = 'I',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepci?n de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		   	= 0, --TC No Cobra Tarifa
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3925)
  and hs_tipocta = 'T'
  and hs_contratado > 0
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3925)
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, @i_tarifa, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end

 update cob_super..cc_detalle_a06
 set cd_canal='I'
 where  cd_fecha_corte = @i_fecha_fin and cd_canal='C' and cd_tipo_servicio = 'TA01490000'

  if @@error <> 0
   begin
      print 'ERROR AL MODIFICAR CANAL EN SERVICIO TA01490000, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 61, KBastida Reporte A06 Canal I Por TC INI Ref61>

/*<REF 65 INI>*/
select
	@i_producto		   	= 3,
	@i_canal		    = 'I',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos Municipios',
	@i_tarifa		   	= 0, 
	@i_tipo_producto  	= null,
    @i_tipo_cliente   	= null

truncate table ##2datos
  if @@error <> 0
     begin
        print 'ERROR AL INSERTAR en table , Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
        return 9991
     end

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3215, 3216)
  and hs_causa in('7749','1417','2235','2237','2319','1430')
  and hs_tipocta = 'T'
  and hs_contratado > 0 
  and hs_correccion = 'S'

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end

  select @cont = sum(count(1)),@valor = sum(isnull(hs_monto,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3215, 3216)
    and hs_causa in('7749','1417','2235','2237','2319','1430')
    and hs_tipocta = 'T'
    and hs_contratado > 0
    and hs_correccion = 'N'
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, 0, round(isnull(@valor,0) /@w_porcIva,2), 0,
    '','','',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end

 update cob_super..cc_detalle_a06
 set cd_canal='I'
 where  cd_fecha_corte = @i_fecha_fin and cd_canal='C' and cd_tipo_servicio = 'TA01490000'

  if @@error <> 0
   begin
      print 'ERROR AL MODIFICAR CANAL EN SERVICIO TA01490000, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
/*<REF 65 FIN>*/

--------------------------------------------------------------------------ref045 inicio
--<REF 67
--> ********** <--
--> ********** <--
--> TA01420000 <--
--> ********** <--
--> ********** <--

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA01420000',
	@i_descripcion		= 'Renovacion de servicio Anual de Token Virtual', 
	@cont = 0,
	@valor = 0.00,
	@cont2 = 0,
	@valor2 = 0.00
	
-- SERVICIO EXONERADO
select @cont = count(1), @valor = isnull(sum(isnull(rd_valor_debito,0)),0)
                               from cob_atm..atm_t_renovacion_disp a
                               inner join cob_atm..at_entrust b
                                               on b.en_identidad= a.rd_identidad
                                               and b.en_login = a.rd_login
                               where a.rd_fec_cobro>= @i_fecha_ini
                               and a.rd_fec_cobro< dateadd(day,1,@i_fecha_fin)
                               and a.rd_tip_dispositivo = 2
                               and b.en_tip_cliente = 1
                               and a.rd_estado_deb = 'X'

select @cont2 = count(1), @valor2 = isnull(sum(isnull(rd_valor_debito,0)),0)
                               from cob_atm..atm_t_renovacion_disp a
                               inner join cob_atm..at_entrust b
                                               on b.en_identidad= a.rd_identidad
                                               and b.en_login = a.rd_login
                               where a.rd_fec_cobro>= @i_fecha_ini
                               and a.rd_fec_cobro< dateadd(day,1,@i_fecha_fin)
                               and a.rd_tip_dispositivo = 2
                               and b.en_ind_persona = 'P'
                               and b.en_tip_cliente = 0
                               and a.rd_estado_deb = 'X'

select @cont = @cont + @cont2
select @valor = @valor + @valor2

insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada, cd_cta_contable,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, '', @i_descripcion,
    '', '', substring(@i_servicio, 1, 2),
    '', @cont, 0,
	ROUND(isnull(@valor,0)/@w_porcIva,2), 0,'540614',
    'P','09','01',ROUND(isnull(@valor,0)/@w_porcIva,2),ROUND(isnull(@valor,0)/@w_porcIva,2), ROUND(isnull(@valor,0),2) - ROUND(isnull(@valor,0)/@w_porcIva,2)
	  	
if @@error <> 0
   begin
      print 'ERROR AL INSERTAR EN, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--REF 67>




select
	@i_producto		= 3,
	@i_canal		= 'C',
	@i_servicio     	= 'TA01610000',
	@i_descripcion		= 'Recaudaciones de pagos a terceros, a excepción de recaudaciones de tributos pagados con tarjetas',
	@i_tarifa		= 0.27, --Ref54 Modifca tarfia --0.31,---0.54,   Ref50 cambio de tarifa
	@i_tipo_producto    	= null,
    	@i_tipo_cliente     	= null

truncate table ##correccion
insert into ##correccion
select hs_ssn_corr
from cob_cuentas_his..cc_his_servicio s
where hs_tsfecha >= @i_fecha_ini
  and hs_tsfecha <= @i_fecha_fin
  and hs_oficina >= 0
  and hs_moneda = 1
  and hs_tipo_transaccion in (3366,3372)
  and hs_terminal = 'ATMB'
  and hs_correccion = 'S'
  and hs_valor > 0

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR ##correccion, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 9991
   end


  select @cont = sum(count(1)),@valor = sum(isnull(hs_valor,0))
  from cob_cuentas_his..cc_his_servicio s
  where hs_tsfecha >=  @i_fecha_ini
    and hs_tsfecha <= @i_fecha_fin
    and hs_oficina >= 0
    and hs_moneda = 1
    and hs_tipo_transaccion in (3366,3372)
    and hs_terminal = 'ATMB'
    and hs_correccion = 'N'
    and hs_valor > 0
  and hs_secuencial not in (select hs_ssn_corr from ##correccion)



insert into cob_super..cc_detalle_a06
    (cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada,
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado)  --Ref50 ingreso campo valores
select  @i_producto, @i_fecha_fin, @i_canal,
    @i_servicio, null, @i_descripcion,
    null, null, substring(@i_servicio, 1, 2),
    null, @cont, @i_tarifa, round(isnull(@valor,0) /@w_porcIva,2), 0,
    'P','09','01',round(isnull(@valor,0) /@w_porcIva,2),round(isnull(@valor,0) /@w_porcIva,2), isnull(@valor,0)- round(isnull(@valor,0) /@w_porcIva,2)  --Ref50 ingreso campo valores

   if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end


--Ref54  modificar canal segun lo solcitado por el usuario
 update cob_super..cc_detalle_a06
 set cd_canal='I'
 where  cd_fecha_corte = @i_fecha_fin and cd_canal='C' and cd_tipo_servicio = 'TA01490000'

  if @@error <> 0
   begin
      print 'ERROR AL MODIFICAR CANAL EN SERVICIO TA01490000, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end

--------------------------------------------------------------------------ref045 fin
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--<REF 70
   
   	exec cob_super..pa_proc_aper_caso_a06
		@e_fecha_ini    = @i_fecha_ini,
		@e_fecha_fin    = @i_fecha_fin
	if @@error <> 0
	begin
      print 'ERROR AL INSERTAR EN, cob_super..sp_proc_aper_caso_a06'
      return 99991
	end
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--REF 70>

--Ref50  pholguiv agrega variables de consulta
declare @v_prop_canal char(1),
	@v_cod_provincia char(2),
	@v_cod_canton char(2),
	@v_cargo_porcentaje money,
	@v_ingreso_neto money,
	@v_monto_base money,
	@v_base_imponible money,
	@v_iva_pagado money

--Ponderacion de registros duplicados segun critrio de campos
select
	@cont=0,
	@valor=0,
	@i_producto=3


--Ref50 pholguiv encerar valores
select @v_prop_canal ='',@v_cod_provincia='',@v_cod_canton ='',@v_cargo_porcentaje =0,@v_ingreso_neto =0,@v_monto_base =0,
       @v_base_imponible =0,@v_iva_pagado =0,@i_tarifa=0,@valor=0

--Agregar los registros de IVR segun la informacion ingresada
declare a06_ivr cursor
for
select pw_producto,pw_canal,pw_servicio,pw_descripcion,pw_tipo_tarifa, isnull(pw_cargo_dolares,0),sum(pw_cantidad),isnull(pw_prop_canal,''), isnull(pw_cod_provincia,''), isnull(pw_cod_canton,''),
       sum(isnull(pw_cargo_porcentaje,0)),sum(isnull(pw_ingreso_bruto,0)),sum(isnull(pw_ingreso_neto,0)), 	--Ref50 agrega campos nuevos
       sum(isnull(pw_monto_base,0)),sum(isnull(pw_base_imponible,0)),sum(isnull(pw_iva_pagado,0))  						--Ref50 agrega campos nuevos
from cob_internet..bv_parametros_wap
where pw_fecha_corte  >= @i_fecha_ini and pw_fecha_corte <=  @i_fecha_fin
group by pw_producto,pw_canal,pw_servicio,pw_descripcion,pw_tipo_tarifa,pw_cargo_dolares,pw_prop_canal, pw_cod_provincia, pw_cod_canton
order by  pw_producto,pw_canal,pw_servicio,pw_prop_canal, pw_cod_provincia, pw_cod_canton

for read only

open a06_ivr
fetch a06_ivr into @i_producto,@i_canal, @i_servicio,@i_descripcion,@w_tipo_tarifa,@i_tarifa,@cont,@v_prop_canal, @v_cod_provincia, @v_cod_canton,
		   @v_cargo_porcentaje,@valor,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado

while @@sqlstatus != 2
begin
	if @@sqlstatus = 1
	     begin
		close a06_ivr
		deallocate cursor a06_ivr
		return 9999
	     end

	if not exists (select 1 from cob_super..cc_detalle_a06 where cd_fecha_corte = @i_fecha_fin
                                and cd_tipo_servicio = @i_servicio
                                and cd_canal = @i_canal
                                and cd_tarifa=@i_tarifa
                                and cd_prop_canal = ltrim(rtrim(@v_prop_canal))
				and cd_cod_provincia = ltrim(rtrim(@v_cod_provincia))
				and cd_cod_canton= ltrim(rtrim(@v_cod_canton)))

	begin
		insert into cob_super..cc_detalle_a06
		(cd_producto, cd_fecha_corte, cd_canal,
		cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
		cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
		cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total, cd_prop_canal, cd_cod_provincia ,cd_cod_canton, cd_cargo_porcentaje,cd_ingreso_neto ,cd_monto_base ,cd_base_imponible, cd_iva_pagado)    --Ref50 : pholguiv

		values( @i_producto, @i_fecha_fin, @i_canal,
		@i_servicio, null, @i_descripcion,
		null, null, @w_tipo_tarifa,
		null, @cont, @i_tarifa,@valor, @v_prop_canal, @v_cod_provincia, @v_cod_canton,@v_cargo_porcentaje,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado)

		if @@error<>0
		begin
			close a06_ivr
			deallocate cursor a06_ivr
			return 9999
		end
        end
      else
        begin

		update cob_super..cc_detalle_a06
			set cd_numero_trans   = isnull(cd_numero_trans,0)   +  @cont,
			    cd_ingreso_total  = isnull(cd_ingreso_total,0)  +  @valor,
			    cd_ingreso_neto   = isnull(cd_ingreso_neto,0)   +  @v_ingreso_neto,
			    cd_base_imponible = isnull(cd_base_imponible,0) +  @v_base_imponible
		where  cd_fecha_corte = @i_fecha_fin
			and cd_tipo_servicio = @i_servicio
			and cd_canal = @i_canal
			and cd_tarifa = @i_tarifa
			and cd_prop_canal = ltrim(rtrim(@v_prop_canal))
			and cd_cod_provincia =  ltrim(rtrim(@v_cod_provincia))
			and cd_cod_canton =  ltrim(rtrim(@v_cod_canton))

		if @@error<>0
		begin
			close a06_ivr
			deallocate cursor a06_ivr
			return 9999
		end

         end


fetch a06_ivr into @i_producto,@i_canal, @i_servicio,@i_descripcion,@w_tipo_tarifa,@i_tarifa,@cont,@v_prop_canal, @v_cod_provincia, @v_cod_canton,
		   @v_cargo_porcentaje,@valor,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado
end
close a06_ivr
deallocate cursor a06_ivr

--Ponderacion de registros duplicados segun critrio de campos
select
	@cont=0,
	@valor=0,
	@i_producto=3


--Ref50 pholguiv encerar valores
select @v_prop_canal ='',
@v_cod_provincia='',
@v_cod_canton ='',
@v_cargo_porcentaje =0,
@v_ingreso_neto =0,
@v_monto_base =0,
@v_base_imponible =0,
@v_iva_pagado =0


declare ctas_a06 cursor
for

select cd_canal, cd_tipo_servicio,  isnull(cd_prop_canal, ''),cd_cod_provincia,cd_cod_canton,   --Ref50 campos nuevos
count(1) cont,sum(cd_ingreso_total) valor, sum(cd_numero_trans) num_trx,
sum(cd_cargo_porcentaje),sum(cd_ingreso_neto),sum(cd_monto_base),sum(cd_base_imponible),sum(cd_iva_pagado) -- JPM Ref.31      --Ref50 sumatorias nuevos campos
from cob_super..cc_detalle_a06
where cd_fecha_corte = @i_fecha_fin
group by cd_canal, cd_tipo_servicio,cd_prop_canal,cd_cod_provincia,cd_cod_canton
having count(1)>1
order by cd_tipo_servicio

for read only

open ctas_a06
fetch ctas_a06 into @i_canal, @i_servicio,@v_prop_canal,@v_cod_provincia,@v_cod_canton,
@cont,@valor, @cont2,@v_cargo_porcentaje,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado   -- JPM Ref.31        --Ref50 agrega variables

while @@sqlstatus != 2
begin
if @@sqlstatus = 1
     begin
        close ctas_a06
        deallocate cursor ctas_a06
        return 9999
     end

	select top 1
	@i_descripcion	 = cd_descripcion,  @w_tipo_tarjeta = cd_tipo_tarjeta,
	@w_clase_tarjeta = cd_clase_tarjeta,@w_tipo_tarifa  = cd_tipo_tarifa
	from cob_super..cc_detalle_a06
	where cd_fecha_corte = @i_fecha_fin
	and cd_canal=@i_canal
	and cd_tipo_servicio=@i_servicio
	and cd_prop_canal = @v_prop_canal
	and cd_cod_provincia = @v_cod_provincia
	and cd_cod_canton = @v_cod_canton
	if @@error<>0
	begin
		close ctas_a06
		deallocate cursor ctas_a06
		return 9999
	end

	--Ref50 maxima tarifa
	select  @i_tarifa= max(isnull(cd_tarifa,0))	
	from cob_super..cc_detalle_a06
	where cd_fecha_corte = @i_fecha_fin
	and cd_canal=@i_canal
	and cd_tipo_servicio=@i_servicio
	and cd_prop_canal = @v_prop_canal
	and cd_cod_provincia = @v_cod_provincia
	and cd_cod_canton = @v_cod_canton

	--Eliminamos registro del servicio
	delete from cob_super..cc_detalle_a06
	where cd_fecha_corte = @i_fecha_fin
	and cd_canal = @i_canal
	and cd_tipo_servicio = @i_servicio
	and cd_prop_canal = @v_prop_canal
	and cd_cod_provincia = @v_cod_provincia
	and cd_cod_canton = @v_cod_canton

	if @@error<>0
	begin
		close ctas_a06
		deallocate cursor ctas_a06
		return 9999
	end

	if @i_canal in ('I','F','M','V')
	select @v_prop_canal='',@v_cod_provincia='',@v_cod_canton=''

	insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa, cd_ingreso_total, cd_prop_canal, cd_cod_provincia ,cd_cod_canton, cd_cargo_porcentaje,cd_ingreso_neto ,cd_monto_base ,cd_base_imponible, cd_iva_pagado)    --Ref50 : pholguiv

	values( @i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, '', @i_descripcion,
	@w_tipo_tarjeta, @w_clase_tarjeta, substring(@i_servicio, 1, 2),
	'', @cont2, @i_tarifa, @valor,isnull(@v_prop_canal,''),isnull(@v_cod_provincia,''),isnull(@v_cod_canton,''),@v_cargo_porcentaje,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado)         -- JPM Ref.31: antes @cont

	if @@error<>0
	begin
	        close ctas_a06
	        deallocate cursor ctas_a06
	        return 9999
        end

     fetch ctas_a06 into @i_canal, @i_servicio,@v_prop_canal,@v_cod_provincia,@v_cod_canton,
     @cont,@valor, @cont2,@v_cargo_porcentaje,@v_ingreso_neto,@v_monto_base,@v_base_imponible,@v_iva_pagado   -- JPM Ref.31        --Ref50 agrega variables

end
close ctas_a06
deallocate cursor ctas_a06

--<REF 72
-- CAMBIOS EN LA EXTRACCION DE INFORMACION
--------------------------------------------------------------------------
--> ********** <--
--> ********** <--
--> TD00721007 <--
--> ********** <--
--> ********** <--
select
	@i_producto			= 3,
	@i_canal			= 'O',
	@i_servicio     	= 'TD00721007',
	@i_descripcion		= 'Depósito de cheques de remesas internacionales'

truncate table ##correccion
truncate table ##3datos2
truncate table ##temp_resporder
--<REF 73
insert into ##correccion
select hs_ssn_corr 
from cob_cuentas_his..cc_his_servicio a
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '985'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
		and hs_correccion = 'S'
		and hs_terminal <> 'ATMB'  
--REF 73>


insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
from cob_cuentas_his..cc_his_servicio a
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '985'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'  
		and hs_correccion = 'N'
		and hs_secuencial not in(select hs_ssn_corr from ##correccion) 
		group by hs_oficina, hs_monto, hs_valor


truncate table ##correccion

select
	@i_producto			= 4

insert into ##correccion
select hs_ssn_corr --REF 73
from cob_ahorros_his..ah_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
	and hs_tipo_transaccion = 4188 and hs_causa = '982'
	and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
	and hs_correccion = 'S'
	and hs_terminal <> 'ATMB'  


insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
from cob_ahorros_his..ah_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
	and hs_tipo_transaccion = 4188 and hs_causa = '982'
	and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
	and hs_terminal <> 'ATMB'  
	and hs_correccion = 'N'
	and hs_secuencial not in (select hs_ssn_corr from ##correccion)
	group by hs_oficina, hs_monto, hs_valor


insert into ##temp_resporder
select 
	sum(isnull(cantidad,0)),
	sum(isnull(valor,0)),
	provincia,
	canton, 
	round(round(sum(isnull(valor,0)),2)/sum(isnull(cantidad,0)),2), iva
	from ##3datos2
	group by provincia,canton, valor,iva
	
insert into cob_super..cc_detalle_a06(cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada, cd_cta_contable, 
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,
	cd_ingreso_neto,cd_base_imponible,cd_iva_pagado, cd_monto_base,cd_cargo_porcentaje)
select 
	cd_producto= @i_producto, cd_fecha_corte = @i_fecha_fin, cd_canal=@i_canal,
	cd_tipo_servicio=@i_servicio, cd_tipo_producto = null, cd_descripcion=@i_descripcion,
	cd_tipo_tarjeta=null,cd_clase_tarjeta=null,cd_tipo_tarifa=substring(@i_servicio, 1, 2),
	cd_tipo_cliente=null,cd_numero_trans = sum(cantidad), 
	cd_tarifa=tarifa,
	cd_ingreso_total=round(sum(isnull(valor, 0)),2),
	cd_tasa_ponderada=0,
	cd_cta_contable='540702',
	cd_prop_canal='P',
	cd_cod_provincia=provincia,
	cd_cod_canton=canton,
	cd_ingreso_neto=round(sum(isnull(valor, 0)),2),
	cd_base_imponible=round(sum(isnull(valor, 0)),2),
	cd_iva_pagado= iva*sum(cantidad),cd_monto_base=0,cd_cargo_porcentaje=0
	from ##temp_resporder
	group by provincia,canton,tarifa,iva


if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end

--------------------------------------------------------------------------
--> ********** <--
--> ********** <--
--> TD00781007 <--
--> ********** <--
--> ********** <--
select
	@i_producto			= 3,
	@i_canal			= 'O',
	@i_servicio     	= 'TD00781007',
	@i_descripcion		= 'Suspensión de pago de cheque sobre bancos extranjeros'

truncate table ##correccion
truncate table ##3datos2
truncate table ##temp_resporder

insert into ##correccion
select hs_ssn_corr --REF 73
from cob_cuentas_his..cc_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
	and hs_tipo_transaccion = 3188 and hs_causa = '644'
	and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
	and hs_terminal <> 'ATMB'  
	and hs_correccion = 'S'
	
	
insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
from cob_cuentas_his..cc_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
	and hs_tipo_transaccion = 3188 and hs_causa = '644'
	and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
	and hs_terminal <> 'ATMB'
	and hs_correccion = 'N'
	and hs_secuencial not in (select hs_ssn_corr from ##correccion)
	group by hs_oficina, hs_monto, hs_valor



select
	@i_producto			= 4


truncate table ##correccion


insert into ##correccion
select hs_ssn_corr --REF 73
from cob_ahorros_his..ah_his_servicio a
where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
	and hs_tipo_transaccion = 4188 and hs_causa = '197'
	and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
	and hs_terminal <> 'ATMB'  
	and hs_correccion = 'S'
		
insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2)
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
	from cob_ahorros_his..ah_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 4188 and hs_causa = '197'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'  
		and hs_correccion = 'N'
		and hs_secuencial not in (select hs_ssn_corr from ##correccion)
	group by hs_oficina, hs_monto, hs_valor


insert into ##temp_resporder
select 
	sum(isnull(cantidad,0)),sum(isnull(valor,0)),provincia,canton, round(round(sum(isnull(valor,0)),2)/sum(isnull(cantidad,0)),2), iva
	from ##3datos2
	group by provincia,canton, valor,iva
		
insert into cob_super..cc_detalle_a06(cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada, cd_cta_contable, 
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,
	cd_ingreso_neto,cd_base_imponible,cd_iva_pagado, cd_monto_base,cd_cargo_porcentaje)
select 
	cd_producto= @i_producto, cd_fecha_corte = @i_fecha_fin, cd_canal=@i_canal,
	cd_tipo_servicio=@i_servicio, cd_tipo_producto = null, cd_descripcion=@i_descripcion,
	cd_tipo_tarjeta=null,cd_clase_tarjeta=null,cd_tipo_tarifa=substring(@i_servicio, 1, 2),
	cd_tipo_cliente=null,cd_numero_trans = sum(cantidad), 
	cd_tarifa=tarifa,
	cd_ingreso_total=round(sum(isnull(valor, 0)),2),
	cd_tasa_ponderada=0,
	cd_cta_contable='540702',
	cd_prop_canal='P',
	cd_cod_provincia=provincia,
	cd_cod_canton=canton,
	cd_ingreso_neto=round(sum(isnull(valor, 0)),2),
	cd_base_imponible=round(sum(isnull(valor, 0)),2),
	cd_iva_pagado= iva*sum(cantidad),cd_monto_base=0,cd_cargo_porcentaje=0
	from ##temp_resporder
	group by provincia,canton,tarifa,iva
		
if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end



--------------------------------------------------------------------------
--> ********** <--
--> ********** <--
--> TA00830000 <--
--> ********** <--
--> ********** <--
select
	@i_producto			= 3,
	@i_canal			= 'O',
	@i_servicio     	= 'TA00830000',
	@i_descripcion		= 'SUSPENSIÓN TRANSITORIA DEL PAGO DE CHEQUE(S) (POR EVENTO PARA UNO O VARIOS CHEQUES)'

truncate table ##correccion
truncate table ##3datos2
truncate table ##temp_resporder

insert into ##correccion
select hs_ssn_corr --REF 73
from cob_cuentas_his..cc_his_servicio a
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '486'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','cpv001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'
		
insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
	from cob_cuentas_his..cc_his_servicio a
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '486'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','cpv001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'
		and hs_correccion = 'N'
		and hs_secuencial not in (select hs_ssn_corr from ##correccion)		
		group by hs_oficina, hs_monto, hs_valor


truncate table ##correccion


insert into ##correccion
select hs_ssn_corr --REF 73
		from cob_cuentas_his..cc_his_servicio a  
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <=  @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '486'
		and hs_usuario in ('srolese','ope998','cpv001','SAT','SROLESE')
		and hs_correccion = 'S'

insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
	from cob_cuentas_his..cc_his_servicio a
		where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion = 3188 and hs_causa = '486'
		and hs_usuario in ('srolese','ope998','cpv001','SAT','SROLESE')
		and hs_correccion = 'N'
		and hs_secuencial not in (select hs_ssn_corr from ##correccion)		
		group by hs_oficina, hs_monto, hs_valor


insert into ##temp_resporder
select 
	sum(isnull(cantidad,0)),sum(isnull(valor,0)),provincia,canton, round(round(sum(isnull(valor,0)),2)/sum(isnull(cantidad,0)),2), iva
	from ##3datos2
	group by provincia,canton, valor,iva
		
insert into cob_super..cc_detalle_a06(cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada, cd_cta_contable, 
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,
	cd_ingreso_neto,cd_base_imponible,cd_iva_pagado, cd_monto_base,cd_cargo_porcentaje)
select 
	cd_producto= @i_producto, cd_fecha_corte = @i_fecha_fin, cd_canal=@i_canal,
	cd_tipo_servicio=@i_servicio, cd_tipo_producto = null, cd_descripcion=@i_descripcion,
	cd_tipo_tarjeta=null,cd_clase_tarjeta=null,cd_tipo_tarifa=substring(@i_servicio, 1, 2),
	cd_tipo_cliente=null,cd_numero_trans = sum(cantidad), 
	cd_tarifa=tarifa,
	cd_ingreso_total=round(sum(isnull(valor, 0)),2),
	cd_tasa_ponderada=0,
	cd_cta_contable='540602',
	cd_prop_canal='P',
	cd_cod_provincia=provincia,
	cd_cod_canton=canton,
	cd_ingreso_neto=round(sum(isnull(valor, 0)),2),
	cd_base_imponible=round(sum(isnull(valor, 0)),2),
	cd_iva_pagado= iva*sum(cantidad),cd_monto_base=0,cd_cargo_porcentaje=0
	from ##temp_resporder
	group by provincia,canton,tarifa,iva
		

if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end
--------------------------------------------------------------------------
--> ********** <--
--> ********** <--
--> TA01540000 <--
--> ********** <--
--> ********** <--
select
	@i_producto			= 4,
	@i_canal			= 'O',
	@i_servicio     	= 'TA01540000',
	@i_descripcion		= 'Emisión del paquete de apertura de cuenta básica con tarjeta electrónica con chip'


truncate table ##correccion
truncate table ##3datos2
truncate table ##temp_resporder

insert into ##correccion
select hs_ssn_corr --REF 73
from cob_virtuales_his..vi_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion in (120061,120072)
		and ltrim(rtrim(hs_causa)) = '51'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'
		and hs_correccion = 'S'

insert into ##3datos2
select 
	count(1),
	sum(isnull(hs_valor, 0)),
	(select of_provincia 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
	(select substring(of_canton,3,2) 
		from cobis..cl_oficina 
		where of_oficina = a.hs_oficina),
 	(hs_monto - hs_valor)
	from cob_virtuales_his..vi_his_servicio a
	where hs_tsfecha >= @i_fecha_ini and hs_tsfecha <= @i_fecha_fin
		and hs_tipo_transaccion in (120061,120072)
		and ltrim(rtrim(hs_causa)) = '51'
		and hs_usuario not in ('ope998', 'srolese', 'IVR', 'SAT', 'kiosko','cnb001','SROLESE','WAP')
		and hs_terminal <> 'ATMB'
		and hs_correccion = 'N'
		and hs_secuencial not in (select hs_ssn_corr from ##correccion)		
		group by hs_oficina, hs_monto, hs_valor
	
insert into ##temp_resporder
select 
	sum(isnull(cantidad,0)),sum(isnull(valor,0)),provincia,canton, round(round(sum(isnull(valor,0)),2)/sum(isnull(cantidad,0)),2), iva
	from ##3datos2
	group by provincia,canton, valor,iva
	
insert into cob_super..cc_detalle_a06(cd_producto, cd_fecha_corte, cd_canal,
    cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
    cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
    cd_tipo_cliente, cd_numero_trans, cd_tarifa,
    cd_ingreso_total, cd_tasa_ponderada, cd_cta_contable, 
    cd_prop_canal,cd_cod_provincia,cd_cod_canton,
	cd_ingreso_neto,cd_base_imponible,cd_iva_pagado, cd_monto_base,cd_cargo_porcentaje)
select 
	cd_producto= @i_producto, cd_fecha_corte = @i_fecha_fin, cd_canal=@i_canal,
	cd_tipo_servicio=@i_servicio, cd_tipo_producto = null, cd_descripcion=@i_descripcion,
	cd_tipo_tarjeta=null,cd_clase_tarjeta=null,cd_tipo_tarifa=substring(@i_servicio, 1, 2),
	cd_tipo_cliente=null,cd_numero_trans = sum(cantidad), 
	cd_tarifa=tarifa,
	cd_ingreso_total=round(sum(isnull(valor, 0)),2),
	cd_tasa_ponderada=0,
	cd_cta_contable='540601',
	cd_prop_canal='P',
	cd_cod_provincia=provincia,
	cd_cod_canton=canton,
	cd_ingreso_neto=round(sum(isnull(valor, 0)),2),
	cd_base_imponible=round(sum(isnull(valor, 0)),2),
	cd_iva_pagado= iva*sum(cantidad),cd_monto_base=0,cd_cargo_porcentaje=0
	from ##temp_resporder
	group by provincia,canton,tarifa,iva


if @@error <> 0
   begin
      print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
      return 99991
   end

--REF 72>

---< Ref50 >---Agregar,Monto base

create table #trx_causa (tipo varchar(10),servicio varchar(12),trx int, causa varchar(3),rev char(1))


insert into #trx_causa values('O','TA00460000',3048,'915','')
insert into #trx_causa values('O','TA00460000',4253,'915','')

insert into #trx_causa values('O','TA00480000',120060,'790','')
insert into #trx_causa values('O','TA00480000',120060,'794','')
insert into #trx_causa values('O','TA00480000',120060,'819','')
insert into #trx_causa values('O','TA00480000',120060,'824','')
insert into #trx_causa values('O','TA00480000',3050,'976','')
insert into #trx_causa values('O','TA00480000',3050,'539','')
insert into #trx_causa values('O','TA00480000',4272,'976','')
insert into #trx_causa values('O','TA00480000',4264,'976','')
insert into #trx_causa values('O','TA00480000',4264,'473','')

--Ref:59 --
--insert into #trx_causa values('O','TA00490000',3048,'226','')
--insert into #trx_causa values('O','TA00490000',120059,'226','')
--insert into #trx_causa values('O','TA00490000',4253,'226','')

--insert into #trx_causa values('I','TA00490000',3048,'230','')
--insert into #trx_causa values('I','TA00490000',4253,'230','')
--insert into #trx_causa values('I','TA00490000',4272,'453','R')
--insert into #trx_causa values('I','TA00490000',3050,'453','R')

insert into #trx_causa values('I','TA00520000',3050,'665','')
insert into #trx_causa values('I','TA00520000',3050,'668','')
insert into #trx_causa values('I','TA00520000',3050,'692','')
insert into #trx_causa values('I','TA00520000',3050,'694','')
insert into #trx_causa values('I','TA00520000',3050,'493','')
insert into #trx_causa values('I','TA00520000',3050,'790','')
insert into #trx_causa values('I','TA00520000',3050,'792','')
insert into #trx_causa values('I','TA00520000',3050,'794','')
insert into #trx_causa values('I','TA00520000',3050,'796','')
insert into #trx_causa values('I','TA00520000',3050,'520','')
insert into #trx_causa values('I','TA00520000',3050,'819','')
insert into #trx_causa values('I','TA00520000',3050,'822','')
insert into #trx_causa values('I','TA00520000',3050,'824','')
insert into #trx_causa values('I','TA00520000',3050,'827','')
insert into #trx_causa values('I','TA00520000',3050,'740','')  --< ref:52 >
insert into #trx_causa values('I','TA00520000',4272,'819','')
insert into #trx_causa values('I','TA00520000',4272,'822','')
insert into #trx_causa values('I','TA00520000',4272,'824','')
insert into #trx_causa values('I','TA00520000',4272,'827','')
insert into #trx_causa values('I','TA00520000',4272,'665','')
insert into #trx_causa values('I','TA00520000',4272,'668','')
insert into #trx_causa values('I','TA00520000',4272,'692','')
insert into #trx_causa values('I','TA00520000',4272,'694','')
insert into #trx_causa values('I','TA00520000',4272,'520','')
insert into #trx_causa values('I','TA00520000',4262,'520','')
insert into #trx_causa values('I','TA00520000',4264,'520','')
insert into #trx_causa values('I','TA00520000',3404,'0','')
insert into #trx_causa values('I','TA00520000',3405,'0','')

insert into #trx_causa values('I','TA00520000',4404,'0','')
insert into #trx_causa values('I','TA00520000',4405,'0','')
insert into #trx_causa values('I','TA00520000',4272,'790','')
insert into #trx_causa values('I','TA00520000',4272,'792','')
insert into #trx_causa values('I','TA00520000',4272,'794','')
insert into #trx_causa values('I','TA00520000',4272,'796','')

insert into #trx_causa values('I','TA00520000',4272,'740','')  --< ref:52 >

--Ref:59 --comentar
--insert into #trx_causa values('O','TA00490000',3050,'464','C')
--insert into #trx_causa values('O','TA00490000',4272,'464','C')
--insert into #trx_causa values('O','TA00490000',120060,'464','C')


delete cob_super..cc_detalle_a06 where cd_fecha_corte = @i_fecha_fin and cd_tipo_servicio in ('TA00490000','TB01610000') --and cd_canal = 'O'
if @@error<>0
begin
	return 9999
end

select tipo,servicio, (case when rev ='R' then hm_valor *-1 else hm_valor end) monto,rev
into #valores
from cob_cuentas_his..cc_his_movimiento a,#trx_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and hm_tipo_tran =trx
and hm_causa=causa

if @@error<>0
begin
	return 9999
end

insert into #valores
select tipo, servicio,(case when rev ='R' then hm_valor *-1 else hm_valor end) monto,rev
from cob_ahorros_his..ah_his_movimiento a,#trx_causa
where hm_fecha>= @i_fecha_ini and hm_fecha<= @i_fecha_fin
and hm_tipo_tran =trx
and hm_causa=causa

if @@error<>0
begin
	return 9999
end

insert into #valores
select tipo, servicio,(case when rev ='R' then hm_valor *-1 else hm_valor end) monto,rev
from cob_virtuales_his..vi_his_movimiento a,#trx_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and hm_tipo_tran =trx
and hm_causa=causa

if @@error<>0
begin
	return 9999
end

---comision
--Ref:59 -- comentar servicio TA00490000, este ya no se ejecuta
/*
select tipo,servicio,sum(monto) val,count(1) cantidad into #totales_deb from #valores
where rev = 'C'
group by tipo,servicio

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TA00490000',
	@i_descripcion		= 'Servicio de acreditacion de  transferencias de fondos recibidas de clientes de otra entidad',
    	@i_tarifa       	= 0.2 --Ref54 --0.27-- 0.30 ---< ref: 12 >-Colocar la tarifa 1 segun requerimiento

--< CC0001 - CC0011

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,
	cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado				--Ref50
	)

select 	@i_producto, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0001', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null,cantidad, @i_tarifa,
        round(isnull(sum(isnull(val, 0)), 0)/@w_porcIva,2),
        'P','09','01', round(isnull(sum(isnull(val, 0)), 0)/@w_porcIva,2),round(isnull(sum(isnull(val, 0)), 0)/@w_porcIva,2),  (isnull(sum(isnull(val, 0)), 0) - round(isnull(sum(isnull(val, 0)), 0)/@w_porcIva,2))  --Ref50

from #totales_deb

if @@error<>0
begin
	return 9999
end
*/

--Ref:59 --

select
	@i_producto		= 3,
	@i_canal		= 'O',
	@i_servicio     	= 'TB01610000',
	@i_descripcion		= 'Servicio de acreditacion de  transferencias de fondos recibidas de clientes de otra entidad',
    	@i_tarifa       	= 0

----Ref:59 -- Agrega trx para reverso de servicio TB01610000

select @cont =0,@cont2 = 0

select @cont = count(1)
from cob_cuentas_his..cc_his_movimiento c
inner join cobis..cl_catalogo b on convert(varchar(10),c.hm_tipo_tran)= b.codigo and c.hm_causa = b.valor
inner join cobis..cl_tabla a on b.tabla = a.codigo
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and a.tabla ='cc_trx_causa_cred_rev'

select @cont = isnull(@cont,0) + count(1)
from cob_ahorros_his..ah_his_movimiento c
inner join cobis..cl_catalogo b on convert(varchar(10),c.hm_tipo_tran)= b.codigo and c.hm_causa = b.valor
inner join cobis..cl_tabla a on b.tabla = a.codigo
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and a.tabla ='cc_trx_causa_cred_rev'


--Ref:59 Agrega trx para  de servicio TB01610000 ctas virtuales
select @cont2 = count(1)
from cob_virtuales_his..vi_his_movimiento c
inner join cob_super..cc_a06_transaccion d on c.hm_tipo_tran = d.at_transaccion
inner join cob_super..cc_a06_causa e on c.hm_causa = ac_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and at_cod_servicio = 'TB01610000' and at_tip_producto='CB0003'
and ac_cod_servicio = 'TB01610000' and ac_tip_producto='CB0003'


select @cont2 = count(1) + @cont2
from cob_virtuales_his..vi_his_movimiento c
inner join cob_super..cc_a06_transaccion d on c.hm_tipo_tran = d.at_transaccion
inner join cob_super..cc_a06_causa e on c.hm_causa = ac_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and at_cod_servicio = 'TB01610000' and at_tip_producto='CV0001'
and ac_cod_servicio = 'TB01610000' and ac_tip_producto='CV0001'

select @cont2 = count(1) + @cont2
from cob_ahorros_his..ah_his_movimiento c
inner join cob_super..cc_a06_transaccion d on c.hm_tipo_tran = d.at_transaccion
inner join cob_super..cc_a06_causa e on c.hm_causa = ac_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and at_cod_servicio = 'TB01610000' and at_tip_producto='CA0001'
and ac_cod_servicio = 'TB01610000' and ac_tip_producto='CA0001'

select @cont2 = count(1) + @cont2
from cob_cuentas_his..cc_his_movimiento c
inner join cob_super..cc_a06_transaccion d on c.hm_tipo_tran = d.at_transaccion
inner join cob_super..cc_a06_causa e on c.hm_causa = ac_causa
where hm_fecha>= @i_fecha_ini and hm_fecha <= @i_fecha_fin
and at_cod_servicio = 'TB01610000' and at_tip_producto='CC0001'
and ac_cod_servicio = 'TB01610000' and ac_tip_producto='CC0001'

select @cont= isnull(@cont2,0) - isnull(@cont,0)

insert into cob_super..cc_detalle_a06
	(cd_producto, cd_fecha_corte, cd_canal,
	cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
	cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
	cd_tipo_cliente, cd_numero_trans, cd_tarifa,
	cd_ingreso_total,cd_prop_canal,cd_cod_provincia,cd_cod_canton,cd_ingreso_neto,cd_base_imponible,cd_iva_pagado
	)

values (3, @i_fecha_fin, @i_canal,
	@i_servicio, 'CC0000', @i_descripcion,
	null, null, substring(@i_servicio, 1, 2),
	null,@cont, @i_tarifa,
        0,'P','09','01', 0,0,0  )

if @@error<>0
begin
     print 'ERROR AL INSERTAR, Canal:%1!, Producto:%2!, Servicio:%3!',@i_canal,@i_producto,@i_servicio
     return 99991
end

----Ref:59 FIN--

--Monto Base 

select tipo,servicio ,sum(monto) val into #totales from #valores
where rev != 'C'
group by tipo,servicio

update cob_super..cc_detalle_a06
set cd_monto_base = val
from cob_super..cc_detalle_a06,#totales
where cd_fecha_corte = @i_fecha_fin
and cd_tipo_servicio = servicio
and cd_canal = tipo

if @@error<>0
begin
	return 9999
end

---< Ref50 >---Agregar,Monto base  --Fin

--< ref:37 >-- Modificacion Descripcion a todos los servicio TB00950000
update cob_super..cc_detalle_a06
set cd_descripcion='Bloqueo, anulacion o cancelacion de tarjetas debito/pago/credito/electronica/prepago'
where  cd_fecha_corte = @i_fecha_fin
and cd_tipo_servicio = 'TB00950000'

if @@error<>0
begin
	return 9999
end

---< ref: 48 >---Actualizador masivo de cuentas contables para todos los servisios

select  @i_servicio='',
	@v_cta_contable=''

select ltrim(rtrim(b.codigo)) servicio, b.valor into #tmp_servicios
from cobis..cl_tabla a,cobis..cl_catalogo b
where a.tabla  = 'cs_ctas_contables'
  and a.codigo = b.tabla
  and substring(ltrim(rtrim(b.codigo)),1,2)!= 'TB'   --No deben tomarse las tarifas basicas


--Agregar cuentas contables segun la informacion del corte
declare a06_cta_ctable cursor
for
select servicio,valor from #tmp_servicios

for read only

open a06_cta_ctable
fetch a06_cta_ctable into @i_servicio,@v_cta_contable

while @@sqlstatus != 2
begin
	if @@sqlstatus = 1
	begin
		close a06_cta_ctable
		deallocate cursor a06_cta_ctable
		return 9999
	end

	--Si existe en la extraccion se agrega la cta contable
	if exists(select 1 from  cob_super..cc_detalle_a06 where  cd_fecha_corte = @i_fecha_fin
	 			      			      and cd_tipo_servicio = @i_servicio )
	begin
		update cob_super..cc_detalle_a06
		set cd_cta_contable = @v_cta_contable
		where  cd_fecha_corte = @i_fecha_fin
		 and cd_tipo_servicio = @i_servicio

		if @@error<>0
		begin
			close a06_cta_contable
			deallocate cursor a06_cta_contable
			return 9999
		end
	end

     fetch a06_cta_ctable into  @i_servicio,@v_cta_contable

end
close a06_cta_ctable
deallocate cursor a06_cta_ctable

---< ref: 48 >---fin Agrega ctas contables

 if object_id('tempdb.dbo.##temp_resporder') is not null
   begin
       drop table tempdb.dbo.##temp_resporder
   end



return 0
go


if exists(select 1 from sysobjects where name='sp_procesos_manuales_a06' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_procesos_manuales_a06 *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_procesos_manuales_a06 -- ERROR -- >>>'
go



