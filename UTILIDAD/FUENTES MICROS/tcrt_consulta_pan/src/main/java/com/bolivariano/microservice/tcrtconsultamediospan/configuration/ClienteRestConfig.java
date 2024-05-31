package com.bolivariano.microservice.tcrtconsultamediospan.configuration;

import java.net.URI;
import java.net.URL;

import javax.net.ssl.SSLContext;

import com.bolivariano.microservice.tcrtconsultamediospan.dto.ApiResponse;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.ClienteResponseData;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.ConsultaIdentificacionRequest;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.MensajeSalida;
import com.bolivariano.microservice.tcrtconsultamediospan.util.Util;
import com.bolivariano.microservice.tcrtconsultamediospan.util.enums.DictionaryResponses;
import com.bolivariano.microservice.tcrtconsultamediospan.util.exceptions.CustomException;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManagerBuilder;
import org.apache.hc.client5.http.io.HttpClientConnectionManager;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.core5.ssl.SSLContextBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Configuration
public class ClienteRestConfig {
    private static final Logger logger = LoggerFactory.getLogger(ClienteRestConfig.class);

    @Value("${api.rest.consultapan.urlApi}")
    private String urlGeneral;

    @Value("${api.rest.consultapan.metodo}")
    private String urlMetodo;

    @Value("${api.rest.codigomis.urlApi}")
    private String urlCodigoMis;

    @Value("${api.rest.codigomis.metodo}")
    private String urlMetodoCodigoMis;

    @Value("${server.ssl.key-store}")
    private String keyStore;

    @Value("${server.ssl.key-store-password}")
    private String keyStorePassword;

    @Autowired
    private Util util;

    public ApiResponse consultaIdentificacion(
            ConsultaIdentificacionRequest request) throws CustomException {

        ApiResponse respuesta = new ApiResponse();
        ObjectMapper mapper = new ObjectMapper();
        String resultado;
        try {
            var paramEntrada = mapper.writeValueAsString(request);
            logger.info("Inicio del Proceso consultaIdentificacion Parametros de Entrada: {}", paramEntrada);
            String jsonRequest = mapper.writeValueAsString(request);
            resultado = this.invocacionRestApi(HttpMethod.GET, urlGeneral+urlMetodo, jsonRequest);

            respuesta = util.convertStringToObject(resultado, ApiResponse.class);

            var paramSalida = mapper.writeValueAsString(respuesta.getResponse());
            logger.info("Fin del Proceso consultaIdentificacion Parametros de Salida: {}", paramSalida);

        } catch (Exception e) {
            logger.error("errorExc consultaIdentificacion {} ", e.getMessage());
        }
        return respuesta;
    }

    public ClienteResponseData consultaIdentificacionCodigoMis(Integer codigoMis) throws CustomException {

        ClienteResponseData respuesta = new ClienteResponseData();
        ObjectMapper mapper = new ObjectMapper();
        String resultado;
        try {
            resultado = this.invocacionRestApi(HttpMethod.GET, urlCodigoMis+urlMetodoCodigoMis+'/'+codigoMis, "");
            respuesta = util.convertStringToObject(resultado, ClienteResponseData.class);
            logger.info("consultaIdentificacionCodigoMis respuesta: {}", respuesta);
            var paramSalida = mapper.writeValueAsString(respuesta);
            logger.info("Fin del Proceso consultaIdentificacionCodigoMis Parametros de Salida: {}", paramSalida);

        } catch (Exception e) {
            logger.error("errorExc consultaIdentificacionCodigoMis {} ", e.getMessage());
        }
        return respuesta;
    }

    public String invocacionRestApi(HttpMethod httpMethod, String urlService, String bodyRequest) throws RestClientException, CustomException
    {
        URI uri = null;
        HttpEntity<Object> request = null;
        ResponseEntity<String> response = null;
        try {
            UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(urlService);
            HttpHeaders httpHeader = new HttpHeaders();
            httpHeader.setContentType(MediaType.parseMediaType("application/json;charset=UTF-8"));
            uri = builder.build().toUri();
            logger.info("URL configurada: {}", uri);
            request = new HttpEntity<>(bodyRequest, httpHeader);
            RestTemplate restTemplate = restTemplate();
            response = restTemplate.exchange(uri, httpMethod, request, String.class);
            return response.getBody();
        } catch (HttpClientErrorException e) {
            MensajeSalida salida = new MensajeSalida();
            logger.error("HttpClientErrorException mensaje: {} ", e.getMessage());
            try {
                salida = new Util().convertStringToObject(e.getResponseBodyAsString(), MensajeSalida.class);
            } catch (JsonProcessingException e1) {
                logger.info("Formato de json: {} ", e1.getMessage());
            }
            throw new CustomException(salida.getCodigoError(), salida.getMensajeUsuario(), salida.getMensajeSistema());
        } catch (RestClientException e) {
            throw new CustomException(DictionaryResponses.INTERNAL_ERROR.getCode(),DictionaryResponses.INTERNAL_ERROR.getMessage(), e.getMessage());
        }
    }

    public RestTemplate restTemplate() throws CustomException {
        try {
            SSLContext sslContext = new SSLContextBuilder()
                    .loadTrustMaterial(new URL("file:"+keyStore), keyStorePassword.toCharArray()).build();

            SSLConnectionSocketFactory socketFactory = new SSLConnectionSocketFactory(sslContext);

            HttpClientConnectionManager connectionManager = PoolingHttpClientConnectionManagerBuilder.create().setSSLSocketFactory(socketFactory).build();
            CloseableHttpClient httpClient = HttpClients.custom().setConnectionManager(connectionManager).build();
            ClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory(httpClient);

            return new RestTemplate(requestFactory);
        }catch (Exception e) {
            throw new CustomException(DictionaryResponses.INTERNAL_ERROR.getCode(),DictionaryResponses.INTERNAL_ERROR.getMessage(), e.getMessage());
        }
    }

}
