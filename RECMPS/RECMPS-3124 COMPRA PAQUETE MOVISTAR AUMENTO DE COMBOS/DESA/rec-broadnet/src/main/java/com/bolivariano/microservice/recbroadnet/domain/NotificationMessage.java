package com.bolivariano.microservice.recbroadnet.domain;

import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeEntradaEjecutarPago;
import com.bolivariano.microservice.recbroadnet.domain.mensajeotc.MensajeSalidaEjecutarPago;

public class NotificationMessage {
    private MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago;
    private MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago;

    public NotificationMessage(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago, MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago) {
        this.mensajeEntradaEjecutarPago = mensajeEntradaEjecutarPago;
        this.mensajeSalidaEjecutarPago = mensajeSalidaEjecutarPago;
    }

    public MensajeEntradaEjecutarPago getMensajeEntradaEjecutarPago() {
        return mensajeEntradaEjecutarPago;
    }

    public void setMensajeEntradaEjecutarPago(MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago) {
        this.mensajeEntradaEjecutarPago = mensajeEntradaEjecutarPago;
    }

    public MensajeSalidaEjecutarPago getMensajeSalidaEjecutarPago() {
        return mensajeSalidaEjecutarPago;
    }

    public void setMensajeSalidaEjecutarPago(MensajeSalidaEjecutarPago mensajeSalidaEjecutarPago) {
        this.mensajeSalidaEjecutarPago = mensajeSalidaEjecutarPago;
    }
}
