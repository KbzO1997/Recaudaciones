<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ns2="http://54.86.239.96:8001/BankWS/BolivarianoWS/" exclude-result-prefixes="men ns0">
  <xsl:template match="/">

   
<mc:MensajeSalidaConsultar xmlns:mc="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea">
      <xsl:choose>
        <xsl:when test="/CargarDatosSalida/codigoError='0000'">
    		<codigoError xmlns="">0000</codigoError>
		    <codigoErrorRemoto xmlns="">0000</codigoErrorRemoto>
	        <mensajeUsuario xmlns="">TRANSACCION EXITOSA</mensajeUsuario>                 
                 <informacionDeposito>
                 <identificacion>
                  <xsl:value-of select="/CargarDatosSalida/identificacion"/>
                 </identificacion>		        
                   <nombreCliente>
                      <xsl:value-of select="/CargarDatosSalida/nombreCliente"/>
                    </nombreCliente>
                    <numeroDocumento>
                      <xsl:value-of select="/CargarDatosSalida/identificacion"/>
                    </numeroDocumento>                 
                    <deuda>
                      <xsl:value-of select="/CargarDatosSalida/deuda"/>
                    </deuda>                   
                  </informacionDeposito> 
		</xsl:when>
        <xsl:otherwise>
			<codigoError xmlns="">
            <xsl:value-of select="/CargarDatosSalida/codigoError"/>
          </codigoError>
		    <codigoErrorRemoto xmlns="">
            <xsl:value-of select="/CargarDatosSalida/codigoError"/>
          </codigoErrorRemoto>
		    <mensajeUsuario xmlns="">
            <xsl:value-of select="/CargarDatosSalida/mensajeError"/>
          </mensajeUsuario>				    
		</xsl:otherwise>
      </xsl:choose>
    </mc:MensajeSalidaConsultar>
    
  </xsl:template>
</xsl:stylesheet>