<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:bol="http://54.86.239.96:8001/BankWS/BolivarianoWS/"
 exclude-result-prefixes="men ns0">
  <xsl:template match="/">

   
<mc:MensajeSalidaReversar xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea" >
	<xsl:choose>
			<xsl:when test="/RegistrarPagoBancoSalida/codigoError='0000'">
			<codigoError xmlns="">0000</codigoError>
		    <codigoErrorRemoto xmlns="">0000</codigoErrorRemoto>
		    <mensajeUsuario xmlns="">TRANSACCION EXITOSA</mensajeUsuario>
		</xsl:when>
		<xsl:otherwise>
			<codigoError xmlns=""><xsl:value-of select="/RegistrarPagoBancoSalida/codigoError"/></codigoError>
		    <codigoErrorRemoto xmlns=""><xsl:value-of select="/RegistrarPagoBancoSalida/codigoError"/></codigoErrorRemoto>
		    <mensajeUsuario xmlns=""><xsl:value-of select="/RegistrarPagoBancoSalida/mensajeError"/></mensajeUsuario>		
		</xsl:otherwise>	
	</xsl:choose>	
</mc:MensajeSalidaReversar>    
  </xsl:template>
</xsl:stylesheet>