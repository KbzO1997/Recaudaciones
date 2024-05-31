package com.bolivariano.microservice.utilitarioms.service;

import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.homologarmensaje.HomologarMensaje;
import com.bolivariano.homologarmensaje.MensajeEntradaHomologarMensaje;
import com.bolivariano.homologarmensaje.MensajeSalidaHomologarMensaje;
import com.bolivariano.mensajebolivariano.MensajeSalida;

@Service("homologarMensaje")
public class HomologarMensajeService {
	private final static Logger logger = LoggerFactory.getLogger(HomologarMensajeService.class);
	
	@Autowired
	WebServiceConfig config;
	@Value("${client.ws.address.homologarMensaje.sistema}")
	String sistema;
	
	public Object homologarMensaje(Object mensaje, Exchange exchange) {
		if(mensaje instanceof MensajeSalida) {
			MensajeSalida mensajeSalida = (MensajeSalida) mensaje;
			boolean homologar = false;
			if(exchange.getProperty("homologar") != null) {
				homologar = (boolean) exchange.getProperty("homologar");
			}
			if(exchange.getProperty("sistema") != null) {
				sistema = (String) exchange.getProperty("sistema");
			}
			if(homologar && mensajeSalida.getCodigoError() != null && !mensajeSalida.getCodigoError().equals("0")) {
				logger.debug("Homologando Mensaje");
				HomologarMensaje clienteHomologar = null;
				try {
					String codigoError = mensajeSalida.getCodigoError();
					String mensajeUsuario = mensajeSalida.getMensajeUsuario();
					logger.debug("codigoError: "+codigoError);
					logger.debug("mensajeUsuario: "+mensajeUsuario);
					clienteHomologar = config.clienteHomologarMensaje();
					MensajeEntradaHomologarMensaje mensajeEntradaHomologar = new MensajeEntradaHomologarMensaje();
					mensajeEntradaHomologar.setCodigo(codigoError);
					mensajeEntradaHomologar.setMensaje(mensajeUsuario);
					mensajeEntradaHomologar.setSistema(sistema);
					MensajeSalidaHomologarMensaje mensajeSalidaHomologar = clienteHomologar.homologarMensaje(mensajeEntradaHomologar);
					codigoError = mensajeSalidaHomologar.getCodigo();
					mensajeUsuario = mensajeSalidaHomologar.getMensaje();		
					mensajeSalida.setCodigoError(codigoError);
					mensajeSalida.setMensajeUsuario(mensajeUsuario);
					mensaje = mensajeSalida;
					logger.debug("codigoError homologado: "+codigoError);
					logger.debug("mensajeUsuario homologado: "+mensajeUsuario);
					config.returnObject(clienteHomologar);
				}catch(Exception e) {
					if(clienteHomologar!=null)config.returnObject(clienteHomologar);
					logger.error("error homologando mensaje", e);
				}
			}
		}
		return mensaje;
	}
		
}
