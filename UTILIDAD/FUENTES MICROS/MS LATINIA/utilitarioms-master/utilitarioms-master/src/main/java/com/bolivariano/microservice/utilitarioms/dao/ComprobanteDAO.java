package com.bolivariano.microservice.utilitarioms.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Service;
import com.bolivariano.utilitario.dao.DbParameter;
import com.bolivariano.utilitario.dao.ParameterType;

@Service
public class ComprobanteDAO {
	
	@Autowired
	StoredProcedureUtils storedProcedureUtils;
	
	private Map<String, String> camposComprobante, camposComprobanteNoMon;
	
	@PostConstruct
	private void init() {
		camposComprobante= new HashMap<String, String>();
		camposComprobanteNoMon= new HashMap<String, String>();
		
		//Transacciones monetarias
		camposComprobante.put("trn", "t_trn");
		camposComprobante.put("ente", "i_ente");
		camposComprobante.put("fecha", "s_date");
		camposComprobante.put("secLog", "i_sec_log"); //para relacionar con bv_log
		camposComprobante.put("servicio", "i_servicio");
		camposComprobante.put("operacion", "i_operacion");
		camposComprobante.put("cuenta", "i_cuenta");
		camposComprobante.put("moneda", "i_moneda");
		camposComprobante.put("producto", "i_producto");
		camposComprobante.put("filialDb", "i_filial_db");
		camposComprobante.put("tipo", "i_tipo");
		camposComprobante.put("codigo", "i_codigo");
		camposComprobante.put("factura", "i_factura");
		camposComprobante.put("nombreCr", "i_nombre_cr");
		camposComprobante.put("cuentaCr", "i_cuenta_cr");
		camposComprobante.put("monedaCr", "i_moneda_cr");
		camposComprobante.put("productoCr", "i_producto_cr");
		camposComprobante.put("filialCr", "i_filial_cr");
		camposComprobante.put("monedaPago", "i_moneda_pago");
		camposComprobante.put("valor", "i_valor");
		camposComprobante.put("fechaReg", "i_fecha_reg");
		camposComprobante.put("fechaPago", "i_fecha_pago");
		camposComprobante.put("estado", "i_estado");
		camposComprobante.put("notas", "i_notas");
		camposComprobante.put("referencia", "i_referencia");
		camposComprobante.put("login", "i_login");
		camposComprobante.put("nombreFactura", "i_nombre_factura");
		camposComprobante.put("valorFactura", "i_valor_factura");
		camposComprobante.put("codTrans", "i_cod_trans");		
		camposComprobante.put("fchContable", "i_fch_contable");
		camposComprobante.put("saldoCuenta", "i_saldo_cuenta");
		camposComprobante.put("fchTope", "i_fch_tope");
		camposComprobante.put("pacLectAnt", "i_pac_lect_ant");
		camposComprobante.put("pacLectAct", "i_pac_lect_act");
		camposComprobante.put("pacDireccion", "i_pac_direccion");
		camposComprobante.put("pacFecDesde", "i_pac_fecdesde");
		camposComprobante.put("pacFecHasta", "i_pac_fechasta");
		camposComprobante.put("pacValorAcum", "i_pac_valoracum");
		camposComprobante.put("pacNumFac", "i_pac_numfac");
		camposComprobante.put("pacCategoria", "i_pac_categoria");
		camposComprobante.put("pacEmision", "i_pac_emision");
		camposComprobante.put("minimo", "i_minimo");
		camposComprobante.put("nombreCuenta", "i_nombre_cuenta");
		camposComprobante.put("tarifa", "i_tarifa");
		camposComprobante.put("texto1", "i_texto1");
		camposComprobante.put("texto2", "i_texto2");
		camposComprobante.put("recurrId", "i_recurr_id");
		camposComprobante.put("ejecucion", "i_ejecucion");
		camposComprobante.put("cedula", "i_cedula");
		
		//Transacciones no monetarias
		camposComprobanteNoMon.put("trn", "t_trn");
		camposComprobanteNoMon.put("ente", "i_ente");
		camposComprobanteNoMon.put("fecha", "s_date");
		camposComprobanteNoMon.put("secLog", "i_sec_log"); //para relacionar con bv_log
		camposComprobanteNoMon.put("servicio", "i_servicio");
		camposComprobanteNoMon.put("operacion", "i_operacion");
		camposComprobanteNoMon.put("cuenta", "i_cuenta");
		camposComprobanteNoMon.put("moneda", "i_moneda");
		camposComprobanteNoMon.put("producto", "i_producto");
		camposComprobanteNoMon.put("tipo", "i_tipo");
		camposComprobanteNoMon.put("codigo", "i_codigo");
		camposComprobanteNoMon.put("factura", "i_factura");
		camposComprobanteNoMon.put("filialCr", "i_filial_cr");
		camposComprobanteNoMon.put("monedaPago", "i_moneda_pago");
		camposComprobanteNoMon.put("valor", "i_valor");
		camposComprobanteNoMon.put("fechaReg", "i_fecha_reg");
		camposComprobanteNoMon.put("fechaPago", "i_fecha_pago");
		camposComprobanteNoMon.put("estado", "i_estado");
		camposComprobanteNoMon.put("notas", "i_notas");
		camposComprobanteNoMon.put("referencia", "i_referencia");
		camposComprobanteNoMon.put("login", "i_login");
		camposComprobanteNoMon.put("nombreFactura", "i_nombre_factura");
		camposComprobanteNoMon.put("codTrans", "i_cod_trans");		
		camposComprobanteNoMon.put("fchContable", "i_fch_contable");
		camposComprobanteNoMon.put("pacDireccion", "i_pac_direccion");
		camposComprobanteNoMon.put("pacValorAcum", "i_pac_valoracum");
		camposComprobanteNoMon.put("pacNumFac", "i_pac_numfac");
		camposComprobanteNoMon.put("pacEmision", "i_pac_emision");
		camposComprobanteNoMon.put("minimo", "i_minimo");
		camposComprobanteNoMon.put("nombreCuenta", "i_nombre_cuenta");
		camposComprobanteNoMon.put("tarifa", "i_tarifa");
		camposComprobanteNoMon.put("texto1", "i_texto1");
		camposComprobanteNoMon.put("texto2", "i_texto2");
		camposComprobanteNoMon.put("recurrId", "i_recurr_id");
		camposComprobanteNoMon.put("ejecucion", "i_ejecucion");
		camposComprobanteNoMon.put("cedula", "i_cedula");
	}
    
	public Map<?, ?> registrarComprobante(Map<?, ?> input){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		
		for (String key : camposComprobante.keySet()) {
			Object value= null;
			if(input.get(key) != null)
				value= input.get(key);
			
			inParams.put(camposComprobante.get(key), value);			
		}
		
		inParams.put("o_pagos_id", 0);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure("cob_bvirtual", "sp_ins_pagos", inParams, sqlParameters);
	}
	
	public Map<?, ?> registrarComprobanteNoMon(Map<?, ?> input){
		HashMap<String, Object> inParams = new HashMap<String, Object>();
		
		for (String key : camposComprobanteNoMon.keySet()) {
			Object value= null;
			if(input.get(key) != null)
				value= input.get(key);
			
			inParams.put(camposComprobanteNoMon.get(key), value);			
		}
		
		inParams.put("o_pagos_id", 0);
		SqlParameter sqlParameters [] = {};
		return storedProcedureUtils.callStoredProcedure("cob_bvirtual", "sp_ins_pagos_reimpre", inParams, sqlParameters);
	}
	
	public Map<?, ?> obtenerSecuencial(String tablaSecuencial){
		List<DbParameter> dbParameters = new ArrayList<>();
		dbParameters.add(new DbParameter("s_ssn", null, Types.INTEGER)); 
		dbParameters.add(new DbParameter("s_user", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_sesn", null, Types.INTEGER));
		dbParameters.add(new DbParameter("s_term", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_date", null, Types.DATE));
		dbParameters.add(new DbParameter("s_srv", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_lsrv", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_rol", null, Types.SMALLINT));
		dbParameters.add(new DbParameter("s_ofi", null, Types.SMALLINT));
		dbParameters.add(new DbParameter("s_org_err", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_error", null, Types.INTEGER));
		dbParameters.add(new DbParameter("s_sev", null, Types.TINYINT));
		dbParameters.add(new DbParameter("s_msg", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("s_org", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("t_debug", "N", Types.VARCHAR));
		dbParameters.add(new DbParameter("t_file", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("t_from", null, Types.VARCHAR));
		dbParameters.add(new DbParameter("i_tabla", tablaSecuencial, Types.VARCHAR));
		dbParameters.add(new DbParameter("o_siguiente",  0, Types.INTEGER, ParameterType.OUTPUT));

		return storedProcedureUtils.callStoredProcedureSybase("cobis", "sp_seqnos", dbParameters);			
	}
	
}
