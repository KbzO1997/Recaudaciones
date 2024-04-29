package com.bolivariano.microservice.recbroadnet.domain.mensajeotc;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;
import com.bolivariano.microservice.recbroadnet.domain.recibo.Recibo;
import com.bolivariano.microservice.recbroadnet.domain.servicio.Servicio;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.xml.bind.annotation.*;
import javax.xml.datatype.XMLGregorianCalendar;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for mensajeEntradaEjecutarPago complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="mensajeEntradaEjecutarPago"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="canal" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="cuenta" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
 *         &lt;element name="depuracion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="esquemaFirma" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="fecha" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/&gt;
 *         &lt;element name="fechaPago" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="moneda" type="{http://www.bolivariano.com/dominio/TipoIdentificador}tipoMoneda" minOccurs="0"/&gt;
 *         &lt;element name="nombreCliente" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="oficina" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
 *         &lt;element name="secuencial" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="servicio" type="{http://www.bolivariano.com/dominio/Servicio}servicio" minOccurs="0"/&gt;
 *         &lt;element name="tipoCuenta" type="{http://www.bolivariano.com/dominio/TipoIdentificador}tipoCuenta" minOccurs="0"/&gt;
 *         &lt;element name="transaccion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="usuario" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="valorComision" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="valorPago" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="tipoProceso" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;
 *         &lt;element name="tipEjecucion" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/&gt;        
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "entradaEjecutarPago", propOrder = {
    "canal",
    "cuenta",
    "datosAdicionales",
    "depuracion",
    "esquemaFirma",
    "fecha",
    "fechaPago",
    "moneda",
    "nombreCliente",
    "oficina",
    "recibos",
    "secuencial",
    "servicio",
    "tipoCuenta",
    "transaccion",
    "usuario",
    "valorComision",
    "valorPago"
})
@XmlRootElement(name = "entradaEjecutarPago")
public class MensajeEntradaEjecutarPago {

    protected String canal;
    protected String cuenta;
    protected DatosAdicionales datosAdicionales;
    protected String depuracion;
    protected String esquemaFirma;
    @XmlSchemaType(name = "dateTime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss",timezone = "America/Guayaquil")
    protected XMLGregorianCalendar fecha;
    @XmlSchemaType(name = "dateTime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "America/Guayaquil")
    protected XMLGregorianCalendar fechaPago;
    protected String moneda;
    protected String nombreCliente;
    protected String oficina;
    protected Recibos recibos;
    protected String secuencial;
    protected Servicio servicio;
    protected String tipoCuenta;
    protected String transaccion;
    protected String usuario;
    protected Double valorComision;
    protected Double valorPago;
    /**
     * Gets the value of the canal property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCanal() {
        return canal;
    }

    /**
     * Sets the value of the canal property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCanal(String value) {
        this.canal = value;
    }

    /**
     * Gets the value of the cuenta property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCuenta() {
        return cuenta;
    }

    /**
     * Sets the value of the cuenta property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCuenta(String value) {
        this.cuenta = value;
    }

    /**
     * Gets the value of the datosAdicionales property.
     *
     * @return
     *     possible object is
     *     {@link DatosAdicionales }
     *
     */
    public DatosAdicionales getDatosAdicionales() {
        return datosAdicionales;
    }

    /**
     * Sets the value of the datosAdicionales property.
     *
     * @param value
     *     allowed object is
     *     {@link DatosAdicionales }
     *
     */
    public void setDatosAdicionales(DatosAdicionales value) {
        this.datosAdicionales = value;
    }

    /**
     * Gets the value of the depuracion property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getDepuracion() {
        return depuracion;
    }

    /**
     * Sets the value of the depuracion property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setDepuracion(String value) {
        this.depuracion = value;
    }

    /**
     * Gets the value of the esquemaFirma property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getEsquemaFirma() {
        return esquemaFirma;
    }

    /**
     * Sets the value of the esquemaFirma property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setEsquemaFirma(String value) {
        this.esquemaFirma = value;
    }

    /**
     * Gets the value of the fecha property.
     *
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public XMLGregorianCalendar getFecha() {
        return fecha;
    }

    /**
     * Sets the value of the fecha property.
     *
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public void setFecha(XMLGregorianCalendar value) {
        this.fecha = value;
    }

    /**
     * Gets the value of the fechaPago property.
     *
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public XMLGregorianCalendar getFechaPago() {
        return fechaPago;
    }

    /**
     * Sets the value of the fechaPago property.
     *
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *
     */
    public void setFechaPago(XMLGregorianCalendar value) {
        this.fechaPago = value;
    }

    /**
     * Gets the value of the moneda property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getMoneda() {
        return moneda;
    }

    /**
     * Sets the value of the moneda property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setMoneda(String value) {
        this.moneda = value;
    }

    /**
     * Gets the value of the nombreCliente property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getNombreCliente() {
        return nombreCliente;
    }

    /**
     * Sets the value of the nombreCliente property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setNombreCliente(String value) {
        this.nombreCliente = value;
    }

    /**
     * Gets the value of the oficina property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getOficina() {
        return oficina;
    }

    /**
     * Sets the value of the oficina property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setOficina(String value) {
        this.oficina = value;
    }

    /**
     * Gets the value of the recibos property.
     *
     * @return
     *     possible object is
     *     {@link Recibos }
     *
     */
    public Recibos getRecibos() {
        return recibos;
    }

    /**
     * Sets the value of the recibos property.
     *
     * @param value
     *     allowed object is
     *     {@link Recibos }
     *
     */
    public void setRecibos(Recibos value) {
        this.recibos = value;
    }

    /**
     * Gets the value of the secuencial property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecuencial() {
        return secuencial;
    }

    /**
     * Sets the value of the secuencial property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecuencial(String value) {
        this.secuencial = value;
    }

    /**
     * Gets the value of the servicio property.
     * 
     * @return
     *     possible object is
     *     {@link Servicio }
     *     
     */
    public Servicio getServicio() {
        return servicio;
    }

    /**
     * Sets the value of the servicio property.
     * 
     * @param value
     *     allowed object is
     *     {@link Servicio }
     *     
     */
    public void setServicio(Servicio value) {
        this.servicio = value;
    }

    /**
     * Gets the value of the tipoCuenta property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTipoCuenta() {
        return tipoCuenta;
    }

    /**
     * Sets the value of the tipoCuenta property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTipoCuenta(String value) {
        this.tipoCuenta = value;
    }

    /**
     * Gets the value of the transaccion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransaccion() {
        return transaccion;
    }

    /**
     * Sets the value of the transaccion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransaccion(String value) {
        this.transaccion = value;
    }

    /**
     * Gets the value of the usuario property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUsuario() {
        return usuario;
    }

    /**
     * Sets the value of the usuario property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUsuario(String value) {
        this.usuario = value;
    }

    /**
     * Gets the value of the valorComision property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public Double getValorComision() {
        return valorComision;
    }

    /**
     * Sets the value of the valorComision property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setValorComision(Double value) {
        this.valorComision = value;
    }

    /**
     * Gets the value of the valorPago property.
     * 
     * @return
     *     possible object is
     *     {@link Double }
     *     
     */
    public Double getValorPago() {
        return valorPago;
    }

    /**
     * Sets the value of the valorPago property.
     * 
     * @param value
     *     allowed object is
     *     {@link Double }
     *     
     */
    public void setValorPago(Double value) {
        this.valorPago = value;
    }
    

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
     *         &lt;element name="datoAdicional" type="{http://www.bolivariano.com/dominio/DatoAdicional}datoAdicional" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
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
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the datoAdicional property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getDatoAdicional().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link DatoAdicional }
         * 
         * 
         */
        public List<DatoAdicional> getDatoAdicional() {
            if (datoAdicional == null) {
                datoAdicional = new ArrayList<>();
            }
            return this.datoAdicional;
        }

        
    }


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
     *         &lt;element name="recibo" type="{http://www.bolivariano.com/dominio/Recibo}recibo" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
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
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the recibo property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getRecibo().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link Recibo }
         * 
         * 
         */
        public List<Recibo> getRecibo() {
            if (recibo == null) {
                recibo = new ArrayList<>();
            }
            return this.recibo;
        }

    }

}
