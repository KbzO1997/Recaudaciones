package com.bolivariano.microservice.pagoproveedorcnb.exception;

public class CollectorException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public CollectorException(Throwable e) {
		super(e);
	}

	public CollectorException(String message) {
		super(message);
	}
}
