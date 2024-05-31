package com.bolivariano.microservice.utilitarioms.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaConsultarParametroCore;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaConsultarParametroCore;
import com.bolivariano.microservice.utilitarioms.dao.CuposDAO;
import com.bolivariano.utilitario.common.StopWatch;
import com.bolivariano.utilitario.common.Utils;

@Service("consultarParametroCoreService")		  
public class ConsultarParametroCore {
	private final static Logger logger = LoggerFactory.getLogger(ConsultarParametroCore.class);
 
	@Autowired
    private CuposDAO cupoDAO;	
	
	@SuppressWarnings("unchecked")
	public MensajeSalidaConsultarParametroCore consultarParametroCore(MensajeEntradaConsultarParametroCore mensajeEntrada, Exchange exchange){
		MensajeSalidaConsultarParametroCore mensajeSalida = new MensajeSalidaConsultarParametroCore();
		StopWatch elapsedTime = new StopWatch();
		try {			
			elapsedTime.start();
			logger.debug("****Inicia consulta parametro core****");
			Map<?, ?> resultado = cupoDAO.obtenerParametroCore(mensajeEntrada.getNemonico(), mensajeEntrada.getTipo(), mensajeEntrada.getProducto());
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion sybase.cob_internet.pa_wap_cparametros_cobis " + elapsedTime.getElapsedTime()+"ms");
			if(resultado!=null && resultado.containsKey("s_retorno")) {
				if(resultado.get("s_retorno").toString().equals("0")) {					
					mensajeSalida.setCodigoError("0");
					mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
					mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
					List<Map<?, ?>> parametros = (List<Map<?, ?>>) resultado.get("#result-set-1");					
					String parametro = parametros.get(0).get("valor_parametro").toString();
					if("D".equals(mensajeEntrada.getTipo())){
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");						
						Date fecha = formatter.parse(parametro.replaceAll("\\/", "-"));
						parametro = Utils.fechaAXMLGregorianCalendar(fecha).toString();	
					}					
					mensajeSalida.setValorParametro(parametro);
				}else {
					mensajeSalida.setCodigoError("1001");
					mensajeSalida.setMensajeSistema("Lo sentimos por favor inténtelo mas tarde");
					mensajeSalida.setMensajeUsuario("Error al consultar parametro core");
					mensajeSalida.setValorParametro("0.00");
				}
			}
		}catch(Exception e) {
			logger.error("", e);
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema("Lo sentimos por favor intentelo mas tarde");
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
			return mensajeSalida;
		}
		
		return mensajeSalida;	
	}		
}
