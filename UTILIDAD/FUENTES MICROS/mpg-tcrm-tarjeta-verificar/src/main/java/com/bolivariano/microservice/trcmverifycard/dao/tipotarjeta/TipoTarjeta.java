package com.bolivariano.microservice.trcmverifycard.dao.tipotarjeta;
import com.bolivariano.commons.annotation.StoreProcedureParam;
import com.bolivariano.commons.annotation.StoreProcedure;
import com.bolivariano.commons.utils.db.AbstractStoreProcedureModel;

import java.sql.Types;

@StoreProcedure(schema = "dbo",catalog = "db_tarjeta_bb",name="pa_tcd_ctipotarjeta")
public class TipoTarjeta extends AbstractStoreProcedureModel {
    @StoreProcedureParam(name = "@e_pan",type = Types.VARCHAR)
    private String pan;
    @StoreProcedureParam(name = "@s_tipo_tarjeta",type = Types.VARCHAR,isOut = true)
    private String tipo;

    public String getPan() {
        return pan;
    }

    public void setPan(String pan) {
        this.pan = pan;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

}
