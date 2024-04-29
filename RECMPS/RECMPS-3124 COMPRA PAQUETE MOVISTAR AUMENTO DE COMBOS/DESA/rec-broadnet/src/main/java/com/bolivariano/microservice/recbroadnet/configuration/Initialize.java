package com.bolivariano.microservice.recbroadnet.configuration;
import com.bolivariano.microservice.recbroadnet.service.ProcessorService;
import io.quarkus.runtime.ShutdownEvent;

import javax.enterprise.event.Observes;
import javax.inject.Inject;

import org.jboss.logging.Logger;

import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.enterprise.context.ApplicationScoped;

	@ApplicationScoped
	public class Initialize implements Runnable{

	    @Inject
	    ProcessorService processorService;
	    
	    @Inject
		Logger log;

	    private ExecutorService scheduler;

	    void onStart() {
	        scheduler = Executors.newFixedThreadPool(1);
	        scheduler.submit(this);
	    }

	    void onStop(@Observes ShutdownEvent event) {
	    	log.info(event);
	        scheduler.shutdown();
	    }

	    @Override
	    public void run() {
	        try {
	            String messageMQ = "{\"tipoFlujo\":\"CONSULTA\",\"mensajeEntradaConsultarDeuda\":{\"canal\":\"S\",\"depuracion\":\"N\",\"fecha\":\"2023-06-09T00:00:00\",\"oficina\":\"0\",\"secuencial\":\"133620346\",\"servicio\":{\"codTipoServicio\":\"TELEFONIA_CELULAR\",\"codigoConvenio\":\"19574\",\"codigoEmpresa\":\"19574\",\"codigoTipoBanca\":\"BP\",\"codigoTipoIdentificador\":\"CELULAR\",\"datosAdicionales\":{\"datoAdicional\":[{\"codigo\":\"e_prov_req\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"MS_REC_BROADNET_REQ\",\"visible\":null},{\"codigo\":\"e_prov_resp\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"MS_REC_BROADNET_RESP\",\"visible\":null},{\"codigo\":\"e_srv\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"BOLIVSRV\",\"visible\":null},{\"codigo\":\"e_term\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"term24\",\"visible\":null},{\"codigo\":\"e_rol\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"5\",\"visible\":null},{\"codigo\":\"e_corr\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"N\",\"visible\":null},{\"codigo\":\"e_ssn_corr\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_mon\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"1\",\"visible\":null},{\"codigo\":\"e_servicio\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"e_identificacion\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"e_efectivo\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_cheque\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_debito\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_tarjeta\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_comision_efe\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_comision_chq\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_comision_db\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_total\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_tipo_cta\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"e_cuenta\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"e_autoriza\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"N\",\"visible\":null},{\"codigo\":\"e_ubi\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"e_opcion\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"C\",\"visible\":null},{\"codigo\":\"e_reverso\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"e_emp_nombre\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"\",\"visible\":null},{\"codigo\":\"vp_s_fecha_contable\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_ssn\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"133620346\",\"visible\":null},{\"codigo\":\"vp_s_comision\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"0\",\"visible\":null},{\"codigo\":\"vp_s_tasa\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_base_imp\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_impuesto\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_empresa\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"BROADNET S.A. (MOVISTAR)\",\"visible\":null},{\"codigo\":\"vp_s_recaudacion\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"LINEA   \",\"visible\":null},{\"codigo\":\"vp_s_referencia1\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_referencia2\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"vp_s_referencia3\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":null,\"visible\":null},{\"codigo\":\"e_prov_req\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"MS_REC_BROADNET_REQ\",\"visible\":null},{\"codigo\":\"e_prov_resp\",\"etiqueta\":null,\"editable\":null,\"formato\":null,\"listasSeleccion\":null,\"longitud\":null,\"mascara\":null,\"regexp\":null,\"tipo\":null,\"valor\":\"MS_REC_BROADNET_RESP\",\"visible\":null}]},\"identificador\":\"0999999999\"},\"transaccion\":\"2057\",\"usuario\":\"TcUPI1396206\"}}";
	            String userId = UUID.randomUUID().toString().replace("-", "").substring(0, 12);
	            processorService.processMessage(messageMQ, userId);
	        } catch (Exception ignored) {
	        	log.info(ignored);
	        }finally {
	            scheduler.shutdown();
	        }
	    }

}
