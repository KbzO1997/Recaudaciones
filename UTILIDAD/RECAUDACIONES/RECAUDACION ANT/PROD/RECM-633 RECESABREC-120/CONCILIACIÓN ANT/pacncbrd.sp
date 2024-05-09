use cob_pagos
go
if exists(select 1 from sysobjects where name = 'pa_pg_gconcilia_reca_banred' and type = 'P')
begin
   drop procedure dbo.pa_pg_gconcilia_reca_banred
   if exists (select 1 from sysobjects where name = 'pa_pg_gconcilia_reca_banred' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_pg_gconcilia_reca_banred -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_pg_gconcilia_reca_banred *OK* =='
end
go
/***********************************************************************************/
/*   Archivo:                pacncbrd.sp                       					   */
/*   Motor de Base:      	 SYBASE                                      	  	   */
/*   Servidor:           	 HP-ACTIVA                                  		   */
/*   Aplicacion:         	 CyberBank                                  		   */
/*   Base de datos:          cob_pagos                                             */
/*   Procesamiento:      	 BATCH                                        	 	   */
/*   Aplicación:             Recaudaciones                                         */
/*   Stored Procedure:       pa_pg_gconcilia_reca_banred                          */
/*   Diseñado por:           Dario Espinosa Aldean                                 */
/*   Fecha de escritura:     03/Marz/2022                                          */
/***********************************************************************************/
/*                                 IMPORTANTE                                      */
/*      "Este programa es parte de los paquetes bancarios propiedad de             */
/*      BANCO BOLIVARIANO S.A.                                                     */
/*      Su uso no autorizado queda expresamente prohibido asi como                 */
/*      cualquier alteracion o agregado hecho por alguno de sus                    */
/*      usuarios sin el debido consentimiento por escrito de la                    */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante."            */
/***********************************************************************************/
/*                                  PROPOSITO                                      */
/* BATCH: Consulta de la Información del Archivo de Conciliación BANRED            */
/***********************************************************************************/
/*                               MODIFICACIONES:                                   */
/* REF FECHA        AUTOR         TAREA JIRA                      DESCRIPCION      */
/* 01  04/Mar/2022  Dario Espinosa CONCILIACION                   Emision Inicial  */
/***********************************************************************************/

create proc dbo.pa_pg_gconcilia_reca_banred
as
  declare @v_sp_name      varchar(32),
          @v_return       int,
          @v_relleno_txt  char(1),
          @v_relleno_num  char(1)
  --
  set @v_sp_name = 'pa_pg_gconcilia_reca_banred', @v_return = 0
  ----------------------------------------------------------------------
  -- Se obtiene el caracter de relleno de texto
  select @v_relleno_txt =' '
 
  -- Se setea el caracter de relleno de texto
  select @v_relleno_num = '0'
  ---
  select tc_tipo_registro,                                                                                                                  -- RCP-TIPO-REGISTRO
         tc_ori_registro,                                                                                                                   -- RCP-ORIGEN-REGISTRO
         tc_adquiriente = replicate (@v_relleno_num, 6 - len('233')) + '233',                                                               -- RCP-FIID-ADQUIRENTE
         tc_autorizador = replicate (@v_relleno_num, 6 - len('2287')) + '2287',                                                             -- RCP-FIID-AUTORIZADOR
         tc_hora_tran = str_replace(convert(char(10),tc_hora_tran,103),'/',null) + str_replace(convert(varchar,tc_hora_tran,108),':',null), -- RCP-FECHA-HORA-TRANSACCION
         tc_tipo_proceso,                                                                                                                   -- RCP-CODIGO-TIPO-MENSAJE
         tc_subtipo_trans,                                                                                                                  -- RCP-SUBTIPO-TRANSACCION
         tc_tipo_disp,                                                                                                                      -- RCP-TIPO-DISPOSITIVO
         tc_secuencial = convert(varchar,tc_secuencial) + replicate (' ', 12 - len(ltrim(rtrim(convert(varchar,tc_secuencial))))),          -- RCP-SECUENCIA-TRX-ADQ
         tc_sec_bred = convert(varchar,tc_sec_bred) + replicate (' ', 12 - len(ltrim(rtrim(convert(varchar,tc_sec_bred))))),                -- RCP-SECUENCIA-TRX-SWITCH
         tc_respuesta = '000000',                                                                                                           -- RCP-RESPUESTA-TRANSACCION
         tc_ind_rev = '0',                                                                                                                  -- RCP-INDICADOR-REVERSA
         tc_cod_autoriz = tc_cod_autoriza + replicate (@v_relleno_txt, 10- len(tc_cod_autoriza)),                                           -- RCP-CODIGO-AUTORIZACION
         tc_cod_bred = replicate (@v_relleno_num,20),                                                                                       -- RCP-CODIGO-BANRED
         tc_oficina = convert(varchar,tc_oficina) + replicate (@v_relleno_txt, 6 - len(ltrim(rtrim(convert(varchar,tc_oficina))))),         -- RCP-COD-AGENCIA-RECAUD
         tc_terminal = tc_terminal + replicate (@v_relleno_txt, 8 - len(ltrim(rtrim(tc_terminal)))),                                        -- RCP-COD-TERMINAL-RECAUD
         tc_referencia = tc_referencia + replicate (@v_relleno_txt, 30 - len(tc_referencia)), 												-- RCP-NUMERO DOCUMENTO
         tc_tipo_doc = replicate (@v_relleno_txt,8),                                                                                        -- RCP-TIPO DOCUMENTO
         tc_num_comprob = replicate (@v_relleno_txt,16),                                                                                    -- RCP-NUMERO COMPROBANTE
         tc_ciudad_of = tc_ciudad_of + replicate (@v_relleno_txt, 22 - len(ltrim(rtrim(tc_ciudad_of)))),                                    -- RCP-LOCALIDAD DOCUMENTO
         str_replace(convert(char(10),tc_tsfecha,103),'/',null),                                                                            -- RCP-PERIODO INICIO
         str_replace(convert(char(10),tc_tsfecha,103),'/',null),                                                                            -- RCP-PERIODO FIN
         tc_tipocta_bred,                                                                                                                   -- RCP-TIPO CUENTA ORIGEN
         tc_cta_banco = replicate (@v_relleno_num, 16 - len(tc_cta_banco)) + tc_cta_banco,                                                  -- RCP-NUMERO CUENTA ORIGEN
         tc_tcta_bco_dest = tc_tipocta_dest,                                                                                                -- RCP-TIPO CUENTA DESTINO
         tc_cta_bco_dest = replicate (@v_relleno_num, 16 - len(tc_cta_banco_dest))+ tc_cta_banco_dest,                                      -- RCP-NUMERO CUENTA DESTINO
         tc_num_tarjeta = replicate('0',20),                                                                                                -- RCP-NUMERO TARJETA
         tc_cod_moneda = '840',                                                                                                             -- RCP-CODIGO MONEDA
         tc_tipo_pago,                                                                                                                      -- RCP-TIPO PAGO
         tc_val_total = replicate(@v_relleno_num, 20 - len(convert(varchar(20),tc_valor_total)))+convert(varchar(20),tc_valor_total),       -- RCP-VALOR TRANSACCION 1
         tc_val_serv  = replicate(@v_relleno_num, 20 - len(convert(varchar(20),tc_valor_servicio)))+convert(varchar(20),tc_valor_servicio), -- RCP-VALOR TRANSACCION 2
         tc_comision = replicate(@v_relleno_num, 20 - len(convert(varchar(20),tc_comision)))+convert(varchar(20),tc_comision),              -- RCP-VALOR COMISION
         tc_compensa = 'S',                                                                                                                 -- RCP-COMPENSA
         tc_unidad_nego = replicate (@v_relleno_txt,6),                                      												-- RCP-UNIDAD-NEGOCIO
		 tc_med_aut = 'O',                                      																			-- METODO DE AUTORIZACION
		 tc_bco_emisor = '2310',                                      																		-- BANCO EMISOR
         tc_filler = replicate (@v_relleno_txt, 57)                                                                                         -- RCP-FILLER1
    from db_general..reca_tmp_concilia_banred
	order by tc_empresa
	--
	if @@rowcount = 0
	begin
		set @v_return = 33333
		print 'ERROR: Consultar transacciones'
		return @v_return 
	end
		
return 0

go
if exists(select 1 from sysobjects where name='pa_pg_gconcilia_reca_banred' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_pg_gconcilia_reca_banred *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_pg_gconcilia_reca_banred -- ERROR -- >>>'
go
