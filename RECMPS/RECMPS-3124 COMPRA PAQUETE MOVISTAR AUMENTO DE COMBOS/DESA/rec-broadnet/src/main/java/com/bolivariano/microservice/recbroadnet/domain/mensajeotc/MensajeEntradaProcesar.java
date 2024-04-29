package com.bolivariano.microservice.recbroadnet.domain.mensajeotc;

import com.bolivariano.microservice.recbroadnet.domain.TipoFlujo;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
@NoArgsConstructor
public class MensajeEntradaProcesar implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    
    private TipoFlujo tipoFlujo;
    private MensajeEntradaEjecutarReverso mensajeEntradaEjecutarReverso;
    private MensajeEntradaEjecutarPago mensajeEntradaEjecutarPago;
    private MensajeEntradaConsultarDeuda mensajeEntradaConsultarDeuda;

}
