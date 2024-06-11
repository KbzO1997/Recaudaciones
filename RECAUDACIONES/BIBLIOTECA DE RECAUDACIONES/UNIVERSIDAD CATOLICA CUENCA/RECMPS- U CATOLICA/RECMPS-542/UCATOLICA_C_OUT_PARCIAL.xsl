<?xml version="1.0" encoding="UTF-8" ?>
<?oracle-xsl-mapper <!-- SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY. -->
  <mapTargets>
    <target type="WSDL">
      <schema location="../otc-nopolicy.wsdl"/>
      <rootElement name="salidaConsultarDeuda" namespace="http://www.bolivariano.com/ws/OTCService"/>
    </target>
  </mapTargets>
  <!-- GENERATED BY ORACLE XSL MAPPER 11.1.1.7.0(build 130301.0647.0008) AT [MON MAY 28 16:42:38 COT 2018]. -->
?>
<xsl:stylesheet version="1.0"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:ns0="http://www.bolivariano.com/EE"
                xmlns:ns8="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns2="http://www.bolivariano.com/CoreBB"
                xmlns:ns4="http://www.bolivariano.com/CashManagement/DepositoEnLinea"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns14="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns15="http://www.bolivariano.com/dominio/Recibo"
                xmlns:ns19="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns18="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns10="http://www.bolivariano.com/dominio/Servicio"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:ns1="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:ns5="http://www.bolivariano.com/Recaudo"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:ns11="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns12="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:mcnel="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns13="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:ns9="http://www.bolivariano.com/ws/OTCService"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
                xmlns:ns3="http://www.bolivariano.com/Producto"
                xmlns:ns16="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns6="http://www.bolivariano.com/Cliente"
                xmlns:ns17="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ns7="http://www.bolivariano.com/Comision"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"

                exclude-result-prefixes="xsi xsl ns0 soap ns2 ns4 wsdl ns1 ns5 mcnel xsd http ns3 ns6 ns7 ns8 ns14 ns15 ns19 ns18 ns10 ns11 ns12 ns13 ns9 ns16 ns17 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
	<xsl:template match="/">
		<ns17:salidaConsultarDeuda>
			<xsl:choose>
				<xsl:when test="/mcnel:MensajeSalidaConsultar/codigoError='0'">
					<xsl:call-template name="RespuestaOK"/>
				</xsl:when>
				<xsl:when test="/mcnel:MensajeSalidaConsultar/codigoError!='0'">
					<xsl:call-template name="RespuestaError"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="RespuestaError"/>
				</xsl:otherwise>
			</xsl:choose>
		</ns17:salidaConsultarDeuda>
	</xsl:template>
	<xsl:template name="RespuestaOK">
		<ns17:codigoError>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/codigoError"/>
		</ns17:codigoError>
		<ns17:montoMinimo>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:deudaMinima"/>
		</ns17:montoMinimo>
		<ns17:montoTotal>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:deuda"/>
		</ns17:montoTotal>
		<ns17:mensajeUsuario>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/mensajeUsuario"/>
		</ns17:mensajeUsuario>
		<ns17:formaPago>
			<xsl:text disable-output-escaping="no">ABONO</xsl:text>
		</ns17:formaPago>
		<ns17:nombreCliente>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:nombreCliente"/>
		</ns17:nombreCliente>
		<ns17:recibos>
			<ns17:recibo>
			<totalAPagar><xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:deudaMinima"/></totalAPagar>
			</ns17:recibo>
		</ns17:recibos>
		
	</xsl:template>
	<xsl:template name="RespuestaError">
		<ns17:codigoError>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/codigoError"/>
		</ns17:codigoError>
		<ns17:mensajeUsuario>
			<xsl:value-of select="/mcnel:MensajeSalidaConsultar/mensajeUsuario"/>
		</ns17:mensajeUsuario>
	</xsl:template>
</xsl:stylesheet>
