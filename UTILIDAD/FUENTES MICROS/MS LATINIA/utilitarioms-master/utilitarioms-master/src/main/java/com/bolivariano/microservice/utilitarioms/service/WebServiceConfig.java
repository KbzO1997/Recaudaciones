package com.bolivariano.microservice.utilitarioms.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.xml.ws.BindingProvider;

import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.AbandonedConfig;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.cxf.Bus;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.jaxws.JaxWsClientProxy;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.apache.cxf.ws.policy.PolicyBuilder;
import org.apache.cxf.ws.policy.PolicyConstants;
import org.apache.http.HttpHost;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.neethi.Policy;
import org.apache.wss4j.common.crypto.Merlin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.DefaultUriTemplateHandler;

import com.bolivariano.homologarmensaje.HomologarMensaje;
import com.bolivariano.homologarmensaje.HomologarMensaje_Service;
import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesPortType;
import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesSOAPService;


@Service
public class WebServiceConfig {

	private final static Logger logger = LoggerFactory.getLogger(WebServiceConfig.class);
	
	@Value("${client.ws.address.cmm.url}")
	private String cmmURL;
	@Value("${client.ws.address.cmm.conntimeout}")
	private int cmmConnTimeout;
	@Value("${client.ws.address.cmm.readtimeout}")
	private int cmmReadTimeout;
	@Value("${client.ws.address.cmm.maxopenconnections}")
	private int cmmMaxOpenConnections;
	@Value("${client.ws.address.cmm.requestconntimeout}")
	private int cmmRequestConnTimeout;
	
	
	@Value("${client.ws.address.conectorLatinia.url}")
	private String conectorLatiniaURL;
	@Value("${client.ws.address.conectorLatinia.conntimeout}")
	private int conectorLatiniaConnTimeout;
	@Value("${client.ws.address.conectorLatinia.readtimeout}")
	private int conectorLatiniaReadTimeout;
				
	@Value("${client.ws.address.homologarMensaje.url}")
	private String homologarMensajeURL;
	@Value("${client.ws.address.homologarMensaje.conntimeout}")
	private int homologarMensajeConntimeout;
	@Value("${client.ws.address.homologarMensaje.readtimeout}")
	private int homologarMensajeReadtimeout;
	
	@Value("${client.ssl.trustStore}")
	private String trustStore;
	@Value("${client.ssl.trustStorePassword}")
	private String trustStorePassword;
	
	//BMK-2064 dvillavc 2020/09/01
	@Value("${client.service.latinia.username}")
	private String usernameLatinia;
	@Value("${client.service.latinia.password}")
	private String passwordLatinia;
	@Value("${client.service.latinia.encrypUsername}")
	private String encryptUsernameLatinia;
	@Value("${client.service.latinia.encrypPassword}")
	private String encryptPasswordLatinia;
	//BMK-2064 dvillavc 2020/09/01
	
	
	private Policy wsSecuritypolicy = null;	//BMK-2064 dvillavc 2020/09/01	
	
	private GenericObjectPool<HomologarMensaje> poolHomologarMensaje = null;
	private GenericObjectPool<NotificacionesPortType> poolNotificaciones = null;

	@Value("${client.ws.rest-max-total}")
	private int restMaxTotal;
	@Value("${client.ws.rest-default-max-per-route}")
	private int restMaxPerRouteDefault;	
	@Value("${client.ws.pool-max-total}")
	private int poolmaxtotal;
	@Value("${client.ws.pool-max-idle}")
	private int poolmaxidle;
	@Value("${client.ws.pool-min-idle}")
	private int poolminidle;
	@Value("${client.ws.pool-min-idle-time}")
	private int poolminidletime;
	@Value("${client.ws.pool-remove-abandoned-timeout}")
	private int poolremoveabandonedtimeout;

	private RestTemplate clienteCMM = null;
	
	
	
	@PostConstruct
	private void setSSL() {
		System.setProperty("javax.net.ssl.trustStore", trustStore);
		System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
		try {
			initPools();
		} catch (Exception e) {
			logger.error("error cargando los clientes webservice", e);
		}
	}
	
	private synchronized void initPools() throws Exception {
		if (poolNotificaciones == null) {
			poolNotificaciones = new GenericObjectPool<>(
					new WSClientPoolFactory<>(NotificacionesPortType.class, conectorLatiniaURL));
			setConfigPool(poolNotificaciones);
			poolNotificaciones.preparePool();
		}
		
		if (poolHomologarMensaje == null) {
			poolHomologarMensaje = new GenericObjectPool<>(
					new WSClientPoolFactory<>(HomologarMensaje.class, homologarMensajeURL));
			setConfigPool(poolHomologarMensaje);
			poolHomologarMensaje.preparePool();
		}
	}
	
	private void setConfigPool(GenericObjectPool<?> genericPool) {
		final AbandonedConfig abandonedConfig = new AbandonedConfig();
		abandonedConfig.setRemoveAbandonedTimeout(poolremoveabandonedtimeout);
		abandonedConfig.setLogAbandoned(true);
		abandonedConfig.setUseUsageTracking(true);
		abandonedConfig.setRemoveAbandonedOnBorrow(true);
		abandonedConfig.setRemoveAbandonedOnMaintenance(true);

		genericPool.setMaxTotal(poolmaxtotal);
		genericPool.setMaxIdle(poolmaxidle);
		genericPool.setMinIdle(poolminidle);
		genericPool.setMinEvictableIdleTimeMillis(poolminidletime);
		genericPool.setAbandonedConfig(abandonedConfig);
		genericPool.setBlockWhenExhausted(false);

	}
	
	
	public synchronized void returnObject(Object client) {
		if (client instanceof NotificacionesPortType) {
			poolNotificaciones.returnObject((NotificacionesPortType) client);
		} else if (client instanceof HomologarMensaje) {
			poolHomologarMensaje.returnObject((HomologarMensaje) client);
		} 

	}

	/*
	private void setBindingProviderSecurity(BindingProvider bindingProvider, String address) throws Exception{
		
		try {
			Map<String, Object> reqContext = bindingProvider.getRequestContext();
			reqContext.put("security.encryption.username", encrypUsername);
			reqContext.put("ws-security.username", busUsername);
			reqContext.put("ws-security.password", busPassword);
			reqContext.put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, address);
			reqContext.put("ws-security.is-bsp-compliant", "false");
            Merlin issuerCrypto = new Merlin();
            KeyStore keyStore = KeyStore.getInstance("JKS");
            File keyStoreFile = new File(truestore);
			InputStream input = new FileInputStream(keyStoreFile);
	        keyStore.load(input, trustStorePassword.toCharArray());
	        issuerCrypto.setKeyStore(keyStore);
	        reqContext.put("security.signature.crypto", issuerCrypto);
	        reqContext.put("security.encryption.crypto", issuerCrypto);	        	
			
		} catch (KeyStoreException | IOException | NoSuchAlgorithmException | CertificateException e) {
			logger.error("error cargando el certificado de encriptacion del servicio", e);
			throw e;
		} 			
	}*/
	
	//BMK-2064 dvillavc 2020/09/01	
	private void setSecurityLatinia(BindingProvider bindingProvider) throws Exception{
		Map<String, Object> reqContext = bindingProvider.getRequestContext();
		reqContext.put("security.encryption.username", encryptUsernameLatinia);
		reqContext.put("ws-security.username", usernameLatinia);
		reqContext.put("ws-security.password", passwordLatinia);
		if(wsSecuritypolicy == null) {
			InvocationHandler invocationHandler = Proxy.getInvocationHandler(bindingProvider);
			Bus bus = ((JaxWsClientProxy)invocationHandler).getClient().getBus();
			InputStream is = this.getClass().getResourceAsStream("/oswm-wss11-policy.xml");
			PolicyBuilder builder = bus.getExtension(org.apache.cxf.ws.policy.PolicyBuilder.class);
			wsSecuritypolicy = builder.getPolicy(is);			
		}
		reqContext.put(PolicyConstants.POLICY_OVERRIDE, wsSecuritypolicy);
	}
	
	
	private void setBindingProviderSecurity(BindingProvider bindingProvider, String address) throws Exception{
		
		try {
			Map<String, Object> reqContext = bindingProvider.getRequestContext();			
			reqContext.put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, address);			
            Merlin issuerCrypto = new Merlin();
            KeyStore keyStore = KeyStore.getInstance("JKS");
            File keyStoreFile = new File(trustStore);
			InputStream input = new FileInputStream(keyStoreFile);
	        keyStore.load(input, trustStorePassword.toCharArray());
	        issuerCrypto.setKeyStore(keyStore);
	        reqContext.put("security.signature.crypto", issuerCrypto);
	        reqContext.put("security.encryption.crypto", issuerCrypto);	        	
			
		} catch (KeyStoreException | IOException | NoSuchAlgorithmException | CertificateException e) {
			logger.error("error cargando el certificado de encriptacion del servicio", e);
			throw e;
		} 			
	}
	//BMK-2064 dvillavc 2020/09/01
	
	public HomologarMensaje clienteHomologarMensaje() throws Exception{
		/*if(clienteHomologarMensaje == null) {
			HomologarMensaje_Service homologarMensajeService = new HomologarMensaje_Service(new URL(homologarMensajeURL));
			clienteHomologarMensaje =  homologarMensajeService.getHomologarMensajePt();
			setTimeouts((BindingProvider) clienteHomologarMensaje, homologarMensajeConntimeout, homologarMensajeReadtimeout);
		}		
		return clienteHomologarMensaje;*/	
		if (poolHomologarMensaje == null)
			initPools();
		HomologarMensaje clienteHomologarMensaje = poolHomologarMensaje.borrowObject();
		setTimeouts((BindingProvider) clienteHomologarMensaje, homologarMensajeConntimeout,
				homologarMensajeReadtimeout);
		return clienteHomologarMensaje;
    }
	
	//BMK-2064 dvillavc 2020/09/01
	public NotificacionesPortType clienteConectorLatinia() throws Exception{
		if (poolNotificaciones == null)
			initPools();
		
		NotificacionesPortType clienteConectorLatinia = poolNotificaciones.borrowObject();
		setSecurityLatinia((BindingProvider) clienteConectorLatinia);
		setBindingProviderSecurity((BindingProvider) clienteConectorLatinia, conectorLatiniaURL);
		setTimeouts((BindingProvider) clienteConectorLatinia, conectorLatiniaConnTimeout, conectorLatiniaReadTimeout);
		
		/*if(clienteConectorLatinia == null) {
			NotificacionesSOAPService conectorLanitia = new NotificacionesSOAPService(new URL(conectorLatiniaURL));
			clienteConectorLatinia =  conectorLanitia.getNotificacionesSOAP11BindingQSPort();
			setSecurityLatinia((BindingProvider) clienteConectorLatinia);
			setBindingProviderSecurity((BindingProvider) clienteConectorLatinia, conectorLatiniaURL);
			setTimeouts((BindingProvider) clienteConectorLatinia, conectorLatiniaConnTimeout, conectorLatiniaReadTimeout);
		}		*/
		return clienteConectorLatinia;	
    }
	
    public RestTemplate clienteCMM() throws Exception{
    	if(clienteCMM == null) {
    		clienteCMM =  new RestTemplate();
    		DefaultUriTemplateHandler handler = new DefaultUriTemplateHandler();
    	    handler.setBaseUrl(cmmURL);
    	    clienteCMM.setUriTemplateHandler(handler);
			setTimeouts(clienteCMM, cmmConnTimeout, cmmReadTimeout, cmmURL, cmmMaxOpenConnections, cmmRequestConnTimeout);
    	}
		return clienteCMM;
    }
        
	private void setTimeouts(RestTemplate restTemplate, int connTimeout, int readTimeout, String serviceUrl,
			int maxConnections, int requestConnTimeout) {
		PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager();
		connectionManager.setMaxTotal(restMaxTotal);
		connectionManager.setDefaultMaxPerRoute(restMaxPerRouteDefault);
		URL url = null;
		try {
			url = new URL(serviceUrl);
			HttpHost httpHost = new HttpHost(url.getHost(), url.getPort(), url.getProtocol());
			connectionManager.setMaxPerRoute(new HttpRoute(httpHost), maxConnections);
			RequestConfig requestConfig = RequestConfig.custom().setConnectionRequestTimeout(requestConnTimeout)
					.setConnectTimeout(connTimeout).setSocketTimeout(readTimeout).build();
			CloseableHttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig)
					.setConnectionManager(connectionManager).build();
			HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
			clientHttpRequestFactory.setHttpClient(httpClient);
			restTemplate.setRequestFactory(clientHttpRequestFactory);
		} catch (MalformedURLException e) {
			logger.error("La URL del servicio es incorrecta");
		}

	}

    
   
    private void setTimeouts(BindingProvider serviceClass, int connTimeout, int readTimeout) {
    	Client cxfClient = ClientProxy.getClient(serviceClass);
		HTTPConduit httpConduit = (HTTPConduit) cxfClient.getConduit();
		HTTPClientPolicy httpClientPolicy = new HTTPClientPolicy();
		httpClientPolicy.setAllowChunking(false);
		httpClientPolicy.setConnectionRequestTimeout(connTimeout);
		httpClientPolicy.setConnectionTimeout(connTimeout);
		httpClientPolicy.setReceiveTimeout(readTimeout);
		httpConduit.setClient(httpClientPolicy);
    }
    
    /*public void resetClient(Object client){
    	if(client instanceof RestTemplate) {
    		clienteCMM = null;
    	}else if(client instanceof NotificacionesPortType) {
    		clienteConectorLatinia = null;
    	}else if(client instanceof IWSLoginSimplified) {
    		loginSimplified = null;
    	}
    }*/
    
    
    public class WSClientPoolFactory<T> extends BasePooledObjectFactory<T> {

		private Class<?> clazz;
		NotificacionesSOAPService notificacionesSOAPService;
		HomologarMensaje_Service homologarMensaje_Service;

		public WSClientPoolFactory(Class<?> clazz, String wsdl) throws MalformedURLException {
			this.clazz = clazz;

			if (clazz == NotificacionesPortType.class) {
				notificacionesSOAPService = new NotificacionesSOAPService(new URL(wsdl));
			} else if (clazz == HomologarMensaje.class) {
				homologarMensaje_Service = new HomologarMensaje_Service(new URL(wsdl));
			} 
		}

		@SuppressWarnings("unchecked")
		@Override
		public T create() throws Exception {
			T type = null;
			if (clazz == NotificacionesPortType.class) {
				NotificacionesPortType portType = notificacionesSOAPService.getNotificacionesSOAP11BindingQSPort();
				type = (T) portType;
			} else if (clazz == HomologarMensaje.class) {
				HomologarMensaje portType = homologarMensaje_Service.getHomologarMensajePt();
				type = (T) portType;
			}
			return type;
		}

		@SuppressWarnings("unchecked")
		@Override
		public PooledObject<T> wrap(Object obj) {
			return (PooledObject<T>) new DefaultPooledObject<T>((T) obj);
		}

	}
}
