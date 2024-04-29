package com.bolivariano.microservice.recbroadnet.dao;

import com.bolivariano.microservice.recbroadnet.domain.Catalogo;
import com.bolivariano.microservice.recbroadnet.domain.SalidaSpCatalogo;
import io.agroal.api.AgroalDataSource;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@ApplicationScoped
public class CatalogosDao {

    @Inject
    Logger log;

    @Inject
    AgroalDataSource dataSource;

    public SalidaSpCatalogo catalogos(String tabla, String canal) throws SQLException {

        SalidaSpCatalogo responseSPCatalogos = new SalidaSpCatalogo();
        List<Catalogo> lstCtalogo = new ArrayList<>();
        Catalogo catalogo;
        Connection connection = null;
        CallableStatement procStmt = null;
        StringBuilder sql = new StringBuilder();
        ResultSet rs = null;

        try {

            connection = dataSource.getConnection();
            sql.append(" { call cob_internet..pa_cash_gtabla(?,?,?,?) }");
            procStmt = connection.prepareCall(sql.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            procStmt.setString("@e_tabla", tabla);
            procStmt.registerOutParameter("@s_codigo_respuesta", Types.INTEGER);
            procStmt.registerOutParameter("@s_mensaje_usuario", Types.VARCHAR);
            procStmt.setString("@e_canal", canal);

            boolean results = procStmt.execute();

            while (true) {
                if (results) {
                    rs = procStmt.getResultSet();

                    while (rs.next()) {
                        catalogo = new Catalogo();
                        catalogo.setIdTabla(rs.getInt(1));
                        catalogo.setParametro(rs.getDouble(2));
                        catalogo.setValor(rs.getString(3));
                        lstCtalogo.add(catalogo);
                    }
                } else {
                    int updateCount = procStmt.getUpdateCount();
                    if (updateCount == -1) {
                        break;
                    }
                }
                results = procStmt.getMoreResults();
            }

            responseSPCatalogos.setCodigo(procStmt.getInt("@s_codigo_respuesta"));
            responseSPCatalogos.setMensajeSalida(procStmt.getString("@s_mensaje_usuario"));
            responseSPCatalogos.setLstCatalogo(lstCtalogo);

            procStmt.close();
            log.info("MENSAJE RECIBIDO >>>> " + responseSPCatalogos.getMensajeSalida());

        } catch (Exception e) {
        	
            log.error("ERROR AL EJECUTAR CONSULTA: ", e);
            responseSPCatalogos.setMensajeSalida("ERROR AL EJECUTAR CONSULTA: " + e.getMessage());
            responseSPCatalogos.setCodigo(1);

        } finally {
            try{
                if (procStmt != null){
                    procStmt.close();
                }
                if (connection != null){
                    log.info("CIERRA CONEXION!");
                    connection.close();
                }
                if (rs != null){
                    rs.close();
                }
            }catch (Exception ex){
                log.error("ERROR AL CERRAR CONEXION: " + ex.getMessage(),ex);
            }

        }
        return responseSPCatalogos;
    }

}
