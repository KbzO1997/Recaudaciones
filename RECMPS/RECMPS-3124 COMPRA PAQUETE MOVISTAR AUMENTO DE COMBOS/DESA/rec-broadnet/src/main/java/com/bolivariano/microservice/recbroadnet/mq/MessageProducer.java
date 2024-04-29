package com.bolivariano.microservice.recbroadnet.mq;

import static com.ibm.msg.client.jms.JmsConstants.JMS_IBM_CHARACTER_SET;
import static com.ibm.msg.client.jms.JmsConstants.JMS_IBM_MQMD_EXPIRY;

import java.nio.charset.StandardCharsets;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.jms.BytesMessage;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSContext;
import javax.jms.JMSProducer;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.jboss.logging.Logger;

import com.bolivariano.microservice.recbroadnet.configuration.ApplicationProperties;
import com.bolivariano.microservice.recbroadnet.configuration.MQConnectionFactoryData;

@ApplicationScoped
public class MessageProducer {
	@Inject
	Logger log;

	@Inject
	@MQConnectionFactoryData
	ConnectionFactory mqConnectionFactory;

	@Inject
	ApplicationProperties applicationProperties;

	public void sendMessage(String mensajeStr, final String correlationId, boolean testMQ) {
		
		try (
			final JMSContext context = mqConnectionFactory.createContext(Session.AUTO_ACKNOWLEDGE)) {
			final JMSProducer producer = context.createProducer();
			
			final Destination destination = context.createQueue(applicationProperties.mq().queueReplay());
			
			BytesMessage messageJMS = context.createBytesMessage();
			messageJMS.setJMSCorrelationID(correlationId);
			messageJMS.setJMSMessageID(correlationId);

			producer.setTimeToLive(applicationProperties.mq().timeToLive());
			messageJMS.setIntProperty(JMS_IBM_MQMD_EXPIRY, applicationProperties.mq().timeToLive().intValue());
			messageJMS.setJMSExpiration(applicationProperties.mq().timeToLive());

			messageJMS.setIntProperty(JMS_IBM_CHARACTER_SET, applicationProperties.mq().characterSet());
			messageJMS.setJMSDeliveryMode(DeliveryMode.NON_PERSISTENT);
			messageJMS.setJMSPriority(Message.DEFAULT_PRIORITY);
			messageJMS.setJMSTimestamp(System.nanoTime());

			messageJMS.writeBytes(mensajeStr.getBytes(StandardCharsets.UTF_8));


			messageJMS.setJMSTimestamp(System.nanoTime());			
			if (!testMQ) log.infof("Rsp: " + mensajeStr);


			producer.send(destination, messageJMS);
		} catch (Exception e) {
			log.error("Error en producir de servicio JMS", e);
			throw new IllegalArgumentException(e);
		}
	}
	
	public void sendMessageConvrtText(String mensajeStr, final String correlationId, boolean testMQ){
		
		try (final JMSContext context = mqConnectionFactory.createContext(Session.AUTO_ACKNOWLEDGE)) {
			final JMSProducer producer = context.createProducer();
			final Destination destination ;

			if (testMQ)	destination= context.createQueue(applicationProperties.mq().queueRequest());
			else destination= context.createQueue(applicationProperties.mq().queueReplay());

			TextMessage messageJMS = context.createTextMessage();
			messageJMS.setJMSCorrelationID(correlationId);
			messageJMS.setJMSMessageID(correlationId);

			producer.setTimeToLive(applicationProperties.mq().timeToLive());
			messageJMS.setIntProperty(JMS_IBM_MQMD_EXPIRY, applicationProperties.mq().timeToLive().intValue());
			messageJMS.setJMSExpiration(applicationProperties.mq().timeToLive());

			messageJMS.setIntProperty(JMS_IBM_CHARACTER_SET, applicationProperties.mq().characterSet());
			messageJMS.setJMSDeliveryMode(DeliveryMode.NON_PERSISTENT);
			messageJMS.setJMSPriority(Message.DEFAULT_PRIORITY);
			messageJMS.setJMSTimestamp(System.nanoTime());

			messageJMS.setText(mensajeStr);
			if (!testMQ) log.infof("Rsp: " + mensajeStr);
			

			producer.send(destination, messageJMS);
		} catch (Exception e) {
			log.error("Error en producir de servicio JMS", e);
			throw new IllegalArgumentException("Error al consultar deuda Broadnet: " + e.getMessage());
		}
		
	}
}
