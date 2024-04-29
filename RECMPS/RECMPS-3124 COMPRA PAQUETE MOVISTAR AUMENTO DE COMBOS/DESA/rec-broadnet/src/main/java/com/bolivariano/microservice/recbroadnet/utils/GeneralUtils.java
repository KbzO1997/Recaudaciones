package com.bolivariano.microservice.recbroadnet.utils;

import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;

import javax.xml.datatype.XMLGregorianCalendar;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;


public class GeneralUtils {

	private static final String FORMATOFECHA_YDM = "yyyy-dd-MM";
	private static final String FORMATOFECHA_YMD = "yyyy-MM-dd";
	private static final String FORMATOFECHA_MDY ="MM/dd/yyyy";
	private static final TimeZone IST_TIMEZONE = TimeZone.getTimeZone("America/Guayaquil");

	private GeneralUtils() {
	}

	public static String obtenerValorDatoAdicional(String clave, List<DatoAdicional> datosAdicionales) {
		DatoAdicional resultDatoAdicional = datosAdicionales.parallelStream().filter(x -> x.getCodigo().equals(clave) && x.getValor() != null && !x.getValor().isEmpty() && !"0".equals(x.getValor())).findFirst().orElse(null);
		//SI EXISTE ALGUNO BUSCA EL ULTIMO
		if (resultDatoAdicional != null){
			int lastIndex = datosAdicionales.parallelStream().filter(x -> x.getCodigo().equals(clave) && x.getValor() != null && !x.getValor().isEmpty() && !"0".equals(x.getValor()))
					.mapToInt(datosAdicionales::indexOf).max().getAsInt();
			resultDatoAdicional = datosAdicionales.get(lastIndex);

		}
		return resultDatoAdicional != null?resultDatoAdicional.getValor():"";
	}

	public static String dateParseString(Date fecha)
	{
		SimpleDateFormat formato = new SimpleDateFormat(FORMATOFECHA_MDY, Locale.ENGLISH);
		return formato.format(fecha);

	}
	public static Date strParseDate(String fecha)
	{
		SimpleDateFormat formato = new SimpleDateFormat(FORMATOFECHA_MDY);
		Date fechaDate = null;
		try {
			fechaDate = formato.parse(fecha);
		} catch (ParseException e) {
			throw new IllegalArgumentException(e);
		}
		return fechaDate;
	}

	public static DatoAdicional asignarCodigoValor(String codigo, Object valor) {
		DatoAdicional datoAdicional = new DatoAdicional();
		datoAdicional.setCodigo(codigo);
		datoAdicional.setValor(valor==null?"":String.valueOf(valor));
		return datoAdicional;
	}

	public static String setearValor(Object valor, String valorDefecto){

		if(valor== null)
			return valorDefecto;
		else {
			if(valor.equals(""))
				return valorDefecto;
			else
				return (String.valueOf(valor));
		}
	}


	public static String strParseDate() {
		Date fechaAct = new Date();
		SimpleDateFormat formato = new SimpleDateFormat("yyyyMMddHHmmss");
		String fechaFormat = null;

		try {
			fechaFormat = formato.format(fechaAct);
		} catch (Exception e) {
			throw new IllegalArgumentException(e);
		}

		return fechaFormat;
	}

	public static String strParseDate(Date fecha, String pattern) {
		SimpleDateFormat formato = new SimpleDateFormat(pattern);
		String fechaFormat = null;

		try {
			fechaFormat = formato.format(fecha);
		} catch (Exception e) {
			throw new IllegalArgumentException(e);
		}

		return fechaFormat;
	}

	public static java.sql.Date stringParseDate(String fecha)
	{
		SimpleDateFormat formato = new SimpleDateFormat(FORMATOFECHA_MDY);
		java.sql.Date fechaDate = null;
		try {
			fechaDate = (java.sql.Date) formato.parse(fecha);
		}
		catch (ParseException ex)
		{
			throw new IllegalArgumentException(ex);
		}
		return fechaDate;
	}

	public static String formatTimeStamp(XMLGregorianCalendar cal){
		DateFormat timeStampFormatter= new SimpleDateFormat(FORMATOFECHA_YDM);

		if (cal == null)
			return "";
		else
		{
			return timeStampFormatter.format(cal.toGregorianCalendar(IST_TIMEZONE, Locale.US, null).getTime());
		}
	}

	public static String formatTimeStampRe(Date calend){
		DateFormat timeStampFormat= new SimpleDateFormat(FORMATOFECHA_YMD);

		if (calend == null)
			return "";
		else
		{
			return timeStampFormat.format(calend);
		}
	}

}
