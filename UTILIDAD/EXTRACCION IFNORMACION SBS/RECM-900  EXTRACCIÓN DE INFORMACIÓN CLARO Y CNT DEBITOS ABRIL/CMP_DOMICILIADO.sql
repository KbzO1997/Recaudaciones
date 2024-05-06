select distinct CONVERT(VARCHAR(10), hs_tsfecha, 101)  FECHA, isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION, isnull(cc_nombre, ah_nombre) CLIENTE, hs_clase ESTADO, 
hs_cta_banco CTA, case when cc_cta_banco is not null then 'C' when ah_cta_banco is not null then 'A' else hs_tipocta end TIPO, hs_causa EMPRESA
FROM cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
WHERE 
hs_tsfecha between '04/01/2024' and '04/31/2024'
and hs_causa in ('361','8454','8453','144','1127','1330','825','1719','4977','4978','4981','331')
and hs_tipo_transaccion in (3182)
and hs_clase in ('I')
