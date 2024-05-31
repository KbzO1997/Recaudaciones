package com.bolivariano.microservice.trcmverifycard.dao.cliente;

import com.bolivariano.commons.annotation.StoreProcedure;
import com.bolivariano.commons.annotation.StoreProcedureParam;
import com.bolivariano.commons.utils.db.AbstractStoreProcedureModel;
import lombok.Getter;
import lombok.Setter;

import java.sql.Types;

@Getter
@Setter
@StoreProcedure(schema = "dbo",catalog = "cobis",name="pa_tcd_ccliente")
public class Cliente extends AbstractStoreProcedureModel {
    @StoreProcedureParam(name = "@e_codigo_mis",type = Types.INTEGER)
    private Integer codigoMis;
    @StoreProcedureParam(name = "@s_nombre_cliente",type = Types.VARCHAR,isOut = true)
    private String nombreCliente;
    @StoreProcedureParam(name = "@s_apellidoCliente",type = Types.VARCHAR,isOut = true)
    private String apellidoCliente;
    @StoreProcedureParam(name = "@s_fecha_nacimiento",type = Types.VARCHAR,isOut = true)
    private String fechaNacimiento;
    @StoreProcedureParam(name = "@s_title",type = Types.VARCHAR,isOut = true)
    private String title;
    @StoreProcedureParam(name = "@s_direccion",type = Types.VARCHAR,isOut = true)
    private String direccion;
    @StoreProcedureParam(name = "@s_email",type = Types.VARCHAR,isOut = true)
    private String email;
    @StoreProcedureParam(name = "@s_pais",type = Types.VARCHAR,isOut = true)
    private String pais;

    @StoreProcedureParam(name = "@s_ciudad",type = Types.VARCHAR,isOut = true)
    private String ciudad;
    @StoreProcedureParam(name = "@s_celular",type = Types.VARCHAR,isOut = true)
    private String celular;
}
