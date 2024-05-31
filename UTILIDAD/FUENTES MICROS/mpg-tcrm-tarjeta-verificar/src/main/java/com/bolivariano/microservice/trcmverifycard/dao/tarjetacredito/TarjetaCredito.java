package com.bolivariano.microservice.trcmverifycard.dao.tarjetacredito;

import com.bolivariano.commons.annotation.StoreProcedure;
import com.bolivariano.commons.annotation.StoreProcedureParam;
import com.bolivariano.commons.utils.db.AbstractStoreProcedureModel;

import java.sql.Types;

@StoreProcedure(schema = "dbo",catalog = "db_tarjeta_bb",name="pa_tcd_ctarjeta_cre")
public class TarjetaCredito extends AbstractStoreProcedureModel {
    @StoreProcedureParam(name = "@e_pan",type = Types.CHAR)
    private String panCre;
    @StoreProcedureParam(name = "@e_fechaExpiracion",type = Types.CHAR)
    private String fechaExpiracionCre;
    @StoreProcedureParam(name = "@e_nombre_tarjeta",type = Types.CHAR)
    private String nombreTarjetaCre;
    @StoreProcedureParam(name = "@e_cvv",type = Types.INTEGER)
    private Integer cvvCre;
    @StoreProcedureParam(name = "@s_numero_cuenta",type = Types.CHAR,isOut = true)
    private String numeroCuentaCre;
    @StoreProcedureParam(name = "@s_codigo_mis",type = Types.INTEGER,isOut = true)
    private Integer codigoMisCre;
    @StoreProcedureParam(name = "@s_numero_tarjeta",type = Types.CHAR,isOut = true)
    private String numeroTarjetaCre;
    @StoreProcedureParam(name = "@s_identificacion",type = Types.CHAR,isOut = true)
    private String identificacionCre;
    @StoreProcedureParam(name = "@s_tipo_identificacion",type = Types.CHAR,isOut = true)
    private String tipoIdentificacionCre;
    @StoreProcedureParam(name = "@s_expirado",type = Types.INTEGER,isOut = true)
    private Integer expiradoCre;
    @StoreProcedureParam(name = "@s_fraude",type = Types.INTEGER,isOut = true)
    private Integer fraudeCre;
    @StoreProcedureParam(name = "@s_robo",type = Types.INTEGER,isOut = true)
    private Integer roboCre;
    @StoreProcedureParam(name = "@s_invalido",type = Types.INTEGER,isOut = true)
    private Integer invalidoCre;

    public String getNombreTarjetaCre() {
        return nombreTarjetaCre;
    }

    public void setNombreTarjetaCre(String nombreTarjetaCre) {
        this.nombreTarjetaCre = nombreTarjetaCre;
    }

    public Integer getCvvCre() {
        return cvvCre;
    }

    public void setCvvCre(Integer cvvCre) {
        this.cvvCre = cvvCre;
    }

    public void setExpiradoCre(Integer expiradoCre) {
        this.expiradoCre = expiradoCre;
    }
    public Integer getExpiradoCre() {
        return expiradoCre;
    }

    public Integer getFraudeCre() {
        return fraudeCre;
    }

    public void setFraudeCre(Integer fraudeCre) {
        this.fraudeCre = fraudeCre;
    }

    public Integer getRoboCre() {
        return roboCre;
    }

    public void setRoboCre(Integer roboCre) {
        this.roboCre = roboCre;
    }

    public Integer getInvalidoCre() {
        return invalidoCre;
    }

    public void setInvalidoCre(Integer invalidoCre) {
        this.invalidoCre = invalidoCre;
    }
    public String getPanCre() {
        return panCre;
    }

    public void setPanCre(String panCre) {
        this.panCre = panCre;
    }

    public String getFechaExpiracionCre() {
        return fechaExpiracionCre;
    }

    public void setFechaExpiracionCre(String fechaExpiracionCre) {
        this.fechaExpiracionCre = fechaExpiracionCre;
    }

    public String getNumeroCuentaCre() {
        return numeroCuentaCre;
    }

    public void setNumeroCuentaCre(String numeroCuentaCre) {
        this.numeroCuentaCre = numeroCuentaCre;
    }

    public Integer getCodigoMisCre() {
        return codigoMisCre;
    }

    public void setCodigoMisCre(Integer codigoMisCre) {
        this.codigoMisCre = codigoMisCre;
    }

    public String getNumeroTarjetaCre() {
        return numeroTarjetaCre;
    }

    public void setNumeroTarjetaCre(String numeroTarjetaCre) {
        this.numeroTarjetaCre = numeroTarjetaCre;
    }

    public String getIdentificacionCre() {
        return identificacionCre;
    }

    public void setIdentificacionCre(String identificacionCre) {
        this.identificacionCre = identificacionCre;
    }

    public String getTipoIdentificacionCre() {
        return tipoIdentificacionCre;
    }

    public void setTipoIdentificacionCre(String tipoIdentificacionCre) {
        this.tipoIdentificacionCre = tipoIdentificacionCre;
    }
}
