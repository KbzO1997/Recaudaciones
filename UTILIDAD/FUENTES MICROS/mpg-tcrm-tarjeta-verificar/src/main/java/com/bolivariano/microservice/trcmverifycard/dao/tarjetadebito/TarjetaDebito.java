package com.bolivariano.microservice.trcmverifycard.dao.tarjetadebito;

import com.bolivariano.commons.annotation.StoreProcedure;
import com.bolivariano.commons.annotation.StoreProcedureParam;
import com.bolivariano.commons.utils.db.AbstractStoreProcedureModel;

import java.sql.Types;

@StoreProcedure(schema = "dbo",catalog = "cob_atm",name="pa_tcd_ctarjeta_deb")
public class TarjetaDebito extends AbstractStoreProcedureModel {
    @StoreProcedureParam(name = "@e_pan",type = Types.VARCHAR)
    private String panDeb;
    @StoreProcedureParam(name = "@e_fechaExpiracion",type = Types.VARCHAR)
    private String fechaExpiracionDeb;
    @StoreProcedureParam(name = "@e_nombre_tarjeta ",type = Types.VARCHAR)
    private String nombreTarjetaDeb;
    @StoreProcedureParam(name = "@s_numero_cuenta",type = Types.INTEGER,isOut = true)
    private Integer numeroCuentaDeb;
    @StoreProcedureParam(name = "@s_codigo_mis",type = Types.INTEGER,isOut = true)
    private Integer codigoMisDeb;
    @StoreProcedureParam(name = "@s_numero_tarjeta",type = Types.INTEGER,isOut = true)
    private Integer numeroTarjetaDeb;
    @StoreProcedureParam(name = "@s_expirado",type = Types.INTEGER,isOut = true)
    private Integer expiradoDeb;
    @StoreProcedureParam(name = "@s_fraude",type = Types.INTEGER,isOut = true)
    private Integer fraudeDeb;
    @StoreProcedureParam(name = "@s_robo",type = Types.INTEGER,isOut = true)
    private Integer roboDeb;
    @StoreProcedureParam(name = "@s_invalido",type = Types.INTEGER,isOut = true)
    private Integer invalidoDeb;

    public String getPanDeb() {
        return panDeb;
    }

    public void setPanDeb(String panDeb) {
        this.panDeb = panDeb;
    }

    public String getFechaExpiracionDeb() {
        return fechaExpiracionDeb;
    }

    public void setFechaExpiracionDeb(String fechaExpiracionDeb) {
        this.fechaExpiracionDeb = fechaExpiracionDeb;
    }

    public String getNombreTarjetaDeb() {
        return nombreTarjetaDeb;
    }

    public void setNombreTarjetaDeb(String nombreTarjetaDeb) {
        this.nombreTarjetaDeb = nombreTarjetaDeb;
    }

    public Integer getNumeroCuentaDeb() {
        return numeroCuentaDeb;
    }

    public void setNumeroCuentaDeb(Integer numeroCuentaDeb) {
        this.numeroCuentaDeb = numeroCuentaDeb;
    }

    public Integer getCodigoMisDeb() {
        return codigoMisDeb;
    }

    public void setCodigoMisDeb(Integer codigoMisDeb) {
        this.codigoMisDeb = codigoMisDeb;
    }

    public Integer getNumeroTarjetaDeb() {
        return numeroTarjetaDeb;
    }

    public void setNumeroTarjetaDeb(Integer numeroTarjetaDeb) {
        this.numeroTarjetaDeb = numeroTarjetaDeb;
    }

    public Integer getExpiradoDeb() {
        return expiradoDeb;
    }

    public void setExpiradoDeb(Integer expiradoDeb) {
        this.expiradoDeb = expiradoDeb;
    }

    public Integer getFraudeDeb() {
        return fraudeDeb;
    }

    public void setFraudeDeb(Integer fraudeDeb) {
        this.fraudeDeb = fraudeDeb;
    }

    public Integer getRoboDeb() {
        return roboDeb;
    }

    public void setRoboDeb(Integer roboDeb) {
        this.roboDeb = roboDeb;
    }

    public Integer getInvalidoDeb() {
        return invalidoDeb;
    }

    public void setInvalidoDeb(Integer invalidoDeb) {
        this.invalidoDeb = invalidoDeb;
    }
}
