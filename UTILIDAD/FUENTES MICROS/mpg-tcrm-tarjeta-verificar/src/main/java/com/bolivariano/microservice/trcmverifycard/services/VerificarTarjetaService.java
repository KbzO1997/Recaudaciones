package com.bolivariano.microservice.trcmverifycard.services;


import com.bolivariano.commons.utils.ResponsePayload;
import com.bolivariano.microservice.trcmverifycard.configuration.ClientRestConfig;
import com.bolivariano.microservice.trcmverifycard.dao.cliente.ClienteDao;
import com.bolivariano.microservice.trcmverifycard.dao.cliente.Cliente;
import com.bolivariano.microservice.trcmverifycard.dao.tarjetacredito.TarjetaCredito;
import com.bolivariano.microservice.trcmverifycard.dao.tarjetacredito.TarjetaCreditoDao;
import com.bolivariano.microservice.trcmverifycard.dao.tarjetadebito.TarjetaDebito;
import com.bolivariano.microservice.trcmverifycard.dao.tarjetadebito.TarjetaDebitoDao;
import com.bolivariano.microservice.trcmverifycard.dao.tipotarjeta.TipoTarjetaDao;
import com.bolivariano.microservice.trcmverifycard.dao.tipotarjeta.TipoTarjeta;
import com.bolivariano.microservice.trcmverifycard.dto.TarjetaVal;
import com.bolivariano.microservice.trcmverifycard.dto.VerificaTarjetaReq;
import com.bolivariano.commons.utils.logs.LogUtils;
import com.bolivariano.microservice.trcmverifycard.dto.VerificaTarjetaRes;
import com.bolivariano.microservice.trcmverifycard.dto.cliente.ClienteRes;
import com.bolivariano.microservice.trcmverifycard.dto.credimatic.CredimaticReq;
import com.bolivariano.microservice.trcmverifycard.dto.credimatic.CredimaticRes;
import com.bolivariano.microservice.trcmverifycard.dto.tarjetacre.TarjetaCreditoRes;
import com.bolivariano.microservice.trcmverifycard.dto.tarjetadeb.TarjetaDebitoRes;
import com.bolivariano.microservice.trcmverifycard.exceptions.CustomException;
import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;

import java.util.Date;

import static com.bolivariano.microservice.trcmverifycard.utils.ValidaUtil.*;

@Service
public class VerificarTarjetaService implements IVerificarTarjetaService{

    private final TipoTarjetaDao tipoTarjetaDao;
    private final TarjetaCreditoDao tarjetaCreditoDao;
    private final TarjetaDebitoDao tarjetaDebitoDao;
    private final ClienteDao clienteDao;

    private final CredimaticService credimaticService;

    @Autowired
    public VerificarTarjetaService(TipoTarjetaDao tipoTarjetaDao, TarjetaCreditoDao tarjetaCreditoDao, TarjetaDebitoDao tarjetaDebitoDao, ClienteDao clienteDao, ClientRestConfig clientRestConfig, CredimaticService credimaticService) {
        this.tipoTarjetaDao = tipoTarjetaDao;
        this.tarjetaCreditoDao = tarjetaCreditoDao;
        this.tarjetaDebitoDao = tarjetaDebitoDao;
        this.clienteDao = clienteDao;
        this.credimaticService = credimaticService;
    }
    private static final LogUtils logger = LogUtils.getLogger(VerificarTarjetaService.class);

    private static final String NO_CLIENT_INFO = "No se encontro informacion del cliente";
    private static final String NO_CLIENT_MIS = "No se encontro el identificador del cliente";

    @Override
    public ResponsePayload validarTarjeta(VerificaTarjetaReq tarjetaReq) {
        logger.info("Inicio de servicio Validar Tarjeta: " + tarjetaReq.getCardId());
        var startTime = new Date();

        try {
            VerificaTarjetaRes res = new VerificaTarjetaRes();

            String tipoTarjeta = determinarTipoTarjeta(tarjetaReq.getCardBin());

            if (tipoTarjeta == null || tipoTarjeta.isBlank()) {
                return ResponsePayload.error(400, "No existe BIN");
            }

            res.setTipoTarjeta(tipoTarjeta);


            if ("TC".equals(tipoTarjeta)) {
                return procesarTarjetaCredito(tarjetaReq, tipoTarjeta);
            } else if ("TD".equals(tipoTarjeta)) {
                return procesarTarjetaDebito(tarjetaReq, tipoTarjeta);
            } else {
                return ResponsePayload.error(400, "Tipo de tarjeta no compatible");
            }
        } catch (Exception ex) {
            logger.error("Error al ejecutar el servicio: "+ ex);
            return ResponsePayload.error(500, "Error interno");
        } finally {
            logger.tiempo("Servicio Validar Tarjeta", "ResponseEntity", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), null, 5000 - 1000 );
            logger.info("Fin de servicio Validar Tarjeta: " + tarjetaReq.getCardId());
        }
    }

    private String determinarTipoTarjeta(String cardBin) {
        var sp = new TipoTarjeta();
        sp.setPan(cardBin);
        return tipoTarjetaDao.consultarTipoTarjeta(sp);
    }

    private ResponsePayload procesarTarjetaDebito(VerificaTarjetaReq tarjetaReq, String tipoTarjeta) {
        try {
            VerificaTarjetaRes res = new VerificaTarjetaRes();

            var spTD = new TarjetaDebito();
            spTD.setPanDeb(tarjetaReq.getPan());
            spTD.setFechaExpiracionDeb(tarjetaReq.getExp());
            spTD.setNombreTarjetaDeb(tarjetaReq.getName());

            TarjetaDebitoRes debitoRes = tarjetaDebitoDao.consultarTarjetaDebito(spTD);

            if (Boolean.FALSE.equals(debitoRes.getExpirado()) && Boolean.FALSE.equals(debitoRes.getFraude())
                    && Boolean.FALSE.equals(debitoRes.getRobo()) && Boolean.FALSE.equals(debitoRes.getInvalido())
            ) {
                if(debitoRes.getCodigoMis() == null) {
                    return ResponsePayload.error(400, NO_CLIENT_MIS);
                }

                ClienteRes client = consultarDatosCliente(debitoRes.getCodigoMis());
                ResponsePayload validacionCliente = validarDatosCliente(client);
                if (validacionCliente != null) {
                    return validacionCliente;
                }

                res.setDatosCliente(client);
            }

            res.setClaveUnica(debitoRes.getNumeroTarjeta());
            res.setConsumerId(debitoRes.getCodigoMis());
            res.setAccountId(debitoRes.getNumeroCuenta());
            res.setTipoTarjeta(tipoTarjeta);

            TarjetaVal tarjetaVal = new TarjetaVal();
            tarjetaVal.setExpired(debitoRes.getExpirado());
            tarjetaVal.setInvalid(debitoRes.getInvalido());
            tarjetaVal.setFraudSuspect(debitoRes.getFraude());
            tarjetaVal.setLostOrStolen(debitoRes.getRobo());

            res.setCard(tarjetaVal);

            return ResponsePayload.ok(res);
        } catch (Exception ex) {
            logger.error("Error al procesar la tarjeta de débito " + ex);
            return null;
        }
    }

    private ClienteRes consultarDatosCliente(Integer codigoMis) {
        try {
            var spCliente = new Cliente();
            spCliente.setCodigoMis(codigoMis);

            ClienteRes clienteRes = clienteDao.consultarCliente(spCliente);

            if (clienteRes != null && clienteRes.getNombreCliente() != null) {
                return clienteRes;
            } else {
                logger.warn("Cliente no encontrado para el código MIS: {}", codigoMis);
                return null;
            }
        } catch (Exception ex) {
            logger.error("Error al consultar datos del cliente", ex);
            return null;
        }
    }

    private ResponsePayload procesarTarjetaCredito(VerificaTarjetaReq req, String tipoTarjeta) {
        try {
            VerificaTarjetaRes res = new VerificaTarjetaRes();
            TarjetaVal tarjetaVal = new TarjetaVal();
            int cvv = (req.getCvv() == null || req.getCvv().isEmpty()) ? 0 : 1;

            var spTC = new TarjetaCredito();
            spTC.setPanCre(req.getPan());
            spTC.setFechaExpiracionCre(req.getExp());
            spTC.setCvvCre(cvv);
            spTC.setNombreTarjetaCre(req.getName());

            TarjetaCreditoRes creditoRes = tarjetaCreditoDao.consultarTarjetaCredito(spTC);

            if(creditoRes == null) {
                return  ResponsePayload.error(400, "Tarjeta no encontrada");
            }

            if (cvv == 1) {
                return this.validaCredimatic(creditoRes,req);
            } else {
                if(creditoRes.getCodigoMis() == null) {
                    return ResponsePayload.error(400, NO_CLIENT_MIS);
                }

                res.setClaveUnica(creditoRes.getNumeroTarjeta());
                res.setConsumerId(creditoRes.getCodigoMis());
                res.setAccountId(creditoRes.getNumeroCuenta());
                res.setTipoTarjeta(tipoTarjeta);

                tarjetaVal.setLostOrStolen(creditoRes.getRobo());
                tarjetaVal.setFraudSuspect(creditoRes.getFraude());
                tarjetaVal.setInvalid(creditoRes.getInvalido());
                tarjetaVal.setExpired(creditoRes.getExpirado());
                res.setCard(tarjetaVal);

                if (Boolean.FALSE.equals(tarjetaVal.getLostOrStolen()) && Boolean.FALSE.equals(tarjetaVal.getFraudSuspect())
                        && Boolean.FALSE.equals(tarjetaVal.getExpired()) && Boolean.FALSE.equals(tarjetaVal.getInvalid())
                ) {
                    ClienteRes client = consultarDatosCliente(creditoRes.getCodigoMis());
                    ResponsePayload validacionCliente = validarDatosCliente(client);
                    if (validacionCliente != null) {
                        return validacionCliente;
                    }

                    res.setDatosCliente(client);
                }

                return ResponsePayload.ok(res);
            }

        } catch (Exception ex) {
            logger.error("Error al procesar la tarjeta de crédito " + ex);
            return null;
        }
    }

    private ResponsePayload validaCredimatic(TarjetaCreditoRes tc, VerificaTarjetaReq req){
        try{
            logger.info("Inicio de validacion por Credimatic");
            TarjetaVal tarjetaVal = new TarjetaVal();
            VerificaTarjetaRes res = new VerificaTarjetaRes();

            res.setClaveUnica(tc.getNumeroTarjeta());
            res.setConsumerId(tc.getCodigoMis());
            res.setAccountId(tc.getNumeroCuenta());
            res.setTipoTarjeta("TC");

            CredimaticReq credimaticReq = new CredimaticReq();
            credimaticReq.setNumeroCuenta(tc.getNumeroCuenta());
            credimaticReq.setNumeroTarjeta(ocultarCaracteres(req.getPan()));
            credimaticReq.setIdentificacion(tc.getIdentificacion());
            credimaticReq.setTipoIdentificacion(tc.getTipoIdentificacion());

            credimaticReq.setCvv2(req.getCvv());
            credimaticReq.setFechaExpira(req.getExp());
            credimaticReq.setTerminal(obtenerIp());
            credimaticReq.setFechaHoraTransaccion(obtenerFecha());
            credimaticReq.setSecuencialOrigen(generarSecuencial());

            CredimaticRes respCredimatic = this.credimaticService.validaCvv(credimaticReq);

            if(respCredimatic.getCodigo().equals("000")){
                res.setCvvStatus(true);
                tarjetaVal.setExpired(false);
                tarjetaVal.setInvalid(false);
                tarjetaVal.setFraudSuspect(false);
                tarjetaVal.setLostOrStolen(false);
            }

            if(respCredimatic.getCodigo().equals("901")) {
                res.setCvvStatus(true);
                tarjetaVal.setExpired(true);
                tarjetaVal.setInvalid(false);
                tarjetaVal.setFraudSuspect(false);
                tarjetaVal.setLostOrStolen(false);
            }

            if(respCredimatic.getCodigo().equals("905")) {
                res.setCvvStatus(false);
                tarjetaVal.setExpired(false);
                tarjetaVal.setInvalid(true);
                tarjetaVal.setFraudSuspect(false);
                tarjetaVal.setLostOrStolen(false);
            }

            if(respCredimatic.getCodigo().equals("903")) {
                res.setCvvStatus(true);
                tarjetaVal.setExpired(false);
                tarjetaVal.setInvalid(true);
                tarjetaVal.setFraudSuspect(false);
                tarjetaVal.setLostOrStolen(false);
            }

            if(respCredimatic.getCodigo().equals("999")) {
                logger.info("Falló el llamado a credimatic");
                return ResponsePayload.error(500, "Servicio de Credimatic no disponible");
            }

            logger.info("Codigo Respuesta Credimatic: " + respCredimatic.getCodigo());

            res.setCard(tarjetaVal);

            if (Boolean.FALSE.equals(tarjetaVal.getLostOrStolen()) && Boolean.FALSE.equals(tarjetaVal.getFraudSuspect())
                    && Boolean.FALSE.equals(tarjetaVal.getExpired()) && Boolean.FALSE.equals(tarjetaVal.getInvalid())
            ) {
                if(tc.getCodigoMis() == null) {
                    return ResponsePayload.error(400, NO_CLIENT_MIS);
                }

                ClienteRes client = consultarDatosCliente(tc.getCodigoMis());
                ResponsePayload validacionCliente = validarDatosCliente(client);
                if (validacionCliente != null) {
                    return validacionCliente;
                }

                res.setDatosCliente(client);
            }

            return ResponsePayload.ok(res);

        } catch (CustomException ce) {
            logger.error("Error en llamado a Credimatic: {}", ce.getMessage());

            return ResponsePayload.error(ce.getCodigoError(), ce.getMessage());

        } catch (Exception ex) {
            logger.error("Error en llamado a Credimatic: {}", ex.getMessage());

            return ResponsePayload.error(500, "Error Interno");

        } finally {
            logger.info("Fin de validacion por Credimatic");
        }
    }

    private ResponsePayload validarDatosCliente(ClienteRes cliente) {
        if (cliente == null) {
            return ResponsePayload.error(400, NO_CLIENT_INFO);
        }

        if (cliente.getCelular() == null || cliente.getCelular().isBlank()) {
            logger.info("El cliente no tiene celular registrado");
        }

        if (cliente.getEmail() == null || cliente.getEmail().isBlank()) {
            logger.info("El cliente no tiene email registrado");
        }

        if (cliente.getDireccion() == null || cliente.getDireccion().isBlank()) {
            logger.info("El cliente no tiene direccion registrada");
        }

        return null;
    }

}