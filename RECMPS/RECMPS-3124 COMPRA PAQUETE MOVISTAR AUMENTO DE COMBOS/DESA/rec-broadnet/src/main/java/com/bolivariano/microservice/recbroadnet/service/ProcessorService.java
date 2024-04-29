package com.bolivariano.microservice.recbroadnet.service;

import com.bolivariano.microservice.recbroadnet.domain.TipoFlujo;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.*;
import com.bolivariano.microservice.recbroadnet.exception.BusinessException;
import com.bolivariano.microservice.recbroadnet.exception.ConverterException;
import com.bolivariano.microservice.recbroadnet.mq.MessageProducer;
import com.bolivariano.microservice.recbroadnet.utils.*;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.nio.charset.StandardCharsets;

@ApplicationScoped
public class ProcessorService {
	@Inject
	Logger log;

	@Inject
    MessageProducer mqProducer;

	@Inject
	GeneralResponse generalResponde;

	@Inject
	BroadnetService broadnetService;


	public void processMessage(String mensaje, String idCorrelacion) throws ConverterException {
		MensajeEntradaProcesar mensajeEntradaProcesar;
		MensajeSalidaProcesar mensajeSalidaProcesar;
		Converter converter = ConverterFactory.getConverter(ContentTypeEnum.JSON);

		try {
			log.info("Inicia transacción.");
			mensajeEntradaProcesar = converter.convertirAObjeto(mensaje, MensajeEntradaProcesar.class);

			if (mensajeEntradaProcesar == null) {
				throw new IllegalArgumentException("Mensaje de entrada vacio");
			}

			if (TipoFlujo.PAGO.equals(mensajeEntradaProcesar.getTipoFlujo())) {
				log.info("Inicia proceso pago");
				MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago = mensajeEntradaProcesar.getMensajeEntradaEjecutarPago();

				if (mensajeEntradaEjecutarPago == null){
					throw new BusinessException("MENSAJE EJECUTAR PAGO ES VACIO");
				}
				MensajeSalidaEjecutarPago msjSalidaEjecutarPago = this.broadnetService.ejecutarPago(mensajeEntradaEjecutarPago);

				log.info("FINALIZA CONVERSION");
				//SETEA RESPUESTA INDEPENDIENTE AL FLUJOS
				mensajeSalidaProcesar = generalResponde.generateResponse(msjSalidaEjecutarPago);


			} else if (TipoFlujo.CONSULTA.equals(mensajeEntradaProcesar.getTipoFlujo())) {
				//SETEA RESPUESTA INDEPENDIENTE AL FLUJOS
				log.info("INICIA PROCESO CONSULTA");
				MensajeEntradaConsultarDeuda mensajeEntradaConsultarDeuda = mensajeEntradaProcesar.getMensajeEntradaConsultarDeuda();

				if (mensajeEntradaConsultarDeuda == null) {
					throw new BusinessException("MENSAJE EJECUTAR CONSULTA ES VACIO");
				}

				MensajeSalidaConsultarDeuda msjSalidaConsultarDeuda = this.broadnetService.consultarDeuda(mensajeEntradaConsultarDeuda);
				mensajeSalidaProcesar = generalResponde.generateResponse(msjSalidaConsultarDeuda);

			} else if (TipoFlujo.REVERSO.equals(mensajeEntradaProcesar.getTipoFlujo())) {
				//SETEA RESPUESTA INDEPENDIENTE AL FLUJOS
				log.info("INICIA REVERSO");
				MensajeEntradaEjecutarReverso mensajeEntradaEjecutarReverso = mensajeEntradaProcesar.getMensajeEntradaEjecutarReverso();

				if (mensajeEntradaEjecutarReverso == null) {
					throw new BusinessException("MENSAJE EJECUTAR REVERSO ES VACIO");
				}

				MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago = this.broadnetService.ejecutarReverso(mensajeEntradaEjecutarReverso);
				mensajeSalidaProcesar = generalResponde.generateResponse(mensajeSalidaEjecutarPago);


			} else {
				log.error("Flujo no implementado");
				throw new IllegalArgumentException("Flujo no implementado");
			}



		} catch (Exception e) {
			log.error("Error procesar mensaje: " + e.getMessage(),e);
			mensajeSalidaProcesar = generalResponde.generateResponseError(null, "Error procesar mensaje: " + e.getMessage());
		}

		log.info("Transformación de mensaje de salida.");
		String mensajeJmsResponseUTF8 = converter.convertirDeObjeto(mensajeSalidaProcesar);
		byte[] ptext = mensajeJmsResponseUTF8.getBytes(StandardCharsets.UTF_8);
		mensajeJmsResponseUTF8 = new String(ptext, StandardCharsets.UTF_8);
		mqProducer.sendMessage(mensajeJmsResponseUTF8, idCorrelacion, false);

	}

}
