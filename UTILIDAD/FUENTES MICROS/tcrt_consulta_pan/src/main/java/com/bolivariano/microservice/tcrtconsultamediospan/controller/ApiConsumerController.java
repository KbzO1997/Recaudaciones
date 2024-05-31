package com.bolivariano.microservice.tcrtconsultamediospan.controller;

import com.bolivariano.microservice.tcrtconsultamediospan.dto.ApiResponse;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.ConsultaIdentificacionRequest;
import com.bolivariano.microservice.tcrtconsultamediospan.dto.RouteResponse;
import com.bolivariano.microservice.tcrtconsultamediospan.service.ConsultaPanSvc;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("tcrt-consulta-pan/v1/")
public class ApiConsumerController {

    @Autowired
    ConsultaPanSvc consultaPanSvc;


    @PostMapping(value = "clientemedios", consumes = MediaType.APPLICATION_JSON_VALUE)
    @Operation(summary = "Cliente medios envio", description = "Consultar los medios de envio del cliente por el PAN de su tarjeta")
    @ApiResponses(@io.swagger.v3.oas.annotations.responses.ApiResponse(responseCode = "200", content = {
            @Content(schema = @Schema(implementation = ApiResponse.class), mediaType = "application/json")
    }))
    public ResponseEntity<ApiResponse> consultaMediosPorPan(@RequestBody ConsultaIdentificacionRequest request) {
        if (request == null) {
            var response = new ApiResponse(RouteResponse.response(RouteResponse.Status.BAD_REQUEST));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        //Contiene los posibles escenarios de error controlados por un code y message
        ApiResponse response = consultaPanSvc.consultarMediosPan(request);

        return ResponseEntity.ok(response);
    }


    @GetMapping("codigomis/{codigomis}")
    @Operation(summary = "Cliente Identificacion", description = "Consultar la identificacion del cliente")
    @ApiResponses(@io.swagger.v3.oas.annotations.responses.ApiResponse(responseCode = "200", content = {
            @Content(schema = @Schema(implementation = ApiResponse.class), mediaType = "application/json")
    }))
    public ResponseEntity<ApiResponse> consultarIdentificacion(@PathVariable Integer codigomis){
        if (codigomis == null) {
            var response = new ApiResponse(RouteResponse.response(RouteResponse.Status.BAD_REQUEST));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
        ApiResponse response = consultaPanSvc.consultaIdentificacionCodigoMis(codigomis);
        return ResponseEntity.ok(response);
    }
}