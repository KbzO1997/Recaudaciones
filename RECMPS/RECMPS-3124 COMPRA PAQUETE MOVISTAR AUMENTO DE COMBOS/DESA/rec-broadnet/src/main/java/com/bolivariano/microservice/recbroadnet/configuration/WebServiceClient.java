package com.bolivariano.microservice.recbroadnet.configuration;

import java.net.MalformedURLException;
import java.net.URL;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.ws.BindingProvider;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.jboss.logging.Logger;

import com.bolivariano.wsframework.ServicioSeguridadSCL;
import com.bolivariano.wsframework.ServicioSeguridadSCLSoap;

@ApplicationScoped
public class WebServiceClient {

	@Inject
	Logger log;

	@Inject
	ApplicationProperties applicationProperties;

	@PostConstruct
	public void init() {
		System.setProperty("javax.net.ssl.trustStore", applicationProperties.truststore().path());
		System.setProperty("javax.net.ssl.trustStorePassword", applicationProperties.truststore().password());
		System.setProperty("javax.net.ssl.trustStoreType", applicationProperties.truststore().type());
	}


	public ServicioSeguridadSCLSoap obtenerClienteFramework() throws MalformedURLException {
		ServicioSeguridadSCL servicioSeguridadSCL = new ServicioSeguridadSCL(
				new URL(applicationProperties.frameworkSeguridad().url()));
		ServicioSeguridadSCLSoap servicioSeguridadSCLSoap = servicioSeguridadSCL.getServicioSeguridadSCLSoap();
		setTimeouts((BindingProvider) servicioSeguridadSCLSoap,
				applicationProperties.frameworkSeguridad().connTimeout(),
				applicationProperties.frameworkSeguridad().readTimeout());
		return servicioSeguridadSCLSoap;
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
