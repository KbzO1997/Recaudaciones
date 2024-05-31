package com.bolivariano.microservice.pagoproveedorcnb.service;


import org.eclipse.microprofile.config.inject.ConfigProperty;

import com.bolivariano.microservice.pagoproveedorcnb.configuration.MQConnectionFactoryData;
import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorRuntimeException;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.jms.*;

import static com.ibm.msg.client.jms.JmsConstants.*;

import java.nio.charset.StandardCharsets;

@ApplicationScoped
public class MessageSenderService {
    @ConfigProperty(name = "otc-collector.ibm.mq.queue-replay")
    String queueName;

    @ConfigProperty(name = "otc-collector.ibm.mq.queue-request")
    String queueNameResponse;
    @Inject
    org.jboss.logging.Logger log;

    @Inject
    @MQConnectionFactoryData
    ConnectionFactory mqConnectionFactory;

    public void sendMessage(String message, final String userId, boolean test) {
        log.info("COLA MQ  SENDER --> " + queueName);
        log.info("MENSAJE--> " + message);
       
        try(final JMSContext context = mqConnectionFactory.createContext(Session.AUTO_ACKNOWLEDGE)){
            final JMSProducer producer = context.createProducer();
            final Destination destination;

            if (test)
                destination = context.createQueue(queueNameResponse);
            else
                destination = context.createQueue(queueName);
            
            BytesMessage messageJMS = context.createBytesMessage();
            messageJMS.setJMSCorrelationID(userId);
            messageJMS.setJMSMessageID(userId);

            messageJMS.setJMSExpiration(50000);
            messageJMS.setIntProperty(JMS_IBM_CHARACTER_SET, 1208);
            messageJMS.setJMSDeliveryMode(DeliveryMode.NON_PERSISTENT);
            messageJMS.setJMSPriority(Message.DEFAULT_PRIORITY);
            messageJMS.setJMSTimestamp(System.nanoTime());

            messageJMS.writeBytes(message.getBytes(StandardCharsets.UTF_8));

            log.info("MENSAJE--> " + messageJMS);
            log.info("TEXT--> " + message);
            log.info("JMSX_USERID --> " + userId);
            
            producer.send(destination, messageJMS);
        }catch (Exception e) {
            log.error("Error en producir de servicio JMS", e);
            throw new CollectorRuntimeException(e);
        }
    }
}
