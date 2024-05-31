package com.bolivariano.microservice.tcrtconsultamediospan.service;

import com.bolivariano.microservice.tcrtconsultamediospan.configuration.ClienteRestConfig;
import com.bolivariano.microservice.tcrtconsultamediospan.configuration.WebServiceConfig;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.*;
import com.bolivariano.srvmediosenvio.detallemedios.v1.DetalleMedios;
import com.bolivariano.srvmediosenvio.mediosenvio.v1_0.MediosEnvioPortType;
import com.bolivariano.srvmediosenvio.mensajemediosenvio.v1.MensajeEntradaConsultarMedios;
import com.bolivariano.srvmediosenvio.mensajemediosenvio.v1.MensajeSalidaConsultarMedios;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ConsultaPanSvc {

    private static final Logger logger= LoggerFactory.getLogger(ConsultaPanSvc.class);
    
    @Autowired
    ClienteRestConfig clientePan;

    @Autowired
    private WebServiceConfig service;

    public ApiResponse consultarMediosPan(ConsultaIdentificacionRequest mensajeEntrada) {

        try {
            logger.info("Invocacion a consulta identificacion por pan Rest");

            ApiResponse respuesta = clientePan.consultaIdentificacion(mensajeEntrada);

            if (respuesta.getResponse().getCode() == 200) {
                ObjectMapper objectMapper = new ObjectMapper();
                ConsultaIdentificacion consultaIdentificacion = objectMapper.convertValue(respuesta.getData(), ConsultaIdentificacion.class);

                String identificacion = consultaIdentificacion.getId();

                // Llamar a la función para obtener los medios
                List<Medios> mediosList = obtenerMediosDeMediosEnvio(identificacion);

                if (mediosList.isEmpty()) {
                    return new ApiResponse(RouteResponse.response(RouteResponse.Status.NOT_FOUND, "No se encontraron medios para el cliente"));
                }

                return new ApiResponse(RouteResponse.response(RouteResponse.Status.OK), mediosList);

            } else {
                if(respuesta.getResponse().getCode() == 404){
                    logger.info("No se ha encontrado registro relacionado con el PAN");
                }
                // Si la respuesta no es 200 (OK), devolver una ApiResponse con el código y mensaje de la respuesta
                return new ApiResponse(respuesta.getResponse());
            }
        } catch (Exception e) {
            logger.error("Error invocacion rest: {}", e.getMessage());
            return new ApiResponse(RouteResponse.response(RouteResponse.Status.INTERNAL_ERROR));
        } finally {
            logger.info("Fin Invocacion a consulta identificacion por pan Rest");
        }
    }

    public ApiResponse consultaIdentificacionCodigoMis(Integer codigomis) {
        try {

            ClienteResponseData responseData = clientePan.consultaIdentificacionCodigoMis(codigomis);

            if ((responseData  != null) && (responseData.getData() != null)) {
                List<Medios> mediosList = obtenerMediosDeMediosEnvio(responseData.getData().getIdentificaion());
                if (mediosList.isEmpty()) {
                    return new ApiResponse(RouteResponse.response(RouteResponse.Status.NOT_FOUND));
                }

                return new ApiResponse(RouteResponse.response(RouteResponse.Status.OK), mediosList);
            }else {
                if(responseData.getStatus() == 404){
                    logger.info("No se ha encontrado registro relacionado con el PAN");
                }
                // Si la respuesta no es 200 (OK), devolver una ApiResponse con el código y mensaje de la respuesta
                return new ApiResponse(RouteResponse.response(RouteResponse.Status.NOT_FOUND));
            }

        }catch ( Exception ex){
            logger.error("Error invocacion rest: {}", ex.getMessage());
            return new ApiResponse(RouteResponse.response(RouteResponse.Status.INTERNAL_ERROR));
        } finally {
            logger.info("Fin Invocacion a consulta identificacion por pan Rest");
        }

    }


    private List<Medios> obtenerMediosDeMediosEnvio(String identificacion) {
        List<Medios> mediosList = new ArrayList<>();

        try {
            logger.info("Llamado a Medios Envio Soap");
            MensajeEntradaConsultarMedios mensajeEntradaConsultarMedios = new MensajeEntradaConsultarMedios();
            mensajeEntradaConsultarMedios.setIdentificacion(identificacion);
            MediosEnvioPortType consultaMedios = service.clienteConsultaMedios();
            MensajeSalidaConsultarMedios respuestaMedios = consultaMedios.consultarMedios(mensajeEntradaConsultarMedios);

            if (respuestaMedios.getCodigoError().equals("0")) {
                mediosList = obtenerMedios(respuestaMedios);
            } else {
                logger.error("Error en el llamado a Medios Envio. Código de error: {}", respuestaMedios.getCodigoError());
            }

        } catch (Exception e) {
            logger.error("Error al consumir Medios Envio Soap: {}", e.getMessage());
        } finally {
            logger.info("Fin Invocacion a Medios Envio Soap");
        }

        return mediosList;
    }

    private List<Medios> obtenerMedios(MensajeSalidaConsultarMedios respuestaMedios) {
        List<Medios> mediosList = new ArrayList<>();

        int cantMedios = respuestaMedios.getDetalleMedios().getDetalleMedios().size();

        if (cantMedios > 0) {
            logger.info("Se recupero información de Medios Envío");
            List<DetalleMedios> detalles = respuestaMedios.getDetalleMedios().getDetalleMedios();

            // Iterar a través de los objetos DetalleMedios
            for (DetalleMedios detalle : detalles) {
                // Crear un objeto Medios y agregarlo a la lista
                mediosList.add(new Medios(detalle.getTipoMedio(), detalle.getDeDescripcion()));
            }
        } else {
            logger.info("La respuesta no contiene detalles de medios.");
        }

        return mediosList;
    }

}
