package com.bolivariano.microservice.utilitarioms.service;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.NumberFormat;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import javax.annotation.PostConstruct;
import javax.imageio.ImageIO;
import javax.swing.JEditorPane;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.apache.camel.Exchange;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaRegistrarComprobante;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeSalidaRegistrarComprobante;
import com.bolivariano.filagenerica.FilaGenerica;
import com.bolivariano.microservice.utilitarioms.dao.ComprobanteDAO;
import com.bolivariano.utilitario.common.StopWatch;
import com.bolivariano.recibo.Recibo;
import com.bolivariano.bancamovil.mensajesutilitarioms.v1.MensajeEntradaRegistrarComprobante.DatosAdicionalesComprobante.Dato;

@Service("comprobanteCyberBank")
public class ComprobanteCyberBank {
	private final static Logger logger = LoggerFactory.getLogger(ComprobanteCyberBank.class);
    @Value("${xml.insertTicket}")
    private String insertTicketFile;
    @Value("${xml.insertTicketAdditionalData}")
    private String insertTicketAdditionalDataFile;
    
    //dvillavc INICIO 2021-02-26    
    @Value("${xml.insertTicketReceipts}")
    private String insertTicketReceiptsFile;
    @Value("${xml.receiptTableBase64}")
    private String receiptTableBase64File;
    @Value("${html.reciboHTML}")
    private String reciboHTMLFile;
    @Value("${html.widthReceiptImage}")
    private String widthReceiptImage;    
    @Value("${html.heightReceiptImage}")
    private String heightReceiptImage;    
    //dvillavc FIN 2021-02-26
    
    @Value("${xml.path}")
    private String xmlPath;
    @Value("${cmm-nemonic}")
    private String cmmNemonic;
	@Autowired
    private WebServiceConfig serviceConfig;
	@Autowired
    private ComprobanteDAO comprobanteDAO;
	@Autowired
    private UserLoginSimplifyService userLoginSimplifyService;    
	
	private String insertTicket;
	private String insertTicketAdditionalData;
	private String insertTicketReceipts;//BMK-0000 dvillavc 2021-02-26
	private static String receiptTableBase64;
	private String reciboHTML;//BMK-0000 dvillavc 2021-02-26
	private int widthImage;//BMK-0000 dvillavc 2021-02-26
	private int heightImage;//BMK-0000 dvillavc 2021-02-26
	
	private Map<String, String> templates;
	
	@PostConstruct
	private void loadXmlFiles() {
		try {
			insertTicket = new String (Files.readAllBytes(Paths.get(insertTicketFile)));
			insertTicketAdditionalData= new String (Files.readAllBytes(Paths.get(insertTicketAdditionalDataFile)));
			insertTicketReceipts= new String (Files.readAllBytes(Paths.get(insertTicketReceiptsFile)));//BMK-0000 dvillavc 2021-02-26
			receiptTableBase64 = new String (Files.readAllBytes(Paths.get(receiptTableBase64File)));//BMK-0000 dvillavc 2021-02-26
			reciboHTML= new String (Files.readAllBytes(Paths.get(reciboHTMLFile)));//BMK-0000 dvillavc 2021-02-26
			widthImage = Integer.parseInt(widthReceiptImage);//BMK-0000 dvillavc 2021-02-26
			heightImage = Integer.parseInt(heightReceiptImage);//BMK-0000 dvillavc 2021-02-26
		} catch (IOException e) {
			logger.error("No se pudo cargar el archivo xml", e);
		}
	}
	
	public MensajeSalidaRegistrarComprobante registrar(MensajeEntradaRegistrarComprobante mensajeEntrada, Exchange exchange){
		MensajeSalidaRegistrarComprobante mensajeSalida = new MensajeSalidaRegistrarComprobante();
		Document document;
		StopWatch elapsedTime = new StopWatch();
		String insertTicketTemp = insertTicket;
		String xmlTicket= null;
		 exchange.setProperty("homologar", true);
	    try {
	    	
	    	if(mensajeEntrada.getIdServicio() == null || mensajeEntrada.getIdServicio().equals("")) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar idServicio");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar idServicio");
				return mensajeSalida;
	    	}else if (mensajeEntrada.getCliente() == null || mensajeEntrada.getCliente().getIdentificaciones() == null ||
	    			  mensajeEntrada.getCliente().getIdentificaciones().isEmpty()) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar identificacion/tipoIdentificacion");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar identificacion/tipoIdentificacion");
				return mensajeSalida;
	    	}else if (mensajeEntrada.getTablaSecuencial() == null || mensajeEntrada.getTablaSecuencial().equals("")) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar tablaSecuencial");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar tablaSecuencial");
				return mensajeSalida;
	    	}else if (mensajeEntrada.getDatosComprobante() == null || mensajeEntrada.getDatosComprobante().getDato() == null) {
	    		mensajeSalida.setCodigoError("1030");
				mensajeSalida.setMensajeSistema("Se requiere ingresar datos de comprobante");
				mensajeSalida.setMensajeUsuario("Se requiere ingresar datos de comprobante");
				return mensajeSalida;
	    	}
		    
		    String errorXpath = "//errors/error/cmmMsg/text()";
			String codigoErrorXpath = "//errors/error/cmmCode/text()";
		    
			XPathFactory factory = XPathFactory.newInstance();
			XPath xPath = factory.newXPath();
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			
			String sessionId;
		    String userId;

		    if(mensajeEntrada.getUriTechCodigoUsuario() == null || mensajeEntrada.getUriTechCodigoUsuario().isEmpty() || mensajeEntrada.getUriTechCodigoUsuario().contains("$uriTech")) {
		    	String identificacion = mensajeEntrada.getCliente().getIdentificaciones().get(0).getIdentificacion();
		    	String tipoIdentificacion = mensajeEntrada.getCliente().getIdentificaciones().get(0).getTipoIdentificacion().value();
				Map<String, String> resultado = userLoginSimplifyService.getProcessSystemUserLoginSimplify(tipoIdentificacion, identificacion);
				
				String codigoError = (String) resultado.get("CODIGO-ERROR");
				String mensajeUsuario = (String) resultado.get("MENSAJE-USUARIO");
				String mensjaeSistema = (String) resultado.get("MENSAJE-SISTEMA");
				
				if(codigoError!= null && codigoError.equals("0")) {
				    sessionId = (String) resultado.get("SESSION-ID");
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
		    }
		    
		    String secuencial= mensajeEntrada.getSecuencial();
		    
		    if(secuencial == null || secuencial.equals("")) {	
			    secuencial= mensajeEntrada.getCanal();
			    try {
			    	elapsedTime.start();
				    Map<?,?> out = comprobanteDAO.obtenerSecuencial(mensajeEntrada.getTablaSecuencial());
					elapsedTime.stop();
					logger.debug("tiempo de ejecucion comprobanteDAO.obtenerSecuencial: " + elapsedTime.getElapsedTime()	+ "ms");

				    if(out.get("o_siguiente") != null)
				    	secuencial+= out.get("o_siguiente");
			    }catch (Exception e) {
			    	logger.error("Error al consultar el secuencial del comprobante CyberBank", e);
			    	mensajeSalida.setCodigoError("9999");
					mensajeSalida.setMensajeUsuario("Lo sentimos por favor inténtelo luego");
					mensajeSalida.setMensajeSistema("Error al consultar el secuencial del comprobante CyberBank");
					return mensajeSalida;
				}
		    }
	        
	    	if(templates == null)
	    		templates= new HashMap<String, String>();
	    	
	        if(templates.get(mensajeEntrada.getIdServicio()) == null) {
	        	templates.put(mensajeEntrada.getIdServicio(), 
	        			new String (Files.readAllBytes(Paths.get(xmlPath + mensajeEntrada.getIdServicio() + ".xml"))));
	        }
	        
	        xmlTicket= templates.get(mensajeEntrada.getIdServicio());
	        String tipoServicio = "";//BMK-0000 dvillavc INICIO 2021-02-26
	        for (FilaGenerica dato : mensajeEntrada.getDatosComprobante().getDato()) {
	        	//BMK-0000 dvillavc INICIO 2021-02-26
	        	String codigo = dato.getCodigo(), valor = dato.getValor();  	        	
				xmlTicket = StringUtils.replace(xmlTicket,"${" + codigo + "}", valor);
				if("tipoServicio".equals(codigo)) tipoServicio = valor;
				//BMK-0000 dvillavc FIN 2021-02-26				
			}
	        
	        String datosAdicionales= "";
	        if(mensajeEntrada.getDatosAdicionalesComprobante() != null && mensajeEntrada.getDatosAdicionalesComprobante().getDato() != null && 
	        		!mensajeEntrada.getDatosAdicionalesComprobante().getDato().isEmpty()) {
	        	for (Dato dato : mensajeEntrada.getDatosAdicionalesComprobante().getDato()) {
	        		String datoAdicional= insertTicketAdditionalData;
	        		datoAdicional= StringUtils.replace(datoAdicional,"${codigo}", dato.getCodigo());
	        		datoAdicional= StringUtils.replace(datoAdicional,"${valor}", dato.getValor());
	        		//BMK-0000 dvillavc INICIO 2021-02-26
	        		datoAdicional= StringUtils.replace(datoAdicional,"${etiqueta}", dato.getEtiqueta());		        	
		        	datoAdicional= StringUtils.replace(datoAdicional,"${visible}", dato.isVisible() + "");
		        	datosAdicionales+= datoAdicional;
				}	        	
	        }
	        
	        //BMK-0000 dvillavc INICIO 2021-02-26
	        String recibos = "", imagenRecibo = "";
	        if(mensajeEntrada.getRecibo() != null && mensajeEntrada.getRecibo().getDatoRecibo() != null) {
	        	for (Recibo dato : mensajeEntrada.getRecibo().getDatoRecibo()) {
		        	String recibo = insertTicketReceipts;
		        	String reciboHtml = reciboHTML;
		        	recibo= StringUtils.replace(recibo,"${concepto}", dato.getConcepto());
		        	recibo= StringUtils.replace(recibo,"${fecha}", dato.getFecha());
		        	recibo= StringUtils.replace(recibo,"${comprobante}", dato.getComprobante());
		        	recibo= StringUtils.replace(recibo,"${totalPagar}", dato.getTotalPagar());
		        	recibos += recibo;
		        	
		        	if("PAGO_IESS".equals(tipoServicio)) {
			        	reciboHtml= StringUtils.replace(reciboHtml,"${concepto}", dato.getConcepto());
			        	reciboHtml= StringUtils.replace(reciboHtml,"${fecha}", dato.getFecha());
			        	reciboHtml= StringUtils.replace(reciboHtml,"${comprobante}", dato.getComprobante());
			        	reciboHtml= StringUtils.replace(reciboHtml,"${totalpagar}", NumberFormat.getCurrencyInstance().format(new BigDecimal(dato.getTotalPagar())).replaceAll("\\$", ""));
			        	imagenRecibo += reciboHtml;
		        	}
	        	}
	        	
	        }
	        xmlTicket= StringUtils.replace(xmlTicket,"${recibos}", recibos);
	        xmlTicket= StringUtils.replace(xmlTicket,"${imagenReciboIESSBase64}", generarReciboBase64(imagenRecibo,widthImage,heightImage));
	        //BMK-0000 dvillavc FIN 2021-02-26
	        
	        xmlTicket= StringUtils.replace(xmlTicket,"${datosAdicionales}", datosAdicionales);	        
            xmlTicket= StringUtils.replace(xmlTicket,"${executingOperatorId}", userId);
            
	        insertTicketTemp= StringUtils.replace(insertTicketTemp,"${traceNumber}", secuencial);
	        insertTicketTemp= StringUtils.replace(insertTicketTemp,"${mnemonic}", cmmNemonic);
	        insertTicketTemp= StringUtils.replace(insertTicketTemp,"${executingOperatorId}", userId);
	        insertTicketTemp= StringUtils.replace(insertTicketTemp,"${xmlMessage}", "<![CDATA[" + xmlTicket + "]]>");
	        insertTicketTemp= StringUtils.replace(insertTicketTemp,"${referenceNumber}", secuencial);
	        
		    //System.out.println(insertTicketTemp);
	        logger.debug("TICKET: " + insertTicketTemp);
		    
	        String response = "";
		    try {
				RestTemplate cmmRestTemplate = serviceConfig.clienteCMM();
				elapsedTime.start();
				response = cmmRestTemplate.postForObject("", insertTicketTemp, String.class);
				elapsedTime.stop();
				logger.debug("tiempo de ejecucion CMM.insertTicket: " + elapsedTime.getElapsedTime()	+ "ms");
				
			} catch (Exception e) {
				logger.error("Error al ejecutar servicio CMM.insertTicket", e);
				mensajeSalida.setCodigoError("9999");
				mensajeSalida.setMensajeSistema("Lo sentimos por favor inténtelo luego");
				mensajeSalida.setMensajeUsuario(e.getMessage());
				return mensajeSalida;
			}
		    
			document = db.parse(new ByteArrayInputStream(response.getBytes(StandardCharsets.UTF_8.name())));  
			document.getDocumentElement().normalize();  
			String error = (String) xPath.evaluate(errorXpath, document.getDocumentElement(), XPathConstants.STRING);  
			if(error!=null && !error.isEmpty()) {
				mensajeSalida.setCodigoError("1111");
				mensajeSalida.setMensajeUsuario(error);
				mensajeSalida.setMensajeSistema(error);
				return mensajeSalida;
			}
			
			mensajeSalida.setNumeroComprobante(secuencial);
		    	    
			mensajeSalida.setCodigoError("0");
			mensajeSalida.setMensajeSistema("TRANSACCION EXITOSA");
			mensajeSalida.setMensajeUsuario("TRANSACCION EXITOSA");
			
	    }catch (Exception e) {
	    	logger.error("Error al registrar compobante en CyberBank", e);
	    	mensajeSalida.setCodigoError("9999");
			mensajeSalida.setMensajeSistema("Lo sentimos por favor inténtelo luego");
			mensajeSalida.setMensajeUsuario(e.getMessage());
		}
	    
		return mensajeSalida;	
	}
	
	private String generarReciboBase64(String datos, int width, int height) {		
		if(datos == null || "".equals(datos)) return "";		
		String encodedString = "";
		try {   
			    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);			    
			    Graphics graphics = image.createGraphics();
			    JEditorPane editorPane = new JEditorPane("text/html", datos);
			    editorPane.setSize(width, height);
			    editorPane.print(graphics);
			    
			    ByteArrayOutputStream baos = new ByteArrayOutputStream();
			    ImageIO.write(image, "jpg", baos);
			    byte[] bytes = baos.toByteArray();
			    encodedString = Base64.getEncoder().encodeToString(bytes);
			System.out.println(encodedString);
		} catch (IOException e) {
			e.printStackTrace();
		}		 
		return StringUtils.replace(receiptTableBase64,"${imagenBase64}", encodedString); 
	}	
}
