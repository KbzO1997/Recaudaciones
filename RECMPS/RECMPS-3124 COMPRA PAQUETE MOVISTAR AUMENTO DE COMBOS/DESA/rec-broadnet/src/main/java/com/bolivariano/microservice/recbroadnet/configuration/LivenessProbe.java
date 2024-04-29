package com.bolivariano.microservice.recbroadnet.configuration;

import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import org.eclipse.microprofile.health.Liveness;
import com.bolivariano.microservice.recbroadnet.mq.MessageProducer;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.UUID;

@Liveness
@ApplicationScoped
public class LivenessProbe implements HealthCheck {

@Inject
MessageProducer senderService;

	@Override
	public HealthCheckResponse call() {
	
		try {
			String userId = UUID.randomUUID().toString().replace("-", "").substring(0, 12);
			senderService.sendMessageConvrtText("TEST",userId, true);
			return HealthCheckResponse.up("Ok LivenessProbe");
		} catch (Exception ex){
			return HealthCheckResponse.down(ex.getMessage());
		}	
	}

}