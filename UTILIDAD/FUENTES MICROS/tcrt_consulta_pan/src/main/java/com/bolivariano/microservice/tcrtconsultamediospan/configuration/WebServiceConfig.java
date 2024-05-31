package com.bolivariano.microservice.tcrtconsultamediospan.configuration;

import com.bolivariano.microservice.tcrtconsultamediospan.util.exceptions.WebServiceCreationException;
import com.bolivariano.srvmediosenvio.mediosenvio.v1_0.MediosEnvio;
import com.bolivariano.srvmediosenvio.mediosenvio.v1_0.MediosEnvioPortType;
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

import org.apache.wss4j.common.crypto.Merlin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.Map;

@Service
public class WebServiceConfig {
    // SSL
    @Value("${client.ssl.trustStore}")
    private String truestore;
    @Value("${client.ssl.trustStorePassword}")
    private String trustStorePassword;

    @Value("${client.ws.address.conmedios.url}")
    private String conIdentificacionUrl;

    @Value("${client.ws.address.conmedios.conntimeout}")
    private int conMediosConnTimeout;
    @Value("${client.ws.address.conmedios.readtimeout}")
    private int conMediosReadTimeout;

    @Value("${encryption.usuario}")
    private String conMediosUsuario;
    @Value("${encryption.clave-secundaria}")
    private String conMediosClave;
    @Value("${encryption.valor-secundario}")
    private String conMediosPass;

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

    private static final Logger logger = LoggerFactory.getLogger(WebServiceConfig.class);

    private GenericObjectPool<MediosEnvioPortType> poolClientConsultaMedios = null;

    @PostConstruct
    private void setSSL() {
        System.setProperty("javax.net.ssl.trustStore", truestore);
        System.setProperty("javax.net.ssl.trustStorePassword", trustStorePassword);
        try {
            initPool();
        } catch (Exception e) {
            logger.error("Error al cargar SSL: {}", e.getMessage());
        }
    }

    private synchronized void initPool() {
        try {
            logger.info("Iniciar pool web services");

            if (poolClientConsultaMedios == null) {
                poolClientConsultaMedios = new GenericObjectPool<>(
                        new WSClientPoolFactory<>(MediosEnvioPortType.class, conIdentificacionUrl));
                setConfigPool(poolClientConsultaMedios);
                poolClientConsultaMedios.preparePool();
            }

        } catch (Exception e) {
            logger.error("Error al precargar el servicio: {}", e.getMessage());
        }
    }
    public MediosEnvioPortType clienteConsultaMedios() throws WebServiceCreationException {

        try {
            if (poolClientConsultaMedios == null)
                initPool();
            MediosEnvioPortType clienteConsultaMedios = poolClientConsultaMedios.borrowObject();
            setTimeouts((BindingProvider) clienteConsultaMedios, conMediosConnTimeout, conMediosReadTimeout);

            return clienteConsultaMedios;
        } catch (Exception e) {
            throw new WebServiceCreationException("Error al crear el pool de conexiones", e);
        }
    }

    private void setConfigPool(GenericObjectPool<?> genericPool) {
        final AbandonedConfig abandonedConfig = new AbandonedConfig();
        abandonedConfig.setLogAbandoned(true);
        abandonedConfig.setUseUsageTracking(true);
        abandonedConfig.setRemoveAbandonedOnBorrow(true);
        abandonedConfig.setRemoveAbandonedOnMaintenance(true);

        genericPool.setMaxTotal(poolmaxtotal);
        genericPool.setMaxIdle(poolmaxidle);
        genericPool.setMinIdle(poolminidle);
        genericPool.setAbandonedConfig(abandonedConfig);
        genericPool.setBlockWhenExhausted(false);
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
        if (client instanceof MediosEnvioPortType mediosenvioporttype) {
            poolClientConsultaMedios.returnObject(mediosenvioporttype);
        }
    }


    public class WSClientPoolFactory<T> extends BasePooledObjectFactory<T> {

        private Class<?> clazz;
        MediosEnvio mediosEnvioSoap;

        public WSClientPoolFactory(Class<?> clazz, String wsdl) throws WebServiceCreationException {
            try {
            this.clazz = clazz;
                if (clazz == MediosEnvioPortType.class) {
                    mediosEnvioSoap = new MediosEnvio(new URL(wsdl));
                }
            } catch (Exception e) {
                throw new WebServiceCreationException("Error al instanciar soap MediosEnvio", e);
            }
        }

        @SuppressWarnings("unchecked")
        @Override
        public T create() throws Exception {
            T type = null;
            if (clazz == MediosEnvioPortType.class) {
                MediosEnvioPortType clienteConsultaMedios = mediosEnvioSoap.getMediosEnvioPortType();
                setBindingProviderSecurity((BindingProvider) clienteConsultaMedios, conIdentificacionUrl);
                setConsultaMediosSecurity((BindingProvider) clienteConsultaMedios);
                type = (T) clienteConsultaMedios;
            }

            return type;
        }

        @SuppressWarnings("unused")
        private void setConsultaMediosSecurity(BindingProvider bindingProvider) throws WebServiceCreationException {
            try {
                Map<String, Object> reqContext = bindingProvider.getRequestContext();
                reqContext.put("security.encryption.username", conMediosUsuario);
                reqContext.put("ws-security.username", conMediosClave);
                reqContext.put("ws-security.password", conMediosPass);
            } catch (Exception e){
                throw new WebServiceCreationException("Error al crear el pool de conexiones", e);
            }
        }

        private void setBindingProviderSecurity(BindingProvider bindingProvider, String address) throws WebServiceCreationException {
            try (InputStream input = new FileInputStream(new File(truestore))) {
                Map<String, Object> reqContext = bindingProvider.getRequestContext();
                reqContext.put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, address);
                Merlin issuerCrypto = new Merlin();
                KeyStore keyStore = KeyStore.getInstance("JKS");
                keyStore.load(input, trustStorePassword.toCharArray());
                issuerCrypto.setKeyStore(keyStore);
                reqContext.put("security.signature.crypto", issuerCrypto);
                reqContext.put("security.encryption.crypto", issuerCrypto);
            } catch (IOException | KeyStoreException | NoSuchAlgorithmException | CertificateException e) {
                throw new WebServiceCreationException("Error cargando el certificado de encriptación o la política de seguridad del servicio", e);
            }
        }

        @SuppressWarnings("unchecked")
        @Override
        public PooledObject<T> wrap(Object obj) {
            return new DefaultPooledObject<>((T) obj);
        }

    }
}
