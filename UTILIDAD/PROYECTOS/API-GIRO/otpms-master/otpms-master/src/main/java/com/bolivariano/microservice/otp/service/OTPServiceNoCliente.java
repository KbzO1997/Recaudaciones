package com.bolivariano.microservice.otp.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.otp.dao.OtpDAO;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeResponse;
import com.bolivariano.microservice.otp.dto.MediosEnvio;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.CoreUtils;
import com.bolivariano.microservice.otp.utils.constant.Enums;

@Service
public class OTPServiceNoCliente {

	@Autowired
	private OtpDAO cuposDAO;

	@Autowired
	private NotificacionLatinia notificacionLatinia;

	@Autowired
	private OTPServiceEntrust otpServiceEntrust;

	/* Mensajes Validar OTP */
	@Value("${mensaje.otpservice.validar.ok}")
	private String mensajeValidarOK;

	@Value("${mensaje.otpservice.validar.error}")
	private String mensajeValidarError;

	private String consCelular = "s_celular";
	private String consCorreo = "s_correo";

	private final Logger logger = LoggerFactory.getLogger(OTPServiceNoCliente.class);

	/*--------------------------GENERAR OTP NO CLIENTE------------------------------------------*/
	public GenerarOTPMensajeResponse generarOTPNoCliente(String proceso, GenerarOTPMensajeRequest request)
			throws OTPException {
		GenerarOTPMensajeResponse mensaje = null;
		MediosEnvio medioEnvio = new MediosEnvio();

		String medioNotificacion = request.getMedioNotificacion();
		String identificacionCliente = request.getIdentificacionCliente();
		String otp = "";

		/* Validar que el campo medioNotificacion de envio sea correcto */
		if (!rArays.asList("A", "C", "M").contains(medioNotificacion.trim().toUpperCase())) {
			return OTPException.mensajeGenerarOTP(404, Enums.MENSAJE_MEDIOS_BAD, null);
		}

		try {

			mensaje = validarProductoProvTerc(proceso, request, medioEnvio);

			if (mensaje != null) {
				return mensaje;
			}
		} catch (NullPointerException nexc) {
			logger.error("Error al obtener medios de envio {}", nexc);
			mensaje = OTPException.mensajeGenerarOTP(404, String.format(Enums.MENSAJE_MEDIOS_NULL, "celular o correo"),
					null);
			return mensaje;
		}
		try {
			otp = otpServiceEntrust.obtenerCodigoOTPEntrust(proceso, identificacionCliente);
		} catch (OTPException e) {
			return OTPException.mensajeGenerarOTP(e.getCodigoError(), e.getMensajeSistema(), null);
		}

		if (otp == null) {
			return OTPException.mensajeGenerarOTP(404, Enums.MENSAJE_OTP_NULL, null);
		}

		Map<String, Object> notificacion = new HashMap<>();
		notificacion.put("proceso", proceso);
		notificacion.put("medioNotificacion", medioNotificacion);
		notificacion.put("mis", 0);
		notificacion.put("otp", otp);
		notificacion.put("telefono", medioEnvio.getCelular());
		notificacion.put("mail", medioEnvio.getCorreo());
		notificacion.put("nemonico", request.getServicio());
		boolean notificacionEnviada = notificacionLatinia.enviarNotificacion(notificacion, request.getAdicionalesNotificacion());

		if (!notificacionEnviada) {
			return OTPException.mensajeGenerarOTP(500, Enums.MENSAJE_NOTIFICACION_NULL, null);
		}

		return OTPException.mensajeGenerarOTP(0,
				CoreUtils.mensajeRespuestaMedios(medioNotificacion, medioEnvio.getCelular(), medioEnvio.getCorreo()),
				CoreUtils.encodeOTP(otp));
	}

	/* Obtener y validar medio de envio proveedor o tercero. */
	private GenerarOTPMensajeResponse validarProductoProvTerc(String proceso, GenerarOTPMensajeRequest request,
			MediosEnvio medioEnvio) throws OTPException {

		GenerarOTPMensajeResponse mensaje;

		Map<String, Object> mediosEnvio = obtenerMediosEnvioProveedor(proceso, request);

		if (mediosEnvio.containsKey(consCelular) && mediosEnvio.get(consCelular) != null) {
			medioEnvio.setCelular(mediosEnvio.get(consCelular).toString());
		}

		if (mediosEnvio.containsKey(consCorreo) && mediosEnvio.get(consCorreo) != null) {
			medioEnvio.setCorreo(mediosEnvio.get(consCorreo).toString());
		}

		mensaje = validarMediosEnvioProveedor(request.getMedioNotificacion(), medioEnvio);

		return mensaje;
	}

	/* Obtener medios de envio proveedor/tercero. */
	private Map<String, Object> obtenerMediosEnvioProveedor(String proceso, GenerarOTPMensajeRequest request) {
		Map<String, Object> mediosEnvio = new HashMap<>();
		String producto = request.getProducto();
		String identificacionCliente = request.getIdentificacionCliente();
		
		/* Validar si se envia producto o parametros correo/celular */
		try {
			if (producto != null && producto.equalsIgnoreCase(Enums.KEY_PROVEEDOR)) {
				mediosEnvio = cuposDAO.obtenerMediosDeEnvioBayted(proceso, Enums.KEY_PROVEEDOR, identificacionCliente);
			}else if (producto != null && producto.equalsIgnoreCase(Enums.KEY_TERCERO)) {
				mediosEnvio = cuposDAO.obtenerMediosDeEnvioBayted(proceso, Enums.KEY_TERCERO, identificacionCliente);
			} else {
				/* Observacion */
				mediosEnvio = new HashMap<>();
				mediosEnvio.put(consCelular, request.getCelular());
				mediosEnvio.put(consCorreo, request.getCorreo());

			}
		} catch (Exception e) {
			mediosEnvio = new HashMap<>();
		}

		return mediosEnvio;
	}

	/* Validar medios de envio proveedor/tercero. */
	private GenerarOTPMensajeResponse validarMediosEnvioProveedor(String medioNotificacion, MediosEnvio medioEnvio) {
		boolean errorValidarMediosProveedor = false;
		String celular = medioEnvio.getCelular();
		String correo = medioEnvio.getCorreo();
		String mensajeError = "";
		
		if ((celular == null || celular.trim().length() <= 0) && (correo == null || correo.trim().length() <= 0)) {
			errorValidarMediosProveedor = true;
			mensajeError = String.format(Enums.MENSAJE_MEDIOS_NULL, "celular/correo");
		}

		if ((celular == null || celular.length() <= 0) && medioNotificacion.trim().equalsIgnoreCase("C")) {
			errorValidarMediosProveedor = true;
			mensajeError = String.format(Enums.MENSAJE_MEDIOS_NULL, "celular");
		}

		if ((correo == null || correo.length() <= 0) && medioNotificacion.trim().equalsIgnoreCase("M")) {
			errorValidarMediosProveedor = true;
			mensajeError = String.format(Enums.MENSAJE_MEDIOS_NULL, "correo");
		}
		return errorValidarMediosProveedor ? OTPException.mensajeGenerarOTP(404, mensajeError, null) : null;
	}
}
