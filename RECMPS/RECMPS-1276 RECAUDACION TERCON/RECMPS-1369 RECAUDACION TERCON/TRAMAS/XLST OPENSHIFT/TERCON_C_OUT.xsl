<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mcnel="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
				xmlns:ns4="http://www.bolivariano.com/CashManagement/DepositoEnLinea"
                xmlns:ns14="http://www.bolivariano.com/mensaje/MensajeOTC"
                exclude-result-prefixes="xsl ns14 ns4">
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/mcnel:MensajeSalidaConsultar/codigoError='0'">
				<ns14:salidaConsultarDeuda>					
					<ns14:codigoError>
						<xsl:value-of select="/mcnel:MensajeSalidaConsultar/codigoError"/>
					</ns14:codigoError>					   
					<ns14:formaPago>TOTAL</ns14:formaPago>
					<ns14:montoTotal>
                        <xsl:value-of select="format-number(/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:deuda, '0.00')"/>
					</ns14:montoTotal>
					<ns14:nombreCliente>
						<xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:nombreCliente"/>
					</ns14:nombreCliente>
					<ns14:datosAdicionales>
						<ns14:datoAdicional>
							<codigo>
								<xsl:text disable-output-escaping="no">nDocumento</xsl:text>
							</codigo>
							<editable>
								<xsl:text disable-output-escaping="no">false</xsl:text>
							</editable>
							<valor>
								<xsl:value-of select="/mcnel:MensajeSalidaConsultar/informacionDeposito/ns4:numeroDocumento"/>
							</valor>
							<visible>
								<xsl:text disable-output-escaping="no">false</xsl:text>
							</visible>
						</ns14:datoAdicional>
					</ns14:datosAdicionales>

				</ns14:salidaConsultarDeuda>
			</xsl:when>
			<xsl:otherwise>
				<ns14:salidaConsultarDeuda>
					<ns14:codigoError>
						<xsl:value-of select="/mcnel:MensajeSalidaConsultar/codigoError"/>
					</ns14:codigoError>
					<ns14:mensajeUsuario>
						<xsl:value-of select="/mcnel:MensajeSalidaConsultar/mensajeUsuario"/>
					</ns14:mensajeUsuario>               
				</ns14:salidaConsultarDeuda>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>