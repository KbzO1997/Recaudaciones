package com.bolivariano.microservice.recbroadnet.mq;

import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.event.Observes;
import javax.inject.Inject;
import javax.jms.ConnectionFactory;
import javax.jms.JMSConsumer;
import javax.jms.JMSContext;
import javax.jms.Message;
import javax.jms.Queue;
import javax.jms.Session;

import com.bolivariano.microservice.recbroadnet.service.ProcessorService;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.recbroadnet.configuration.ApplicationProperties;
import com.bolivariano.microservice.recbroadnet.configuration.MQConnectionFactoryData;

import io.quarkus.runtime.ShutdownEvent;
import io.quarkus.runtime.StartupEvent;
import javax.jms.JMSException;

@ApplicationScoped
public class MessageListener implements Runnable {

	@Inject
	Logger log;

	@Inject
	@MQConnectionFactoryData
	ConnectionFactory connectionFactory;

	@Inject
	ApplicationProperties applicationProperties;

	@Inject
    ProcessorService processorService;


	private ExecutorService scheduler;

	void onStart(@Observes StartupEvent event) {
		log.info(event);
		int maxThread = applicationProperties.mq().poolJms().intValue();
		scheduler = Executors.newFixedThreadPool(maxThread);
		for (int i = 0; i < maxThread; i++) {
			scheduler.submit(this);
		}
	}
	void onStop(@Observes ShutdownEvent event) {
		log.info(event);
		scheduler.shutdown();
	}

	@Override
	public void run() {
		log.info("Inicia thread listener");
		log.info("Cola mq --> " + applicationProperties.mq().queueRequest());

		JMSConsumer consumer = null;
		
		try (JMSContext context = connectionFactory.createContext(Session.AUTO_ACKNOWLEDGE)) {
			Queue queue = context.createQueue(applicationProperties.mq().queueRequest());
			consumer = context.createConsumer(queue);
			while (true) {
				Message message = consumer.receive();
				if (Objects.isNull(message)) return;

				String mensajeJMS = message.getBody(String.class);
				String correlationId = message.getJMSCorrelationID();

				if (mensajeJMS.equals("TEST")){
					log.info("TestMQ OK");
				}else {
					log.info("INI JMS RECIBIDO --> " + correlationId);
					log.infof("Mensaje recibido: %s ", mensajeJMS);
					processorService.processMessage(mensajeJMS, correlationId);
					log.info("FIN JMS RECIBIDO --> " + correlationId);
				}

			}
		
		}catch(JMSException jmsEx) {
			log.error("Error JMSExceptionS -->", jmsEx);
		} catch (Exception e) {
			log.error("Error en consumo de servicio JMS -->", e);
		} finally {
			log.error("finally");
			if (consumer != null) {
				log.error("close consumer");
				consumer.close();
			}
			Runnable runnableTask = () -> {
				try {
					log.info("THREAD DELAY --> " + applicationProperties.mq().delayReconnect());
					TimeUnit.MILLISECONDS.sleep(applicationProperties.mq().delayReconnect());
				} catch (InterruptedException e) {
					log.error("Error en setear DELAY RECONNECT --> ", e);
					Thread.currentThread().interrupt();
				} catch (Exception  e){
					log.error("Error general ", e);
				}
			};

			log.error("Levantando nuevo hilo");
			new Thread(runnableTask).start();
			scheduler.submit(this);
			log.error("Levantando nuevo hilo fin");
		}
		log.info("Fin run ...");

	}

}
