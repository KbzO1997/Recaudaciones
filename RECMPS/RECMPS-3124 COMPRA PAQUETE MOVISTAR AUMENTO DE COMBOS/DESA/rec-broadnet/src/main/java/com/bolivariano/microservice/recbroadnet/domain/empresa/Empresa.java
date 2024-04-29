
package com.bolivariano.microservice.recbroadnet.domain.empresa;

import com.bolivariano.microservice.recbroadnet.domain.convenio.Convenio;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for empresa complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="empresa"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codigoEmpresa" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="etiquetaEmpresa" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="convenioVisible" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="convenios" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="convenio" type="{http://www.bolivariano.com/dominio/Convenio}convenio" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="matriculable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="matriculacionMultiple" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="validable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "empresa", propOrder = {
    "codigoEmpresa",
    "etiquetaEmpresa",
    "convenioVisible",
    "convenios",
    "matriculable",
    "matriculacionMultiple",
    "validable"
})
public class Empresa {

    protected String codigoEmpresa;
    protected String etiquetaEmpresa;
    protected Boolean convenioVisible;
    protected Convenios convenios;
    protected Boolean matriculable;
    protected Boolean matriculacionMultiple;
    protected Boolean validable;

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
     * Gets the value of the etiquetaEmpresa property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getEtiquetaEmpresa() {
        return etiquetaEmpresa;
    }

    /**
     * Sets the value of the etiquetaEmpresa property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setEtiquetaEmpresa(String value) {
        this.etiquetaEmpresa = value;
    }

    /**
     * Gets the value of the convenioVisible property.
     *
     * @return
     *     possible object is
     *     {@link Boolean }
     *
     */
    public Boolean isConvenioVisible() {
        return convenioVisible;
    }

    /**
     * Sets the value of the convenioVisible property.
     *
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *
     */
    public void setConvenioVisible(Boolean value) {
        this.convenioVisible = value;
    }

    /**
     * Gets the value of the convenios property.
     *
     * @return
     *     possible object is
     *     {@link Convenios }
     *
     */
    public Convenios getConvenios() {
        return convenios;
    }

    /**
     * Sets the value of the convenios property.
     *
     * @param value
     *     allowed object is
     *     {@link Convenios }
     *
     */
    public void setConvenios(Convenios value) {
        this.convenios = value;
    }

    /**
     * Gets the value of the matriculable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMatriculable() {
        return matriculable;
    }

    /**
     * Sets the value of the matriculable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMatriculable(Boolean value) {
        this.matriculable = value;
    }

    /**
     * Gets the value of the matriculacionMultiple property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMatriculacionMultiple() {
        return matriculacionMultiple;
    }

    /**
     * Sets the value of the matriculacionMultiple property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMatriculacionMultiple(Boolean value) {
        this.matriculacionMultiple = value;
    }

    /**
     * Gets the value of the validable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isValidable() {
        return validable;
    }

    /**
     * Sets the value of the validable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setValidable(Boolean value) {
        this.validable = value;
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
     *         &lt;element name="convenio" type="{http://www.bolivariano.com/dominio/Convenio}convenio" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "convenio"
    })
    public static class Convenios {

        @XmlElement(nillable = true)
        protected List<Convenio> convenio;

        /**
         * Gets the value of the convenio property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the convenio property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getConvenio().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link Convenio }
         * 
         * 
         */
        public List<Convenio> getConvenio() {
            if (convenio == null) {
                convenio = new ArrayList<Convenio>();
            }
            return this.convenio;
        }

    }

}
