package com.bolivariano.microservice.recbroadnet.configuration;

import io.quarkus.runtime.annotations.StaticInitSafe;
import io.smallrye.config.ConfigMapping;
import io.smallrye.config.ConfigMapping.NamingStrategy;

import javax.inject.Named;
import java.util.List;

/**
 * 
 * @author Gizlo-Fernando Andrade
 *         <p>
 *         Interface para mapear los properties con el prefijo mi-claro-app-api
 *
 */
@StaticInitSafe
@ConfigMapping(prefix = "broadnet", namingStrategy = NamingStrategy.VERBATIM)
@Named("applicationConfig")
public interface ApplicationProperties {

	Provider provider();

	Banco banco();

	List<ParametrosEmpresa> parametrosEmpresa();

	MQ mq();

	Sybase sybase();

	FrameworkSeguridad frameworkSeguridad();

	Truststore truststore();
	
	TCP tcp();
	
	Iso8583xml iso8583xml();
	

	interface Provider {
		Integer connTimeout();

		Integer connRequestTimeout();

		Integer readTimeout();

		String formatoFecha();

		String formatoFechaContable4();

		String formatoFechaContable6();

		String formatoTiempo();

		String posEntryMode();

		String networkId();

		String posConditionCode();

		String terminalId();

		String merchantId();

		String codigoCajero();

		String processingCodeAhorro();

		String processingCodeCte();

		String processingCodeDef();
	}

	interface Banco {
		String bancoFormatoFechaContable();

		String codigoTipoCuentaAho();

		String codigoTipoCuentaCte();

		String codigoDatoAdicionalFechaContable();

		String codigoDatoAdicionalEfectivo();

		String codigoDatoAdicionalDebito();

		String codigoDatoAdicionalUbicacion();
	}

	interface ParametrosEmpresa {
		String empresa();

		String codigoServicio();

		String codigoProducto();

		String codigoEmpresa();

		String dispositivo();
		
		String tabla();
	}

	interface MQ {
		String host();

		Integer port();

		String channel();

		String queueManager();

		String queueRequest();

		String queueReplay();

		Integer poolJms();

		Integer delayReconnect();

		Long timeToLive();

		Integer characterSet();
	}
	

	interface Sybase {
		int queryTimeout();
	}
	

	interface Truststore {

		String path();

		String password();

		String type();

	}
	
	interface FrameworkSeguridad {
		String url();
		
		int connTimeout();
		
		int readTimeout();

		int idAplicacion();

		String usuarioApl();

	}
	
	interface TCP{
		String host();
		
		String port();
		
		int timeout();
	}

	interface Iso8583xml{
		String url();
		
		int connTimeout();
		
		int readTimeout();
	}
	
}
