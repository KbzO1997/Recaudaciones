package com.bolivariano.microservice.recbroadnet.domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RechargeAuxiliar {

    private String celular;
    private int operadora; 
    private int secuencial; 
    private Double efectivo;
    private Double debito;
    private String fecha;
    private String canal;
    private String user;
    private int oficina;
    private int ubicacion;
    private String nombre;
    private String tipoCuenta;
    private String cuenta;
    
}
