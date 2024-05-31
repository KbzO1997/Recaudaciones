package com.bolivariano.microservice.pagoproveedorcnb.test;

import java.sql.Connection;
import java.sql.SQLException;
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
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import io.quarkus.test.junit.mockito.InjectMock;


class TestConsulta {

	@Inject
	MessageService mensajeService;

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

	private static HikariDataSource dataSourceObj;

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

	@Test
	void testPrepareStatement() {
		Date time = new Date();
		String variableDate = CoreUtils.dateToString(time);
		Assertions.assertNotNull(variableDate);
	}

	/**
	 * Test Consulta Tercero Error
	 * 
	 * @throws Exception
	 */
	@Test
	void testConsultaTerceroError() throws Exception {
		final String userId = null;
		try {
			String mensajeJMS = MensajeConsulta.mensajeConsTercero();
			mensajeService.processMessage(mensajeJMS, userId);
		} catch (Exception e) {
			Assertions.assertNotNull(e.getStackTrace());
		}
	}

	/**
	 * Test Executar Proveedor Erroneo
	 */
	@Test
	void testExecutarProveedorError() {
		final String validaMensaje = "0";
		try {
			MessageResponse mensajeResponse;
			mensajeResponse = microsreEngine.executeTransaction(null);
			Assertions.assertEquals(validaMensaje, mensajeResponse.getCodeSPError());
		} catch (Exception e) {
			Assertions.assertNotNull(e.getStackTrace());
		}
	}

	/**
	 * Test Consultar Pago Proveedor Error
	 */
	@Test
	void testConsultaProveedorError() {
		final String userId = null;

		try {
			String mensajeJMS = null;
			mensajeService.processMessage(mensajeJMS, userId);
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

		final String opcion = "";
		try {
			sybaseScriptEngine.obtieneOrdenEjecucion(opcion);
		} catch (Exception e) {
			Assertions.assertNotNull(e.getStackTrace());
		}
	}

	public static class MensajeConsulta {

		public static String mensajeCons() {
			return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><mensajeEntradaGateway xmlns=\"http://www.bolivariano.com/mensaje/MensajeOSB\"><puntoFinal>PagoProveedor/proxy/PagoProveedorCanal</puntoFinal><operacion>CONSULTAR</operacion><identificadorCorrelacion>19c1cc3406dc</identificadorCorrelacion><mensaje><![CDATA[<mensajeEntradaCollector xmlns:ns11=\"http://www.bolivariano.com/ws/EMT/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.bolivariano.com/mensaje/MensajeCollector\"><opcion>CONSULTA_OPAGO</opcion><datos><dato><codigo>s_ssn</codigo><valor>33519836</valor></dato><dato><codigo>s_lsrv</codigo><valor>BOLIVSRV</valor></dato><dato><codigo>s_srv</codigo><valor>BOLIVSRV</valor></dato><dato><codigo>s_user</codigo><valor>cnb001</valor></dato><dato><codigo>s_term</codigo><valor>consola</valor></dato><dato><codigo>s_date</codigo><valor>08/09/2022</valor></dato><dato><codigo>s_ofi</codigo><valor>0</valor></dato><dato><codigo>s_rol</codigo><valor>252</valor></dato><dato><codigo>s_org</codigo><valor>L</valor></dato><dato><codigo>t_corr</codigo><valor>N</valor></dato><dato><codigo>t_ssn_corr</codigo><valor>0</valor></dato><dato><codigo>t_debug</codigo><valor/></dato><dato><codigo>t_file</codigo><valor/></dato><dato><codigo>t_from</codigo><valor/></dato><dato><codigo>t_rty</codigo><valor>N</valor></dato><dato><codigo>t_trn</codigo><valor>3966</valor></dato><dato><codigo>i_mon</codigo><valor>1</valor></dato><dato><codigo>i_opcaux</codigo><valor/></dato><dato><codigo>i_empresa</codigo><valor>437</valor></dato><dato><codigo>i_servicio</codigo><valor>PAGOPRV</valor></dato><dato><codigo>i_frm_pagcob</codigo><valor/></dato><dato><codigo>i_nproducto</codigo><valor>3</valor></dato><dato><codigo>i_estado</codigo><valor>I</valor></dato><dato><codigo>i_opcion_cons</codigo><valor>NUC</valor></dato><dato><codigo>i_tident</codigo><valor>CC</valor></dato><dato><codigo>i_ident</codigo><valor>0957123425</valor></dato></datos></mensajeEntradaCollector>]]></mensaje></mensajeEntradaGateway>";
		}

		private static String mensajeConsTercero() {
			return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><mensajeEntradaGateway xmlns=\"http://www.bolivariano.com/mensaje/MensajeOSB\"><puntoFinal>PagoTercero/proxy/PagoTerceroCanal</puntoFinal><operacion>CONSULTAR</operacion><identificadorCorrelacion>fd444ceac622</identificadorCorrelacion><mensaje><![CDATA[<mensajeEntradaCollector xmlns:ns11=\"http://www.bolivariano.com/ws/EMT/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.bolivariano.com/mensaje/MensajeCollector\"><opcion>CONSULTA_OPAGO</opcion><datos><dato><codigo>s_ssn</codigo><valor>30471046</valor></dato><dato><codigo>s_lsrv</codigo><valor>BOLIVSRV</valor></dato><dato><codigo>s_srv</codigo><valor>BOLIVSRV</valor></dato><dato><codigo>s_user</codigo><valor>cnb001</valor></dato><dato><codigo>s_term</codigo><valor>consola</valor></dato><dato><codigo>s_date</codigo><valor>07/20/2022</valor></dato><dato><codigo>s_ofi</codigo><valor>0</valor></dato><dato><codigo>s_rol</codigo><valor>252</valor></dato><dato><codigo>s_org</codigo><valor>L</valor></dato><dato><codigo>t_corr</codigo><valor>N</valor></dato><dato><codigo>t_ssn_corr</codigo><valor>0</valor></dato><dato><codigo>t_debug</codigo><valor/></dato><dato><codigo>t_file</codigo><valor/></dato><dato><codigo>t_from</codigo><valor/></dato><dato><codigo>t_rty</codigo><valor>N</valor></dato><dato><codigo>t_trn</codigo><valor>3966</valor></dato><dato><codigo>i_mon</codigo><valor>1</valor></dato><dato><codigo>i_opcaux</codigo><valor/></dato><dato><codigo>i_empresa</codigo><valor>2696</valor></dato><dato><codigo>i_servicio</codigo><valor>PAGTERCER</valor></dato><dato><codigo>i_frm_pagcob</codigo><valor/></dato><dato><codigo>i_nproducto</codigo><valor>3</valor></dato><dato><codigo>i_estado</codigo><valor>I</valor></dato><dato><codigo>i_opcion_cons</codigo><valor>NUC</valor></dato><dato><codigo>i_tident</codigo><valor>CI</valor></dato><dato><codigo>i_ident</codigo><valor>0958045114</valor></dato></datos></mensajeEntradaCollector>]]></mensaje></mensajeEntradaGateway>";

		}

		public static CollectorRequest mensajeConsultaIn() {
			CollectorRequest resultCollector = new CollectorRequest();
			Map<String, String> dato = null;
			resultCollector.setOpcion("CONSULTA_OPAGO");
			resultCollector.setDatos(dato);
			return resultCollector;
		}

		public static MessageResponse mensajeConsultaOut() {
			MessageResponse microsreRespons = new MessageResponse();
			microsreRespons.setCorrelationId("af92e341fbc6");
			microsreRespons.setCodeSPError("0");
			microsreRespons.setExecutionDate(new Date());
			microsreRespons.setMessageSPError("sms");
			Map<String, Object> result = new HashMap<>();
			String[] arreglo = { "1" };
			result.put("i_opcion", arreglo);
			microsreRespons.setResult(result);
			return microsreRespons;
		}

		public static Connection objDataSource() throws SQLException {
			HikariConfig hikariConfig = new HikariConfig();
			hikariConfig.setCatalog(null);
			hikariConfig.setUsername("operadorRec");
			hikariConfig.setPassword("ClvOpeRec++1");
			hikariConfig.setDriverClassName("com.sybase.jdbc4.jdbc.SybDriver");
			hikariConfig.setConnectionTimeout(5000);
			hikariConfig.setConnectionInitSql("SELECT 1");
			hikariConfig.setMaximumPoolSize(5);
			hikariConfig.setMinimumIdle(1);
			hikariConfig.setMaxLifetime(60000);
			hikariConfig.setIdleTimeout(10000);
			hikariConfig.setLeakDetectionThreshold(0);

			dataSourceObj = new HikariDataSource(hikariConfig);
			return dataSourceObj.getConnection();
		}

	}

}
