package com.bolivariano.microservice.utilitarioms.service;

import java.math.BigInteger;
import java.util.Map;

import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaValidarCupo;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaValidarCupo;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.TipoPago;
import com.bolivariano.microservice.utilitarioms.dao.CuposDAO;
import com.bolivariano.utilitario.common.StopWatch;

@Service("cupoNormal")
public class CupoNormal24Online {

	private final static Logger logger = LoggerFactory.getLogger(CupoNormal24Online.class);

	@Autowired
	CuposDAO cupoDAO;
	@Autowired
	CupoPersonalizado24Online cupoPersonalizado24Online;
	 
	public MensajeSalidaValidarCupo validar(MensajeEntradaValidarCupo mensajeEntrada, Exchange exchange) {
		StopWatch elapsedTime = new StopWatch();
		int cliente = 0;
		String tipoPersona = "";
		int secuencial = 0;
		MensajeSalidaValidarCupo mensajeSalida = new MensajeSalidaValidarCupo();
		exchange.setProperty("homologar", true);
		if (!(mensajeEntrada.getIdentificacion() != null && !mensajeEntrada.getIdentificacion().isEmpty())) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar identificacion/tipoIdentificacion");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar identificacion/tipoIdentificacion");
			return mensajeSalida;
    	}else if (mensajeEntrada.getMoneda() == null && mensajeEntrada.getCodigoMoneda() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de codigoMoneda");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de codigoMoneda");
			return mensajeSalida;
    	}else if (mensajeEntrada.getCanal() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de canal");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de canal");
			return mensajeSalida;
    	}else if (mensajeEntrada.getUsuario() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de usuario");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de usuario");
			return mensajeSalida;
    	}else if (mensajeEntrada.getOficina() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de oficina");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de oficina");
			return mensajeSalida;
    	}else if (mensajeEntrada.getTipoProducto() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de tipoProducto");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de tipoProducto");
			return mensajeSalida;
    	}
		
		try {
			elapsedTime.start();
			Map<?, ?> resultEnte = cupoDAO.obtenerEnte(mensajeEntrada.getIdentificacion());
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.con_internet.pa_wap_ccon_datos_general "+elapsedTime.getElapsedTime()+"ms");
			if(resultEnte!=null && resultEnte.containsKey("s_resultado")) {
				if(resultEnte.get("s_resultado").toString().equals("0")) {
					cliente = (Integer) resultEnte.get("s_ente");
					tipoPersona = (String) resultEnte.get("s_tipo_persona");
					secuencial = (Integer) resultEnte.get("s_ssn_branch");
				}else {
					mensajeSalida.setCodigoError("1001");
					mensajeSalida.setMensajeSistema(resultEnte.get("s_mensaje").toString());
					mensajeSalida.setMensajeUsuario(resultEnte.get("s_mensaje").toString());
					return mensajeSalida;
				}
			}
		}catch(Exception e) {
			logger.error("", e);
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema("Lo sentimos por favor intentelo mas tarde");
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
			return mensajeSalida;
		}
		
		int producto = 0;
		switch(mensajeEntrada.getTipoCuentaDebito()) {
			case AHO:
				producto = 4;
				break;
			case BAS:
				break;
			case CTB:
				break;
			case CTE:
				producto = 3;
				break;
			case ESP:
				break;
			case VIR:
				producto = 12;
				break;
			default:
				break;
		}
		Integer moneda = null;
		
		if(mensajeEntrada.getCodigoMoneda() != null) {
			moneda = mensajeEntrada.getCodigoMoneda().intValue();
		}
		if(moneda == null) {
			try {
				elapsedTime.start();
				Map<?, ?> resultMoneda = cupoDAO.obtenerCodigoMoneda(mensajeEntrada.getMoneda(), null, mensajeEntrada.getCanal());
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion sybase.cobis.pa_cash_ccod_moneda "+elapsedTime.getElapsedTime()+"ms");
				if(resultMoneda!=null && resultMoneda.containsKey("s_cod_respuesta")) {
					if(resultMoneda.get("s_cod_respuesta").toString().equals("0")) {
						moneda = (Integer) resultMoneda.get("s_cod_moneda");
					}else {
						mensajeSalida.setCodigoError("1001");
						mensajeSalida.setMensajeSistema(resultMoneda.get("s_mensaje").toString());
						mensajeSalida.setMensajeUsuario(resultMoneda.get("s_mensaje").toString());
						return mensajeSalida;
					}
				}
			}catch(Exception e) {
				logger.error("", e);
				mensajeSalida.setCodigoError("9999");
				mensajeSalida.setMensajeSistema("Lo sentimos por favor intentelo mas tarde");
				mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
				return mensajeSalida;
			}
		}
		String tipo = "GEN";
		if(mensajeEntrada.getTipoPago().equals(TipoPago.OTROS_BANCOS)) {
			tipo = "SPI";
		}
		try {
			elapsedTime.start();
			Map<?, ?> resultValida =  cupoDAO.validaCupoNormal(mensajeEntrada.getIdentificacion(), mensajeEntrada.getCuentaDebito(),  mensajeEntrada.getMonto(), producto, (moneda == null ? "" : moneda.toString()), tipo);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_bvirtual.pa_wap_vcupo_normal "+elapsedTime.getElapsedTime()+"ms");
			if(resultValida.get("s_resultado") != null) {
				String mensaje = resultValida.get("s_mensaje").toString();
				Integer codigorError = ((Integer)resultValida.get("s_resultado"));
				if(codigorError != 0) {
					mensajeSalida.setCodigoError(codigorError.toString());
					mensajeSalida.setMensajeUsuario(mensaje);
					mensajeSalida.setMensajeSistema(mensaje);
					return mensajeSalida;
				}
			}
		}catch(Exception e) {
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
			mensajeSalida.setMensajeSistema(e.getMessage());
			return mensajeSalida;
		}
		mensajeSalida.setSecuenciaTransaccion(new Long(secuencial));
		mensajeSalida.setEnte(BigInteger.valueOf(cliente));
		mensajeSalida.setTipoPersona(tipoPersona);
		mensajeSalida.setCodigoError("0");
		mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
		mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
		return mensajeSalida;
	}
	
	public MensajeSalidaValidarCupo actualizar(MensajeEntradaValidarCupo mensajeEntrada, Exchange exchange) {
		exchange.setProperty("homologar", true);
		StopWatch elapsedTime = new StopWatch();
		MensajeSalidaValidarCupo mensajeSalida = new MensajeSalidaValidarCupo();
		if (!(mensajeEntrada.getIdentificacion() != null && !mensajeEntrada.getIdentificacion().isEmpty())) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar identificacion/tipoIdentificacion");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar identificacion/tipoIdentificacion");
			return mensajeSalida;
    	}else if (mensajeEntrada.getMoneda() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de moneda");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de moneda");
			return mensajeSalida;
    	}else if (mensajeEntrada.getCanal() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de canal");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de canal");
			return mensajeSalida;
    	}else if (mensajeEntrada.getUsuario() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de usuario");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de usuario");
			return mensajeSalida;
    	}else if (mensajeEntrada.getOficina() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de oficina");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de oficina");
			return mensajeSalida;
    	}else if (!(mensajeEntrada.getTipoPersona() != null && !mensajeEntrada.getTipoPersona().isEmpty())) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de tipoPersona");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de tipoPersona");
			return mensajeSalida;
    	}else if (mensajeEntrada.getTipoProducto() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de tipoProducto");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de tipoProducto");
			return mensajeSalida;
    	}else if (mensajeEntrada.getEnte() == null) {
    		mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de ente");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de ente");
			return mensajeSalida;
    	}
		
		int producto = 0;
		switch(mensajeEntrada.getTipoCuentaDebito()) {
			case AHO:
				producto = 4;
				break;
			case BAS:
				break;
			case CTB:
				break;
			case CTE:
				producto = 3;
				break;
			case ESP:
				break;
			case VIR:
				producto = 12;
				break;
			default:
				break;
		}
		Integer moneda = null;
		
		if(mensajeEntrada.getCodigoMoneda() != null) {
			moneda = mensajeEntrada.getCodigoMoneda().intValue();
		}
		if(moneda == null) {
			try {
				elapsedTime.start();
				Map<?, ?> resultMoneda = cupoDAO.obtenerCodigoMoneda(mensajeEntrada.getMoneda(), null, mensajeEntrada.getCanal());
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion sybase.cobis.pa_cash_ccod_moneda "+elapsedTime.getElapsedTime()+"ms");
				if(resultMoneda!=null && resultMoneda.containsKey("s_cod_respuesta")) {
					if(resultMoneda.get("s_cod_respuesta").toString().equals("0")) {
						moneda = (Integer) resultMoneda.get("s_cod_moneda");
					}else {
						mensajeSalida.setCodigoError("1001");
						mensajeSalida.setMensajeSistema(resultMoneda.get("s_mensaje").toString());
						mensajeSalida.setMensajeUsuario(resultMoneda.get("s_mensaje").toString());
						return mensajeSalida;
					}
				}
			}catch(Exception e) {
				logger.error("", e);
				mensajeSalida.setCodigoError("9999");
				mensajeSalida.setMensajeSistema("Lo sentimos por favor intentelo mas tarde");
				mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
				return mensajeSalida;
			}
		}
		
		String tipo = "GEN";
		if(mensajeEntrada.getTipoPago().equals(TipoPago.OTROS_BANCOS)) {
			tipo = "SPI";
		}
		try {
			elapsedTime.start();
			cupoDAO.actualizaCupoNormal(mensajeEntrada.getIdentificacion(), mensajeEntrada.getCuentaDebito(),  mensajeEntrada.getMonto(), producto, (moneda == null ? "" : moneda.toString()), tipo);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_bvirtual.pa_wap_vcupo_normal "+elapsedTime.getElapsedTime()+"ms");
		}catch(Exception e) {
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema(e.getLocalizedMessage());
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
			return mensajeSalida;
		}
		mensajeSalida.setCodigoError("0");
		mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
		mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
		return mensajeSalida;
	}
}
