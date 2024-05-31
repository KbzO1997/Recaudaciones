package com.bolivariano.microservice.utilitarioms.service;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import javax.annotation.PostConstruct;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;

import com.bolivariano.utilitario.common.StopWatch;

@Service("userLoginSimplifyService")
public class UserLoginSimplifyService {
	private final static Logger logger = LoggerFactory.getLogger(UserLoginSimplifyService.class);
	
    @Value("${xml.processSystemUserLoginSimplify}")
    private String processSystemUserLoginFile; 
    @Value("${cmm-nemonic}")
    private String cmmNemonic;	
    
	@Autowired
    private WebServiceConfig serviceConfig;   
    
	private String processSystemUserLoginSimplify;
	
	@PostConstruct
	private void loadXmlFiles() {
		try {			
			processSystemUserLoginSimplify = new String (Files.readAllBytes(Paths.get(processSystemUserLoginFile)));
		} catch (IOException e) {
			logger.error("No se pudo cargar el archivo xml", e);
		}
	}
		
	public Map<String, String> getProcessSystemUserLoginSimplify(String tipoIdentificacion, String identificacion){
		Map<String, String> resultado = new HashMap<>();
		String processSystemUserLoginSimplifyTemp = processSystemUserLoginSimplify;		
		StopWatch elapsedTime = new StopWatch();
		
    	processSystemUserLoginSimplifyTemp= StringUtils.replace(processSystemUserLoginSimplifyTemp,"${mnemonic}", cmmNemonic);
    	processSystemUserLoginSimplifyTemp= StringUtils.replace(processSystemUserLoginSimplifyTemp,"${identificationNumber}", identificacion);
    	processSystemUserLoginSimplifyTemp= StringUtils.replace(processSystemUserLoginSimplifyTemp,"${identificationType}", tipoIdentificacion);
		
    	String responseLogin = "";
	    try {
			RestTemplate cmmRestTemplate = serviceConfig.clienteCMM();
			elapsedTime.start();
			responseLogin = cmmRestTemplate.postForObject("", processSystemUserLoginSimplifyTemp, String.class);
			elapsedTime.stop();
    		logger.debug("tiempo de ejecucion CMM.processSystemUserLoginSimplify: " + elapsedTime.getElapsedTime() + "ms");
		} catch (Exception ex) {
			logger.error("Error al ejecutar servicio CMM.processSystemUserLoginSimplify", ex);		
			resultado.put("CODIGO-ERROR", "9999");
			resultado.put("MENSAJE-USUARIO", "Lo sentimos por favor inténtelo luego");
			resultado.put("MENSAJE-SISTEMA", "Error: " + ex.getMessage());
			
			return resultado;
		}
	    
	    String errorXpath = "//errors/error/cmmMsg/text()";
		String codigoErrorXpath = "//errors/error/cmmCode/text()";
	    
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db;
		Document document;
		try {
			db = dbf.newDocumentBuilder();	    
			
			document = db.parse(new ByteArrayInputStream(responseLogin.getBytes(StandardCharsets.UTF_8.name())));  
			document.getDocumentElement().normalize();  
			
			String error = (String) xPath.evaluate(errorXpath, document.getDocumentElement(), XPathConstants.STRING);  
			String errorCode = (String) xPath.evaluate(codigoErrorXpath, document.getDocumentElement(), XPathConstants.STRING);
			if(error!=null && !error.isEmpty()) {		
				resultado.put("CODIGO-ERROR", "1111");
				resultado.put("MENSAJE-USUARIO", error);
				resultado.put("MENSAJE-SISTEMA", error + " " + errorCode);			
				
				return resultado;
			}
		}
		catch(Exception ex) {
			logger.error("Error al obtener los resultados del llamado de CMM.processSystemUserLoginSimplify", ex);		
			resultado.put("CODIGO-ERROR", "9999");
			resultado.put("MENSAJE-USUARIO", "Lo sentimos por favor inténtelo luego");
			resultado.put("MENSAJE-SISTEMA", "Error: " + ex.getMessage());
			
			return resultado;			
		}
		
		try {
			String sessionIdXpath = "//generic/sessionID/text()";
			String userIdXpath = "//systemUser/userId/text()";
		    String sessionId = (String) xPath.evaluate(sessionIdXpath, document.getDocumentElement(), XPathConstants.STRING);
		    String userId = (String) xPath.evaluate(userIdXpath, document.getDocumentElement(), XPathConstants.STRING);

			resultado.put("CODIGO-ERROR", "0");
			resultado.put("MENSAJE-USUARIO", "TRANSACCION EXITOSA");
			resultado.put("MENSAJE-SISTEMA", "TRANSACCION EXITOSA");		    
			resultado.put("SESSION-ID", sessionId);
			resultado.put("USER-ID", userId);
		    
		}
		catch(Exception ex) {
			logger.error("Error en las variables de salida de CMM.processSystemUserLoginSimplify", ex);		
			resultado.put("CODIGO-ERROR", "9999");
			resultado.put("MENSAJE-USUARIO", "Lo sentimos por favor inténtelo luego");
			resultado.put("MENSAJE-SISTEMA", "Error: " + ex.getMessage());
			
			return resultado;			
		}
		
		return resultado;
	}
}
