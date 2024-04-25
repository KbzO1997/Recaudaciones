<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  exclude-result-prefixes="men ns0"
xmlns:bol="http://54.86.239.96:8001/BankWS/BolivarianoWS/">
    <xsl:template match="/">
        <mc:MensajeSalidaPagar xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea">
            <xsl:choose>
                <xsl:when test="/RegistrarPagoBancoSalida/codigoError='0000'">
                    <codigoError xmlns="">0000</codigoError>
                    <codigoErrorRemoto xmlns="">0000</codigoErrorRemoto>
                    <mensajeError xmlns="">TRANSACCION EXITOSA</mensajeError>
                </xsl:when>
                <xsl:otherwise>
                    <codigoError xmlns="">
                        <xsl:value-of select="/RegistrarPagoBancoSalida/codigoError" />
                    </codigoError>
                    <codigoErrorRemoto xmlns="">
                        <xsl:value-of select="/RegistrarPagoBancoSalida/codigoError" />
                    </codigoErrorRemoto>
                    <mensajeError xmlns="">
                        <xsl:value-of select="/RegistrarPagoBancoSalida/mensajeError" />
                    </mensajeError>
                </xsl:otherwise>
            </xsl:choose>
        </mc:MensajeSalidaPagar>
    </xsl:template>
</xsl:stylesheet>