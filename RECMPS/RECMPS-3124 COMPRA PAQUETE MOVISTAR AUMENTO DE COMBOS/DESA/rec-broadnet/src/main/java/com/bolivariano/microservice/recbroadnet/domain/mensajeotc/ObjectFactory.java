
package com.bolivariano.microservice.recbroadnet.domain.mensajeotc;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

/**
 * This object contains factory methods for each Java content interface and Java
 * element interface generated in the com.bolivariano.mensaje.mensajeotc
 * package.
 * <p>
 * An ObjectFactory allows you to programatically construct new instances of the
 * Java representation for XML content. The Java representation of XML content
 * can consist of schema derived interfaces and classes representing the binding
 * of schema type definitions, element declarations and model groups. Factory
 * methods for each of these are provided in this class.
 *
 */
@XmlRegistry
public class ObjectFactory {

	private final static QName _MensajeEntradaEjecutarPago_QNAME = new QName(
			"http://www.bolivariano.com/mensaje/MensajeOTC", "entradaEjecutarPago");
	private final static QName _MensajeSalidaEjecutarPago_QNAME = new QName(
			"http://www.bolivariano.com/mensaje/MensajeOTC", "salidaEjecutarPago");

	/**
	 * Create a new ObjectFactory that can be used to create new instances of schema
	 * derived classes for package: com.bolivariano.mensaje.mensajeotc
	 *
	 */
	public ObjectFactory() {
	}

	/**
	 * Create an instance of {@link MensajeSalidaEjecutarPago }
	 *
	 */
	public MensajeSalidaEjecutarPago createMensajeSalidaEjecutarPago() {
		return new MensajeSalidaEjecutarPago();
	}

	/**
	 * Create an instance of {@link MensajeEntradaEjecutarPago }
	 *
	 */
	public MensajeEntradaEjecutarPago createMensajeEntradaEjecutarPago() {
		return new MensajeEntradaEjecutarPago();
	}

	/**
	 * Create an instance of {@link MensajeEntradaConsultarEmpresa }
	 *
	 */

	/**
	 * Create an instance of {@link MensajeSalidaEjecutarPago.DatosAdicionales }
	 *
	 */
	public MensajeSalidaEjecutarPago.DatosAdicionales createMensajeSalidaEjecutarPagoDatosAdicionales() {
		return new MensajeSalidaEjecutarPago.DatosAdicionales();
	}

	/**
	 * Create an instance of {@link MensajeEntradaEjecutarPago.DatosAdicionales }
	 *
	 */

	/**
	 * Create an instance of {@link JAXBElement
	 * }{@code <}{@link MensajeEntradaEjecutarPago}{@code >}}
	 *
	 */
	@XmlElementDecl(namespace = "http://www.bolivariano.com/mensaje/MensajeOTC", name = "MensajeEntradaEjecutarPago")
	public JAXBElement<MensajeEntradaEjecutarPago> createMensajeEntradaEjecutarPago(
			MensajeEntradaEjecutarPago value) {
		return new JAXBElement<>(_MensajeEntradaEjecutarPago_QNAME,
				MensajeEntradaEjecutarPago.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement
	 * }{@code <}{@link MensajeEntradaConsultarEmpresa }{@code >}}
	 *
	 */

	/**
	 * Create an instance of {@link JAXBElement
	 * }{@code <}{@link MensajeSalidaEjecutarPago }{@code >}}
	 *
	 */
	@XmlElementDecl(namespace = "http://www.bolivariano.com/mensaje/MensajeOTC", name = "MensajeSalidaEjecutarPago")
	public JAXBElement<MensajeSalidaEjecutarPago> createMensajeSalidaEjecutarPago(
			MensajeSalidaEjecutarPago value) {
		return new JAXBElement<MensajeSalidaEjecutarPago>(_MensajeSalidaEjecutarPago_QNAME,
				MensajeSalidaEjecutarPago.class, null, value);
	}

}
