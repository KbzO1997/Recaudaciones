package com.bolivariano.microservice.pagoproveedorcnb.test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.jboss.logging.Logger;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import com.bolivariano.microservice.pagoproveedorcnb.bean.CollectorRequest;
import com.bolivariano.microservice.pagoproveedorcnb.bean.MessageResponse;
import com.bolivariano.microservice.pagoproveedorcnb.dao.StoreProcedureDAO;
import com.bolivariano.microservice.pagoproveedorcnb.dao.SybaseScriptEngineDAO;
import com.bolivariano.microservice.pagoproveedorcnb.domain.mensajecollector.MensajeEntradaCollector;
import com.bolivariano.microservice.pagoproveedorcnb.exception.CollectorException;
import com.bolivariano.microservice.pagoproveedorcnb.service.ExecutorService;
import com.bolivariano.microservice.pagoproveedorcnb.service.MessageSenderService;
import com.bolivariano.microservice.pagoproveedorcnb.service.MessageService;
import com.bolivariano.microservice.pagoproveedorcnb.utils.CoreUtils;
import com.bolivariano.microservice.pagoproveedorcnb.utils.DataSourceFactory;
import com.bolivariano.microservice.pagoproveedorcnb.utils.StoreProcedureEngine;


import io.quarkus.test.junit.mockito.InjectMock;

class TestPago {

	@Inject
	MessageService mensajeService;

	@Inject
	MensajePago smsPagoProveedor;

	@InjectMock
	ExecutorService ejecutaServicio;

	@InjectMock
	SybaseScriptEngineDAO ejecutaDAO;

	@InjectMock
	Logger log;

	@InjectMock
	ExecutorService microsreEngine;

	@InjectMock
	MessageSenderService senderService;

	@InjectMock
	StoreProcedureEngine dataSourceEngine;

	@InjectMock
	DataSourceFactory dataSourceFactory;

	@InjectMock
	StoreProcedureDAO storeProcedureEngine;

	@InjectMock
	SybaseScriptEngineDAO sybaseScriptEngine;

	@InjectMock
	MensajeEntradaCollector mensajeCollectorIn;


	@BeforeEach
	void setUp() {
		microsreEngine = Mockito.mock(ExecutorService.class);
		log = Mockito.mock(Logger.class);
		microsreEngine = new ExecutorService();
		mensajeService = new MessageService();
		storeProcedureEngine = new StoreProcedureDAO();
		dataSourceEngine = new StoreProcedureEngine();
		dataSourceFactory = new DataSourceFactory();
		sybaseScriptEngine = new SybaseScriptEngineDAO();
	}

	/**
	 * Test Pago Proveedor Erroneo mensaje de entrada null
	 */
	@Test
	void testPagoProveedorError() {
		final String userId = null;
		try {
			mensajeService.processMessage(null, userId);
		} catch (Exception e) {
			Assertions.assertEquals(true, e.getCause() == (null));
		}
	}

	/**
	 * Teste Executar Proveedor Erroneo
	 */
	@Test
	void testExecutarProveedorError() {
		final String validaMensaje = "0";
		try {
			MessageResponse mensajeResponse;
			mensajeResponse = ejecutaServicio.executeTransaction(null);
			Assertions.assertEquals(validaMensaje, mensajeResponse.getCodeSPError());
		} catch (Exception e) {
			Assertions.assertNotNull(e.getStackTrace());
		}
	}

	/**
	 * Test Obtener Orden de Ejecucion Erronea
	 * 
	 * @throws CollectorException
	 */
	@Test
	void TestObtieneOrdenEjecucionError() throws CollectorException {

		final String opcion = "PAGO";
		try {
			Assertions.assertNull(ejecutaDAO.obtieneOrdenEjecucion(opcion));
		} catch (Exception e) {
			Assertions.assertNotNull(e.getStackTrace());
		}
	}

	/**
	 * Test Pago Tercero Erroneo mensaje de entrada null
	 */
	@Test
	void testPagoTerceroError() {
		final String userId = null;
		try {
			String mensajeJMS = null;
			mensajeService.processMessage(mensajeJMS, userId);
		} catch (Exception e) {
			Assertions.assertEquals(true, e.getCause() == (null));
		}
	}
	
	@Test
	void testPrepareStatementPago() {
		Date time = new Date();
		String variableDate = CoreUtils.dateToString(time);
		Assertions.assertNotNull(variableDate);
	}

	public static class MensajePago {

		public static String mensajePago() {
			return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><mensajeEntradaGateway xmlns=\"http://www.bolivariano.com/mensaje/MensajeOSB\"><puntoFinal>PagoProveedor/proxy/PagoProveedorCanal</puntoFinal><operacion>PAGAR</operacion><identificadorCorrelacion>e57ad106d699</identificadorCorrelacion><mensaje><![CDATA[<mensajeEntradaCollector xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.bolivariano.com/mensaje/MensajeCollector\"><opcion>PAGO</opcion><datos><dato><codigo>s_ssn</codigo><valor>10282955</valor></dato><dato><codigo>s_lsrv</codigo><valor>SRVDESA2</valor></dato><dato><codigo>s_srv</codigo><valor>SRVDESA2</valor></dato><dato><codigo>s_user</codigo><valor>CNB002</valor></dato><dato><codigo>s_term</codigo><valor>consola</valor></dato><dato><codigo>s_date</codigo><valor>07/20/2022</valor></dato><dato><codigo>s_ofi</codigo><valor>0</valor></dato><dato><codigo>s_rol</codigo><valor>244</valor></dato><dato><codigo>s_org</codigo><valor>L</valor></dato><dato><codigo>t_corr</codigo><valor>N</valor></dato><dato><codigo>t_ssn_corr</codigo><valor>0</valor></dato><dato><codigo>t_debug</codigo><valor>N</valor></dato><dato><codigo>t_rty</codigo><valor>N</valor></dato><dato><codigo>t_trn</codigo><valor>3966</valor></dato><dato><codigo>i_mon</codigo><valor>1</valor></dato><dato><codigo>i_opcion</codigo><valor>T</valor></dato><dato><codigo>i_opcaux</codigo><valor/></dato><dato><codigo>i_empresa</codigo><valor>4598</valor></dato><dato><codigo>i_autoriza</codigo><valor>N</valor></dato><dato><codigo>i_supautor</codigo><valor/></dato><dato><codigo>i_orden_banco</codigo><valor>10000031</valor></dato><dato><codigo>i_orden_empresa</codigo><valor>1495</valor></dato><dato><codigo>i_secuencial</codigo><valor>1</valor></dato><dato><codigo>i_nproducto</codigo><valor>3</valor></dato><dato><codigo>i_cta_debito</codigo><valor>0005090608</valor></dato><dato><codigo>i_nempresa</codigo><valor>ACROMAX</valor></dato><dato><codigo>i_nom_bene</codigo><valor/></dato><dato><codigo>i_frm_pagcob</codigo><valor>PEF</valor></dato><dato><codigo>i_canal</codigo><valor>CNB</valor></dato><dato><codigo>i_tident</codigo><valor>CC</valor></dato><dato><codigo>i_cta</codigo><valor>0957123425</valor></dato><dato><codigo>i_ident</codigo><valor>0957123425</valor></dato><dato><codigo>i_efe</codigo><valor>33.01</valor></dato><dato><codigo>i_valch</codigo><valor>0</valor></dato><dato><codigo>i_val</codigo><valor>33.01</valor></dato><dato><codigo>i_tipo_nuc_retiro</codigo><valor>CC</valor></dato><dato><codigo>i_nuc_retiro</codigo><valor>0957123425</valor></dato><dato><codigo>i_servicio</codigo><valor>PAGOPRV</valor></dato><dato><codigo>i_tipo_cheque</codigo><valor/></dato><dato><codigo>i_opcion_cons</codigo><valor>NUC</valor></dato><dato><codigo>i_sec</codigo><valor>0</valor></dato><dato><codigo>e_terminal_id</codigo><valor>3431</valor></dato><dato><codigo>e_comercio</codigo><valor>3431</valor></dato><dato><codigo>e_cod_autorizacion</codigo><valor>13100002</valor></dato><dato><codigo>e_agencia</codigo><valor>CNB00101</valor></dato><dato><codigo>e_red</codigo><valor>CNB002</valor></dato></datos></mensajeEntradaCollector>]]></mensaje></mensajeEntradaGateway>";
		}

		public static String mensajePagoTercero() {
			return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><mensajeEntradaGateway xmlns=\"http://www.bolivariano.com/mensaje/MensajeOSB\"><puntoFinal>PagoTercero/proxy/PagoTerceroCanal</puntoFinal><operacion>PAGAR</operacion><identificadorCorrelacion>e57ad106d699</identificadorCorrelacion><mensaje><![CDATA[<mensajeEntradaCollector xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.bolivariano.com/mensaje/MensajeCollector\"><opcion>PAGO</opcion><datos><dato><codigo>s_ssn</codigo><valor>10282955</valor></dato><dato><codigo>s_lsrv</codigo><valor>SRVDESA2</valor></dato><dato><codigo>s_srv</codigo><valor>SRVDESA2</valor></dato><dato><codigo>s_user</codigo><valor>CNB002</valor></dato><dato><codigo>s_term</codigo><valor>consola</valor></dato><dato><codigo>s_date</codigo><valor>07/20/2022</valor></dato><dato><codigo>s_ofi</codigo><valor>0</valor></dato><dato><codigo>s_rol</codigo><valor>244</valor></dato><dato><codigo>s_org</codigo><valor>L</valor></dato><dato><codigo>t_corr</codigo><valor>N</valor></dato><dato><codigo>t_ssn_corr</codigo><valor>0</valor></dato><dato><codigo>t_debug</codigo><valor>N</valor></dato><dato><codigo>t_rty</codigo><valor>N</valor></dato><dato><codigo>t_trn</codigo><valor>3966</valor></dato><dato><codigo>i_mon</codigo><valor>1</valor></dato><dato><codigo>i_opcion</codigo><valor>T</valor></dato><dato><codigo>i_opcaux</codigo><valor/></dato><dato><codigo>i_empresa</codigo><valor>4598</valor></dato><dato><codigo>i_autoriza</codigo><valor>N</valor></dato><dato><codigo>i_supautor</codigo><valor/></dato><dato><codigo>i_orden_banco</codigo><valor>10000031</valor></dato><dato><codigo>i_orden_empresa</codigo><valor>1495</valor></dato><dato><codigo>i_secuencial</codigo><valor>1</valor></dato><dato><codigo>i_nproducto</codigo><valor>3</valor></dato><dato><codigo>i_cta_debito</codigo><valor>0005090608</valor></dato><dato><codigo>i_nempresa</codigo><valor>ACROMAX</valor></dato><dato><codigo>i_nom_bene</codigo><valor/></dato><dato><codigo>i_frm_pagcob</codigo><valor>PEF</valor></dato><dato><codigo>i_canal</codigo><valor>CNB</valor></dato><dato><codigo>i_tident</codigo><valor>CC</valor></dato><dato><codigo>i_cta</codigo><valor>0957123425</valor></dato><dato><codigo>i_ident</codigo><valor>0957123425</valor></dato><dato><codigo>i_efe</codigo><valor>33.01</valor></dato><dato><codigo>i_valch</codigo><valor>0</valor></dato><dato><codigo>i_val</codigo><valor>33.01</valor></dato><dato><codigo>i_tipo_nuc_retiro</codigo><valor>CC</valor></dato><dato><codigo>i_nuc_retiro</codigo><valor>0957123425</valor></dato><dato><codigo>i_servicio</codigo><valor>PAGOPRV</valor></dato><dato><codigo>i_tipo_cheque</codigo><valor/></dato><dato><codigo>i_opcion_cons</codigo><valor>NUC</valor></dato><dato><codigo>i_sec</codigo><valor>0</valor></dato><dato><codigo>e_terminal_id</codigo><valor>3431</valor></dato><dato><codigo>e_comercio</codigo><valor>3431</valor></dato><dato><codigo>e_cod_autorizacion</codigo><valor>13100002</valor></dato><dato><codigo>e_agencia</codigo><valor>CNB00101</valor></dato><dato><codigo>e_red</codigo><valor>CNB002</valor></dato></datos></mensajeEntradaCollector>]]></mensaje></mensajeEntradaGateway>";
		}

		public static CollectorRequest mensajePagEjecutadorIn() {
			CollectorRequest resultCollector = new CollectorRequest();
			resultCollector.setOpcion("PAGO");
			resultCollector.setDatos(null);
			return resultCollector;
		}

		public static MessageResponse mensajePagEjecutadorOut() {
			MessageResponse microsreRespons = new MessageResponse();
			microsreRespons.setCorrelationId("af92e341fbc6");
			microsreRespons.setCodeSPError("0");
			microsreRespons.setExecutionDate(new Date());
			microsreRespons.setMessageSPError("sms");
			Map<String, Object> result = new HashMap<>();
			String[] dato = { "1" };
			result.put("i_opcion", dato);
			microsreRespons.setResult(result);
			return microsreRespons;
		}

	}

}
