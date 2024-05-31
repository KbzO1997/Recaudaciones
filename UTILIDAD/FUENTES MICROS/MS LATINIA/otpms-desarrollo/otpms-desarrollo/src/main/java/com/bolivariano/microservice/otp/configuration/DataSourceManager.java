package com.bolivariano.microservice.otp.configuration;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

@Configuration
public class DataSourceManager {
	/* SYBASE */
	@Bean(name = "sybaseDataSource")
	@ConfigurationProperties("spring.sybase.datasource")
	public DataSource sybaseDataSource() {
		return DataSourceBuilder.create().build();
	}
	public JdbcTemplate sybaseJdbcTemplate(@Qualifier("sybaseDataSource") DataSource sybaseDataSource) {
	
		return new JdbcTemplate(sybaseDataSource);
	}

	public SimpleJdbcCall sybaseSimpleJdbcCall(@Qualifier("sybaseDataSource") DataSource sybaseDataSource) {
		return new SimpleJdbcCall(sybaseDataSource);
	}
}
