package com.bolivariano.microservice.pagoproveedorcnb.configuration;

import java.util.Map;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.inject.Singleton;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.service.SecurityFrameworkClient;

import io.quarkus.arc.DefaultBean;

@Dependent
public class FrameworkSecurityInitializer {

	@Inject
	Logger log;

	@ConfigProperty(name = "otc.collector.truststore.path")
	String truststorePath;

	@ConfigProperty(name = "otc-collector.truststore.password")
	String truststorePassword;

	@ConfigProperty(name = "otc-collector.truststore.type")
	String truststoreType;

	@Produces
	@Singleton
	@DefaultBean
	Map<String, String> frameworkSecurityParams(SecurityFrameworkClient securityFrameworkClient)
			throws CollectorException {
		System.setProperty("javax.net.ssl.trustStore", truststorePath);
		System.setProperty("javax.net.ssl.trustStorePassword", truststorePassword);
		System.setProperty("javax.net.ssl.trustStoreType", truststoreType);
		log.info("Iniciando consumo frameworkSecurityParams");
		return securityFrameworkClient.loginAplicacion();
	}

}
