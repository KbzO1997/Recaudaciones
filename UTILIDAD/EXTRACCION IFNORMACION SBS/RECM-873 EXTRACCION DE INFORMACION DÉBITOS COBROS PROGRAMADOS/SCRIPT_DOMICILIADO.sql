select CONVERT(VARCHAR(10), hs_tsfecha, 101)  FECHA, isnull(en_ced_ruc,p_pasaporte) IDENTIFICACION, isnull(cc_nombre, ah_nombre) CLIENTE, hs_clase ESTADO, 
hs_cta_banco CTA, case when cc_cta_banco is not null then 'C' when ah_cta_banco is not null then 'A' else hs_tipocta end TIPO, hs_causa EMPRESA, hs_referencia SUBMINISTRO
from cob_cuentas_his..cc_his_servicio
left join cob_cuentas..cc_ctacte on hs_cta_banco = cc_cta_banco
left join cob_ahorros..ah_cuenta on hs_cta_banco = ah_cta_banco
inner join cobis..cl_ente on isnull(cc_cliente, ah_cliente) = en_ente
where 
hs_tsfecha between '06/01/2023' and '12/31/2023'
and hs_causa in ('1127')
and hs_tipo_transaccion in (3182)
and hs_clase in ('I')