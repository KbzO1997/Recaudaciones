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
import com.bolivariano.microservice.utilitarioms.dao.CuposDAO;
import com.bolivariano.utilitario.common.StopWatch;

@Service("cupoPersonalizado")
public class CupoPersonalizado24Online {

	private final static Logger logger = LoggerFactory.getLogger(CupoPersonalizado24Online.class);

	@Autowired
	CuposDAO cupoDAO;
	@Autowired
	CupoNormal24Online cupoNormal24Online;

	public MensajeSalidaValidarCupo validar(MensajeEntradaValidarCupo mensajeEntrada, Exchange exchange) {
		int cliente = 0;
		int clienteMis = 0;
		String tipoPersona = "";
		exchange.setProperty("homologar", true);
		MensajeSalidaValidarCupo mensajeSalida = new MensajeSalidaValidarCupo();
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
		StopWatch elapsedTime = new StopWatch();
		int secuencial = 0;
		try {
			elapsedTime.start();
			Map<?, ?> resultEnte = cupoDAO.obtenerEnte(mensajeEntrada.getIdentificacion());
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.con_internet.pa_wap_ccon_datos_general "+elapsedTime.getElapsedTime()+"ms");
			if(resultEnte!=null && resultEnte.containsKey("s_resultado")) {
				if(resultEnte.get("s_resultado").toString().equals("0")) {
					cliente = (Integer) resultEnte.get("s_ente");
					clienteMis = (Integer) resultEnte.get("s_ente_mis");
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
		int transaccion = 0;
		switch(mensajeEntrada.getTipoProducto()) {
		case TARJETA_CREDITO:
				transaccion = 18988;
				break;
			case TRANSFERENCIA:
				transaccion = 18757;
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
		
		try {
			elapsedTime.start();
			Map<?, ?> resultTipoCupo = cupoDAO.obtenerTipoCupo(mensajeEntrada.getCuentaDebito(), producto, clienteMis, tipoPersona);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_internet.sp_consulta_tipo_cupo "+elapsedTime.getElapsedTime()+"ms");
			if(resultTipoCupo!=null && resultTipoCupo.containsKey("o_cupo_normal")) {
				if(resultTipoCupo.get("o_cupo_normal").toString().equals("S")) {
					mensajeSalida = cupoNormal24Online.validar(mensajeEntrada, exchange);
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
		
		try {
			elapsedTime.start();
			cupoDAO.validaCupoPersonalizado(mensajeEntrada.getIdentificacion(), mensajeEntrada.getUsuario(), cliente, secuencial, "SRV", mensajeEntrada.getOficina().intValue(), mensajeEntrada.getCuentaDebito(), mensajeEntrada.getTerminal(), transaccion, mensajeEntrada.getMonto(), producto, moneda.toString() , tipoPersona);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_bvirtual.sp_chequea_cuenta_bv_new "+elapsedTime.getElapsedTime()+"ms");			
		}catch(Exception e) {
			if(e.getCause().getMessage().contains("1850036")) {
				mensajeSalida.setCodigoError("2003");
				mensajeSalida.setMensajeSistema(e.getCause().getMessage());
				mensajeSalida.setMensajeUsuario("No existe cupo asociado a esa transaccion");
				logger.error("error ejecutando sp ", e);
				return mensajeSalida;
			}else if(e.getCause().getMessage().contains("1850291")) {
				mensajeSalida.setCodigoError("2000");
				mensajeSalida.setMensajeSistema(e.getCause().getMessage());
				mensajeSalida.setMensajeUsuario("Valor excede al cupo disponible");
				logger.error("error ejecutando sp ", e);
				return mensajeSalida;
			}else if(e.getCause().getMessage().contains("String or binary data would be truncated")) {
				try {
					elapsedTime.start();
					cupoDAO.validaCupoPersonalizado(mensajeEntrada.getIdentificacion(), mensajeEntrada.getUsuario(), cliente, secuencial, "SRV", mensajeEntrada.getOficina().intValue(), mensajeEntrada.getCuentaDebito(), mensajeEntrada.getTerminal(), transaccion, mensajeEntrada.getMonto(), producto, moneda.toString() , tipoPersona);
					elapsedTime.stop();
					logger.debug("tiempo de ejecucion storebb.cob_bvirtual.sp_chequea_cuenta_bv_new "+elapsedTime.getElapsedTime()+"ms");			
				}catch(Exception e1) {
					if(e1.getCause().getMessage().contains("1850036")) {
						mensajeSalida.setCodigoError("2003");
						mensajeSalida.setMensajeSistema(e1.getCause().getMessage());
						mensajeSalida.setMensajeUsuario("No existe cupo asociado a esa transaccion");
						logger.error("error ejecutando sp ", e1);
						return mensajeSalida;
					}else if(e1.getCause().getMessage().contains("1850291")) {
						mensajeSalida.setCodigoError("2000");
						mensajeSalida.setMensajeSistema(e1.getCause().getMessage());
						mensajeSalida.setMensajeUsuario("Valor excede al cupo disponible");
						logger.error("error ejecutando sp ", e1);
						return mensajeSalida;
					}
					logger.error("error ejecutando sp ", e1);
				}
			}
				
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
		StopWatch elapsedTime = new StopWatch();
		exchange.setProperty("homologar", true);
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
		
		int clienteMis = 0;
		String tipoPersona = "";
		try {
			elapsedTime.start();
			Map<?, ?> resultEnte = cupoDAO.obtenerEnte(mensajeEntrada.getIdentificacion());
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.con_internet.pa_wap_ccon_datos_general "+elapsedTime.getElapsedTime()+"ms");
			if(resultEnte!=null && resultEnte.containsKey("s_resultado")) {
				if(resultEnte.get("s_resultado").toString().equals("0")) {
					clienteMis = (Integer) resultEnte.get("s_ente_mis");
					tipoPersona = (String) resultEnte.get("s_tipo_persona");
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
		
		try {
			elapsedTime.start();
			Map<?, ?> resultTipoCupo = cupoDAO.obtenerTipoCupo(mensajeEntrada.getCuentaDebito(), producto, clienteMis, tipoPersona);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_internet.sp_consulta_tipo_cupo "+elapsedTime.getElapsedTime()+"ms");
			if(resultTipoCupo!=null && resultTipoCupo.containsKey("o_cupo_normal")) {
				if(resultTipoCupo.get("o_cupo_normal").toString().equals("S")) {
					mensajeSalida = cupoNormal24Online.actualizar(mensajeEntrada, exchange);
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
		
		int transaccion = 0;
		switch(mensajeEntrada.getTipoProducto()) {
			case TARJETA_CREDITO:
				transaccion = 18988;
				break;
			case TRANSFERENCIA:
				transaccion = 18757;
				break;
		}
		
		try {
			elapsedTime.start();
			cupoDAO.actualizaCupoPersonalizado(mensajeEntrada.getIdentificacion(), mensajeEntrada.getUsuario(), mensajeEntrada.getEnte().intValue(), Integer.parseInt(mensajeEntrada.getSecuencial()), "SRV", mensajeEntrada.getOficina().intValue(), mensajeEntrada.getCuentaDebito(), mensajeEntrada.getTerminal(), transaccion , mensajeEntrada.getMonto(), producto, (moneda == null ? "" : moneda.toString()), mensajeEntrada.getTipoPersona());
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion storebb.cob_bvirtual.sp_saldo_diario_new "+elapsedTime.getElapsedTime()+"ms");
		}catch(Exception e) {
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema(e.getCause().getMessage());
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor intentelo mas tarde");
			return mensajeSalida;
		}
		mensajeSalida.setCodigoError("0");
		mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
		mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
		return mensajeSalida;
	}
}
