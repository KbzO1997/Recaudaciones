package com.bolivariano.microservice.recbroadnet.configuration;

import io.quarkus.arc.Unremovable;
import io.quarkus.credentials.CredentialsProvider;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
@Unremovable
public class BBCredentialsProvider implements CredentialsProvider {

    @Inject
    Map<String, String> frameworkSecurityParams;

    @Override
    public Map<String, String> getCredentials(String credentialsProviderName) {

        Map<String, String> properties = new HashMap<>();
        properties.put(USER_PROPERTY_NAME, frameworkSecurityParams.get("RECM_user_sybase"));
        properties.put(PASSWORD_PROPERTY_NAME, frameworkSecurityParams.get("RECM_pass_sybase"));
        return properties;
    }

}
