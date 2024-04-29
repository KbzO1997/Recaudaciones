/*
 * XmlConverter.java
 * 
 * Copyright (c) 2012 FARCOMED.
 * Todos los derechos reservados.
 */

package com.bolivariano.microservice.recbroadnet.utils;


import org.apache.commons.lang3.StringEscapeUtils;

import com.bolivariano.microservice.recbroadnet.exception.ConverterException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;

/**
 * Clase
 * 
 * @author
 * @revision $Revision: 1.2 $
 */
@SuppressWarnings("deprecation")
public class XmlConverter implements Converter {

	@SuppressWarnings("unchecked")
	public <T> T convertirAObjeto(final InputStream valor, final Class<T> clase)
			throws ConverterException {
		try {
			JAXBContext context = JAXBContext.newInstance(clase);
			
			XMLInputFactory xif = XMLInputFactory.newFactory();
	        xif.setProperty(XMLInputFactory.IS_SUPPORTING_EXTERNAL_ENTITIES, false);
	        xif.setProperty(XMLInputFactory.SUPPORT_DTD, false);
	        XMLStreamReader xsr = xif.createXMLStreamReader(valor);
	        
			Unmarshaller unmarshaller = context.createUnmarshaller();
			return (T) unmarshaller.unmarshal(xsr);
		} catch (JAXBException | XMLStreamException e) {
			throw new ConverterException(e);
		}
	}

	@SuppressWarnings("unchecked")
	public <T> T convertirAObjeto(final String valor, final Class<T> clase)
			throws ConverterException {
		try {
			JAXBContext context = JAXBContext.newInstance(clase);
			
			XMLInputFactory xif = XMLInputFactory.newFactory();
	        xif.setProperty(XMLInputFactory.IS_SUPPORTING_EXTERNAL_ENTITIES, false);
	        xif.setProperty(XMLInputFactory.SUPPORT_DTD, false);
	        
	        StringReader reader = new StringReader(valor);
	        XMLStreamReader xsr = xif.createXMLStreamReader(reader);
	        
			Unmarshaller unmarshaller = context.createUnmarshaller();
			return (T) unmarshaller.unmarshal(xsr);
		} catch (JAXBException | XMLStreamException e) {
			throw new ConverterException(e);
		}
	}

	@Override
	public String convertirDeObjeto(final Object o) throws ConverterException {
		try {
			final JAXBContext context = JAXBContext.newInstance(o.getClass());
			final Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, false);
			marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.TRUE);

			final StringWriter stringWriter = new StringWriter();
			marshaller.marshal(o, stringWriter);
			return stringWriter.toString();
		} catch (JAXBException e) {
			throw new ConverterException(e);
		}
	}

	@Override
	public String convertirDeObjetoFormat(final Object o)
			throws ConverterException {
		try {
			final JAXBContext context = JAXBContext.newInstance(o.getClass());
			final Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

			final StringWriter stringWriter = new StringWriter();
			marshaller.marshal(o, stringWriter);
			
			return StringEscapeUtils.unescapeXml(stringWriter.toString());
		} catch (JAXBException e) {
			throw new ConverterException(e);
		}
	}
}
