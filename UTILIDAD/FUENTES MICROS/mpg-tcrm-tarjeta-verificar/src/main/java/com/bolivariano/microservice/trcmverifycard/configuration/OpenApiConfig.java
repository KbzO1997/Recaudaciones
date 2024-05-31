package com.bolivariano.microservice.trcmverifycard.configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

import java.util.List;

public class OpenApiConfig {
    @Value("${verificartarjeta.openapi.dev-url}")
    private String devUrl;
    @Value("${verificartarjeta.openapi.prod-url}")
    private String prodUrl;
    @Bean
    public OpenAPI myOpenAPI() {
        var devServer = new Server().url(devUrl).description("Server URL in Development environment");
        var prodServer = new Server().url(prodUrl).description("Server URL in Production environment");
        var contact = new Contact();
        contact.setEmail("");
        contact.setName("Banco Bolivariano");
        contact.setUrl("");
        var mitLicense = new License().name("MIT License").url("https://choosealicense.com/licenses/mit/");
        var info = new Info().title("Consulta Medios de Envío API").version("1.0").contact(contact)
                .description("Api de medios de pagos, orquesta la solicitud con el pan del cliente verificado si es de tarjeta debito o credito y devuelte los datos de dicho cliente.")
                .termsOfService("").license(mitLicense);
        return new OpenAPI().info(info).servers(List.of(devServer, prodServer));
    }
}
