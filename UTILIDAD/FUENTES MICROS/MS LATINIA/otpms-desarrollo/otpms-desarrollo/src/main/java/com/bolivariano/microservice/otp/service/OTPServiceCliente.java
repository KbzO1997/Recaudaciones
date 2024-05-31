package com.bolivariano.microservice.otp.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.otp.dao.OtpDAO;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeResponse;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.CoreUtils;
import com.bolivariano.microservice.otp.utils.constant.Enums;

@Service
public class OTPServiceCliente {

	@Autowired
	private OtpDAO cuposDAO;

	@Autowired
	private NotificacionLatinia ntfLatServCL;

	@Autowired
	private OTPServiceEntrust srvEntServCl;

	/* Mensajes Validar OTP */
	@Value("${mensaje.otpservice.validar.ok}")
	private String mensajeValidarOK;

	@Value("${mensaje.otpservice.validar.error}")
	private String mensajeValidarError;

	private static final Logger LOG = LoggerFactory.getLogger(OTPServiceCliente.class);

	/* OTP CLIENTE */
	public GenerarOTPMensajeResponse generarOTPCliente(String proceso, GenerarOTPMensajeRequest request, Integer mis) {

		String medioNotificacion = request.getMedioNotificacion();
		String identificacionCliente = request.getIdentificacionCliente();
		String otp = "";
		String celular = "";
		String correo = "";
		mis = mis == null ? obtenerCodigoMis(proceso, identificacionCliente) : mis;

		if (mis == null || mis == 0) {
			return OTPException.mensajeGenerarOTP(404, Enums.MENSAJE_MIS_NULL, null);
		}

		Map<String, Object> out = cuposDAO.obtenerMediosDeEnvio(proceso, mis);

		if (out == null) {
			return OTPException.mensajeGenerarOTP(404, String.format(Enums.MENSAJE_MEDIOS_NULL, " medio de envio "),
					null);
		}
		
		celular = (String) out.get("o_celular");
		correo = (String) out.get("o_correo");
		
		if (StringUtils.isEmpty(celular) && medioNotificacion.trim().equalsIgnoreCase("C")) {
			return OTPException.mensajeGenerarOTP(404, String.format(Enums.MENSAJE_MEDIOS_NULL, " celular "), null);
		} else if (StringUtils.isEmpty(correo) && medioNotificacion.trim().equalsIgnoreCase("M")) {
			return OTPException.mensajeGenerarOTP(404, String.format(Enums.MENSAJE_MEDIOS_NULL, " correo "), null);
		} else if (StringUtils.isEmpty(correo) && StringUtils.isEmpty(celular)) {
			return OTPException.mensajeGenerarOTP(404, String.format(Enums.MENSAJE_MEDIOS_NULL, " correo/celular "),
					null);
		}

		try {
			otp = srvEntServCl.obtenerCodigoOTPEntrust(proceso, identificacionCliente);
		} catch (OTPException e) {
			return OTPException.mensajeGenerarOTP(e.getCodigoError(), e.getMensajeSistema(), null);
		}

		if (otp == null) {
			return OTPException.mensajeGenerarOTP(500, Enums.MENSAJE_OTP_NULL, null);
		}

		Map<String, Object> notificacion = new HashMap<>();
		notificacion.put("proceso", proceso);
		notificacion.put("medioNotificacion", medioNotificacion);
		notificacion.put("mis", mis);
		notificacion.put("otp", otp);
		notificacion.put("telefono", celular);
		notificacion.put("mail", correo);
		notificacion.put("nemonico", request.getServicio());
		boolean notificacionEnviada = ntfLatServCL.enviarNotificacion(notificacion,
				request.getAdicionalesNotificacion());

		if (!notificacionEnviada) {
			return OTPException.mensajeGenerarOTP(500, Enums.MENSAJE_NOTIFICACION_NULL, null);
		}

		return OTPException.mensajeGenerarOTP(0, CoreUtils.mensajeRespuestaMedios(medioNotificacion, celular, correo),
				CoreUtils.encodeOTP(otp));
	}

	private Integer obtenerCodigoMis(String proceso, String identificacionCliente) {
		Integer mis = 0;
		try {

			mis = cuposDAO.obtenerCodigoMIS(proceso, identificacionCliente);

		} catch (Exception e) {
			LOG.info("{} Error al validar obtener codigo mis", proceso);
		}

		return mis;
	}
	

}
