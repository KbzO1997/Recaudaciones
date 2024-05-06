
SELECT substring(convert(char(10), hs_tsfecha,103),4,7) as MES, isnull(cc_nombre, ah_nombre) NOMBRE, isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION, 
hs_cta_banco CTA, case when cc_cta_banco is not null then 'CTE' when ah_cta_banco is not null then 'AHO' else hs_tipocta end TIPO
INTO #tmp_tran_servicio_1
FROM cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE 
hs_causa in ('38','8523')
AND hs_tipo_transaccion = 3427 
AND hs_tsfecha >= '04/01/2024'
AND hs_tsfecha <= '04/30/2024'

SELECT isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION
INTO #tmp_tran_servicio_2
FROM cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE hs_causa in ('38','8523')
AND hs_tipo_transaccion = 3427
AND hs_tsfecha >= '03/01/2024'
AND hs_tsfecha <= '03/31/2024'
AND hs_tipo_contable in ('3','4')
union all
SELECT isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION
FROM cob_cuentas_acum..cc_his_servicio_acum
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE hs_causa in ('38','8523')
AND hs_tipo_transaccion = 3427 
AND hs_tsfecha >= '05/01/2023'
AND hs_tsfecha <= '01/31/2024'

SELECT DISTINCT IDENTIFICACION
INTO #tmp_tran_servicio_4
from  #tmp_tran_servicio_1

SELECT DISTINCT IDENTIFICACION
INTO #tmp_tran_servicio_3
from  #tmp_tran_servicio_2



select ts.IDENTIFICACION 
into #tmp_tran_servicio_5
from #tmp_tran_servicio_4 ts
left  join #tmp_tran_servicio_3 ts3 on ts.IDENTIFICACION  = ts3.IDENTIFICACION
where ts3.IDENTIFICACION is null



SELECT DISTINCT ts.MES, ts.NOMBRE, ts.IDENTIFICACION, ts.CTA, ts.TIPO
FROM #tmp_tran_servicio_1 ts
inner join #tmp_tran_servicio_5 ts5 on ts.IDENTIFICACION = ts5.IDENTIFICACION
