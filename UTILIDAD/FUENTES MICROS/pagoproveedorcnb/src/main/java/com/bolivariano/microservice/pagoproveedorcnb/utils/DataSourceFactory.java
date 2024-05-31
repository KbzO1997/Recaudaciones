package com.bolivariano.microservice.pagoproveedorcnb.utils;

import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.sql.Connection;
import java.util.Map;

@Singleton
public class DataSourceFactory {

	@ConfigProperty(name = "otc-collector.sybase.datasource.driverClassName")
	String driverClassName;

	@ConfigProperty(name = "otc-collector.sybase.datasource.dbName")
	String dbName;

	@ConfigProperty(name = "otc-collector.sybase.datasource.hostPort")
	String hostPort;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.usernameProperty")
	String usernameProperty;

	@ConfigProperty(name = "otc-collector.sybase.datasource.passwordProperty")
	String passwordProperty;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.connTimeout")
	int connTimeout;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.maxPoolSize")
	int maxPoolSize;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.minimunIdle")
	int minimunIdle;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.idleTimeout")
	int idleTimeout;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.maxLifeTime")
	int maxLifeTime;
	
	@ConfigProperty(name = "otc-collector.sybase.datasource.leakDetectionThreshold")
	int leakDetectionThreshold;

	@Inject
	Logger log;

	@Inject
	Map<String, String> frameworkSecurityParams;

	private HikariDataSource dataSourceObj;

	public Connection getConnection() throws CollectorException {
		try {
			initDatasource();
			return dataSourceObj.getConnection();

		} catch (Exception ex) {
			throw new CollectorException(ex);
		}
	}

	private void initDatasource() {
		if (dataSourceObj != null) {
			log.info("Toma datasource creado");
			return;
		}

		log.info("Genera Datasource");
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setJdbcUrl("jdbc:sybase:Tds:" + hostPort + "/"+ dbName+ "?SERVER_INITIATED_TRANSACTIONS=false");
		hikariConfig.addDataSourceProperty("SERVER_INITIATED_TRANSACTIONS","false");

		log.info("URL:" + hikariConfig.getJdbcUrl());
		
		hikariConfig.setUsername(frameworkSecurityParams.get(usernameProperty));
		hikariConfig.setPassword(frameworkSecurityParams.get(passwordProperty));

		hikariConfig.setDriverClassName(driverClassName);
		hikariConfig.setConnectionTimeout(connTimeout);
		hikariConfig.setAutoCommit(true);
		hikariConfig.setConnectionInitSql("SELECT 1");
		hikariConfig.setMaximumPoolSize(maxPoolSize);
		hikariConfig.setMinimumIdle(minimunIdle);
		hikariConfig.setMaxLifetime(maxLifeTime);
		hikariConfig.setIdleTimeout(idleTimeout);
		hikariConfig.setLeakDetectionThreshold(leakDetectionThreshold);

		dataSourceObj = new HikariDataSource(hikariConfig);
		log.info("Fin de generacion de datasource");
	}

}
