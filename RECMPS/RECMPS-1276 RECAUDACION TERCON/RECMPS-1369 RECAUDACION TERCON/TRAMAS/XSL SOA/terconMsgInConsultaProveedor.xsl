<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:men="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"
 exclude-result-prefixes="men"
 >
  <xsl:template match="/">
    <bol:CargarDatosEntrada  xmlns:bol="http://54.86.239.96:8001/BankWS/BolivarianoWS/">
		<tipoIdentificacion><xsl:value-of select="men:MensajeEntradaConsultar/tipoIdentificacion"/></tipoIdentificacion>
		<parametroBusqueda><xsl:value-of select="men:MensajeEntradaConsultar/codigo"/></parametroBusqueda>
	</bol:CargarDatosEntrada>
  </xsl:template>
</xsl:stylesheet>