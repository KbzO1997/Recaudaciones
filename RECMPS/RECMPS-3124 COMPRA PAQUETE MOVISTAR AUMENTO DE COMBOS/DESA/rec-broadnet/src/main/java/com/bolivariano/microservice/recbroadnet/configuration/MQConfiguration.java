package com.bolivariano.microservice.recbroadnet.configuration;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import javax.jms.JMSException;

import com.ibm.msg.client.wmq.common.CommonConstants;
import org.jboss.logging.Logger;

import com.ibm.mq.jms.MQConnectionFactory;
import com.ibm.mq.jms.MQQueueConnectionFactory;

@ApplicationScoped
public class MQConfiguration {

	@Inject
	Logger log;

	@Inject
	ApplicationProperties applicationProperties;
	
	@Produces
	@MQConnectionFactoryData
	public MQConnectionFactory getConnectionFactory() throws JMSException {
		MQQueueConnectionFactory connectionFactory = new MQQueueConnectionFactory();
		connectionFactory.setHostName(applicationProperties.mq().host());
		connectionFactory.setQueueManager(applicationProperties.mq().queueManager());
		connectionFactory.setPort(applicationProperties.mq().port());
		connectionFactory.setChannel(applicationProperties.mq().channel());
		connectionFactory.setTransportType(CommonConstants.WMQ_CM_CLIENT);
		connectionFactory.setIntProperty(CommonConstants.WMQ_CLIENT_RECONNECT_OPTIONS,
				CommonConstants.WMQ_CLIENT_RECONNECT);

		return connectionFactory;
	}

}