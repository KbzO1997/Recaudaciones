package com.bolivariano.microservice.trcmverifycard.utils;

import com.bolivariano.microservice.trcmverifycard.dto.VerificaTarjetaReq;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ValidaUtil {
    static final Logger logger = LoggerFactory.getLogger(ValidaUtil.class);

    private ValidaUtil(){

    }

    public static Boolean validaRequest(VerificaTarjetaReq req){
        boolean valida= false;
        if(req.getPan().isEmpty()||req.getPan().isBlank()){
            valida = true;
        }
        if(req.getCardBin().isEmpty()||req.getCardBin().isBlank()){
            valida = true;
        }

        if(req.getExp().isEmpty()||req.getExp().isBlank()){
            valida = true;
        }
        return valida;
    }

    public static String ocultarCaracteres(String input) {
        if (input.length() >= 10) {
            String primerosSeis = input.substring(0, 6);

            String ultimosCuatro = input.substring(input.length() - 4);

            int caracteresOcultos = input.length() - 10;

            String ocultos = "X".repeat(caracteresOcultos);

            return primerosSeis + ocultos + ultimosCuatro;
        } else {
            return "";
        }
    }
    public static String generarSecuencial(){
        LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter customFormatter = DateTimeFormatter.ofPattern("MMddHHmmss");
        String numericDateTime = now.format(customFormatter);
        long numericValue = Long.parseLong(numericDateTime);

        return String.valueOf(numericValue);
    }
    public static String obtenerIp(){
        String dataResp = "";
        try{
            InetAddress ip = InetAddress.getLocalHost();
            dataResp = ip.getHostAddress();
        } catch (UnknownHostException ex){
            logger.error(ex.getMessage());
        }
        return dataResp;
    }
    public static String obtenerFecha(){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatoDate = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        return now.format(formatoDate);
    }
}
