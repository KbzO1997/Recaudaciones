/************************************************************************/
/*    Archivo: 			pgbroadnetb.sp                                	*/
/*    Motor de Base: 	SYBASE                     						*/
/*    Base de datos: 	cob_pagos                                     	*/
/*    Servidor: 		HP-ACT                                      	*/
/*    Aplicacion: 		Cyberbank	                                	*/
/*    Stored procedure: pa_pag_i_concilia_broadnet_b                  	*/
/*    Procesamiento: 	OLTP	                                    	*/
/*    Ult.ControlTarea: J-RECM-641                          		    */
/*    Ult.Referencia:   REF 5                         			    	*/
/*    Disenado por: 	Danny Olaya S.                                	*/
/*    Fecha de escritura: 07/May/2019                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*    Este programa es parte de los paquetes bancarios propiedad del    */
/*    "BANCO BOLIVARIANO".                                              */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus usuarios  */
/*    sin el debido consentimiento por escrito de la Presidencia        */
/*    Ejecutiva del BANCO BOLIVARIANO o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/* Este proceso realiza la conciliacion de las recaudaciones del Broadnet  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/*   1  07/May/2019   Danny Olaya S.  RRCYT-4 (JIRA) - Emision Inicial  */
/*   2  03/Jun/2019   Danny Olaya S.  RRCYT-12 - Incorporar en */
/*      la consulta la tabla de Log ATM para mostrar recargas MOVISTAR  */
/*   3  25/08/2022  Kevin Bastidas	RECESABREC-124 TSERVI MOVISTAR CANALES DIGITALES*/
/*	 4	14/10/2022	Jonathan Guerrero 	RECM-634 CONCILIACION EN TSERVI MOVISTAR/TUENTI CANALES DIGITALES*/
/*	 5	24/10/2022	Kevin Bastidaz 	RECM-641 ERROR BATCH BROADNET pgccbroadnet*/
/************************************************************************/

use cob_pagos
go
if exists(select 1 from sysobjects where name = 'pa_pag_i_concilia_broadnet_b' and type = 'P')
begin
   drop procedure dbo.pa_pag_i_concilia_broadnet_b
   if exists (select 1 from sysobjects where name = 'pa_pag_i_concilia_broadnet_b' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pag_i_concilia_broadnet_b -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pag_i_concilia_broadnet_b *OK* =='
end
go

create procedure dbo.pa_pag_i_concilia_broadnet_b
(
   @e_fecha                datetime,
   @e_fecha1               smalldatetime = null
)

as

    --Conciliacion desde el batch
   select @e_fecha1 = @e_fecha

   --Cada que ingrese a hacer una conciliacion de Broadnet se borra la tabla: cob_pagos..pag_t_broadnet_servicio
   truncate table cob_pagos..pag_t_broadnet_servicio

   --Inserto todos los movimientos de las Transacciones de Horario Normal
   
   --ref002 Ini
   print "BUSCO LAS TRANSACCIONES DE LA TRAN_SERVICIO CNT Y TUENTI"
   
														
    if object_id('tempdb.dbo.#pg_tmp_cc_tran_servicio') is not null
        drop table #pg_tmp_cc_tran_servicio
		
	if object_id('tempdb.dbo.#pg_tmp_cc_tran_servicio_resp') is not null
       drop table #pg_tmp_cc_tran_servicio_resp
		
	if object_id('tempdb.dbo.#pg_tmp_cc_his_servicio') is not null
        drop table #pg_tmp_cc_his_servicio		
		
--<REF 4, Add Se crea Tabla Temporal para almacenar ts_ssn_corr RECM-634																		  
		CREATE TABLE #pg_tmp_cc_tran_servicio
		(
		  ts_ssn_corr int ,
		  ts_causa varchar (6),
		  ts_tipo_transaccion int		  
		)
		
		CREATE TABLE #pg_tmp_cc_tran_servicio_resp
		(
		  ts_ssn_corr int,
		  ts_causa varchar (6)	,
		  ts_tipo_transaccion int		  
		)
		
		CREATE TABLE #pg_tmp_cc_his_servicio
		(
		  hs_ssn_corr int, 
		  hs_causa varchar (6),
		  hs_tipo_transaccion int		  
		)		
	
		insert	into #pg_tmp_cc_tran_servicio (ts_ssn_corr,ts_causa,ts_tipo_transaccion)
		select ts_ssn_corr,ts_causa,ts_tipo_transaccion  from cob_cuentas..cc_tran_servicio
                            where ts_tipo_transaccion in (4060,4061,4062,4063,62686,62688,62687,62689,4014,4015)
                            and ts_tsfecha = @e_fecha
                            and ts_causa in ('8456','8457','19574','19575','103')
                            and ts_correccion = 'S'
		
		insert	into #pg_tmp_cc_tran_servicio_resp (ts_ssn_corr,ts_causa,ts_tipo_transaccion)		
		select ts_ssn_corr,ts_causa,ts_tipo_transaccion from cob_cuentas..cc_tran_servicio_resp
                           where ts_tipo_transaccion in (4060,4061,4062,4063,62686,62688,62687,62689,4014,4015)
                           and ts_tsfecha = @e_fecha
                           and ts_causa in ('8456','8457','19574','19575','103')
                           and ts_correccion = 'S'
						   
		insert	into #pg_tmp_cc_his_servicio (hs_ssn_corr,hs_causa,hs_tipo_transaccion)				   
		select hs_ssn_corr, hs_causa,hs_tipo_transaccion from cob_cuentas_his..cc_his_servicio
                           where hs_tsfecha = @e_fecha1              
                           and hs_tipo_transaccion in (4060,4061,4062,4063,62686,62688,62687,62689,4014,4015)
                           and hs_causa in ('8456','8457','19574','19575','103')
                           and hs_correccion = 'S'		
		--REF 4, Add Se crea Tabla Temporal para almacenar ts_ssn_corr>
		
   if exists(select 1 from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (4060,4061,4062,4063, 62686, 62688,62689, 62687) --Ref3 KBastida  --trx 62688 62686 62689, 62687
   and ts_tsfecha = @e_fecha 
   and ts_causa in ('8456','8457','19574','19575'))  --Ref3 KBastida  --causa 19575 19574
   begin
      --Tomo los datos de la tran_servicio
      print "TOMANDO DATOS DE TRAN_SERVICIO CNT Y TUENTI"

      insert cob_pagos..pag_t_broadnet_servicio
      select 
      'br_codigo'           = a.ts_referencia,        -- Número de celular                                   
      'br_valor'            = (isnull(a.ts_saldo,0) + isnull(a.ts_monto,0) + isnull(a.ts_valor,0)),                         
      'br_fec_cble'         = a.ts_tsfecha,--Fecha contable
      'br_fec_proceso'      = a.ts_tsfecha,--Fecha proceso
      'br_sec_bco'          = a.ts_secuencial,--Secuencial del Banco
      'br_num_ref'          = right(convert(varchar,a.ts_secuencial),6),--Secuencial de Broadnet
      'br_fecha_trx_local'  = a.ts_corresponsal,                                     --Fecha Transaccion Local
      'br_hora_trx_local'   = substring(convert(varchar(8),a.ts_hora,108),1,2) +
                           substring(convert(varchar(8),a.ts_hora,108),4,2) +
                           substring(convert(varchar(8),a.ts_hora,108),7,2),      --Hora Transaccion Local
      'br_est_conciliacion' = "",                                                  --Estado Conciliacion
      'br_usuario'          = a.ts_usuario,
      'br_nombre'     = a.ts_nombre,
      'br_tip_trx'    = a.ts_tipo_transaccion  ,
      'br_cta_bco'    = a.ts_cta_banco ,
      'br_monto_cta'  = a.ts_monto,
      'br_tipo_cta'   = a.ts_tipocta,
      'br_canal'      = a.ts_tipo_chequera,
	  'br_empresa'    = a.ts_causa,
	  'br_autoriz'    = a.ts_propietario
      from cob_cuentas..cc_tran_servicio a
	  left join #pg_tmp_cc_tran_servicio b ON a.ts_secuencial = b.ts_ssn_corr /*<REF 4>*/
      where a.ts_tipo_transaccion in (4060,4061,4062,4063,62686,62688,62687,62689)  --Ref3 KBastida  --trx 62688-62686 62687,62689
      and a.ts_tsfecha = @e_fecha
      and a.ts_causa in ('8456','8457','19574','19575') --Ref3 KBastida  --causa 19574-19575
	  and a.ts_correccion = 'N'
      and b.ts_ssn_corr is null	/*<REF 4>*/
		if @@error <> 0
		begin
			return 1
		end
   end
   else
   begin
      print "Busco datos en tran_servicio_resp CNT Y TUENTI"
      if exists(select 1 from cob_cuentas..cc_tran_servicio_resp
      where ts_tipo_transaccion in (4060,4061,4062,4063, 62686,62688,62687,62689)  --Ref3 KBastida  --trx 62688-62686
      and ts_tsfecha = @e_fecha
      and ts_causa in ('8456','8457','19574','19575'))  --Ref3 KBastida  --causa 19574-19575

      begin
         --Tomo los datos de la cc_tran_servicio_resp

         print "TOMANDO DATOS DE TRAN_SERVICIO_RESP CNT Y TUENTI"

         insert cob_pagos..pag_t_broadnet_servicio
         select 
        'br_codigo'           = a.ts_referencia,                                          
        'br_valor'            = (isnull(a.ts_saldo,0) + isnull(a.ts_monto,0) + isnull(a.ts_valor,0)),                      
        'br_fec_cble'         = a.ts_tsfecha,--Fecha contable
        'br_fec_proceso'      = a.ts_tsfecha,--Fecha proceso
        'br_sec_bco'          = a.ts_secuencial,--secuencial del banco
        'br_num_ref'          = right(convert(varchar,a.ts_secuencial),6),--secuencial de Broadnet
        'br_fecha_trx_local'  = a.ts_corresponsal,--Fecha Transaccion Local
        'br_hora_trx_local'   = substring(convert(varchar(8),a.ts_hora,108),1,2) +
                           substring(convert(varchar(8),a.ts_hora,108),4,2) +
                           substring(convert(varchar(8),a.ts_hora,108),7,2), --Hora Transaccion Local
        'br_est_conciliacion' = "",--Estado Conciliacion
        'br_usuario'          = a.ts_usuario,
        'br_nombre'     = a.ts_nombre,
        'br_tip_trx'    = a.ts_tipo_transaccion, 
        'br_cta_bco'    = a.ts_cta_banco ,
        'br_monto_cta'  = a.ts_monto ,
        'br_tipo_cta'   = a.ts_tipocta ,
        'br_canal'      = a.ts_tipo_chequera,
		'br_empresa'    = a.ts_causa,
		'br_autoriz'    = a.ts_propietario
		from cob_cuentas..cc_tran_servicio_resp	a	
		left join #pg_tmp_cc_tran_servicio_resp b ON a.ts_secuencial = b.ts_ssn_corr	/*<REF 4>*/	
		where a.ts_tipo_transaccion in (4060,4061,4062,4063,62686,62688,62687,62689)  --Ref3 KBastida  --trx 62688-62686
		and a.ts_tsfecha = @e_fecha
		and a.ts_causa in ('8456','8457','19574','19575')  --Ref3 KBastida  --causa 19574-19575
		and a.ts_correccion = 'N'
		and b.ts_ssn_corr is null	/*<REF 4>*/			   
			if @@error <> 0
			begin
				return 1
			end
		end
      else
      begin
         print "Busco datos en cc_his_servicio CNT Y TUENTI"
         if exists(select 1 from cob_cuentas_his..cc_his_servicio
         where hs_tsfecha = @e_fecha1    
         and hs_tipo_transaccion in (4060,4061,4062,4063,  62686,62688,62687,62689)  --Ref3 KBastida  --trx 62688-62686
         and hs_causa in ('8456','8457','19574','19575'))  --Ref3 KBastida  --causa 19574-19575
         begin
            --Tomo los datos de la cc_his_servicio
            print "TOMANDO DATOS DE HIS_SERVICIO CNT Y TUENTI"
            
            insert cob_pagos..pag_t_broadnet_servicio
            select 
          'br_codigo'          =  a.hs_referencia,
          'br_valor'            = (isnull(a.hs_saldo,0) + isnull(a.hs_monto,0) + isnull(a.hs_valor,0)),                         
          'br_fec_cble'         = a.hs_tsfecha,--Fecha contable
          'br_fec_proceso'      = a.hs_tsfecha,--Fecha proceso
          'br_sec_bco'          = a.hs_secuencial,--secuencial del banco
          'br_num_ref'          = right(convert(varchar,a.hs_secuencial),6),--secuencial de Broadnet
          'br_fecha_trx_local'  = a.hs_corresponsal,--Fecha Transaccion Local
          'br_hora_trx_local'   = substring(convert(varchar(8),a.hs_hora,108),1,2) +
                           substring(convert(varchar(8),a.hs_hora,108),4,2) +
                           substring(convert(varchar(8),a.hs_hora,108),7,2),      --Hora Transaccion Local
          'br_est_conciliacion' = "",--Estado Conciliacion
          'br_usuario'          = a.hs_usuario,
          'br_nombre'     = a.hs_nombre,
          'br_tip_trx'    = a.hs_tipo_transaccion  ,
          'br_cta_bco'    = a.hs_cta_banco ,
          'br_monto_cta'  = a.hs_monto ,
          'br_tipo_cta'   = a.hs_tipocta ,
          'br_canal'      = a.hs_tipo_chequera,
		  'br_empresa'	  = a.hs_causa,
		  'br_autoriz'    = a.hs_propietario
			from cob_cuentas_his..cc_his_servicio a
			left join #pg_tmp_cc_his_servicio b ON a.hs_secuencial = b.hs_ssn_corr /*<REF 4>*/
			where a.hs_tipo_transaccion in (4060,4061,4062,4063,  62686,62688,62687,62689)  --Ref3 KBastida  --trx 62688-62686
			and a.hs_tsfecha = @e_fecha1          
			and a.hs_causa in ('8456','8457','19574','19575')  --Ref3 KBastida  --causa 19574-19575
			and a.hs_correccion = 'N'
			and b.hs_ssn_corr is null	/*<REF 4>*/						
				if @@error <> 0
				begin
					return 1
				end
			end
		end

   end 
   
   --Inserto todos los movimientos de las Transacciones de Horario Normal
   print "BUSCO LAS TRANSACCIONES DE LA TRAN_SERVICIO MOVISTAR"

   if exists(select 1 from cob_cuentas..cc_tran_servicio
   where ts_tipo_transaccion in (4014,4015, 62688,62689)  --Ref3 KBastida  --trx 62688 62689
   and ts_tsfecha = @e_fecha 
   and ts_causa in ('103', '19574'))   --Ref3 KBastida  --causa 19574

   begin

      --Tomo los datos de la tran_servicio
      print "TOMANDO DATOS DE TRAN_SERVICIO MOVISTAR"

      insert cob_pagos..pag_t_broadnet_servicio
      select
      'br_codigo'           = a.ts_referencia,        -- Número de celular                                   
      'br_valor'            = (isnull(a.ts_saldo,0) + isnull(a.ts_monto,0) + isnull(a.ts_valor,0)),                         
      'br_fec_cble'         = a.ts_tsfecha,--Fecha contable
      'br_fec_proceso'      = a.ts_tsfecha,--Fecha proceso
      'br_sec_bco'          = hl_sec_host,--Secuencial del Banco
      'br_num_ref'          = right(convert(varchar,hl_autorizacion),6),--Secuencial de Broadnet
      'br_fecha_trx_local'  = a.ts_corresponsal,                                     --Fecha Transaccion Local
      'br_hora_trx_local'   = substring(convert(varchar(8),a.ts_hora,108),1,2) +
                           substring(convert(varchar(8),a.ts_hora,108),4,2) +
                           substring(convert(varchar(8),a.ts_hora,108),7,2),      --Hora Transaccion Local
      'br_est_conciliacion' = "",                                                  --Estado Conciliacion
      'br_usuario'          = a.ts_usuario,
      'br_nombre'     = a.ts_nombre,
      'br_tip_trx'    = a.ts_tipo_transaccion  ,
      'br_cta_bco'    = a.ts_cta_banco ,
      'br_monto_cta'  = a.ts_monto,
      'br_tipo_cta'   = a.ts_tipocta,
      'br_canal'      = a.ts_tipo_chequera,
	  'br_empresa'    = a.ts_causa,
	  'br_autoriz'    = a.ts_propietario
	from 
	cob_cuentas..cc_tran_servicio a inner join cob_atm..at_his_log_autoriza
	on ts_secuencial = hl_sec_host		
	and a.ts_tsfecha = hl_fecha_hora
	and a.ts_tipo_transaccion in (4014,4015, 62688,62689)  --Ref3 KBastida  --trx 62688 62689
	and a.ts_tsfecha = @e_fecha
	and hl_empresa = 1342
	and a.ts_causa in ('103','19574') --Ref3 KBastida  --causa 19574
	and a.ts_correccion = 'N'
	left join #pg_tmp_cc_tran_servicio b ON a.ts_secuencial = b.ts_ssn_corr /*<REF 4>*/
	and b.ts_ssn_corr is null	/*<REF 4>*/
	
							   
		if @@error <> 0
		begin
			return 1
		end
   end
   else
   begin
      print "Busco datos en tran_servicio_resp MOVISTAR"
      if exists(select 1 from cob_cuentas..cc_tran_servicio_resp
      where ts_tipo_transaccion in (4014,4015, 62688,62689)  --Ref3 KBastida  --trx 62688 62689
      and ts_tsfecha = @e_fecha
      and ts_causa in ('103', '19574'))   --Ref3 KBastida  --causa 19574

      begin
         --Tomo los datos de la cc_tran_servicio_resp

         print "TOMANDO DATOS DE TRAN_SERVICIO_RESP MOVISTAR"

         insert cob_pagos..pag_t_broadnet_servicio
         select
		'br_codigo'           = a.ts_referencia,        -- Número de celular                                   
		'br_valor'            = (isnull(a.ts_saldo,0) + isnull(a.ts_monto,0) + isnull(a.ts_valor,0)),                         
		'br_fec_cble'         = a.ts_tsfecha,--Fecha contable
		'br_fec_proceso'      = a.ts_tsfecha,--Fecha proceso
		'br_sec_bco'          = hl_sec_host,--Secuencial del Banco
		'br_num_ref'          = right(convert(varchar,hl_autorizacion),6),--Secuencial de Broadnet
		'br_fecha_trx_local'  = a.ts_corresponsal,                                     --Fecha Transaccion Local
		'br_hora_trx_local'   = substring(convert(varchar(8),a.ts_hora,108),1,2) +
                           substring(convert(varchar(8),a.ts_hora,108),4,2) +
                           substring(convert(varchar(8),a.ts_hora,108),7,2),      --Hora Transaccion Local
		'br_est_conciliacion' = "",                                                  --Estado Conciliacion
		'br_usuario'          = a.ts_usuario,
		'br_nombre'     = a.ts_nombre,
		'br_tip_trx'    = a.ts_tipo_transaccion  ,
		'br_cta_bco'    = a.ts_cta_banco ,
		'br_monto_cta'  = a.ts_monto,
		'br_tipo_cta'   = a.ts_tipocta,
		'br_canal'      = a.ts_tipo_chequera,
		'br_empresa'    = a.ts_causa,
		'br_autoriz'    = a.ts_propietario
		from 
		cob_cuentas..cc_tran_servicio_resp a inner join cob_atm..at_his_log_autoriza
		on ts_secuencial = hl_sec_host		
		and a.ts_tsfecha = hl_fecha_hora
		and a.ts_tipo_transaccion in (4014,4015, 62688,62689)  --Ref3 KBastida  --trx 62688 62689
		and a.ts_tsfecha = @e_fecha
		and hl_empresa = 1342
		and a.ts_causa in ('103','19574')  --Ref3 KBastida  --causa 19574
		and a.ts_correccion = 'N'		
		left join #pg_tmp_cc_tran_servicio_resp b ON a.ts_secuencial = b.ts_ssn_corr 	
		and b.ts_causa in ('103','19574')/*<REF 5>*/
		and b.ts_ssn_corr is null	/*<REF 4>*/	
		
			   
			if @@error <> 0
			begin
				return 1
			end
		end
        else
        begin
			 print "Busco datos en cc_his_servicio MOVISTAR"
			 if exists(select 1 from cob_cuentas_his..cc_his_servicio
			 where hs_tsfecha = @e_fecha1    
			 and hs_tipo_transaccion in (4060,4061,4062,4063,62688,62689)  --Ref3 KBastida  --trx 62688-62686
			 and hs_causa in ('8456','8457','19574'))  --Ref3 KBastida  --causa 19574-19575

			begin
					--Tomo los datos de la cc_his_servicio
					print "TOMANDO DATOS DE HIS_SERVICIO MOVISTAR"
					
					insert cob_pagos..pag_t_broadnet_servicio
					select
					'br_codigo'           = a.hs_referencia,        -- Número de celular                                   
					'br_valor'            = (isnull(hs_saldo,0) + isnull(a.hs_monto,0) + isnull(a.hs_valor,0)),                         
					'br_fec_cble'         = a.hs_tsfecha,--Fecha contable
					'br_fec_proceso'      = a.hs_tsfecha,--Fecha proceso
					'br_sec_bco'          = hl_sec_host,--Secuencial del Banco
					'br_num_ref'          = right(convert(varchar,hl_autorizacion),6),--Secuencial de Broadnet
					'br_fecha_trx_local'  = a.hs_corresponsal,                                     --Fecha Transaccion Local
					'br_hora_trx_local'   = substring(convert(varchar(8),a.hs_hora,108),1,2) +
											substring(convert(varchar(8),a.hs_hora,108),4,2) +
											substring(convert(varchar(8),a.hs_hora,108),7,2),      --Hora Transaccion Local
					'br_est_conciliacion' = "",                                                  --Estado Conciliacion
					'br_usuario'          = a.hs_usuario,
					'br_nombre'     = a.hs_nombre,
					'br_tip_trx'    = a.hs_tipo_transaccion  ,
					'br_cta_bco'    = a.hs_cta_banco ,
					'br_monto_cta'  = a.hs_monto,
					'br_tipo_cta'   = a.hs_tipocta,
					'br_canal'      = a.hs_tipo_chequera,
					'br_empresa'    = a.hs_causa,
					'br_autoriz'    = a.hs_propietario
				from 
				cob_cuentas_his..cc_his_servicio a inner join cob_atm..at_his_log_autoriza
				on a.hs_secuencial = hl_sec_host
				and a.hs_tsfecha = hl_fecha_hora
				and a.hs_tipo_transaccion in (4014,4015, 62688,62689)  --Ref3 KBastida  --trx 62688 62689
				and a.hs_tsfecha = @e_fecha
				and hl_empresa = 1342
				and a.hs_causa in ('103','19574') --Ref3 KBastida  --causa 19574
				and a.hs_correccion = 'N'				
				left join #pg_tmp_cc_his_servicio b ON a.hs_secuencial = b.hs_ssn_corr /*<REF 4>*/
				and b.hs_ssn_corr is null	/*<REF 4>*/
				
											
					if @@error <> 0
					begin
						return 1
					end
			  end
		end
   end --ref002 Fin

return 0
go
if exists(select 1 from sysobjects where name='pa_pag_i_concilia_broadnet_b' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pag_i_concilia_broadnet_b *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pag_i_concilia_broadnet_b -- ERROR -- >>>'
go
