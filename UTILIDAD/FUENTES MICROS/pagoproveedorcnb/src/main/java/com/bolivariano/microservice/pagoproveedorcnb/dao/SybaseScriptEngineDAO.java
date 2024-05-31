package com.bolivariano.microservice.pagoproveedorcnb.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import com.bolivariano.microservice.pagoproveedorcnb.domain.InParameter;
import com.bolivariano.microservice.pagoproveedorcnb.utils.DataSourceFactory;
import com.bolivariano.microservice.pagoproveedorcnb.utils.StoreProcedureEngine;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.model.SybaseScript;
import com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.CaseSensitive;
import com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.DataType;
import com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.ParamType;
import com.bolivariano.microservice.pagoproveedorcnb.model.StoredProcedure.Parameter;

@ApplicationScoped
public class SybaseScriptEngineDAO {

	@Inject
	StoreProcedureDAO storeProcedureEngine;

	@Inject
	StoreProcedureEngine dataSourceEngine;

	@Inject
	DataSourceFactory dataSourceFactory;

	@Inject
	Logger log;

	public SybaseScript validateSybaseScript(String idScript, String idOperacion) throws CollectorException {
		log.debug("validateSybaseScript idScript --> " + idScript);
		log.debug("validateSybaseScript idOperacion --> " + idOperacion);

		SybaseScript sybaseScript = obtieneinforScript(idScript, idOperacion);
		StringBuilder sqlBuf = new StringBuilder(sybaseScript.getScript().toLowerCase() + " ");
		int parametrosIn = 0;
		int parametrosOut = 0;
		
		for (String storedProcedure : sybaseScript.getParameters().keySet()) {
			for (Parameter param : sybaseScript.getParameters().get(storedProcedure)) {
				if (param.getType().toString().equalsIgnoreCase("IN")) {
					sqlBuf.append("@" + param.getName() + "=? ,");
				}
				if (param.getType().toString().equalsIgnoreCase("OUT")) {
					sqlBuf.append("@" + param.getName() + "= ? out ,");

				}
			}
		}
		sybaseScript.setCantidadParametrosIn(parametrosIn);
		sybaseScript.setCantidadParametrosIn(parametrosOut);

		sybaseScript.setScript(sqlBuf.substring(0, sqlBuf.length() - 1));

		return sybaseScript;
	}

	private Parameter buildParametro(String name, DataType dataType, ParamType paramType, String nameInSybaseScript,
			int indexInSybaseScript, CaseSensitive caseSensitive) {
		Parameter parametro = new Parameter();
		parametro.setName(name);
		parametro.setDataType(dataType);
		parametro.setType(paramType);
		parametro.setNameInSybaseScript(nameInSybaseScript);
		parametro.setIndexInSybaseScript(indexInSybaseScript);
		parametro.setCaseSensitive(caseSensitive);
		return parametro;
	}

	public SybaseScript obtieneinforScript(String idScript, String operacion) throws CollectorException {
		log.debug("obtieneinforScript idScript --> " + idScript);
		log.debug("obtieneinforScript idOperacion --> " + operacion);

		SybaseScript sbScriptInicial = new SybaseScript();
		SybaseScript sbScriptFinal = new SybaseScript();
		List<Parameter> listParametro = new ArrayList<>();

		listParametro.add(
				buildParametro("e_id_script", DataType.VARCHAR, ParamType.IN, "id_script", 1, CaseSensitive.UPPER));
		listParametro.add(
				buildParametro("e_id_opcion", DataType.VARCHAR, ParamType.IN, "id_opcion", 2, CaseSensitive.UPPER));
		listParametro
				.add(buildParametro("s_version", DataType.VARCHAR, ParamType.OUT, "version", 3, CaseSensitive.UPPER));
		listParametro.add(buildParametro("s_transaccion", DataType.VARCHAR, ParamType.OUT, "transaccion", 4,
				CaseSensitive.UPPER));
		listParametro
				.add(buildParametro("s_script", DataType.VARCHAR, ParamType.OUT, "script", 5, CaseSensitive.UPPER));
		listParametro.add(
				buildParametro("s_cod_error", DataType.INTEGER, ParamType.OUT, "cod_error", 6, CaseSensitive.UPPER));
		listParametro.add(buildParametro("s_error", DataType.VARCHAR, ParamType.OUT, "error", 7, CaseSensitive.UPPER));

		Map<String, List<Parameter>> map = new HashMap<>();
		map.put("dbo.pa_rec_obtiene_script", listParametro);
		
		sbScriptInicial.setScript("exec cob_pagos..pa_cp_cobtiene_producto " + "@e_id_script = ? , "
				+ "@e_id_opcion = ? , " + "@s_version = ? out, " + "@s_transaccion = ? out, " + "@s_script = ? out, "
				+ "@s_cod_error = ? out, " + "@s_error = ? out ");

		sbScriptInicial.setParameters(map);

		Map<String, String> mapParam = new HashMap<>();
		Map<String, Map<String, String>> mapParamInical = new HashMap<>();
		mapParam.put("e_id_script", idScript);
		mapParam.put("e_id_opcion", operacion);
		mapParamInical.put("dbo.pa_rec_obtiene_script", mapParam);

		Map<String, InParameter> inputParams = storeProcedureEngine.getInParameters(mapParamInical, sbScriptInicial);
		List<Parameter> outputParams = storeProcedureEngine.getOutParameters(sbScriptInicial);
		Connection connection = dataSourceFactory.getConnection();
		CallableStatement callableStatement = null;

		try {
			Map<String, Object>  resultMap = dataSourceEngine.executeStatement(sbScriptInicial.getScript(), connection, inputParams, outputParams);
			callableStatement = (CallableStatement) resultMap.get("callableStatement");
			Map<String, Object> result = storeProcedureEngine.getResultsFromCallableStatement(callableStatement, outputParams, true, (List<String[]>) resultMap.get("lstString"), 0);

			for (Map.Entry<String, Object> entry : result.entrySet()) {
				sbScriptFinal.setScript(
						"script".equals(entry.getKey()) ? entry.getValue().toString() : sbScriptFinal.getScript());
				sbScriptFinal.setTransaction("transaccion".equals(entry.getKey()) ? entry.getValue().toString()
						: sbScriptFinal.getTransaction());
				sbScriptFinal.setVersion(
						"version".equals(entry.getKey()) ? entry.getValue().toString() : sbScriptFinal.getVersion());

				if ("result".equals(entry.getKey())) {
					List<String[]> lstString = (List<String[]>) entry.getValue();
					listParametro = putParameterInParameterList(lstString);									

					Map<String, List<Parameter>> mapParametro = new HashMap<>();
					mapParametro.put(sbScriptFinal.getTransaction().toLowerCase(), listParametro);

					sbScriptFinal.setParameters(mapParametro);
				}
			}

			if (sbScriptFinal.getScript().trim().length() == 0)
				throw new CollectorException("No existe configuración para id script ingresado.");

		} catch (Exception e) {
			throw new CollectorException(e);
		} finally {
			closeObjects(callableStatement, connection);
		}

		return sbScriptFinal;
	}
	
	private List<Parameter> putParameterInParameterList(List<String[]> lstString) {
		List<Parameter>  listParametro = new ArrayList<>();
		Parameter parametro = null;
		for (String[] arreglo : lstString) {
			parametro = new Parameter();
			parametro.setNameInSybaseScript(arreglo[0]);
			parametro.setName(arreglo[1]);
			parametro.setDataType(validaDataType(arreglo[2]));
			parametro.setType(validaParamType(arreglo[3]));
			parametro.setAlias(arreglo[4]);
			parametro.setIndexInSybaseScript(Integer.parseInt(arreglo[5]));
			parametro.setCaseSensitive(validaCaseSensitive(arreglo[6]));
			listParametro.add(parametro);
		}
		return listParametro;
	}
	public List<String[]> obtieneOrdenEjecucion(String opcion) throws CollectorException {

		SybaseScript sbScriptInicial = new SybaseScript();
		List<String[]> lstString = null;
		List<Parameter> listParametro = new ArrayList<>();
		
		listParametro.add(
				buildParametro("e_id", DataType.VARCHAR, ParamType.IN, "id", 1, CaseSensitive.UPPER));
		listParametro.add(
				buildParametro("s_cod_error", DataType.INTEGER, ParamType.OUT, "cod_error", 2, CaseSensitive.UPPER));
		listParametro.add(buildParametro("s_error", DataType.VARCHAR, ParamType.OUT, "error",3, CaseSensitive.UPPER));

		Map<String, List<Parameter>> map = new HashMap<>();
		map.put("dbo.pa_rec_obtiene_orden_ejecucion", listParametro);

		sbScriptInicial.setScript("exec cob_pagos..pa_cp_corden_ejecucion_prod " + "@e_id = ? , "
				+ "@s_cod_error = ? out, " + "@s_error = ? out ");

		sbScriptInicial.setParameters(map);

		Map<String, String> mapParam = new HashMap<>();
		Map<String, Map<String, String>> mapParamInical = new HashMap<>();
		mapParam.put("e_id", opcion);
		mapParamInical.put("dbo.pa_rec_obtiene_orden_ejecucion", mapParam);

		Map<String, InParameter> inParameters = storeProcedureEngine.getInParameters(mapParamInical, sbScriptInicial);
		List<Parameter> outParameters = storeProcedureEngine.getOutParameters(sbScriptInicial);

		Connection connection = dataSourceFactory.getConnection();
		CallableStatement callableStatement = null;
		Map<String, Object> resultMap = null;

		try {
			resultMap = dataSourceEngine.executeStatement(sbScriptInicial.getScript(), connection, inParameters, outParameters);
			callableStatement = (CallableStatement) resultMap.get("callableStatement");
			Map<String, Object> result = storeProcedureEngine.getResultsFromCallableStatement(callableStatement, outParameters, true, (List<String[]>) resultMap.get("lstString"), 0);

			for (Map.Entry<String, Object> entry : result.entrySet()) {
				if ("result".equals(entry.getKey())) {
					lstString = (List<String[]>) entry.getValue();

				}
			}

		} catch (Exception e) {
			throw new CollectorException(e);
		} finally {
			closeObjects(callableStatement, connection);
		}

		return lstString;
	}

	public DataType validaDataType(String valor) {

		switch (valor) {
		case "VARCHAR":
			return DataType.VARCHAR;
		case "INTEGER":
			return DataType.INTEGER;
		case "DATE":
			return DataType.DATE;
		case "NUMBER":
			return DataType.NUMBER;
		default:
			break;
		}

		return null;
	}

	public ParamType validaParamType(String valor) {

		switch (valor) {
		case "IN":
			return ParamType.IN;
		case "OUT":
			return ParamType.OUT;
		case "INOUT":
			return ParamType.INOUT;
		default:
			break;
		}

		return null;
	}

	public CaseSensitive validaCaseSensitive(String valor) {

		switch (valor) {
		case "UPPER":
			return CaseSensitive.UPPER;
		case "LOWER":
			return CaseSensitive.LOWER;
		case "CAPITALIZE":
			return CaseSensitive.CAPITALIZE;
		case "NONE":
			return CaseSensitive.NONE;
		default:
			break;
		}

		return null;
	}
	
	private void closeObjects(CallableStatement callableStatement, Connection connection) {
		try {
			if (callableStatement != null)
				callableStatement.close();
			if (connection != null)
				connection.close();				
		} catch (Exception e) {
			log.warn("Error clossing connection");
		}
	}

}
