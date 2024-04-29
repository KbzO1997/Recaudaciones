package com.bolivariano.microservice.recbroadnet.exception;

public class BusinessException extends Exception {

    /**
	 * 
	 */
	private static final long serialVersionUID = -525298901120915843L;

	public BusinessException(String message){
        super(message);
    }

    public BusinessException(Throwable cause){
        super(cause);
    }
}
