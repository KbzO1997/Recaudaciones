
package com.bolivariano.microservice.recbroadnet.domain.convenio;

import com.bolivariano.microservice.recbroadnet.domain.tipoidentificador.TipoIdentificador;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for convenio complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="convenio"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codigo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="etiquetaCodigo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="tipoIdentificadores"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="tipoIdentificador" type="{http://www.bolivariano.com/dominio/TipoIdentificador}tipoIdentificador" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="visible" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "convenio", propOrder = {
    "codigo",
    "etiquetaCodigo",
    "tipoIdentificadores",
    "visible"
})
public class Convenio {

    protected String codigo;
    protected String etiquetaCodigo;
    @XmlElement(required = true)
    protected TipoIdentificadores tipoIdentificadores;
    protected boolean visible;

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
     * Gets the value of the tipoIdentificadores property.
     *
     * @return
     *     possible object is
     *     {@link TipoIdentificadores }
     *
     */
    public TipoIdentificadores getTipoIdentificadores() {
        return tipoIdentificadores;
    }

    /**
     * Sets the value of the tipoIdentificadores property.
     *
     * @param value
     *     allowed object is
     *     {@link TipoIdentificadores }
     *
     */
    public void setTipoIdentificadores(TipoIdentificadores value) {
        this.tipoIdentificadores = value;
    }

    /**
     * Gets the value of the visible property.
     * 
     */
    public boolean isVisible() {
        return visible;
    }

    /**
     * Sets the value of the visible property.
     * 
     */
    public void setVisible(boolean value) {
        this.visible = value;
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
     *         &lt;element name="tipoIdentificador" type="{http://www.bolivariano.com/dominio/TipoIdentificador}tipoIdentificador" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "tipoIdentificador"
    })
    public static class TipoIdentificadores {

        @XmlElement(nillable = true)
        protected List<TipoIdentificador> tipoIdentificador;

        /**
         * Gets the value of the tipoIdentificador property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the tipoIdentificador property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getTipoIdentificador().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link TipoIdentificador }
         * 
         * 
         */
        public List<TipoIdentificador> getTipoIdentificador() {
            if (tipoIdentificador == null) {
                tipoIdentificador = new ArrayList<TipoIdentificador>();
            }
            return this.tipoIdentificador;
        }

    }

}
