package com.bolivariano.microservice.otp.utils.constant;

public class Enums {
	/*Constructor vacio debido a requerimientos de sonarqu*/
	Enums() {
	}
	
    public static final Integer DEFAULT_QUERY_TIMEOUT = 5000;
    public static final String PARAMETROS_INCORRECTOS = "Parametros Incorrectos";
	public static final String KEY_PROVEEDOR = "PAGOPRV";
	public static final String KEY_TERCERO = "PAGTERCER";
	public static final String MENSAJE_MEDIOS_NULL = "No tienes %s registrado, Acércate a cualquiera de las oficinas del Banco Bolivariano y actualiza tus datos.";
	public static final String MENSAJE_NOTIFICACION_NULL = "Fallo en comunicación,intenta más tarde.";
	public static final String MENSAJE_GENERAR_OK = "Tu código fue enviado al %s registrado.";
	public static final String MENSAJE_OTP_NULL = "Fallo en comunicación,intenta más tarde.";
	public static final String MENSAJE_MEDIOS_BAD = "El parametro de envio debe ser A Todos, C Celular, M Correo.";
	public static final String MENSAJE_MIS_NULL = "Identificación incorrecta";
	public static final String BYTED_DOWN = "No existe servicio Bayted disponible.";

}
