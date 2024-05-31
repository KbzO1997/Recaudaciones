package com.bolivariano.microservice.trcmverifycard.services;

import com.bolivariano.commons.utils.ResponsePayload;
import com.bolivariano.microservice.trcmverifycard.dto.VerificaTarjetaReq;
import org.springframework.stereotype.Service;


@Service
public interface IVerificarTarjetaService {
    public ResponsePayload validarTarjeta(VerificaTarjetaReq pan);
}
