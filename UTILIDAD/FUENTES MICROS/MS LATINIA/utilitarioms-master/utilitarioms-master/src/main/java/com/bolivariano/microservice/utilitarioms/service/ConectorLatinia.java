package com.bolivariano.microservice.utilitarioms.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaEnviarNotificacion;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaEnviarNotificacion;
import com.bolivariano.filagenerica.FilaGenerica;
import com.bolivariano.microservice.notification_gateway.estructura.ClaveValorNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.DatoAdjunto;
import com.bolivariano.microservice.notification_gateway.estructura.DatosAdicionalesNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.DatosAdjunto;
import com.bolivariano.microservice.notification_gateway.estructura.DatosComunNotificacion;
import com.bolivariano.microservice.notification_gateway.estructura.MedioEnvio;
import com.bolivariano.microservice.notification_gateway.estructura.MediosEnvio;
import com.bolivariano.microservice.notification_gateway.estructura.Notificacion;
import com.bolivariano.microservice.notification_gateway.estructura.TipoMedio;
import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesPortType;
import com.bolivariano.microservice.utilitarioms.bean.ServiciosCorreoPersonalizado;
import com.bolivariano.microservice.utilitarioms.dao.CuposDAO;
import com.bolivariano.utilitario.common.StopWatch;
import com.bolivariano.utilitario.common.Utils;

@Service("conectorLatinia")
public class ConectorLatinia {
	private final static Logger logger = LoggerFactory.getLogger(ConectorLatinia.class);
	
	@Value("${latinia.titulo-notificacion-asunto}")
    private String asuntoNotificacion;
	
	@Value("${latinia.referencia-compania}")
    private String referenciaCompania;
	
	@Autowired
	private WebServiceConfig serviceConfig;
	
	@Autowired
	private CuposDAO cuposDAO = new CuposDAO();
	
	@Autowired
	private ServiciosCorreoPersonalizado serviciosCorreoPersonalizado;
	
	//Key: Nombre del campo REQUEST , Value: Nombre con extension que tendra el Adjunto.
	private HashMap<String, String> parametroConAdjunto = new HashMap<>();{
		parametroConAdjunto.put("imgFrontal","imagenfrontal.jpg"); 
		parametroConAdjunto.put("imgReverso","imagenreverso.jpg");		
	}	
	
	//Key: Nemonico del servicio , Value: Tipo de MIME(extension o adjunto) Requerido.
	private HashMap<String, String> servicioConAdjunto = new HashMap<>();{
		servicioConAdjunto.put("DEPEX","image/jpeg");		
	}
	
	public MensajeSalidaEnviarNotificacion enviarNotificacion(MensajeEntradaEnviarNotificacion entrada) {
		StopWatch elapsedTime = new StopWatch();
			MensajeSalidaEnviarNotificacion mensajeSalida = new MensajeSalidaEnviarNotificacion(); 
			com.bolivariano.microservice.notification_gateway.estructura.MensajeEntradaEnviarNotificacion mensajeEntradaNotificacion = 
					new com.bolivariano.microservice.notification_gateway.estructura.MensajeEntradaEnviarNotificacion();
			com.bolivariano.microservice.notification_gateway.estructura.MensajeSalidaEnviarNotificacion  mensajeSalidaNotificacion = 
					new com.bolivariano.microservice.notification_gateway.estructura.MensajeSalidaEnviarNotificacion();
			String tipoServicio = entrada.getTipoServicio();			
			
				String identificacion = entrada.getCliente().getIdentificaciones().get(0).getIdentificacion();
				String tipoIdentificacion = entrada.getCliente().getIdentificaciones().get(0).getTipoIdentificacion().value();
				String canal = entrada.getCanal();
				NotificacionesPortType notificacionesPT = null;	
				String correoPersonalizado="";
				
				HashMap<String,String> cliente 				= obtenerDatosCliente(identificacion);
				HashMap<String,String> mediosEnvioCliente 	= obtenerMedioEnvio(identificacion, tipoIdentificacion);
				
				String fechaIngreso = Utils.fechaAcadena(new Date(), "dd/MM/yyyy");
				String horaIngreso = Utils.fechaAcadena(new Date(), "HH:mm:ss");
				
				String fechaTicket = Utils.fechaAcadena(new Date(), "yyyyMMdd");
				String horaTicket = Utils.fechaAcadena(new Date(), "HHmmsssss");
				String requerimiento = "WAP"+ fechaTicket + horaTicket;
				
				MediosEnvio mediosEnvio = new MediosEnvio();
				MedioEnvio celular = new MedioEnvio();
				MedioEnvio correo = new MedioEnvio();
				
				Notificacion notificacion = new Notificacion();
				    notificacion.setIdRequerimiento(requerimiento);
					notificacion.setCodEnte(cliente.get("codigoEnte"));
					notificacion.setRefServicio(tipoServicio);
					notificacion.setRefCompania(referenciaCompania);
				
				DatosComunNotificacion datosComunes = new DatosComunNotificacion();
					datosComunes.setCanal(canal);
					datosComunes.setAsunto(asuntoNotificacion);
					datosComunes.setFechaIngreso(fechaIngreso);
					datosComunes.setHoraIngreso(horaIngreso);	
				
				DatosAdicionalesNotificacion datosAdicionales = new DatosAdicionalesNotificacion();
				DatosAdjunto datosAdjuntos = new DatosAdjunto();
				for (FilaGenerica dato : entrada.getDatosNotificacion().getDato()) {
					if(servicioConAdjunto.containsKey(tipoServicio) 
								&& parametroConAdjunto.containsKey(dato.getCodigo())){					
						DatoAdjunto adjunto = new DatoAdjunto();						
							adjunto.setValor(String.valueOf(dato.getValor()));
							adjunto.setNombre(parametroConAdjunto.get(dato.getCodigo()));
							adjunto.setCodificacion("base64");
							adjunto.setTipo(servicioConAdjunto.get(tipoServicio));
						datosAdjuntos.getDatoAdjunto().add(adjunto);						
					}else {
						ClaveValorNotificacion parametros = new ClaveValorNotificacion();
							if(serviciosCorreoPersonalizado.getServicios().contains(tipoServicio)) {
								if("correo".equals(dato.getCodigo()))
									correoPersonalizado = dato.getValor();
							}
							parametros.setClave(String.valueOf(dato.getCodigo()));
							parametros.setValor(String.valueOf(dato.getValor()));							
						datosAdicionales.getParametrosNotificacion().add(parametros);
					}
				}
				
				if(serviciosCorreoPersonalizado.getServicios().contains(tipoServicio)) {	
					celular.setTipo(TipoMedio.C);
					celular.setValor("");					
					correo.setTipo(TipoMedio.M);					
					correo.setValor(correoPersonalizado);	
					if(serviciosCorreoPersonalizado.getSinMis()!=null)
					notificacion.setCodEnte(serviciosCorreoPersonalizado.getSinMis().contains(tipoServicio)?null:notificacion.getCodEnte());
				}else {					
					celular.setTipo(TipoMedio.C);
					celular.setValor(String.valueOf(mediosEnvioCliente.get("telefono")));
					correo.setTipo(TipoMedio.M);					
					correo.setValor(String.valueOf(mediosEnvioCliente.get("correo")));
				}	
				
				mediosEnvio.getMedioEnvio().add(celular);
				mediosEnvio.getMedioEnvio().add(correo);
					
				mensajeEntradaNotificacion.setNotificacion(notificacion);					
				mensajeEntradaNotificacion.setDatosComunNotificacion(datosComunes);
				mensajeEntradaNotificacion.setAdicionalesNotificacion(datosAdicionales);
				mensajeEntradaNotificacion.setMediosEnvio(mediosEnvio);
				if(servicioConAdjunto.containsKey(tipoServicio))
					mensajeEntradaNotificacion.setDatosAdjunto(datosAdjuntos);					
				
				try {
					notificacionesPT = serviceConfig.clienteConectorLatinia();
					elapsedTime.start();
					mensajeSalidaNotificacion = notificacionesPT.enviarNotificacion(mensajeEntradaNotificacion);
					elapsedTime.stop();
					logger.debug("tiempo de ejecucion notificacionesPT.enviarNotificacion: " + elapsedTime.getElapsedTime() + "ms");					
					logger.info("Codigo Ejecucion notificacionesPT.enviarNotificacion: " + mensajeSalidaNotificacion.getCodigoError());
					logger.info("Mensaje Ejecucion notificacionesPT.enviarNotificacion: " + mensajeSalidaNotificacion.getMensajeSistema());
					mensajeSalida.setCodigoError(mensajeSalidaNotificacion.getCodigoError());
					mensajeSalida.setMensajeUsuario(mensajeSalidaNotificacion.getMensajeUsuario());
					mensajeSalida.setMensajeSistema(mensajeSalidaNotificacion.getMensajeSistema());
					serviceConfig.returnObject(notificacionesPT);
					return mensajeSalida;
					
				} catch (Exception ex) {
					if (notificacionesPT != null) {
						serviceConfig.returnObject(notificacionesPT);
					}
					logger.error("error al llamado al servicio Conector Latinia ", ex);
					mensajeSalida.setCodigoError("9999");
					mensajeSalida.setMensajeUsuario("Error al llamado al servicio Conector Latinia");
					mensajeSalida.setMensajeSistema("Error al llamado al servicio Conector Latinia: " + ex.getMessage());
					return mensajeSalida;
				}
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> obtenerMedioEnvio(String identificacion, String tipoIdentificacion){		
		HashMap<String, String> resultado = new HashMap<String,String>();
		StopWatch elapsedTime = new StopWatch();
		String telefono = "";
		String correo = "";
			try {
				elapsedTime.start();
				Map<?, ?> out = cuposDAO.obtenerMediosEnvio(tipoIdentificacion, identificacion, "WAP");
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion cuposDAO.obtenerMediosEnvio: " + elapsedTime.getElapsedTime()	+ "ms");
				if(out == null) {
					logger.warn("No existen medios de envio");			
				}else if(out.get("s_cod_error") != null && !"0".equals(out.get("s_cod_error") + "")) {
					logger.warn("Error al consultar medios de envio " + out.get("s_cod_error") + " " + out.get("s_msj_error"));			
				}else if(out.get("result") == null) {
					logger.warn("No existen medios de envio");			
				}else{				
						try {
							List<Map<?, ?>> datos= (List<Map<?, ?>>) out.get("result");
							for(Map<?, ?> row: datos) {
								if(telefono.isEmpty() && "CELULAR".equals(row.get("s_tipo_medio") + ""))
									telefono = row.get("de_descripcion") + "";
								else if(correo.isEmpty() && "EMAIL".equals(row.get("s_tipo_medio") + ""))
									correo = row.get("de_descripcion") + "";
							}
						} catch (Exception e) {
							logger.error("Error al mapear medios envio", e);
							telefono = "";
							correo = "";
						}			
				}
			}catch (Exception e) {
				logger.error("Error al obtenerMediosEnvio", e);
				telefono = "";
				correo = "";
			}
			
		resultado.put("correo", correo);
		resultado.put("telefono", telefono);
		return resultado;
	}
	
	private HashMap<String, String> obtenerDatosCliente(String identificacion){
		HashMap<String, String> resultado = new HashMap<String,String>();
		StopWatch elapsedTime = new StopWatch();
		String codigoEnte = "";
		String nombreCliente = "";
		
			try {
				elapsedTime.start();
				Map<String, String> detalleCliente = cuposDAO.obtenerDetalleUsuarioVal(identificacion, "WAP");
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion cuposDAO.obtenerDetalleUsuarioVal: " + elapsedTime.getElapsedTime()	+ "ms");
				
				codigoEnte = (String) detalleCliente.get("codigoMis");
				nombreCliente = (String) detalleCliente.get("nombre");
			}
			catch(Exception e) {
				logger.error("error obtenerDatosCliente: " + e.getMessage());
				codigoEnte = "";
				nombreCliente = "";			
			}
			
			logger.info("codigoEnte: " + codigoEnte);
			logger.info("nombreCliente: " + nombreCliente);
			
		resultado.put("codigoEnte", codigoEnte);
		resultado.put("nombreCliente", nombreCliente);		
		return resultado;
	}
	
}
