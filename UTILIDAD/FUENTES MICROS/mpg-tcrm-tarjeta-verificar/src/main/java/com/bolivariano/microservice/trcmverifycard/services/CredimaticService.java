package com.bolivariano.microservice.trcmverifycard.services;

import com.bolivariano.microservice.trcmverifycard.configuration.ClientRestConfig;
import com.bolivariano.microservice.trcmverifycard.dto.credimatic.CredimaticReq;
import com.bolivariano.microservice.trcmverifycard.dto.credimatic.CredimaticRes;
import com.bolivariano.microservice.trcmverifycard.exceptions.CustomException;
import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import com.bolivariano.microservice.trcmverifycard.utils.LogsUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.beans.factory.annotation.Autowired;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Date;

@Service
public class CredimaticService {

    private static final LogsUtils loggerUtil = LogsUtils.getLogger(CredimaticService.class);
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    private final String urlCredimatic;
    private final String token;

    @Autowired
    public CredimaticService(RestTemplate restTemplate, ObjectMapper objectMapper, @Value("${credimatic.rest.api}") String urlCredimatic, @Value("${credimatic.rest.token}") String token) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
        this.urlCredimatic = urlCredimatic;
        this.token = token;
    }

    public CredimaticRes validaCvv(CredimaticReq request) throws CustomException, JsonProcessingException {
        String jsonRequest = objectMapper.writeValueAsString(request);
        String jsonResponse = invocacionRestApi(urlCredimatic, jsonRequest);
        return objectMapper.readValue(jsonResponse, CredimaticRes.class);
    }

    private String invocacionRestApi(String urlService, String bodyRequest) throws RestClientException, CustomException {
        var startTime = new Date();
        try {
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.setContentType(MediaType.APPLICATION_JSON);
            httpHeaders.setBearerAuth(token);

            HttpEntity<String> entity = new HttpEntity<>(bodyRequest, httpHeaders);
            UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(urlService);
            URI uri = builder.build().toUri();

            ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.POST, entity, String.class);
            return response.getBody();
        } catch (HttpClientErrorException e) {
            int statusCode = e.getStatusCode().value();
            String responseBody = e.getResponseBodyAsString();

            if (statusCode == 401) {
                throw new CustomException(statusCode, "Error de autenticación", responseBody);
            } else {
                throw new CustomException(statusCode, "Error HTTP", responseBody);
            }
        } catch (RestClientException e) {
            throw new CustomException(500, "Error de tipo RestClient", e.getMessage());
        } finally {
            loggerUtil.tiempo("Credimatic WebApi", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), null, 5000 - 1000 );
        }
    }
}
