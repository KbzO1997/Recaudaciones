package com.bolivariano.microservice.pagoproveedorcnb.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import com.bolivariano.microservice.pagoproveedorcnb.domain.InParameter;
import com.bolivariano.microservice.pagoproveedorcnb.utils.DataSourceFactory;
import com.bolivariano.microservice.pagoproveedorcnb.utils.StoreProcedureEngine;
import org.jboss.logging.Logger;

import com.bolivariano.microservice.pagoproveedorcnb.bean.CollectorRequest;
import com.bolivariano.microservice.pagoproveedorcnb.bean.MessageResponse;
import com.bolivariano.microservice.pagoproveedorcnb.dao.StoreProcedureDAO;
import com.bolivariano.microservice.pagoproveedorcnb.dao.SybaseScriptEngineDAO;
import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.model.StoredProcedure;
import com.bolivariano.microservice.pagoproveedorcnb.model.SybaseScript;


@ApplicationScoped
public class ExecutorService {

    @Inject
    Logger log;

    @Inject
    StoreProcedureEngine dataSourceEngine;

    @Inject
    DataSourceFactory dataSourceFactory;

    @Inject
    StoreProcedureDAO storeProcedureEngine;

    @Inject
    SybaseScriptEngineDAO sybaseScriptEngine;

    public MessageResponse executeTransaction(CollectorRequest collectorRequest) throws CollectorException  {
        MessageResponse microsreResponse = new MessageResponse();
        log.info("opcion collector --> " + collectorRequest.getOpcion());
        List<String[]> lstOperacionEjecutar = sybaseScriptEngine.obtieneOrdenEjecucion(collectorRequest.getOpcion());
        Connection connection = null;
        CallableStatement callableStatement = null;
        Map<String, Object> resultMap;
        int codigoRetorno = 300;

        try {
            log.info("lstOperacionEjecutar collector --> " + lstOperacionEjecutar);
            connection = dataSourceFactory.getConnection();

            for (String[] arreglo : lstOperacionEjecutar) {
                SybaseScript sybaseScript = sybaseScriptEngine.validateSybaseScript(arreglo[1], arreglo[2]);
                collectorRequest.getDatos().put("i_opcion", arreglo[2]);
                Map<String, InParameter> inParameters = storeProcedureEngine.getInParametersAux(collectorRequest.getDatos(), sybaseScript);

				if (sybaseScript.getScript().contains("pa_cc_itprvtrccnb")) {

					inParameters.forEach((s, i) -> {
						String nombreActual = i.getName();
						nombreActual = nombreActual.replace("s_", "e_").replace("i_", "e_").replace("t_", "e_");
						i.setName(nombreActual);
					});
				}

                log.infof("Se obtuvo inParameters %s", inParameters);
                List<StoredProcedure.Parameter> outParameters = storeProcedureEngine.getOutParameters(sybaseScript);              
                
                log.infof("Se obtuvo outParameters %s", outParameters);

                String scripFinal = sybaseScript.getScript();
                log.info("SCRIPT FINAL --> " + scripFinal);
                scripFinal = convertExecScriptToCall(scripFinal);
                log.info("SCRIPT FINAL MODIFICADO --> " + scripFinal);
                boolean hasReturn = scripFinal.contains("? = call");
                int returnIndex = 0;
                log.info("*** CONTIENE CALL: " + hasReturn);
                //SETEO RETURN VALUE
                if (hasReturn){
                    returnIndex = 1;
                }

                resultMap = dataSourceEngine.executeStatement(scripFinal, connection, inParameters, outParameters);
                callableStatement = (CallableStatement) resultMap.get("callableStatement");
                Map<String, Object> result = storeProcedureEngine.getResultsFromCallableStatement(callableStatement, outParameters, false, (List<String[]> )resultMap.get("lstString"), returnIndex);
                codigoRetorno = (int) resultMap.get("codigoRetorno");
                log.info("CODIGO RETORNO --> " + codigoRetorno);
                result.put("RETURN_VALUE", codigoRetorno);

                if (!connection.getAutoCommit()){
                    connection.commit();
                }

                microsreResponse.setResult(result);
                microsreResponse.setExecutionDate(new Date());
                microsreResponse.setCodeSPError(codigoRetorno + "");
                callableStatement.close();

            }
        }catch (Exception e) {
            log.error("ERROR SP: " + e.getMessage(), e);
            throw new CollectorException(e);
        }finally {
            try {                    
				if (callableStatement != null){
                    callableStatement.close();
                }
				if (connection != null){
                    connection.close();
                }
			} catch (SQLException ex) {
				log.warn("Error closing connections", ex);
			}
        }
        return microsreResponse;
    }

    private String convertExecScriptToCall(String script){
        String[] arr = script.split(" ");

        int nums = 0;
        char temp;
        for (int i = 0; i < script.length(); i++) {

            temp = script.charAt(i);
            if (temp == '?')
                nums++;
        }

        StringBuilder scriptFinal = new StringBuilder();
        scriptFinal.append("{? = call ");
        scriptFinal.append(arr[1]);
        scriptFinal.append("(");
        for(int index= 0; index < nums-1; index++){
            scriptFinal.append("?,");
        }
        if (nums > 0){
            scriptFinal.append("?)}");
        }else{
            scriptFinal.append(")}");
        }
        return scriptFinal.toString();
    }
}