package com.bolivariano.microservice.recbroadnet.domain.servicio;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for servicio complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="servicio"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codTipoServicio" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="codigoConvenio" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="codigoEmpresa" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="codigoTipoBanca" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="codigoTipoIdentificador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
 *         &lt;element name="identificador" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "servicio", propOrder = {
    "codTipoServicio",
    "codigoConvenio",
    "codigoEmpresa",
    "codigoTipoBanca",
    "codigoTipoIdentificador",
    "datosAdicionales",
    "identificador"
})
public class Servicio {

    @XmlElement(required = true)
    protected String codTipoServicio;
    @XmlElement(required = true)
    protected String codigoConvenio;
    @XmlElement(required = true)
    protected String codigoEmpresa;
    @XmlElement(required = true)
    protected String codigoTipoBanca;
    protected String codigoTipoIdentificador;
    protected DatosAdicionales datosAdicionales;
    protected String identificador;

    /**
     * Gets the value of the codTipoServicio property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodTipoServicio() {
        return codTipoServicio;
    }

    /**
     * Sets the value of the codTipoServicio property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodTipoServicio(String value) {
        this.codTipoServicio = value;
    }

    /**
     * Gets the value of the codigoConvenio property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodigoConvenio() {
        return codigoConvenio;
    }

    /**
     * Sets the value of the codigoConvenio property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodigoConvenio(String value) {
        this.codigoConvenio = value;
    }

    /**
     * Gets the value of the codigoEmpresa property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodigoEmpresa() {
        return codigoEmpresa;
    }

    /**
     * Sets the value of the codigoEmpresa property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodigoEmpresa(String value) {
        this.codigoEmpresa = value;
    }

    /**
     * Gets the value of the codigoTipoBanca property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodigoTipoBanca() {
        return codigoTipoBanca;
    }

    /**
     * Sets the value of the codigoTipoBanca property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodigoTipoBanca(String value) {
        this.codigoTipoBanca = value;
    }

    /**
     * Gets the value of the codigoTipoIdentificador property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodigoTipoIdentificador() {
        return codigoTipoIdentificador;
    }

    /**
     * Sets the value of the codigoTipoIdentificador property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodigoTipoIdentificador(String value) {
        this.codigoTipoIdentificador = value;
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
     * Gets the value of the identificador property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdentificador() {
        return identificador;
    }

    /**
     * Sets the value of the identificador property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdentificador(String value) {
        this.identificador = value;
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

}
