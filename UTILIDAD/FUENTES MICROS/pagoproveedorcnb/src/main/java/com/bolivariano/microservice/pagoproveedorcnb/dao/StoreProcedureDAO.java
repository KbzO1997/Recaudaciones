package com.bolivariano.microservice.pagoproveedorcnb.dao;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import com.bolivariano.microservice.pagoproveedorcnb.domain.InParameter;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.model.StoredProcedure;
import com.bolivariano.microservice.pagoproveedorcnb.model.SybaseScript;
import com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.ParamType;

@ApplicationScoped
public class StoreProcedureDAO {

	@Inject
	Logger log;

	private static final String PARAMETER = "parameter ";
	private static final String BANK_FORMAT_DATE = "MM/dd/yyyy";
	private static final String CAN_NOT_CONVERT = "can not convert the value ";

	private int countParams(SybaseScript sybaseScript) {
		int countParams = 0;
		for (String paramName : sybaseScript.getParameters().keySet()) {
			List<StoredProcedure.Parameter> spParameters = sybaseScript.getParameters().get(paramName);
			countParams = countParams + spParameters.size();
		}
		log.debugf("CountParams %s", countParams);
		return countParams;
	}

	public Map<String, InParameter> getInParameters(Map<String, Map<String, String>> params, SybaseScript sybaseScript)
			throws CollectorException {
		if (params == null && sybaseScript.getParameters() != null) {
			throw new CollectorException("parameters is required");
		}
		Map<String, InParameter> parameters = new HashMap<>();
		int countParams = countParams(sybaseScript);

		StoredProcedure.Parameter[] spParameters = new StoredProcedure.Parameter[countParams];
		List<StoredProcedure.Parameter> spParams;
		List<StoredProcedure.Parameter> inSpParams;

		InParameter inParameter;
		Object data;

		for (String paramName : sybaseScript.getParameters().keySet()) {
			spParams = sybaseScript.getParameters().get(paramName);
			inSpParams = spParams.parallelStream().filter(x -> x.getType().equals(ParamType.IN))
					.collect(Collectors.toList());
			for (StoredProcedure.Parameter spParam : inSpParams) {
				String value = null;

				if (params != null && params.get(paramName) != null) {
					value = params.get(paramName).get(spParam.getName());
				}

				if (value == null) {
					throw new CollectorException(
							PARAMETER + paramName + "." + spParam.getName() + " have not been set");
				}

				data = convertData(spParam, value, false);
				inParameter = new InParameter(spParam.getName(), data);
				spParameters[spParam.getIndexInSybaseScript() - 1] = spParam;
				parameters.put(spParam.getNameInSybaseScript(), inParameter);
			}
		}

		return buildParametersOrdered(spParameters, parameters);
	}

	private Map<String, InParameter> buildParametersOrdered(StoredProcedure.Parameter[] spParameters,
			Map<String, InParameter> parameters) {
		Map<String, InParameter> parametersOrdered = new LinkedHashMap<>();
		for (StoredProcedure.Parameter parameter : spParameters) {
			if (parameter != null) {
				parametersOrdered.put(String.valueOf(parameter.getIndexInSybaseScript()),
						parameters.get(parameter.getNameInSybaseScript()));
			}
		}
		return parametersOrdered;
	}

	private Object applyCaseSensitive(StoredProcedure.Parameter param, String value) {
		switch (param.getCaseSensitive()) {
		case UPPER:
			return value.toUpperCase();
		case LOWER:
			return value.toLowerCase();
		case CAPITALIZE:
			return capitalize(value);
		default:
			return value;
		}
	}

	private Object convertData(StoredProcedure.Parameter param, String value, boolean scientificNotation)
			throws CollectorException {

		switch (param.getDataType()) {
		case VARCHAR:
			// Aplicacion de Case Sensitive en parametros implicito e explicito
			return applyCaseSensitive(param, value);
		case CLOB:
			return value;
		case DATE:
			try {
				return new SimpleDateFormat(BANK_FORMAT_DATE).parse(value);
			} catch (Exception e) {
				throw new CollectorException(CAN_NOT_CONVERT + value + " to date");
			}

		case NUMBER:
			try {
				return new BigDecimal(value);
			} catch (Exception e) {
				throw new CollectorException(CAN_NOT_CONVERT + value + " to number");
			}
		case INTEGER:
			try {
				return scientificNotation ? new BigDecimal(value).intValue() : Integer.parseInt(value);
			} catch (Exception e) {
				throw new CollectorException(CAN_NOT_CONVERT + value + " to integer");
			}
		default:
			return null;
		}
	}

	public Map<String, InParameter> getInParametersAux(Map<String, String> paramsAux, SybaseScript sybaseScript)
			throws CollectorException {
		if (paramsAux == null && sybaseScript.getParameters() != null) {
			throw new CollectorException("parameters is required");
		}
		Map<String, InParameter> parameters = new HashMap<>();
		int countParams = countParams(sybaseScript);
		StoredProcedure.Parameter[] spParameters = new StoredProcedure.Parameter[countParams];
		List<StoredProcedure.Parameter> storeProcedureParams;
		List<StoredProcedure.Parameter> inStoreProcedureParams;

		InParameter inParameter;
		Object data;

		for (String parameterName : sybaseScript.getParameters().keySet()) {
			storeProcedureParams = sybaseScript.getParameters().get(parameterName);
			inStoreProcedureParams = storeProcedureParams.parallelStream().filter(x -> x.getType().equals(ParamType.IN))
					.collect(Collectors.toList());
			for (StoredProcedure.Parameter spParam : inStoreProcedureParams) {
				String value = paramsAux != null ? paramsAux.get(spParam.getName()) : null;				
				log.info("param --> " + spParam.getName());
				log.info("value --> " + value);
				
				if (value == null) {
					throw new CollectorException(
							PARAMETER + parameterName + "." + spParam.getName() + " have not been set");
				}

				data = convertData(spParam, value, true);				
				inParameter = new InParameter(spParam.getName(), data);
				spParameters[spParam.getIndexInSybaseScript() - 1] = spParam;
				parameters.put(spParam.getNameInSybaseScript(), inParameter);
			}

		}
		return buildParametersOrdered(spParameters, parameters);
	}

	public List<StoredProcedure.Parameter> getOutParameters(SybaseScript sybaseScript) {
		List<StoredProcedure.Parameter> parameters = new ArrayList<>();
		for (String sp : sybaseScript.getParameters().keySet()) {
			for (StoredProcedure.Parameter parameter : sybaseScript.getParameters().get(sp)) {
				switch (parameter.getType()) {
				case OUT:
					parameters.add(parameter);
					break;
				case INOUT:
					parameters.add(parameter);
					break;
				default:
					break;
				}
			}
		}
		return parameters;
	}

	private Map<String, Object> iterateOutParams(CallableStatement callableStatement,
			List<StoredProcedure.Parameter> outParameters, boolean metadata, int returnIndex)
			throws SQLException, ParseException {
		Map<String, Object> result = new LinkedHashMap<>();
		for (StoredProcedure.Parameter parameter : outParameters) {
			log.info("parametro OUT getName " + parameter.getName());
			log.info("parametro OUT getAlias " + parameter.getAlias());
			log.info("parametro OUT getIndexInSybaseScript " + parameter.getIndexInSybaseScript());
			log.info("parametro OUT getDataType " + parameter.getDataType());

			String data = convertValue(callableStatement, parameter, returnIndex);
			log.info("parametro OUT data FORMATO " + data);

			if (metadata) {
				if (parameter.getAlias() != null && !parameter.getAlias().isEmpty()) {
					result.put(parameter.getAlias(), data);
				} else {
					result.put(parameter.getNameInSybaseScript(), data);
				}
			} else {
				if (parameter.getName() != null && !parameter.getName().isEmpty()) {
					result.put(parameter.getName(), data);
				} else {
					result.put(parameter.getNameInSybaseScript(), data);
				}
			}

		}
		return result;
	}

	public void processResulset(List<String[]> lstString, boolean metadata, Map<String, Object> result) {
		if (lstString != null) {
			if (metadata) {
				result.put("result", lstString);

			} else {
				String splitChar = ";";
				int index = 1;
				for (String[] datos : lstString) {

					result.put("resultCLT" + index, processListString(datos, splitChar));
					index++;
				}
			}
		}
	}

	private String processListString(String[] datos, String splitChar) {
		StringBuilder resultStr = new StringBuilder();
		for (String resulSetStr : datos) {
			resultStr.append(resulSetStr != null ? resulSetStr.replace(splitChar, "") : "");
			resultStr.append(splitChar);
		}
		return resultStr.toString();
	}

	public Map<String, Object> getResultsFromCallableStatement(CallableStatement callableStatement,
			List<StoredProcedure.Parameter> outParameters, boolean metadata, List<String[]> lstString, int returnIndex)
			throws SQLException, ParseException {
		Map<String, Object> result = iterateOutParams(callableStatement, outParameters, metadata, returnIndex);
		log.debug("getResultsFromCallableStatement1 -- >" + result);
		processResulset(lstString, metadata, result);
		log.debug("getResultsFromCallableStatement2 -- >" + result);
		return result;
	}

	private String capitalize(String text) {
		StringBuilder sb = new StringBuilder();
		String[] array = text.split("");
		String previous = " ";
		for (int i = 0; i < array.length; i++) {
			if (previous.equals(" ") && i < array.length - 1 && !array[i].equals(" ")) {
				array[i] = array[i].toUpperCase();
			}
			previous = array[i];
			sb.append(array[i]);
		}
		return sb.toString();
	}

	private String convertValue(CallableStatement callableStatement, StoredProcedure.Parameter parameter,
			int returnIndex) throws SQLException, ParseException {
		String data = "";
		switch (parameter.getDataType()) {
		case VARCHAR:
			data = callableStatement.getString(parameter.getIndexInSybaseScript() + returnIndex);
			// Aplicacion de Case Sensitive en parametros implicito e explicito
			if (data != null && !data.isEmpty()) {
				switch (parameter.getCaseSensitive()) {
				case UPPER:
					data = data.toUpperCase();
					break;
				case LOWER:
					data = data.toLowerCase();
					break;
				case CAPITALIZE:
					data = capitalize(data);
					break;
				default:
					break;
				}
			} else {
				data = "";
			}
			break;
		case CLOB:
			Clob clob = callableStatement.getClob(parameter.getIndexInSybaseScript() + returnIndex);
			data = clob.getSubString(1L, (int) clob.length());
			break;
		case INTEGER:
			int integer = callableStatement.getInt(parameter.getIndexInSybaseScript() + returnIndex);
			log.debug("parametro OUT data INT  " + integer);
			data = String.valueOf(integer);
			break;
		case NUMBER:
			BigDecimal bigDecimal = callableStatement.getBigDecimal(parameter.getIndexInSybaseScript() + returnIndex);
			data = bigDecimal != null ? bigDecimal.toString() : "";
			break;
		case DATE:
			SimpleDateFormat format = new SimpleDateFormat(BANK_FORMAT_DATE);
			Date fecha = format.parse(String.valueOf(parameter.getIndexInSybaseScript()));
			data = fecha.toString();
			break;
		case CURSOR:
			ResultSet rs = (ResultSet) callableStatement.getObject(parameter.getIndexInSybaseScript() + returnIndex);
			while (rs.next()) {
				data = rs.getString(1);
			}
			break;
		default:
			break;
		}
		return data;
	}

}
