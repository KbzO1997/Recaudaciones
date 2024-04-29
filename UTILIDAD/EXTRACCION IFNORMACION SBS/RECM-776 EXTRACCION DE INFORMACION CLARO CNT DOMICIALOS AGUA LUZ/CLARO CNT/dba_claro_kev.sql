if object_id('tempdb.dbo.#tmp_info_cta') is not null
    drop table #tmp_info_cta

create table #tmp_info_cta(
ts_fecha date,
ts_cta varchar(24),
ts_tipo tinyint
)

if object_id('tempdb.dbo.#tmp_tran_servicio') is not null
    drop table #tmp_tran_servicio

if object_id('tempdb.dbo.#tmp_trx_mes_1') is not null
    drop table #tmp_trx_mes_1

if object_id('tempdb.dbo.#tmp_trx_mes_2') is not null
    drop table #tmp_trx_mes_2


DECLARE @start_month DATE 
set @start_month = '2023-05-01'

DECLARE @end_month DATE 
set @end_month = '2023-08-01'


SELECT hs_tsfecha, hs_cta_banco, convert(int, hs_tipo_contable) hs_tipo_contable
INTO #tmp_tran_servicio
FROM cob_cuentas_acum..cc_his_servicio_acum
WHERE hs_tipo_transaccion = 3427
AND hs_causa in ('38','8523')
AND hs_tsfecha >= @start_month
UNION
SELECT hs_tsfecha, hs_cta_banco, convert(int, hs_tipo_contable) hs_tipo_contable
FROM cob_cuentas_his..cc_his_servicio
WHERE hs_tipo_transaccion = 3427
AND hs_causa in ('38','8523')
AND hs_tsfecha < DATEADD(MONTH, 1, @end_month)



WHILE @start_month < @end_month
BEGIN
    DECLARE @current_month DATE 
    set @current_month = DATEADD(MONTH, 1, @start_month)
    
    SELECT DISTINCT hs_cta_banco, hs_tipo_contable
    INTO #tmp_trx_mes_1
    FROM #tmp_tran_servicio
    WHERE 
        hs_tsfecha >= @start_month
    AND hs_tsfecha < @current_month

    SELECT DISTINCT hs_cta_banco, hs_tipo_contable
    INTO #tmp_trx_mes_2
    FROM #tmp_tran_servicio
    WHERE 
        hs_tsfecha >=  @current_month
    AND hs_tsfecha < DATEADD(MONTH, 1, @current_month)
    
    INSERT INTO #tmp_info_cta
    SELECT 
        @current_month,
        t2.hs_cta_banco,
        t2.hs_tipo_contable     
    FROM #tmp_trx_mes_2 t2
    LEFT JOIN #tmp_trx_mes_1 t1 ON t2.hs_cta_banco = t1.hs_cta_banco
    WHERE t1.hs_cta_banco IS NULL

    SET @start_month = @current_month
    DROP TABLE #tmp_trx_mes_1
    DROP TABLE #tmp_trx_mes_2 
END


SELECT substring(convert(char(10), ts_fecha,103),4,7) as MES, cc_nombre NOMBRE, en_ced_ruc IDENTIFICACION, ts_cta CTA, TIPO = 'AHO'
from #tmp_info_cta
inner join cob_cuentas..cc_ctacte on ts_cta = cc_cta_banco
inner join cobis..cl_ente on cc_cliente = en_ente
where ts_tipo = 3
UNION
SELECT substring(convert(char(10), ts_fecha,103),4,7) as MES, ah_nombre NOMBRE, en_ced_ruc IDENTIFICACION, ts_cta CTA, TIPO = 'CTE'
from #tmp_info_cta
inner join cob_ahorros..ah_cuenta on ts_cta = ah_cta_banco
inner join cobis..cl_ente on ah_cliente = en_ente
where ts_tipo = 4
order by MES, NOMBRE



if object_id('tempdb.dbo.#tmp_info_cta') is not null
    drop table #tmp_info_cta

if object_id('tempdb.dbo.#tmp_tran_servicio') is not null
    drop table #tmp_tran_servicio

if object_id('tempdb.dbo.#tmp_trx_mes_1') is not null
    drop table #tmp_trx_mes_1

if object_id('tempdb.dbo.#tmp_trx_mes_2') is not null
    drop table #tmp_trx_mes_2