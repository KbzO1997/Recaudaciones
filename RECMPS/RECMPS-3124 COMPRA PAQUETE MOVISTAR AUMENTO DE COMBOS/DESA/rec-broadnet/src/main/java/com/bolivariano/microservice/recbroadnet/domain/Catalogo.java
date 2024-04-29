package com.bolivariano.microservice.recbroadnet.domain;

import java.io.Serializable;

public class Catalogo implements Serializable {

	private static final long serialVersionUID = 1L;

	private int idTabla;
	
	private double parametro;

    private String valor;

	public int getIdTabla() {
		return idTabla;
	}

	public void setIdTabla(int idTabla) {
		this.idTabla = idTabla;
	}

	public double getParametro() {
		return parametro;
	}

	public void setParametro(double parametro) {
		this.parametro = parametro;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

    
}
