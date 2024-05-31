package com.bolivariano.microservice.otp.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.bolivariano.microservice.otp.utils.constant.Enums;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CoreUtils {
	/* Constructor vacio debido a requerimientos de sonarqu */
	CoreUtils() {
	}

	private static Logger logger = LoggerFactory.getLogger(CoreUtils.class);

	public static String dateToString(Date fecha, String formato) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(formato);
		return simpleDateFormat.format(fecha);
	}

	public static String dateToString(Date fecha) {
		return CoreUtils.dateToString(fecha, "yyyy/MM/dd kk:mm:ss");
	}

	public static String dateToString() {
		return CoreUtils.dateToString(new Date());
	}

	public static double getTimeInterval(Date fechaInicio, Date fechaTermino, boolean resultInMiliseconds) {
		Integer milisecond = 1000;
		if (resultInMiliseconds) {
			milisecond = 1;
		}
		return (((double) fechaTermino.getTime() / milisecond) - ((double) fechaInicio.getTime() / milisecond));
	}

	public static double getTimeInterval(Date fechaInicio, boolean resultInMiliseconds) {
		return CoreUtils.getTimeInterval(fechaInicio, new Date(), resultInMiliseconds);
	}

	public static double getTimeInterval(Date fechaInicio) {
		return CoreUtils.getTimeInterval(fechaInicio, true);
	}

	public static Integer getTimeIntervalInt(Date fechaInicio) {
		double segundos = CoreUtils.getTimeInterval(fechaInicio);
		return (int) segundos;
	}

	public static String encodeOTP(String otp) {
		StringBuilder otpEncoded = new StringBuilder();
		int totalCadena = (otp.length() - 2);
		for (int i = 0; i < otp.length(); i++) {
			if (totalCadena <= i) {
				otpEncoded.append(otp.charAt(i));
			} else {
				otpEncoded.append("X");
			}
		}
		return otp;
	}

	public static String mensajeRespuestaMedios(String medioNotificacion, String celular, String correo) {
		String vMensajeGenerarOK = "";
		/* Enmascarar medios de envío en CNB [jaguzmam-CNBM-89] */
		switch (medioNotificacion) {
			case "A":
				vMensajeGenerarOK = String.format(Enums.MENSAJE_GENERAR_OK,
						enmascararTelefono(celular) + " / " + enmascararCorreo(correo));
				break;
			case "M":
				vMensajeGenerarOK = String.format(Enums.MENSAJE_GENERAR_OK, "correo ".concat(enmascararCorreo(correo)));
				break;
			case "C":
				vMensajeGenerarOK = String.format(Enums.MENSAJE_GENERAR_OK,
						"celular ".concat(enmascararTelefono(celular)));
				break;
			default:
				break;
		}
		return vMensajeGenerarOK;
	}

	public static String enmascararCorreo(String correo) {
		logger.info("ENMASCARANDO CORREO -> " + correo);
		int arrobaIndex = correo.indexOf("@");
		if (arrobaIndex != -1 && arrobaIndex > 0) {
			String dominio = correo.substring(arrobaIndex);
			String nombreUsuario = correo.substring(0, 1) + "xxx" + correo.substring(arrobaIndex - 3);
			return nombreUsuario + dominio;
		} else {
			return correo; // No se puede enmascarar
		}
	}

	public static String enmascararTelefono(String telefono) {
		logger.info("ENMASCARANDO TELEFONO -> " + telefono);
		int longitud = telefono.length();
		if (longitud >= 4) {
			String ultimosDigitos = telefono.substring(longitud - 4);
			return "xxxxxx" + ultimosDigitos;
		} else {
			return telefono; // No se puede enmascarar
		}
	}

}
