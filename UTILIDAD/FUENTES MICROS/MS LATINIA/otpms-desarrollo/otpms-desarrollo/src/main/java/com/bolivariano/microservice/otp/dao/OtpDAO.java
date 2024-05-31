package com.bolivariano.microservice.otp.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bolivariano.microservice.otp.exception.OTPException;
import com.bolivariano.microservice.otp.utils.StoredProcedureUtils;
import com.bolivariano.utilitario.dao.DbParameter;
import com.bolivariano.utilitario.dao.GenericRowMapper;
import com.bolivariano.utilitario.dao.ParameterType;

@Service
public class OtpDAO {

	private static final Logger logger = LoggerFactory.getLogger(OtpDAO.class);

	@Autowired
	private StoredProcedureUtils storedProcedureUtils;

	@Value("${limites.limitebd}")
	private Long limitedb;
	@Value("${spring.sybase.schemas.cobis}")
	private String schemaCobis;
	@Value("${spring.sybase.schemas.pagos}")
	private String schemaPagos;

	public Map<String, String> obtenerDetalleUsuarioVal(String proceso, Integer codigoMis){
		Map<String, String> salida = new HashMap<>();
		salida.put("codigoMis", String.valueOf(codigoMis));

		String nombreCliente = "";
		Map<?, ?> out = this.obtenerDetalleUsuario(proceso, codigoMis);
		if (out != null) {
			@SuppressWarnings("unchecked")
			List<Map<?, ?>> datosCliente = (List<Map<?, ?>>) out.get("rs1");
			if (datosCliente != null) {
				Map<?, ?> row = datosCliente.get(0);
				String nombre = row.get("nombre") + "";
				nombreCliente = row.get("p_apellido") + " " + (String) row.get("s_apellido");
				salida.put("nombre", nombre);
				salida.put("nombreCliente", nombreCliente);
			}
		}
		return salida;

	}

	public Integer obtenerCodigoMIS(String proceso, String identificacionCliente) {
		Map<String, Object> out = null;
		Integer mis = null;
		try {
			List<DbParameter> dbParameters = new ArrayList<>();

			dbParameters.add(new DbParameter("i_identificacion", identificacionCliente, Types.VARCHAR));
			dbParameters.add(new DbParameter("o_ente", 0, Types.INTEGER, ParameterType.OUTPUT));
			
			out = (Map<String, Object>) storedProcedureUtils.callStoredProcedureSybase(proceso,"dbo","cob_cuentas",
					"pa_cc_icpcnb", dbParameters, false);
			
			mis = Integer.valueOf(out.get("o_ente").toString());
		
		} catch (Exception e) {
			logger.error("Error invoacion SP pa_cc_icpcnb {}", e);
			mis = null;
		}

		return mis;
	}

	public Map<String, Object> obtenerDetalleUsuario(String proceso, int codigoMis) {
		Map<String, Object> out = null;

		List<DbParameter> dbParameters = new ArrayList<>();
		dbParameters.add(new DbParameter("e_cliente", codigoMis, Types.INTEGER));
		dbParameters.add(new DbParameter("s_codigo_error", null, Types.INTEGER, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("s_mensaje_usuario", null, Types.VARCHAR, ParameterType.OUTPUT));
		dbParameters.add(new DbParameter("rs1", new GenericRowMapper(), ParameterType.RESULTSET));

		out = (Map<String, Object>) storedProcedureUtils.callStoredProcedureSybase(proceso, "dbo", "cob_internet",
				"pa_wap_cdetalle_cliente", dbParameters, false);

		return out;
	}

	public Map<String, Object> obtenerMediosDeEnvio(String proceso, Integer mis) {
		Map<String, Object> out = null;
		try {
			List<DbParameter> dbParameters = new ArrayList<>();

			dbParameters.add(new DbParameter("i_cliente", mis, Types.INTEGER));
			dbParameters.add(new DbParameter("o_celular", "", Types.VARCHAR, ParameterType.OUTPUT));
			dbParameters.add(new DbParameter("o_correo", "", Types.VARCHAR, ParameterType.OUTPUT));

			out = (Map<String, Object>) storedProcedureUtils.callStoredProcedureSybase(proceso, "dbo", schemaPagos,
					"sp_consulta_celular", dbParameters, false);
			
		} catch (Exception e) {
			logger.error("Error invoacion SP sp_consulta_celular " + e.getMessage());
			out = null;
		}
		return out;
	}

	public Map<String, Object> obtenerMediosDeEnvioBayted(String proceso, String tipo, String identificacionCliente) throws OTPException {
		Map<String, Object> out = null;
		try {
			List<DbParameter> dbParameters = new ArrayList<>();

			dbParameters.add(new DbParameter("e_identificacion", identificacionCliente, Types.VARCHAR));
			dbParameters.add(new DbParameter("e_servicio", tipo, Types.VARCHAR));
			dbParameters.add(new DbParameter("s_correo", "", Types.VARCHAR, ParameterType.OUTPUT));
			dbParameters.add(new DbParameter("s_celular", "", Types.VARCHAR, ParameterType.OUTPUT));

			out = (Map<String, Object>) storedProcedureUtils.callStoredProcedureSybase(proceso, "dbo", schemaPagos, "pa_pg_cmedios_op",
					dbParameters, false);
			
		} catch (Exception e) {
			logger.error("Error invoacion SP pa_pg_cmedios_op " + e.getMessage());
			throw new OTPException("Error al consultar medio envio proveedor.",e);
		}
		return out;
	}
}
