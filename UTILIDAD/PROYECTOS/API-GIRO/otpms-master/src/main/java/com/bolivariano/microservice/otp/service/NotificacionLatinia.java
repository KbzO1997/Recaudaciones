package com.bolivariano.microservice.otp.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.notification_gateway.estructura.ClaveValorNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.DatosAdicionalesNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.DatosComunNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.MedioEnvio;
import com.bolivariano.microservice.notification_gateway.estructura.MediosEnvio;
import com.bolivariano.microservice.notification_gateway.estructura.MensajeEntradaEnviarNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.MensajeSalidaEnviarNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.Notificacion;
import com.bolivariano.microservice.notification_gateway.estructura.TipoMedio;
import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesPortType;
import com.bolivariano.microservice.otp.dao.OtpDAO;
import com.bolivariano.microservice.otp.dto.ParametrosNotificacion;
import com.bolivariano.microservice.otp.utils.constant.Procesos;
import com.bolivariano.utilitario.common.StopWatch;

@Service
public class NotificacionLatinia {

	/* Mensajes Latinia */
	@Value("${notificacion.prefix}")
	private String prefix;
	@Value("${notificacion.compania}")
	private String compania;
	@Value("${notificacion.servicio}")
	private String servicio;
	@Value("${notificacion.datoscomunes.canal}")
	private String canal;
	@Value("${notificacion.datoscomunes.asunto}")
	private String asunto;
	@Value("${notificacion.otp.clave}")
	private String otpClave;
	@Value("${notificacion.cliente.clave}")
	private String clienteClave;

	@Autowired
	private WebServiceConfig webServiceConfig;

	@Autowired
	private OtpDAO cuposDAO;
		
	public boolean enviarNotificacion(Map<String, Object> notificacion, List<ParametrosNotificacion> datAdicionales) {
		return generaNotificacion24(notificacion, datAdicionales);
	}

	/* NOTIFICACION LATINIA */
	public boolean generaNotificacion24(Map<String, Object> mapNotificacion, List<ParametrosNotificacion> datAdicionales) {
		String proceso = (String) mapNotificacion.get("proceso");
		String medioNotificacion = (String) mapNotificacion.get("medioNotificacion");
		Integer mis = (Integer) mapNotificacion.get("mis");
		String otp = (String) mapNotificacion.get("otp");
		String telefono = (String) mapNotificacion.get("telefono");
		String mail = (String) mapNotificacion.get("mail");
		String nemonico = (String) mapNotificacion.get("nemonico");
		
		HashMap<String, String> cliente = obtenerDatosCliente(mis);

		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String timestamp = simpleDateFormat.format(date);
		simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String fechaIngreso = simpleDateFormat.format(date);
		simpleDateFormat = new SimpleDateFormat("HH:mm:ss");
		String horaIngreso = simpleDateFormat.format(date);

		MensajeEntradaEnviarNotificacion mensajeEntrada = new MensajeEntradaEnviarNotificacion();
		/* Cabecera */
		Notificacion notificacion = new Notificacion();
		notificacion.setIdRequerimiento(prefix.concat(timestamp));
		notificacion.setRefCompania(compania);
		notificacion.setCodEnte(mis.toString());
		notificacion.setRefServicio(servicio);
		if(nemonico != null)
			notificacion.setRefServicio(nemonico);

		/* Datos Comunes */
		DatosComunNotificacion datosComunes = new DatosComunNotificacion();
		datosComunes.setCanal(canal);
		datosComunes.setAsunto(asunto);
		datosComunes.setFechaIngreso(fechaIngreso);
		datosComunes.setHoraIngreso(horaIngreso);

		/* Datos Adicionales */
		DatosAdicionalesNotificacion datosAdicionales = new DatosAdicionalesNotificacion();
		ClaveValorNotificacion parametros = null;
		parametros = new ClaveValorNotificacion();
		parametros.setClave(otpClave);
		parametros.setValor(otp);
		datosAdicionales.getParametrosNotificacion().add(parametros);

		if (medioNotificacion.trim().equalsIgnoreCase("M") || medioNotificacion.trim().equalsIgnoreCase("A")) {
			String nombreCliente = "nombreCliente";
			if (cliente.get(nombreCliente).trim().length() == 0) {
				return false;

			}
			parametros = new ClaveValorNotificacion();
			parametros.setClave(clienteClave);
			parametros.setValor(cliente.get(nombreCliente));
			datosAdicionales.getParametrosNotificacion().add(parametros);
			if(datAdicionales != null) {
				for (ParametrosNotificacion item : datAdicionales) {
					parametros = new ClaveValorNotificacion();
					parametros.setClave(item.getClave());
					parametros.setValor(item.getValor());
					datosAdicionales.getParametrosNotificacion().add(parametros);
				}
			}
		}

		// Medios Envio
		MediosEnvio mediosEnvio = new MediosEnvio();
		MedioEnvio meCelular = new MedioEnvio();
		MedioEnvio meCorreo = new MedioEnvio();
		meCelular.setTipo(TipoMedio.C);
		meCelular.setValor(telefono);
		meCorreo.setTipo(TipoMedio.M);
		meCorreo.setValor(mail);

		asignaMedios(medioNotificacion, mediosEnvio, meCelular, meCorreo);

		mensajeEntrada.setNotificacion(notificacion);
		mensajeEntrada.setDatosComunNotificacion(datosComunes);
		mensajeEntrada.setAdicionalesNotificacion(datosAdicionales);
		mensajeEntrada.setMediosEnvio(mediosEnvio);
		
		/*Sonarq reformacion*/
		return consumeServicio(mensajeEntrada, proceso);
	}
	
	private boolean consumeServicio(MensajeEntradaEnviarNotificacion mensajeEntrada, String proceso) {
		NotificacionesPortType notificacionSoap = null;		
		try {
			notificacionSoap = webServiceConfig.clienteLatinia(proceso);
			MensajeSalidaEnviarNotificacion mensajeSalidaEnviarNotificacion = notificacionSoap
					.enviarNotificacion(mensajeEntrada);

			if (mensajeSalidaEnviarNotificacion.getCodigoError() == null) {
				return false;
			}

			if (Integer.valueOf(mensajeSalidaEnviarNotificacion.getCodigoError()) != 0) {
				return false;
			}

		} catch (Exception e) {
			webServiceConfig.returnObject(notificacionSoap);
			return false;
		} finally {
			webServiceConfig.returnObject(notificacionSoap);
		}
		return true;
	}
	
	private void asignaMedios(String medioNotificacion,MediosEnvio mediosEnvio, MedioEnvio meCelular, MedioEnvio meCorreo) {
		if (medioNotificacion.trim().equalsIgnoreCase("C") || medioNotificacion.trim().equalsIgnoreCase("A")) {
			mediosEnvio.getMedioEnvio().add(meCelular);
		}
		if (medioNotificacion.trim().equalsIgnoreCase("M") || medioNotificacion.trim().equalsIgnoreCase("A")) {
			mediosEnvio.getMedioEnvio().add(meCorreo);
		}			
	}
	
	private HashMap<String, String> obtenerDatosCliente(Integer mis) {
		HashMap<String, String> resultado = new HashMap<>();
		StopWatch elapsedTime = new StopWatch();
		String codigoEnte = "";
		String nombreCliente = "";

		try {
			elapsedTime.start();
			Map<String, String> detalleCliente = cuposDAO.obtenerDetalleUsuarioVal(Procesos.OBTENER_DETALLE_CLIENTE,
					mis);
			elapsedTime.stop();

			codigoEnte = detalleCliente.get("codigoMis");
			nombreCliente = detalleCliente.get("nombre");
		} catch (Exception e) {
			codigoEnte = "";
			nombreCliente = "";
		}

		resultado.put("codigoEnte", codigoEnte);
		resultado.put("nombreCliente", nombreCliente);
		return resultado;
	}

}
