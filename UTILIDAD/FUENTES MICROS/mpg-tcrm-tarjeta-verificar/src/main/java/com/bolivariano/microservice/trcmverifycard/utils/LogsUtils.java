package com.bolivariano.microservice.trcmverifycard.utils;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

public class LogsUtils {

    private Logger logger;

    private LogsUtils() {

    }

    public static LogsUtils getLogger(Class<?> klzz) {
        var ul = new LogsUtils();
        ul.setLogger(LoggerFactory.getLogger(klzz));
        return ul;
    }

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    public void tiempo(String proceso, String fecha, Integer tiempo, Map<String, Object> params, int sla) {
        LogTiempo log;
        if (tiempo > sla) {
            log = createObjetTime(proceso, fecha, tiempo, params);
            String logMsg = log.toString();
            logger.warn(logMsg);
        } else {
            log = createObjetTime(proceso, fecha, tiempo, params);
            String logMsg = log.toString();
            logger.info(logMsg);
        }
    }

    public void error(String proceso, String fecha, Integer tiempo, Map<String, Object> params, String error) {
        LogTiempo log = createObjetTime(proceso, fecha, tiempo, params, error);
        String logMsg = log.toString();
        logger.error(logMsg);
    }

    public void error(String proceso, String error) {
        logger.error(proceso, error);
    }

    private LogTiempo createObjetTime(String proceso, String fecha, Integer tiempo, Map<String, Object> params) {

        return createObjetTime(proceso, fecha, tiempo, params, null);

    }

    private LogTiempo createObjetTime(String proceso, String fecha, Integer tiempo, Map<String, Object> params, String error) {
        var log = LogTiempo.createIntance();
        log.setProceso(proceso);
        log.setFecha(fecha);
        log.setTiempo(tiempo);
        log.setParams(params);
        log.setError(error);
        return log;
    }

}