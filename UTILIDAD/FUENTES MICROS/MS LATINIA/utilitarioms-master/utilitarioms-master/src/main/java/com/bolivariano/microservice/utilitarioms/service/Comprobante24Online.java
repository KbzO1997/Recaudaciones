package com.bolivariano.microservice.utilitarioms.service;

import java.util.HashMap;
import java.util.Map;
import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaRegistrarComprobante;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaRegistrarComprobante;
import com.bolivariano.filagenerica.FilaGenerica;
import com.bolivariano.microservice.utilitarioms.dao.ComprobanteDAO;
import com.bolivariano.utilitario.common.StopWatch;

@Service("comprobante24Online")
public class Comprobante24Online {
	private final static Logger logger = LoggerFactory.getLogger(Comprobante24Online.class);
	
	@Value("${24Online.comprobante.servicio}")
    private int servicio24Online;
	@Value("${24Online.comprobante.estado}")
    private String estado24Online;
	@Value("${24Online.comprobante.operacion}")
    private String operacion24Online;
	
	@Autowired
    private ComprobanteDAO comprobanteDAO;
	
	public MensajeSalidaRegistrarComprobante registrar(MensajeEntradaRegistrarComprobante mensajeEntrada, Exchange exchange){
		MensajeSalidaRegistrarComprobante mensajeSalida = new MensajeSalidaRegistrarComprobante();
		StopWatch elapsedTime = new StopWatch();
        exchange.setProperty("homologar", true);
	    try {
	    	
	    	if (mensajeEntrada.getCliente() == null || mensajeEntrada.getCliente().getIdentificaciones() == null ||
	    		mensajeEntrada.getCliente().getIdentificaciones().isEmpty()) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar identificacion/tipoIdentificacion");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar identificacion/tipoIdentificacion");
				return mensajeSalida;
	    	}else if (mensajeEntrada.getDatosComprobante() == null || mensajeEntrada.getDatosComprobante().getDato() == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante");
				return mensajeSalida;
	    	}else if (mensajeEntrada.isTransaccionMonetaria() == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere indicar si es transaccion moneteria");
				mensajeSalida.setMensajeUsuario("Se requiere indicar si es transaccion moneteria");
				return mensajeSalida;
	    	}
	    	
	    	Map<String, Object> inParams= new HashMap<>();	    		    
	    	
	    	for (FilaGenerica dato : mensajeEntrada.getDatosComprobante().getDato()) 
				inParams.put(dato.getCodigo(), dato.getValor());
	    	
	    	if(inParams.get("servicio") == null)
	    		inParams.put("servicio", servicio24Online);
	    	if(inParams.get("operacion") == null)
	    		inParams.put("operacion", operacion24Online);
	    	if(inParams.get("estado") == null)
	    		inParams.put("estado", estado24Online);
	    	if(inParams.get("trn") == null)
	    		inParams.put("trn", mensajeEntrada.getTransaccion());

	    	if(mensajeEntrada.getSecuencial() != null) {
	    		String secuencial= mensajeEntrada.getSecuencial();
	    		Integer secuencialEntero= null;
	    		if(secuencial.length() > 8)
	    			secuencial= secuencial.substring(secuencial.length() - 8);
	    		try {
	    			secuencialEntero= Integer.parseInt(secuencial);
	    			if(inParams.get("referencia") == null)
			    		inParams.put("referencia", secuencialEntero);
			    	if(inParams.get("secLog") == null)
			    		inParams.put("secLog", secuencialEntero);
	    		}catch (Exception e) {
					// TODO: handle exception
	    			logger.error("Error al convertir secuencial a entero " + secuencial + " - registrarComprobante 24Online");
				}
	    	}
	    	
	    	if(inParams.get("ente") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: ente");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: ente");
				return mensajeSalida;
	    	}else if(inParams.get("fecha") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: fecha");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: fecha");
				return mensajeSalida;
	    	}else if(inParams.get("tipo") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: tipo");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: tipo");
				return mensajeSalida;
	    	}else if(inParams.get("codigo") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: codigo");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: codigo");
				return mensajeSalida;
	    	}else if(inParams.get("valor") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: valor");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: valor");
				return mensajeSalida;
	    	}else if(inParams.get("fechaPago") == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante: fechaPago");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante: fechaPago");
				return mensajeSalida;
	    	}
	    	
	    	if(mensajeEntrada.isTransaccionMonetaria()) {
	    		elapsedTime.start();	    		
	    		comprobanteDAO.registrarComprobante(inParams);
	    		elapsedTime.stop();
				logger.debug("tiempo de ejecucion comprobanteDAO.registrarComprobante: " + elapsedTime.getElapsedTime() + "ms");
	    	}
	    	else {
	    		elapsedTime.start();
	    		comprobanteDAO.registrarComprobanteNoMon(inParams);	    		
	    		elapsedTime.stop();
	    		logger.debug("tiempo de ejecucion comprobanteDAO.registrarComprobanteNoMon: " + elapsedTime.getElapsedTime() + "ms");
	    	}	    
			mensajeSalida.setCodigoError("0");
			mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
			mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
			
	    }catch (Exception e) {
	    	logger.error("Error al registrar compobante en 24Online", e);
	    	mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema("Lo sentimos por favor inténtelo luego");
			mensajeSalida.setMensajeUsuario(e.getMessage());
		}
	    
		return mensajeSalida;	
	}
}
