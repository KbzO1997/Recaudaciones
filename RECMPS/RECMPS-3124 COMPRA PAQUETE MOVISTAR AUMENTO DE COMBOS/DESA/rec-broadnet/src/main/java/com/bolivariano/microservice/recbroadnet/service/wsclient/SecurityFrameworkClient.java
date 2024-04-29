package com.bolivariano.microservice.recbroadnet.service.wsclient;

import com.bolivariano.microservice.recbroadnet.configuration.ApplicationProperties;
import com.bolivariano.microservice.recbroadnet.configuration.WebServiceClient;
import com.bolivariano.microservice.recbroadnet.exception.BusinessException;
import com.bolivariano.wsframework.ServicioSeguridadSCLSoap;
import org.jboss.logging.Logger;
import org.w3c.dom.Attr;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
public class SecurityFrameworkClient {

	@Inject
	ApplicationProperties applicationProperties;

	@Inject
	Logger log;

	@Inject
	WebServiceClient webServiceClient;

	public Map<String, String> loginAplicacion() throws BusinessException {
		try {
			log.info("Inicia consumo Framework Seguridad");
			Map<String, String> parametrosFramework = new HashMap<>();
			ServicioSeguridadSCLSoap servicioSeguridadSCLSoap = webServiceClient.obtenerClienteFramework();
			String respuesta = servicioSeguridadSCLSoap.loginAplicacion(
					applicationProperties.frameworkSeguridad().idAplicacion(),
					applicationProperties.frameworkSeguridad().usuarioApl());
			NamedNodeMap atributos = this.obtenerValores(respuesta);
			int numeroAtributos = atributos.getLength();

			for (int i = 0; i < numeroAtributos; i++) {
				Attr atributo = (Attr) atributos.item(i);

				String nombrePropiedad = atributo.getNodeName();
				parametrosFramework.put(nombrePropiedad, atributo.getNodeValue());
			}
			log.info("Finaliza consumo Framework Seguridad");
			return parametrosFramework;

		} catch (Exception e) {
			throw new BusinessException("Error al consumir Framework Seguridad");
		}
	}

	public NamedNodeMap obtenerValores(String xmlCadena) {
		try {
			log.info("Se cargar propiedades del framework de seguridad.");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
			Element node = factory.newDocumentBuilder().parse(new ByteArrayInputStream(xmlCadena.getBytes()))
					.getDocumentElement();

			return node.getAttributes();

		} catch (Exception e) {
			log.error("Error al obtener valores", e);
			return null;
		}

	}

}
