/************************************************************************/
/*  Archivo:            cctotmon.sp                             	      */
/*  Motor BD:		        sybase						                              */
/*  Base de datos:      cob_cuentas                     	              */
/*  Aplicacion:		      CUENTAS CORRIENTES				                      */
/*  Stored procedure:   pa_cte_totalizar_tran_monet	 	       		        */
/*  Disenado por:  	    Jorge Pazminno M.                      	        */
/*  Fecha de escritura: 24/Sep/2020	    	                              */
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
/* MODIFICACIONES                          				                      */
/************************************************************************/
/* REF  FECHA          AUTOR            RAZON 		   	                  */
/*   1  24/Sep/2020  J.Pazminno  CTE-CC-SGC00039533                     */
/*                               Tunning Proceso - Transformar SQR => SP*/
/************************************************************************/


-- actualizar tm_secuencial 

use cob_cuentas
go

if exists(select 1 from db_general.dbo.sysobjects where name = 'cte_tmp_monet_conta')
  drop table db_general.dbo.cte_tmp_monet_conta
go

if exists (select 1 from sysobjects where name = "pa_cte_btotalizar_tran_monet_jg" and type='P')
  begin
    drop procedure  dbo.pa_cte_btotalizar_tran_monet_jg
    if exists (select 1 from sysobjects where name = 'pa_cte_btotalizar_tran_monet_jg' and type = 'P')
      PRINT '<<< DROP PROCEDURE pa_cte_btotalizar_tran_monet_jg -- ERROR -- >>>'
    else
      PRINT '== DROP PROCEDURE pa_cte_btotalizar_tran_monet_jg *OK* =='
  end
go

create procedure dbo.pa_cte_btotalizar_tran_monet_jg (
@e_filial                   tinyint,
@e_fecha    	              smalldatetime,
@s_procesadas               int         out
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
        from cob_cuentas..cc_tran_monet  (index cc_tran_monet_tipo_Key)
        where tm_tipo_tran >= 0                                                -- sugerencia de indice
          and tm_fecha = @e_fecha
		  and tm_secuencial in (35781909,35791329,36126363,1133800485,58927629,1297052953)
      )                                                md                    -- tabla derivada por index perfomance
      inner join cob_cuentas..cc_tran_monet              m
           on   md.secuencial  = m.tm_secuencial
            and isnull(md.cod_alterno, -1) = isnull(m.tm_cod_alterno, -1)     -- condicionar -1 por <null> porque si hay valores en 0 que duplican registros
      inner join cob_remesas..re_tran_contable
           on   md.tipo_tran	= tc_tipo_tran 
            and tc_causa_org	in (isnull(md.causa, '0'), '0')
 where tc_estado		= 'V'          
   and not exists(select 1
                   from cobis..cl_tabla a
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

if exists(select 1 from sysobjects where name='pa_cte_btotalizar_tran_monet_jg' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_cte_btotalizar_tran_monet_jg *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_cte_btotalizar_tran_monet_jg -- ERROR -- >>>'
go
