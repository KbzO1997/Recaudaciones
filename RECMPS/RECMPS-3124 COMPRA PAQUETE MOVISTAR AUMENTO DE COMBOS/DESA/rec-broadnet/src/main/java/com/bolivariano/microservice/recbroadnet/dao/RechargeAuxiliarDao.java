package com.bolivariano.microservice.recbroadnet.dao;

import com.bolivariano.microservice.recbroadnet.domain.RechargeAuxiliar;
import com.bolivariano.microservice.recbroadnet.domain.SalidaSpCatalogo;
import io.agroal.api.AgroalDataSource;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.sql.*;

@ApplicationScoped
public class RechargeAuxiliarDao {

	@Inject
    Logger log;

    @Inject
    AgroalDataSource dataSource;

    public SalidaSpCatalogo auxiliarRecharge(RechargeAuxiliar valorRechargeAuxiliar) throws SQLException  {
        Connection connection = null;
        CallableStatement procStmt = null;
        StringBuilder sql = new StringBuilder();
        SalidaSpCatalogo responseSPAuxRecharge = new SalidaSpCatalogo();
                
        try{
            connection = dataSource.getConnection();

            sql.append(" { call cob_pagos..pa_pg_iauxrecarga(?,?,?,?,?,?,?,?,?,?,?,?,?) }");
            procStmt = connection.prepareCall(sql.toString(), ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            //parametros de entrada
            procStmt.setString	("@e_celular", valorRechargeAuxiliar.getCelular() );
            procStmt.setInt		("@e_operadora", valorRechargeAuxiliar.getOperadora() );
            procStmt.setInt		("@e_secuencial", valorRechargeAuxiliar.getSecuencial());	
            procStmt.setDouble	("@e_efectivo", valorRechargeAuxiliar.getEfectivo());
            procStmt.setDouble	("@e_debito", valorRechargeAuxiliar.getDebito());
            procStmt.setDate	("@s_date", Date.valueOf(valorRechargeAuxiliar.getFecha()));
            procStmt.setString	("@e_canal", valorRechargeAuxiliar.getCanal());
            procStmt.setString	("@s_user", valorRechargeAuxiliar.getUser() );
            procStmt.setInt		("@e_oficina", valorRechargeAuxiliar.getOficina());  
            procStmt.setInt		("@e_ubicacion", valorRechargeAuxiliar.getUbicacion());  
            procStmt.setString	("@e_nombre", valorRechargeAuxiliar.getNombre() ); 
            procStmt.setString	("@e_tipo_cta", valorRechargeAuxiliar.getTipoCuenta() );
            procStmt.setString	("@e_cuenta", valorRechargeAuxiliar.getCuenta() );                            

        	log.info("PARAMETROS SP: COB_PAGOS..PA_PG_IAUXRECARGA "+valorRechargeAuxiliar.getCelular() + ","+valorRechargeAuxiliar.getOperadora()+ ","+valorRechargeAuxiliar.getSecuencial()+ ","+valorRechargeAuxiliar.getEfectivo()+ ","
        														  +valorRechargeAuxiliar.getDebito()+ ","+valorRechargeAuxiliar.getFecha()+ ","+valorRechargeAuxiliar.getCanal()+ ","
        														  +valorRechargeAuxiliar.getUser() + ","+valorRechargeAuxiliar.getOficina()+ ","+valorRechargeAuxiliar.getUbicacion()+ ","
        														  +valorRechargeAuxiliar.getNombre()+ ","+valorRechargeAuxiliar.getTipoCuenta()+","+valorRechargeAuxiliar.getCuenta());        	            
            boolean results = procStmt.execute();

            log.info("Respuesta pa_pg_iauxrecarga results: "+results);
            
            responseSPAuxRecharge.setCodigo(0);
            responseSPAuxRecharge.setMensajeSalida("PROCESO EJECUTADO");
            procStmt.close();     

        }catch (Exception e) {
            log.error(e.getMessage());
            log.error("ERROR AL EJECUTAR AUXILIARRECHARGE: ", e);
            responseSPAuxRecharge.setMensajeSalida("ERROR AL EJECUTAR AUXILIARRECHARGE: " + e.getMessage());
            responseSPAuxRecharge.setCodigo(1);

        }finally {
            try{
                if (procStmt != null){
                    procStmt.close();
                }
                if (connection != null){
                    log.info("CIERRA CONEXION!");
                    connection.close();
                }
            }catch (Exception ex){
                log.error("ERROR AL CERRAR CONEXION: " + ex.getMessage(),ex);
            }

        }

        return responseSPAuxRecharge;

    }
}
