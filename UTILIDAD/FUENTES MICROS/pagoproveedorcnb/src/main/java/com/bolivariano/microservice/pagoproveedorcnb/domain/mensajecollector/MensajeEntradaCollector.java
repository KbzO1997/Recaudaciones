package com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector;


import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


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
 *         &lt;element name="opcion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="datos" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="dato" type="{http://www.bolivariano.com/mensaje/MensajeCollector}dato" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 *
 *
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "opcion", "datos" })
@XmlRootElement(name = "mensajeEntradaCollector")
public class MensajeEntradaCollector {

    @XmlElement(required = true)
    protected String opcion;
    protected /*MensajeEntradaCollector.*/Datos datos;

    /**
     * Gets the value of the opcion property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getOpcion() {
        return opcion;
    }

    /**
     * Sets the value of the opcion property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setOpcion(String value) {
        this.opcion = value;
    }

    /**
     * Gets the value of the datos property.
     *
     * @return
     *     possible object is
     *     {@link MensajeEntradaCollector.Datos }
     *
     */
    public Datos getDatos() {
        return datos;
    }

    /**
     * Sets the value of the datos property.
     *
     * @param value
     *     allowed object is
     *     {@link MensajeEntradaCollector.Datos }
     *
     */
    public void setDatos(Datos value) {
        this.datos = value;
    }



}