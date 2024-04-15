UPDATE  OTC_D_SERVICIO SET
    SRV_NOMBRE = 'Xtrim  TVCable Internet'
WHERE SRV_ID = 201;

UPDATE  OTC_D_SERVICIO SET
    SRV_NOMBRE = 'Xtrim  TVCable TV Pagada'
WHERE SRV_ID = 202;

UPDATE  OTC_D_SERVICIO SET
    SRV_NOMBRE = 'Xtrim  TVCable Telefono'
WHERE SRV_ID = 204;

update OTC_M_EMPRESA 
set emp_nombre = 'Xtrim TVCable',
emp_descripcion = 'Xtrim TVCable'
where emp_id = 163;