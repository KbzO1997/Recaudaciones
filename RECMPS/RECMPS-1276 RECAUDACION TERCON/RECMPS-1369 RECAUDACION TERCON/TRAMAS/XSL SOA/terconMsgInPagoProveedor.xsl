<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:men="http://www.bolivariano.com/CashManagement/MensajesDepositoenLinea" 
xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
exclude-result-prefixes="men">
    <xsl:template match="/">
    
        <bol:RegistrarPagoBancoEntrada xmlns:bol="http://54.86.239.96:8001/BankWS/BolivarianoWS/">
            <tipoProceso>1</tipoProceso>
            <tipoIdentificacion>
                <xsl:value-of select="men:MensajeEntradaPagar/tipoIdentificacion" />
            </tipoIdentificacion>
            <identificacion>
                <xsl:value-of select="men:MensajeEntradaPagar/identificacion" />
            </identificacion>
            <referencia></referencia>
            <monedaPago>USD</monedaPago>
            <valorPago>
                <xsl:value-of select="men:MensajeEntradaPagar/pago/valorPagoTotal" />
            </valorPago>
            <secuencialPago>
                <xsl:value-of select="men:MensajeEntradaPagar/secuencial" />
            </secuencialPago>
             <fechaPago>
                <xsl:value-of select="xp20:format-dateTime(xp20:current-dateTime(),'[Y0001]-[M01]-[D01]')" />
            </fechaPago>
            <horaPago>
                <xsl:value-of select="xp20:format-dateTime(xp20:current-dateTime(),'[H01]:[m01]:[s01]')" />
            </horaPago>
            <canalProceso>
                <xsl:if test="men:MensajeEntradaPagar/canal='VEN'">VENBCO</xsl:if> 
                <xsl:if test="men:MensajeEntradaPagar/canal='IBK' or men:MensajeEntradaPagar/canal='IBK'">WEBBCO</xsl:if> 
                <xsl:if test="men:MensajeEntradaPagar/canal='ATM'">ATMBCO</xsl:if> 
                <xsl:if test="men:MensajeEntradaPagar/canal='CNB'">CNBBCO</xsl:if>
                <xsl:if test="men:MensajeEntradaPagar/canal='WAP'">MOVBCO</xsl:if>                    
            </canalProceso>
            <codigoBanco>BOL</codigoBanco>
            <formaPago>
                <xsl:value-of select="men:MensajeEntradaPagar/formaPago" />
           </formaPago>
        </bol:RegistrarPagoBancoEntrada>
    </xsl:template>
</xsl:stylesheet>