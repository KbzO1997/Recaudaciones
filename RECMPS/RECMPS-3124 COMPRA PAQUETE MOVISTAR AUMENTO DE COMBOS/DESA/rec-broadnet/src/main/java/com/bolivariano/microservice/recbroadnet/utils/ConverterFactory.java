/*
 * ConverterFactory.java
 * 
 * Copyright (c) 2012 FARCOMED.
 * Todos los derechos reservados.
 */

package com.bolivariano.microservice.recbroadnet.utils;

/**
 * Clase
 * 
 * @author
 * @revision $Revision: 1.1 $
 */
public class ConverterFactory {
	private ConverterFactory() {
	}

	public static Converter getConverter(final ContentTypeEnum tipo) {
		switch (tipo) {
		case XML:
			return new XmlConverter();
		case JSON:
			return new JsonConverter();
		default:
			throw new IllegalArgumentException(
					"No existe un convertidor para: " + tipo);
		}
	}

	
}
