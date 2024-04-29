package com.bolivariano.microservice.recbroadnet.domain.mensajeotc;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.xml.bind.annotation.*;
import javax.xml.datatype.XMLGregorianCalendar;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for mensajeSalidaEjecutarPago complex type.
 * <p>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;complexType name="mensajeSalidaEjecutarPago"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="banderaOffline" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="codigoError" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="datosAdicionales" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="datoAdicional" type="{http://www.bolivariano.com/dominio/DatoAdicional}datoAdicional" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="fechaDebito" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/&gt;
 *         &lt;element name="fechaPago" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="mensajeUsuario" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="mensajeSistema" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="montoTotal" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/&gt;
 *         &lt;element name="referencia" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "salidaEjecutarPago", propOrder = {
        "banderaOffline",
        "codigoError",
        "datosAdicionales",
        "fechaDebito",
        "fechaPago",
        "mensajeUsuario",
        "mensajeSistema",
        "montoTotal",
        "referencia"
})
@XmlRootElement(name = "salidaEjecutarPago")
public class MensajeSalidaEjecutarPago {

    protected Boolean banderaOffline;
    protected String codigoError;
    protected DatosAdicionales datosAdicionales;
    @XmlSchemaType(name = "dateTime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss",timezone = "America/Guayaquil")
    protected XMLGregorianCalendar fechaDebito;
    @XmlSchemaType(name = "dateTime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss",timezone = "America/Guayaquil")
    protected XMLGregorianCalendar fechaPago;
    protected String mensajeUsuario;
    protected String mensajeSistema;
    protected Double montoTotal;
    protected String referencia;

    /**
     * Gets the value of the banderaOffline property.
     *
     * @return possible object is
     * {@link Boolean }
     */
    public Boolean getBanderaOffline() {
        return banderaOffline;
    }

    /**
     * Sets the value of the banderaOffline property.
     *
     * @param value allowed object is
     *              {@link Boolean }
     */
    public void setBanderaOffline(Boolean value) {
        this.banderaOffline = value;
    }

    /**
     * Gets the value of the codigoError property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getCodigoError() {
        return codigoError;
    }

    /**
     * Sets the value of the codigoError property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setCodigoError(String value) {
        this.codigoError = value;
    }

    /**
     * Gets the value of the datosAdicionales property.
     *
     * @return possible object is
     * {@link DatosAdicionales }
     */
    public DatosAdicionales getDatosAdicionales() {
        return datosAdicionales;
    }

    /**
     * Sets the value of the datosAdicionales property.
     *
     * @param value allowed object is
     *              {@link DatosAdicionales }
     */
    public void setDatosAdicionales(DatosAdicionales value) {
        this.datosAdicionales = value;
    }

    /**
     * Gets the value of the fechaDebito property.
     *
     * @return possible object is
     * {@link XMLGregorianCalendar }
     */
    public XMLGregorianCalendar getFechaDebito() {
        return fechaDebito;
    }

    /**
     * Sets the value of the fechaDebito property.
     *
     * @param value allowed object is
     *              {@link XMLGregorianCalendar }
     */
    public void setFechaDebito(XMLGregorianCalendar value) {
        this.fechaDebito = value;
    }

    /**
     * Gets the value of the fechaPago property.
     *
     * @return possible object is
     * {@link XMLGregorianCalendar }
     */
    public XMLGregorianCalendar getFechaPago() {
        return fechaPago;
    }

    /**
     * Sets the value of the fechaPago property.
     *
     * @param value allowed object is
     *              {@link XMLGregorianCalendar }
     */
    public void setFechaPago(XMLGregorianCalendar value) {
        this.fechaPago = value;
    }

    /**
     * Gets the value of the mensajeUsuario property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getMensajeUsuario() {
        return mensajeUsuario;
    }

    /**
     * Sets the value of the mensajeUsuario property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setMensajeUsuario(String value) {
        this.mensajeUsuario = value;
    }

    /**
     * Gets the value of the mensajeSistema property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getMensajeSistema() {
        return mensajeSistema;
    }

    /**
     * Sets the value of the mensajeSistema property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setMensajeSistema(String value) {
        this.mensajeSistema = value;
    }

    /**
     * Gets the value of the montoTotal property.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getMontoTotal() {
        return montoTotal;
    }

    /**
     * Sets the value of the montoTotal property.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setMontoTotal(Double value) {
        this.montoTotal = value;
    }

    /**
     * Gets the value of the referencia property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getReferencia() {
        return referencia;
    }

    /**
     * Sets the value of the referencia property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setReferencia(String value) {
        this.referencia = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * <p>
     * <p>The following schema fragment specifies the expected content contained within this class.
     * <p>
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="datoAdicional" type="{http://www.bolivariano.com/dominio/DatoAdicional}datoAdicional" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
            "datoAdicional"
    })
    public static class DatosAdicionales {

        @XmlElement(nillable = true)
        protected List<DatoAdicional> datoAdicional;

        /**
         * Gets the value of the datoAdicional property.
         * <p>
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the datoAdicional property.
         * <p>
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getDatoAdicional().add(newItem);
         * </pre>
         * <p>
         * <p>
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link DatoAdicional }
         */
        public List<DatoAdicional> getDatoAdicional() {
            if (datoAdicional == null) {
                datoAdicional = new ArrayList<DatoAdicional>();
            }
            return this.datoAdicional;
        }

    }

    @Override
    public String toString() {
        return "MensajeSalidaEjecutarPago{" +
                "banderaOffline=" + banderaOffline +
                ", codigoError='" + codigoError + '\'' +
                ", datosAdicionales=" + datosAdicionales +
                ", fechaDebito=" + fechaDebito +
                ", fechaPago=" + fechaPago +
                ", mensajeUsuario='" + mensajeUsuario + '\'' +
                ", mensajeSistema='" + mensajeSistema + '\'' +
                ", montoTotal=" + montoTotal +
                ", referencia='" + referencia + '\'' +
                '}';
    }
}
