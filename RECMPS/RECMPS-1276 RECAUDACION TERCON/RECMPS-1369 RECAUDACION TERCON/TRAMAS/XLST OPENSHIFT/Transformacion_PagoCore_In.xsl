<?xml version = '1.0' encoding = 'UTF-8'?>
<xsl:stylesheet version="1.0" xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20" xmlns:bpws="http://schemas.xmlsoap.org/ws/2003/03/business-process/" xmlns:ns0="http://www.bolivariano.com/FormaPago" xmlns:bpel="http://docs.oasis-open.org/wsbpel/2.0/process/executable" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns4="http://www.bolivariano.com/Enumerados" xmlns:ns1="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea" xmlns:bpm="http://xmlns.oracle.com/bpmn20/extensions" xmlns:tns="http://xmlns.oracle.com/pcbpel/adapter/db/DepositoEnLinea/DepositoEnLinea/CanalesNoCobis" xmlns:ns11="http://xmlns.oracle.com/pcbpel/adapter/db/DepositoEnLinea/DepositoEnLinea/pa_reca_tpago_dep_linea" xmlns:plt="http://schemas.xmlsoap.org/ws/2003/05/partner-link/" xmlns:ns3="http://www.bolivariano.com/CoreBB" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ora="http://schemas.oracle.com/xpath/extension" xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator" xmlns:client="http://xmlns.oracle.com/DepositoEnLinea/DepositoEnLinea/PagarDep" xmlns:ns2="http://www.bolivariano.com/MensajeBolivariano" xmlns:db="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CanalesNoCobis" xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction" xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc" xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue" xmlns:ns9="http://xmlns.oracle.com/pcbpel/adapter/db/DepositoEnLinea/DepositoEnLinea/sp_val_servicios_varios" xmlns:hwf="http://xmlns.oracle.com/bpel/workflow/xpath" xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype" xmlns:ns5="http://www.bolivariano.com/CashManagement/DepositoEnLinea" xmlns:med="http://schemas.oracle.com/mediator/xpath" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ids="http://xmlns.oracle.com/bpel/services/IdentityService/xpath" xmlns:ns8="http://xmlns.oracle.com/pcbpel/adapter/db/sp/sp_val_servicios_varios" xmlns:ns7="http://www.bolivariano.com/Restricciones" xmlns:xdk="http://schemas.oracle.com/bpel/extension/xpath/function/xdk" xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions" xmlns:ns10="http://xmlns.oracle.com/pcbpel/adapter/db/sp/pa_reca_tpago_dep_linea" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns12="http://schemas.oracle.com/bpel/extension" xmlns:ns6="http://www.bolivariano.com/Comision" xmlns:ldap="http://schemas.oracle.com/xpath/extension/ldap" exclude-result-prefixes="xsi xsl ns0 ns4 ns1 tns plt ns3 wsdl client ns2 db ns9 plnk ns5 ns8 ns7 xsd ns12 ns6 ns11 ns10 xp20 bpws bpel bpm ora socket mhdr oraext dvm hwf med ids xdk xref ldap" xmlns:oracle-xsl-mapper="http://www.oracle.com/xsl/mapper/schemas"
                xmlns:oraxsl="http://www.oracle.com/XSL/Transform/java">
  <oracle-xsl-mapper:schema>
      <!--SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY.-->
      <oracle-xsl-mapper:mapSources>
         <oracle-xsl-mapper:source type="WSDL">
            <oracle-xsl-mapper:schema location="../PagarDep.wsdl"/>
            <oracle-xsl-mapper:rootElement name="MensajeEntradaPagar" namespace="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"/>
         </oracle-xsl-mapper:source>
         <oracle-xsl-mapper:source type="WSDL">
            <oracle-xsl-mapper:schema location="../CanalesNoCobis.wsdl"/>
            <oracle-xsl-mapper:rootElement name="OutputParameters" namespace="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CanalesNoCobis"/>
            <oracle-xsl-mapper:param name="OutCanalesNoCobis.OutputParameters"/>
         </oracle-xsl-mapper:source>
         <oracle-xsl-mapper:source type="WSDL">
            <oracle-xsl-mapper:schema location="../sp_val_servicios_varios.wsdl"/>
            <oracle-xsl-mapper:rootElement name="OutputParameters" namespace="http://xmlns.oracle.com/pcbpel/adapter/db/sp/sp_val_servicios_varios"/>
            <oracle-xsl-mapper:param name="OutValidacionesPrevias.OutputParameters"/>
         </oracle-xsl-mapper:source>
         <oracle-xsl-mapper:source type="WSDL">
            <oracle-xsl-mapper:schema location="../PagarDep.wsdl"/>
            <oracle-xsl-mapper:rootElement name="MensajeSalidaPagar" namespace="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea"/>
            <oracle-xsl-mapper:param name="OutPagarProveedor.parametros"/>
         </oracle-xsl-mapper:source>
      </oracle-xsl-mapper:mapSources>
      <oracle-xsl-mapper:mapTargets>
         <oracle-xsl-mapper:target type="WSDL">
            <oracle-xsl-mapper:schema location="../pa_reca_tpago_dep_linea.wsdl"/>
            <oracle-xsl-mapper:rootElement name="InputParameters" namespace="http://xmlns.oracle.com/pcbpel/adapter/db/sp/pa_reca_tpago_dep_linea"/>
         </oracle-xsl-mapper:target>
      </oracle-xsl-mapper:mapTargets>
      <oracle-xsl-mapper:mapShowPrefixes type="true"/>
      <!--GENERATED BY ORACLE XSL MAPPER 12.2.1.4.0(XSLT Build 190828.0353.3300) AT [FRI NOV 27 16:53:29 COT 2020].-->
   </oracle-xsl-mapper:schema>
   <!--User Editing allowed BELOW this line - DO NOT DELETE THIS LINE-->
   <xsl:param name="OutCanalesNoCobis.OutputParameters"/>
  <xsl:param name="OutValidacionesPrevias.OutputParameters"/>
  <xsl:param name="OutPagarProveedor.parametros"/>
  <xsl:template match="/">
    <ns10:InputParameters>
      <xsl:if test="/ns1:MensajeEntradaPagar/secuencial">
        <ns10:s_ssn>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/secuencial"/>
        </ns10:s_ssn>
      </xsl:if>
      <xsl:if test="/ns1:MensajeEntradaPagar/servidorLocal">
        <ns10:s_lsrv>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/servidorLocal"/>
        </ns10:s_lsrv>
      </xsl:if>
      <xsl:if test="/ns1:MensajeEntradaPagar/servidor">
        <ns10:s_srv>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/servidor"/>
        </ns10:s_srv>
      </xsl:if>
      <ns10:s_user>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/usuario"/>
      </ns10:s_user>
      <xsl:if test="/ns1:MensajeEntradaPagar/terminal">
        <ns10:s_term>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/terminal"/>
        </ns10:s_term>
      </xsl:if>
      <xsl:if test="/ns1:MensajeEntradaPagar/fecha">
        <ns10:s_date>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/fecha"/>
        </ns10:s_date>
      </xsl:if>
      <ns10:s_ofi>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/oficina"/>
      </ns10:s_ofi>
      <ns10:s_rol>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/rol"/>
      </ns10:s_rol>
      <xsl:if test="$OutCanalesNoCobis.OutputParameters/db:OutputParameters/db:s_sev">
        <ns10:s_sev>
          <xsl:value-of select="$OutCanalesNoCobis.OutputParameters/db:OutputParameters/db:s_sev"/>
        </ns10:s_sev>
      </xsl:if>
      <ns10:s_org>
        <xsl:text disable-output-escaping="no">L</xsl:text>
      </ns10:s_org>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/modoCorreccion">
          <ns10:t_corr>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/modoCorreccion"/>
          </ns10:t_corr>
        </xsl:when>
        <xsl:otherwise>
          <ns10:t_corr>
            <xsl:text disable-output-escaping="no">N</xsl:text>
          </ns10:t_corr>
        </xsl:otherwise>
      </xsl:choose>
      <ns10:t_ssn_corr>
        <xsl:text disable-output-escaping="no">0</xsl:text>
      </ns10:t_ssn_corr>
      <xsl:if test="/ns1:MensajeEntradaPagar/depuracion">
        <ns10:t_debug>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/depuracion"/>
        </ns10:t_debug>
      </xsl:if>
      <xsl:if test="/ns1:MensajeEntradaPagar/archivo">
        <ns10:t_file>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/archivo"/>
        </ns10:t_file>
      </xsl:if>
      <ns10:t_trn>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/transaccion"/>
      </ns10:t_trn>
      <ns10:e_mon>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/moneda"/>
      </ns10:e_mon>
      <ns10:e_empresa>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/codigoSubempresa"/>
      </ns10:e_empresa>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/aplicacionCobis">
          <ns10:e_aplcobis>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/aplicacionCobis"/>
          </ns10:e_aplcobis>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_aplcobis>
            <xsl:text disable-output-escaping="no">N</xsl:text>
          </ns10:e_aplcobis>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/efectivo/valor">
          <ns10:e_efectivo>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/efectivo/valor"/>
          </ns10:e_efectivo>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_efectivo>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_efectivo>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/cheque/valor">
          <ns10:e_cheque>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/cheque/valor"/>
          </ns10:e_cheque>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_cheque>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_cheque>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/debitoCuenta/valor">
          <ns10:e_debito>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/debitoCuenta/valor"/>
          </ns10:e_debito>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_debito>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_debito>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/tarjeta/valor">
          <ns10:e_tarjeta>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/tarjeta/valor"/>
          </ns10:e_tarjeta>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_tarjeta/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/valorComisionTotal">
          <ns10:e_comision_tot>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/valorComisionTotal"/>
          </ns10:e_comision_tot>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_comision_tot>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_comision_tot>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/efectivo/valorComision">
          <ns10:e_comision_efe>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/efectivo/valorComision"/>
          </ns10:e_comision_efe>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_comision_efe>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_comision_efe>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/cheque/valorComision">
          <ns10:e_comision_chq>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/cheque/valorComision"/>
          </ns10:e_comision_chq>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_comision_chq>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_comision_chq>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/debitoCuenta/valorComision">
          <ns10:e_comision_db>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/debitoCuenta/valorComision"/>
          </ns10:e_comision_db>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_comision_db>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_comision_db>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/valorPagoTotal">
          <ns10:e_total>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/valorPagoTotal"/>
          </ns10:e_total>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_total>
            <xsl:text disable-output-escaping="no">0.00</xsl:text>
          </ns10:e_total>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/pago/cheque/cantidadCheques">
          <ns10:e_cant_cheques>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/cheque/cantidadCheques"/>
          </ns10:e_cant_cheques>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_cant_cheques>
            <xsl:text disable-output-escaping="no">0</xsl:text>
          </ns10:e_cant_cheques>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="/ns1:MensajeEntradaPagar/pago/debitoCuenta/tipoCuenta">
        <ns10:e_tipo_cta>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/debitoCuenta/tipoCuenta"/>
        </ns10:e_tipo_cta>
      </xsl:if>
      <xsl:if test="/ns1:MensajeEntradaPagar/pago/debitoCuenta/cuenta">
        <ns10:e_cuenta>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/pago/debitoCuenta/cuenta"/>
        </ns10:e_cuenta>
      </xsl:if>
      <ns10:e_autoriza>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/modoProceso"/>
      </ns10:e_autoriza>
      <ns10:e_canal>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/canal"/>
      </ns10:e_canal>
      <ns10:e_tsn>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/tipoPago"/>
      </ns10:e_tsn>
      <xsl:choose>
        <xsl:when test="/ns1:MensajeEntradaPagar/ubicacion">
          <ns10:e_ubi>
            <xsl:value-of select="/ns1:MensajeEntradaPagar/ubicacion"/>
          </ns10:e_ubi>
        </xsl:when>
        <xsl:otherwise>
          <ns10:e_ubi>
            <xsl:text disable-output-escaping="no">0</xsl:text>
          </ns10:e_ubi>
        </xsl:otherwise>
      </xsl:choose>
      <ns10:e_cod_referencia>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/identificacion"/>
      </ns10:e_cod_referencia>
      <ns10:e_nombre_cliente>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/nombreCliente"/>
      </ns10:e_nombre_cliente>
      <!--KBastida ini Para Ingresar la Identificacion-->
      <ns10:e_ruc_cliente>      
        <xsl:if test="/ns1:MensajeEntradaPagar/codigoSubempresa='8459'">
          <xsl:value-of select="/ns1:MensajeEntradaPagar/referenciaDocumento"/>
        </xsl:if> 
      </ns10:e_ruc_cliente>
      <!--KBastida ini-->
      <ns10:e_cod_respuesta>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/numeroDocumento"/>
      </ns10:e_cod_respuesta>
      <ns10:e_ssn>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/secuencial"/>
      </ns10:e_ssn>
      <ns10:e_nomb_tramite>
        <xsl:value-of select="/ns1:MensajeEntradaPagar/referenciaDocumento"/>
      </ns10:e_nomb_tramite>
      <xsl:if test="/ns1:MensajeEntradaPagar/denominacion">
        <ns10:e_denominaciones>
          <xsl:value-of select="/ns1:MensajeEntradaPagar/denominacion"/>
        </ns10:e_denominaciones>
      </xsl:if>
    </ns10:InputParameters>
  </xsl:template>
</xsl:stylesheet>