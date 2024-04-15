cob_pagos..sp_helptext pa_pag_a_concilia_broadnet_x, null , null, showsql
--Para generar el reporte automatico se debe de usar esta tabla 
--tener en cuenta que debe estar llebna la tabla 
cob_pagos..sp_helptext pa_pag_c_concilia_broadnet_e, null , null, showsql

select * from cob_cuentas..cc_tran_servicio_resp where ts_tsfecha = '04/11/2022'
select * from cob_cuentas..cc_tran_servicio where ts_causa in ('8456') and ts_tsfecha = '04/11/2022'
select * from cob_pagos..cc_l_auxiliar_recarga where ar_fec_proceso = '04/11/2022' and ar_operadora = 8456
select * from cob_pagos..pag_t_broadnet_servicio
select * from cob_pagos..pag_t_concilia_broadnet where co_fec_cble = '04/11/2022' and co_empresa = '8456'

create nonclustered index i_pag_t_concilia_broadnet_02 on dbo.pag_t_concilia_broadnet (co_num_ref)