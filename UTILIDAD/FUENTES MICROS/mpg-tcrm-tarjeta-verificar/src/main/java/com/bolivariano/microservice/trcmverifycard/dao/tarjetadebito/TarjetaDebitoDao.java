package com.bolivariano.microservice.trcmverifycard.dao.tarjetadebito;

import com.bolivariano.commons.utils.db.AbstractStoreProcedureCall;
import com.bolivariano.microservice.trcmverifycard.dto.tarjetadeb.TarjetaDebitoRes;

import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import com.bolivariano.microservice.trcmverifycard.utils.LogsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class TarjetaDebitoDao extends AbstractStoreProcedureCall {
    private static final LogsUtils logger = LogsUtils.getLogger(TarjetaDebitoDao.class);

    private static final String S_NUMERO_CUENTA = "@s_numero_cuenta";
    private static final String S_CODIGO_MIS = "@s_codigo_mis";
    private static final String S_NUMERO_TARJETA = "@s_numero_tarjeta";
    private static final String S_EXPIRADO = "@s_expirado";
    private static final String S_FRAUDE = "@s_fraude";
    private static final String S_ROBO = "@s_robo";
    private static final String S_INVALIDO = "@s_invalido";
    @Autowired
    public TarjetaDebitoDao(ApplicationContext applicationContext) {
        super(applicationContext);
    }
    public TarjetaDebitoRes consultarTarjetaDebito(TarjetaDebito sp){
        var startTime = new Date();

        TarjetaDebitoRes tarjetaDeb = null;

        var data = callStoredProcedure(sp);

        if (((Integer) data.get(S_NUMERO_CUENTA) != null) ) {
            tarjetaDeb = new TarjetaDebitoRes();

            tarjetaDeb.setNumeroCuenta(((Integer) data.get(S_NUMERO_CUENTA)).toString());
            tarjetaDeb.setCodigoMis((Integer) data.get(S_CODIGO_MIS));
            tarjetaDeb.setNumeroTarjeta(((Integer) data.get(S_NUMERO_TARJETA)).toString());
            tarjetaDeb.setExpirado(((Integer) data.get(S_EXPIRADO)).equals(1));
            tarjetaDeb.setFraude(((Integer) data.get(S_FRAUDE)).equals(1));
            tarjetaDeb.setRobo(((Integer) data.get(S_ROBO)).equals(1));
            tarjetaDeb.setFraude(((Integer) data.get(S_FRAUDE)).equals(1));
            tarjetaDeb.setInvalido(((Integer) data.get(S_INVALIDO)).equals(1));
        }

        logger.tiempo("consultarTarjetaDebito", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), data, 5000 - 1000 );

        return tarjetaDeb;
    }
}
