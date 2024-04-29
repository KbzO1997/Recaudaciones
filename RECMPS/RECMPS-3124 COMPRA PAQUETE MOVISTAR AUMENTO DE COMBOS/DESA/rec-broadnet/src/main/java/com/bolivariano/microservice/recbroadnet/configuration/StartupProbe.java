package com.bolivariano.microservice.recbroadnet.configuration;

import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import com.bolivariano.microservice.recbroadnet.service.ProcessorService;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import org.jboss.logging.Logger;

import org.eclipse.microprofile.health.Startup;
@Startup
@ApplicationScoped
public class StartupProbe implements HealthCheck {

    @Inject
    ProcessorService processorService;
    
    @Inject
	Initialize initialize;

	@Inject
	Logger log;

    @Override
    public HealthCheckResponse call() {

    	try{
			initialize.onStart();
			log.info("StartupProbe OK");
			return HealthCheckResponse.up("Ok StartupProbe");

		} catch (Exception ex) {
			return HealthCheckResponse.down(ex.getMessage());
		}


    }

}
