
package com.bolivariano.microservice.pagoproveedorcnb.domain.mensajeosb;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each
 * Java content interface and Java element interface
 * generated in the com.bolivariano.mensaje.mensajeosb package.
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
         * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.bolivariano.mensaje.mensajeosb
         *
         */
    }

    /**
     * Create an instance of {@link MensajeEntradaGateway }
     *
     */
    public MensajeEntradaGateway createMensajeEntradaGateway() {
        return new MensajeEntradaGateway();
    }

    /**
     * Create an instance of {@link MensajeSalidaGateway }
     *
     */
    public MensajeSalidaGateway createMensajeSalidaGateway() {
        return new MensajeSalidaGateway();
    }

}
