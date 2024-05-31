package com.bolivariano.microservice.trcmverifycard.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CoreUtils {
    /* Constructor vacio debido a requerimientos de sonarqu */
    CoreUtils() {
    }

    public static String dateToString(Date fecha, String formato) {
        var simpleDateFormat = new SimpleDateFormat(formato);
        return simpleDateFormat.format(fecha);
    }

    public static String dateToString(Date fecha) {
        return CoreUtils.dateToString(fecha, "yyyy/MM/dd kk:mm:ss");
    }

    public static String dateToString() {
        return CoreUtils.dateToString(new Date());
    }

    public static double getTimeInterval(Date fechaInicio, Date fechaTermino, boolean resultInMiliseconds) {
        Integer milisecond = 1000;
        if (resultInMiliseconds) {
            milisecond = 1;
        }
        return (((double) fechaTermino.getTime() / milisecond) - ((double) fechaInicio.getTime() / milisecond));
    }

    public static double getTimeInterval(Date fechaInicio, boolean resultInMiliseconds) {
        return CoreUtils.getTimeInterval(fechaInicio, new Date(), resultInMiliseconds);
    }

    public static double getTimeInterval(Date fechaInicio) {
        return CoreUtils.getTimeInterval(fechaInicio, true);
    }

    public static Integer getTimeIntervalInt(Date fechaInicio) {
        double segundos = CoreUtils.getTimeInterval(fechaInicio);
        return (int) segundos;
    }

}
