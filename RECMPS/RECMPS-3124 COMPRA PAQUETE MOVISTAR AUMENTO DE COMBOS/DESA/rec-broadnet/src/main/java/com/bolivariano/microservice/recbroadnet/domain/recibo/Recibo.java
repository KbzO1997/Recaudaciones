package com.bolivariano.microservice.recbroadnet.domain.recibo;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Clase Java para recibo complex type.
 *
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 *
 * <pre>
 * &lt;complexType name="recibo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="comprobante" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="concepto" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="cuota" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="datosAdicionales" minOccurs="0">
 *           &lt;complexType>
 *             &lt;complexContent>
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                 &lt;sequence>
 *                   &lt;element name="datoAdicional" type="{http://www.bolivariano.com/dominio/DatoAdicional}datoAdicional" maxOccurs="unbounded" minOccurs="0"/>
 *                 &lt;/sequence>
 *               &lt;/restriction>
 *             &lt;/complexContent>
 *           &lt;/complexType>
 *         &lt;/element>
 *         &lt;element name="dato1" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="dato2" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="dividendo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="fecha" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="formaPago" type="{http://www.bolivariano.com/dominio/FormaPago}formaPago" minOccurs="0"/>
 *         &lt;element name="identificador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="impuesto" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="interes" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *         &lt;element name="interesesPagados" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *         &lt;element name="interesesPendientes" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *         &lt;element name="numeroPredial" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="pago" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *         &lt;element name="referencia" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="secuencia" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="tipoProceso" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="totalAPagar" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *         &lt;element name="valor" type="{http://www.w3.org/2001/XMLSchema}double" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "recibo", propOrder = {
        "comprobante",
        "concepto",
        "cuota",
        "datosAdicionales",
        "dato1",
        "dato2",
        "dividendo",
        "fecha",
        "formaPago",
        "identificador",
        "impuesto",
        "interes",
        "interesesPagados",
        "interesesPendientes",
        "numeroPredial",
        "pago",
        "referencia",
        "secuencia",
        "tipoProceso",
        "totalAPagar",
        "valor"
})
public class Recibo {

    protected String comprobante;
    protected String concepto;
    protected String cuota;
    protected DatosAdicionales datosAdicionales;
    protected String dato1;
    protected String dato2;
    protected String dividendo;
    protected String fecha;
    protected String formaPago;
    protected String identificador;
    protected String impuesto;
    protected Double interes;
    protected Double interesesPagados;
    protected Double interesesPendientes;
    protected String numeroPredial;
    protected Double pago;
    protected String referencia;
    protected String secuencia;
    protected String tipoProceso;
    protected Double totalAPagar;
    protected Double valor;

    /**
     * Obtiene el valor de la propiedad comprobante.
     *
     * @return possible object is
     * {@link String }
     */
    public String getComprobante() {
        return comprobante;
    }

    /**
     * Define el valor de la propiedad comprobante.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setComprobante(String value) {
        this.comprobante = value;
    }

    /**
     * Obtiene el valor de la propiedad concepto.
     *
     * @return possible object is
     * {@link String }
     */
    public String getConcepto() {
        return concepto;
    }

    /**
     * Define el valor de la propiedad concepto.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setConcepto(String value) {
        this.concepto = value;
    }

    /**
     * Obtiene el valor de la propiedad cuota.
     *
     * @return possible object is
     * {@link String }
     */
    public String getCuota() {
        return cuota;
    }

    /**
     * Define el valor de la propiedad cuota.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setCuota(String value) {
        this.cuota = value;
    }

    /**
     * Obtiene el valor de la propiedad datosAdicionales.
     *
     * @return possible object is
     * {@link DatosAdicionales }
     */
    public DatosAdicionales getDatosAdicionales() {
        return datosAdicionales;
    }

    /**
     * Define el valor de la propiedad datosAdicionales.
     *
     * @param value allowed object is
     *              {@link DatosAdicionales }
     */
    public void setDatosAdicionales(DatosAdicionales value) {
        this.datosAdicionales = value;
    }

    /**
     * Obtiene el valor de la propiedad dato1.
     *
     * @return possible object is
     * {@link String }
     */
    public String getDato1() {
        return dato1;
    }

    /**
     * Define el valor de la propiedad dato1.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setDato1(String value) {
        this.dato1 = value;
    }

    /**
     * Obtiene el valor de la propiedad dato2.
     *
     * @return possible object is
     * {@link String }
     */
    public String getDato2() {
        return dato2;
    }

    /**
     * Define el valor de la propiedad dato2.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setDato2(String value) {
        this.dato2 = value;
    }

    /**
     * Obtiene el valor de la propiedad dividendo.
     *
     * @return possible object is
     * {@link String }
     */
    public String getDividendo() {
        return dividendo;
    }

    /**
     * Define el valor de la propiedad dividendo.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setDividendo(String value) {
        this.dividendo = value;
    }

    /**
     * Obtiene el valor de la propiedad fecha.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * Define el valor de la propiedad fecha.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFecha(String value) {
        this.fecha = value;
    }

    /**
     * Obtiene el valor de la propiedad formaPago.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFormaPago() {
        return formaPago;
    }

    /**
     * Define el valor de la propiedad formaPago.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFormaPago(String value) {
        this.formaPago = value;
    }

    /**
     * Obtiene el valor de la propiedad identificador.
     *
     * @return possible object is
     * {@link String }
     */
    public String getIdentificador() {
        return identificador;
    }

    /**
     * Define el valor de la propiedad identificador.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setIdentificador(String value) {
        this.identificador = value;
    }

    /**
     * Obtiene el valor de la propiedad impuesto.
     *
     * @return possible object is
     * {@link String }
     */
    public String getImpuesto() {
        return impuesto;
    }

    /**
     * Define el valor de la propiedad impuesto.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setImpuesto(String value) {
        this.impuesto = value;
    }

    /**
     * Obtiene el valor de la propiedad interes.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getInteres() {
        return interes;
    }

    /**
     * Define el valor de la propiedad interes.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setInteres(Double value) {
        this.interes = value;
    }

    /**
     * Obtiene el valor de la propiedad interesesPagados.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getInteresesPagados() {
        return interesesPagados;
    }

    /**
     * Define el valor de la propiedad interesesPagados.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setInteresesPagados(Double value) {
        this.interesesPagados = value;
    }

    /**
     * Obtiene el valor de la propiedad interesesPendientes.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getInteresesPendientes() {
        return interesesPendientes;
    }

    /**
     * Define el valor de la propiedad interesesPendientes.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setInteresesPendientes(Double value) {
        this.interesesPendientes = value;
    }

    /**
     * Obtiene el valor de la propiedad numeroPredial.
     *
     * @return possible object is
     * {@link String }
     */
    public String getNumeroPredial() {
        return numeroPredial;
    }

    /**
     * Define el valor de la propiedad numeroPredial.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setNumeroPredial(String value) {
        this.numeroPredial = value;
    }

    /**
     * Obtiene el valor de la propiedad pago.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getPago() {
        return pago;
    }

    /**
     * Define el valor de la propiedad pago.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setPago(Double value) {
        this.pago = value;
    }

    /**
     * Obtiene el valor de la propiedad referencia.
     *
     * @return possible object is
     * {@link String }
     */
    public String getReferencia() {
        return referencia;
    }

    /**
     * Define el valor de la propiedad referencia.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setReferencia(String value) {
        this.referencia = value;
    }

    /**
     * Obtiene el valor de la propiedad secuencia.
     *
     * @return possible object is
     * {@link String }
     */
    public String getSecuencia() {
        return secuencia;
    }

    /**
     * Define el valor de la propiedad secuencia.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setSecuencia(String value) {
        this.secuencia = value;
    }

    /**
     * Obtiene el valor de la propiedad tipoProceso.
     *
     * @return possible object is
     * {@link String }
     */
    public String getTipoProceso() {
        return tipoProceso;
    }

    /**
     * Define el valor de la propiedad tipoProceso.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setTipoProceso(String value) {
        this.tipoProceso = value;
    }

    /**
     * Obtiene el valor de la propiedad totalAPagar.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getTotalAPagar() {
        return totalAPagar;
    }

    /**
     * Define el valor de la propiedad totalAPagar.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setTotalAPagar(Double value) {
        this.totalAPagar = value;
    }

    /**
     * Obtiene el valor de la propiedad valor.
     *
     * @return possible object is
     * {@link Double }
     */
    public Double getValor() {
        return valor;
    }

    /**
     * Define el valor de la propiedad valor.
     *
     * @param value allowed object is
     *              {@link Double }
     */
    public void setValor(Double value) {
        this.valor = value;
    }


    /**
     * <p>Clase Java para anonymous complex type.
     *
     * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
     *
     * <pre>
     * &lt;complexType>
     *   &lt;complexContent>
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
     *       &lt;sequence>
     *         &lt;element name="datoAdicional" type="{http://www.bolivariano.com/dominio/DatoAdicional}datoAdicional" maxOccurs="unbounded" minOccurs="0"/>
     *       &lt;/sequence>
     *     &lt;/restriction>
     *   &lt;/complexContent>
     * &lt;/complexType>
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
         */
        public List<DatoAdicional> getDatoAdicional() {
            if (datoAdicional == null) {
                datoAdicional = new ArrayList<>();
            }
            return this.datoAdicional;
        }

    }

}
