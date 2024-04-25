cob_servicios..sp_helptext sp_tr_pago_senae_rc_OSB, null, null, showsql
cob_servicios..sp_helptext sp_tr_pago_senae_rc, null, null, showsql


select v_cod_grupo = pe_cod_grupo

from cob_pagos..pg_person_empresa

where pe_empresa = 8976


select *

from cob_servicios..sv_movtos_aduanas
order by ma_fechmovi desc

-- where ma_declaracion = '7400001051000502026' 
where ma_papeleta = '7400001051000502026' 

--delete from  cob_servicios..sv_movtos_aduanas
--where ma_papeleta =  '7400001051000502585'

update 
set = 7400001051000502026
where ma_papeleta = '7400001051000502026' 