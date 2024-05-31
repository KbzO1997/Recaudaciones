package com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector;


import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


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
 *         &lt;element name="coding" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="mensaje" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="estado" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="fechaEjecucion" type="{http://www.w3.org/2001/XMLSchema}dateTime"/&gt;
 *         &lt;element name="correlacion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
@XmlType(name = "", propOrder = { "coding", "mensaje", "estado", "fechaEjecucion", "correlacion", "datos" })
@XmlRootElement(name = "mensajeSalidaCollector")
public class MensajeSalidaCollector {

    @XmlElement(required = true)
    protected String coding;
    @XmlElement(required = true)
    protected String mensaje;
    @XmlElement(required = true)
    protected String estado;
    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar fechaEjecucion;
    @XmlElement(required = true)
    protected String correlacion;
    protected /*MensajeSalidaCollector.*/Datos datos;

    /**
     * Gets the value of the coding property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCoding() {
        return coding;
    }

    /**
     * Sets the value of the coding property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCoding(String value) {
        this.coding = value;
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

    /**
     * Gets the value of the estado property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getEstado() {
        return estado;
    }

    /**
     * Sets the value of the estado property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setEstado(String value) {
        this.estado = value;
    }

    /**
     * Gets the value of the fechaEjecucion property.
     *
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public XMLGregorianCalendar getFechaEjecucion() {
        return fechaEjecucion;
    }

    /**
     * Sets the value of the fechaEjecucion property.
     *
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public void setFechaEjecucion(XMLGregorianCalendar value) {
        this.fechaEjecucion = value;
    }

    /**
     * Gets the value of the correlacion property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCorrelacion() {
        return correlacion;
    }

    /**
     * Sets the value of the correlacion property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCorrelacion(String value) {
        this.correlacion = value;
    }

    /**
     * Gets the value of the datos property.
     *
     * @return
     *     possible object is
     *     {@link MensajeSalidaCollector.Datos }
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
     *     {@link MensajeSalidaCollector.Datos }
     *
     */
    public void setDatos(Datos value) {
        this.datos = value;
    }

}