package com.bolivariano.microservice.otp.service;

import java.io.IOException;
import java.net.URL;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.xml.ws.BindingProvider;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.AbandonedConfig;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesPortType;
import com.bolivariano.microservice.notification_gateway.microservicio.notificationgateway.NotificacionesSOAPService;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.CoreUtils;
import com.bolivariano.microservice.otp.utils.LogsUtils;

import bolivariano.fin.ec.wsentrust.service.EntrustService;
import bolivariano.fin.ec.wsentrust.service.EntrustServicePortType;
import ec.com.bolivariano.otp.manager.OTPManager;
import ec.com.bolivariano.otp.manager.ServiceOTP;

@Service
public class WebServiceConfig {
	private static final LogsUtils logger = LogsUtils.getLogger(WebServiceConfig.class);

	// LatiniaService
	@Value("${client.ws.address.latinia.url}")
	private String latiniaURL;
	@Value("${client.ws.address.latinia.conntimeout}")
	private int latiniaConnTimeout;
	@Value("${client.ws.address.latinia.readtimeout}")
	private int latiniaReadTimeout;
	private String nameLatinia = "NotificacionLatinia";

	// EntrustService
	@Value("${client.ws.address.entrustUtil.url}")
	private String entrustUtilURL;
	@Value("${client.ws.address.entrustUtil.conntimeout}")
	private int entrustUtilConnTimeout;
	@Value("${client.ws.address.entrustUtil.readtimeout}")
	private int entrustUtilReadTimeout;
	private String nameEntrust = "EntrustService";

	// Bayted
	@Value("${client.ws.address.bayted.url}")
	private String baytedURL;
	@Value("${client.ws.address.bayted.conntimeout}")
	private int baytedConnTimeout;
	@Value("${client.ws.address.bayted.readtimeout}")
	private int baytedReadTimeout;
	private String nameBayted = "BaytedService";

	// SSL
	@Value("${client.ssl.trustStore}")
	private String truestore;
	@Value("${client.ssl.trustStorePassword}")
	private String trustStorePassword;

	// Config pool
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

	private GenericObjectPool<EntrustServicePortType> poolclienteEntrust = null;
	private GenericObjectPool<NotificacionesPortType> poolClienteLatinia = null;
	private GenericObjectPool<OTPManager> poolclienteBayted = null;

	@PostConstruct
	private void setSSL() {
		System.setProperty("javax.net.ssl.trustStore", truestore);
		System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
		try {
			initPool();
		} catch (Exception e) {
			Date startTime = new Date();
			logger.error(WebServiceConfig.class.getName(), "setSSL", CoreUtils.dateToString(startTime),
					CoreUtils.getTimeIntervalInt(startTime), null, e.toString());
		}
	}

	private synchronized void initPool() {
		try {
			if (poolClienteLatinia == null) {
				poolClienteLatinia = new GenericObjectPool<>(new WSClientPoolFactory<>(NotificacionesPortType.class, latiniaURL));
				setConfigPool(poolClienteLatinia);
				poolClienteLatinia.preparePool();
			}
		} catch (Exception e) {
			showLogErrors(nameLatinia, e);
		}

		try {
			if (poolclienteEntrust == null) {
				poolclienteEntrust = new GenericObjectPool<>(
						new WSClientPoolFactory<>(EntrustServicePortType.class, entrustUtilURL));
				setConfigPool(poolclienteEntrust);
				poolclienteEntrust.preparePool();
			}

		} catch (Exception e) {
			showLogErrors(nameEntrust, e);
		}

		try {
			if (poolclienteBayted == null) {
				poolclienteBayted = new GenericObjectPool<>(new WSClientPoolFactory<>(OTPManager.class, baytedURL));
				setConfigPool(poolclienteBayted);
				poolclienteBayted.preparePool();
			}

		} catch (Exception e) {
			showLogErrors(nameBayted, e);
		}

	}

	private void showLogErrors(String name, Exception e) {
		Date startTime = new Date();
		logger.error(WebServiceConfig.class.getName(), name, CoreUtils.dateToString(startTime),
				CoreUtils.getTimeIntervalInt(startTime), null, e.toString());
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
	

	public EntrustServicePortType clienteEntrustUtil(String proceso) throws OTPException {
		Date startTime = new Date();

		if (poolclienteEntrust == null)
			initPool();
		EntrustServicePortType clienteEntrust;
		try {
			clienteEntrust = poolclienteEntrust.borrowObject();
			logger.tiempo(proceso, nameEntrust, CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime),
					null, entrustUtilConnTimeout - 1000);
		} catch (Exception e) {
			throw new OTPException(e);
		}
		setTimeouts((BindingProvider) clienteEntrust, entrustUtilConnTimeout, entrustUtilReadTimeout);
		
		return clienteEntrust;

	}

		public OTPManager clientebayted(String proceso) {
		Date startTime = new Date();
		try {
			if (poolclienteBayted == null){
				initPool();
				OTPManager clienteBayted = poolclienteBayted.borrowObject();
				setTimeouts((BindingProvider) clienteBayted, baytedConnTimeout, baytedReadTimeout);
				logger.tiempo(proceso, nameBayted, CoreUtils.dateToString(startTime),CoreUtils.getTimeIntervalInt(startTime), null, baytedConnTimeout - 1000);
				return clienteBayted;
			}
			return poolclienteBayted.borrowObject();

		} catch (Exception e) {
			logger.error(proceso, nameBayted, CoreUtils.dateToString(startTime),CoreUtils.getTimeIntervalInt(startTime), null, e.toString());
			return null;
		}

	}

	public NotificacionesPortType clienteLatinia(String proceso) {
		Date startTime = new Date();
		try {
			if (poolClienteLatinia == null)
				initPool();
			NotificacionesPortType clienteUtilitario = poolClienteLatinia.borrowObject();
			setTimeouts((BindingProvider) clienteUtilitario, latiniaConnTimeout, latiniaReadTimeout);

			logger.tiempo(proceso, nameLatinia, CoreUtils.dateToString(startTime),
					CoreUtils.getTimeIntervalInt(startTime), null, latiniaConnTimeout - 1000);

			return clienteUtilitario;
		} catch (Exception e) {
			logger.error(proceso, nameLatinia, CoreUtils.dateToString(startTime),
					CoreUtils.getTimeIntervalInt(startTime), null, e.toString());
			return null;
		}

	}

	private void setTimeouts(BindingProvider serviceClass, int connTimeout, int readTimeout) {
		Client cxfClient = ClientProxy.getClient(serviceClass);
		HTTPConduit httpConduit = (HTTPConduit) cxfClient.getConduit();
		HTTPClientPolicy httpClientPolicy = new HTTPClientPolicy();
		httpClientPolicy.setConnectionRequestTimeout(connTimeout);
		httpClientPolicy.setConnectionTimeout(connTimeout);
		httpClientPolicy.setReceiveTimeout(readTimeout);
		httpConduit.setClient(httpClientPolicy);
	}

	public synchronized void returnObject(Object client) {
		if (client instanceof EntrustServicePortType) {
			poolclienteEntrust.returnObject((EntrustServicePortType) client);
		} else if (client instanceof NotificacionesPortType) {
			poolClienteLatinia.returnObject((NotificacionesPortType) client);
		} else if (client instanceof OTPManager) {
			poolclienteBayted.returnObject((OTPManager) client);
		}
	}

	public class WSClientPoolFactory<T> extends BasePooledObjectFactory<T> {

		private Class<?> clazz;
		NotificacionesSOAPService notificacionesSOAPService;
		EntrustService entrustService;
		ServiceOTP serviceOTP;

		public WSClientPoolFactory(Class<?> clazz, String wsdl) throws IOException {
			this.clazz = clazz;
			if (clazz == NotificacionesPortType.class) {
				notificacionesSOAPService = new NotificacionesSOAPService(new URL(wsdl));
			} else if (clazz == EntrustServicePortType.class) {
				entrustService = new EntrustService(new URL(wsdl));
			} else if (clazz == OTPManager.class) {							
				serviceOTP = new ServiceOTP(new URL(wsdl));
			}
		}

		@SuppressWarnings("unchecked")
		@Override
		public T create() throws Exception {
			T type = null;
			if (clazz == NotificacionesPortType.class) {
				NotificacionesPortType clienteLatinia = notificacionesSOAPService
						.getNotificacionesSOAP11BindingQSPort();
				type = (T) clienteLatinia;
			} else if (clazz == EntrustServicePortType.class) {
				EntrustServicePortType clienteEntrust = entrustService.getEntrustServicePort();
				type = (T) clienteEntrust;
			} else if (clazz == OTPManager.class) {
				OTPManager clienteBayted = serviceOTP.getWsHttpEndpoint();
				BindingProvider bp = (BindingProvider)clienteBayted;
				bp.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, baytedURL);
				type = (T) clienteBayted;
			}
			return type;
		}

		@SuppressWarnings("unchecked")
		@Override
		public PooledObject<T> wrap(Object obj) {
			return (PooledObject<T>) new DefaultPooledObject<>((T) obj);
		}

	}
}
