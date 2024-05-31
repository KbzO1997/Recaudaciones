package com.bolivariano.microservice.utilitarioms.configuration;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

@Configuration
public class DataSourceManager {
	
	/* STORE BB */
    
	@Primary
    @Bean(name="storeDataSource")
    @ConfigurationProperties("spring.storebb.datasource")
    public DataSource storeDataSource() {
       return DataSourceBuilder.create().build();
        //return storeDataSourceProperties().initializeDataSourceBuilder().build();
    }
    
    public JdbcTemplate storeJdbcTemplate(@Qualifier("storeDataSource")DataSource storeDataSource) {
       return new JdbcTemplate(storeDataSource);
    }
    
    public SimpleJdbcCall storeSimpleJdbcCall(@Qualifier("storeDataSource")DataSource storeDataSource) {
       return new SimpleJdbcCall(storeDataSource);
    }
    
    /* SYBASE */
    @Bean(name="sybaseDataSource")
    @ConfigurationProperties("spring.sybase.datasource")
    public DataSource sybaseDataSource() {
       return DataSourceBuilder.create().build();
        //return sybaseDataSourceProperties().initializeDataSourceBuilder().build();
    }
    

    public JdbcTemplate sybaseJdbcTemplate(@Qualifier("sybaseDataSource")DataSource sybaseDataSource) {
		 return new JdbcTemplate(sybaseDataSource);
    }
	   
    public SimpleJdbcCall sybaseSimpleJdbcCall(@Qualifier("sybaseDataSource")DataSource sybaseDataSource) {
       return new SimpleJdbcCall(sybaseDataSource);
    }
	

}
