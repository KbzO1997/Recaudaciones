package com.bolivariano.microservice.otp.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.GenerarOTPMensajeResponse;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeRequest;
import com.bolivariano.microservice.otp.dto.ValidarOTPMensajeResponse;
import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.service.OTPService;
import com.bolivariano.microservice.otp.service.OTPServiceCliente;
import com.bolivariano.microservice.otp.service.OTPServiceEntrust;
import com.bolivariano.microservice.otp.service.OTPServiceNoCliente;
import com.bolivariano.microservice.otp.utils.constant.Enums;
import com.bolivariano.microservice.otp.utils.constant.Procesos;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@RestController
@RequestMapping("/otp")
public class RestControllerOTP {
	private static final Logger logger = LoggerFactory.getLogger(RestController.class);
	private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	
	@Autowired
	private OTPService otpService;
	
	@Autowired
	private OTPServiceCliente otpServiceCliente;
	
	@Autowired
	private OTPServiceNoCliente otpServiceNoCliente;
	
	@Autowired
	private OTPServiceEntrust otpServiceEntrust;

	
    /*Generar OTP para cliente o no cliente*/
	@PostMapping("/generarOTP")
	public ResponseEntity<GenerarOTPMensajeResponse> generarOTP(@RequestBody GenerarOTPMensajeRequest request) {
		logger.info("metodo /generarOTP");
		printMensajeEntrada(gson.toJson(request));		

		if (request.getIdentificacionCliente() == null || request.getMedioNotificacion() == null) {
			GenerarOTPMensajeResponse response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getMedioNotificacion().trim().equalsIgnoreCase("")) {
			GenerarOTPMensajeResponse response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		GenerarOTPMensajeResponse response = otpService.generarOTPGenerico(request);
		printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);
	
	}

	/*Validar OTP para cliente o no cliente*/ 
	@PostMapping("/validarOTP")
	public ResponseEntity<ValidarOTPMensajeResponse> validarOTP(@RequestBody ValidarOTPMensajeRequest request) {
		logger.info("metodo /validarOTP");
		printMensajeEntrada(gson.toJson(request));
		
		if (request.getIdentificacionCliente() == null || request.getOtp() == null) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getOtp().trim().equalsIgnoreCase("")) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		ValidarOTPMensajeResponse response = otpService.validarOTPGenerico(request);
		printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);
	}
	
     /*Generar OTP para cliente registrado en DB BB*/
	/* C -> CELULAR, M -> CORREO, A -> CELULAR y CORREO */
	@PostMapping("/generarOTPCliente")
	public ResponseEntity<GenerarOTPMensajeResponse> generarOTPCliente(@RequestBody GenerarOTPMensajeRequest request) {
		logger.info("metodo /generarOTPCliente");
		printMensajeEntrada(gson.toJson(request));

		if (request.getIdentificacionCliente() == null || request.getMedioNotificacion() == null) {
			GenerarOTPMensajeResponse response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getMedioNotificacion().trim().equalsIgnoreCase("")) {
			GenerarOTPMensajeResponse response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		GenerarOTPMensajeResponse response = otpServiceCliente.generarOTPCliente(Procesos.GENERAR_OTP_CLIENTE, request, null);
		printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);

	}

	/*Validar OTP par cliente registrado dn DB BB*/
	@PostMapping("/validarOTPCliente")
	public ResponseEntity<ValidarOTPMensajeResponse> validarOTPCliente(@RequestBody ValidarOTPMensajeRequest request) {
		logger.info("metodo /validarOTPCliente");
		printMensajeEntrada(gson.toJson(request));

		if (request.getIdentificacionCliente() == null || request.getOtp() == null) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getOtp().trim().equalsIgnoreCase("")) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		ValidarOTPMensajeResponse response = otpServiceEntrust.validarCodigoOTPEntrust(Procesos.VALIDAR_OTP_CLIENTE,request);
		printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);

	}
	
     /*Generar OTP para cliente no registrado en DB BB*/
	/* C -> CELULAR, M -> CORREO, A -> CELULAR y CORREO */
	@PostMapping("/generarOTPNoCliente")
	public ResponseEntity<GenerarOTPMensajeResponse> generarOTPNoCliente(
			@RequestBody GenerarOTPMensajeRequest request) {
		logger.info("metodo /generarOTPNoCliente");
		printMensajeEntrada(gson.toJson(request));
		GenerarOTPMensajeResponse response = null ;

		if (request.getIdentificacionCliente() == null || request.getMedioNotificacion() == null) {
			response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getMedioNotificacion().trim().equalsIgnoreCase("")) {
			 response = new GenerarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS, null);
			return new ResponseEntity(response, HttpStatus.OK);
		}
		 try {
			response = otpServiceNoCliente.generarOTPNoCliente(Procesos.GENERAR_OTP_NO_CLIENTE, request);
		} catch (OTPException e) {
			response = new GenerarOTPMensajeResponse();
			response.setCodigoRespuesta(-1);
			response.setMensaje(e.getMessage());
		}

		 printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);

	}
	/*Validar OTP para cliente no registrado en DB BB*/
	@PostMapping("/validarOTPNoCliente")
	public ResponseEntity<ValidarOTPMensajeResponse> validarOTPNoCliente(
			@RequestBody ValidarOTPMensajeRequest request) {
		logger.info("metodo /validarOTPNoCliente");
		printMensajeEntrada(gson.toJson(request));
	
		if (request.getIdentificacionCliente() == null || request.getOtp() == null) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}

		if (request.getIdentificacionCliente().trim().equalsIgnoreCase("")
				|| request.getOtp().trim().equalsIgnoreCase("")) {
			ValidarOTPMensajeResponse response = new ValidarOTPMensajeResponse(400, Enums.PARAMETROS_INCORRECTOS);
			return new ResponseEntity(response, HttpStatus.OK);
		}
		
		ValidarOTPMensajeResponse response = otpServiceEntrust.validarCodigoOTPEntrust(Procesos.VALIDAR_OTP_NO_CLIENTE, request);
		printMensajeSalida(gson.toJson(response));
		return new ResponseEntity(response, HttpStatus.OK);

	}
	
	public void printMensajeEntrada(String object) {
		logger.info("*****************REQUEST********************");
		logger.info(object);
		logger.info("*****************END REQUEST********************");
	}
	
	public static void printMensajeSalida(String object) {
		logger.info("*****************RESPONSE********************");
		logger.info(object);
		logger.info("*****************END RESPONSE********************");
	}
}
