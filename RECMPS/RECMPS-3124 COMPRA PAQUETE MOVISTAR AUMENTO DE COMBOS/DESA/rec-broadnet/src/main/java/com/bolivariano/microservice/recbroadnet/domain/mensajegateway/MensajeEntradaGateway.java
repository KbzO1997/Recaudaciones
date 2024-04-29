package com.bolivariano.microservice.recbroadnet.domain.mensajegateway;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for anonymous complex type.
 *
 * <p>The following schema fragment specifies the expected content contained within this class.
 *
 * <pre>
 * &lt;complexType&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="puntoFinal" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="operacion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="identificadorCorrelacion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="mensaje" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 *
 *
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "puntoFinal", "operacion", "identificadorCorrelacion",  "mensaje" })
@XmlRootElement(name = "mensajeEntradaGateway")
public class MensajeEntradaGateway {

    @XmlElement(required = true)
    protected String puntoFinal;
    @XmlElement(required = true)
    protected String operacion;
    @XmlElement(required = true)
    protected String identificadorCorrelacion;
    @XmlElement(required = true)
    protected String mensaje;

    /**
     * Gets the value of the puntoFinal property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getPuntoFinal() {
        return puntoFinal;
    }

    /**
     * Sets the value of the puntoFinal property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setPuntoFinal(String value) {
        this.puntoFinal = value;
    }

    /**
     * Gets the value of the operacion property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getOperacion() {
        return operacion;
    }

    /**
     * Sets the value of the operacion property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setOperacion(String value) {
        this.operacion = value;
    }
    /**
     * Gets the value of the identificadorCorrelacion property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getIdentificadorCorrelacion() {
        return identificadorCorrelacion;
    }
    /**
     * Sets the value of the identificadorCorrelacion property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setIdentificadorCorrelacion(String value) {
        this.identificadorCorrelacion = value;
    }

    /**
     * Gets the value of the mensaje property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */

    public String getMensaje() {
        return mensaje;
    }

    /**
     * Sets the value of the mensaje property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setMensaje(String value) {
        this.mensaje = value;
    }

}
