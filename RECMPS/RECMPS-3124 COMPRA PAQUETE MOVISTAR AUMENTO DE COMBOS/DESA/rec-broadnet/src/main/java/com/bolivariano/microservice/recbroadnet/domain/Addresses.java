package com.bolivariano.microservice.recbroadnet.domain;

import java.io.Serializable;

public class Addresses implements Serializable{

	private static final long serialVersionUID = 1L;
	protected String className;
	protected String type;
	protected String ref;
	
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	
	
}
