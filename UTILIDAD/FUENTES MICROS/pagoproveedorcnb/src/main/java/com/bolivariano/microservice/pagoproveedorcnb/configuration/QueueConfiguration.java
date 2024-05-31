package com.bolivariano.microservice.pagoproveedorcnb.configuration;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.jms.JMSException;
import javax.ws.rs.Produces;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import com.ibm.mq.jms.MQConnectionFactory;
import com.ibm.mq.jms.MQQueueConnectionFactory;


@ApplicationScoped
public class QueueConfiguration {

    @ConfigProperty(name = "otc-collector.ibm.mq.host")
    String host;

    @ConfigProperty(name = "otc-collector.ibm.mq.port")
    int port;

    @ConfigProperty(name = "otc-collector.ibm.mq.channel")
    String channel;

    @ConfigProperty(name = "otc-collector.ibm.mq.queue-manager")
    String queueManager;

    @ConfigProperty(name = "otc-collector.ibm.mq.queue-request")
    String queueName;

    @Inject
    org.jboss.logging.Logger log;

    @Produces
    @MQConnectionFactoryData
    public MQConnectionFactory getConnectionFactory() throws JMSException {
        log.info("host -->" + host);
        log.info("port -->" + port);
        log.info("channel -->" + channel);
        log.info("queueManager -->" + queueManager);
        log.info("QUEuE_NAME -->" + queueName);

        MQQueueConnectionFactory connectionFactory = new MQQueueConnectionFactory();
        connectionFactory.setHostName(host);
        connectionFactory.setQueueManager(queueManager);
        connectionFactory.setPort(port);
        connectionFactory.setChannel(channel);
        connectionFactory.setTransportType(com.ibm.msg.client.wmq.common.CommonConstants.WMQ_CM_CLIENT);
        connectionFactory.setCCSID(1208);

        return connectionFactory;
    }
}