<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:ns11="http://www.bolivariano.com/CashManagement/ws/RecaudacionAgua"
                xmlns:ns12="http://www.bolivariano.com/FormaPago"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/"
                xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ns15="http://www.bolivariano.com/Enumerados"
                xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions"
                xmlns:ns1="http://www.bolivariano.com/dominio/DatoAdicional"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:ns14="http://www.bolivariano.com/CoreBB"
                xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:ora="http://schemas.oracle.com/xpath/extension"
                xmlns:ns5="http://www.bolivariano.com/dominio/Convenio"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:ns6="http://www.bolivariano.com/dominio/Recibo"
                xmlns:ns10="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns9="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesRecaudacionAgua"
                xmlns:ns0="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns13="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns2="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:ns3="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:ns17="http://www.bolivariano.com/Restricciones"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns4="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:tns="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns7="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns16="http://www.bolivariano.com/Comision"
                xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                exclude-result-prefixes="xsi xsl ns1 soap wsdl ns5 ns6 ns10 ns9 ns0 ns2 ns3 ns4 tns xsd ns7 ns8 ns11 ns12 ns15 ns14 mime mc ns13 plnk ns17 http ns16 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
  <xsl:template match="/">
	<ns2:entradaConsultarDeuda xmlns:ns2="http://www.bolivariano.com/mensaje/MensajeOTC">
		<ns2:canal>
			<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:canal"/>
		</ns2:canal>
		<ns2:depuracion>
			<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:depuracion"/>
		</ns2:depuracion>
		<xsl:variable name="fecha" select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_date"]/valor'/>
		<xsl:choose>
			<xsl:when test="$fecha">
				<ns2:fecha>
					<xsl:value-of select="substring($fecha, 1,19)"/>
				</ns2:fecha>
			</xsl:when>
			<xsl:otherwise>
				<ns2:fecha>
					<xsl:value-of select="substring(/ns8:entradaConsultarDeuda/ns8:fecha, 1,19)"/>
				</ns2:fecha>
			</xsl:otherwise>
		</xsl:choose>
		<ns2:oficina>
			<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:oficina"/>
		</ns2:oficina>
		<xsl:variable name="secuencial" select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/>
		<xsl:choose>
			<xsl:when test="$secuencial">
				<ns2:secuencial>
					<xsl:value-of select="$secuencial"/>
				</ns2:secuencial>
			</xsl:when>
			<xsl:otherwise>
				<ns2:secuencial>
					<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:oficina/secuencial"/>
				</ns2:secuencial>
			</xsl:otherwise>
		</xsl:choose>
		<ns2:servicio>
			<codTipoServicio>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codTipoServicio"/>
			</codTipoServicio>
			<codigoConvenio>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoConvenio"/>
			</codigoConvenio>
			<codigoEmpresa>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoEmpresa"/>
			</codigoEmpresa>
			<codigoTipoBanca>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoBanca"/>
			</codigoTipoBanca>
			<codigoTipoIdentificador>
				<xsl:choose>
						<xsl:when test="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoIdentificador = 'CED'">
						  <xsl:text disable-output-escaping="no">002</xsl:text>
						</xsl:when>
						<xsl:when test="/ns8:entradaEjecutarPago/ns8:servicio/codigoTipoIdentificador = 'RUC'">
						  <xsl:text disable-output-escaping="no">008</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="no">007</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
			</codigoTipoIdentificador>
			<datosAdicionales>
				<datoAdicional>
					<codigo>e_srv</codigo>
					<valor>
						<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_term</codigo>
					<valor>
						<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_rol</codigo>
					<valor>
						<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_corr</codigo>
					<valor>N</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_ssn_corr</codigo>
					<valor>0</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_mon</codigo>
					<valor>1</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_servicio</codigo>
					<valor>
						<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoConvenio"/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_identificacion</codigo>
					<valor>
						<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/codigoTipoIdentificador"/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_autoriza</codigo>
					<valor>N</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_ubi</codigo>
					<valor>
						<xsl:value-of select='/ns8:entradaConsultarDeuda/ns8:datosAdicionales/ns8:datoAdicional[codigo = "i_ubi"]/valor'/>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_opcion</codigo>
					<valor>C</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_prov_req</codigo>
					<valor>
						<xsl:text disable-output-escaping="no">MS_REC_ECUTEL_REQ</xsl:text>
					</valor>
				</datoAdicional>
				<datoAdicional>
					<codigo>e_prov_resp</codigo>
					<valor>
						<xsl:text disable-output-escaping="no">MS_REC_ECUTEL_RESP</xsl:text>
					</valor>
				</datoAdicional>
			</datosAdicionales>
			<identificador>
				<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:servicio/identificador"/>
			</identificador>
		</ns2:servicio>
		<ns2:transaccion>
			<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:transaccion"/>
		</ns2:transaccion>
		<ns2:usuario>
			<xsl:value-of select="/ns8:entradaConsultarDeuda/ns8:usuario"/>
		</ns2:usuario>
	</ns2:entradaConsultarDeuda>
  </xsl:template> 
</xsl:stylesheet>