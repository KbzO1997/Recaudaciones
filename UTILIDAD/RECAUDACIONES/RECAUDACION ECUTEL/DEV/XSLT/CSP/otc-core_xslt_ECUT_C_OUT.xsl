<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:men="http://www.bolivariano.com/mensaje/MensajeOTC"
                exclude-result-prefixes="java">
  <xsl:template match="/">
    <men:salidaConsultarDeuda>
      <men:codigoError>
        <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/return/text()"/>
      </men:codigoError>
      <men:formaPago>
        <xsl:text disable-output-escaping="no">ABONO</xsl:text>
      </men:formaPago>
      <men:mensajeUsuario>
        <!-- <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_msg']/text()"/>-->
        <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/Message/text()"/>
      </men:mensajeUsuario>
      <xsl:choose>
        <xsl:when test="/CTSMessage/Data/ProcedureResponse/return = '0'">
          <men:limiteMontoMaximo>
            <xsl:value-of select="(/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_pvalor']/text()) * (2.0)"/>
          </men:limiteMontoMaximo>
          <men:montoTotal>
            <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_pvalor']/text()"/>
          </men:montoTotal>
          <men:nombreCliente>
            <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_pnombre']/text()"/>
          </men:nombreCliente>
        </xsl:when>
        <xsl:otherwise>
          <men:montoTotal>0</men:montoTotal>
          <men:nombreCliente></men:nombreCliente>
        </xsl:otherwise>
      </xsl:choose>
    </men:salidaConsultarDeuda>
  </xsl:template>
</xsl:stylesheet>