
package com.bolivariano.microservice.recbroadnet.domain.tipoidentificador;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;
import com.bolivariano.microservice.recbroadnet.domain.regionalarea.RegionalArea;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for tipoIdentificador complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="tipoIdentificador"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codigo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="etiquetaCodigo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="concatenadorRegionalArea" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
 *         &lt;element name="flujoAyuda" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="mascara" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="matriculable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="programable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="regexp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="regionalAreas" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="regionalArea" type="{http://www.bolivariano.com/dominio/RegionalArea}regionalArea" maxOccurs="unbounded" minOccurs="0"/&gt;
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
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "tipoIdentificador", propOrder = {
    "codigo",
    "etiquetaCodigo",
    "concatenadorRegionalArea",
    "datosAdicionales",
    "flujoAyuda",
    "mascara",
    "matriculable",
    "programable",
    "regexp",
    "regionalAreas",
    "textoAyuda"
})
public class TipoIdentificador {

    protected String codigo;
    protected String etiquetaCodigo;
    protected String concatenadorRegionalArea;
    protected DatosAdicionales datosAdicionales;
    protected String flujoAyuda;
    protected String mascara;
    protected Boolean matriculable;
    protected Boolean programable;
    protected String regexp;
    protected RegionalAreas regionalAreas;
    protected String textoAyuda;

    /**
     * Gets the value of the codigo property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getCodigo() {
        return codigo;
    }

    /**
     * Sets the value of the codigo property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setCodigo(String value) {
        this.codigo = value;
    }

    /**
     * Gets the value of the etiquetaCodigo property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getEtiquetaCodigo() {
        return etiquetaCodigo;
    }

    /**
     * Sets the value of the etiquetaCodigo property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setEtiquetaCodigo(String value) {
        this.etiquetaCodigo = value;
    }

    /**
     * Gets the value of the concatenadorRegionalArea property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getConcatenadorRegionalArea() {
        return concatenadorRegionalArea;
    }

    /**
     * Sets the value of the concatenadorRegionalArea property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setConcatenadorRegionalArea(String value) {
        this.concatenadorRegionalArea = value;
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
     * Gets the value of the flujoAyuda property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getFlujoAyuda() {
        return flujoAyuda;
    }

    /**
     * Sets the value of the flujoAyuda property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setFlujoAyuda(String value) {
        this.flujoAyuda = value;
    }

    /**
     * Gets the value of the mascara property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getMascara() {
        return mascara;
    }

    /**
     * Sets the value of the mascara property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setMascara(String value) {
        this.mascara = value;
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
     * Gets the value of the programable property.
     *
     * @return
     *     possible object is
     *     {@link Boolean }
     *
     */
    public Boolean isProgramable() {
        return programable;
    }

    /**
     * Sets the value of the programable property.
     *
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *
     */
    public void setProgramable(Boolean value) {
        this.programable = value;
    }

    /**
     * Gets the value of the regexp property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getRegexp() {
        return regexp;
    }

    /**
     * Sets the value of the regexp property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setRegexp(String value) {
        this.regexp = value;
    }

    /**
     * Gets the value of the regionalAreas property.
     *
     * @return
     *     possible object is
     *     {@link RegionalAreas }
     *
     */
    public RegionalAreas getRegionalAreas() {
        return regionalAreas;
    }

    /**
     * Sets the value of the regionalAreas property.
     *
     * @param value
     *     allowed object is
     *     {@link RegionalAreas }
     *
     */
    public void setRegionalAreas(RegionalAreas value) {
        this.regionalAreas = value;
    }

    /**
     * Gets the value of the textoAyuda property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTextoAyuda() {
        return textoAyuda;
    }

    /**
     * Sets the value of the textoAyuda property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTextoAyuda(String value) {
        this.textoAyuda = value;
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
                datoAdicional = new ArrayList<DatoAdicional>();
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
     *         &lt;element name="regionalArea" type="{http://www.bolivariano.com/dominio/RegionalArea}regionalArea" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "regionalArea"
    })
    public static class RegionalAreas {

        @XmlElement(nillable = true)
        protected List<RegionalArea> regionalArea;

        /**
         * Gets the value of the regionalArea property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the regionalArea property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getRegionalArea().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link RegionalArea }
         * 
         * 
         */
        public List<RegionalArea> getRegionalArea() {
            if (regionalArea == null) {
                regionalArea = new ArrayList<RegionalArea>();
            }
            return this.regionalArea;
        }

    }

}
