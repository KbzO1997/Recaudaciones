package com.bolivariano.microservice.utilitarioms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;

import com.bolivariano.microservice.utilitarioms.configuration.DataSourceManager;
import com.bolivariano.utilitario.common.Utils;
import com.bolivariano.utilitario.dao.DbParameter;

@Component
public class StoredProcedureUtils {
	Logger logger = LoggerFactory.getLogger(StoredProcedureUtils.class);
	
	@Autowired
    private DataSourceManager dataSourceManager;
    
    public Map<?, ?> callStoredProcedure(String schemaName, String procedureName, Map<String, Object> parameters, SqlParameter[] sqlParameters){
    	DataSource storeDataSource = dataSourceManager.storeDataSource();
    	SimpleJdbcCall simpleJdbcCall = dataSourceManager.storeSimpleJdbcCall(storeDataSource);
		simpleJdbcCall.withCatalogName(schemaName);
		simpleJdbcCall.withSchemaName("dbo");
		simpleJdbcCall.withProcedureName(procedureName);
		simpleJdbcCall.declareParameters(sqlParameters);
		simpleJdbcCall.compile();
		MapSqlParameterSource inParams = new MapSqlParameterSource();
        if(null!=parameters) {
            for (Map.Entry<String, Object> parameter : parameters.entrySet()) {
                inParams.addValue(parameter.getKey(), parameter.getValue());
            }
        }
        logger.debug("PROCEDURE {} IS CALLED",procedureName);
        return simpleJdbcCall.execute(inParams);
        
    }
    
    public Map<?, ?> callStoredFunction(String schemaName, String functionName, Map<String, Object> parameters){
    	DataSource storeDataSource = dataSourceManager.storeDataSource();
    	SimpleJdbcCall simpleJdbcCall = dataSourceManager.storeSimpleJdbcCall(storeDataSource);
		simpleJdbcCall.withCatalogName(schemaName);
		simpleJdbcCall.withSchemaName("dbo");
		simpleJdbcCall.withFunctionName(functionName);
		simpleJdbcCall.withReturnValue();
		simpleJdbcCall.compile();
        MapSqlParameterSource inParams = new MapSqlParameterSource();
        if(null!=parameters) {
            for (Map.Entry<String, Object> parameter : parameters.entrySet()) {
                inParams.addValue(parameter.getKey(), parameter.getValue());
            }
        }
        logger.debug("FUNCTION {} IS CALLED",functionName);
        return simpleJdbcCall.execute(inParams);
    }
    
    public Map<?, ?> callStoredProcedureSybase(String schemaName, String procedureName, List<DbParameter> parameters){
    	//Se descompone la lista de DbParameter para obtener los datos que se utilizaran para la ejecucion del procedimiento
    	Map<String, Object> parametros= Utils.getDBParameters(parameters);
    	SqlParameter[] sqlParameters = (SqlParameter[]) parametros.get("SQLPARAMETER");
    	MapSqlParameterSource inParams = (MapSqlParameterSource) parametros.get("MAPPARAMETER");
    	//Preparando los datos necesarios para la ejecucion
    	DataSource sybaseDataSource = dataSourceManager.sybaseDataSource();
    	SimpleJdbcCall simpleJdbcCall = dataSourceManager.sybaseSimpleJdbcCall(sybaseDataSource);
		simpleJdbcCall.withCatalogName(schemaName);
		simpleJdbcCall.withSchemaName("dbo");
		simpleJdbcCall.withProcedureName(procedureName);
		simpleJdbcCall.withoutProcedureColumnMetaDataAccess(); //Para que no consulte metadata
        if(sqlParameters != null) {
               simpleJdbcCall.declareParameters(sqlParameters);
        }
		simpleJdbcCall.compile();		
        logger.debug("PROCEDURE {} IS CALLED",procedureName);
        return simpleJdbcCall.execute(inParams);         
     }    

    public String[] getParamaters(Map<String, Object> parameters){
    	List<String> list = new ArrayList<>();
    	for(String key: parameters.keySet()) {
    		list.add(key);
    	}
    	String array[] = new String[parameters.size()];
    	array = list.toArray(array);
    	return array;
    }
}
