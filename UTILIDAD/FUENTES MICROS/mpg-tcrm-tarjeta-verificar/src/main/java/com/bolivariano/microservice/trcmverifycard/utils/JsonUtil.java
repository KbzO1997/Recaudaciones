package com.bolivariano.microservice.trcmverifycard.utils;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public final class JsonUtil {

    @Autowired
    ObjectMapper objectMapper;

    public <T> T convertStringToObject(String json, final Class<T> clazz)
            throws JsonProcessingException {
        return objectMapper.readValue(json, clazz);
    }

}
