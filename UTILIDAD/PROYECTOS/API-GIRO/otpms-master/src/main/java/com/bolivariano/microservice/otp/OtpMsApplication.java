package com.bolivariano.microservice.otp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
public class OtpMsApplication {

	public static void main(String[] args) {
		SpringApplication.run(OtpMsApplication.class, args);
	}
}
