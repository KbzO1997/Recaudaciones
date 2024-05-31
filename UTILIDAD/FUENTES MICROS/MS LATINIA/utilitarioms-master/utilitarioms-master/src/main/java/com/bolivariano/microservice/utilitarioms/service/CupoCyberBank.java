package com.bolivariano.microservice.utilitarioms.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.camel.Exchange;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;

import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaValidarCupo;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaValidarCupo;
import com.bolivariano.microservice.utilitarioms.dao.ComprobanteDAO;
import com.bolivariano.utilitario.common.StopWatch;

@Service("cupoCyberBank")
public class CupoCyberBank {
	private final static Logger logger = LoggerFactory.getLogger(CupoCyberBank.class);
    @Value("${xml.processEntryToEvaluate}")
    private String processEntryToEvaluateFile;
    @Value("${xml.processAccumulatedData}")
    private String processAccumulatedDataFile;
    @Value("${xml.massiveSelectInstitution}")
    private String massiveSelectInstitutionFile;
    
    @Value("${cmm-nemonic}")
    private String cmmNemonic; 
    
	@Autowired
    private WebServiceConfig serviceConfig;
	
	@Autowired
    private ComprobanteDAO comprobanteDAO;
	@Autowired
    private UserLoginSimplifyService userLoginSimplifyService; 	
	
	private String processEntryToEvaluate;
	private String processAccumulatedData;
	private String massiveSelectInstitution;

	@PostConstruct
	private void loadXmlFiles() {
		try {
			processEntryToEvaluate = new String (Files.readAllBytes(Paths.get(processEntryToEvaluateFile)));
			processEntryToEvaluate = new String (Files.readAllBytes(Paths.get(processEntryToEvaluateFile)));
			processAccumulatedData = new String (Files.readAllBytes(Paths.get(processAccumulatedDataFile)));
			massiveSelectInstitution = new String (Files.readAllBytes(Paths.get(massiveSelectInstitutionFile)));
		} catch (IOException e) {
			logger.error("No se pudo cargar el archivo xml", e);
		}
	}
	
	public MensajeSalidaValidarCupo validar(MensajeEntradaValidarCupo  mensajeEntrada, Exchange exchange){
		exchange.setProperty("homologar", true);
		MensajeSalidaValidarCupo mensajeSalida = new MensajeSalidaValidarCupo();
		String segmento = mensajeEntrada.getSegmento();
		StopWatch elapsedTime = new StopWatch();
		
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db;
		Document document = null;
		
		if(segmento == null || segmento.equals("")) {
	    	String massiveSelectInstitutionTmp= massiveSelectInstitution;
	    	massiveSelectInstitutionTmp= StringUtils.replace(massiveSelectInstitutionTmp,"${identificationNumber}", mensajeEntrada.getIdentificacion());
	    	String segmentoXpath = "//institution/segment/name/text()";
			String responseSegment = "";
		    try {
				RestTemplate cmmRestTemplate = serviceConfig.clienteCMM();
				elapsedTime.start();
				responseSegment = cmmRestTemplate.postForObject("", massiveSelectInstitutionTmp, String.class);
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion CMM.massiveSelectInstitution " + elapsedTime.getElapsedTime()+"ms");
				
				db = dbf.newDocumentBuilder();
				document = db.parse(new ByteArrayInputStream(responseSegment.getBytes(StandardCharsets.UTF_8.name())));  
				document.getDocumentElement().normalize();  
				segmento = (String) xPath.evaluate(segmentoXpath, document.getDocumentElement(), XPathConstants.STRING);  
				if(segmento == null || segmento.isEmpty()) {
					mensajeSalida.setCodigoError("1111");
					mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
					mensajeSalida.setMensajeSistema("Error al consultar segmento del cliente");
					return mensajeSalida;
				}
				mensajeEntrada.setSegmento(segmento);
			    
			} catch (Exception e) {
				logger.error("Error al ejecutar servicio CMM.massiveSelectInstitutionTmp", e);
				mensajeSalida.setCodigoError("9999");
				mensajeSalida.setMensajeSistema(e.getMessage());
				mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
				return mensajeSalida;
			}
	    }
		
		//String sessionId = null;
	    String userId = null;

	    if(mensajeEntrada.getUriTechCodigoUsuario() == null || mensajeEntrada.getUriTechCodigoUsuario().isEmpty() || mensajeEntrada.getUriTechCodigoUsuario().contains("$uriTech")) {
	    	String identificacion = mensajeEntrada.getIdentificacion();
	    	String tipoIdentificacion = mensajeEntrada.getTipoIdentificacion().value();
			Map<String, String> resultado = userLoginSimplifyService.getProcessSystemUserLoginSimplify(tipoIdentificacion, identificacion);
			
			String codigoError = (String) resultado.get("CODIGO-ERROR");
			String mensajeUsuario = (String) resultado.get("MENSAJE-USUARIO");
			String mensjaeSistema = (String) resultado.get("MENSAJE-SISTEMA");
			
			if(codigoError!= null && codigoError.equals("0")) {
			    //sessionId = (String) resultado.get("SESSION-ID");
			    userId = (String) resultado.get("USER-ID");
			}
			else {
				mensajeSalida.setCodigoError(codigoError);
				mensajeSalida.setMensajeUsuario(mensajeUsuario);
				mensajeSalida.setMensajeSistema(mensjaeSistema);
				return mensajeSalida;
			}
	    }
	    else {
	    	userId = mensajeEntrada.getUriTechCodigoUsuario();
			logger.debug("Se asigna uriTechCodigoUsuario (validarCupo):  " + userId);

	    }
	    
    	String error;
    	//String source;
    	String codError;
    	String sessionIdXpath = "//generic/sessionID/text()";
		String userIdXpath = "//systemUser/userId/text()";
		String errorXpath = "//errors/error/cmmMsg/text()";
		//String sourceXpath = "//errors/error/source/text()";
		//String codErrorXpath = "//errors/error/sourceCode/text()";
		String approvedXpath = "//generic/approved/text()";
		String codigoErrorXpath = "//errors/error/cmmCode/text()";
	    String serviceId = "";
	    String variantId = "";
	    switch(mensajeEntrada.getTipoProducto()) {
			case TARJETA_CREDITO:
				switch(mensajeEntrada.getTipoPago()) {
					case OTROS_BANCOS:
						serviceId = "TERCEROS";
						variantId = "PAGO_TARJETA_TERCEROS";
						break;
					case PROPIAS:
						serviceId = "PROPIAS";
						variantId = "PAGO_TARJETA_PROPIA";
						break;
					case TERCEROS:
						serviceId = "TERCEROS";
						variantId = "PAGO_TARJETA_TERCEROS";
						break;
					default:
						break;
					}
				break;
			case TRANSFERENCIA:
				switch(mensajeEntrada.getTipoPago()) {
				case OTROS_BANCOS:
					serviceId = "TERCEROS";
					variantId = "TRANSFERENCIA_CUENTAS_TERCEROS";
					break;
				case PROPIAS:
					serviceId = "PROPIAS";
					variantId = "TRANSFERENCIA_CUENTAS_PROPIAS";
					break;
				case TERCEROS:
					serviceId = "TERCEROS";
					variantId = "TRANSFERENCIA_CUENTAS_TERCEROS";
					break;
				default:
					break;
				}
			case PAGOS:
				switch(mensajeEntrada.getTipoPago()) {
				case PAGO_SERVICIOS:
					serviceId = "PAGOS";
					variantId = "PAGO_SERVICIOS";
					break;
				default:
					break;
				}
			break;
		}
	   
	    int secuencial = 0;
	    try {
	    	elapsedTime.start();
		    Map<?,?> out= comprobanteDAO.obtenerSecuencial("wap_cupos");
		    elapsedTime.stop();
			logger.debug("tiempo de ejecucion comprobanteDAO.obtenerSecuencial " + elapsedTime.getElapsedTime()+"ms");

		    if(out.get("o_siguiente") != null)
		    	secuencial = (Integer) out.get("o_siguiente");
	    }catch (Exception e) {
			logger.error("Error al consultar el secuencial del comprobante CyberBank", e);
	    	mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
			mensajeSalida.setMensajeSistema("Error al consultar el secuencial del comprobante CyberBank");
			return mensajeSalida;
		}
	    
	    String executingOperatorId = userId;
	    for(String values : executingOperatorId.split("\\;")) {
	    	if(values.contains("CEDULA_DE_IDENTIDAD")) {
	    		userId = values.substring(values.indexOf("CEDULA_DE_IDENTIDAD"));
	    		break;
	    	}
	    }
	    String processEntryToEvaluateTemp = processEntryToEvaluate;
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${mnemonic}", cmmNemonic);
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${executingOperatorId}", executingOperatorId);
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${userId}", userId);
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${accNumber}", mensajeEntrada.getCuentaDebito());
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${amount}", String.valueOf(mensajeEntrada.getMonto()));
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${processId}", String.valueOf(secuencial));
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${serviceId}", serviceId);
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${variantId}", variantId);
	    processEntryToEvaluateTemp= StringUtils.replace(processEntryToEvaluateTemp,"${segment}", mensajeEntrada.getSegmento());
	    
        String response = "";
	    try {
			RestTemplate cmmRestTemplate = serviceConfig.clienteCMM();
			elapsedTime.start();
			response = cmmRestTemplate.postForObject("", processEntryToEvaluateTemp, String.class);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion CMM.processEntryToEvaluate " + elapsedTime.getElapsedTime() + "ms");
			db = dbf.newDocumentBuilder();
			document = db.parse(new ByteArrayInputStream(response.getBytes(StandardCharsets.UTF_8.name())));  
			document.getDocumentElement().normalize();  
			error = (String) xPath.evaluate(errorXpath, document.getDocumentElement(), XPathConstants.STRING); 
			//source = (String) xPath.evaluate(sourceXpath, document.getDocumentElement(), XPathConstants.STRING);
			codError = (String) xPath.evaluate(codigoErrorXpath, document.getDocumentElement(), XPathConstants.STRING);  
			if(codError!=null && !codError.isEmpty()) {
				if(codError.equals("ERROR_ACUMULADO_DIARIO_MONTO_SUPERADO")) {
					mensajeSalida.setCodigoError("2000");
					mensajeSalida.setMensajeUsuario("Valor excede al cupo disponible");
				}
				else if(codError.equals("ERROR_ACUMULADO_DIARIO_CANTIDAD_TRANSACCIONES_SUPERADO") || 
						codError.equals("ERROR_ACUMULADO_MENSUAL_CANTIDAD_TRANSACCIONES_SUPERADO"))
				{
					mensajeSalida.setCodigoError("2023");
					mensajeSalida.setMensajeUsuario("Has llegado al maximo de transacciones permitidas");
				}
				else {
					mensajeSalida.setCodigoError("9999");
					mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
				}
				mensajeSalida.setMensajeSistema(codError + " " + error);
				return mensajeSalida;
			}
			String approved = (String) xPath.evaluate(approvedXpath, document.getDocumentElement(), XPathConstants.STRING);
			if(!approved.equals("APROBADA")) {
				mensajeSalida.setCodigoError("2000");
				mensajeSalida.setMensajeUsuario("Valor excede al cupo disponible");
				mensajeSalida.setMensajeSistema("Valor excede al cupo disponible");
				return mensajeSalida;
			}
		} catch (Exception e) {
			logger.error("Error al ejecutar servicio CMM.processEntryToEvaluate", e);
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema(e.getMessage());
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
			return mensajeSalida;
		}

	    mensajeSalida.setSegmento(segmento);
		mensajeSalida.setCodigoError("0");
		mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
		mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");

		return mensajeSalida;	
	}

	public MensajeSalidaValidarCupo actualizar(MensajeEntradaValidarCupo  mensajeEntrada, Exchange exchange){
		MensajeSalidaValidarCupo mensajeSalida = new MensajeSalidaValidarCupo();
		StopWatch elapsedTime = new StopWatch();

		if (mensajeEntrada.getSegmento() == null) {
			logger.error("Se requiere ingresar datos de segmento");
			mensajeSalida.setCodigoError("1030");
			mensajeSalida.setMensajeSistema("Se requiere ingresar datos de segmento");
			mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de segmento");
			return mensajeSalida;
		}

    	XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db;

		//String sessionId;
	    String userId;

	    if(mensajeEntrada.getUriTechCodigoUsuario() == null || mensajeEntrada.getUriTechCodigoUsuario().isEmpty() || mensajeEntrada.getUriTechCodigoUsuario().contains("$uriTech")) {
	    	String identificacion = mensajeEntrada.getIdentificacion();
	    	String tipoIdentificacion = mensajeEntrada.getTipoIdentificacion().value();
			Map<String, String> resultado = userLoginSimplifyService.getProcessSystemUserLoginSimplify(tipoIdentificacion, identificacion);
			
			String codigoError = (String) resultado.get("CODIGO-ERROR");
			String mensajeUsuario = (String) resultado.get("MENSAJE-USUARIO");
			String mensjaeSistema = (String) resultado.get("MENSAJE-SISTEMA");
			
			if(codigoError!= null && codigoError.equals("0")) {
			    //sessionId = (String) resultado.get("SESSION-ID");
			    userId = (String) resultado.get("USER-ID");
			}
			else {
				mensajeSalida.setCodigoError(codigoError);
				mensajeSalida.setMensajeUsuario(mensajeUsuario);
				mensajeSalida.setMensajeSistema(mensjaeSistema);
				return mensajeSalida;
			}
	    }
	    else {
	    	userId = mensajeEntrada.getUriTechCodigoUsuario();
	    	logger.debug("Se asigna uriTechCodigoUsuario (actualizarCupo):  " + userId);
	    }
				
    	String error;
    	String sessionIdXpath = "//generic/sessionID/text()";
		String userIdXpath = "//systemUser/userId/text()";
		String errorXpath = "//errors/error/cmmMsg/text()";
		Document document = null;
		
	    String serviceId = "";
	    String variantId = "";
	    switch(mensajeEntrada.getTipoProducto()) {
			case TARJETA_CREDITO:
				switch(mensajeEntrada.getTipoPago()) {
					case OTROS_BANCOS:
						serviceId = "TERCEROS";
						variantId = "PAGO_TARJETA_TERCEROS";
						break;
					case PROPIAS:
						serviceId = "PROPIAS";
						variantId = "PAGO_TARJETA_PROPIA";
						break;
					case TERCEROS:
						serviceId = "TERCEROS";
						variantId = "PAGO_TARJETA_TERCEROS";
						break;
					default:
						break;
					}
				break;
			case TRANSFERENCIA:
				switch(mensajeEntrada.getTipoPago()) {
				case OTROS_BANCOS:
					serviceId = "TERCEROS";
					variantId = "TRANSFERENCIA_CUENTAS_TERCEROS";
					break;
				case PROPIAS:
					serviceId = "PROPIAS";
					variantId = "TRANSFERENCIA_CUENTAS_PROPIAS";
					break;
				case TERCEROS:
					serviceId = "TERCEROS";
					variantId = "TRANSFERENCIA_CUENTAS_TERCEROS";
					break;
				default:
					break;
				}
			case PAGOS:
				switch(mensajeEntrada.getTipoPago()) {
				case PAGO_SERVICIOS:
					serviceId = "PAGOS";
					variantId = "PAGO_SERVICIOS";
					break;
				default:
					break;
				}
			break;
		}
	   
	    int secuencial = 0;
	    try {
	    	elapsedTime.start();
		    Map<?,?> out= comprobanteDAO.obtenerSecuencial("wap_cupos");
		    elapsedTime.stop();
			logger.debug("tiempo de ejecucion comprobanteDAO.obtenerSecuencial " + elapsedTime.getElapsedTime() + "ms");

		    if(out.get("o_siguiente") != null)
		    	secuencial = (Integer) out.get("o_siguiente");
	    }catch (Exception e) {
			logger.error("Error al consultar el secuencial del comprobante CyberBank", e);
	    	mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
			mensajeSalida.setMensajeSistema("Error al consultar el secuencial del comprobante CyberBank");
			return mensajeSalida;
		}
	    
	    String executingOperatorId = userId;
	    for(String values : executingOperatorId.split("\\;")) {
	    	if(values.contains("CEDULA_DE_IDENTIDAD")) {
	    		userId = values.substring(values.indexOf("CEDULA_DE_IDENTIDAD"));
	    		break;
	    	}
	    }
	    String processAccumulatedDataTemp = processAccumulatedData;	    
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${mnemonic}", cmmNemonic);
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${executingOperatorId}", executingOperatorId);
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${userId}", userId);
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${accNumber}", mensajeEntrada.getCuentaDebito());
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${amount}", String.valueOf(mensajeEntrada.getMonto()));
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${processId}", String.valueOf(secuencial));
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${serviceId}", serviceId);
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${variantId}", variantId);
	    processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${segment}", mensajeEntrada.getSegmento());
	    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	    if(mensajeEntrada.getFecha() != null) {
	    	processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${transactionDate}", sdf.format(mensajeEntrada.getFecha().toGregorianCalendar().getTime()));
	    }else{
	    	processAccumulatedDataTemp= StringUtils.replace(processAccumulatedDataTemp,"${transactionDate}", sdf.format(new Date()));
	    }
	    
	    String response = "";
	    String codError = "";
	    String description = "";
	    String codErrorXpath = "//error/codError/text()";
		String descriptionXpath = "//error/description/text()";
	    try {
			RestTemplate cmmRestTemplate = serviceConfig.clienteCMM();
			elapsedTime.start();
			response = cmmRestTemplate.postForObject("", processAccumulatedDataTemp, String.class);
			elapsedTime.stop();
			logger.debug("tiempo de ejecucion CMM.processAccumulatedData " + elapsedTime.getElapsedTime() + "ms");
			db = dbf.newDocumentBuilder();
			document = db.parse(new ByteArrayInputStream(response.getBytes(StandardCharsets.UTF_8.name())));  
			document.getDocumentElement().normalize();  
			codError = (String) xPath.evaluate(codErrorXpath, document.getDocumentElement(), XPathConstants.STRING);  
			description = (String) xPath.evaluate(descriptionXpath, document.getDocumentElement(), XPathConstants.STRING);  
			if(!codError.equals("0")) {
				mensajeSalida.setCodigoError("2000");
				mensajeSalida.setMensajeUsuario("Valor excede al cupo disponible");
				mensajeSalida.setMensajeSistema(description);
				return mensajeSalida;
			}
		} catch (Exception e) {
			logger.error("Error al ejecutar servicio CMM.processEntryToEvaluate", e);
			mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema("Lo sentimos por favor inténtelo luego");
			mensajeSalida.setMensajeUsuario(e.getMessage());
			return mensajeSalida;
		}
	    	    
		mensajeSalida.setCodigoError("0");
		mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
		mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
	    
		return mensajeSalida;	
	}
}
