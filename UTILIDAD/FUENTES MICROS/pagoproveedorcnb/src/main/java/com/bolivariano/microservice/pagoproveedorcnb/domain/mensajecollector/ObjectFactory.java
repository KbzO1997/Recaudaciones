
package com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each
 * Java content interface and Java element interface
 * generated in the com.bolivariano.mensaje.mensajecollector package.
 * <p>An ObjectFactory allows you to programatically
 * construct new instances of the Java representation
 * for XML content. The Java representation of XML
 * content can consist of schema derived interfaces
 * and classes representing the binding of schema
 * type definitions, element declarations and model
 * groups.  Factory methods for each of these are
 * provided in this class.
 *
 */
@XmlRegistry
public class ObjectFactory {


    
    public ObjectFactory() {
    	/**
         * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.bolivariano.mensaje.mensajecollector
         *
         */
    }

    /**
     * Create an instance of {@link MensajeEntradaCollector }
     *
     */
    public MensajeEntradaCollector createMensajeEntradaCollector() {
        return new MensajeEntradaCollector();
    }

    /**
     * Create an instance of {@link MensajeSalidaCollector }
     *
     */
    public MensajeSalidaCollector createMensajeSalidaCollector() {
        return new MensajeSalidaCollector();
    }

    /**
     * Create an instance of {@link MensajeEntradaCollector.Datos }
     *
     */
    public Datos createMensajeEntradaCollectorDatos() {
        return new Datos();
    }

    /**
     * Create an instance of {@link MensajeSalidaCollector.Datos }
     *
     */
    public Datos createMensajeSalidaCollectorDatos() {
        return new Datos();
    }

    /**
     * Create an instance of {@link Dato }
     *
     */
    public Dato createDato() {
        return new Dato();
    }

}
