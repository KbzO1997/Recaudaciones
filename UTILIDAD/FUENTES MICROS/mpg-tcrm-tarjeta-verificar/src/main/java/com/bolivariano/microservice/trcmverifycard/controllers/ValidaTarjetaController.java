package com.bolivariano.microservice.trcmverifycard.controllers;

import com.bolivariano.commons.utils.ResponsePayload;
import com.bolivariano.microservice.trcmverifycard.dto.VerificaTarjetaReq;
import com.bolivariano.microservice.trcmverifycard.services.VerificarTarjetaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static com.bolivariano.microservice.trcmverifycard.utils.ValidaUtil.validaRequest;

@RestController
@RequestMapping("${microservices.context-name}/${microservices.version}/verificaCard")
@Tag(name = "Verifica Tarjeta", description = "Vefirifica si la tarjeta ingresada es de credito o debito")
public class ValidaTarjetaController {

    private final VerificarTarjetaService verificarTarjetaService;
    @Autowired
    public ValidaTarjetaController(VerificarTarjetaService verificarTarjetaService){
        this.verificarTarjetaService = verificarTarjetaService;
    }

    private static final Logger logger = LoggerFactory.getLogger(ValidaTarjetaController.class);
    @PostMapping()
    @Operation(summary = "Verificar tarjeta", description = "verificar la tarjeta del cliente")
    @ApiResponses(@io.swagger.v3.oas.annotations.responses.ApiResponse(responseCode = "200", content = {
            @Content(schema = @Schema(implementation = VerificaTarjetaReq.class), mediaType = "application/json")
    }))
    public ResponsePayload consultarClientePan(@RequestBody VerificaTarjetaReq request){
        logger.info("Solicitud del servicio: {}", request);
        if(Boolean.TRUE.equals(validaRequest(request))){
            return ResponseEntity.status(400).body(ResponsePayload.error(400,"Datos Incorrecto")).getBody();
        }else if(request.getCardBin().length() < 6){
            return ResponseEntity.status(400).body(ResponsePayload.error(400,"cardBin no cumple longintud mínima")).getBody();
        }
        return verificarTarjetaService.validarTarjeta(request);
    }

}
