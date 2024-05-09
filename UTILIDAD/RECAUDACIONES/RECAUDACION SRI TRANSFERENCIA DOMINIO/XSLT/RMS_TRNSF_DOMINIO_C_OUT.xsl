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
                exclude-result-prefixes="xsi xsl tns ns0 ns3 soap ns2 wsdl mime mc ns1 plnk ns5 http xsd ns4 ns6 ns12 ns13 ns16 ns17 ns8 ns9 ns10 ns11 ns7 ns14 ns15 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
<xsl:template match="/">
	<ns15:salidaConsultarDeuda>
		
		<xsl:choose>

			<xsl:when test="/ns15:salidaConsultarDeuda/ns15:codigoError != 0">
				<ns15:codigoError>
					<xsl:value-of select="/ns15:salidaConsultarDeuda/ns15:codigoError"/>
				</ns15:codigoError>
				<ns15:mensajeUsuario>
					<xsl:value-of select="/ns15:salidaConsultarDeuda/ns15:mensajeUsuario"/>
				</ns15:mensajeUsuario>
			</xsl:when>

			<xsl:otherwise>
			
				<ns15:codigoError>0</ns15:codigoError>
				<ns15:mensajeUsuario>Mensaje Procesado</ns15:mensajeUsuario>
				<ns15:formaPago>TOTAL</ns15:formaPago>
				<ns15:formaPagoRecibos>UNICO_CRONOLOGICO</ns15:formaPagoRecibos>
				
				<ns15:mensajeSistema>
					<xsl:value-of select="/ns15:salidaConsultarDeuda/ns15:mensajeSistema"/>
				</ns15:mensajeSistema>
				
				<ns15:montoTotal>
					<xsl:value-of select="/ns15:salidaConsultarDeuda/ns15:montoTotal"/>
				</ns15:montoTotal>
				
				<xsl:if test="/ns15:salidaConsultarDeuda/ns15:nombreCliente">
					<ns15:nombreCliente>
						<xsl:value-of select="/ns15:salidaConsultarDeuda/ns15:nombreCliente"/>
					</ns15:nombreCliente>
				</xsl:if>


				<ns15:datosAdicionales>
					
					<xsl:for-each select="/ns15:salidaConsultarDeuda/ns15:datosAdicionales/ns15:datoAdicional">
					  <ns15:datoAdicional>
						<codigo>
						  <xsl:value-of select="codigo"/>
						</codigo>
						<etiqueta>
						  <xsl:value-of select="descripcion"/>
						</etiqueta>
						<editable>
						  <xsl:text disable-output-escaping="no">false</xsl:text>
						</editable>
						<valor>
						  <xsl:value-of select="valor"/>
						</valor>
						<xsl:choose>
						  <xsl:when test='imprimir = "SI"'>
							<visible>
							  <xsl:text disable-output-escaping="no">true</xsl:text>
							</visible>
						  </xsl:when>
						  <xsl:when test='imprimir != "SI"'>
							<visible>
							  <xsl:text disable-output-escaping="no">false</xsl:text>
							</visible>
						  </xsl:when>
						</xsl:choose>
					  </ns15:datoAdicional>
					</xsl:for-each>

				</ns15:datosAdicionales>

			</xsl:otherwise>
		</xsl:choose>
	</ns15:salidaConsultarDeuda>
</xsl:template>
</xsl:stylesheet>