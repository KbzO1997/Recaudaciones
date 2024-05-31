<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:java="java"
 xmlns:men="http://www.bolivariano.com/mensaje/MensajeOTC"
 exclude-result-prefixes="men java">
	<xsl:template match="/">
		<CTSMessage>
			<CTSHeader> 
				<Field name="srv" type="S"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/></Field>
				<Field name="ofi" type="N"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ofi"]/valor'/></Field>
				<Field name="trn" type="N">62320</Field>
				<Field name="serviceName" type="S">cob_procesador..fp_consulta_ecutel</Field>
				<Field name="date" type="D"><xsl:value-of select='java:format(java:text.SimpleDateFormat.new("MM/dd/yyyy"), java:util.Date.new())'/></Field>
				<Field name="term" type="S"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/></Field>
				<Field name="ssnLog" type="S"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="rol" type="N"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/></Field>
				<Field name="ssn" type="N"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="ssn_branch " type="N"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="user" type="S"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_user"]/valor'/></Field>
				<Field name="lsrv" type="S"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_lsrv"]/valor'/></Field>			
			</CTSHeader>
			<Data>
				<ProcedureRequest>
					<SpName>cob_procesador..fp_consulta_ecutel</SpName>
					<Param name="@t_trn" type="56" io="0" len="4">62320</Param>
			        <xsl:choose>
			         <xsl:when test="/men:entradaConsultarDeuda/men:servicio/codigoTipoIdentificador = 'CED'">
			           <Param name="@i_ptipo_doc" type="39" io="0" len="3">002</Param>
			         </xsl:when>
			         <xsl:when test="/men:entradaConsultarDeuda/men:servicio/codigoTipoIdentificador = 'RUC'">
			           <Param name="@i_ptipo_doc" type="39" io="0" len="3">008</Param>
			         </xsl:when>
			         <xsl:otherwise>
			           <Param name="@i_ptipo_doc" type="39" io="0" len="3">007</Param>
			         </xsl:otherwise>
			       </xsl:choose>
					
					<Param name="@i_pcodigo" type="39" io="0" len="10"><xsl:value-of select="/men:entradaConsultarDeuda/men:servicio/identificador"/></Param>
					<Param name="@i_pid_banco" type="39" io="0" len="3">003</Param>
					<Param name="@i_pcanal" type="39" io="0" len="4">BVIR</Param>
					<Param name="@o_pnombre" type="39" io="1" len="80">********************************************************************************</Param>
					<Param name="@o_pvalor" type="39" io="1" len="80">********************************************************************************</Param>
					<Param name="@o_pfecha_pago" type="39" io="1" len="80">********************************************************************************</Param>
					<Param name="@o_pid_respuesta" type="39" io="1" len="80">********************************************************************************</Param>
					<Param name="@o_msg" type="39" io="1" len="80">********************************************************************************</Param>
					

					<Param name="@i_ubi" type="56" io="0" len="4">0</Param>
					<Param name="@s_user" type="39" io="0" len="7"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_user"]/valor'/></Param>
					<Param name="@s_srv" type="39" io="0" len="8"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_srv"]/valor'/></Param>
					<Param name="@s_rol" type="56" io="0" len="4"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_rol"]/valor'/></Param>
					<Param name="@s_ofi" type="56" io="0" len="4"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ofi"]/valor'/></Param>
					<Param name="@s_term" type="39" io="0" len="10"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_term"]/valor'/></Param>
					<Param name="@s_ssn" type="56" io="0" len="4"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/></Param>
					<Param name="@s_ssn_branch" type="56" io="0" len="4"><xsl:value-of select='/men:entradaConsultarDeuda/men:servicio/datosAdicionales/datoAdicional[codigo = "s_ssn"]/valor'/></Param>
				</ProcedureRequest>
			</Data>
		</CTSMessage>
	</xsl:template>
</xsl:stylesheet>