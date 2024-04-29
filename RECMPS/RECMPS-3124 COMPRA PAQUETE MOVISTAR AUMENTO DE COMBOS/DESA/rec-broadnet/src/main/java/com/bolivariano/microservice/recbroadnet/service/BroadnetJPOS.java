package com.bolivariano.microservice.recbroadnet.service;

import com.bolivariano.microservice.recbroadnet.configuration.ApplicationProperties;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeEntradaEjecutarPago;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeEntradaEjecutarReverso;
import com.bolivariano.microservice.recbroadnet.exception.BusinessException;
import org.jboss.logging.Logger;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.ISOUtil;
import org.jpos.iso.channel.NACChannel;
import org.jpos.iso.packager.ISO87BPackager;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

@ApplicationScoped
public class BroadnetJPOS {

	@Inject
	Logger log;

	@Inject
	ApplicationProperties applicationProperties;

	private static final String RECHARGE = "RECHARGE";
	private static final String REVERSE = "REVERSE";

	public void recharge(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago, ApplicationProperties.ParametrosEmpresa parametrosEmpresa,
						 String codigoProceso,String fechaContable) throws ParseException, IOException, ISOException, BusinessException {
		ISOMsg response = processISO(mensajeEntradaEjecutarPago.getValorPago(), codigoProceso, mensajeEntradaEjecutarPago.getSecuencial(), fechaContable, mensajeEntradaEjecutarPago.getServicio().getIdentificador(), parametrosEmpresa,RECHARGE);

		if (response == null) {
			log.error("Respuesta vacia");
			throw new BusinessException("Error respuesta ISO vacia");
		}
		Object codigoRespuesta = response.getValue(39);

		if (!"00".equals(codigoRespuesta)) {
			log.error("ERROR EN RESPUESTA ISO " + codigoRespuesta);
			throw new ISOException(Optional.of(codigoRespuesta).get().toString());
		}
	}

	public String reverse(MensajeEntradaEjecutarReverso mensajeEntradaEjecutarReverso, ApplicationProperties.ParametrosEmpresa parametrosEmpresa, String secuencial, String fechaContable) throws ParseException, IOException, ISOException, BusinessException {
		ISOMsg response = processISO(mensajeEntradaEjecutarReverso.getValorPago(), null, secuencial, fechaContable, mensajeEntradaEjecutarReverso.getServicio().getIdentificador(), parametrosEmpresa,REVERSE);
		Object codigoRespuesta;

		if (response == null) {
			log.error("Respuesta vacia");
			throw new BusinessException("Error respuesta ISO vacia");
		}

		codigoRespuesta = response.getValue(39);

		if (codigoRespuesta != null) {
			log.info("CODIGO RESPUESTA: " + codigoRespuesta);
		}

		return codigoRespuesta != null ? codigoRespuesta.toString() : "BROA_100";
	}

	private String validaField112(String codigoEmpresa, String codigoProducto, String numeroTelefono) {
		String field112 = String.format("%s%s%s", codigoEmpresa, codigoProducto, numeroTelefono);

		if (field112 != null) {
			if (field112.length() < 24) {
				field112 = fixLength(field112, 24, ' ', 1);
			} else {
				field112 = unPadRight(field112, 24);
			}
		} else {
			field112 = "                        ";
		}
		return field112;
	}


	private String validaValorTotalToStr(Double valorTotal) {
		String valorTotalStr = "000000000000";

		if ((valorTotal != null) && (valorTotal.doubleValue() > 0)) {
			valorTotalStr = new DecimalFormat("0.00").format(valorTotal);
			valorTotalStr = valorTotalStr.replace(".", "");
			valorTotalStr = valorTotalStr.replace(",", "");

			if (valorTotalStr.length() < 12) {
				valorTotalStr = fixLength(valorTotalStr, 12, '0', 0);
			} else {
				valorTotalStr = unPadLeft(valorTotalStr, 12);
			}
		}
		return valorTotalStr;
	}

	private String validaDispositivo(String dispositivo) {
		if (dispositivo != null) {
			if (dispositivo.length() < 2) {
				dispositivo = fixLength(dispositivo, 2, '0', 0);
			} else {
				dispositivo = unPadLeft(dispositivo, 2);
			}
		} else {
			dispositivo = "00";
		}
		return dispositivo;
	}


	private String validaSecuencial(String secuencial) {
		if (secuencial != null) {
			if (secuencial.length() < 6) {
				secuencial = fixLength(secuencial, 6, '0', 0);
			} else {
				secuencial = unPadLeft(secuencial, 6);
			}
		} else {
			secuencial = "000000";
		}
		return secuencial;
	}



	private String fixLength(String value, int length, char extraValue, int orientation) {
		if (length > value.length()) {
			int fixed = length - value.length();
			StringBuilder fixedStr = new StringBuilder();

			for (int i = 0; i < fixed; i++) {
				fixedStr.append(extraValue);
			}

			if (orientation == 0) {
				return fixedStr + value;
			} else {
				return value + fixedStr;
			}

		}
		return value;
	}

	private String unPadLeft(String value, int length) {

		if (value.length() > length) {
			int unPadLength = value.length() - length;
			return value.substring(unPadLength);
		}
		return value;
	}

	private String unPadRight(String value, int length) {
		if (value.length() > length) {
			int unPadLength = value.length() - length;
			return value.substring(0, unPadLength);
		}
		return value;
	}


	private String formatearFecha(Date fecha) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(applicationProperties.provider().formatoFecha());
		return simpleDateFormat.format(fecha);
	}

	private String formatearFechaContable(String fechaStr, boolean incluyeAnios) throws ParseException {
		SimpleDateFormat parser = new SimpleDateFormat(applicationProperties.banco().bancoFormatoFechaContable());
		Date fecha = parser.parse(fechaStr);
		SimpleDateFormat formatter;
		if (incluyeAnios)
			formatter = new SimpleDateFormat(applicationProperties.provider().formatoFechaContable6());
		else
			formatter = new SimpleDateFormat(applicationProperties.provider().formatoFechaContable4());

		return formatter.format(fecha);
	}

	private String formatearTiempo(Date fecha) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(applicationProperties.provider().formatoTiempo());
		return simpleDateFormat.format(fecha);
	}

	private ISOMsg processISO(Double valorTotal, String codigoProceso,
							  String secuencial,String fechaContable, String numeroTelefono,
							  ApplicationProperties.ParametrosEmpresa parametrosEmpresa, String operation) throws ParseException, IOException, ISOException{

		Date fechaEmision = new Date();
		String codigoServicio = parametrosEmpresa.codigoServicio();
		String dispositivo = parametrosEmpresa.dispositivo();
		String codigoEmpresa = parametrosEmpresa.codigoEmpresa();
		String codigoProducto = parametrosEmpresa.codigoProducto();

		String fecha = formatearFecha(fechaEmision);
		String hora = formatearTiempo(fechaEmision);
		String fechaContableStr6 = formatearFechaContable(fechaContable, true);

		String tpdu = "6080000001";
		NACChannel channel = new NACChannel(applicationProperties.tcp().host(), Integer.parseInt(applicationProperties.tcp().port()), new ISO87BPackager(), ISOUtil.hex2byte(tpdu));
		channel.connect();

		secuencial = validaSecuencial(secuencial);
		dispositivo = validaDispositivo(dispositivo);
		String valorTotalStr = validaValorTotalToStr(valorTotal);
		String field112 = validaField112(codigoEmpresa, codigoProducto, numeroTelefono);

		ISOMsg request = new ISOMsg("0200");
		log.info("MTI: 0200");
		request.set(2, codigoServicio); //MOV
		log.info("FIELD_2: " + codigoServicio);

		String field3Recharge = "28" + codigoProceso + "00";
		String field3 = REVERSE.equals(operation)?"370000":field3Recharge;
		request.set(3, field3);
		log.info("FIELD_3: " + field3);

		request.set(4, valorTotalStr);
		log.info("FIELD_4: " + valorTotalStr);

		request.set(11, secuencial);
		log.info("FIELD_11: " + secuencial);

		request.set(12, hora);
		log.info("FIELD_12: " + hora);

		request.set(13, fecha);
		log.info("FIELD_13: " + fecha);

		request.set(22, applicationProperties.provider().posEntryMode());
		log.info("FIELD_22: " + applicationProperties.provider().posEntryMode());

		request.set(24, applicationProperties.provider().networkId());
		log.info("FIELD_24: " + applicationProperties.provider().networkId());

		request.set(25, applicationProperties.provider().posConditionCode());
		log.info("FIELD_25: " + applicationProperties.provider().posConditionCode());

		request.set(38, secuencial);
		log.info("FIELD_38: " + secuencial);

		request.set(41, applicationProperties.provider().terminalId());
		log.info("FIELD_41: " + applicationProperties.provider().terminalId());

		request.set(42, applicationProperties.provider().merchantId());
		log.info("FIELD_42: " + applicationProperties.provider().merchantId());

		request.set(112, field112);
		log.info("FIELD_112: " + field112);

		request.set(114, dispositivo);
		log.info("FIELD_114: " + dispositivo);

		request.set(116, applicationProperties.provider().codigoCajero());
		log.info("FIELD_116: " + applicationProperties.provider().codigoCajero());

		request.set(118, fechaContableStr6);
		log.info("FIELD_118: " + fechaContableStr6);

		log.info("TIMEOUT: " + applicationProperties.provider().readTimeout());
		channel.setTimeout(applicationProperties.provider().readTimeout());
		channel.send(request);

		return channel.receive();

	}

}
