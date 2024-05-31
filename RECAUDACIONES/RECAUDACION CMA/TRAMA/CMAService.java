package com.bolivariano.microservice.reccma.service;

import com.bolivariano.microservice.reccma.domain.mensajeotc.MensajeEntradaEjecutarPago;
import com.bolivariano.microservice.reccma.domain.mensajeotc.MensajeSalidaEjecutarPago;
import com.bolivariano.microservice.reccma.domain.mensajeotc.MensajeEntradaEjecutarReverso;
import com.bolivariano.microservice.reccma.configuration.ApplicationProperties;
import com.bolivariano.microservice.reccma.domain.datoadicional.DatoAdicional;
import com.bolivariano.microservice.reccma.domain.mensajeotc.*;
import com.bolivariano.microservice.reccma.utils.ContentTypeEnum;
import com.bolivariano.microservice.reccma.utils.Converter;
import com.bolivariano.microservice.reccma.utils.ConverterFactory;
import com.bolivariano.microservice.reccma.utils.GeneralUtils;
import io.netty.channel.ConnectTimeoutException;
import io.netty.handler.timeout.ReadTimeoutException;
import io.netty.handler.timeout.TimeoutException;
import io.quarkiverse.cxf.annotation.CXFClient;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.transport.http.HTTPConduit;
import org.jboss.logging.Logger;
import org.tempuri.*;
import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.ws.WebServiceException;

import java.math.BigDecimal;
import java.net.ConnectException;
import java.net.SocketTimeoutException;
import java.util.Date;
import java.util.List;

@ApplicationScoped
public class CMAService {

    private static final String JAVA_TRUESTORE = "javax.net.ssl.trustStore";
    private static final String JAVA_TRUESTORE_PASS = "javax.net.ssl.trustStorePassword";
    private static final String JAVA_TRUESTORE_TYPE = "javax.net.ssl.trustStoreType";
    private static final CharSequence COULD_NOT_RECEIVE_MSG = "Could not receive Message";
    private static final CharSequence READ_TIME_OUT = "Read timed out";
    private static final CharSequence JAVA_SOCKET_TIMEOUT_EXP = "java.net.SocketTimeoutException";
    private static final String REV_001 = "REV_001";
    private static final String ERROR_CONSUMIR_PROVEEDOR = "ERROR AL CONSUMIR PROVEEDOR";
    private static final String CMA_003 = "CMA_003";
    private static final CharSequence IO_NETTY_READ_TIMEOUT_EXP = "io.netty.handler.timeout.ReadTimeoutException";
    private static final String EMPRESA_DESTINO_NO_DISPONIBLE = "EMPRESA DESTINO NO DISPONIBLE";

    @Inject
    @CXFClient("cma-service")
    BolivarianoWSSoap cmaServiceWSSoap;

    @Inject
    ApplicationProperties applicationProperties;

    @Inject
    Logger log;


    @PostConstruct
    void configurePortType() {
        try {
            final var httpConduit = (HTTPConduit) ClientProxy.getClient(cmaServiceWSSoap).getConduit();

            httpConduit.getClient().setConnectionTimeout(applicationProperties.provider().connTimeout());
            httpConduit.getClient().setReceiveTimeout(applicationProperties.provider().readTimeout());

        } catch (Exception ex) {
            log.error("ERROR AL SETEAR TIMEOUT: " + ex.getMessage(), ex);
        }

    }

	public MensajeSalidaConsultarDeuda consultarDeuda(MensajeEntradaConsultarDeuda mensajeEntradaConsultarDeuda) {
        MensajeSalidaConsultarDeuda mensajeSalidaConsultarDeuda;
        Converter converter = ConverterFactory.getConverter(ContentTypeEnum.XML);
        try {
            System.setProperty(JAVA_TRUESTORE, applicationProperties.truststore().path());
            System.setProperty(JAVA_TRUESTORE_PASS, applicationProperties.truststore().password());
            System.setProperty(JAVA_TRUESTORE_TYPE, applicationProperties.truststore().type());
            CargarDatos cargarDatos = new CargarDatos();
            cargarDatos.setTipoId("1");
            cargarDatos.setParam(mensajeEntradaConsultarDeuda.getServicio().getIdentificador());
            
            log.info("SECUENCIAL: " + mensajeEntradaConsultarDeuda.getSecuencial());
            log.info("CANAL: " + mensajeEntradaConsultarDeuda.getCanal());
            log.info("IDENTIFICADOR: " + mensajeEntradaConsultarDeuda.getServicio().getIdentificador());

            convertirDeObjetoByConsultaRq(converter, cargarDatos);
         
            Resultado resultado = this.cmaServiceWSSoap.cargarDatos(cargarDatos.getTipoId(),cargarDatos.getParam());

            convertirDeObjetoByConsultaRs(converter, resultado);
 
            mensajeSalidaConsultarDeuda = salidaConsulta(resultado);

            //MensajeSalidaConsultarDeuda salidaDeuda = new MensajeSalidaConsultarDeuda();

            //salidaDeuda.setCodigoError("0");
            //salidaDeuda.setMontoTotal(100.00);
            //salidaDeuda.setIdentificadorDeuda(mensajeEntradaConsultarDeuda.getServicio().getIdentificador());
            //salidaDeuda.setNombreCliente("STR");
            //salidaDeuda.setMensajeUsuario("OK");


            //mensajeSalidaConsultarDeuda =  salidaDeuda;


        } catch (Exception e) {
            log.error("Error en procesamiento CMA: " + e.getMessage(), e);
            mensajeSalidaConsultarDeuda = new MensajeSalidaConsultarDeuda();
            mensajeSalidaConsultarDeuda.setCodigoError("CMA_70013");
            mensajeSalidaConsultarDeuda.setMensajeUsuario(EMPRESA_DESTINO_NO_DISPONIBLE);
            mensajeSalidaConsultarDeuda.setMensajeSistema("EMPRESA DESTINO NO DISPONIBLE --> " + e.getMessage());
        }

        return mensajeSalidaConsultarDeuda;
    }

    private void convertirDeObjetoByConsultaRq(Converter converter, CargarDatos cargarDatos) {
        try {
            log.info("REQUEST CONSULTA CMA: " + converter.convertirDeObjeto(cargarDatos));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR REQUEST:  " + ex1.getMessage(), ex1);
        }
    }

    
    private void convertirDeObjetoByConsultaRs(Converter converter, Resultado resultado) {
        try {
            log.info("RESPONSE CONSULTA CMA: " + converter.convertirDeObjeto2(resultado,"resultado"));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR RESPONSE:   " + ex1.getMessage(), ex1);
        }
    }

    private void convertirDeObjetoByPagoRq(Converter converter, RegistrarPagoBancoEntrada registrarPagoBancoEntrada) {
        try {
            log.info("REQUEST PAGO CMA: " + converter.convertirDeObjeto(registrarPagoBancoEntrada));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR REQUEST: " + ex1.getMessage(), ex1);
        }
    }

    private void convertirDeObjetoByPagoRs(Converter converter, Resultado resultado) {
        try {
            log.info("RESPONSE PAGO CMA: " + converter.convertirDeObjeto2(resultado,"resultado"));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR RESPONSE: " + ex1.getMessage(), ex1);
        }
    }
    
    
    private void convertirDeObjetoByReversoRq(Converter converter, RegistrarPagoBancoEntrada registrarPagoBancoEntrada) {
        try {
            log.info("REQUEST REVERSO CMA: " + converter.convertirDeObjeto(registrarPagoBancoEntrada));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR REQUEST: " + ex1.getMessage(), ex1);
        }
    }

    private void convertirDeObjetoByReversoRs(Converter converter, Resultado resultado) {
        try {
            log.info("RESPONSE REVERSO CMA: " + converter.convertirDeObjeto2(resultado,"resultado"));
        } catch (Exception ex1) {
            log.error("ERROR AL CONVERTIR RESPONSE: " + ex1.getMessage(), ex1);
        }
    }
    

    private MensajeSalidaConsultarDeuda salidaConsulta(Resultado resultado) {
        MensajeSalidaConsultarDeuda salidaDeuda = new MensajeSalidaConsultarDeuda();
    
        try {
        	
        	if (resultado.getCargarDatosSalida() != null){
        		
        		 if (resultado.getCargarDatosSalida().getCliente().get(0).getCodigoError().equals("0000")) {
               	     salidaDeuda.setCodigoError("0");     
                     salidaDeuda.setMontoTotal(resultado.getCargarDatosSalida().getCliente().get(0).getDeuda().doubleValue());
                     salidaDeuda.setIdentificadorDeuda(resultado.getCargarDatosSalida().getCliente().get(0).getIdentificacion());
                     salidaDeuda.setNombreCliente(resultado.getCargarDatosSalida().getCliente().get(0).getNombreCliente());
                     salidaDeuda.setMensajeUsuario(resultado.getCargarDatosSalida().getCliente().get(0).getMensajeError());
                        
                     log.info("COD ERROR: " + resultado.getCargarDatosSalida().getCliente().get(0).getCodigoError());
                     log.info("MSG ERROR: " + resultado.getCargarDatosSalida().getCliente().get(0).getMensajeError());
                     log.info("IDENTIFICACIÓN: " + resultado.getCargarDatosSalida().getCliente().get(0).getIdentificacion());
                     log.info("CLIENTE: " + resultado.getCargarDatosSalida().getCliente().get(0).getNombreCliente());
                     log.info("DEUDA: " + resultado.getCargarDatosSalida().getCliente().get(0).getDeuda());
                     
	               }           	 
	               else {
	             	   salidaDeuda.setCodigoError(resultado.getCargarDatosSalida().getCliente().get(0).getCodigoError()); 
	                   salidaDeuda.setMensajeUsuario(resultado.getCargarDatosSalida().getCliente().get(0).getMensajeError());      
	             	   log.info("COD ERROR: " + resultado.getCargarDatosSalida().getCliente().get(0).getCodigoError());
	                   log.info("MSG ERROR: " + resultado.getCargarDatosSalida().getCliente().get(0).getMensajeError());
	               }
        		
        	}else if (resultado.getMensajeError() != null )
        	{  		
        		   salidaDeuda.setCodigoError(resultado.getMensajeError().getCodigoError()); 
                   salidaDeuda.setMensajeUsuario(resultado.getMensajeError().getMensajeError());      
             	   log.info("COD ERROR: " + resultado.getMensajeError().getCodigoError());
                   log.info("MSG ERROR: " + resultado.getMensajeError().getMensajeError());     		      		
        		
        	}else {
	       		 salidaDeuda.setCodigoError("99"); 
	             salidaDeuda.setMensajeUsuario("ERROR EN CONSULTAR CMA");      
	       	     log.info("COD ERROR: 99" );
	             log.info("MSG ERROR: ERROR EN CONSULTAR CMA");
	        }
        		
 
           
           
            return salidaDeuda;
            
        } catch (Exception e) {
            throw new IllegalArgumentException("Error al ejecutar salida Consulta deuda CMA: " + e.getMessage());
        }
    }


    public MensajeSalidaEjecutarPago ejecutarPago(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago) {
        MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago = new MensajeSalidaEjecutarPago();
        mensajeSalidaEjecutarPago.setCodigoError("0");
        mensajeSalidaEjecutarPago.setMensajeUsuario("PAGO EXISTOSO");

        try {

            System.setProperty(JAVA_TRUESTORE, applicationProperties.truststore().path());
            System.setProperty(JAVA_TRUESTORE_PASS, applicationProperties.truststore().password());
            System.setProperty(JAVA_TRUESTORE_TYPE, applicationProperties.truststore().type());
           
            
            log.info("SECUENCIAL: " + mensajeEntradaEjecutarPago.getSecuencial());
            log.info("CANAL: " + mensajeEntradaEjecutarPago.getCanal());
            log.info("IDENTIFICADOR: " + mensajeEntradaEjecutarPago.getServicio().getIdentificador());
            log.info("VALOR: " + mensajeEntradaEjecutarPago.getValorPago());
            
            RegistrarPagoBancoEntrada registrarPagoBancoEntrada =  new RegistrarPagoBancoEntrada();
            registrarPagoBancoEntrada.setTipoProceso("1");
            registrarPagoBancoEntrada.setTipoIdentificacion("1");
            registrarPagoBancoEntrada.setIdentificacion(mensajeEntradaEjecutarPago.getServicio().getIdentificador());          
            registrarPagoBancoEntrada.setReferencia(mensajeEntradaEjecutarPago.getServicio().getIdentificador());
            registrarPagoBancoEntrada.setMonedaPago("USD");
            registrarPagoBancoEntrada.setValorPago(BigDecimal.valueOf(mensajeEntradaEjecutarPago.getValorPago()));
            registrarPagoBancoEntrada.setSecuencialPago(mensajeEntradaEjecutarPago.getSecuencial());
            registrarPagoBancoEntrada.setFechaPago(GeneralUtils.formatearFechaGregorian2(new Date()));
            registrarPagoBancoEntrada.setHoraPago(GeneralUtils.formatearFechaTiempo( new Date(),"HH:mm:ss"));
            registrarPagoBancoEntrada.setCanalProceso(mensajeEntradaEjecutarPago.getCanal());
            registrarPagoBancoEntrada.setCodigoBanco("BOL");
            registrarPagoBancoEntrada.setFormaPago(mensajeEntradaEjecutarPago.getTipoCuenta());
           
            Converter converterXML = ConverterFactory.getConverter(ContentTypeEnum.XML);
            convertirDeObjetoByPagoRq(converterXML, registrarPagoBancoEntrada);
                   
            Resultado resultado = this.cmaServiceWSSoap.registrarPagoBancoEntrada(
            		registrarPagoBancoEntrada.getTipoProceso(), 
            		registrarPagoBancoEntrada.getTipoIdentificacion(), 
            		registrarPagoBancoEntrada.getIdentificacion(), 
            		registrarPagoBancoEntrada.getReferencia(), 
            		registrarPagoBancoEntrada.getMonedaPago(), 
            		registrarPagoBancoEntrada.getValorPago(), 
            		registrarPagoBancoEntrada.getSecuencialPago(), 
            		registrarPagoBancoEntrada.getFechaPago(), 
            		registrarPagoBancoEntrada.getHoraPago(), 
            		registrarPagoBancoEntrada.getCanalProceso(), 
            		registrarPagoBancoEntrada.getCodigoBanco(), 
            		registrarPagoBancoEntrada.getFormaPago());
                    	        
      
                convertirDeObjetoByPagoRs(converterXML, resultado);
                mensajeSalidaEjecutarPago = salidaPago(resultado);

            /*MensajeSalidaEjecutarPago mensajeSalida = new MensajeSalidaEjecutarPago();

            mensajeSalida.setCodigoError("0");
            mensajeSalida.setMensajeUsuario("OK");
            mensajeSalida.setMensajeSistema("OK");
            mensajeSalida.setReferencia(mensajeEntradaEjecutarPago.getServicio().getIdentificador());
            mensajeSalida.setFechaPago(GeneralUtils.formatearFechaGregorian2(new Date()));
            mensajeSalida.setFechaDebito(GeneralUtils.formatearFechaGregorian2(new Date()));
            mensajeSalida.setMontoTotal(mensajeEntradaEjecutarPago.getValorPago());


            mensajeSalidaEjecutarPago = mensajeSalida;
            */
            
        } catch (Exception e) {
            log.error("ERROR AL EJECUTAR PAGO CMA: " + e.getMessage(), e);
            log.info("TIPO EXCEPCION: " + e.getClass());
            return validateException(e);
        }
        return mensajeSalidaEjecutarPago;

    }

    private MensajeSalidaEjecutarPago salidaPago(Resultado resultado) {
        MensajeSalidaEjecutarPago mensajeSalida = new MensajeSalidaEjecutarPago();

        try {
      
            	
        	if (resultado.getRegistrarPagoBancoSalida() != null)
        	{
        		if (resultado.getRegistrarPagoBancoSalida().getCodigoError().equals("0000")) {
        			
        			mensajeSalida.setCodigoError("0");
                	mensajeSalida.setMensajeUsuario(resultado.getRegistrarPagoBancoSalida().getMensajeError());
                	mensajeSalida.setMensajeSistema(resultado.getRegistrarPagoBancoSalida().getMensajeError());
                    mensajeSalida.setReferencia(resultado.getRegistrarPagoBancoSalida().getIdentificacion());
                	mensajeSalida.setFechaPago(GeneralUtils.formatearFechaGregorian2(new Date()));
                    mensajeSalida.setFechaDebito(GeneralUtils.formatearFechaGregorian2(new Date()));
                    mensajeSalida.setMontoTotal(resultado.getRegistrarPagoBancoSalida().getValorPago().doubleValue());
                   
                    log.info("COD ERROR: " + resultado.getRegistrarPagoBancoSalida().getCodigoError());
                    log.info("MSG ERROR: " + resultado.getRegistrarPagoBancoSalida().getMensajeError());
                    log.info("SECUENCIAL: " + resultado.getRegistrarPagoBancoSalida().getSecuencialPago());
                    log.info("TIPO ID: " + resultado.getRegistrarPagoBancoSalida().getTipoIdentificacion());
                    log.info("IDENTIFICACIÓN: " + resultado.getRegistrarPagoBancoSalida().getIdentificacion());
                    log.info("VALOR: " + resultado.getRegistrarPagoBancoSalida().getValorPago());
                    
        		} else {
        			
        			mensajeSalida.setCodigoError(resultado.getRegistrarPagoBancoSalida().getCodigoError());
                	mensajeSalida.setMensajeUsuario(resultado.getRegistrarPagoBancoSalida().getMensajeError());
                	mensajeSalida.setMensajeSistema(resultado.getRegistrarPagoBancoSalida().getMensajeError());
        			
        		    log.info("COD ERROR: " + resultado.getRegistrarPagoBancoSalida().getCodigoError());
                    log.info("MSG ERROR: " + resultado.getRegistrarPagoBancoSalida().getMensajeError());
        		
        		}
        		
                
        	} else if ( resultado.getMensajeError() != null)  {
        		
        		mensajeSalida.setCodigoError(resultado.getMensajeError().getCodigoError());
            	mensajeSalida.setMensajeUsuario(resultado.getMensajeError().getMensajeError());
            	 log.info("COD ERROR: " + resultado.getMensajeError().getCodigoError());
                 log.info("MSG ERROR: " + resultado.getMensajeError().getMensajeError());
                 
        	}else {
        		mensajeSalida.setCodigoError("99"); 
        		mensajeSalida.setMensajeUsuario("ERROR EN PAGO CMA");      
	       	    log.info("COD ERROR: 99" );
	            log.info("MSG ERROR: ERROR EN PAGO CMA");
        	}
        	
        	
            
        } catch (Exception e) {
            log.error("Error al salida pago CMA: " + e.getMessage(), e);
            throw new IllegalArgumentException(e);

        }
        return mensajeSalida;
    }

    
    public MensajeSalidaEjecutarPago ejecutarReverso(MensajeEntradaEjecutarReverso mensajeEntradaEjecutarReverso) {
        MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago;
        try {
            System.setProperty(JAVA_TRUESTORE, applicationProperties.truststore().path());
            System.setProperty(JAVA_TRUESTORE_PASS, applicationProperties.truststore().password());
            System.setProperty(JAVA_TRUESTORE_TYPE, applicationProperties.truststore().type());

            List<DatoAdicional> datosAdicionales = mensajeEntradaEjecutarReverso.getServicio().getDatosAdicionales().getDatoAdicional();

            if (mensajeEntradaEjecutarReverso.getDatosAdicionales() != null && mensajeEntradaEjecutarReverso.getDatosAdicionales().getDatoAdicional() != null
                    && !mensajeEntradaEjecutarReverso.getDatosAdicionales().getDatoAdicional().isEmpty()) {
                datosAdicionales.addAll(mensajeEntradaEjecutarReverso.getDatosAdicionales().getDatoAdicional());
            }

            String secuencial = GeneralUtils.obtenerDatoAdicional("e_ssn_corr", datosAdicionales);

            
            log.info("SSN CORR: " + secuencial) ;
            log.info("CANAL: " + mensajeEntradaEjecutarReverso.getCanal());
            log.info("IDENTIFICADOR: " + mensajeEntradaEjecutarReverso.getServicio().getIdentificador());
            log.info("VALOR: " + mensajeEntradaEjecutarReverso.getValorPago());
            
            RegistrarPagoBancoEntrada registrarPagoBancoEntrada =  new RegistrarPagoBancoEntrada();
            registrarPagoBancoEntrada.setTipoProceso("2");
            registrarPagoBancoEntrada.setTipoIdentificacion("1");
            registrarPagoBancoEntrada.setIdentificacion(mensajeEntradaEjecutarReverso.getServicio().getIdentificador());          
            registrarPagoBancoEntrada.setReferencia(mensajeEntradaEjecutarReverso.getServicio().getIdentificador());
            registrarPagoBancoEntrada.setMonedaPago("USD");
            registrarPagoBancoEntrada.setValorPago(BigDecimal.valueOf(mensajeEntradaEjecutarReverso.getValorPago()));
            registrarPagoBancoEntrada.setSecuencialPago(secuencial);
            registrarPagoBancoEntrada.setFechaPago(GeneralUtils.formatearFechaGregorian2(new Date()));
            registrarPagoBancoEntrada.setHoraPago(GeneralUtils.formatearFechaTiempo( new Date(),"HH:mm:ss"));
            registrarPagoBancoEntrada.setCanalProceso(mensajeEntradaEjecutarReverso.getCanal());
            registrarPagoBancoEntrada.setCodigoBanco("BOL");
            registrarPagoBancoEntrada.setFormaPago(mensajeEntradaEjecutarReverso.getTipoCuenta());
            
            Converter converterXML = ConverterFactory.getConverter(ContentTypeEnum.XML);
            convertirDeObjetoByReversoRq(converterXML, registrarPagoBancoEntrada);
                   
            Resultado resultado = this.cmaServiceWSSoap.registrarPagoBancoEntrada(
            		registrarPagoBancoEntrada.getTipoProceso(), 
            		registrarPagoBancoEntrada.getTipoIdentificacion(), 
            		registrarPagoBancoEntrada.getIdentificacion(), 
            		registrarPagoBancoEntrada.getReferencia(), 
            		registrarPagoBancoEntrada.getMonedaPago(), 
            		registrarPagoBancoEntrada.getValorPago(), 
            		registrarPagoBancoEntrada.getSecuencialPago(), 
            		registrarPagoBancoEntrada.getFechaPago(), 
            		registrarPagoBancoEntrada.getHoraPago(), 
            		registrarPagoBancoEntrada.getCanalProceso(), 
            		registrarPagoBancoEntrada.getCodigoBanco(), 
            		registrarPagoBancoEntrada.getFormaPago());
                    	        
      
                convertirDeObjetoByReversoRs(converterXML, resultado);
                mensajeSalidaEjecutarPago = salidaPago(resultado);

        //mensajeSalidaEjecutarPago = null;
    

        } catch (Exception e) {
            log.error("ERROR AL EJECUTAR REVERSO CMA: " + e.getMessage(), e);
            log.info("TIPO EXCEPCION: " + e.getClass());
            return validateException(e);
        }

        return mensajeSalidaEjecutarPago;
    }

    
    private MensajeSalidaEjecutarPago validateException(Exception e) {
        if (e instanceof WebServiceException) {
            return webServiceException(e);
        } else if (e instanceof SocketTimeoutException || e instanceof ReadTimeoutException || e instanceof TimeoutException || e instanceof ConnectTimeoutException) {
            return this.buildErrorMessage(EMPRESA_DESTINO_NO_DISPONIBLE, e.getMessage(), REV_001);
        } else if (e instanceof ConnectException) {
            return this.buildErrorMessage("ERROR DE CONEXION", e.getMessage(), "CMA_001");
        }

        return this.buildErrorMessage(ERROR_CONSUMIR_PROVEEDOR, e.getMessage(), CMA_003);

    }
    
    private MensajeSalidaEjecutarPago webServiceException(Exception e) {
        StackTraceElement[] stktrace = e.getStackTrace();
        String trace = e.getMessage();
        log.info("TRACE: " + e.getMessage());
        if (trace != null && (trace.contains(COULD_NOT_RECEIVE_MSG) || trace.contains(JAVA_SOCKET_TIMEOUT_EXP) || trace.contains(READ_TIME_OUT) || trace.contains(IO_NETTY_READ_TIMEOUT_EXP))) {
            return this.buildErrorMessage(EMPRESA_DESTINO_NO_DISPONIBLE, e.getMessage(), REV_001);
        }
        // print element of stktrace
        for (int i = 0; i < stktrace.length; i++) {
            trace = stktrace[i].toString();
            log.info("TRACE: " + trace);
            if (trace != null && (trace.contains(COULD_NOT_RECEIVE_MSG) || trace.contains(JAVA_SOCKET_TIMEOUT_EXP) || trace.contains(READ_TIME_OUT) || trace.contains(IO_NETTY_READ_TIMEOUT_EXP))) {
                return this.buildErrorMessage(EMPRESA_DESTINO_NO_DISPONIBLE, e.getMessage(), REV_001);
            }
        }
        return this.buildErrorMessage(ERROR_CONSUMIR_PROVEEDOR, e.getMessage(), CMA_003);

    }
    
    private MensajeSalidaEjecutarPago buildErrorMessage(String message, String techMessage, String code) {
        MensajeSalidaEjecutarPago msep = new MensajeSalidaEjecutarPago();
        msep.setCodigoError(code);
        msep.setMensajeUsuario(message);
        msep.setMensajeSistema(techMessage);
        return msep;
    }
    
}