/*
 * JsonConverter.java
 * 
 * Copyright (c) 2012 FARCOMED.
 * Todos los derechos reservados.
 */

package com.bolivariano.microservice.recbroadnet.utils;


import com.bolivariano.microservice.recbroadnet.exception.ConverterException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringEscapeUtils;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

/**
 * Clase
 * 
 * @author
 * @revision $Revision: 1.1 $
 */
@SuppressWarnings("deprecation")
public class JsonConverter implements Converter {

	@Override
	public <T> T convertirAObjeto(final InputStream valor, final Class<T> clase)
			throws ConverterException {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			return objectMapper.readValue(valor, clase);
		} catch (Exception e) {
			throw new ConverterException(e);
		}

	}

	@Override
	public <T> T convertirAObjeto(final String valor, final Class<T> clase)
			throws ConverterException {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			return objectMapper.readValue(valor, clase);
		} catch (Exception e) {
			throw new ConverterException(e);
		}
	}

	@Override
	public String convertirDeObjeto(final Object o) throws ConverterException {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String mensajeJson = objectMapper.writeValueAsString(o);
			if(mensajeJson != null){
				byte[] ptext = mensajeJson.getBytes(StandardCharsets.UTF_8);
				mensajeJson = new String(ptext, StandardCharsets.UTF_8);
			}

			return mensajeJson;

		} catch (Exception e) {
			throw new ConverterException(e);
		}
	}

	@Override
	public String convertirDeObjetoFormat(Object o) throws ConverterException {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String mensajeJson = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(o);
			if(mensajeJson != null){
				byte[] ptext = mensajeJson.getBytes(StandardCharsets.UTF_8);
				mensajeJson = new String(ptext, StandardCharsets.UTF_8);
			}
			return StringEscapeUtils.unescapeXml(mensajeJson);
		} catch (Exception e) {
			throw new ConverterException(e);
		}
	}

}
