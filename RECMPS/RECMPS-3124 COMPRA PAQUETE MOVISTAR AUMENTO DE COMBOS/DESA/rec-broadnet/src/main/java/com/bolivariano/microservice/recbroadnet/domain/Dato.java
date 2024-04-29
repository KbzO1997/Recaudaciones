package com.bolivariano.microservice.recbroadnet.domain;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Dato implements Serializable {

    private static final long serialVersionUID = 1L;
    protected String nombre;
    protected String desccanal;
    protected String deservicio;
    protected String empresa;
    protected String planilla;
    protected String fecha_tope;
    protected String fecha1;
    protected String prodeb;
    protected String ctadeb;
    protected String valor;
    protected String valor2;
    protected String valortope;
    protected String gsm;
    protected String email;
    protected String phone;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDesccanal() {
        return desccanal;
    }

    public void setDesccanal(String desccanal) {
        this.desccanal = desccanal;
    }

    public String getDeservicio() {
        return deservicio;
    }

    public void setDeservicio(String deservicio) {
        this.deservicio = deservicio;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getPlanilla() {
        return planilla;
    }

    public void setPlanilla(String planilla) {
        this.planilla = planilla;
    }

    public String getFecha_tope() {
        return fecha_tope;
    }

    public void setFecha_tope(String fecha_tope) {
        this.fecha_tope = fecha_tope;
    }

    public String getFecha1() {
        return fecha1;
    }

    public void setFecha1(String fecha1) {
        this.fecha1 = fecha1;
    }

    public String getProdeb() {
        return prodeb;
    }

    public void setProdeb(String prodeb) {
        this.prodeb = prodeb;
    }

    public String getCtadeb() {
        return ctadeb;
    }

    public void setCtadeb(String ctadeb) {
        this.ctadeb = ctadeb;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getValor2() {
        return valor2;
    }

    public void setValor2(String valor2) {
        this.valor2 = valor2;
    }

    public String getValortope() {
        return valortope;
    }

    public void setValortope(String valortope) {
        this.valortope = valortope;
    }

    public String getGsm() {
        return gsm;
    }

    public void setGsm(String gsm) {
        this.gsm = gsm;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
