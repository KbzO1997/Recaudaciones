/************************************************************************/
/*    Archivo: pgbroadnete.sp                                			*/
/*    Stored procedure  : pa_pag_c_concilia_broadnet_e                  */
/*    Base de datos: cob_pagos                                     		*/
/*    Producto          : Cuentas de pagos                              */
/*    Motor de Base: 		SYBASE                     					*/
/*    Servidor: 			HP-ACT                                      */
/*    Procesamiento: 		OLTP	                                    */
/*    Aplicacion: 		Cyberbank	                                	*/
/*    Disenado por      : Danny Olaya S.                                */
/*    Fecha de escritura: 30/Abr/2019                                   */
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
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/*   1  30/Abr/2019   Danny Olaya S.  RRCYT-4 (JIRA)   Emision Inicial  */
/*   2  06/Jun/2019   Danny Olaya S.  RECA-CE-SGC00035614  Ajustes Recargas CNT y TUENTI*/
/* 	 3  25/08/2022  Kevin Bastidas	RECESABREC-124 TSERVI MOVISTAR CANALES DIGITALES*/
/************************************************************************/

use cob_pagos
go
if exists(select 1 from sysobjects where name = 'pa_pag_c_concilia_broadnet_e' and type = 'P')
begin
   drop procedure dbo.pa_pag_c_concilia_broadnet_e
   if exists (select 1 from sysobjects where name = 'pa_pag_c_concilia_broadnet_e' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pag_c_concilia_broadnet_e -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pag_c_concilia_broadnet_e *OK* =='
end
go

create procedure dbo.pa_pag_c_concilia_broadnet_e
(     
	   @e_empresa			   varchar(5),
	   @e_fecha                varchar(10),
	   @e_siguiente            int = null
)

as

-----Archivo de pagos exitosos 

  set rowcount 15

  select convert(varchar(10),co_fec_cble,101),
  ci_descripcion,
  of_nombre,
  'canal'= co_canal,
  co_usuario,
  co_valor,
  ts_valor,
  ts_saldo,
  ts_monto,
  'Hora'= convert(varchar(10),co_fec_cble,101) + ' ' + substring(co_hora_trn_local,1,2) + ":" + substring(co_hora_trn_local,3,2) + ":" +  substring(co_hora_trn_local,5,2) ,
  ts_campo_alt_dos,
  co_nombre,
  co_celular,
  co_autoriz_bco
  from cob_pagos..pag_t_concilia_broadnet inner join cob_cuentas..cc_tran_servicio_resp
  on ts_secuencial = co_autoriz_bco
  inner join cobis..cl_oficina 
  on of_oficina = ts_oficina 
  inner join cobis..cl_ciudad
  on ci_ciudad = of_ciudad
  where co_fec_cble = @e_fecha
  and co_autoriz_bco > @e_siguiente
  and co_resultado in('OK','BO') --ref002
  and ts_causa = @e_empresa
  and co_empresa = @e_empresa
  and ts_tipo_transaccion in(4014,4015, 4060, 4061, 4062, 4063, 62686,62687,62688,62689) --Ref3 KBastida  --trx Servicio 62686 hasta 62689
  order by co_autoriz_bco 
  

  set rowcount 0

return 0
go
if exists(select 1 from sysobjects where name='pa_pag_c_concilia_broadnet_e' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pag_c_concilia_broadnet_e *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pag_c_concilia_broadnet_e -- ERROR -- >>>'
go
                                                                                                                                                                        
