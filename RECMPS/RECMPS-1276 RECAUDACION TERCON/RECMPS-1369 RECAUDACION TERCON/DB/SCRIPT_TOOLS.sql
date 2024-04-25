--<--Script Funcionales-->
select * from OTC_M_EMPRESA where emp_nombre like '%Servi%';

--<--Script Funcionales-->
update OTC_M_EMPRESA set emp_nombre = 'Impuestos Aduaneros (SENAE)' , emp_descripcion = 'Impuestos Aduaneros (SENAE)' where emp_id = 23;

--<--Script Para cambiar de empresa a Aretina-->
UPDATE otc_m_grupo_servicio SET CT_ID_TIPO_SERV = 30  WHERE GRP_ID = 618; --Estaba en:26

--<!--Script Para hacer aparecer un servicio como TipoPago en 24 Online-->
update otc_m_grupo_servicio set grp_convenio_visible = 1 where grp_id = 702;