use cob_super
go
if exists (select 1 from sysobjects where name = 'sp_inserta_cte_a06_ofi')
  drop proc dbo.sp_inserta_cte_a06_ofi
  if exists (select 1 from sysobjects where name = 'sp_inserta_cte_a06_ofi')
     print 'DROP PROC sp_inserta_cte_a06_ofi <<ERROR>>'
  else
     print 'DROP PROC sp_inserta_cte_a06_ofi <<OK>>'
go

/************************************************************************/
/*      Archivo           : cccc06of.sp                                 */
/*      Stored procedure  : sp_inserta_cte_a06_ofi                      */
/*      Base de datos     : cob_super                                 */
/*      Producto          : Cuentas Corrientes                          */
/*      Disenado por      : German Medina Cevallos                      */
/*      Fecha de escritura: 07-Diciembre-2009                           */
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
/*      Extrae información para el A06 de Oficina                       */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA          AUTOR              RAZON                             */
/*  07/DIC/2009    German Medina C.   Emision Inicial                   */
/*2 12/MAR/2010    German Medina C.   CTE-CC-8434 - Tasa Ponderada      */
/*3 10/JUN/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-8977                       */
/*4 13/Ene/2017   María José Silva    RECA-CC-SGC00027525  Cobro de Comision claro Batch */
/*5 16/Feb/2017   Daniel Pereira      RECA-CC-SGC00027934  Cobro Comisión ND Ventanilla */
/*6 24/Abr/2017   Danny Olaya         RECA-CC-SGC00028468  Cobro de Comision EEQ Batch */
/*7 25/Jul/2017   Daniel Pereira      CAJ-CC-SGC00028304 cobro comision canal ATM*/
/************************************************************************/
/*8 07/Ago/2017   Vanessa Miranda T  MEER-AP-SGC00026606-SGC00028066   */
/*              Se agrega deflactación de Iva                          */
/*9 03/26/2019	  Pablo Holguiv	      CTE-CC-SGC00034569 Nuevos campos	*/
/************************************************************************/

create proc dbo.sp_inserta_cte_a06_ofi
(
  @i_fecha_ini                datetime        = null,
  @i_fecha_fin                datetime        = null,
  @i_canal                    char(1)         = null,
  @i_servicio                 varchar(10)     = null,
  @i_tipo_producto            varchar(10)     = null,
  @i_tipo_cliente             char(1)         = null,
  @i_usu1                     varchar(10)     = null,
  @i_usu2                     varchar(10)     = null,
  @i_usu3                     varchar(10)     = null,
  @i_usu4                     varchar(10)     = null,
  @i_usu5                     varchar(10)     = null,
  @i_moneda                   smallint        = null,
  @i_producto                 smallint        = null

)
as

--> Declaracion de variables
declare
@w_cate1             char(1),
@w_cate2             char(1),
@w_valor_comision    money,
@w_tasa_ponderada    money,
@w_error             int,
@w_porcIva           float,	--Ref 6:dolaya
@w_Iva		     float	--Ref 9 pholguiv

--> Crea Temporales

create table #tran
(
  trx      int          null
)

create table #causa
(
  cau     varchar(6)    null
)

create table #cate
(
  cat      char(1)      null
)
create table #clie
(
  cli      char(1)      null
)
create table #sector
(
  sec      char(2)      null
)

create table #resultado
(
  cont     int          null,
  valor    money        null,
  iva      money   	null, --Ref 9: pholguiv
  causa    varchar(10)  null, --Ref004:msilvag
  corr	   char(1)	null,  --REF: 5
  oficina  int 		null
)


--> Llena Temporales
--> Transaccion
insert into #tran
select
	  at_transaccion
from
	  cc_a06_transaccion
where
    at_canal          = @i_canal
and at_cod_servicio   = @i_servicio
and at_tip_producto   = @i_tipo_producto
and at_tip_cliente    = @i_tipo_cliente

--> Causa
insert into #causa
select
	  ac_causa
from
	  cc_a06_causa
where
    ac_canal          = @i_canal
and ac_cod_servicio   = @i_servicio
and ac_tip_producto   = @i_tipo_producto
and ac_tip_cliente    = @i_tipo_cliente


--> Categoria
insert into #cate
select
	  ca_categoria
from
	  cc_a06_categoria
where
    ca_canal          = @i_canal
and ca_cod_servicio   = @i_servicio
and ca_tip_producto   = @i_tipo_producto
and ca_tip_cliente    = @i_tipo_cliente

--> Tipo Cliente
insert into #clie
select
	  (case pa_tip_cliente when 'N' then 'P' when 'J' then 'C' else 'T' end)
from
	  cc_a06_parametros
where
    pa_canal          = @i_canal
and pa_cod_servicio   = @i_servicio
and pa_tip_producto   = @i_tipo_producto
and pa_tip_cliente    = @i_tipo_cliente

if exists(select 1 from #clie where cli = 'T')
begin
	truncate table #clie

	insert into #clie (cli) values ('C')
	insert into #clie (cli) values ('P')

end

--> Sector - (3)Sector Financiero - (4)Sector Publico
insert into #sector
select
	  pa_sector
from
	  cc_a06_parametros
where
    pa_canal          = @i_canal
and pa_cod_servicio   = @i_servicio
and pa_tip_producto   = @i_tipo_producto
and pa_tip_cliente    = @i_tipo_cliente

--Ref 6:dolaya Inicio

select  @w_porcIva = isnull(pa_float,0) + 1,
	@w_Iva 	   = isnull(pa_float,0)			--Ref 9: pholguiv iva
from cobis..cl_parametro
where pa_producto = 'CTE'
and pa_nemonico = 'IVA'

--Ref 6:dolaya Fin

select
    'cuenta' = hm_cta_banco,
    -- Ref 6:dolaya Inicio
    'valor' = case when hm_correccion ='N' then round(isnull(hm_valor, 0)/@w_porcIva,2)  else round(isnull(hm_valor, 0)/@w_porcIva,2) *-1  end,--ref8 vmirandt defactar iva
    'iva'   = case when hm_correccion ='N' then isnull(hm_valor, 0) - round(isnull(hm_valor, 0)/@w_porcIva,2)
    		else (isnull(hm_valor, 0) - round(isnull(hm_valor, 0)/@w_porcIva,2) ) *-1  end,		--ref 9 pholguiv iva
    'oficina'= hm_oficina,	   										--ref 9 pholguiv oficina
    -- Ref 6:dolaya Fin
    'causa' = isnull(hm_causa,''),  --Ref004:msilvag
    'corr' = hm_correccion --REF: 5

into
    #datos
from
    cob_cuentas_his..cc_his_movimiento
where
    hm_fecha >= @i_fecha_ini
and hm_fecha <= @i_fecha_fin
and hm_oficina >= 0
and hm_moneda = @i_moneda
and hm_tipo_tran in (select trx from #tran)
and hm_causa in (select cau from #causa)
and hm_usuario not in (@i_usu1, @i_usu2, @i_usu3, @i_usu4, @i_usu5,'cnb001')
and hm_terminal <> 'ATMB'  --ref 7

--<ref: 3 - INI>--
--<SE CAMBIA LA MANERA DE OBTENER LA TASA PONDERADA Y QUE LA CALCULE SOLO SI ES NECESARIO>--
--<YA QUE NO SIEMPRE ES NECESARIO OBTENERLA: EJEMPLO --> PAR EL CASA DE UNA COMISION IGUAL>--
--<NO APLICA EL CALCULO PORQUE LA TASA PONDERADA SERIA LA MISMA COMISION>--

if exists(select 1 from #sector where sec in ('3', '4'))
begin

  insert into #resultado
  select
      'cont'  = case when corr ='N' then isnull(count(1), 0) else isnull(count(1), 0)*-1 end  , --REF: 5
      'valor' = isnull(sum(valor), 0) ,
      'iva' = isnull(sum(iva), 0) ,			--ref 9 pholguiv oficina
      'causa' = isnull(causa,''),  --Ref004:msilvag
      'corr'  = corr, --REF: 5
      'oficina'=oficina
  from
      cob_cuentas..cc_ctacte, #datos
  where
      cc_cta_banco = cuenta
  and cc_categoria not in ('R')
  and cc_tipocta in (select cli from #clie)
  and cc_tipo_contable in (select sec from #sector)
  group by causa,corr,oficina --Ref004:msilvag --REF: 5
end
else
begin
  if exists (select 1 from #cate where cat = 'N')
  begin
    insert into #resultado
    select
    'cont'  = case when corr ='N' then isnull(count(1), 0) else isnull(count(1), 0)*-1 end  , --REF: 5
    'valor' = isnull(sum(valor), 0),
    'iva' = isnull(sum(iva), 0) ,			--ref 9 pholguiv oficina
    'causa' = isnull(causa,''),  --Ref004:msilvag
    'corr'  = corr,  --REF: 5
    'oficina'=oficina
    from
    cob_cuentas..cc_ctacte, #datos
    where
    cc_cta_banco = cuenta
    and cc_categoria not in ('R')
    and cc_tipocta in (select cli from #clie)
    group by causa,corr,oficina --Ref004:msilvag --REF: 5
  end
  else
  begin
    insert into #resultado
    select
    'cont'  = case when corr ='N' then isnull(count(1), 0) else isnull(count(1), 0)*-1 end  , --REF: 5
    'valor' = isnull(sum(valor), 0),
    'iva'   = isnull(sum(iva), 0) ,			--ref 9 pholguiv oficina
    'causa' = isnull(causa,''),  --Ref004:msilvag
    'corr'  = corr,  --REF: 5
    'oficina'= oficina
    from
    cob_cuentas..cc_ctacte, #datos
    where
    cc_cta_banco = cuenta
    and cc_categoria in (select cat from #cate)
    and cc_tipocta in (select cli from #clie)
    group by causa,corr,oficina --Ref004:msilvag --REF: 5
  end
end


--Ref004:msilvag A06 Debitos Automaticos Claro Inicio
select 'conta' = isnull(sum(cont), 0) ,
       'valor' = isnull(sum(valor) ,0),
       'iva'   = isnull(sum(iva), 0) ,
       'oficina'= oficina,
       'provincia' = (select of_provincia from cobis..cl_oficina where of_oficina=a.oficina),			--Ref 9 : pholguiv  agrega provincia
       'canton' = (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina=a.oficina)		--Ref 9 : pholguiv  agrega canton

into #tmp_resul
from #resultado a
where causa not in ('749','598') --causas de Debitos Batch de Claro
group by oficina

select 'conta' = isnull(sum(cont), 0) ,
       'valor' = isnull(sum(valor) ,0),
       'iva'   = isnull(sum(iva), 0) ,
       'oficina'= oficina,
       'provincia' = (select of_provincia from cobis..cl_oficina where of_oficina=a.oficina),			--Ref 9 : pholguiv  agrega provincia
       'canton' = (select substring(of_canton,3,2) from cobis..cl_oficina where of_oficina=a.oficina)		--Ref 9 : pholguiv  agrega canton

into #tmp_resul2
from #resultado  a
where causa in ('749','598') --causas de Debitos Batch de Claro
group by oficina
--Ref004:msilvag Fin


--<EMPIEZA EL CALCULO DE LA TASA PONDERADA SOLO SI ES NECESARIO>--
if exists (select 1 from cob_super..cc_a06_no_comision where an_transaccion in (select trx from #tran)
                                                             and an_causa in (select cau from #causa))
begin
    --> Este calculo solo se hace si la comision no puede ser calcula de las transaccionales

    select
        @w_valor_comision = pa_tarifa,
        @w_tasa_ponderada = pa_tarifa
    from
        cob_super..cc_a06_parametros
    where
        pa_canal          = @i_canal
    and pa_cod_servicio   = @i_servicio
    and pa_tip_producto   = @i_tipo_producto
    and pa_tip_cliente    = @i_tipo_cliente

     if isnull(@w_valor_comision,0)=0
      set @w_Iva=0

    update
        #tmp_resul      --Ref004:msilvag #resultado
    set
        valor = (conta * @w_valor_comision), ----Ref004:msilvag (cont * @w_valor_comision)
        iva   = (conta * @w_Iva)
    from
        #tmp_resul      --Ref004:msilvag #resultado


    if @@error <> 0
    begin
        select @w_error = @@error

        update cob_super..cc_a06_parametros
        set pa_error = @w_error, pa_desc_error = 'Error: Update resultado_no_comision: ' || @i_servicio || ' - ' || @i_tipo_producto || ' - ' || @i_canal || ' - ' || @i_tipo_cliente
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
    end


end

--Ref004:msilvag Inicio
select conta, valor,iva,provincia,canton
into #tmp
from #tmp_resul
union all
select conta, valor,iva,provincia,canton from #tmp_resul2


select 'cont'  = isnull(sum(conta), 0) ,
       'valor' = isnull(sum(valor) ,0),
       'iva'   = isnull(sum(iva) ,0),
       'provincia' = provincia,				--Ref 9 : pholguiv  agrega provincia
       'canton'    = canton				--Ref 9 : pholguiv  agrega cantoninto #tempo1
into #tmp1
from #tmp a
group by provincia,canton
--Ref004:msilvag Fin


--<SI YA LA OBTUBO LA TASA PONDERADA YA NO LA VUELVE A CALCULAR>--
if @w_tasa_ponderada = null
begin --> if @w_tasa_ponderada = null - INI

    if exists(select 1 from #sector where sec in ('3', '4'))
    begin


      --< GAMC 22FEB2010 - CALCULO DE TASA PONDERADA >--
      select @w_tasa_ponderada =
      sum
         (
           (
             valor
             *
             count(*)
           )
           /
           sum(count(*))
         )
      from
          cob_cuentas..cc_ctacte, #datos
      where
          cc_cta_banco = cuenta
      and cc_categoria not in ('R')
      and cc_tipocta in (select cli from #clie)
      and cc_tipo_contable in (select sec from #sector)
      group by valor

    end
    else
    begin
      if exists (select 1 from #cate where cat = 'N')
      begin

        --< GAMC 22FEB2010 - CALCULO DE TASA PONDERADA >--
        select @w_tasa_ponderada =
        sum
         (
           (
             valor
             *
             count(*)
           )
           /
           sum(count(*))
         )
        from
          cob_cuentas..cc_ctacte, #datos
        where
            cc_cta_banco = cuenta
        and cc_categoria not in ('R')
        and cc_tipocta in (select cli from #clie)
        group by valor

      end
      else
      begin

        --< GAMC 22FEB2010 - CALCULO DE TASA PONDERADA >--
        select @w_tasa_ponderada =
        sum
         (
           (
             valor
             *
             count(*)
           )
           /
           sum(count(*))
         )
        from
          cob_cuentas..cc_ctacte, #datos
        where
            cc_cta_banco = cuenta
        and cc_categoria in (select cat from #cate)
        and cc_tipocta in (select cli from #clie)
        group by valor


      end

    end

end   --> if @w_tasa_ponderada = null - FIN

if exists (select 1 from cob_super..cc_a06_parametros where pa_canal          = @i_canal
                                                                    and pa_cod_servicio   = @i_servicio
                                                                    and pa_tip_producto   = @i_tipo_producto
                                                                    and pa_tip_cliente    = @i_tipo_cliente
                                                                    and pa_tarifa = 0)
begin
    select @w_tasa_ponderada = 0
end

if exists(select 1 from cob_super..cc_detalle_a06 where cd_fecha_corte   = @i_fecha_fin
                                                         and cd_canal           = @i_canal
                                                         and cd_tipo_servicio   = @i_servicio
                                                         and cd_tipo_producto   = @i_tipo_producto
                                                         and cd_tipo_cliente    = @i_tipo_cliente)
begin
    print ''
    print 'REGISTRO YA EXISTE: %1! - %2! - %3! - %4! - ', @i_canal, @i_servicio, @i_tipo_producto, @i_tipo_cliente
    print ''
end
else
begin

    insert into cob_super..cc_detalle_a06
      (cd_producto, cd_fecha_corte, cd_canal,
      cd_tipo_servicio, cd_tipo_producto, cd_descripcion,
      cd_tipo_tarjeta, cd_clase_tarjeta, cd_tipo_tarifa,
      cd_tipo_cliente, cd_numero_trans, cd_tarifa,
      cd_ingreso_total, cd_tasa_ponderada,
      cd_prop_canal, cd_cod_provincia ,cd_cod_canton, cd_cargo_porcentaje,	--Ref 9 : pholguiv  agrega nuevos campos
      cd_ingreso_neto ,cd_monto_base , cd_base_imponible, cd_iva_pagado 	--Ref 9 : pholguiv  agrega nuevos campos
      )
    select
      @i_producto, @i_fecha_fin, pa_canal,
      pa_cod_servicio, pa_tip_producto, pa_descripcion,
      null, null, pa_tip_tarifa,
      pa_tip_cliente, isnull(cont, 0), pa_tarifa,
      isnull(valor, 0), @w_tasa_ponderada,
      'P',provincia,canton,0,						--Ref 9 : pholguiv  agrega nuevos campos
      isnull(valor,0),0,isnull(valor,0),isnull(iva,0)									--Ref 9 : pholguiv  agrega nuevos campos

    from
      cob_super..cc_a06_parametros, #tmp1  --Ref004:msilvag #resultado
    where
      pa_canal          = @i_canal
    and pa_cod_servicio   = @i_servicio
    and pa_tip_producto   = @i_tipo_producto
    and pa_tip_cliente    = @i_tipo_cliente

    if @@error <> 0
    begin
        select @w_error = @@error

        update cob_super..cc_a06_parametros
        set pa_error = @w_error, pa_desc_error = 'Error: Insert cc_detalle_a06: ' || @i_servicio || ' - ' || @i_tipo_producto || ' - ' || @i_canal || ' - ' || @i_tipo_cliente
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
    end


end

return 0

go
  if exists (select 1 from sysobjects where name = 'sp_inserta_cte_a06_ofi')
     print 'CREATE PROC sp_inserta_cte_a06_ofi <<OK>>'
  else
     print 'CREATE PROC sp_inserta_cte_a06_ofi <<ERROR>>'
go

