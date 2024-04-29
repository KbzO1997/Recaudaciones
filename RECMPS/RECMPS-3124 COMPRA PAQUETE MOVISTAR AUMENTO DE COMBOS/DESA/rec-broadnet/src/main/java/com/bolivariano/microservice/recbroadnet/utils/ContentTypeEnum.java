/*
 * ContentTypeEnum.java
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
public enum ContentTypeEnum {

	XML("text/xml"), JSON("application/json");

	private String tipo;

	private ContentTypeEnum(final String tipo) {
		this.tipo = tipo;
	}

	/**
	 * @return el tipo
	 */
	public String getTipo() {
		return this.tipo;
	}
}
