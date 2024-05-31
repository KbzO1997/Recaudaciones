package com.bolivariano.microservice.pagoproveedorcnb.configuration;

import com.bolivariano.microservice.pagoproveedorcnb.service.MessageSenderService;
import org.eclipse.microprofile.health.HealthCheck;
import org.eclipse.microprofile.health.HealthCheckResponse;
import org.eclipse.microprofile.health.Liveness;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.UUID;

@Liveness
@ApplicationScoped
public class LivenessProbe implements HealthCheck {
    @Inject
    MessageSenderService messageSenderService;


    @Override
    public HealthCheckResponse call() {
        try{
            String userId = UUID.randomUUID().toString().replace("-", "").substring(0, 12);
            messageSenderService.sendMessage("TEST",userId, true);
            return HealthCheckResponse.up("Ok LivenessProbe");
        }catch (Exception ex){
            return HealthCheckResponse.down(ex.getMessage());
        }

    }
}
