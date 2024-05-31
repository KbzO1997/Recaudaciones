<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:tns="http://www.bolivariano.com/CashManagement/ws/RecaudacionAgua"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:ns0="http://www.bolivariano.com/FormaPago"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ns3="http://www.bolivariano.com/Enumerados"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:ns6="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns2="http://www.bolivariano.com/CoreBB"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns12="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns13="http://www.bolivariano.com/dominio/Recibo"
                xmlns:ns16="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns17="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesRecaudacionAgua"
                xmlns:ns8="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns1="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype"
                xmlns:ns9="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns10="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:ns5="http://www.bolivariano.com/Restricciones"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns11="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:ns7="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns14="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns4="http://www.bolivariano.com/Comision"
                xmlns:ns15="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                xmlns:java="java"
                exclude-result-prefixes="java xsi xsl tns ns0 ns3 soap ns2 wsdl mime mc ns1 plnk ns5 http xsd ns4 ns6 ns12 ns13 ns16 ns17 ns8 ns9 ns10 ns11 ns7 ns14 ns15 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <ns15:salidaEjecutarPago>
    <xsl:variable name="codigoError" select="/ns7:salidaEjecutarPago/ns7:codigoError"/>
		 <xsl:choose>
		 
			<xsl:when test="$codigoError = 'REV_001'">
				<ns15:codigoError>70013</ns15:codigoError>
				<ns15:mensajeUsuario>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:mensajeUsuario"/>
				</ns15:mensajeUsuario>
			</xsl:when>
			
			<xsl:when test="/ns7:salidaEjecutarPago/ns7:codigoError != 0">
				<ns15:codigoError>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:codigoError"/>
				</ns15:codigoError>
				<ns15:mensajeUsuario>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:mensajeUsuario"/>
				</ns15:mensajeUsuario>
			</xsl:when>
			
			<xsl:otherwise>
			
				<ns15:codigoError>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:codigoError"/>
				</ns15:codigoError>
				<ns15:mensajeUsuario>TRANSACCION EXITOSA</ns15:mensajeUsuario>
				<ns15:mensajeSistema>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:mensajeSistema"/>
				</ns15:mensajeSistema>
				<ns15:montoTotal>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:montoTotal"/>
				</ns15:montoTotal>
				<ns15:referencia>
					<xsl:value-of select='/ns7:salidaEjecutarPago/ns7:datosAdicionales/ns7:datoAdicional[codigo = "vp_s_ssn"]/valor'/>
				</ns15:referencia>
				<ns15:fechaDebito>
          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss"), java:util.Date.new())'/>
        </ns15:fechaDebito>
				<ns15:fechaPago>
					<xsl:value-of select="/ns7:salidaEjecutarPago/ns7:fechaPago"/>
				</ns15:fechaPago>
				<ns15:datosAdicionales/>
				
			</xsl:otherwise>
		</xsl:choose>
    </ns15:salidaEjecutarPago>
  </xsl:template>
</xsl:stylesheet>