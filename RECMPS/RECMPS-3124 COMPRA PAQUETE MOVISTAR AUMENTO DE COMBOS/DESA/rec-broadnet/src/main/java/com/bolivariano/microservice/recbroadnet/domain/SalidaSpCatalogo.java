package com.bolivariano.microservice.recbroadnet.domain;

import java.io.Serializable;
import java.util.List;


public class SalidaSpCatalogo implements Serializable {

	private static final long serialVersionUID = 1L;

	private int codigo;

    private String mensajeSalida;
    
    private List<Catalogo> lstCatalogo;

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public String getMensajeSalida() {
		return mensajeSalida;
	}

	public void setMensajeSalida(String mensajeSalida) {
		this.mensajeSalida = mensajeSalida;
	}

	public List<Catalogo> getLstCatalogo() {
		return lstCatalogo;
	}

	public void setLstCatalogo(List<Catalogo> lstCatalogo) {
		this.lstCatalogo = lstCatalogo;
	}

}
