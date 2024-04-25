/************************************************************************/
/*  Archivo:            cctotmon_test.sp                             	*/
/*  Motor BD:		sybase					        */
/*  Base de datos:      cob_cuentas                     	        */
/*  Aplicacion:		CUENTAS CORRIENTES			        */
/*  Stored procedure:   pa_ctebtotalizartranmonet_test	 	        */
/*  Disenado por:  	    Jorge Pazminno M.                           */
/*  Fecha de escritura: 24/Sep/2020	    	                        */
/************************************************************************/
/*          		     IMPORTANTE		                        */
/* Este programa es parte de los paquetes bancarios propiedad de        */
/* "BANCO BOLIVARIANO".                                                 */
/* Su uso no autorizado queda expresamente prohibido asi como           */
/* cualquier alteracion o agregado hecho por alguno de sus              */
/* usuarios sin el debido consentimiento por escrito de la              */
/* Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.       */
/************************************************************************/
/* Se encarga de calcular los totales de las transacciones monetarias   */
/* del dia a contabilizar.  Estos totales se almacenan en re_total      */
/************************************************************************/
/* MODIFICACIONES                          			        */
/************************************************************************/
/* REF  FECHA          AUTOR            RAZON 		   	        */
/*   1  24/Sep/2020  J.Pazminno  CTE-CC-SGC00039533                     */
/*                               Tunning Proceso - Transformar SQR => SP*/
/************************************************************************/

use cob_cuentas
go

if exists(select 1 from db_general.dbo.sysobjects where name = 'cte_tmp_monet_conta')
  drop table db_general.dbo.cte_tmp_monet_conta
go

if exists (select 1 from sysobjects where name = "pa_ctebtotaltranmonet_test" and type='P')
  begin
    drop procedure  dbo.pa_ctebtotaltranmonet_test
    if exists (select 1 from sysobjects where name = 'pa_ctebtotaltranmonet_test' and type = 'P')
      PRINT '<<< DROP PROCEDURE pa_ctebtotaltranmonet_test -- ERROR -- >>>'
    else
      PRINT '== DROP PROCEDURE pa_ctebtotaltranmonet_test *OK* =='
  end
go

create procedure dbo.pa_ctebtotaltranmonet_test (
@e_filial       tinyint,
@e_fecha    	smalldatetime,
@e_usuario      varchar(30),		--test
@s_procesadas   int out
)
as
declare
@v_moneda_base              tinyint,
@v_return                   int

--Inicio_Valida
begin tran
  delete cob_cuentas..cc_control_contabilidad
  where cc_fecha = @e_fecha
    and cc_producto = 3
    and cc_transaccion = 'M'
  if @@error <> 0
  begin
    rollback tran
    print 'ERROR EN DELETE cob_cuentas..cc_control_contabilidad (CTE-M)'
    return 1
  end
  
  insert into cob_cuentas..cc_control_contabilidad
         (cc_fecha, cc_producto, cc_transaccion, cc_estado, cc_hora_inicio, cc_hora_fin)
  values (@e_fecha, 3, 'M', 'E', getdate(), null)
  if @@error <> 0
  begin
    rollback tran
    print 'ERROR EN INSERT cob_cuentas..cc_control_contabilidad (CTE-M)'
    return 2
  end

  delete cob_remesas..re_total 
   where to_producto = 3 and to_tipo = 'M'
  if @@error <> 0
  begin
    rollback tran
    print 'ERROR EN DELETE cob_remesas..re_total (CTE-M)'
    return 3
  end
commit tran

-- inicializacionbes del proceso
-- moneda base 
select @v_moneda_base = em_moneda_base
 from cob_conta..cb_empresa
 where em_empresa = @e_filial
if @@rowcount = 0
begin
  print 'MONEDA BASE NO DEFINIDA'
  return 4
end 

if exists(select 1 from db_general.dbo.sysobjects where name = 'cte_tmp_monet_conta')
  drop table db_general.dbo.cte_tmp_monet_conta

-- bull insert "masivo" de las trx participantes
select ti_moneda        = tm_moneda,
       ti_tipo_contable = isnull(tm_tipo_contable, '0'),
       ti_ofic_orig     = tm_oficina,
       ti_ofic_dest     = tm_oficina_cta,
       ti_tipo_tran     = md.tipo_tran,
       ti_causa         = md.causa,
       ti_tasa_solca    = isnull(tm_tasa_solca, 1),
       tc_contabiliza,
       tc_causa_dst,
       tc_causa_org,
       tc_perfil,
       tc_estado,
       ti_cotizcompra   = case when tm_moneda <> @v_moneda_base and isnull(tm_tasa_solca, 1) = 1
                                then (select cotbase = isnull(ct_compra, 1)  
                                       from cob_conta..cb_cotizacion
                                       where ct_fecha = convert(datetime, @e_fecha)
                                         and ct_moneda = m.tm_moneda)
                                else   isnull(tm_tasa_solca, 1)
                          end,
       ti_valor         = case when tc_contabiliza = 'VTR'    then isnull(tm_valor, 0)
                               when tc_contabiliza = 'VCH'    then isnull(tm_chq_locales, 0)
                               when tc_contabiliza = 'COM'    then isnull(tm_valor_comision, 0)
                               when tc_contabiliza = 'INT'    then isnull(tm_valor_interes, 0)
                               when tc_contabiliza = 'TDE'    then (isnull(tm_valor, 0) + isnull(tm_chq_locales, 0))
                               when tc_contabiliza = 'VCO'    then (isnull(tm_valor, 0) - isnull(tm_valor_comision, 0))
                               when tc_contabiliza = 'VIN'    then (isnull(tm_valor, 0) - isnull(tm_valor_interes, 0))
                               when tc_contabiliza = 'CCO'    then (isnull(tm_chq_locales, 0) + isnull(tm_valor_comision, 0))
                               when tc_contabiliza = 'EFE' and substring(isnull(tm_canal,''),1,3) <> 'CNB'
                                                              then isnull(tm_efectivo, 0)
                               when tc_contabiliza = 'EFECNB' and substring(isnull(tm_canal,''),1,3) = 'CNB'
                                                              then isnull(tm_efectivo, 0)
                               when tc_contabiliza = 'SAC'    then isnull(tm_saldo_contable, 0)
                               when tc_contabiliza = 'SAD'    then isnull(tm_saldo_disponible, 0)
                               when tc_contabiliza = 'L24'    then isnull(tm_l24h, 0)
                               when tc_contabiliza = 'REM'    then isnull(tm_remesas, 0)
                               when tc_contabiliza = 'SCO'    then isnull(tm_contratado, 0)
                               when tc_contabiliza = 'SOC'    then isnull(tm_ocasional, 0)
                               when tc_contabiliza = 'IMP'    then isnull(tm_valor_impuesto, 0)
                               when tc_contabiliza = 'ISO'    then isnull(tm_valor_solca, 0)
                               when tc_contabiliza = 'VSI'    then (isnull(tm_valor, 0) - isnull(tm_valor_impuesto, 0))
                               when tc_contabiliza = 'CAP'    then (isnull(tm_valor, 0) + isnull(tm_valor_impuesto, 0)) 
                               when tc_contabiliza = 'VCC'    then (isnull(tm_chq_locales, 0) + isnull(tm_valor_impuesto, 0) - (isnull(tm_efectivo, 0) - isnull(tm_valor, 0))) 
                               when tc_contabiliza = 'CAI'    then (isnull(tm_valor, 0) + isnull(tm_valor_impuesto, 0) + isnull(tm_efectivo, 0)) 
                               else                           0
                          end * case tm_correccion when 'S' then -1 else 1 end,
        ti_contar     = 1 * case tm_correccion when 'S' then -1 else 1 end,
        ti_secuencial = tm_secuencial
into db_general.dbo.cte_tmp_monet_conta lock datarows
from (select secuencial  = tm_secuencial,
             cod_alterno = tm_cod_alterno,
             tipo_tran   = tm_tipo_tran,
             causa       = tm_causa
      from cob_cuentas..cc_tran_monet (index cc_tran_monet_tipo_Key)
      where tm_tipo_tran >= 0                                                -- sugerencia de indice
      and tm_fecha = @e_fecha

       and tm_tsn in (132832020,132990668) 

      --and tm_secuencial in (259857010,1113856837)
      --and tm_tsn in (132841397,132841616,54876489)
      --and tm_secuencial in (132841397,132841616,57126195,944171225)
      --and tm_tsn in (62616106)
      --and tm_secuencial = 1445512903
      --and tm_secuencial = 30428849
      --and tm_tsn in (48373373,48741233,49121246,50387223,54015939)
      --and tm_secuencial = 501861245
      --and tm_secuencial = 1027193452
      --and tm_tsn in (48373373,48741233,49121246,50387223,54015939)
      --and tm_tsn in (132716286,132716443,132716517,132716582,132716592,132717029,132717189,132717265)
      --and tm_tsn in (132653248,132653322,132653545,132653593)
      --and tm_tsn in (132653248,132653322,132653545,132653593)
      --and tm_secuencial  in(198702033,756395870,587097711,1021529209) 
      --and tm_secuencial  in(1127015742,231888180,527525964)     
      --and tm_tsn in (132643684,132643689,132643748,132644625)
      --and tm_hora >= '11/15/2022 11:30' and tm_hora <= '11/15/2022 11:44'
      --and tm_secuencial = 1803532661  
      --and tm_secuencial = 61953261  
      --and tm_tsn in (49551906,49864609,50884923,51011429,51740339)
      --and tm_usuario like @e_usuario
      --and tm_tsn in (49823096,49921853,50476276,161275539,161615536,47263026,51358243,51636336,52234549,52524583,53080679)    
      --and tm_tsn in (43784469,45236316,45935239,47803753)
      -- and (tm_hora >= '08/22/2022 15:00:00' and tm_hora <= '08/22/2022 16:00:00')
      --and tm_tsn in(34940719,35425476,48127406,48775753,49348346,49701383,50132726,50700569,51470703,51857186,53486989,54550879,54641383,54723549,54967963,57761296)

      --and tm_causa <> '810'
      --and tm_usuario in('WAP','frodrigm')
      --and tm_cta_banco in('0000145703','0005020704','0035012421','1020020371')
      --and tm_beneficiario in('0104117866','0103298378','0103825162',null)
      ) md                    -- tabla derivada por index perfomance
inner join cob_cuentas..cc_tran_monet m
  on md.secuencial  = m.tm_secuencial
  and isnull(md.cod_alterno, -1) = isnull(m.tm_cod_alterno, -1)     -- condicionar -1 por <null> porque si hay valores en 0 que duplican registros
inner join cob_remesas..re_tran_contable
  on md.tipo_tran = tc_tipo_tran 
  and tc_causa_org in (isnull(md.causa, '0'), '0')
where tc_estado = 'V'          
and not exists(select 1 from cobis..cl_tabla a
               left join cobis..cl_catalogo b on a.codigo = b.tabla
               where a.tabla = 'tr_mon_no_cont' and estado = 'V'
               and md.tipo_tran = convert(int, b.codigo))
order by ti_moneda, ti_tipo_contable, ti_ofic_orig, ti_ofic_dest, ti_tipo_tran, ti_causa, ti_tasa_solca

if @@error <> 0
begin
  print 'Error en bullcopy db_general..cte_tmp_monet_conta'
  return 5
end

dump tran db_general with truncate_only
 
exec @v_return = cob_cuentas..pa_cte_btotalizar_tran_monet_1
    @e_filial     = @e_filial,
    @e_fecha    	= @e_fecha,
    @s_procesadas = @s_procesadas   out

if @@error <> 0
begin
  print 'ERROR EN PROCESO cob_cuentas..pa_cte_btotalizar_tran_monet_1 (CTE-M)'
  return 6
end
else    
if @v_return <> 0
  return @v_return

update cob_cuentas..cc_control_contabilidad
  set cc_estado = 'F',
      cc_hora_fin = getdate()
 where cc_fecha = @e_fecha
   and cc_producto = 3
   and cc_transaccion = 'M'

if @@error <> 0
begin
  print 'ERROR EN UPDATE cob_cuentas..cc_control_contabilidad (CTE-M)'
  return 7
end

return 0
go

if exists(select 1 from sysobjects where name='pa_ctebtotaltranmonet_test' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_ctebtotaltranmonet_test *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_ctebtotaltranmonet_test -- ERROR -- >>>'
go
