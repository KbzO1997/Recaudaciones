package com.bolivariano.microservice.recbroadnet.domain.datoadicional;

import com.bolivariano.microservice.recbroadnet.domain.listaseleccion.ListaSeleccion;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for datoAdicional complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="datoAdicional"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codigo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="etiqueta" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="editable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="formato" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="listasSeleccion" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="listaSeleccion" type="{http://www.bolivariano.com/dominio/ListaSeleccion}listaSeleccion" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="longitud" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="mascara" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="regexp" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="tipo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="valor" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="visible" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "datoAdicional", propOrder = {
    "codigo",
    "etiqueta",
    "editable",
    "formato",
    "listasSeleccion",
    "longitud",
    "mascara",
    "regexp",
    "tipo",
    "valor",
    "visible"
})
public class DatoAdicional {

    protected String codigo;
    protected String etiqueta;
    protected Boolean editable;
    protected String formato;
    protected ListasSeleccion listasSeleccion;
    protected String longitud;
    protected String mascara;
    protected String regexp;
    protected String tipo;
    protected String valor;
    protected Boolean visible;

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
     * Gets the value of the etiqueta property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getEtiqueta() {
        return etiqueta;
    }

    /**
     * Sets the value of the etiqueta property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setEtiqueta(String value) {
        this.etiqueta = value;
    }

    /**
     * Gets the value of the editable property.
     *
     * @return
     *     possible object is
     *     {@link Boolean }
     *
     */
    public Boolean isEditable() {
        return editable;
    }

    /**
     * Sets the value of the editable property.
     *
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *
     */
    public void setEditable(Boolean value) {
        this.editable = value;
    }

    /**
     * Gets the value of the formato property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getFormato() {
        return formato;
    }

    /**
     * Sets the value of the formato property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setFormato(String value) {
        this.formato = value;
    }

    /**
     * Gets the value of the listasSeleccion property.
     *
     * @return
     *     possible object is
     *     {@link ListasSeleccion }
     *
     */
    public ListasSeleccion getListasSeleccion() {
        return listasSeleccion;
    }

    /**
     * Sets the value of the listasSeleccion property.
     *
     * @param value
     *     allowed object is
     *     {@link ListasSeleccion }
     *
     */
    public void setListasSeleccion(ListasSeleccion value) {
        this.listasSeleccion = value;
    }

    /**
     * Gets the value of the longitud property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLongitud() {
        return longitud;
    }

    /**
     * Sets the value of the longitud property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLongitud(String value) {
        this.longitud = value;
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
     * Gets the value of the tipo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTipo() {
        return tipo;
    }

    /**
     * Sets the value of the tipo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTipo(String value) {
        this.tipo = value;
    }

    /**
     * Gets the value of the valor property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getValor() {
        return valor;
    }

    /**
     * Sets the value of the valor property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setValor(String value) {
        this.valor = value;
    }

    /**
     * Gets the value of the visible property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isVisible() {
        return visible;
    }

    /**
     * Sets the value of the visible property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setVisible(Boolean value) {
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
     *         &lt;element name="listaSeleccion" type="{http://www.bolivariano.com/dominio/ListaSeleccion}listaSeleccion" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "listaSeleccion"
    })
    public static class ListasSeleccion {

        @XmlElement(nillable = true)
        protected List<ListaSeleccion> listaSeleccion;

        /**
         * Gets the value of the listaSeleccion property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the listaSeleccion property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getListaSeleccion().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link ListaSeleccion }
         * 
         * 
         */
        public List<ListaSeleccion> getListaSeleccion() {
            if (listaSeleccion == null) {
                listaSeleccion = new ArrayList<ListaSeleccion>();
            }
            return this.listaSeleccion;
        }

    }

}
