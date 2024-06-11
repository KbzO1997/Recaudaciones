<?xml version="1.0" encoding="UTF-8" ?>
<?oracle-xsl-mapper <!-- SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY. -->
  <mapSources>
    <source type="WSDL">
      <schema location="../otc-nopolicy.wsdl"/>
      <rootElement name="entradaConsultarDeuda" namespace="http://www.bolivariano.com/ws/OTCService"/>
    </source>
  </mapSources>
  <!-- GENERATED BY ORACLE XSL MAPPER 11.1.1.7.0(build 130301.0647.0008) AT [MON MAY 28 15:06:02 COT 2018]. -->
?>
<xsl:stylesheet version="1.0"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:ns12="http://www.bolivariano.com/EE"
                xmlns:ns1="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns14="http://www.bolivariano.com/CoreBB"
                xmlns:ns16="http://www.bolivariano.com/Cuenta"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns5="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns6="http://www.bolivariano.com/dominio/Recibo"
                xmlns:ns9="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns10="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns0="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns13="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:ns17="http://www.bolivariano.com/Recaudo"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:ns2="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns3="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:mcnel="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns4="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:tns="http://www.bolivariano.com/ws/OTCService"
                xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns15="http://www.bolivariano.com/Producto"
                xmlns:ns7="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns18="http://www.bolivariano.com/Cliente"
                xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ns19="http://www.bolivariano.com/Comision"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                xmlns:java="java"
                exclude-result-prefixes="xsi xsl ns1 soap wsdl ns5 ns6 ns9 ns10 ns0 ns2 ns3 ns4 tns xsd ns7 ns8 ns12 ns14 ns16 ns13 ns17 mcnel http ns15 ns18 ns19 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
	<xsl:template match="/">
		<mcnel:MensajeEntradaConsultar>
		
			<canal>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:canal"/>
			</canal>
			
			<fecha>
				<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_date"]/valor'/>
			</fecha>
			
			<oficina>
				<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_ofi"]/valor'/>
			</oficina>
			
			<terminal>
				<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/>
			</terminal>
			
			<transaccion>
				<xsl:text disable-output-escaping="no">62675</xsl:text>
			</transaccion>
			
			<secuencial>
				<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/>
			</secuencial>
			
			<usuario>
				<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_user"]/valor'/>
			</usuario>
			
			<codigoEmpresa>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoEmpresa"/>
			</codigoEmpresa>
			
			<codigoSubempresa>									
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoEmpresa"/>
			</codigoSubempresa>
			
			<tipoIdentificacion>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoIdentificador"/>			
			</tipoIdentificacion>
			
			<codigo>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/identificador"/>
			</codigo>
			
		</mcnel:MensajeEntradaConsultar>
	</xsl:template>
</xsl:stylesheet>
