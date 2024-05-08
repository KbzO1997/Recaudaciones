/************************************************************************/
/*      Archivo:                capiccdi.sp                             */
/*      Stored procedure:       sp_genera_diferidos_rc                  */
/*  Base de datos:      cob_cuentas                             */
/*  Producto:               Cuentas Corrientes                          */
/*      Fecha de escritura:     Ago/2000                                */
/************************************************************************/
/*              IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                        */  
/*  Su uso no autorizado queda expresamente prohibido asi como        */
/*  cualquier alteracion o agregado hecho por alguno de sus           */
/*  usuarios sin el debido consentimiento por escrito de la           */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la capitalizacion de cuentas corrientes   */
/*      en forma diaria                                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/* REF  FECHA           AUTOR           RAZON                           */
/*      02/09/2004   SIPECOM      SI VALORES SON NULOS REEMPLAZAR     */
/*                                  POR CEROS                           */
/*      03/08/2004   W.Ramirez    Cambio en Atc para Diferido         */  
/*      05/20/2004   W.Ramirez    Temporal monetaria para SPI         */
/*      12/01/2004   R.Castillo   Restar el campo ts_autoriz_aut      */
/*      03/22/2005   R.Castillo   Contabilidad de Servicios       */
/*   6  02.mar.2006  Gisella Gonzalez R.  SAT-1487: Comision puede venir*/
/*                   null, y el campo valor se grababa con null.  */
/*  7 22/Agosto/2011 Sandra Merino  ATMFULL-286-CU-1720                 */
/*8  17/Abr/2013  María Jo. Silva  CTE-CE-SGC00008618 Cobro comision de Emp. CATEG*/
/*9  03/Sep/2013  J.Pazminno M.    Considerar nuevas causas en trx 3050 */
/*                                 Tarea: CTE-CE-SGC00010984            */
/*10 09/AGO/2017  Tanya Cumbicos   PGCCOB-AP-SGC00028737-SGC00028786    */
/*			 inclusion de contabilidad por ajuste diferido	*/
/************************************************************************/

use cob_cuentas
go

if exists (select 1 from sysobjects where name = 'sp_genera_diferidos_rc')
   drop proc sp_genera_diferidos_rc

go
create proc sp_genera_diferidos_rc (
        @i_fecha                datetime
)
as

declare
@w_ts_secuencial         int,  
@w_ts_cod_alterno        int,
@w_ts_tipo_transaccion   int,
@w_ts_clase              varchar(3),           
@w_ts_tsfecha            smalldatetime,         
@w_ts_tabla              tinyint,           
@w_ts_usuario            varchar(64),        
@w_ts_terminal           varchar(64),        
@w_ts_rol                smallint,             
@w_ts_correccion         char(1),      
@w_ts_ssn_corr           int,       
@w_ts_reentry            char(1),         
@w_ts_origen             char(1),          
@w_ts_nodo               varchar(30),            
@w_ts_referencia         varchar(15),      
@w_ts_remoto_ssn         int,      
@w_ts_cheque_rec         int,      
@w_ts_ctacte             int,          
@w_ts_cta_banco          varchar(24),       
@w_ts_filial             tinyint,          
@w_ts_oficina            smallint,         
@w_ts_oficial            smallint,         
@w_ts_fecha_aper         smalldatetime,      
@w_ts_cliente            int,         
@w_ts_ced_ruc            varchar(13),         
@w_ts_estado             char(1),          
@w_ts_direccion_ec       tinyint,    
@w_ts_descripcion_ec     varchar(120), 
@w_ts_ciclo              char(1),          
@w_ts_categoria          char(1),       
@w_ts_producto           tinyint,        
@w_ts_tipo               char(1),            
@w_ts_indicador          tinyint,       
@w_ts_moneda             tinyint,          
@w_ts_default            int,         
@w_ts_tipo_def           char(1),        
@w_ts_rol_ente           char(1),        
@w_ts_tipo_promedio      char(1),  
@w_ts_numero             smallint,         
@w_ts_fecha              smalldatetime,           
@w_ts_autorizante        varchar(64),    
@w_ts_causa              varchar(6),           
@w_ts_servicio           varchar(3),        
@w_ts_saldo              money ,           
@w_ts_fecha_uso          smalldatetime,       
@w_ts_monto              money,           
@w_ts_fecha_ven          smalldatetime,       
@w_ts_filial_aut         tinyint,      
@w_ts_ofi_aut            tinyint,         
@w_ts_autoriz_aut        varchar(64),    
@w_ts_filial_anula       tinyint,  
@w_ts_ofi_anula          tinyint,      
@w_ts_autoriz_anula      varchar(64),  
@w_ts_cheque_desde       int,   
@w_ts_cheque_hasta       int,   
@w_ts_chequera           smallint,       
@w_ts_num_cheques        smallint,    
@w_ts_departamento       smallint,   
@w_ts_cta_gir            varchar(24),        
@w_ts_endoso             int,                
@w_ts_cod_banco          varchar(8),            
@w_ts_corresponsal       varchar(8),          
@w_ts_propietario        varchar(8),         
@w_ts_carta              int,                
@w_ts_sec_correccion     int,      
@w_ts_cheque             int,               
@w_ts_cta_banco_dep      varchar(24),       
@w_ts_oficina_pago       smallint,         
@w_ts_contratado         money,           
@w_ts_valor              money,                
@w_ts_ocasional          money,            
@w_ts_banco              smallint,                
@w_ts_ccontable          varchar(20),            
@w_ts_cta_funcionario    char(1),      
@w_ts_mercantil          char(1),            
@w_ts_cta_asociada       varchar(24),         
@w_ts_tipocta            char(1),              
@w_ts_fecha_eimp         smalldatetime,  
@w_ts_fecha_rimp         smalldatetime,        
@w_ts_fecha_rofi         smalldatetime,           
@w_ts_tipo_chequera      varchar(5),        
@w_ts_stick_imp          char(12),            
@w_ts_tipo_imp           char(1),             
@w_ts_tarjcred           varchar(20),             
@w_ts_aporte_iess        money,          
@w_ts_descuento_iess     money,      
@w_ts_fonres_iess        money,          
@w_ts_agente             varchar(30),               
@w_ts_nombre             varchar(120),              
@w_ts_debito             char(1),              
@w_ts_hora               smalldatetime,                
@w_ts_oficina_cta        smallint,          
@w_ts_tsn                int,                  
@w_ts_tipo_contable      char(2),       
@w_ts_estado_sob         char(3),          
@w_ts_tipo_credito       char(1),        
@w_ts_plazo              char(2),                
@w_ts_tipo_sobregiro     char(1),       
@w_ts_campo_alt_uno      varchar(30),       
@w_ts_campo_alt_dos      varchar(30),
@w_ts_ubicacion          smallint,
@w_trn_ajuste           int,
@w_efec                 money,
@w_valchq               money,
@w_debcred              money,
@w_reten                money,
@w_efecob               money,
@w_efecobchq            money,
@w_efecobodb            money,
@w_ncre                 money,
@w_tarj                 money,
@w_cruce_depto          money,
@w_otros                money,
@w_total                money,
@w_efectivo             varchar(30),
@w_cheque               varchar(30),
@w_efecto_chq           varchar(30),
@w_efecto_odb           varchar(30),
@w_nc_fiscales          varchar(30),
@w_tarjetas             varchar(30),
@w_retencion            varchar(30),
@w_ndnc                 varchar(30), 
@w_depto                varchar(30),
@w_autoriz_aut      money  -- RCA 12/01/2004



declare transacciones cursor for
select 
ts_secuencial,  
ts_cod_alterno, 
ts_tipo_transaccion,
ts_clase,           
ts_tsfecha,         
ts_tabla,           
ts_usuario,         
ts_terminal,        
ts_rol,             
ts_correccion ,     
ts_ssn_corr,        
ts_reentry,         
ts_origen,          
ts_nodo,            
ts_referencia,      
ts_remoto_ssn,      
ts_cheque_rec,      
ts_ctacte,          
ts_cta_banco ,      
ts_filial,          
ts_oficina,         
ts_oficial,         
ts_fecha_aper,      
ts_cliente,         
ts_ced_ruc,         
ts_estado,          
ts_direccion_ec,    
ts_descripcion_ec, 
ts_ciclo ,          
ts_categoria,       
ts_producto,        
ts_tipo,            
ts_indicador ,      
ts_moneda,          
ts_default,         
ts_tipo_def,        
ts_rol_ente ,       
ts_tipo_promedio ,  
ts_numero,         
ts_fecha,           
ts_autorizante ,    
ts_causa,           
ts_servicio,        
ts_saldo,           
ts_fecha_uso,       
ts_monto,           
ts_fecha_ven,       
ts_filial_aut,      
ts_ofi_aut,         
ts_autoriz_aut,    
ts_filial_anula,   
ts_ofi_anula ,     
ts_autoriz_anula , 
ts_cheque_desde,   
ts_cheque_hasta,  
ts_chequera,       
ts_num_cheques ,   
ts_departamento,   
ts_cta_gir,        
ts_endoso,                
ts_cod_banco,             
ts_corresponsal,          
ts_propietario,          
ts_carta,                
ts_sec_correccion,       
ts_cheque ,              
ts_cta_banco_dep ,       
ts_oficina_pago,        
ts_contratado,          
ts_valor ,               
ts_ocasional,            
ts_banco,                
ts_ccontable ,           
ts_cta_funcionario ,     
ts_mercantil,            
ts_cta_asociada,        
ts_tipocta ,             
ts_fecha_eimp ,          
ts_fecha_rimp,           
ts_fecha_rofi,           
ts_tipo_chequera,        
ts_stick_imp,            
ts_tipo_imp,             
ts_tarjcred ,            
ts_aporte_iess ,         
ts_descuento_iess,       
ts_fonres_iess,          
ts_agente,               
ts_nombre ,              
ts_debito ,              
ts_hora ,                
ts_oficina_cta,          
ts_tsn,                  
ts_tipo_contable ,       
ts_estado_sob ,          
ts_tipo_credito ,        
ts_plazo,                
ts_tipo_sobregiro,       
ts_campo_alt_uno ,       
ts_campo_alt_dos,
ts_ubicacion,
  tg_efectivo,  
  tg_cheque,   
  tg_efecto_chq,
  tg_efecto_odb,
  tg_nc_fiscales,
  tg_tarjetas,   
  tg_retencion,  
  tg_ndnc,       
  tg_depto,
  tg_trn_ajuste,
convert(money,isnull(ts_autoriz_aut, '0')) -- RCA 12/01/2004
from cob_cuentas..cc_tran_servicio_resp,
     cob_remesas..re_trn_caja
where  ts_tipo_transaccion = tg_transaccion
  and  tg_horario_corte = "D"
----  and  tg_recaudacion = "S"
  and  tg_afecta_entradaint = "S"     --- para transaccion de ajuste tiene S o N 
  and  tg_trn_ajuste  is not null 
  and ts_tsfecha = '11/29/2022' --'09/14/2022'
  for  read only
/* Apertura del cursor */

open transacciones

/* Localizar el primer registro */

fetch transacciones into 
@w_ts_secuencial,  
@w_ts_cod_alterno ,
@w_ts_tipo_transaccion,
@w_ts_clase,           
@w_ts_tsfecha,         
@w_ts_tabla,           
@w_ts_usuario ,        
@w_ts_terminal,        
@w_ts_rol,             
@w_ts_correccion,      
@w_ts_ssn_corr ,       
@w_ts_reentry,         
@w_ts_origen,          
@w_ts_nodo,            
@w_ts_referencia,      
@w_ts_remoto_ssn,      
@w_ts_cheque_rec,      
@w_ts_ctacte,          
@w_ts_cta_banco,       
@w_ts_filial,          
@w_ts_oficina,         
@w_ts_oficial,         
@w_ts_fecha_aper,      
@w_ts_cliente,         
@w_ts_ced_ruc,         
@w_ts_estado,          
@w_ts_direccion_ec,    
@w_ts_descripcion_ec , 
@w_ts_ciclo,          
@w_ts_categoria,       
@w_ts_producto,        
@w_ts_tipo,            
@w_ts_indicador,       
@w_ts_moneda,          
@w_ts_default,         
@w_ts_tipo_def,        
@w_ts_rol_ente,        
@w_ts_tipo_promedio ,  
@w_ts_numero,         
@w_ts_fecha,           
@w_ts_autorizante ,    
@w_ts_causa,           
@w_ts_servicio,        
@w_ts_saldo,           
@w_ts_fecha_uso,       
@w_ts_monto,           
@w_ts_fecha_ven,       
@w_ts_filial_aut,      
@w_ts_ofi_aut,         
@w_ts_autoriz_aut,    
@w_ts_filial_anula ,  
@w_ts_ofi_anula,      
@w_ts_autoriz_anula,  
@w_ts_cheque_desde,   
@w_ts_cheque_hasta,   
@w_ts_chequera,       
@w_ts_num_cheques,    
@w_ts_departamento,   
@w_ts_cta_gir,        
@w_ts_endoso,                
@w_ts_cod_banco ,            
@w_ts_corresponsal,          
@w_ts_propietario ,         
@w_ts_carta,                
@w_ts_sec_correccion,      
@w_ts_cheque,               
@w_ts_cta_banco_dep,       
@w_ts_oficina_pago,         
@w_ts_contratado,           
@w_ts_valor,                
@w_ts_ocasional,            
@w_ts_banco,                
@w_ts_ccontable,            
@w_ts_cta_funcionario,      
@w_ts_mercantil,            
@w_ts_cta_asociada,         
@w_ts_tipocta,              
@w_ts_fecha_eimp, 
@w_ts_fecha_rimp,          
@w_ts_fecha_rofi,           
@w_ts_tipo_chequera,        
@w_ts_stick_imp,            
@w_ts_tipo_imp,             
@w_ts_tarjcred,             
@w_ts_aporte_iess,          
@w_ts_descuento_iess ,      
@w_ts_fonres_iess,          
@w_ts_agente,               
@w_ts_nombre ,              
@w_ts_debito ,              
@w_ts_hora ,                
@w_ts_oficina_cta,          
@w_ts_tsn,                  
@w_ts_tipo_contable ,       
@w_ts_estado_sob ,          
@w_ts_tipo_credito ,        
@w_ts_plazo,                
@w_ts_tipo_sobregiro,       
@w_ts_campo_alt_uno ,       
@w_ts_campo_alt_dos,
@w_ts_ubicacion,
      @w_efectivo,
      @w_cheque ,
      @w_efecto_chq,
      @w_efecto_odb,
      @w_nc_fiscales,
      @w_tarjetas,
      @w_retencion,
      @w_ndnc,
      @w_depto,
      @w_trn_ajuste,
      @w_autoriz_aut -- RCA 12012004

while (@@sqlstatus = 0)
 begin
       select @w_efec = 0
       select @w_valchq=0
       select @w_reten=0
       select @w_efecob=0
       select @w_ncre=0
       select @w_debcred=0
       select @w_otros=0
       select @w_total=0 
       select @w_efecobchq = 0
       select @w_efecobodb = 0
       select @w_tarj = 0
       select @w_cruce_depto = 0
       /* select @w_autoriz_aut = 0 -- RCA*/ -- No debe Inicializarse

       if @w_efectivo is not null
          begin
            select @w_efec =
                 case @w_efectivo
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
       if @w_cheque is not null
          begin
            select @w_valchq =
                 case @w_cheque 
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end

       if @w_retencion is not null
          begin
            select @w_reten =
                 case @w_retencion
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
       if @w_ndnc is not null
          begin
            select @w_debcred =
                 case @w_ndnc
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
       if @w_nc_fiscales is not null
          begin
            select @w_ncre =
                 case @w_nc_fiscales
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end


       if @w_efecto_chq is not null
          begin
            select @w_efecobchq =
                 case @w_efecto_chq
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
       if @w_efecto_odb is not null
          begin
            select @w_efecobodb =
                 case @w_efecto_odb
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end

      
       if @w_tarjetas is not null
          begin
            select @w_tarj  =
                 case @w_tarjetas
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
 
       if @w_depto is not null
          begin
            select @w_cruce_depto   =
                 case @w_depto
                      when "ts_saldo"          then @w_ts_saldo
                      when "ts_valor"          then @w_ts_valor
                      when "ts_monto"          then @w_ts_monto
                      when "ts_contratado"     then @w_ts_contratado
                      when "ts_ocasional"      then @w_ts_ocasional
                      when "ts_aporte_iess"    then @w_ts_aporte_iess 
                      when "ts_descuento_iess" then @w_ts_descuento_iess 
                      when "ts_fonres_iess"    then @w_ts_fonres_iess
                      else 0
                 end
             
          end
       
       select @w_efecob = isnull(@w_efecobchq,0) + isnull(@w_efecobodb,0)
       select @w_otros = isnull(@w_cruce_depto,0) + isnull(@w_tarj,0)
       
   ---    select @w_total= @w_efec + @w_valchq + @w_reten + @w_efecob +  @w_ncre + @w_debcred + @w_otros

    select @w_total = isnull(@w_efec,0) + isnull(@w_valchq,0)  + isnull(@w_efecob,0) +  isnull(@w_ncre,0) + isnull(@w_debcred,0) + isnull(@w_otros,0)

    if @w_ts_tipo_transaccion in (3219,3297)--(3201,3202,3203,3219,3297) Ref008:msilvag     --- ame 01/23/2004
          select @w_total = @w_total - isnull(@w_ts_aporte_iess,0) - @w_autoriz_aut  -- RCA 12012004
          
    ----smerino validacion para luz y agua
    if @w_ts_tipo_transaccion in (3201,3202,3919)
         select @w_total = @w_total + isnull(@w_ts_contratado,0) --smerino  ref7
          
    if @w_ts_tipo_transaccion = 3473     -- RCA 03/24/2005 Control de Pagos Visa Diferido del Diferido
          select @w_total = @w_total - isnull(@w_ts_aporte_iess,0) 

       insert  cob_cuentas..cc_tran_servicio values
          (@w_ts_secuencial,  
           @w_ts_cod_alterno ,
           @w_trn_ajuste,
           @w_ts_clase,           
           @i_fecha,              ---- @w_ts_tsfecha,         
           @w_ts_tabla,           
           @w_ts_usuario ,        
           @w_ts_terminal,        
           @w_ts_rol,             
           @w_ts_correccion,      
           @w_ts_ssn_corr ,       
           @w_ts_reentry,         
           @w_ts_origen,          
           @w_ts_nodo,            
           @w_ts_referencia,      
           @w_ts_remoto_ssn,      
           @w_ts_cheque_rec,      
           @w_ts_ctacte,          
           @w_ts_cta_banco,       
           @w_ts_filial,          
           @w_ts_oficina,         
           @w_ts_oficial,         
           @w_ts_fecha_aper,      
           @w_ts_cliente,         
           @w_ts_ced_ruc,         
           @w_ts_estado,          
           @w_ts_direccion_ec,    
           @w_ts_descripcion_ec , 
           @w_ts_ciclo,          
           @w_ts_categoria,       
           @w_ts_producto,        
           @w_ts_tipo,            
           @w_ts_indicador,       
           @w_ts_moneda,          
           @w_ts_default,         
           @w_ts_tipo_def,        
           @w_ts_rol_ente,        
           @w_ts_tipo_promedio ,  
           @w_ts_numero,         
           @w_ts_fecha,           
           @w_ts_autorizante ,    
           @w_ts_causa,           
           @w_ts_servicio,        
           @w_ts_saldo,           
           @w_ts_fecha_uso,       
           @w_ts_monto,           
           @w_ts_fecha_ven,       
           @w_ts_filial_aut,      
           @w_ts_ofi_aut,         
           @w_ts_autoriz_aut,    
           @w_ts_filial_anula ,  
           @w_ts_ofi_anula,      
           @w_ts_autoriz_anula,  
           @w_ts_cheque_desde,   
           @w_ts_cheque_hasta,   
           @w_ts_chequera,       
           @w_ts_num_cheques,    
           @w_ts_departamento,   
           @w_ts_cta_gir,        
           @w_ts_endoso,                
           @w_ts_cod_banco ,            
           @w_ts_corresponsal,          
           @w_ts_propietario ,         
           @w_ts_carta,                
           @w_ts_sec_correccion,      
           @w_ts_cheque,               
           @w_ts_cta_banco_dep,       
           @w_ts_oficina_pago,         
           @w_ts_contratado,           
           @w_ts_valor,                
           @w_ts_ocasional,            
           @w_ts_banco,                
           @w_ts_ccontable,            
           @w_ts_cta_funcionario,      
           @w_ts_mercantil,            
           @w_ts_cta_asociada,         
           @w_ts_tipocta,              
           @w_ts_fecha_eimp,   
           @w_ts_fecha_rimp,        
           @w_ts_fecha_rofi,           
           @w_ts_tipo_chequera,        
           @w_ts_stick_imp,            
           @w_ts_tipo_imp,             
           @w_ts_tarjcred,             
           @w_ts_aporte_iess,          
           @w_ts_descuento_iess ,      
           @w_total,                  --- @w_ts_fonres_iess,          
           @w_ts_agente,               
           @w_ts_nombre ,              
           @w_ts_debito ,              
           @w_ts_hora ,                
           @w_ts_oficina_cta,          
           @w_ts_tsn,                  
           @w_ts_tipo_contable ,       
           @w_ts_estado_sob ,          
           @w_ts_tipo_credito ,        
           @w_ts_plazo,                
           @w_ts_tipo_sobregiro,       
           @w_ts_campo_alt_uno ,       
           @w_ts_campo_alt_dos,
           @w_ts_ubicacion)
    -- JPM Ref.09 : control de error -->
    if @@error <> 0
    begin
      print 'Error en insert (1) cob_cuentas..cc_tran_servicio @w_ts_secuencial %1!, @w_ts_cod_alterno %2!', @w_ts_secuencial, @w_ts_cod_alterno
      return 1
    end
    -- <-- JPM Ref.09 : control de error

    fetch transacciones into 
        @w_ts_secuencial,  
        @w_ts_cod_alterno ,
        @w_ts_tipo_transaccion,
        @w_ts_clase,           
        @w_ts_tsfecha,         
        @w_ts_tabla,           
        @w_ts_usuario ,        
        @w_ts_terminal,        
        @w_ts_rol,             
        @w_ts_correccion,      
        @w_ts_ssn_corr ,       
        @w_ts_reentry,         
        @w_ts_origen,          
        @w_ts_nodo,            
        @w_ts_referencia,      
        @w_ts_remoto_ssn,      
        @w_ts_cheque_rec,      
        @w_ts_ctacte,          
        @w_ts_cta_banco,       
        @w_ts_filial,          
        @w_ts_oficina,         
        @w_ts_oficial,         
        @w_ts_fecha_aper,      
        @w_ts_cliente,         
        @w_ts_ced_ruc,         
        @w_ts_estado,          
        @w_ts_direccion_ec,    
        @w_ts_descripcion_ec , 
        @w_ts_ciclo,          
        @w_ts_categoria,       
        @w_ts_producto,        
        @w_ts_tipo,            
        @w_ts_indicador,       
        @w_ts_moneda,          
        @w_ts_default,         
        @w_ts_tipo_def,        
        @w_ts_rol_ente,        
        @w_ts_tipo_promedio ,  
        @w_ts_numero,         
        @w_ts_fecha,           
        @w_ts_autorizante ,    
        @w_ts_causa,           
        @w_ts_servicio,        
        @w_ts_saldo,           
        @w_ts_fecha_uso,       
        @w_ts_monto,           
        @w_ts_fecha_ven,       
        @w_ts_filial_aut,      
        @w_ts_ofi_aut,         
        @w_ts_autoriz_aut,    
        @w_ts_filial_anula ,  
        @w_ts_ofi_anula,      
        @w_ts_autoriz_anula,  
        @w_ts_cheque_desde,   
        @w_ts_cheque_hasta,   
        @w_ts_chequera,       
        @w_ts_num_cheques,    
        @w_ts_departamento,   
        @w_ts_cta_gir,        
        @w_ts_endoso,                
        @w_ts_cod_banco ,            
        @w_ts_corresponsal,          
        @w_ts_propietario ,         
        @w_ts_carta,                
        @w_ts_sec_correccion,      
        @w_ts_cheque,               
        @w_ts_cta_banco_dep,       
        @w_ts_oficina_pago,         
        @w_ts_contratado,           
        @w_ts_valor,                
        @w_ts_ocasional,            
        @w_ts_banco,                
        @w_ts_ccontable,            
        @w_ts_cta_funcionario,      
        @w_ts_mercantil,            
        @w_ts_cta_asociada,         
        @w_ts_tipocta,              
        @w_ts_fecha_eimp, 
        @w_ts_fecha_rimp,                  
        @w_ts_fecha_rofi,           
        @w_ts_tipo_chequera,        
        @w_ts_stick_imp,            
        @w_ts_tipo_imp,             
        @w_ts_tarjcred,             
        @w_ts_aporte_iess,          
        @w_ts_descuento_iess ,      
        @w_ts_fonres_iess,          
        @w_ts_agente,               
        @w_ts_nombre ,              
        @w_ts_debito ,              
        @w_ts_hora ,                
        @w_ts_oficina_cta,          
        @w_ts_tsn,                  
        @w_ts_tipo_contable ,       
        @w_ts_estado_sob ,          
        @w_ts_tipo_credito ,        
        @w_ts_plazo,                
        @w_ts_tipo_sobregiro,       
        @w_ts_campo_alt_uno ,       
        @w_ts_campo_alt_dos,
        @w_ts_ubicacion,
        @w_efectivo,
        @w_cheque ,
        @w_efecto_chq,
        @w_efecto_odb,
        @w_nc_fiscales,
        @w_tarjetas,
        @w_retencion,
        @w_ndnc,
        @w_depto,
        @w_trn_ajuste,
        @w_autoriz_aut -- RCA 12012004
 end

/* Cerrar y liberar cursor */

close transacciones

deallocate cursor transacciones

-- Depositos Especiales Diferidos
-- /* Pasar a tran servicio la trx 3289 de tran_monet como 3321 */
   insert cob_cuentas..cc_tran_servicio
      (ts_secuencial,ts_clase,ts_cod_alterno,ts_tipo_transaccion,ts_tsfecha,ts_usuario,ts_terminal,ts_rol,
       ts_correccion,ts_ssn_corr,ts_reentry,ts_origen,ts_nodo,ts_remoto_ssn,
       ts_cta_banco,ts_filial,ts_oficina,ts_tipo,ts_indicador,ts_moneda,ts_causa,
       ts_valor,ts_monto,ts_departamento,ts_cheque,ts_cta_banco_dep,ts_contratado,
       ts_saldo,ts_ocasional,ts_nombre,ts_hora,ts_oficina_cta,
       ts_tsn,ts_tipo_contable,ts_campo_alt_uno,ts_campo_alt_dos)
    select tm_secuencial,'DED',tm_cod_alterno,3321,@i_fecha,tm_usuario,tm_terminal,tm_rol,
       tm_correccion,tm_sec_correccion,tm_reentry,tm_origen,tm_nodo,tm_remoto_ssn,
       tm_cta_banco,tm_filial,tm_oficina,tm_tipo,tm_indicador,tm_moneda,tm_causa,
       tm_valor,0,tm_departamento,tm_cheque,tm_ctabanco_dep,0,
       tm_chq_locales,0,tm_beneficiario,tm_hora,tm_oficina_cta,
       tm_tsn,tm_tipo_contable,tm_campo_alt_uno,tm_campo_alt_dos
    from  cob_cuentas..cc_tran_monet_resp
    where tm_tipo_tran = 3289
    -- JPM Ref.09 : control de error -->
    if @@error <> 0
    begin
      print 'Error en insert (2) cob_cuentas..cc_tran_servicio'
      return 1
    end
    -- <-- JPM Ref.09 : control de error

   -- Genera transaccion de servicios para los pagos Diferidos Ctacte

    insert cob_cuentas..cc_tran_servicio
          (ts_tsfecha,ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_filial,ts_oficina,ts_usuario,
       ts_terminal,ts_rol,ts_correccion,ts_sec_correccion,ts_origen,ts_nodo,ts_reentry,
       ts_cta_banco,ts_valor,ts_moneda,ts_causa,
       ts_ocasional,ts_cta_asociada,ts_estado,
       ts_saldo,ts_hora,
       ts_oficina_cta,ts_tsn, ts_tipo_contable, ts_monto)
    select @i_fecha,tm_secuencial,tm_cod_alterno,3406,tm_filial,tm_oficina,tm_usuario,
       tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,
       tm_cta_banco,tm_valor - isnull(tm_valor_comision, 0), tm_moneda,tm_causa,   --REF6:GGR
       tm_ocasional,tm_ctadestino,tm_tipo_xfer,
       tm_valor_comision,tm_hora,
       tm_oficina_cta,tm_tsn, tm_tipo_contable, tm_valor
    from  cob_cuentas..cc_tran_monet_resp
    where tm_tipo_tran = 3405 
    -- JPM Ref.09 : control de error -->
    if @@error <> 0
    begin
      print 'Error en insert (3) cob_cuentas..cc_tran_servicio'
      return 1
    end
    -- <-- JPM Ref.09 : control de error


/***  PARA TARJETA CORPORATIVA   ***/

    update cob_atc..tc_pago_tarjeta
       set pt_estado = "PEN"
    from   cob_atc..tc_pago_tarjeta,
       cob_cuentas..cc_tran_servicio_resp
    where  pt_empresa    = ts_cheque_desde
      and  pt_tarjeta    = ts_cheque_hasta
      and  pt_secu_pago  = ts_endoso
      and pt_estado not in ('REV','REC')  --WRB 03/07/2004
      and  ts_tipo_transaccion = 3254
    -- JPM Ref.09 : control de error -->
    if @@error <> 0
    begin
      print 'Error en update cob_atc..tc_pago_tarjeta'
      return 1
    end
    -- <-- JPM Ref.09 : control de error



insert cob_cuentas..cc_tran_servicio    -- JVP 12/Nov/2003
          (ts_tsfecha,ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_filial,ts_oficina,ts_usuario,
       ts_terminal,ts_rol,ts_correccion,ts_sec_correccion,ts_origen,ts_nodo,ts_reentry,
       ts_cta_banco,ts_valor,ts_moneda,ts_causa,
       ts_ocasional,ts_cta_asociada,ts_estado,
       ts_saldo,ts_hora,
       ts_oficina_cta,ts_tsn, ts_tipo_contable, ts_monto)
    select @i_fecha,tm_secuencial,tm_cod_alterno,3406,tm_filial,tm_oficina,tm_usuario,
       tm_terminal,tm_rol,tm_correccion,tm_sec_correccion,tm_origen,tm_nodo,tm_reentry,
       tm_cta_banco,tm_valor - isnull(tm_valor_comision,0), tm_moneda,tm_causa,
       tm_ocasional,tm_ctadestino,tm_tipo_xfer,
       tm_valor_comision,tm_hora,
       tm_oficina_cta,tm_tsn, tm_tipo_contable, tm_valor
    from  cob_cuentas..cc_tran_monet_resp  a            -- JPM Ref.09: alias
    where tm_tipo_tran = 3050
      and exists(select 1 from cobis..cl_tabla    x,
                               cobis..cl_catalogo b
                  where x.tabla = 'cc_causa_ajuste_paginterb_dif'
                    and x.codigo = b.tabla
                    and b.estado = 'V'
                    and a.tm_causa = b.codigo)
    if @@error <> 0
    begin
      print 'Error en insert (4) cob_cuentas..cc_tran_servicio'
      return 1
    end
    -- <-- JPM Ref.09 : control de error




/****************DZF******************/


    insert cob_cuentas..cc_tran_servicio    
          (ts_tsfecha,ts_secuencial,ts_cod_alterno,ts_tipo_transaccion,ts_filial,ts_oficina,ts_usuario,
       ts_terminal,ts_rol,ts_correccion,ts_sec_correccion,ts_origen,ts_nodo,ts_reentry,
       ts_cta_banco,ts_valor,ts_moneda,ts_causa,
       ts_ocasional,ts_cta_asociada,ts_estado,
       ts_saldo,ts_hora,
       ts_oficina_cta,ts_tsn, ts_tipo_contable, ts_monto)
    select @i_fecha,ts_secuencial,ts_cod_alterno,3406,ts_filial,ts_oficina,ts_usuario,
       ts_terminal,ts_rol,ts_correccion,ts_sec_correccion,ts_origen,ts_nodo,ts_reentry,
       ts_cta_banco,ts_valor,ts_moneda,ts_causa,
       ts_ocasional,ts_cta_asociada,ts_estado,
       ts_saldo,ts_hora,
       ts_oficina_cta,ts_tsn, ts_tipo_contable, ts_monto
    from  cob_cuentas..cc_tran_servicio_resp
    where ts_tipo_transaccion = 3415
    if @@error <> 0
    begin
      print 'Error en insert (5) cob_cuentas..cc_tran_servicio'
      return 1
    end
    -- <-- JPM Ref.09 : control de error


/************************************/


--ref 10
	--REGISTRA CONTABILIDAD DE CARGA
	insert into cob_cuentas..cc_tran_servicio
	(ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_rol, ts_terminal,
	ts_correccion, ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_referencia,
	ts_campo_alt_uno, ts_campo_alt_dos, ts_nombre, ts_tipo_chequera, 
	ts_monto, ts_saldo,ts_valor,
	ts_ubicacion, ts_hora,	ts_moneda, ts_causa)
	select 	ts_secuencial, 43557, ts_oficina, ts_usuario, ts_rol, ts_terminal,
	ts_correccion, ts_reentry, ts_origen, ts_nodo, @i_fecha, ts_referencia,
	ts_campo_alt_uno, ts_campo_alt_dos, ts_nombre, ts_tipo_chequera, 
	ts_monto, ts_saldo,ts_valor,
	ts_ubicacion, ts_hora,	ts_moneda, ts_causa
    	from  cob_cuentas..cc_tran_servicio_resp
	where ts_tipo_transaccion = 43556

	    if @@error <> 0
	    begin
	      print 'Error en insert (5) cob_cuentas..cc_tran_servicio'
	      return 1
	    end
	
--ref 10

return 0
go



