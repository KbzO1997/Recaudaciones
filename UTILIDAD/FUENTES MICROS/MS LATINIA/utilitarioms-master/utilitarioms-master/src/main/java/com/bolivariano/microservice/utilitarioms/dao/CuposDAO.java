package com.bolivariano.microservice.utilitarioms.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Service;
import com.bolivariano.utilitario.dao.DbParameter;
import com.bolivariano.utilitario.dao.GenericRowMapper;
import com.bolivariano.utilitario.dao.ParameterType;

@Service
public class CuposDAO {
	
	private String schemaName = "cob_bvirtual";
	private String schemaNameSybase = "cob_internet";
	
	@Autowired
	StoredProcedureUtils storedProcedureUtils;
	
	public Map<?, ?> obtenerEnte(String identificacion){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("e_login", identificacion);
		inParams.put("e_identificador", null);
		inParams.put("e_tipotrx", null);
		inParams.put("s_ente", null);
		inParams.put("s_ente_mis", null);
		inParams.put("s_tipo_persona", null);
		inParams.put("s_ssn_branch", null);
		inParams.put("s_codigo", null);
		inParams.put("s_cta_credito_prod", null);
		inParams.put("s_resultado", null);
		inParams.put("s_mensaje", null);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure("cob_internet", "pa_wap_ccon_datos_general", inParams, sqlParameters);
	}
	
	public Map<?, ?> validaCupoNormal(String identificacion, String cuenta, double monto, int producto, String moneda, String tipo){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("e_login", identificacion);
		inParams.put("e_servicio", 1);
		inParams.put("e_ctadeb", cuenta);
		inParams.put("e_moneda", moneda);
		inParams.put("e_producto", producto);
		inParams.put("e_monto", monto);
		inParams.put("e_tipo", tipo);
		inParams.put("s_resultado", null);
		inParams.put("s_mensaje", null);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure(schemaName, "pa_wap_pverif_cupo_normal", inParams, sqlParameters);
	}
	
	public Map<?, ?> actualizaCupoNormal(String identificacion, String cuenta, double monto, int producto, String moneda, String tipo){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("e_login", identificacion);
		inParams.put("e_servicio", 1);
		inParams.put("e_ctadeb", cuenta);
		inParams.put("e_moneda", moneda);
		inParams.put("e_producto", producto);
		inParams.put("e_monto", monto);
		inParams.put("e_tipo", tipo);
		inParams.put("s_resultado", null);
		inParams.put("s_mensaje", null);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure(schemaName, "pa_wap_acupo_normal", inParams, sqlParameters);
	}
	
	
	public Map<?, ?> validaCupoPersonalizado(String identificacion, String usuario, int cliente, 
			int secuencial, String servidor, int oficina, String cuenta,
			String terminal, int transaccion,  double monto, int producto, String moneda, String tipoPersona){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("s_ssn", secuencial);
		inParams.put("i_cliente", cliente);
		inParams.put("i_servicio", 1);
		inParams.put("s_servicio", 1);
		inParams.put("i_moneda", moneda);
		inParams.put("i_producto", producto);
		inParams.put("i_cuenta", cuenta);
		inParams.put("i_monto", monto);
		inParams.put("i_tercero", "N");
		inParams.put("i_signo", "D");
		inParams.put("i_validar", "N");
		inParams.put("i_login", identificacion);
		inParams.put("i_trn_origen", transaccion);
		inParams.put("i_tipo_persona", tipoPersona);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure(schemaName, "sp_chequea_cuenta_bv_new", inParams, sqlParameters);
	}
	
	public Map<?, ?> actualizaCupoPersonalizado(String identificacion, String usuario, int cliente, 
			int secuencial, String servidor, int oficina, String cuenta,
			String terminal, int transaccion,  double monto, int producto, String moneda, String tipoPersona){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("s_ssn", secuencial);
		inParams.put("s_user", usuario);
		inParams.put("s_term", terminal);
		inParams.put("s_date", new Date());
		inParams.put("s_srv", servidor);
		inParams.put("s_lsrv", servidor);
		inParams.put("s_sesn", null);
		inParams.put("s_ofi", oficina);
		inParams.put("t_trn", transaccion);
		inParams.put("t_corr", "N");
		inParams.put("t_debug", "N");
		inParams.put("t_file", null);
		inParams.put("t_from", null);
		inParams.put("s_servicio", 1);
		inParams.put("i_cuenta", cuenta);
		inParams.put("i_cliente_cod", cliente);
		inParams.put("i_login", identificacion);
		inParams.put("i_producto", producto);
		inParams.put("i_moneda", moneda);
		inParams.put("i_monto", monto);
		inParams.put("i_trn_origen", transaccion);
		inParams.put("i_tipo_persona", tipoPersona);
		
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure(schemaName, "sp_saldo_diario_new", inParams, sqlParameters);
	}
	
	public Map<?, ?> obtenerCodigoMoneda(String nemonicoMoneda, Integer codigoMoneda, String canal){
		List<DbParameter> dbParameters = new ArrayList<>();
		dbParameters.add(new DbParameter("e_tipo_moneda", nemonicoMoneda, Types.VARCHAR));
		dbParameters.add(new DbParameter("e_cod_moneda", codigoMoneda, Types.VARCHAR));
		dbParameters.add(new DbParameter("e_canal", canal, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_tipo_moneda", null, Types.VARCHAR, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("s_cod_moneda", null, Types.VARCHAR, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("s_cod_respuesta", 0, Types.INTEGER, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("s_mensaje ", null, Types.VARCHAR, ParameterType.OUTPUT));		
		return storedProcedureUtils.callStoredProcedureSybase(schemaNameSybase, "pa_cash_ccod_moneda", dbParameters);
	}
	
	public Map<?, ?> obtenerMediosEnvio(String tipoIdentificacion, String identificacion, String canal) {
		List<DbParameter> dbParameters = new ArrayList<>();
		dbParameters.add(new DbParameter("e_identificacion", identificacion, Types.VARCHAR));
		dbParameters.add(new DbParameter("e_tipo_identificacion", tipoIdentificacion, Types.CHAR));
		dbParameters.add(new DbParameter("s_cod_error", 0, Types.INTEGER, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("s_msj_error", null, Types.VARCHAR, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("e_canal", canal, Types.VARCHAR));
		dbParameters.add(new DbParameter("result", new GenericRowMapper(), ParameterType.RESULTSET));
		return storedProcedureUtils.callStoredProcedureSybase(schemaNameSybase, "pa_cash_gmedios_envio", dbParameters);
	}
	
	public Map<?, ?> obtenerTipoCupo(String cuenta, int producto, int enteMis, String tipoPersona){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("i_cuenta", cuenta);
		inParams.put("i_producto", producto);
		inParams.put("i_cliente", enteMis);
		inParams.put("i_tipo_persona", tipoPersona);
		inParams.put("o_cupo_normal", null);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure("cob_internet", "sp_consulta_tipo_cupo", inParams, sqlParameters);
	}
	
	public Map<?, ?> obtenerEnteWap(String identificacion, String opcion){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		inParams.put("i_login", identificacion);
		inParams.put("i_opcion", opcion);
		inParams.put("o_ente", null);
		inParams.put("o_ente_mis", null);
		inParams.put("o_cliente", null);
		inParams.put("o_tipo_persona", null);
		inParams.put("o_ced_pass", null);
		inParams.put("o_clave_digital", null);
		inParams.put("o_dispositivo", null);
		inParams.put("o_val_tiene_disp", null);
		inParams.put("o_resultado", null);
		inParams.put("o_secuencial", null);
		inParams.put("o_mensaje", null);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure("cob_internet", "sp_obtener_ente_wap", inParams, sqlParameters);
	}
	
	public Map<String, String> obtenerDetalleUsuarioVal(String identificacion, String canal) throws Exception {
		Map<String, String> salida = new HashMap<String, String>();

		Integer codigoMis = this.obtenerCodigoMisVal(identificacion, canal);
		salida.put("codigoMis", String.valueOf(codigoMis));

		String nombreCliente = "";
		Map<?, ?> out = this.obtenerDetalleUsuario(codigoMis);
		if (out != null) {
			@SuppressWarnings("unchecked")
			List<Map<?, ?>> datosCliente = (List<Map<?, ?>>) out.get("rs1");
			if (datosCliente != null) {
				Map<?, ?> row = datosCliente.get(0);
				String nombre = row.get("nombre")+"";
				nombreCliente = row.get("p_apellido") + " " + (String) row.get("s_apellido");
				salida.put("nombre", nombre);
				salida.put("nombreCliente", nombreCliente);
			}
		}
		if (out == null) {
			throw new Exception("Error al obtener Detalle del Cliente pa_wap_cdetalle_cliente");
		} else if (nombreCliente == null || nombreCliente.equals("")) {
			throw new Exception("No existe Detalle del Cliente pa_wap_cdetalle_cliente");
		}

		return salida;

	}
	
	private Integer obtenerCodigoMisVal(String identificacion, String canal) throws Exception {		
		Integer codigoMis = null;
		Map<?, ?> out = this.obtenerCodigoMis(identificacion, canal);
		if (out != null) {
			codigoMis = (Integer) out.get("s_ente_mis");
		}
		if (out == null) {
			throw new Exception("Error al obtener Codigo MIS pa_wap_cdetalle_cliente");
		} else if (codigoMis == null) {
			throw new Exception("No existe Codigo MIS pa_wap_cdetalle_cliente");
		}
		return codigoMis;
	}
	
	public Map<?, ?> obtenerCodigoMis(String identificacion, String canal){
    	List<DbParameter> dbParameters = new ArrayList<>();
    	dbParameters.add(new DbParameter("e_tipo_identificacion", "", Types.VARCHAR));
    	dbParameters.add(new DbParameter("e_identificacion", identificacion, Types.VARCHAR));
    	dbParameters.add(new DbParameter("s_ente_mis", 0, Types.INTEGER, ParameterType.OUTPUT));
    	dbParameters.add(new DbParameter("e_canal", "", Types.VARCHAR));
    	
		return storedProcedureUtils.callStoredProcedureSybase("cob_internet", "pa_cash_cobtener_mis", dbParameters);
	}
	 public Map<?, ?> obtenerDetalleUsuario(int codigoMis){
	    	List<DbParameter> dbParameters = new ArrayList<>(); 	
			dbParameters.add(new DbParameter("e_cliente", codigoMis, Types.INTEGER));   
			dbParameters.add(new DbParameter("s_codigo_error", null, Types.INTEGER, ParameterType.OUTPUT));
			dbParameters.add(new DbParameter("s_mensaje_usuario", null, Types.VARCHAR, ParameterType.OUTPUT));
			dbParameters.add(new DbParameter("rs1", new GenericRowMapper(), ParameterType.RESULTSET));
			
			return storedProcedureUtils.callStoredProcedureSybase("cob_internet", "pa_wap_cdetalle_cliente", dbParameters);
	}
	//BMK-1433 dvillavc 2020/07/27
	public Map<?, ?> obtenerParametroCore(String nemonico, String tipo, String prodcuto){
		List<DbParameter> dbParameters = new ArrayList<>();
		dbParameters.add(new DbParameter("e_nemonico", nemonico, Types.VARCHAR));   
		dbParameters.add(new DbParameter("e_tipo", tipo, Types.VARCHAR));
		dbParameters.add(new DbParameter("e_producto", prodcuto, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_retorno", null, Types.INTEGER, ParameterType.OUTPUT));
		return storedProcedureUtils.callStoredProcedureSybase(schemaNameSybase, "pa_wap_cparametros_cobis", dbParameters);	
	}
	//BMK-1433 dvillavc 2020/07/27
	
}
