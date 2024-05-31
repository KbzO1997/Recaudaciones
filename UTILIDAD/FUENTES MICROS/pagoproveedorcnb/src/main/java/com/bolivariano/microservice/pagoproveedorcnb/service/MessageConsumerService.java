package com.bolivariano.microservice.pagoproveedorcnb.service;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.event.Observes;
import javax.inject.Inject;
import javax.jms.*;

import io.quarkus.runtime.ShutdownEvent;
import io.quarkus.runtime.StartupEvent;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import com.bolivariano.microservice.pagoproveedorcnb.configuration.MQConnectionFactoryData;

import java.util.Map;
import java.util.Objects;

@ApplicationScoped
public class MessageConsumerService implements Runnable{

    @Inject
    org.jboss.logging.Logger log;

    @ConfigProperty(name = "otc-collector.ibm.mq.queue-request")
    String queueName;
    @ConfigProperty(name = "otc-collector.ibm.mq.delayReconnect")
    Long delayReconnect;
    @ConfigProperty(name = "otc-collector.ibm.mq.poolJms")
    Long poolJms;
    
    @Inject
    @MQConnectionFactoryData
    ConnectionFactory connectionFactory;

    @Inject
    MessageService messageService;
    
    @Inject
	Map<String, String> frameworkSecurityParams;

    private  ExecutorService scheduler;

    void onStart(@Observes StartupEvent event) {
    	int maxThread = poolJms.intValue();
        scheduler = Executors.newFixedThreadPool(maxThread);
        for (int i = 0; i < maxThread; i++) {
            scheduler.submit(this);
        }
    }

    void onStop(@Observes ShutdownEvent event) {
    	log.infof("Shutdown event %s", event);
    	scheduler.shutdown();
    }

    @Override
    public void run() {
        log.info("EJECUTA LISTENER MQ VERSION 9_2" );
        log.info("CONFIG --> " + connectionFactory );
        JMSConsumer consumer = null;
        try(JMSContext context = connectionFactory.createContext(Session.AUTO_ACKNOWLEDGE)) {     
            log.info("COLA MQ --> " + queueName);
            Queue queue = context.createQueue(queueName);
            consumer = context.createConsumer(queue);
            while (true) {
            	log.info("ESPERANDO MENSAJE EN COLA...");
                Message message = consumer.receive();
                log.info("MENSAJE RECIBIDO--> " + message);
                if (Objects.isNull(message)) return;
                String mensajeJMS = message.getBody(String.class);

                String userId = message.getJMSCorrelationID();
                log.info("correlation ID: " + userId);
                log.info("MENSAJE ENVIADO--> " + mensajeJMS);

                messageService.processMessage(mensajeJMS, userId);
            }
        } catch (Exception e) {
            log.error("Error en consumo de servicio JMS", e);
            
        }finally {
        	if(consumer!=null) {
        		consumer.close();
        	}
            Runnable runnableTask = () -> {
                try {
                	log.info("THREAD DELAY --> " + delayReconnect);
                    TimeUnit.MILLISECONDS.sleep(delayReconnect);
                } catch (InterruptedException e) {
                    log.error("Error en setear DELAY RECONNECT --> ", e);
                    Thread.currentThread().interrupt();
                }
            };
            new Thread(runnableTask).start();
            scheduler.submit(this);
        }

    }
}