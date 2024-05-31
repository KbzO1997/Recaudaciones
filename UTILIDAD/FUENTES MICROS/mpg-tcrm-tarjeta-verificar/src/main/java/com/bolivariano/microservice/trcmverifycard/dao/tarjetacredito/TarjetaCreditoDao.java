package com.bolivariano.microservice.trcmverifycard.dao.tarjetacredito;

import com.bolivariano.commons.utils.db.AbstractStoreProcedureCall;
import com.bolivariano.microservice.trcmverifycard.dto.tarjetacre.TarjetaCreditoRes;
import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import com.bolivariano.microservice.trcmverifycard.utils.LogsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.util.Date;


@Component
public class TarjetaCreditoDao extends AbstractStoreProcedureCall {

    private static final LogsUtils logger = LogsUtils.getLogger(TarjetaCreditoDao.class);

    private static final String S_NUMERO_CUENTA = "@s_numero_cuenta";
    private static final String S_CODIGO_MIS = "@s_codigo_mis";
    private static final String S_NUMERO_TARJETA = "@s_numero_tarjeta";
    private static final String S_IDENTIFICACION = "@s_identificacion";
    private static final String S_TIPO_IDENTIFICACION = "@s_tipo_identificacion";
    private static final String S_EXPIRADO = "@s_expirado";
    private static final String S_FRAUDE = "@s_fraude";
    private static final String S_ROBO = "@s_robo";
    private static final String S_INVALIDO = "@s_invalido";

    @Autowired
    public TarjetaCreditoDao(ApplicationContext applicationContext) {
        super(applicationContext);
    }
    public TarjetaCreditoRes consultarTarjetaCredito(TarjetaCredito sp){
        var startTime = new Date();

        TarjetaCreditoRes tarjetaCre = null;
        var data = callStoredProcedure(sp);

        String cuenta = (String) data.get(S_NUMERO_CUENTA);

        if (cuenta != null && !cuenta.isEmpty()) {
            tarjetaCre = new TarjetaCreditoRes();
            tarjetaCre.setNumeroCuenta((String) data.get(S_NUMERO_CUENTA));
            tarjetaCre.setCodigoMis((Integer) data.get(S_CODIGO_MIS));
            tarjetaCre.setNumeroTarjeta((String) data.get(S_NUMERO_TARJETA));
            tarjetaCre.setIdentificacion((String) data.get(S_IDENTIFICACION));
            tarjetaCre.setTipoIdentificacion((String) data.get(S_TIPO_IDENTIFICACION));
            tarjetaCre.setExpirado(((Integer) data.get(S_EXPIRADO)).equals(1));
            tarjetaCre.setFraude(((Integer) data.get(S_FRAUDE)).equals(1));
            tarjetaCre.setRobo(((Integer) data.get(S_ROBO)).equals(1));
            tarjetaCre.setInvalido(((Integer) data.get(S_INVALIDO)).equals(1));
        }

        logger.tiempo("consultarTarjetaCredito", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), data, 5000 - 1000 );
        return tarjetaCre;
    }
}
