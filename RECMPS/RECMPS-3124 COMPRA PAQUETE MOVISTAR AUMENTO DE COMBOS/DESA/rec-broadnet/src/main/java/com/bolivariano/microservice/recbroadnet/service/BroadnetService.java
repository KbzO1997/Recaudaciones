package com.bolivariano.microservice.recbroadnet.service;

import com.bolivariano.microservice.recbroadnet.configuration.ApplicationProperties;
import com.bolivariano.microservice.recbroadnet.dao.CatalogosDao;
import com.bolivariano.microservice.recbroadnet.dao.RechargeAuxiliarDao;
import com.bolivariano.microservice.recbroadnet.domain.Catalogo;
import com.bolivariano.microservice.recbroadnet.domain.RechargeAuxiliar;
import com.bolivariano.microservice.recbroadnet.domain.SalidaSpCatalogo;
import com.bolivariano.microservice.recbroadnet.domain.datoadicional.DatoAdicional;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.*;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeSalidaConsultarDeuda.Recibos;
import com.bolivariano.microservice.recbroadnet.domain.recibo.Recibo;
import com.bolivariano.microservice.recbroadnet.domain.recibo.Recibo.DatosAdicionales;
import com.bolivariano.microservice.recbroadnet.utils.GeneralUtils;
import io.netty.channel.ConnectTimeoutException;
import io.netty.handler.timeout.ReadTimeoutException;
import org.jboss.logging.Logger;
import org.jpos.iso.ISOException;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.net.ConnectException;
import java.net.SocketTimeoutException;
import java.util.*;

@ApplicationScoped
public class BroadnetService {

    @Inject
    ApplicationProperties applicationProperties;

    
    @Inject
    RechargeAuxiliarDao rechargeCoreService;

    @Inject
    CatalogosDao catalogosDao;

    @Inject
    BroadnetJPOS broadnetJPOS;

    @Inject
    Logger log;

    public MensajeSalidaEjecutarPago ejecutarPago(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago) {
        MensajeSalidaEjecutarPago msep = new MensajeSalidaEjecutarPago();
        msep.setCodigoError("0");
        msep.setMensajeUsuario("PAGO EXITOSO");
        String codigoProceso;
        String fechaContable = "";
        ApplicationProperties.ParametrosEmpresa parametrosEmpresa = null;

        try {
            log.info("INICIA Ejecutar Pago");
            parametrosEmpresa = applicationProperties.parametrosEmpresa()
                    .parallelStream().filter(x -> x.empresa().equals(mensajeEntradaEjecutarPago.getServicio().getCodigoEmpresa()))
                    .findFirst().orElse(null);

            if (parametrosEmpresa == null) {
                return this.buildErrorMessage("EMPRESA NO PARAMETRIZADA PARA CONSUMIR PROVEEDOR", null, "BROD_001");
            }

            fechaContable = GeneralUtils.obtenerValorDatoAdicional(
                    applicationProperties.banco().codigoDatoAdicionalFechaContable(),
                    mensajeEntradaEjecutarPago.getServicio().getDatosAdicionales().getDatoAdicional());

            if (mensajeEntradaEjecutarPago.getCuenta() == null || mensajeEntradaEjecutarPago.getCuenta().isBlank())
                codigoProceso = applicationProperties.provider().processingCodeDef();
            else {
                if (applicationProperties.banco().codigoTipoCuentaAho().equals(mensajeEntradaEjecutarPago.getTipoCuenta())) {
                    codigoProceso = applicationProperties.provider().processingCodeAhorro();
                } else {
                    codigoProceso = applicationProperties.provider().processingCodeCte();
                }
            }
            //EJECUTA PAGO
            broadnetJPOS.recharge(mensajeEntradaEjecutarPago,parametrosEmpresa, codigoProceso, fechaContable);
            log.info("FINALIZA EJECUTAR PAGO");

        } catch (Exception e) {
            log.error("ERROR RECHARGE: " + e.getMessage(), e);
            return procesaMensajeSalidaPagoPorExcepcion(e);
        }

        return msep;
    }

    /**
     * Metodo con logica extraida oara reducior "cognitive complexity"
     * @param e
     * @return
     */
    private MensajeSalidaEjecutarPago procesaMensajeSalidaPagoPorExcepcion(Exception e){
        if (e instanceof SocketTimeoutException || e instanceof ReadTimeoutException || e instanceof ConnectTimeoutException) {
            return this.buildErrorMessage("EJECUTAR REVERSO CON CONFIRMACION", e.getMessage(), "BROD_CONF");
        } else if (e instanceof ConnectException) {
            return this.buildErrorMessage("ERROR DE CONEXION", e.getMessage(), "BROD_002");
        } else if (e instanceof ISOException) {
            String codigoError = e.getMessage().trim();
            log.info("CODIGO ERROR ISO VAL: " + codigoError);
            List<String> checkError = new ArrayList<>();
            checkError.add("09");
            checkError.add("27");
            checkError.add("01");
            checkError.add("17");
            checkError.add("18");
            checkError.add("21");
            checkError.add("70");
            checkError.add("71");
            checkError.add("72");
            checkError.add("73");
            checkError.add("74");
            checkError.add("80");
            checkError.add("81");
            if (checkError.contains(codigoError)) {
                return this.buildErrorMessage("EJECUTAR REVERSO CON CONFIRMACION", e.getMessage(), "BROD_CONF");
            } else {
                return this.buildErrorMessage("ERROR DE RESPUESTA ISO", "ERROR DE RESPUESTA ISO", e.getMessage());
            }
        } else {
            return this.buildErrorMessage("ERROR AL CONSUMIR PROVEEDOR", e.getMessage(), "BROD_003");
        }
    }

    public MensajeSalidaConsultarDeuda consultarDeuda(MensajeEntradaConsultarDeuda mensajeEntradaConsultarDeuda) {
        MensajeSalidaConsultarDeuda mscd = new MensajeSalidaConsultarDeuda();
        SalidaSpCatalogo responseSP = new SalidaSpCatalogo();
        int cantRegistroCatalogo = 0;

        try {
            log.info("Obtención de valores adicionales.");
            ApplicationProperties.ParametrosEmpresa parametrosEmpresa = applicationProperties.parametrosEmpresa()
                    .parallelStream()
                    .filter(x -> x.empresa().equals(mensajeEntradaConsultarDeuda.getServicio().getCodigoEmpresa()))
                    .findFirst().orElse(null);

            if (parametrosEmpresa == null) {
                throw new IllegalArgumentException("Empresa no parametrizada para consumir Broadnet Combos");
            }

            log.info("Consumo SP proceso catalogos.");
            if (applicationProperties.parametrosEmpresa().get(0).empresa().equals(parametrosEmpresa.empresa())) {
                responseSP = catalogosDao.catalogos(applicationProperties.parametrosEmpresa().get(0).tabla(),
                        mensajeEntradaConsultarDeuda.getCanal());
            } else if (applicationProperties.parametrosEmpresa().get(1).empresa().equals(parametrosEmpresa.empresa())) {
                responseSP = catalogosDao.catalogos(applicationProperties.parametrosEmpresa().get(1).tabla(),
                        mensajeEntradaConsultarDeuda.getCanal());
            }
            
            log.info("CODIGO RESPUESTA: " + responseSP.getCodigo());
            if (responseSP.getCodigo() == 0) {
                mscd.setMensajeUsuario(responseSP.getMensajeSalida());
                mscd.setCodigoError(String.valueOf(responseSP.getCodigo()));

                Recibos recibos = new Recibos();
                Recibo recibo;
                DatoAdicional datoAdicional;
                DatosAdicionales adicionales;

                for (Catalogo catalogo : responseSP.getLstCatalogo()) {
                    log.info("CATALOGOS RESPUESTA: " + catalogo.getParametro());
                    log.info("CATALOGOS RESPUESTA VALOR: " + catalogo.getParametro());

                    recibo = new Recibo();
                    adicionales = new DatosAdicionales();
                    datoAdicional = new DatoAdicional();

                    datoAdicional.setCodigo(String.valueOf(catalogo.getParametro()));
                    datoAdicional.setValor(catalogo.getValor());

                    adicionales.getDatoAdicional().add(datoAdicional);

                    recibo.setConcepto(String.valueOf(catalogo.getIdTabla()));
                    recibo.setDatosAdicionales(adicionales);
                    recibos.getRecibo().add(recibo);

                    cantRegistroCatalogo++;
                }

                log.info("Registros por catalogo:" + cantRegistroCatalogo);
                mscd.setRecibos(recibos);

            } else {
                throw new IllegalArgumentException(responseSP.getMensajeSalida());
            }

        } catch (Exception e) {
            log.error("ERROR EN CONSULTA" + e.getMessage(), e);
            mscd.setMensajeUsuario("ERROR AL EJECUTAR CONSULTA: " + e.getMessage());
            mscd.setCodigoError("300");
        }
        return mscd;
    }

    public MensajeSalidaEjecutarPago ejecutarReverso(MensajeEntradaEjecutarReverso mensajeEntradaEjecutarReverso) {
        MensajeSalidaEjecutarPago msep = new MensajeSalidaEjecutarPago();
        msep.setCodigoError("0");
        msep.setMensajeUsuario("REVERSO EXITOSO");
        ApplicationProperties.ParametrosEmpresa parametrosEmpresa = null;
        
        try {
            log.info("INICIA Ejecutar REVERSO");
            parametrosEmpresa = applicationProperties.parametrosEmpresa()
                    .parallelStream().filter(x -> x.empresa().equals(mensajeEntradaEjecutarReverso.getServicio().getCodigoEmpresa()))
                    .findFirst().orElse(null);

            if (parametrosEmpresa == null) {
                return this.buildErrorMessage("EMPRESA NO PARAMETRIZADA PARA CONSUMIR PROVEEDOR", null, "BROD_001");
            }
            
            String secuencial = GeneralUtils.obtenerValorDatoAdicional("e_ssn_corr", mensajeEntradaEjecutarReverso.getServicio().getDatosAdicionales().getDatoAdicional());

            log.info("SECUENCIAL PARA REVERSO --> " + secuencial);
            String fechaContable = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalFechaContable(), mensajeEntradaEjecutarReverso.getServicio().getDatosAdicionales().getDatoAdicional());
            
            //EJECUTA CONFIRMACION
            String responseCode = broadnetJPOS.reverse(mensajeEntradaEjecutarReverso, parametrosEmpresa, secuencial, fechaContable);

            log.info("FINALIZA EJECUTAR REVERSO");
            if ("00".equals(responseCode)) {
                return this.buildErrorMessage("CONFIRMA PAGO, NO REVERSAR CORE", "CONFIRMA PAGO, NO REVERSAR CORE", "CONF_PAGO");
            }
            log.info("RESPUESTA PROVEEDOR (ERROR CONTROLADO): " + homologate(responseCode));
            log.info("REVERSA PROVEEDOR");
            msep.setMensajeSistema(homologate(responseCode));
        } catch (Exception e) {
            log.error("ERROR REVERSO: " + e.getMessage(), e);

        }
        return msep;
    }

    public RechargeAuxiliar inicializarValoresRecAuxiliar(MensajeEntradaConsultarDeuda mensajeEntradaConsultarDeuda) {
        RechargeAuxiliar rechargeAuxiliar = new RechargeAuxiliar();
        try {
            log.info("Obtener valores adicionales.");
            String fechaFormataeada = GeneralUtils.formatTimeStampRe(Calendar.getInstance().getTime());

            if (mensajeEntradaConsultarDeuda.getFecha() != null) {
                fechaFormataeada = GeneralUtils.formatTimeStampRe(mensajeEntradaConsultarDeuda.getFecha().toGregorianCalendar().getTime());
            }

            String efectivo = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalEfectivo(), mensajeEntradaConsultarDeuda.getServicio().getDatosAdicionales().getDatoAdicional());
            String debito = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalDebito(), mensajeEntradaConsultarDeuda.getServicio().getDatosAdicionales().getDatoAdicional());
            String ubicacion = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalUbicacion(), mensajeEntradaConsultarDeuda.getServicio().getDatosAdicionales().getDatoAdicional());

            log.info("Reseteo de valores para entidad RechargeAuxiliar.");
            rechargeAuxiliar.setCelular(mensajeEntradaConsultarDeuda.getServicio().getIdentificador());
            rechargeAuxiliar
                    .setOperadora(Integer.parseInt(mensajeEntradaConsultarDeuda.getServicio().getCodigoEmpresa()));
            rechargeAuxiliar.setSecuencial(Integer.parseInt(mensajeEntradaConsultarDeuda.getSecuencial()));
            rechargeAuxiliar.setEfectivo(Double.parseDouble(efectivo.equalsIgnoreCase("") ? "0" : efectivo));
            rechargeAuxiliar.setDebito(Double.parseDouble(debito.equalsIgnoreCase("") ? "0" : debito));
            rechargeAuxiliar.setFecha(fechaFormataeada);
            rechargeAuxiliar.setCanal(mensajeEntradaConsultarDeuda.getCanal());
            rechargeAuxiliar.setUser(mensajeEntradaConsultarDeuda.getUsuario());
            rechargeAuxiliar.setOficina(Integer.parseInt(mensajeEntradaConsultarDeuda.getOficina()));
            rechargeAuxiliar.setUbicacion(Integer.parseInt(ubicacion.equalsIgnoreCase("") ? "0" : ubicacion));

            rechargeAuxiliar.setNombre("");
            rechargeAuxiliar.setTipoCuenta("");
            rechargeAuxiliar.setCuenta("");

        } catch (Exception e) {
            log.error("ERROR AL OBTENER CAMPOS: " + e.getMessage(), e);
        }
        return rechargeAuxiliar;
    }

    public RechargeAuxiliar inicializarValoresRecAuxiliar(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago) {
        RechargeAuxiliar rechargeAuxiliar = new RechargeAuxiliar();
        try {
            log.info("Obtener valores adicionales.");
            String fechaFormataeada = GeneralUtils.formatTimeStampRe(Calendar.getInstance().getTime());
            if (mensajeEntradaEjecutarPago.getFecha() != null) {
                fechaFormataeada = GeneralUtils.formatTimeStampRe(mensajeEntradaEjecutarPago.getFecha().toGregorianCalendar().getTime());
            }

            String efectivo = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalEfectivo(), mensajeEntradaEjecutarPago.getServicio().getDatosAdicionales().getDatoAdicional());
            String debito = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalDebito(), mensajeEntradaEjecutarPago.getServicio().getDatosAdicionales().getDatoAdicional());
            String ubicacion = GeneralUtils.obtenerValorDatoAdicional(applicationProperties.banco().codigoDatoAdicionalUbicacion(), mensajeEntradaEjecutarPago.getServicio().getDatosAdicionales().getDatoAdicional());

            log.info("Reseteo de valores para entidad RechargeAuxiliar.");
            rechargeAuxiliar.setCelular(mensajeEntradaEjecutarPago.getServicio().getIdentificador());
            rechargeAuxiliar
                    .setOperadora(Integer.parseInt(mensajeEntradaEjecutarPago.getServicio().getCodigoEmpresa()));
            rechargeAuxiliar.setSecuencial(Integer.parseInt(mensajeEntradaEjecutarPago.getSecuencial()));
            rechargeAuxiliar.setEfectivo(Double.parseDouble(efectivo.equalsIgnoreCase("") ? "0" : efectivo));
            rechargeAuxiliar.setDebito(Double.parseDouble(debito.equalsIgnoreCase("") ? "0" : debito));
            rechargeAuxiliar.setFecha(fechaFormataeada);
            rechargeAuxiliar.setCanal(mensajeEntradaEjecutarPago.getCanal());
            rechargeAuxiliar.setUser(mensajeEntradaEjecutarPago.getUsuario());
            rechargeAuxiliar.setOficina(Integer.parseInt(mensajeEntradaEjecutarPago.getOficina()));
            rechargeAuxiliar.setUbicacion(Integer.parseInt(ubicacion.equalsIgnoreCase("") ? "0" : ubicacion));

            rechargeAuxiliar.setNombre(mensajeEntradaEjecutarPago.getNombreCliente());
            rechargeAuxiliar.setTipoCuenta(mensajeEntradaEjecutarPago.getTipoCuenta());
            rechargeAuxiliar.setCuenta(mensajeEntradaEjecutarPago.getCuenta());

        } catch (Exception e) {
            log.error("ERROR AL OBTENER CAMPOS: " + e.getMessage(), e);
        }
        return rechargeAuxiliar;
    }

    public MensajeSalidaEjecutarPago buildErrorMessage(String message, String techMessage, String code) {
        log.info("CODIGO ERROR ISO PARA HOMOLOGAR " + code);
        MensajeSalidaEjecutarPago msep = new MensajeSalidaEjecutarPago();
        msep.setCodigoError(code);

        String messageResponse = homologate(code);

        log.info("MENSAJE ERROR ISO HOMOLOGADO " + messageResponse);
        msep.setMensajeUsuario(messageResponse != null ? messageResponse : message);
        msep.setMensajeSistema(messageResponse != null ? messageResponse : techMessage);
        return msep;
    }

    private String homologate(String code) {
        final String ERROR_EN_SISTEMA = "ERROR EN SISTEMA";
        Map<String, String> homologaMsg = new HashMap<>();
        homologaMsg.put("01", "NUMERO INVALIDO DE MENSAJE.");
        homologaMsg.put("02", "NUMERO INVALIDO DE SUSCRIPTOR");
        homologaMsg.put("03", "ESTABLECIMIENTO NO AFILIADO");
        homologaMsg.put("04", "IDENTIFICACION INVALIDO DE BANCO");
        homologaMsg.put("05", "IMPORTE INVALIDO");
        homologaMsg.put("06", "TIPO INVALIDO DE TARJETA");
        homologaMsg.put("07", "FECHA INVALIDA DE CADUCIDAD");
        homologaMsg.put("08", "MENSAJE INCORRECTO");
        homologaMsg.put("09", "NUMERO INVALIDO DE TRANSACCION BANCARIA");
        homologaMsg.put("10", "NUMERO INVALIDO DE TRANSACCION DE AIRERS");
        homologaMsg.put("11", "VALOR INCORRECTO");
        homologaMsg.put("12", "LA TRANSACCION NO EXISTE PARA REVOCAR");
        homologaMsg.put("13", "MONTO INVALIDO");
        homologaMsg.put("14", "NUMERO INVALIDO DE TARJETA");
        homologaMsg.put("15", "CODIGO INVALIDO DE SEGURIDAD");
        homologaMsg.put("16", "TIPO INVALIDO DE CUENTA");
        homologaMsg.put("17", "FECHA INVALIDA DE CADUCIDAD");
        homologaMsg.put("18", "EMISOR INVALIDO");
        homologaMsg.put("19", "SE HA EXCEDIDO EL LIMITE DE GASTAR");
        homologaMsg.put("20", "NO HAY FONDOS DISPONIBLES");
        homologaMsg.put("21", "RECHAZADO");
        homologaMsg.put("22", "NUMERO INVALIDO DE RECORRIDO");
        homologaMsg.put("24", "SUSCRIPTOR ROMPIO REGLA DE FRAUDE");
        homologaMsg.put("25", "SUSCRIPTOR ROMPIO REGLA DE FRAUDE");
		homologaMsg.put("76", "ERROR DE ACTIVACION DE PAQUETES");
        homologaMsg.put("82", "VALOR PIN NO ESTA DENTRO DEL PREDETERMIN");
        homologaMsg.put("89", "TERMINAL INVALIDO");
        homologaMsg.put("91", "AUTORIZADOR FUERA DE LINEA");
        homologaMsg.put("92", ERROR_EN_SISTEMA);
        homologaMsg.put("94", "LOTE DUPLICADO");
        homologaMsg.put("95", "DESCUADRE");
        homologaMsg.put("96", ERROR_EN_SISTEMA);
        homologaMsg.put("97", ERROR_EN_SISTEMA);
        homologaMsg.put("98", ERROR_EN_SISTEMA);
        homologaMsg.put("A0", "APROBADO");
        homologaMsg.put("A1", "TRANSACCION NO SOPORTADA");
        homologaMsg.put("A2", "CAJERO NO REGISTRADO");
        homologaMsg.put("A3", "CAJERO NO ACTIVO");
        homologaMsg.put("A4", "CAJERO SIN PERMISOS");
        homologaMsg.put("A5", "TRANSACCION NO AUTORIZADA");
        homologaMsg.put("A6", "COMERCIO NO REGISTRADO");
        homologaMsg.put("A7", "COMERCIO NO ACTIVO");
        homologaMsg.put("A8", "TERMINAL NO REGISTRADO");
        homologaMsg.put("A9", "TERMINAL NO ACTIVO");
        homologaMsg.put("B1", "PRODUCTO NO ACTIVO");
        homologaMsg.put("B2", "PROVEEDOR NO REGISTRADO");
        homologaMsg.put("B3", "PROVEEDOR NO ACTIVO");
        homologaMsg.put("B4", "PP NO REGISTRADO");
        homologaMsg.put("B5", "PP NO ACTIVO");
        homologaMsg.put("B6", "PPC NO ACTIVO");
        homologaMsg.put("B7", "CUPO INSUFICIENTE");
        homologaMsg.put("B8", "CUPO X GRUPO NO DISPONIBLE");
        homologaMsg.put("B9", "CUPO X CADENA NO DISPONIBLE");
        homologaMsg.put("C0", "CUPO X COMERCIO NO DISPONIBLE");
        homologaMsg.put("C1", "ERROR EN ACTUALIZACION");
        homologaMsg.put("C2", "UBICACION NO DISPONIBLE");
        homologaMsg.put("C3", "UBICACION NO ACTIVA");
        homologaMsg.put("C4", "PIN NO ACTIVO");
        homologaMsg.put("C5", "TARJETA INVALIDA");
        homologaMsg.put("C6", "TARJETA INACTIVA");
        homologaMsg.put("C7", "TARJETA EXPIRADA");
        homologaMsg.put("C8", "CUENTA INVALIDA");
        homologaMsg.put("C9", "CUENTA INACTIVA");
        homologaMsg.put("D0", "USUARIO NO AUTORIZADO");
        homologaMsg.put("D1", "COMERCIO/CUENTA BLOQUEADA");
        homologaMsg.put("D2", "NUMERO DE CUENTA INVALIDO");
        homologaMsg.put("D3", "SALDO CON CUENTA CERO");
        homologaMsg.put("D4", "MONTO PERIODO EXCEDIDO");
        homologaMsg.put("D5", "SUBPRODUCTO NO EXISTE");
        homologaMsg.put("D6", "SUBPRODUCTO NO PERMITIDO");
        homologaMsg.put("D7", "ALERTA SEGURIDAD");
        homologaMsg.put("D8", "DECLINACION REVERSA");
        homologaMsg.put("ZZ", "REINTENTE TRANSACCION");

        return homologaMsg.get(code);
    }

}
