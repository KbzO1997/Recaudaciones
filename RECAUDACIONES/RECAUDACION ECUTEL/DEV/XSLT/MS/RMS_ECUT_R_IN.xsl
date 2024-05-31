<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable" xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions" xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/" xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue" xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath" xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath" xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap" xmlns:med="http://schemas.oracle.com/mediator/xpath" xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:ns0="http://www.bolivariano.com/dominio/TipoIdentificador" xmlns:ns1="http://www.bolivariano.com/dominio/ns6:datoAdicional" xmlns:ns10="http://www.bolivariano.com/dominio/RegionalArea" xmlns:ns11="http://www.bolivariano.com/ws/BroadnetRecarga" xmlns:ns12="http://www.bolivariano.com/MensajeBolivariano" xmlns:ns13="http://www.bolivariano.com/CoreBB" xmlns:ns14="http://www.bolivariano.com/Producto" xmlns:ns15="http://www.bolivariano.com/Cuenta" xmlns:ns16="http://www.bolivariano.com/Recaudo" xmlns:ns17="http://www.bolivariano.com/Cliente" xmlns:ns18="http://www.bolivariano.com/Broadnet" xmlns:ns19="movr:Movistar/types" xmlns:ns2="http://www.bolivariano.com/dominio/Servicio" xmlns:ns3="http://www.bolivariano.com/dominio/Convenio" xmlns:ns4="http://www.bolivariano.com/dominio/Empresa" xmlns:ns5="http://www.bolivariano.com/dominio/Recibo" xmlns:ns6="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:ns7="http://www.bolivariano.com/dominio/TipoMatriculacion" xmlns:ns8="http://www.bolivariano.com/dominio/FormaPago" xmlns:ns9="http://www.bolivariano.com/dominio/ListaSeleccion" xmlns:ora="http://schemas.oracle.com/xpath/extension" xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator" xmlns:tns="http://www.bolivariano.com/ws/OTCService" xmlns:wbcm="http://www.bolivariano.com/mensaje/MensajeOTC" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk" xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20" xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" exclude-result-prefixes="xsi xsl ns1 soap wsdl ns3 ns5 ns10 ns9 ns2 ns7 ns8 ns0 tns xsd ns4 ns6 soap12 ns13 ns15 mime ns19 ns12 ns16 ns14 ns17 ns18 wbcm bpws xp20 bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap">
	<xsl:template match="/">
		<ns2:entradaEjecutarReverso xmlns:ns2="http://www.bolivariano.com/mensaje/MensajeOTC">
			<xsl:variable name="fecha" select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_date"]/valor' />

			<ns2:canal>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:canal" />
			</ns2:canal>
			<ns2:tipoCuenta>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:tipoCuenta" />
			</ns2:tipoCuenta>
			<ns2:cuenta>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:cuenta" />
			</ns2:cuenta>
			<ns2:secuencial>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_ssn&quot;]/valor" />
			</ns2:secuencial>
			<ns2:valorPago>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago" />
			</ns2:valorPago>
			<ns2:valorComision>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision" />
			</ns2:valorComision>
			<ns2:servicio>
				<codTipoServicio>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/codTipoServicio" />
				</codTipoServicio>
				<codigoConvenio>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/codigoEmpresa" />
				</codigoConvenio>
				<codigoEmpresa>
					<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:servicio/codigoConvenio' />
				</codigoEmpresa>
				<codigoTipoBanca>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/codigoTipoBanca" />
				</codigoTipoBanca>
				<codigoTipoIdentificador>
					<xsl:choose>
						<xsl:when test="/ns6:entradaEjecutarReverso/ns6:servicio/codigoTipoIdentificador = 'CED'">
						  <xsl:text disable-output-escaping="no">002</xsl:text>
						</xsl:when>
						<xsl:when test="/ns6:entradaEjecutarReverso/ns6:servicio/codigoTipoIdentificador = 'RUC'">
						  <xsl:text disable-output-escaping="no">008</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="no">007</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</codigoTipoIdentificador>
				<identificador>
					<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/identificador" />
				</identificador>
				<datosAdicionales>
					<datoAdicional>
						<codigo>e_prov_req</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">MS_REC_ECUTEL_REQ</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_prov_resp</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">MS_REC_ECUTEL_RESP</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_tipo_proceso</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">M</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_tipo_ejecucion</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">PB</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>p_medio</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">12</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>p_terminal</codigo>
						<valor>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_term&quot;]/valor" />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>p_medio</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">12</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>p_branch_id</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">1</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>p_forma_pago</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">1</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>codAgencia</codigo>
						<valor>					
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;codAgencia&quot;]/valor" />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>codLocalidad</codigo>
						<valor>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;vp_s_referencia2&quot;]/valor" />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>category</codigo>
						<valor>
							<xsl:text disable-output-escaping="no">C</xsl:text>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>documentType</codigo>
						<valor>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:servicio/codigoTipoIdentificador" />
						</valor>
					</datoAdicional>					
					<datoAdicional>
						<codigo>fullName</codigo>
						<valor>
							<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:nombreCliente" />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_srv</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_srv"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_term</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_term"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_rol</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_rol"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_corr</codigo>
						<valor>S</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_ssn_corr</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "t_ssn_corr"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_mon</codigo>
						<valor>1</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_servicio</codigo>
						<valor> 		
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:servicio/codigoEmpresa'/>
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_identificacion</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_identificacion"]/valor' />
						</valor>
					</datoAdicional>
					<xsl:choose>
						<xsl:when test="/ns6:entradaEjecutarReverso/ns6:tipoCuenta = 'CTE' or /ns6:entradaEjecutarReverso/ns6:tipoCuenta = 'AHO'">
							<datoAdicional>
								<codigo>e_debito</codigo>
								<valor>
									<xsl:choose>
										<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'VEN'">
										  <xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_debito"]/valor'/>
										</xsl:when>
										<xsl:otherwise>
										  <xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorPago"/>                          
										</xsl:otherwise>
									</xsl:choose>
								</valor>
							</datoAdicional>
							<datoAdicional>
								<codigo>e_comision_db</codigo>								
								<valor>
									<xsl:choose>
										<xsl:when test="/ns6:entradaEjecutarReverso/ns6:canal = 'VEN'">
										  <xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_comision_db"]/valor'/>
										</xsl:when>
										<xsl:otherwise>
										  <xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:valorComision"/>                          
										</xsl:otherwise>
									</xsl:choose>
								</valor>
							</datoAdicional>
						</xsl:when>						
					</xsl:choose>
					<datoAdicional>
						<codigo>e_efectivo</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_efectivo"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_comision_efe</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_comision_efe"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cheque</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cheque"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_comision_chq</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_comision_chq"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_tarjeta</codigo>
						<valor>0</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_comision_efe</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_comision_efe"]/valor' />
						</valor>
					</datoAdicional>

					<datoAdicional>
						<codigo>e_autoriza</codigo>
						<valor>N</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_ubi</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "i_ubi"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_opcion</codigo>
						<valor>P</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_reverso</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_ssn_corr"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_emp_nombre</codigo>
						<valor></valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_ruc_cliente</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_ruc_cliente"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cant_cheques</codigo>
						<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cant_cheques"]/valor' />
					</datoAdicional>
					<datoAdicional>
						<codigo>e_nombre_cta</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_nombre_cta"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cod_referencia</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cod_referencia"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_base_imponible</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_base_imponible"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_factura</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_factura"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cod_respuesta</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cod_respuesta"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cod_grupo</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cod_grupo"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cod_grupo</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cod_grupo"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_nomb_tramite</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_nomb_tramite"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_pcodigo_operacion</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_pcodigo_operacion"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_pcodigo_secuencia</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_pcodigo_secuencia"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_phoralocal</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_phoralocal"]/valor' />
						</valor>
					</datoAdicional>
					<datoAdicional>
						<codigo>e_cod_consultora</codigo>
						<valor>
							<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "e_cod_consultora"]/valor' />
						</valor>
					</datoAdicional>
				</datosAdicionales>
			</ns2:servicio>
			<xsl:choose>
				<xsl:when test="$fecha">

					<ns2:fecha>
						<xsl:value-of select="substring($fecha, 1,19)" />
					</ns2:fecha>
					<ns2:fechaPago>
						<xsl:value-of select="substring($fecha, 1,19)" />
					</ns2:fechaPago>
				</xsl:when>
				<xsl:otherwise>
					<ns2:fecha>
						<xsl:value-of select="substring(/ns6:entradaEjecutarReverso/ns6:fecha, 1,19)" />
					</ns2:fecha>
					<ns2:fechaPago>
						<xsl:value-of select="substring(/ns6:entradaEjecutarReverso/ns6:fechaPago, 1,19)" />
					</ns2:fechaPago>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:variable name="moneda" select='/ns6:entradaEjecutarReverso/ns6:moneda' />
			<xsl:choose>
				<xsl:when test="$moneda">
					<ns2:moneda>
						<xsl:value-of select="$moneda" />
					</ns2:moneda>
				</xsl:when>
				<xsl:otherwise>
					<ns2:moneda>1</ns2:moneda>
				</xsl:otherwise>
			</xsl:choose>
			<ns2:oficina>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:oficina" />
			</ns2:oficina>
			<ns2:terminal>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = &quot;s_term&quot;]/valor" />
			</ns2:terminal>
			<ns2:transaccion>
				<xsl:value-of select="/ns6:entradaEjecutarReverso/ns6:transaccion" />
			</ns2:transaccion>
			<ns2:usuario>
				<xsl:value-of select='/ns6:entradaEjecutarReverso/ns6:datosAdicionales/ns6:datoAdicional[codigo = "s_user"]/valor' />
			</ns2:usuario>
		</ns2:entradaEjecutarReverso>
	</xsl:template>
</xsl:stylesheet>