package com.bolivariano.microservice.otp.utils;

import java.sql.Types;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;
import com.bolivariano.utilitario.common.Utils;
import com.bolivariano.utilitario.dao.DbParameter;
import com.bolivariano.microservice.otp.configuration.DataSourceManager;
import com.bolivariano.microservice.otp.utils.constant.Enums;

@Component
public class StoredProcedureUtils {

	private static final LogsUtils logger = LogsUtils.getLogger(StoredProcedureUtils.class);

	@Autowired
	private DataSourceManager dataSourceManager;

	private Integer queryTimeout;

	public StoredProcedureUtils() {
		this.queryTimeout = Enums.DEFAULT_QUERY_TIMEOUT;
	}

	public Map<String, Object> callStoredProcedureSybase(String proceso, String schemaName, String catalogName,
			String procedureName, List<DbParameter> parameters, Boolean returnValue) {

		Date startTime = new Date();
		try {
			queryTimeout = Enums.DEFAULT_QUERY_TIMEOUT;
			Map<String, Object> parametros = Utils.getDBParameters(parameters);
			SqlParameter[] sqlParameters = (SqlParameter[]) parametros.get("SQLPARAMETER");
			MapSqlParameterSource inParams = (MapSqlParameterSource) parametros.get("MAPPARAMETER");
			SimpleJdbcCall simpleJdbcCall = getCallObject(schemaName, catalogName, procedureName, sqlParameters,
					returnValue);

			Map<String, Object> result = (Map<String, Object>) simpleJdbcCall.execute(inParams);

			logger.tiempo(proceso, catalogName + "." + procedureName, CoreUtils.dateToString(startTime),
					CoreUtils.getTimeIntervalInt(startTime), parametros, queryTimeout - 1000);

			return result;

		} catch (Exception e) {
			logger.error(proceso, catalogName + "." + procedureName, CoreUtils.dateToString(startTime),
					CoreUtils.getTimeIntervalInt(startTime), Utils.getDBParameters(parameters), e.toString());
			return null;
		}

	}

	private final SimpleJdbcCall getCallObject(String schemaName, String catalogName, String procedureName,
			SqlParameter[] sqlParameters, boolean returnValue) {
		DataSource sybaseDataSource = dataSourceManager.sybaseDataSource();
		SimpleJdbcCall simpleJdbcCall = dataSourceManager.sybaseSimpleJdbcCall(sybaseDataSource);

		simpleJdbcCall.getJdbcTemplate().setQueryTimeout(queryTimeout);
		simpleJdbcCall.withCatalogName(catalogName);
		simpleJdbcCall.withSchemaName(schemaName);
		simpleJdbcCall.withProcedureName(procedureName);
		if (returnValue) {
			simpleJdbcCall.declareParameters(new SqlOutParameter("return_value", Types.VARCHAR));
			simpleJdbcCall.declareParameters(sqlParameters);
			simpleJdbcCall.withReturnValue();
		} else {
			simpleJdbcCall.declareParameters(sqlParameters);
		}

		simpleJdbcCall.setAccessCallParameterMetaData(false);
		simpleJdbcCall.withoutProcedureColumnMetaDataAccess();
		simpleJdbcCall.compile();
		return simpleJdbcCall;
	}
}
