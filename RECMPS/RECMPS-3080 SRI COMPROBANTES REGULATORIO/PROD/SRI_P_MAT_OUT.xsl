<?xml version="1.0" encoding="UTF-8" ?>
<?oracle-xsl-mapper <!-- SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY. -->
  <mapSources>
    <source type="WSDL">
      <schema location="../xsd/SRI/SRI_1.wsdl"/>
      <rootElement name="MensajeSalidaPagarMatriculaSRI" namespace="http://www.bolivariano.com/MensajeSRI"/>
    </source>
  </mapSources>
  <mapTargets>
    <target type="WSDL">
      <schema location="../otc-nopolicy.wsdl"/>
      <rootElement name="salidaEjecutarPago" namespace="http://www.bolivariano.com/ws/OTCService"/>
    </target>
  </mapTargets>
  <!-- GENERATED BY ORACLE XSL MAPPER 11.1.1.7.0(build 130301.0647.0008) AT [FRI MAY 25 16:54:04 COT 2018]. -->
?>
<xsl:stylesheet version="1.0"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:ns0="http://www.bolivariano.com/FormaPago"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ns2="http://www.bolivariano.com/Vehiculo"
                xmlns:ns3="http://www.bolivariano.com/Enumerados"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:xsd1="http://www.bolivariano.com/MensajeSRI"
                xmlns:ns11="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns5="http://www.bolivariano.com/CoreBB"
                xmlns:ns6="http://www.bolivariano.com/Cuenta"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns17="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns18="http://www.bolivariano.com/dominio/Recibo"
                xmlns:tns="http://www.bolivariano.com/ws/SRI/"
                xmlns:ns22="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns21="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns13="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns1="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:ns4="http://www.bolivariano.com/Recaudo"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:ns14="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns15="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns16="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:ns12="http://www.bolivariano.com/ws/OTCService"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns7="http://www.bolivariano.com/Producto"
                xmlns:ns19="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns8="http://www.bolivariano.com/Cliente"
                xmlns:ns20="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ns9="http://www.bolivariano.com/Comision"
                xmlns:ns10="http://www.bolivariano.com/SRI" xmlns:java="java"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                exclude-result-prefixes="xsi xsl ns0 ns2 ns3 xsd1 soap ns5 ns6 wsdl tns ns1 ns4 xsd ns7 ns8 ns9 ns10 ns11 ns17 ns18 ns22 ns21 ns13 ns14 ns15 ns16 ns19 ns20 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
  <xsl:template match="/">
    <ns20:salidaEjecutarPago>
      <xsl:choose>
        <xsl:when test="/xsd1:MensajeSalidaPagarMatriculaSRI/codigoError='0'">
          <xsl:call-template name="RespuestaOK"/>
        </xsl:when>
        <xsl:when test="/xsd1:MensajeSalidaPagarMatriculaSRI/codigoError!='0'">
          <xsl:call-template name="RespuestaError"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="RespuestaError"/>
        </xsl:otherwise>
      </xsl:choose>
    </ns20:salidaEjecutarPago>
  </xsl:template>
  <!--  User Defined Templates  -->
  <xsl:template name="RespuestaError">
    <ns20:codigoError>
      <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/codigoError"/>
    </ns20:codigoError>
    <ns20:mensajeUsuario>
      <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/mensajeUsuario"/>
    </ns20:mensajeUsuario>
  </xsl:template>
  <xsl:template name="RespuestaOK">
    <ns20:codigoError>
      <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/codigoError"/>
    </ns20:codigoError>
    <ns20:mensajeUsuario>
      <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/mensajeUsuario"/>
    </ns20:mensajeUsuario>
    <ns20:datosAdicionales>
      <xsl:for-each select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/listaRubros/rubro">
        <ns20:datoAdicional>
          <codigo>
            <xsl:value-of select="codigo"/>
          </codigo>
          <etiqueta>
            <xsl:value-of select="descripcion"/>
          </etiqueta>
          <valor>
            <xsl:value-of select="valor"/>
          </valor>
          <xsl:choose>
            <xsl:when test="imprimir='SI'">
              <visible>
                <xsl:text disable-output-escaping="no">true</xsl:text>
              </visible>
            </xsl:when>
            <xsl:when test="imprimir!='SI'">
              <visible>
                <xsl:text disable-output-escaping="no">false</xsl:text>
              </visible>
            </xsl:when>
          </xsl:choose>
        </ns20:datoAdicional>
      </xsl:for-each>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">propietario</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">Nombre del Propietario:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionVehiculo/propietario"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">identificacionPropietario</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">Identificación del Propietario:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionVehiculo/identificacionPropietario"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">valorAvaluo</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">Valor Avaluo:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionVehiculo/valorAvaluo div 100"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">chasis</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">No. Chasis:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionVehiculo/chasis"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">autSRI</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">No. autorizacion SRI:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/autorizacionSRI"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
        <codigo>
          <xsl:text disable-output-escaping="no">logSRI</xsl:text>
        </codigo>
        <etiqueta>
          <xsl:text disable-output-escaping="no">Log. autorizacion SRI:</xsl:text>
        </etiqueta>
        <editable>
          <xsl:text disable-output-escaping="no">false</xsl:text>
        </editable>
        <valor>
          <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/logSRI"/>
        </valor>
        <visible>
          <xsl:text disable-output-escaping="no">true</xsl:text>
        </visible>
      </ns20:datoAdicional>
      <ns20:datoAdicional>
					<codigo>horario</codigo>
					<valor>
						<xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/horario"/>
					</valor>
				</ns20:datoAdicional>
      <!--KBastida Ini-->
        <ns20:datoAdicional>
          <codigo>08</codigo>
          <etiqueta>Código IFI de Transacción</etiqueta>
          <valor>
            <xsl:value-of select='concat(java:format(java:text.SimpleDateFormat.new("yyyyMMdd"), java:util.Date.new()), /xsd1:MensajeSalidaPagarMatriculaSRI/informacionCore/secuencial)'/>
          </valor>
          <visible>true</visible>
        </ns20:datoAdicional>
        <!--Fin-->

    </ns20:datosAdicionales>
    <ns20:fechaPago>
      <xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/fechaContable"/>
          </ns20:fechaPago>
      <ns20:fechaDebito>
        <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS"), java:util.Date.new())'/>
      </ns20:fechaDebito>

	  
	<xsl:choose>
		<xsl:when test="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/canalCobranza = 'CNB'">
			<ns20:referencia>
				<xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionCore/secuencial"/>
			</ns20:referencia>
		</xsl:when>
		<xsl:otherwise>
			<ns20:referencia>
				<xsl:value-of select="/xsd1:MensajeSalidaPagarMatriculaSRI/informacionSRI/autorizacionSRI"/>
			</ns20:referencia>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>
</xsl:stylesheet>
