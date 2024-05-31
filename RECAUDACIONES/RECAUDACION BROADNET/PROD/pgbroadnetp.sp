use cob_pagos
go
if exists(select 1 from sysobjects where name = 'pa_pag_a_concilia_broadnet_p' and type = 'P')
begin
     drop procedure dbo.pa_pag_a_concilia_broadnet_p
	 if exists (select 1 from sysobjects where name = 'pa_pag_a_concilia_broadnet_p' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pag_a_concilia_broadnet_p -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pag_a_concilia_broadnet_p *OK* =='
end
go
/************************************************************************/
/*  Archivo: pgbroadnetp.sp                                             */
/*  Stored procedure:   pa_pag_a_concilia_broadnet_p                    */
/*  Motor de Base: 		SYBASE                     					    */
/*  Servidor: 			   HP-ACT                                       */
/*  Procesamiento: 		OLTP	                                       	*/
/*  Ult.ControlTarea:   J-RECESABREC-36                         		*/
/*  Ult.Referencia:     REF 7                          			    	*/
/*  Stored procedure:   pa_pag_a_concilia_broadnet_p                	*/
/*  Aplicacion: 		   Cyberbank	                                */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas de pagos                                */
/*  Disenado por:       Danny Olaya S.                                  */
/*  Fecha de escritura: 02/Mayo/2019                                    */
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
/*  Este proceso realiza la conciliacion de las recaudaciones de Broadnet */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/* 1  02/May/2019   Danny Olaya S.  RRCYT-4 (JIRA)   Emision Inicial    */
/* 2  06/Jun/2019   Danny Olaya S.  RECA-CE-SGC00035614  Ajustes Recargas CNT y TUENTI*/
/* 3  17/Sep/2019   Danny Olaya S.  RECA-CE-SGC00036624  Ajuste Recargas en BANCO NO - PROVEEDOR SI*/
/* 4  18/Abr/2022   Kevin Bastidas  RECM-321 COMPLEMENTAR INFORMACION PARA RECARGAS MOVISTAR TWENTI Y CNT*/
/* 5  25/08/2022  Kevin Bastidas	RECESABREC-124 TSERVI MOVISTAR CANALES DIGITALES*/
/* 6  17/10/2022  Jonathan Guerrero	RECM-634	CONCILIACION EN TSERVI MOVISTAR/TUENTI CANALES DIGITALES*/
/* 7  18/10/2022  Kevin Bastidas	RECESABREC-36 CONSULTA Y PAGO ATX MOVISTAR COMPRA DE PAQUETES*/
/************************************************************************/

create procedure dbo.pa_pag_a_concilia_broadnet_p
(
   @e_fecha                varchar(10)
)

as


--Conciliacion desde el batch

	--<REF 6, Ini Crear Tabla obtener la Info por estado co_resultado = 'IE' co_estatus_bco = 'NO' co_estatus_emp_serv = 'SI'
    if object_id('tempdb.dbo.#pg_tmp_integar_informacion') is not null
        drop table #pg_tmp_integar_informacion 

    CREATE TABLE #pg_tmp_integar_informacion
    (
      ts_secuencial int,
      ts_referencia varchar(15) null,
      ts_usuario varchar(64) null,
      ts_tipo_chequera varchar(6) null,
      ts_tipo_transaccion int,
      ts_tsfecha smalldatetime,
      ts_tipocta char(1) null, /*<REF 7, SE AGREGA QUE ACEPTE NULL REF 7>*/
	  ts_cta_banco varchar(24) null,
	  ts_monto money
    )

    insert	into #pg_tmp_integar_informacion (ts_secuencial, ts_referencia,ts_usuario,ts_tipo_chequera,ts_tipo_transaccion,ts_tsfecha,ts_tipocta,ts_cta_banco,ts_monto)
    select ts_secuencial, ts_referencia,ts_usuario,ts_tipo_chequera,ts_tipo_transaccion,ts_tsfecha,ts_tipocta,ts_cta_banco,ts_monto  from  cob_cuentas..cc_tran_servicio
    where ts_correccion = 'N'
    and ts_causa in ('19574','19575') and ts_tsfecha =  @e_fecha
    union all
    select ts_secuencial, ts_referencia,ts_usuario,ts_tipo_chequera,ts_tipo_transaccion,ts_tsfecha,ts_tipocta,ts_cta_banco,ts_monto  from cob_cuentas..cc_tran_servicio_resp
    where ts_correccion = 'N'
    and ts_causa in ('19574','19575') and ts_tsfecha =  @e_fecha
    union all
    select hs_secuencial, hs_referencia,hs_usuario,hs_tipo_chequera,hs_tipo_transaccion,hs_tsfecha,hs_tipocta,hs_cta_banco,hs_monto  from  cob_cuentas_his..cc_his_servicio
    where hs_correccion = 'N'
    and hs_causa in ('19574','19575') and hs_tsfecha =  @e_fecha
    --REF 6, Fin Crear Tabla obtener la Info>


    --Identifico los pagos que estan en el archivo de BROADNET y los que estan en el Banco,

  if object_id('tempdb.dbo.#pg_tmp_auxiliar_recarga') is not null
        drop table #pg_tmp_auxiliar_recarga 

    --select ar.ar_celular, ar.ar_usuario, ar.ar_tipo_trx, ar.ai_tipo_cuenta, ar.ai_cuenta, ar.ai_debito, hl.hl_autorizacion, ar.ar_fec_proceso, ar.ar_canal
	  --into #pg_tmp_auxiliar_recarga
    CREATE TABLE #pg_tmp_auxiliar_recarga
    (
      ar_celular varchar(10) null,
      ar_usuario varchar(15) null,
      ar_tipo_trx INT null,
      ai_tipo_cuenta varchar(4)null,
      ai_cuenta varchar(20) null,
      ai_debito money null,
      hl_autorizacion varchar(6) null,
      ar_fec_proceso datetime null,
      ar_canal varchar(5) null
    )
    insert	into #pg_tmp_auxiliar_recarga (ar_celular ,ar_usuario ,ar_tipo_trx ,ai_tipo_cuenta ,ai_cuenta ,ai_debito ,hl_autorizacion ,ar_fec_proceso ,ar_canal )
    select ar.ar_celular, ar.ar_usuario, ar.ar_tipo_trx, ar.ai_tipo_cuenta, ar.ai_cuenta, ar.ai_debito, hl.hl_autorizacion, ar.ar_fec_proceso, ar.ar_canal
    from cob_pagos..cc_l_auxiliar_recarga ar
      inner join cob_atm..at_his_log_autoriza hl on
      hl.hl_tsfecha =  @e_fecha and ar.ar_secuencial = hl.hl_recibo and hl.hl_reverso = 'S'
    where ar.ar_fec_proceso =  @e_fecha

 begin tran	
	
  update cob_pagos..pag_t_concilia_broadnet
  set
  co_resultado          = "OK",
  co_estatus_bco        = "SI",
  co_estatus_emp_serv   = "SI",
  co_autoriz_bco		= br_sec_bco,
  co_num_ref			= br_num_ref,
  co_hora_trn_local     = br_hora_trx_local,
  co_usuario            = br_usuario,
  co_tip_trx            = br_tip_trx,
  co_nombre             = br_nombre  ,
  co_celular            = br_codigo,
  co_debito             = br_monto_cta,
  co_nro_cuenta         = br_cta_bco,
  co_tipo_cuenta        = br_tipo_cta,
  co_canal              = br_canal,
  co_fecha_real         = getdate()
  from cob_pagos..pag_t_concilia_broadnet
  inner join cob_pagos..pag_t_broadnet_servicio on 
          br_valor=co_valor 
    and  br_num_ref=co_num_ref
    and  br_fec_proceso=co_fec_cble
  where co_fec_cble = @e_fecha
  
  if @@error <> 0
  begin
    rollback tran
    return 1
  end

  --Actualizo los registros conciliados en la Tabla pag_t_broadnet_servicio

  update cob_pagos..pag_t_broadnet_servicio
  set br_est_conciliacion = 'S'
  from cob_pagos..pag_t_broadnet_servicio
  inner join cob_pagos..pag_t_concilia_broadnet on 
    co_valor     = br_valor
    and co_num_ref       = br_num_ref
    and co_fec_cble  = br_fec_proceso
  where br_fec_proceso  = @e_fecha
  
  if @@error <> 0
  begin
    rollback tran
    return 1
  end

   --Los registros restantes que no han sido conciliados con estado exitoso se actualizaran a Banco:NO, Broadnet:SI

  update cob_pagos..pag_t_concilia_broadnet 
  set
  co_resultado = "IE",
  co_estatus_bco = "NO",
  co_estatus_emp_serv = "SI",
  co_hora_trn_local = '000000',
  --ref003 Ini
  co_autoriz_bco = convert(int,isnull(co_num_autoriz,'1'))
  --ref003 Fin
  where co_fec_cble  = @e_fecha
  and co_resultado is null

  --RECM-321 Ini KBastida   
  --se crea tabla temporal pag_t_concilia_broadnet para poder vincular las tablas:  pag_t_concilia_broadnet  pg_tmp_auxiliar_recarga
  --y generar el macth con la tabla: pag_t_concilia_broadnet
      update cob_pagos..pag_t_concilia_broadnet 
      set co_celular  = tmp.ar_celular,
      co_usuario      = tmp.ar_usuario,
      co_tip_trx      = tmp.ar_tipo_trx,
      co_tipo_cuenta  = substring(tmp.ai_tipo_cuenta,1,1),
      co_nro_cuenta   = tmp.ai_cuenta,
      co_debito       =  tmp.ai_debito,
      co_canal        = tmp.ar_canal
      from  cob_pagos..pag_t_concilia_broadnet  c
      inner join #pg_tmp_auxiliar_recarga  tmp on
      c.co_num_ref = tmp.hl_autorizacion
      and  tmp.ar_fec_proceso = @e_fecha      
      where 
         co_fec_cble        = @e_fecha
         and co_resultado   = "IE"
         and co_estatus_bco = "NO"
         and co_estatus_emp_serv = "SI"
         and co_empresa     = '103'
           
  --RECM-321 Ini KBastida 

  --RECM-321 Ini KBastida CMT - TWENTI
      
      update cob_pagos..pag_t_concilia_broadnet 
      set co_celular = ar.ar_celular,
      co_usuario = ar.ar_usuario,
      co_tip_trx = ar.ar_tipo_trx,
      co_tipo_cuenta = substring(ar.ai_tipo_cuenta,1,1),
      co_nro_cuenta = ar.ai_cuenta,
      co_debito =  ar.ai_debito,
      co_canal = ar.ar_canal
      from  cob_pagos..pag_t_concilia_broadnet  inner join cob_pagos..cc_l_auxiliar_recarga ar on
      ar.ar_fec_proceso = @e_fecha and co_valor = ar.ai_debito and 
      RIGHT(convert(varchar(15),ar.ar_secuencial), 6) = co_num_ref 
      where 
         co_fec_cble  = @e_fecha
         and co_resultado = "IE"
         and co_estatus_bco = "NO"
         and co_estatus_emp_serv = "SI"
         and co_empresa != '103'     
  --RECM-321 Ini KBastida
  
  --Ref5 KBastidz Compra Paquete Tuenti-Mov INI
   update cob_pagos..pag_t_concilia_broadnet 
      set 
      co_num_autoriz  = tmp.br_autoriz,
      co_celular      = tmp.br_codigo,
      co_usuario      = tmp.br_usuario ,
      co_tip_trx      = tmp.br_tip_trx,
      co_tipo_cuenta  = substring(tmp.br_tipo_cta,1,1),
      co_nro_cuenta   = tmp.br_cta_bco,
      co_debito       = tmp.br_valor,
      co_canal        = tmp.br_canal
      from  cob_pagos..pag_t_concilia_broadnet  c
      inner join cob_pagos..pag_t_broadnet_servicio tmp 
		on  c.co_num_ref = tmp.br_num_ref
		and tmp.br_fec_proceso = @e_fecha      
      where 
         co_fec_cble        = @e_fecha
         and co_resultado   = "IE"
         and co_estatus_bco = "NO"
         and co_estatus_emp_serv = "SI"
         --and co_empresa     = '19574'
         --and co_empresa     = '19575'
  --Ref5 KBastidz Compra Paquete Tuenti-Mov FIN

	if @@error <> 0
	begin
		rollback tran
		return 1
	end

    --Obtiene las transacciones realizadas por efectivo o cheque
    insert cob_pagos..pag_t_concilia_broadnet
    (co_num_ref,co_autoriz_bco,co_valor             ,co_fec_cble      ,co_fecha_trx , co_nro_cuenta,co_canal,co_num_bin,
     co_resultado ,co_estatus_bco ,co_estatus_emp_serv  ,co_usuario       ,co_celular   , co_debito    ,co_fecha_real,
     co_hora_trn_local  ,co_nombre    ,co_tip_trx     ,co_forma_pago        ,co_fecha_archivo ,co_tipo_cuenta,co_empresa)  
    select  
     br_num_ref, br_sec_bco,br_valor                ,br_fec_cble         ,br_fec_proceso  , br_cta_bco      ,br_canal, 
	 case br_empresa when '103' then  827623
	                            when '8456' then 827624
                              when '19574' then 827828 --Ref5 KBastida  --trx Servicio 827828
                              when '19575' then 827859 --Ref5 KBastida  --trx Servicio 827859
                              else 827688 end,
     'BO'         ,'SI'           ,'NO'                 ,br_usuario          ,br_codigo       , br_monto_cta    ,getdate(), --ref002
     br_hora_trx_local     ,br_nombre       ,br_tip_trx        ,'OTROS'              ,@e_fecha         ,br_tipo_cta, br_empresa
    from cob_pagos..pag_t_broadnet_servicio
    where br_fec_proceso  = @e_fecha and br_est_conciliacion <> 'S'
    and br_cta_bco is null 
    and br_monto_cta = 0
	
	if @@error <> 0
	begin
		rollback tran
		return 1
	end
    
    --Obtiene las transacciones realizadas por nota de debito
    insert cob_pagos..pag_t_concilia_broadnet
    (co_num_ref,co_autoriz_bco,co_valor             ,co_fec_cble      ,co_fecha_trx , co_nro_cuenta,co_canal, co_num_bin,
     co_resultado ,co_estatus_bco ,co_estatus_emp_serv  ,co_usuario       ,co_celular   , co_debito    ,co_fecha_real, 
     co_hora_trn_local  ,co_nombre    ,co_tip_trx     ,co_forma_pago        ,co_fecha_archivo ,co_tipo_cuenta, co_empresa)  
    select  
     br_num_ref,br_sec_bco,br_valor                ,br_fec_cble         ,br_fec_proceso  , br_cta_bco      ,br_canal,
	 	 case br_empresa when '103' then  827623
	                            when '8456' then 827624
                              when '19574' then 827828 --Ref5 KBastida  --trx Servicio 827828
                              when '19575' then 827859 --Ref5 KBastida  --trx Servicio 827859
                              else 827688 end,
     'BO'         ,'SI'           ,'NO'                 ,br_usuario          ,br_codigo       , br_monto_cta    ,getdate(), --ref002
     br_hora_trx_local     ,br_nombre       ,br_tip_trx        ,'ND.CTA'             ,@e_fecha         , br_tipo_cta, br_empresa
    from cob_pagos..pag_t_broadnet_servicio
    where br_fec_proceso  = @e_fecha and br_est_conciliacion <> 'S'
    and br_cta_bco is not null 
    and br_monto_cta <> 0
	
	
    --<REF 6, Update con la Tabla Temp de IntegrarInformacion Ref6    
    update cob_pagos..pag_t_concilia_broadnet
      set 
	  co_autoriz_bco  = ts_secuencial,
      co_celular      = ts_referencia,
      co_usuario      = ts_usuario ,
      co_tip_trx      = ts_tipo_transaccion,
      co_tipo_cuenta  =	substring(ts_tipocta,1,1),
      co_nro_cuenta   = ts_cta_banco,
      co_canal        = ts_tipo_chequera,
	  co_debito		  = ts_monto
      from  #pg_tmp_integar_informacion
      where 
      co_resultado = "IE" and 
      co_estatus_bco = "NO" and 
      co_estatus_emp_serv = "SI" and
      co_fec_cble  = @e_fecha 
	  and
	  convert(varchar,co_autoriz_bco) = right(convert(varchar,ts_secuencial),6)
    --REF 6, Fin Update con la Tabla Temp>

	
	
	if @@error <> 0
	begin
		rollback tran
		return 1
	end
	
	commit tran
 
  if object_id('tempdb.dbo.#pg_tmp_integar_informacion') is not null
          drop table #pg_tmp_integar_informacion 
		  
  if object_id('tempdb.dbo.#pg_tmp_auxiliar_recarga') is not null /*<REF 6>*/
          drop table #pg_tmp_auxiliar_recarga /*<REF 6>*/
return 0

go
if exists(select 1 from sysobjects where name='pa_pag_a_concilia_broadnet_p' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pag_a_concilia_broadnet_p *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pag_a_concilia_broadnet_p -- ERROR -- >>>'
  
go
                                                                                                                                                                      