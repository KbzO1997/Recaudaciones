<?xml version="1.0" encoding="UTF-8" ?>
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
                xmlns:ns10="http://www.bolivariano.com/dominio/ListaSeleccion"
                xmlns:ns9="http://www.bolivariano.com/dominio/RegionalArea"
                xmlns:ns0="http://www.bolivariano.com/dominio/Servicio"
                xmlns:ns13="http://www.bolivariano.com/MensajeBolivariano"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:ns17="http://www.bolivariano.com/Recaudo"
                xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath"
                xmlns:med="http://schemas.oracle.com/mediator/xpath"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns2="http://www.bolivariano.com/dominio/TipoMatriculacion"
                xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath"
                xmlns:mcnel="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
                xmlns:ns3="http://www.bolivariano.com/dominio/FormaPago"
                xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:ns4="http://www.bolivariano.com/dominio/TipoIdentificador"
                xmlns:tns="http://www.bolivariano.com/ws/OTCService"
                xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns15="http://www.bolivariano.com/Producto"
                xmlns:ns18="http://www.bolivariano.com/Cliente"
                xmlns:ns7="http://www.bolivariano.com/dominio/Empresa"
                xmlns:ns19="http://www.bolivariano.com/Comision"
                xmlns:ns8="http://www.bolivariano.com/mensaje/MensajeOTC"
                xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap"
                xmlns:java="java"
                exclude-result-prefixes="xsi xsl ns1 soap wsdl ns5 ns6 ns10 ns9 ns0 ns2 ns3 ns4 tns xsd ns7 ns8 ns12 ns14 ns16 ns13 ns17 mcnel http ns15 ns18 ns19 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
	<xsl:template match="/">
		<mcnel:MensajeEntradaPagar>

			<canal>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:canal"/>
			</canal>

			<depuracion>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</depuracion>

			<fecha>
				<xsl:value-of select='substring(/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_date"]/valor,1,19)'/>
			</fecha>		

			<oficina>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ofi"]/valor'/>
			</oficina>

			<terminal>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_term"]/valor'/>
			</terminal>

			<transaccion>
				<xsl:text disable-output-escaping="no">62676</xsl:text>
			</transaccion>

			<secuencial>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_ssn"]/valor'/>
			</secuencial>

			<usuario>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_user"]/valor'/>
			</usuario>

			<codigoEmpresa>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa"/>
			</codigoEmpresa>
			
			<codigoSubempresa>									
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoEmpresa"/>
			</codigoSubempresa>

			<moneda>
				<xsl:text disable-output-escaping="no">1</xsl:text>
			</moneda>

			<tipoProceso>
				<xsl:text disable-output-escaping="no">1</xsl:text>
			</tipoProceso>

			<tipoIdentificacion>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/codigoTipoIdentificador"/>			
			</tipoIdentificacion>

			<identificacion>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:servicio/identificador'/>				
			</identificacion>

			<monedaPago>
				<xsl:text disable-output-escaping="no">USD</xsl:text>
			</monedaPago>

			<fechaPago>
				<xsl:value-of select="concat(substring(/ns8:entradaEjecutarPago/ns8:fechaPago,6,2),'/', substring(/ns8:entradaEjecutarPago/ns8:fechaPago,9,2),'/', substring(/ns8:entradaEjecutarPago/ns8:fechaPago,1,4)) "/>				
			</fechaPago>

			<horaPago>
				<xsl:value-of select='java:format(java:text.SimpleDateFormat.new("HH:mm:ss"), java:util.Date.new())'/>
			</horaPago>

			<canalProceso>
				<xsl:text disable-output-escaping="no">WEBBCO</xsl:text>
			</canalProceso>

			<codigoBanco>
				<xsl:text disable-output-escaping="no">BOL</xsl:text>
			</codigoBanco>

			<formaPago>
				<xsl:text disable-output-escaping="no">DEB</xsl:text>
			</formaPago>

			<numeroDocumento>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:servicio/identificador"/>
			</numeroDocumento>

			<referenciaDocumento>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</referenciaDocumento>

			<nombreCliente>
				<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:nombreCliente"/>
			</nombreCliente>

			<pago>
				<valorPagoTotal>
					<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
				</valorPagoTotal>
				
				<xsl:variable name="comision">
					<xsl:choose>
						<xsl:when test="string-length(/ns8:entradaEjecutarPago/ns8:valorComision)=0">0.0</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorComision"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<valorComisionTotal>
					<xsl:value-of select="$comision"/>
				</valorComisionTotal>

				<debitoCuenta>
					<tipoCuenta>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:tipoCuenta"/>
					</tipoCuenta>
					<cuenta>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:cuenta"/>
					</cuenta>
					<valor>
						<xsl:value-of select="/ns8:entradaEjecutarPago/ns8:valorPago"/>
					</valor>
					<valorComision>
						<xsl:value-of select="$comision"/>
					</valorComision>
				</debitoCuenta>
				<efectivo>
					<valor>0.00</valor>
					<valorComision>0.00</valorComision>
				</efectivo>
				<cheque>
					<cantidadCheques>0</cantidadCheques>
					<valor>0.00</valor>
					<valorComision>0.00</valorComision>
				</cheque>
			</pago>

			<modoCorreccion>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</modoCorreccion>

			<aplicacionCobis>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</aplicacionCobis>

			<modoProceso>
				<xsl:text disable-output-escaping="no">N</xsl:text>
			</modoProceso>

			<tipoPago>
				<xsl:text disable-output-escaping="no">32</xsl:text>
			</tipoPago>

			<ubicacion>0</ubicacion>

			<rol>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_rol"]/valor'/>
			</rol>

			<servidor>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_srv"]/valor'/>
			</servidor>

			<servidorLocal>
				<xsl:value-of select='/ns8:entradaEjecutarPago/ns8:datosAdicionales/ns8:datoAdicional[codigo = "s_srv"]/valor'/>
			</servidorLocal>


		</mcnel:MensajeEntradaPagar>
	</xsl:template>
</xsl:stylesheet>
