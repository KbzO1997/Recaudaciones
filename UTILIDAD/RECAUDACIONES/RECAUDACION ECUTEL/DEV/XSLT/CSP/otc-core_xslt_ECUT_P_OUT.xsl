<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:java="java"
 xmlns:men="http://www.bolivariano.com/mensaje/MensajeOTC"
 exclude-result-prefixes="java">
	<xsl:template match="/">
	
	    <men:salidaEjecutarPago>
	      <men:codigoError>
	        <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/return/text()"/>
	      </men:codigoError>
	      
	      <xsl:choose>
	      	<xsl:when test="/CTSMessage/Data/ProcedureResponse/ResultSet[1]/rw[3]/cd[2]/text()">
				<men:mensajeUsuario>
					<xsl:value-of select="/CTSMessage/Data/ProcedureResponse/ResultSet[1]/rw[3]/cd[2]/text()"/>
				</men:mensajeUsuario>	      	
	      	</xsl:when>
	      	<xsl:when test="/CTSMessage/Data/ProcedureResponse/Message/text()">
	      		<men:mensajeUsuario>
					<xsl:value-of select="/CTSMessage/Data/ProcedureResponse/Message/text()"/>
				</men:mensajeUsuario>	
	      	</xsl:when>	
	      	<xsl:otherwise>
	      		<men:mensajeUsuario>Error de infraestructura</men:mensajeUsuario>	
	      	</xsl:otherwise>    
	      </xsl:choose>
	      
          	<xsl:variable name="fechaContable" select="/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_fecha_contable']"></xsl:variable>	  
		    <men:fechaPago>
	          <xsl:value-of select="concat(substring($fechaContable,7,4),'-',substring($fechaContable,1,2),'-',substring($fechaContable,4,2),'T00:00:00')"/>
	        </men:fechaPago>
	        <men:fechaDebito>
	          <xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyy-MM-dd&apos;T&apos;HH:mm:ss.SSS"), java:util.Date.new())'/>
	        </men:fechaDebito>
	        <men:referencia>
	          <xsl:value-of select="/CTSMessage/Data/ProcedureResponse/OutputParams/param[@name='@o_ssn']"/>
	        </men:referencia>
	      
	    </men:salidaEjecutarPago>		
		
	</xsl:template>
</xsl:stylesheet>