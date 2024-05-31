package com.bolivariano.microservice.pagoproveedorcnb.utils;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogsUtils {

    private Logger logger;

    private LogsUtils(){

    }
    
    

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    public static LogsUtils getLogger(Class<?> klzz){
        LogsUtils ul = new LogsUtils();
        ul.setLogger( LoggerFactory.getLogger(klzz));
        return ul;
    }


    public void tiempo(String proceso, String objeto,String fecha, Integer tiempo, Map<String, Object> params, int sla)
    {
        if (tiempo > sla)
        {
            LogTiempo log = createObjetTime(proceso,objeto,fecha,tiempo,params);
            logger.warn ( log.toString() );
        }
        else
        {
            LogTiempo log = createObjetTime(proceso,objeto,fecha,tiempo,null);
            logger.info( log.toString() );
        }
    }
    public void error(String proceso, String objeto,String fecha, Integer tiempo, Map<String, Object> params, String error)
    {
        LogTiempo log = createObjetTime(proceso,objeto,fecha,tiempo,params,error);
        logger.error(log.toString());
    }

    private LogTiempo createObjetTime(String proceso, String objeto,String fecha, Integer tiempo, Map<String, Object> params){

        return  createObjetTime(proceso,objeto,fecha,tiempo,params,null);

    }
    private LogTiempo createObjetTime(String proceso, String objeto,String fecha, Integer tiempo, Map<String, Object> params,String error){
        LogTiempo log = LogTiempo.createIntance();
        log.setProceso(proceso);
        log.setObjeto(objeto);
        log.setFecha(fecha);
        log.setTiempo(tiempo);
        log.setParams(params);
        log.setError(error);
        return  log;
    }






}

