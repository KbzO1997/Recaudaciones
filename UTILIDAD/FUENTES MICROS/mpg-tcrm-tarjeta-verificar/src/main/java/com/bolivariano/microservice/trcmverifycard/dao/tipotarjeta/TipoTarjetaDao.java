package com.bolivariano.microservice.trcmverifycard.dao.tipotarjeta;

import com.bolivariano.commons.utils.db.AbstractStoreProcedureCall;
import com.bolivariano.microservice.trcmverifycard.utils.CoreUtils;
import com.bolivariano.microservice.trcmverifycard.utils.LogsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class TipoTarjetaDao extends AbstractStoreProcedureCall {
    private static final LogsUtils logger = LogsUtils.getLogger(TipoTarjetaDao.class);

    private static final String S_TIPO_TARJETA = "@s_tipo_tarjeta";
    @Autowired
    public TipoTarjetaDao(ApplicationContext applicationContext) {
        super(applicationContext);
    }
    public String consultarTipoTarjeta(TipoTarjeta sp){
        var startTime = new Date();
        String dataReturn = "";
        var data = callStoredProcedure(sp);
        dataReturn = (String) data.get(S_TIPO_TARJETA);
        logger.tiempo("consultarTipoTarjeta", CoreUtils.dateToString(startTime), CoreUtils.getTimeIntervalInt(startTime), data, 5000 - 1000 );
        return dataReturn;
    }
}
