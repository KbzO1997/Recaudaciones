/************************************************************************/
/*    Archivo           : pgbroadnets.sp                                */
/*    Stored procedure  : pa_pag_c_concilia_broadnet_s                  */
/*    Base de datos     : cob_pagos                                     */
/*    Producto          : Cuentas de pagos                              */
/*    Disenado por      : Danny Olaya S.                                */
/*    Fecha de escritura: 02/May/2019                                   */
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
/*  Este proceso realiza la CONSULTA conciliacion de las recaudaciones  */ 
/*  de Broadnet                                                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/* 1  02/May/2019   Danny Olaya S.  RRCYT-4 (JIRA)   Emision Inicial  */
/* 2  03/Jun/2019   Danny Olaya S.  RRCYT-12   Actualizar el orden de busqueda por el secuencial Banco  */
/* 3  06/Jun/2019   Danny Olaya S.  RECA-CE-SGC00035614  Ajustes Recargas CNT y TUENTI*/
/************************************************************************/

use cob_pagos
go

if exists (select 1 from [dbo].sysobjects where name = 'pa_pag_c_concilia_broadnet_s')
   drop proc [dbo].pa_pag_c_concilia_broadnet_s

go


create procedure [dbo].pa_pag_c_concilia_broadnet_s
(      
   @e_fecha                varchar(10),
   @e_empresa			   varchar(5),
   @e_siguiente            int          = null,
   @e_estado_bco           varchar(5)   = null,
   @e_estado_emp           varchar(5)   = null,
   @e_forma_pago           varchar(10)  = null 
)

as

--Consulta desde el FE, vista para el Usuario

   set rowcount 15   

   if @e_estado_bco = 'TODOS' 
   begin
      select @e_estado_bco = null
      select @e_forma_pago = null
   end
      
   if @e_estado_emp = 'TODOS'
   begin
      select @e_estado_emp = null
      select @e_forma_pago = null
    end   
   if (@e_estado_bco =  'SI'and @e_estado_emp =  'NO')
   select @e_forma_pago = @e_forma_pago
  else 
    select @e_forma_pago = null

   select
   'Codigo'             = co_celular,
   "Nombre del Abonado" = isnull(co_nombre,'NO EXISTE NOMBRE'),
   "Valor"              = co_valor,
   "Fecha.Cont"         = convert(varchar(10),co_fec_cble,101),
   "Hora Local"         = substring(co_hora_trn_local,1,2) + ":" +
                          substring(co_hora_trn_local,3,2) + ":" +
                          substring(co_hora_trn_local,5,2),
   "Resultado"          = case co_conciliada when  null then 
   
        case co_resultado when "OK" then "OK"
                                            when "BO" then "POR HABILITAR" --ref003
                                            when "IE" then "POR REVERSAR"
        end
                      when "A" then 
        case co_resultado when "OK" then "OK"
                                            when "BO" then "AJUSTADO HABILITAR" --ref003
                                            when "IE" then "AJUSTADO REVERSAR"
        end
                    when "S" then 
        case co_resultado when "OK" then "OK"
                                            when "BO" then "HABILITADO" --ref003
                                            when "IE" then "REVERSADO"
        end
                          end
                          ,
   "Status Bco."        = co_estatus_bco,
   "Status Emp."        = co_estatus_emp_serv,
   "Usuario"            = co_usuario,
   "Autorizacion"       = co_num_autoriz,
   "Sec.BANCO"          = co_autoriz_bco,
   "Canal"				= co_canal,
   "Tipo. Trx."         = co_tip_trx,
   "Est.Conc."          = isnull(co_conciliada,''),
   "Fecha Real"         =  convert(varchar(10),co_fecha_real,101),
   "Tipo Cta"           = case co_tipo_cuenta 
                              when 'A'  then 'AHO'
                              when 'CA' then 'AHO'
                              when 'C'  then 'CTE'
                              when 'CC' then 'CTE'
                              when 'P' then 'BAS'
                          end,
   "Nro.CTA."           = co_nro_cuenta
   from cob_pagos..pag_t_concilia_broadnet 
   where co_fec_cble  = @e_fecha
   and   co_empresa = @e_empresa
   and   co_autoriz_bco > @e_siguiente --ref002                                                
   and (co_estatus_bco = @e_estado_bco or @e_estado_bco is null)                   
   and (co_estatus_emp_serv = @e_estado_emp or @e_estado_emp is null) 
   --and (co_forma_pago = @e_forma_pago or @e_forma_pago is null) --ref003             
   order by co_autoriz_bco

   set rowcount 0

return 0

go
