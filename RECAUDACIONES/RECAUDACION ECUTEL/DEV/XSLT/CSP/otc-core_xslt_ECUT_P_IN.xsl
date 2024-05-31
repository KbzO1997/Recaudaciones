<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:java="java"
 xmlns:men="http://www.bolivariano.com/mensaje/MensajeOTC"
 exclude-result-prefixes="java men">
	<xsl:template match="/">
		<CTSMessage>
			<CTSHeader>				
				<Field name="srv" type="S"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_srv"]/valor'/></Field>
				<Field name="ofi" type="N"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ofi"]/valor'/></Field>
				<Field name="trn" type="N">62322</Field>
				<Field name="serviceName" type="S">cob_procesador..fp_pago_ecutel</Field>
				<Field name="date" type="D"><xsl:value-of select='java:format(java:text.SimpleDateFormat.new("MM/dd/yyyy"), java:util.Date.new())'/></Field>
				<Field name="term" type="S"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_term"]/valor'/></Field>
				<Field name="ssnLog" type="S"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="rol" type="N"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_rol"]/valor'/></Field>
				<Field name="ssn" type="N"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="ssn_branch " type="N"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ssn"]/valor'/></Field>
				<Field name="user" type="S"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_user"]/valor'/></Field>
				<Field name="lsrv" type="S"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_lsrv"]/valor'/></Field>
			</CTSHeader>
			<Data>
				<ProcedureRequest>
					<SpName>cob_procesador..fp_pago_ecutel</SpName>
					<Param name="@s_user" type="47" io="0" len="6">
						<xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_user"]/valor'/>
					</Param>
					<Param name="@t_corr" type="47" io="0" len="1">N</Param>
					<Param name="@t_trn" type="56" io="0" len="4">62322</Param>
					<Param name="@i_mon" type="48" io="0" len="1">
						<xsl:value-of select="/men:entradaEjecutarPago/men:moneda"/>
					</Param>
					<Param name="@i_servicio" type="47" io="0" len="1">5</Param>
					<Param name="@i_empresa" type="47" io="0" len="4">8521</Param>
					<Param name="@i_servname" type="47" io="0" len="17">CLARO SERVICIOS FIJOS</Param>
					<Param name="@i_empname" type="47" io="0" len="21">CLARO SERVICIOS FIJOS</Param>
					<Param name="@i_efectivo" type="56" io="0" len="4">0</Param>
					<Param name="@i_cheque" type="56" io="0" len="4">0</Param>
					<Param name="@i_debito" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago"/>
					</Param>
					<Param name="@i_subtotal" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago"/>
					</Param>
					<Param name="@i_comision_tot" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorComision"/>
					</Param>
					<Param name="@i_comision_db" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorComision"/>
					</Param>
					<Param name="@i_comision_efe" type="56" io="0" len="4">0</Param>
					<Param name="@i_comision_chq" type="56" io="0" len="4">0</Param>
					<Param name="@i_total" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago"/>
					</Param>
					<Param name="@i_totval" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago"/>
					</Param>
					<Param name="@i_totapag" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago + /men:entradaEjecutarPago/men:valorComision"/>
					</Param>
					<Param name="@i_cant_cheques" type="56" io="0" len="4">0</Param>
					<Param name="@i_tipo_cta" type="47" io="0" len="3">
						<xsl:value-of select="/men:entradaEjecutarPago/men:tipoCuenta"/>
					</Param>
					<Param name="@i_cuenta" type="47" io="0" len="10">
						<xsl:value-of select="/men:entradaEjecutarPago/men:cuenta"/>
					</Param>
					<Param name="@i_nombre_cta" type="47" io="0" len="32">
						<xsl:value-of select="/men:entradaEjecutarPago/men:nombreCliente"/>
					</Param>
					<Param name="@i_autoriza" type="47" io="0" len="1">0</Param>
					<Param name="@i_canal" type="47" io="0" len="3">
						<xsl:value-of select="/men:entradaEjecutarPago/men:canal"/>
					</Param>
					<Param name="@i_cod_cliente" type="47" io="0" len="10">
						<xsl:value-of select="/men:entradaEjecutarPago/men:servicio/identificador"/>
					</Param>
					<Param name="@i_ruc_cliente type=39" io="0" len="0"/>
					<Param name="@i_nombre_cliente" type="47" io="0" len="30">
						<xsl:value-of select="/men:entradaEjecutarPago/men:nombreCliente"/>
					</Param>
					
			        <xsl:choose>
			         <xsl:when test="/men:entradaEjecutarPago/men:servicio/codigoTipoIdentificador = 'CED'">
			           <Param name="@i_ptipo_doc" type="47" io="0" len="5">002</Param>
			         </xsl:when>
			         <xsl:when test="/men:entradaEjecutarPago/men:servicio/codigoTipoIdentificador = 'RUC'">
			           <Param name="@i_ptipo_doc" type="47" io="0" len="5">008</Param>
			         </xsl:when>
			         <xsl:otherwise>
			           <Param name="@i_ptipo_doc" type="47" io="0" len="5">007</Param>
			         </xsl:otherwise>
			       </xsl:choose>
					<Param name="@i_pcodigo" type="47" io="0" len="10">
						<xsl:value-of select="/men:entradaEjecutarPago/men:servicio/identificador"/>
					</Param>
					<Param name="@i_pvalor" type="60" io="0" len="8">
						<xsl:value-of select="/men:entradaEjecutarPago/men:valorPago"/>
					</Param>
					<Param name="@i_pfpago" type="47" io="0" len="3">001</Param>
					<Param name="@i_pid_banco" type="47" io="0" len="3">003</Param>
					<Param name="@i_pcanal" type="47" io="0" len="4">BVIR</Param>
					
					<!-- TODO sacar fecha -->
					<Param name="@i_pfecha_cont" type="47" io="0" len="8">
						<xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_date"]/valor'/>
					</Param>	
					<Param name="@i_pfecha_trx" type="47" io="0" len="17">
						<xsl:value-of select='java:format(java:text.SimpleDateFormat.new("yyyyMMdd HH:mm:ss"), java:util.Date.new())'/>
					</Param>
					
					<Param name="@i_psec_banco" type="56" io="0" len="4"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ssn"]/valor'/></Param>
					<Param name="@s_ssn" type="56" io="0" len="4"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ssn"]/valor'/></Param>
					
					<Param name="@o_fecha_contable" type="47" io="1" len="10">XXXXXXXXXX</Param>
					<Param name="@o_ssn" type="56" io="1" len="4">0</Param>
					<Param name="@o_autorisri" type="47" io="1" len="30">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</Param>
					<Param name="@o_fecvensri" type="47" io="1" len="30">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</Param>
					<Param name="@o_nota_venta" type="47" io="1" len="20">xxxxxxxxxxxxxxxxxxxx</Param>
					<Param name="@o_fact_elect" type="47" io="1" len="1">x</Param>
					<Param name="@o_cod_respuesta" type="47" io="1" len="10">xxxxxxxxxx</Param>
					<Param name="@o_mensaje_respuesta" type="47" io="1" len="32">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</Param>
					<Param name="@o_fec_ini_vig_aut" type="47" io="1" len="1">x</Param>
					<Param name="@o_fec_fin_vig_aut" type="47" io="1" len="1">x</Param>
					<Param name="@o_fecdessri" type="47" io="1" len="50">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx</Param>
					<Param name="@o_horario" type="47" io="1" len="1">x</Param>
					<Param name="@o_pid_pago" type="47" io="1" len="1"/>
					
					<!--   TODO enriquecer  parámetros cobis -->					
					<Param name="@s_term" type="47" io="0" len="5"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_term"]/valor'/></Param>
					<Param name="@s_ofi" type="52" io="0" len="2"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_ofi"]/valor'/></Param>
					<Param name="@i_ubi" type="56" io="0" len="4"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "i_ubi"]/valor'/></Param>
					<Param name="@s_rol" type="52" io="0" len="2"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_rol"]/valor'/></Param>
					<Param name="@s_srv" type="47" io="0" len="10"><xsl:value-of select='/men:entradaEjecutarPago/men:datosAdicionales/men:datoAdicional[codigo = "s_srv"]/valor'/></Param>
				</ProcedureRequest>
			</Data>
		</CTSMessage>
	</xsl:template>
</xsl:stylesheet>