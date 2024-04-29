
package com.bolivariano.microservice.recbroadnet.domain.mensajeotc;


import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;
import com.bolivariano.microservice.recbroadnet.domain.recibo.Recibo;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.xml.bind.annotation.*;
import javax.xml.datatype.XMLGregorianCalendar;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for mensajeSalidaConsultarDeuda complex type.
 * <p>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;complexType name="mensajeSalidaConsultarDeuda"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
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
 *         &lt;element name="fechaVencimiento" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/&gt;
 *         &lt;element name="formaPago" type="{http://www.bolivariano.com/dominio/FormaPago}formaPago" minOccurs="0"/&gt;
 *         &lt;element name="formaPagoRecibos" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="identificadorDeuda" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="limiteMontoMaximo" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="limiteMontoMinimo" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="mensajeUsuario" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="mensajeSistema" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="montoMinimo" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="montoTotal" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="nombreCliente" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="recibos" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="recibo" type="{http://www.bolivariano.com/dominio/Recibo}recibo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="textoAyuda" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "salidaConsultarDeuda", propOrder = {
        "codigoError",
        "datosAdicionales",
        "fechaVencimiento",
        "formaPago",
        "formaPagoRecibos",
        "identificadorDeuda",
        "limiteMontoMaximo",
        "limiteMontoMinimo",
        "mensajeUsuario",
        "mensajeSistema",
        "montoMinimo",
        "montoTotal",
        "nombreCliente",
        "recibos",
        "textoAyuda"
})
@XmlRootElement(name = "salidaConsultarDeuda")
public class MensajeSalidaConsultarDeuda {

    protected String codigoError;
    protected DatosAdicionales datosAdicionales;
    @XmlSchemaType(name = "dateTime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss",timezone = "America/Guayaquil")
    protected XMLGregorianCalendar fechaVencimiento;
    protected String formaPago;
    protected String formaPagoRecibos;
    protected String identificadorDeuda;
    protected Double limiteMontoMaximo;
    protected Double limiteMontoMinimo;
    protected String mensajeUsuario;
    protected String mensajeSistema;
    protected Double montoMinimo;
    protected Double montoTotal;
    protected String nombreCliente;
    protected Recibos recibos;
    protected String textoAyuda;

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
     * Gets the value of the fechaVencimiento property.
     *
     * @return possible object is
     * {@link XMLGregorianCalendar }
     */
    public XMLGregorianCalendar getFechaVencimiento() {
        return fechaVencimiento;
    }

    /**
     * Sets the value of the fechaVencimiento property.
     *
     * @param value allowed object is
     *              {@link XMLGregorianCalendar }
     */
    public void setFechaVencimiento(XMLGregorianCalendar value) {
        this.fechaVencimiento = value;
    }

    /**
     * Gets the value of the formaPago property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFormaPago() {
        return formaPago;
    }

    /**
     * Sets the value of the formaPago property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFormaPago(String value) {
        this.formaPago = value;
    }

    /**
     * Gets the value of the formaPagoRecibos property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFormaPagoRecibos() {
        return formaPagoRecibos;
    }

    /**
     * Sets the value of the formaPagoRecibos property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFormaPagoRecibos(String value) {
        this.formaPagoRecibos = value;
    }

    /**
     * Gets the value of the identificadorDeuda property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getIdentificadorDeuda() {
        return identificadorDeuda;
    }

    /**
     * Sets the value of the identificadorDeuda property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setIdentificadorDeuda(String value) {
        this.identificadorDeuda = value;
    }

    /**
     * Gets the value of the limiteMontoMaximo property.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getLimiteMontoMaximo() {
        return limiteMontoMaximo;
    }

    /**
     * Sets the value of the limiteMontoMaximo property.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setLimiteMontoMaximo(Double value) {
        this.limiteMontoMaximo = value;
    }

    /**
     * Gets the value of the limiteMontoMinimo property.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getLimiteMontoMinimo() {
        return limiteMontoMinimo;
    }

    /**
     * Sets the value of the limiteMontoMinimo property.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setLimiteMontoMinimo(Double value) {
        this.limiteMontoMinimo = value;
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
     * Gets the value of the montoMinimo property.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getMontoMinimo() {
        return montoMinimo;
    }

    /**
     * Sets the value of the montoMinimo property.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setMontoMinimo(Double value) {
        this.montoMinimo = value;
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
     * Gets the value of the nombreCliente property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getNombreCliente() {
        return nombreCliente;
    }

    /**
     * Sets the value of the nombreCliente property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setNombreCliente(String value) {
        this.nombreCliente = value;
    }

    /**
     * Gets the value of the recibos property.
     *
     * @return possible object is
     * {@link Recibos }
     */
    public Recibos getRecibos() {
        return recibos;
    }

    /**
     * Sets the value of the recibos property.
     *
     * @param value allowed object is
     *              {@link Recibos }
     */
    public void setRecibos(Recibos value) {
        this.recibos = value;
    }

    /**
     * Gets the value of the textoAyuda property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getTextoAyuda() {
        return textoAyuda;
    }

    /**
     * Sets the value of the textoAyuda property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setTextoAyuda(String value) {
        this.textoAyuda = value;
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
     *         &lt;element name="recibo" type="{http://www.bolivariano.com/dominio/Recibo}recibo" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
            "recibo"
    })
    public static class Recibos {

        @XmlElement(nillable = true)
        protected List<Recibo> recibo;

        /**
         * Gets the value of the recibo property.
         * <p>
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the recibo property.
         * <p>
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getRecibo().add(newItem);
         * </pre>
         * <p>
         * <p>
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link Recibo }
         */
        public List<Recibo> getRecibo() {
            if (recibo == null) {
                recibo = new ArrayList<Recibo>();
            }
            return this.recibo;
        }

    }

}
