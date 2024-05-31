package com.bolivariano.microservice.utilitarioms.bean;

import java.util.List;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix="serviciosCorreoPersonalizado")

public class ServiciosCorreoPersonalizado {
	private List<String> servicios;
	private List<String> sinMis;

	public List<String> getServicios() {
		return servicios;
	}

	public void setServicios(List<String> servicios) {
		this.servicios = servicios;
	}

	public List<String> getSinMis() {
		return sinMis;
	}

	public void setSinMis(List<String> sinMis) {
		this.sinMis = sinMis;
	}
	
	
}