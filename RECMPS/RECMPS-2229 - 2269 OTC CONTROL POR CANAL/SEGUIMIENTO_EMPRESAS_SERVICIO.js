GrupoServicio {
    id=618, servicios=[], tipoBanca=null, tipoServicio=null, 
empresa=Empresa{id=388, codigo='26', descripcion='ARETINA', identificacion='0991169024001', nombre='ARETINA'}, 
convenioVisible=false, matriculable=false, matriculacionMultiple=false, validable=false
}

[GrupoServicio {
    id=618, servicios=[Servicio{id=818, grupoServicio=null, nombre='ARETINA', 
    convenio=Convenio{id=294, codigo='26', etiquetaCodigo='ARE', visible=true, flujos=null, 
    tipoIdentificadores=[TipoIdentificador{id=300, codigo='CODIGO', etiquetaCodigo='Código', concatenadorRegionalArea='null', datoAdicionales=null, flujoAyuda='null', mascara='null',
     matriculable=false, programable=true, regexp='^([A-Z-0-9]){1,20}$', regionalAreas=null, textoAyuda='Ingrese código (RSV o RHD)0000000000', formaPagos=null}]}}], 
    tipoBanca=null, tipoServicio=null, 
    empresa=Empresa{id=388, codigo='26', descripcion='ARETINA', identificacion='0991169024001', nombre='ARETINA'}, 
    convenioVisible=false, matriculable=false, matriculacionMultiple=false, validable=false
}

PARA QUE NO SE VISUALIZE LA EMNPRESA SE DEBIO VALIDAR QUE ESTE NO TENGA SERVICIOS DE ESTA MANERA NO SE LE HACE UN ADD 
Y SOLAMENTE SE HACE CUANDO OTC_ENDPOINT-IMPL
if(empresa.getCodigoEmpresa() != null) {
    empresas.getEmpresa().add(empresa);	
}