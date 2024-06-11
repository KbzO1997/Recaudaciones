package com.bolivariano.microservice.otp.service;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.otp.dao.OtpDAO;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeResponse;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeResponse;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.constant.Procesos;

@Service
public class OTPService {

	@Autowired
	private OtpDAO cuposDAO;

	@Autowired
	private OTPServiceCliente otpServiceCliente;

	@Autowired
	private OTPServiceNoCliente otpServiceNoCliente;

	@Autowired
	private OTPServiceEntrust otpServiceEntrust;

	private static final Logger logger = LoggerFactory.getLogger(OTPService.class);

	/* Generar OTP Generico */
	public GenerarOTPMensajeResponse generarOTPGenerico(GenerarOTPMensajeRequest request) {
		GenerarOTPMensajeResponse generarOTPMensajeResponse;
		String proceso = "";
		String producto = null;

		long timestap = new Date().getTime();

		Integer mis = 0;
		String identificacionCliente = request.getIdentificacionCliente();
		producto = request.getProducto();
		/* Obtener cod mis en caso de ser cedula. */
		proceso = timestap + "-" + Procesos.GENERAR_OTP_CLIENTE;
		mis = cuposDAO.obtenerCodigoMIS(proceso, identificacionCliente);
		/* Si no existe codigo mis transaccion se envia a proveedor/tercero */
		if ((mis == null || mis == 0) || (producto != null)) {
			logger.info("No existe codigo mis para la identificacion ingresada.");
			proceso = timestap + "-" + Procesos.GENERAR_OTP_NO_CLIENTE;
			try {
				generarOTPMensajeResponse = otpServiceNoCliente.generarOTPNoCliente(proceso, request);
			} catch (OTPException e) {
				generarOTPMensajeResponse = new GenerarOTPMensajeResponse();
				generarOTPMensajeResponse.setCodigoRespuesta(-1);
				generarOTPMensajeResponse.setMensaje(e.getMessage());
			}
			return generarOTPMensajeResponse;
		}
		generarOTPMensajeResponse = otpServiceCliente.generarOTPCliente(proceso, request, mis);
		return generarOTPMensajeResponse;
	}

	public ValidarOTPMensajeResponse validarOTPGenerico(ValidarOTPMensajeRequest request) {
		long timestap = new Date().getTime();
		String proceso = timestap + "-" + Procesos.VALIDAR_OTP_CLIENTE;
		return otpServiceEntrust.validarCodigoOTPEntrust(proceso, request);
	}

}
