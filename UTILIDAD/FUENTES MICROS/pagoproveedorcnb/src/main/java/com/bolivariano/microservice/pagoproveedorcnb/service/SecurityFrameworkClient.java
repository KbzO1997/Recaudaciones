package com.bolivariano.microservice.pagoproveedorcnb.service;

import java.io.ByteArrayInputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.ws.BindingProvider;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;
import org.w3c.dom.Attr;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;

import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.wsframework.ServicioSeguridadSCL;
import com.bolivariano.wsframework.ServicioSeguridadSCLSoap;

import io.quarkus.runtime.Quarkus;

@ApplicationScoped
public class SecurityFrameworkClient{

	@ConfigProperty(name = "otc-collector.framework.idAplicacion")
	Integer idAplicacion;
	
	@ConfigProperty(name = "otc-collector.framework.connTimeout")
	Integer connTimeout;
	
	@ConfigProperty(name = "otc-collector.framework.readTimeout")
	Integer readTimeout;

	@ConfigProperty(name = "otc-collector.framework.usuarioApl")
	String usuarioApl;

	@ConfigProperty(name = "otc-collector.framework.url")
	String url;

	@Inject
	Logger log;

	public Map<String, String> loginAplicacion() throws CollectorException {
		try {
			
			log.debug("Inicia consumo Framework Seguridad");
			Map<String, String> parametrosFramework = new HashMap<>();
			ServicioSeguridadSCL servicioSeguridadSCL = new ServicioSeguridadSCL(new URL(url));
			ServicioSeguridadSCLSoap servicioSeguridadSCLSoap = servicioSeguridadSCL.getServicioSeguridadSCLSoap();
			setTimeouts((BindingProvider)servicioSeguridadSCLSoap, connTimeout, readTimeout);
			String respuesta = servicioSeguridadSCLSoap.loginAplicacion(idAplicacion, usuarioApl);

			NamedNodeMap atributos = this.obtenerValores(respuesta);
			int numeroAtributos = atributos.getLength();
			
			
			
			for (int i = 0; i < numeroAtributos; i++) {
				Attr atributo = (Attr) atributos.item(i);
				String nombrePropiedad = atributo.getNodeName();
				parametrosFramework.put(nombrePropiedad, atributo.getNodeValue());
			}
			
			log.debug("Finaliza consumo Framework Seguridad");
			return parametrosFramework;
			
		} catch (Exception e) {
			Quarkus.waitForExit();
			throw new CollectorException("Error al consumir Framework Seguridad");			
		}
	}

	public NamedNodeMap obtenerValores(String xmlCadena) {
		try {
			log.debug("Se cargar propiedades del framework de seguridad.");
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			/*factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, ""); // Compliant
			factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, ""); // compliant*/
			factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl",true);		        
			factory.setFeature("http://xml.org/sax/features/external-general-entities",false);		        
			factory.setFeature("http://xml.org/sax/features/external-parameter-entities",false);
			factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);				
			Element node = factory.newDocumentBuilder().parse(new ByteArrayInputStream(xmlCadena.getBytes()))
					.getDocumentElement();

			return node.getAttributes();

		} catch (Exception e) {
			log.error("Error al obtener valores", e);
			return null;
		}

	}

	private void setTimeouts(BindingProvider serviceClass, int connTimeout, int readTimeout) {
		Client cxfClient = ClientProxy.getClient(serviceClass);
		HTTPConduit httpConduit = (HTTPConduit) cxfClient.getConduit();
		HTTPClientPolicy httpClientPolicy = new HTTPClientPolicy();
		httpClientPolicy.setConnectionRequestTimeout(connTimeout);
		httpClientPolicy.setConnectionTimeout(connTimeout);
		httpClientPolicy.setReceiveTimeout(readTimeout);
		httpConduit.setClient(httpClientPolicy);
	}
}
