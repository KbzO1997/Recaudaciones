package com.bolivariano.microservice.trcmverifycard.dao.cliente;

import com.bolivariano.commons.utils.db.AbstractStoreProcedureCall;
import com.bolivariano.microservice.trcmverifycard.dao.tarjetacredito.TarjetaCreditoDao;
import com.bolivariano.microservice.trcmverifycard.dto.cliente.ClienteRes;
import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import com.bolivariano.microservice.trcmverifycard.utils.LogsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class ClienteDao extends AbstractStoreProcedureCall {
    private static final LogsUtils logger = LogsUtils.getLogger(TarjetaCreditoDao.class);

    private static final String S_NOMBRE_CLIENTE = "@s_nombre_cliente";
    private static final String S_APELLIDO_CLIENTE = "@s_apellidoCliente";
    private static final String S_FECHA_NACIMIENTO = "@s_fecha_nacimiento";
    private static final String S_TITLE = "@s_title";
    private static final String S_DIRECCION = "@s_direccion";
    private static final String S_EMAIL = "@s_email";
    private static final String S_PAIS = "@s_pais";
    private static final String S_CIUDAD = "@s_ciudad";
    private static final String S_CELULAR = "@s_celular";
    @Autowired
    public ClienteDao(ApplicationContext applicationContext) {
        super(applicationContext);
    }

    public ClienteRes consultarCliente(Cliente sp){
        var startTime = new Date();

        ClienteRes cliente = null;

        new ClienteRes();

        var client =  callStoredProcedure(sp);

        if (client.containsKey(S_NOMBRE_CLIENTE) && ((String) client.get(S_NOMBRE_CLIENTE) != null)) {
            cliente = new ClienteRes();

            cliente.setNombreCliente((String) client.get(S_NOMBRE_CLIENTE));
            cliente.setApellidoCliente((String) client.get(S_APELLIDO_CLIENTE));
            cliente.setFechaNacimiento(fechaNacimiento((String) client.get(S_FECHA_NACIMIENTO)));
            cliente.setTitle((String) client.get(S_TITLE));
            cliente.setDireccion((String) client.get(S_DIRECCION));
            cliente.setEmail((String) client.get(S_EMAIL));
            cliente.setPais((String) client.get(S_PAIS));
            cliente.setCiudad((String) client.get(S_CIUDAD));
            cliente.setCelular((String) client.get(S_CELULAR));
        }

        logger.tiempo("consultarCliente", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), client, 5000 - 1000 );
        return cliente;
    }



    private String fechaNacimiento(String fechaString){
        SimpleDateFormat formato = new SimpleDateFormat("MMM dd yyyy hh:mma");
        SimpleDateFormat formatoSalida = new SimpleDateFormat("yyyy-MM-dd");
        String dateReturn = "";
        try{
            Date fecha = formato.parse(fechaString);
            dateReturn = formatoSalida.format(fecha);
            return dateReturn;
        }catch (ParseException e){
            return e.getMessage();
        }
    }
}
