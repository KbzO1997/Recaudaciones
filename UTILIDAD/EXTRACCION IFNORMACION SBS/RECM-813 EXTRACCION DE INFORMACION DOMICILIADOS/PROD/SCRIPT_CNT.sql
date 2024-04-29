if object_id('tempdb.dbo.#tmp_tran_servicio_1') is not null
    drop table #tmp_tran_servicio_1

if object_id('tempdb.dbo.#tmp_tran_servicio_2') is not null
    drop table #tmp_tran_servicio_2

SELECT substring(convert(char(10), hs_tsfecha,103),4,7) as MES, isnull(cc_nombre, ah_nombre) NOMBRE, isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION, 
hs_cta_banco CTA, case when cc_cta_banco is not null then 'CTE' when ah_cta_banco is not null then 'AHO' else hs_tipocta end TIPO
INTO #tmp_tran_servicio_1
FROM cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE 
hs_causa = '113'
AND hs_tipo_transaccion = 43547 
AND hs_tsfecha >= '08/01/2023'
AND hs_tsfecha < '11/01/2023'
AND hs_tipo_contable in ('3','4')

SELECT isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION
INTO #tmp_tran_servicio_2
FROM cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE hs_causa = '113'
AND hs_tipo_transaccion = 43547
AND hs_tsfecha >= '08/01/2022'
AND hs_tsfecha < '11/01/2022'
AND hs_tipo_contable in ('3','4')


SELECT DISTINCT MES, NOMBRE, IDENTIFICACION, CTA, TIPO
FROM #tmp_tran_servicio_1
WHERE IDENTIFICACION NOT IN (
SELECT IDENTIFICACION
FROM #tmp_tran_servicio_2
)

if object_id('tempdb.dbo.#tmp_tran_servicio_1') is not null
    drop table #tmp_tran_servicio_1

if object_id('tempdb.dbo.#tmp_tran_servicio_2') is not null
    drop table #tmp_tran_servicio_2