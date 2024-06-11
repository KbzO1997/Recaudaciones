package com.bolivariano.microservice.otp.service;

import org.datacontract.schemas._2004._07.serviciootp.RespuestaGeneracion;
import org.datacontract.schemas._2004._07.serviciootp.RespuestaValidacion;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeResponse;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.constant.Enums;

import bolivariano.fin.ec.wsentrust.service.EntrustServicePortType;
import bolivariano.fin.ec.wsentrust.service.RespuestaOTP;
import bolivariano.fin.ec.wsentrust.service.RespuestaUserGet;
import ec.com.bolivariano.otp.manager.OTPManager;

@Service
public class OTPServiceEntrust {

	private static final Logger LOG = LoggerFactory.getLogger(OTPServiceEntrust.class);

	@Autowired
	private WebServiceConfig webServiceConfig;

	/* Mensajes Validar OTP */
	@Value("${mensaje.otpservice.validar.ok}")
	private String mensajeValidarOK;

	@Value("${mensaje.otpservice.validar.error}")
	private String mensajeValidarError;

	public String obtenerCodigoOTPEntrust(String proceso, String identificacionCliente) throws OTPException {
		String codigoOTP = null;
		boolean existeUsuarioEntrust = validarUsuarioEntrust(proceso, identificacionCliente);
		/* Si existe usuario */
		if (existeUsuarioEntrust) {
			codigoOTP = consumirServicioEntrust(proceso, identificacionCliente);
			return codigoOTP;
		}
		/* Si no existe usuario Entrust ir por Bayted */
		else {
			
			codigoOTP = consumirServicioBayted(proceso, identificacionCliente, "CNB", "CNB", 10000L);
			return codigoOTP;
		}

	}

	public ValidarOTPMensajeResponse validarCodigoOTPEntrust(String proceso, ValidarOTPMensajeRequest request) {	
		ValidarOTPMensajeResponse mensaje = null;		
		String identificacionCliente = request.getIdentificacionCliente();
		boolean existeUsuarioEntrust = validarUsuarioEntrust(proceso, identificacionCliente);
		/* Si existe usuario */
		if (existeUsuarioEntrust) {
			mensaje = validarOTPCliente(proceso, request);
			return mensaje;
		}else {
			/* Si no existe usuario Entrust ir por Bayted */
			mensaje = validarOTPNoCliente(proceso, request);
			return mensaje;	
		}
	}

	/* Servicio Entrust */
	public String consumirServicioEntrust(String proceso, String identificacionCliente) throws OTPException {
		String codigoOTP = null;
		EntrustServicePortType entrustService = null;
		try {
			entrustService = webServiceConfig.clienteEntrustUtil(proceso);

			if (entrustService == null) {
				throw new OTPException("No existe servicio Entrust disponible.");
			}

			RespuestaOTP respuestaOtp = entrustService.getOTP(identificacionCliente);

			if (respuestaOtp == null) {
				throw new OTPException("No existe respuesta del servicio Entrust getOTP.");
			}

			LOG.info("Identificacion cliente: {}", identificacionCliente);
			LOG.info("Codigo respuesta servicio Entrust getOTP: {}", respuestaOtp.getCodigoRespuesta());
			LOG.info("Mensaje respuesta servicio Entrust getOTP: {}", respuestaOtp.getMensajeSistema());

			codigoOTP = respuestaOtp.getOtp();

			if (respuestaOtp.getCodigoRespuesta() != 0) {
				throw new OTPException(respuestaOtp.getMensajeUsuario(), respuestaOtp.getCodigoRespuesta(), respuestaOtp.getMensajeSistema());
			}
			
		} catch (OTPException e) {
			LOG.error("Error al invocar servicio Entrust: {}", e.getMessage());
			throw new OTPException(e.getMessage(), e.getCodigoError(), e.getMensajeSistema());
		} catch (Exception e) {
			LOG.error("Error al invocar servicio Entrust: {}", e);
			codigoOTP = null;
		} finally {
			/* Se retorna objeto servicio */
			webServiceConfig.returnObject(entrustService);
		}
		
		return codigoOTP;
	}

	/* Servicio Bayted */
	public String consumirServicioBayted(String proceso, String identificacionCliente, String tipoTransaccion,
			String aplicacion, Long timestamp) {
		String codigoOTP = null;
		OTPManager otpManager = null;
		try {

			otpManager = webServiceConfig.clientebayted(proceso);			
			if (otpManager == null) {
				throw new OTPException(Enums.BYTED_DOWN);
			}

			RespuestaGeneracion resGeneracion = otpManager.generarOTP(identificacionCliente, tipoTransaccion,
					aplicacion, timestamp);

			if (resGeneracion == null) {
				throw new OTPException("No existe respuesta del servicio Bayted generarOTP.");
			}
			LOG.info("Identificacion para generar OTP: {}", identificacionCliente);
			LOG.info("Codigo de respuesta servicio Bayted generarOTP: {}", resGeneracion.getCodigoRespuesta().toString());
			LOG.info("Mensaje de respuesta servicio Bayted generarOTP: {}", resGeneracion.getDescripcionRespuesta().toString());
			
			codigoOTP = resGeneracion.getOTP().getValue();

			if (resGeneracion.getCodigoRespuesta() != 0) {
				throw new OTPException(resGeneracion.getDescripcionRespuesta().getValue());
			}
		} catch (OTPException e) {
			LOG.error("Error al conectar al servicio Bayted: {}", e.getMessage());
		} catch (Exception ex) {
			LOG.error("Error al conectar al servicio Bayted: {} ", ex);
			codigoOTP = null;
		} finally {
			webServiceConfig.returnObject(otpManager);
		}
		return codigoOTP;
	}

	/* Valdiar si existe usuario en Entrust */
	private boolean validarUsuarioEntrust(String proceso, String identificacionCliente) {
		EntrustServicePortType entrustService = null;
		boolean existeUsuario = false;
		try {
			entrustService = webServiceConfig.clienteEntrustUtil(proceso);

			if (entrustService == null) {				
				throw new OTPException("No existe servicio Entrust disponible.");
			}

			RespuestaUserGet respuestaGet = entrustService.userGet(identificacionCliente);

			if (respuestaGet == null) {
				throw new OTPException("No existe respuesta del servicio Entrust userGet.");
			}

			LOG.info("Identificacion: {}", identificacionCliente);
			LOG.info("Codigo respuesta userGet: {}", respuestaGet.getCodigoRespuesta());
			LOG.info("Mensaje respuesta userGet: {}", respuestaGet.getMensajeSistema());

			if (respuestaGet.getCodigoRespuesta() != 0) {
				throw new OTPException(respuestaGet.getMensajeSistema());
			}
			
			if(respuestaGet.getAuthenticacionMethods().getMethod().isEmpty()) {
				throw new OTPException("No tiene asignado dispositivo");
			}

			existeUsuario = true;
		} catch (OTPException e) {
			LOG.error("Error al consumir servicio getUser: {}", e.getMessage());
		} catch (Exception e) {
			LOG.error("Error al consumir servicio getUser {}", e);
			return false;
		} finally {
			webServiceConfig.returnObject(entrustService);
		}

		return existeUsuario;
	}

	/*------------------------VALIDAR OTP NO CLIENTE-------------------------------------------------*/
	public ValidarOTPMensajeResponse validarOTPNoCliente(String proceso, ValidarOTPMensajeRequest request) {
		String otp = request.getOtp();
		String identificacionCliente = request.getIdentificacionCliente();		
		boolean validacionExitosa = false;		
		OTPManager otpManager = null;
		
		
		try {			
			
			otpManager = webServiceConfig.clientebayted(proceso);

			if (otpManager == null) {
				throw new OTPException(Enums.BYTED_DOWN);
			}

			RespuestaValidacion respuestaOtp = otpManager.validarOTP(identificacionCliente, "CNB", "CNB", 10000L, otp);

			if (respuestaOtp == null) {
				throw new OTPException("No existe respuesta del servicio Bayted validar OTP.");
			}
			
			
			LOG.info("Identificacion a validar: {}", identificacionCliente);
			LOG.info("Codigo respuesta servicio Bayted validarOTP {}", respuestaOtp.getCodigoRespuesta().toString());
			LOG.info("Mensaje respuesta servicio Bayted validarOTP {}", respuestaOtp.getDescripcionRespuesta().getValue().toString());

			if (respuestaOtp.getCodigoRespuesta() != 0) {
				throw new OTPException(respuestaOtp.getDescripcionRespuesta().getValue().toString(), respuestaOtp.getCodigoRespuesta(), respuestaOtp.getDescripcionRespuesta().getValue().toString());
			}

			validacionExitosa = true;
		} catch (OTPException e) {
			LOG.error("Error al consumir servicio Bayted {}", e.getMessage());
			return OTPException.mensajeValidarOTP(e.getCodigoError(), mensajeValidarError, e.getMensajeSistema());
		} catch (Exception e) {
			LOG.error("Error al consumir servicio Bayted {}", e);
		} finally {
			webServiceConfig.returnObject(otpManager);
		}
		return validacionExitosa ? OTPException.mensajeValidarOTP(0, mensajeValidarOK, null)
				: OTPException.mensajeValidarOTP(404, mensajeValidarError, null);
	}

	/*------------------------VALIDAR OTP CLIENTE-------------------------------------------------*/
	public ValidarOTPMensajeResponse validarOTPCliente(String proceso, ValidarOTPMensajeRequest request) {
		String otp = request.getOtp();
		String identificacionCliente = request.getIdentificacionCliente();
		boolean validacionExitosa = false;
		EntrustServicePortType entrustService = null;
		try {
			entrustService = webServiceConfig.clienteEntrustUtil(proceso);

			if (entrustService == null) {
				throw new OTPException("No existe servicio de Entrust disponible.");
			}

			RespuestaOTP respuestaOtp = entrustService.validateOTP(otp, identificacionCliente);

			if (respuestaOtp == null) {
				throw new OTPException("No existe respuesta del servicio Entrust validarOTP.");
			}

			LOG.info("Identificacion cliente: {}", identificacionCliente);
			LOG.info("Codigo respuesta servicio Entrust validarOTP: {}", respuestaOtp.getCodigoRespuesta());
			LOG.info("Mensaje respuesta servicio Entrust validarOTP: {}", respuestaOtp.getMensajeSistema().toString());

			if (respuestaOtp.getCodigoRespuesta() != 0) {
				throw new OTPException(respuestaOtp.getMensajeSistema().toString(),respuestaOtp.getCodigoRespuesta(), respuestaOtp.getMensajeSistema().toString());
			}

			validacionExitosa = true;
		} catch (OTPException e) {
			LOG.error("Error al consumir servicio Entrust: {}", e.getMessage());
			return OTPException.mensajeValidarOTP(e.getCodigoError(), mensajeValidarError, e.getMensajeSistema());
		} catch (Exception e) {
			LOG.error("Error al consumir servicio Entrust: {}", e);
		} finally {
			webServiceConfig.returnObject(entrustService);
		}
		return validacionExitosa ? OTPException.mensajeValidarOTP(0, mensajeValidarOK, null)
				: OTPException.mensajeValidarOTP(404, mensajeValidarError, null);
	}

}
