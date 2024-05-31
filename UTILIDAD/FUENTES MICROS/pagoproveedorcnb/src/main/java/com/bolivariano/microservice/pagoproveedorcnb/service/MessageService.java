package com.bolivariano.microservice.pagoproveedorcnb.service;

import java.io.StringReader;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.lang3.StringEscapeUtils;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.pagoproveedorcnb.bean.CollectorRequest;
import com.bolivariano.microservice.pagoproveedorcnb.bean.MessageResponse;
import com.bolivariano.microservice.pagoproveedorcnb.bean.MicroSreResponse;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector.Dato;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector.Datos;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector.MensajeEntradaCollector;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector.MensajeSalidaCollector;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajeosb.MensajeEntradaGateway;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajeosb.MensajeSalidaGateway;
import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;

@SuppressWarnings("deprecation")
@ApplicationScoped
public class MessageService {

	@Inject
	Logger log;

	@Inject
	MessageSenderService senderService;

	@Inject
	ExecutorService microsreEngine;
	
	private static final String ERROR = "ERROR";
	private static final String ERROR_PROCESAR_MENSAJE = "ERROR AL PROCESAR MENSAJE: ";

	public void processMessage(String mensajeJMS, final String userId) {

		MessageResponse microsreResponse;
		MicroSreResponse messageResponseGateway = new MicroSreResponse();
		MensajeSalidaCollector mensajeSalidaCollector = new MensajeSalidaCollector();

		messageResponseGateway.setCode("0");
		messageResponseGateway.setMessage("Transaction Successfuly");
		messageResponseGateway.setStatus("OK");

		try {
			MensajeEntradaCollector mensajeEntradaCollector = processInputMessage(mensajeJMS);
			CollectorRequest collectorRequest = new CollectorRequest();
			collectorRequest.setOpcion(mensajeEntradaCollector.getOpcion());
			putCollectorData(mensajeEntradaCollector, collectorRequest);
		
			microsreResponse = microsreEngine.executeTransaction(collectorRequest);

			if (microsreResponse == null) {
				throw new CollectorException("Respuesta SRE NULL");
			}

			messageResponseGateway.setData(microsreResponse);

			if (!"0".equals(microsreResponse.getCodeSPError())) {
				mensajeSalidaCollector.setMensaje("ERROR AL PROCESAR SP");
				mensajeSalidaCollector.setCoding(microsreResponse.getCodeSPError());
				mensajeSalidaCollector.setEstado(ERROR);

			} else {
				mensajeSalidaCollector.setMensaje("Transaction Successfuly");
				mensajeSalidaCollector.setCoding("0");
				mensajeSalidaCollector.setEstado("OK");

			}

		} catch (Exception e) {
			log.error(ERROR_PROCESAR_MENSAJE + e.getMessage(), e);
			messageResponseGateway.setCode("0");
			messageResponseGateway.setStatus(ERROR);
			messageResponseGateway.setMessage(ERROR_PROCESAR_MENSAJE + e.getMessage());

			mensajeSalidaCollector.setMensaje(ERROR_PROCESAR_MENSAJE + e.getMessage());
			mensajeSalidaCollector.setCoding("96");
			mensajeSalidaCollector.setEstado(ERROR);
		}
		try {

			log.info("GATEWAY MENSAJE-- > " + messageResponseGateway.getMessage());
			log.info("GATEWAY CODE-- > " + messageResponseGateway.getCode());
			log.info("GATEWAY ESTADO-- > " + messageResponseGateway.getStatus());

			// TRANFORMACION FINAL DE DATOS
			if (messageResponseGateway.getData() != null) {

				log.info("COLLECTOR MENSAJE-- >" + mensajeSalidaCollector.getMensaje());
				log.info("COLLECTOR CODE-- >" + mensajeSalidaCollector.getCoding());
				log.info("COLLECTOR ESTADO-- >" + mensajeSalidaCollector.getEstado());

				MessageResponse respuestaTemp = (MessageResponse) messageResponseGateway.getData();

				mensajeSalidaCollector.setCorrelacion(respuestaTemp.getCorrelationId());

				if (respuestaTemp.getExecutionDate() != null) {
					GregorianCalendar gregorianCalendar = new GregorianCalendar();
					gregorianCalendar.setTime(respuestaTemp.getExecutionDate());
					mensajeSalidaCollector.setFechaEjecucion(
							DatatypeFactory.newInstance().newXMLGregorianCalendar(gregorianCalendar));
				}

				mensajeSalidaCollector.setDatos(new Datos());
				log.info("RESULTADO -- >" + respuestaTemp.getResult());
				iterateResult(respuestaTemp, mensajeSalidaCollector);

			}

			String mensajeJmsResponseUTF8 = this.processOutputMessage(mensajeSalidaCollector, messageResponseGateway);
			senderService.sendMessage(mensajeJmsResponseUTF8, userId, false);

		} catch (Exception e) {
			log.error("ERROR AL PROCESAR MENSAJE", e);
		}

	}

	private MensajeEntradaCollector processInputMessage(String mensajeJMS)
			throws JAXBException, CollectorException, XMLStreamException {
		JAXBContext jaxbContext = JAXBContext.newInstance(MensajeEntradaGateway.class);
		Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
		XMLStreamReader xsr = null;
		MensajeEntradaGateway mensajeEntradaGateway = null;
		
		XMLInputFactory xif = XMLInputFactory.newFactory();
		xif.setProperty(XMLInputFactory.IS_SUPPORTING_EXTERNAL_ENTITIES, false);
		xif.setProperty(XMLInputFactory.SUPPORT_DTD, false);

		try {
			xsr = xif.createXMLStreamReader(new StringReader(mensajeJMS));
			mensajeEntradaGateway = (MensajeEntradaGateway) jaxbUnmarshaller.unmarshal(xsr);
		} catch (Exception e) {
			throw new XMLStreamException();
		} finally {
			if (xsr != null) {
				xsr.close();
			}
		}


		String mensajeEntradaCollectorXML = mensajeEntradaGateway.getMensaje().replace("<![CDATA[", "").replace("]]>",
				"");
		jaxbContext = JAXBContext.newInstance(MensajeEntradaCollector.class);
		Unmarshaller jaxbUnmarshallerCollector = jaxbContext.createUnmarshaller();
		Source xmlCollector = new StreamSource(new StringReader(mensajeEntradaCollectorXML));
		MensajeEntradaCollector mensajeEntradaCollector = (MensajeEntradaCollector) jaxbUnmarshallerCollector
				.unmarshal(xmlCollector);
		if (mensajeEntradaCollector == null) {
			throw new CollectorException("Mensaje de entrada vacio");
		}
		log.info("mensaje collector XML --> " + mensajeEntradaCollectorXML);
		return mensajeEntradaCollector;
	}

	private String processOutputMessage(MensajeSalidaCollector mensajeSalidaCollector, MicroSreResponse messageResponse)
			throws JAXBException {
		StringWriter mensajeSalidaCollectorWrite = new StringWriter();
		JAXBContext jaxbContext = JAXBContext.newInstance(MensajeSalidaCollector.class);
		Marshaller jaxbMarshallerCollectoe = jaxbContext.createMarshaller();
		jaxbMarshallerCollectoe.marshal(mensajeSalidaCollector, mensajeSalidaCollectorWrite);

		String mensajeSalidaCollectorXML = mensajeSalidaCollectorWrite.toString();

		byte[] ptextCollector = mensajeSalidaCollectorXML.getBytes(StandardCharsets.UTF_8);
		mensajeSalidaCollectorXML = new String(ptextCollector, StandardCharsets.UTF_8);

		StringBuilder mensajeRespuestaJSON = new StringBuilder();
		mensajeRespuestaJSON.append("<![CDATA[");
		mensajeRespuestaJSON.append(mensajeSalidaCollectorXML);
		mensajeRespuestaJSON.append("]]>");

		MensajeSalidaGateway mensajeSalidaGateway = new MensajeSalidaGateway();
		mensajeSalidaGateway.setMensaje(mensajeRespuestaJSON.toString());
		mensajeSalidaGateway.setCodigo(messageResponse.getCode());
		mensajeSalidaGateway.setEstado(messageResponse.getStatus());
		mensajeSalidaGateway.setMensajeUsuario(messageResponse.getMessage());

		StringWriter mensajeJmsResponseWrite = new StringWriter();
		jaxbContext = JAXBContext.newInstance(MensajeSalidaGateway.class);
		Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		jaxbMarshaller.marshal(mensajeSalidaGateway, mensajeJmsResponseWrite);

		String mensajeJmsResponseUTF8 = mensajeJmsResponseWrite.toString();

		byte[] ptext = mensajeJmsResponseUTF8.getBytes(StandardCharsets.UTF_8);
		mensajeJmsResponseUTF8 = new String(ptext, StandardCharsets.UTF_8);
		mensajeJmsResponseUTF8 = StringEscapeUtils.unescapeXml(mensajeJmsResponseUTF8);

		return mensajeJmsResponseUTF8;
	}

	private void putCollectorData(MensajeEntradaCollector mensajeEntradaCollector, CollectorRequest collectorRequest) {
		if (mensajeEntradaCollector.getDatos() != null && !mensajeEntradaCollector.getDatos().getDato().isEmpty()) {
			collectorRequest.setDatos(new HashMap<>());
			log.debug("DATOS collector XML --> ");
			for (Dato dato : mensajeEntradaCollector.getDatos().getDato()) {
				log.debug("codigo--> " + dato.getCodigo());
				log.debug("valor --> " + dato.getValor());
				collectorRequest.getDatos().put(dato.getCodigo(), dato.getValor());
			}
		}

	}

	private String processSingleValues(Object valor) {

		if (valor != null) {
			String clazz = valor.getClass().getName();
			log.info("clazz --> " + clazz);
			switch (clazz) {
			case "java.lang.String":
				return valor.toString();
			case "java.lang.Double":
				return ((Double) valor).toString();
			case "java.lang.Float":
				return ((Float) valor).toString();
			case "java.math.BigDecimal":
				return ((BigDecimal) valor).toString();
			case "java.util.Date":
				String pattern = "dd/MM/yyyy";
				DateFormat df = new SimpleDateFormat(pattern);
				return df.format((Date) valor);
			default:
				break;

			}
		}
		return null;
	}

	private void processMultiValue(Object valor, Dato datoTemp) {
		String valorStr = null;
		if (valor != null) {
			valorStr = valor.toString();
			if (valorStr != null && !valorStr.isEmpty()) {
				Dato.Multivalor multivalor = new Dato.Multivalor();
				String[] valores = valorStr.split(";");
				log.debug("valores -- >" + valores);

				for (String multivalores : valores) {
					multivalor.getValor().add(multivalores);
				}
				datoTemp.setMultivalor(multivalor);
			}
		}
	}

	private void iterateResult(MessageResponse respuestaTemp, MensajeSalidaCollector mensajeSalidaCollector) {
		if (respuestaTemp.getResult() != null && !respuestaTemp.getResult().isEmpty()) {
			Dato datoTemp = null;
			Object valor = null;
			String valorStr = null;

			for (Map.Entry<String, Object> entry : respuestaTemp.getResult().entrySet()) {
				datoTemp = new Dato();
				datoTemp.setCodigo(entry.getKey());
				valor = entry.getValue();

				log.debug("CODIGO -- >" + entry.getKey());
				log.debug("VALOR -- >" + entry.getValue());

				if (entry.getKey().contains("resultCLT")) {
					datoTemp.setCodigo("result");
					this.processMultiValue(valor, datoTemp);

				} else {
					valorStr = this.processSingleValues(valor);
				}

				datoTemp.setValor(valorStr);
				mensajeSalidaCollector.getDatos().getDato().add(datoTemp);
			}
		}
	}

}
