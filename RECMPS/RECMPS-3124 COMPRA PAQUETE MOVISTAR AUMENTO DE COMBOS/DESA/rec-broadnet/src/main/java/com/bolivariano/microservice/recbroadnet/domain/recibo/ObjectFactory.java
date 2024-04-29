package com.bolivariano.microservice.recbroadnet.domain.recibo;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each
 * Java content interface and Java element interface
 * generated in the com.bolivariano.dominio.recibo package.
 * <p>An ObjectFactory allows you to programatically
 * construct new instances of the Java representation
 * for XML content. The Java representation of XML
 * content can consist of schema derived interfaces
 * and classes representing the binding of schema
 * type definitions, element declarations and model
 * groups.  Factory methods for each of these are
 * provided in this class.
 */
@XmlRegistry
public class ObjectFactory {


    /**
     * Create an instance of {@link Recibo }
     */
    public Recibo createRecibo() {
        return new Recibo();
    }

    /**
     * Create an instance of {@link Recibo.DatosAdicionales }
     */
    public Recibo.DatosAdicionales createReciboDatosAdicionales() {
        return new Recibo.DatosAdicionales();
    }

}
