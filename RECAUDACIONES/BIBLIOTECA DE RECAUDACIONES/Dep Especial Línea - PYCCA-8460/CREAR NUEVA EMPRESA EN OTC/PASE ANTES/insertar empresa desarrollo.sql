
 select *
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_cte_servicios'
  and a.codigo = b.tabla
  and b.codigo in ('412','8460')
  and estado = 'V'


insert into cobis..cl_catalogo values   (1091,'8460','779','V')  
insert into cobis..cl_catalogo values   (1091,'412','779','V')  

  select *
  from cobis..cl_tabla a, cobis..cl_catalogo b
  where a.tabla = 'causa_nd_aho_servicios'
  and a.codigo = b.tabla
  and b.codigo in ('412','8460')
  and estado = 'V'


insert into cobis..cl_catalogo values   (1092,'8460','779','V')  
insert into cobis..cl_catalogo values   (1092,'412','779','V')  


  select *
    from cob_pagos..pg_person_empresa
    where pe_empresa in (412,8460)


(8460,'0990000530001','DIRECCION:412','PYCCA S.A.',0,'N',0.00,'NCRCTA','CTE','0005055474',0,null,0,0,0,null,'N',null,'N','N','Costa',6655752,0,'CSPR','DMPY',1,0.12,'53',null,'N')
insert into cob_pagos..pg_person_empresa values
(8460,'0990000530001','DIRECCION:412','PYCCA S.A.',0,'N',0.00,'NCRCTA','CTE','0005055474',0,null,0,0,0,null,'N',null,'N','N','Costa',0,0,null,null,0,null,null,'S',null,null,null)

delete cob_pagos..pg_person_empresa where pe_empresa in (8460)



	select * 
	from cobis..cl_tabla a inner join  cobis..cl_catalogo b
	on a.codigo = b.tabla
	where a.tabla = 'causa_nd_comision_servaho'
	and b.codigo  in ('412','8460')
	and b.estado = 'V'


update cobis..cl_catalogo set valor ='778' where tabla = 27977  and codigo = '8460'
	


	select *
	from cobis..cl_tabla a inner join  cobis..cl_catalogo b
		on a.codigo = b.tabla
	where a.tabla = 'causa_nd_comision_servcte'
	and b.codigo in ('412','8460')


update cobis..cl_catalogo set valor ='778' where tabla = 27976  and codigo = '8460'
	
