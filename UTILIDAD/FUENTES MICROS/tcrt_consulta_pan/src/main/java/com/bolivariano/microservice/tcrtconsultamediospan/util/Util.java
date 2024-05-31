package com.bolivariano.microservice.tcrtconsultamediospan.util;


import java.util.Calendar;
import java.util.GregorianCalendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Component
public final class Util {

    @Autowired
    ObjectMapper objectMapper;

    public static int getHoursMin() {
        GregorianCalendar calendar = new GregorianCalendar();
        return calendar.get(Calendar.HOUR_OF_DAY) + calendar.get(Calendar.MINUTE);
    }

    public <T> T convertStringToObject(String json, final Class<T> clazz)
            throws JsonProcessingException {
        return objectMapper.readValue(json, clazz);
    }

}
