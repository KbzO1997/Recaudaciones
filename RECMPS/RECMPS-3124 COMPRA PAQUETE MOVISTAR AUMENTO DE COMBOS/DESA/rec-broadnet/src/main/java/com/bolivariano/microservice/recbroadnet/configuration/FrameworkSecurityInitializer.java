package com.bolivariano.microservice.recbroadnet.configuration;

import java.util.Map;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.inject.Singleton;

import com.bolivariano.microservice.recbroadnet.exception.BusinessException;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.recbroadnet.service.wsclient.SecurityFrameworkClient;

import io.quarkus.arc.DefaultBean;


@Dependent
public class FrameworkSecurityInitializer {
	
	@Inject
	Logger log;
	
	@Inject
	ApplicationProperties applicationProperties;
	
	
	@Produces
	@Singleton
	@DefaultBean
	Map<String, String> frameworkSecurityParams(SecurityFrameworkClient securityFrameworkClient) throws BusinessException {
		log.info("Iniciando consumo frameworkSecurityParams");
		System.setProperty("javax.net.ssl.trustStore", applicationProperties.truststore().path());
		System.setProperty("javax.net.ssl.trustStorePassword", applicationProperties.truststore().password() );
		System.setProperty("javax.net.ssl.trustStoreType", applicationProperties.truststore().type());
		log.info("Iniciando consumo frameworkSecurityParams");
		return securityFrameworkClient.loginAplicacion();
	}

}
