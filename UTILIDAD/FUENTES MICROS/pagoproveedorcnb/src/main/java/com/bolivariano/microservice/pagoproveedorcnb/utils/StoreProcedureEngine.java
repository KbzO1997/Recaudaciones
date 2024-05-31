package com.bolivariano.microservice.pagoproveedorcnb.utils;

import com.bolivariano.microservice.pagoproveedorcnb.domain.InParameter;
import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes;
import com.bolivariano.microservice.pagoproveedorcnb.model.StoredProcedure;
import com.sybase.jdbc4.jdbc.SybCallableStatement;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.math.BigDecimal;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

@ApplicationScoped
public class StoreProcedureEngine {
	@Inject
	Logger log;

	private static final LogsUtils logger = LogsUtils.getLogger(StoreProcedureEngine.class);

	@ConfigProperty(name = "otc-collector.sybase.datasource.querytimeout", defaultValue = "5000")
	int queryTimeOut;

	public Map<String, Object> executeStatement(String script, Connection connection,
			Map<String, InParameter> inParameters, List<StoredProcedure.Parameter> outParameters)
			throws CollectorException {
		Date time = new Date();
		try {
			boolean hasReturn = script.contains("? = call");
			CallableStatement callableStatement = prepareStatement(script, connection, inParameters, outParameters);
			log.info("callableStatement script -->" + callableStatement);
			boolean resultRest = callableStatement.execute();

			logger.tiempo(script, "", CoreUtils.dateToString(time), CoreUtils.getTimeIntervalInt(time), null,
					queryTimeOut - 1000);

			List<String[]> lstString = null;
			int codigoRetorno = 0;
			int updateCount;

			do {
				if (resultRest) {
					lstString = new ArrayList<>();
					ResultSet rs = callableStatement.getResultSet();
					log.info("Result Set -- > " + rs);
					log.info("Metadata -- > " + callableStatement.getMetaData());
					int columnas = callableStatement.getMetaData().getColumnCount();
					log.info("columnas Set -- > " + columnas);

					while (rs.next()) {
						String[] b = new String[columnas];
						for (int i = 0; columnas > i; i++) {
							b[i] = rs.getString(i + 1);
							log.info("columnas DATA -- > " + b[i]);
						}

						lstString.add(b);
					}
					break;
				}
				updateCount = callableStatement.getUpdateCount();
				resultRest = callableStatement.getMoreResults();
			} while (updateCount != -1);

			if (hasReturn) {
				codigoRetorno = callableStatement.getInt(1);
			}

			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("callableStatement", callableStatement);
			resultMap.put("lstString", lstString);
			resultMap.put("codigoRetorno", codigoRetorno);

			return resultMap;
		} catch (Exception e) {
			log.error("Error al ejecutar executeStatement: " + e.getMessage(), e);
			logger.error(script, "", CoreUtils.dateToString(time), CoreUtils.getTimeIntervalInt(time), null,
					e.toString());
			throw new CollectorException(e);
		}
	}

	private void setParameterValue(SybCallableStatement callableStatement, Map<String, InParameter> inParameters,
			boolean hasReturn) throws NumberFormatException, SQLException {
		int index;
		for (Map.Entry<String, InParameter> me : inParameters.entrySet()) {
			String parameter = me.getKey();
			InParameter inParameter = me.getValue();
			Object value = inParameter.getData();
			index = Integer.parseInt(parameter) + (hasReturn ? 1 : 0);
			log.info("PARAMETRO ENTRADA: " + me.getKey() + " - VALOR: " + me.getValue() + " - INDEX: " + index);
			log.info("PARAMETRO ENTRADA NOMBRE: " + inParameter.getName());
			log.info("VALOR DE ENTRADA: " + value);
			if (hasReturn) {
				callableStatement.setParameterName(index, "@" + inParameter.getName());
			}
			if (value instanceof String) {
				callableStatement.setString(index, (String) value);
			} else if (value instanceof Integer) {
				callableStatement.setInt(index, (Integer) value);
			} else if (value instanceof BigDecimal) {
				callableStatement.setBigDecimal(index, (BigDecimal) value);
			} else if (value instanceof Date) {
				SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
				String date = format.format((Date) value);
				callableStatement.setString(index, date);
			}
		}

	}

	private SybCallableStatement prepareStatement(String script, Connection connection,
			Map<String, InParameter> inParameters, List<StoredProcedure.Parameter> outParameters)
			throws CollectorException {
		try {

			log.info("Prepare statment");
			if (script.contains("pa_cc_itprvtrccnb")) {
				log.info("Entra al cambio");
				script = script.replace("s_", "e_");
				script = script.replace("i_", "e_");
				script = script.replace("t_", "e_");
			}

			boolean hasReturn = script.contains("? = call");
			int returnIndex = 0;
			log.info("CONTIENE CALL: " + hasReturn);

			SybCallableStatement callableStatement = connection.prepareCall(script).unwrap(SybCallableStatement.class);
			// SETEO RETURN VALUE
			if (hasReturn) {
				returnIndex = 1;
				callableStatement.setParameterName(returnIndex, "@RETURN_VALUE");
				callableStatement.registerOutParameter(returnIndex, Types.INTEGER);
			}
			// seteo variables de entrada
			setParameterValue(callableStatement, inParameters, hasReturn);
			// seteo de valiavles de salida
			int index;
			if (outParameters != null) {
				for (StoredProcedure.Parameter param : outParameters) {
					if (param.getType() != EnumTypes.ParamType.IN) {
						index = param.getIndexInSybaseScript() + returnIndex;
						log.info("REGISTRA PARAMETRO DE SALIDA -- > " + param.getName());
						log.info("INDEX DE SALIDA -- > " + index);
						if (hasReturn) {
							callableStatement.setParameterName(index, "@" + param.getName());
						}
						switch (param.getDataType()) {
						case VARCHAR:
							callableStatement.registerOutParameter(index, Types.VARCHAR);
							break;
						case INTEGER:
							callableStatement.registerOutParameter(index, Types.INTEGER);
							break;
						case NUMBER:
							callableStatement.registerOutParameter(index, Types.NUMERIC);
							break;
						case DATE:
							callableStatement.registerOutParameter(index, Types.DATE);
							break;
						default:
							break;
						}
					}
				}
			}
			return callableStatement;

		} catch (Exception e) {
			log.error("Error al setear parametros de salida: " + e.getMessage(), e);
			throw new CollectorException(e);
		}

	}

}
