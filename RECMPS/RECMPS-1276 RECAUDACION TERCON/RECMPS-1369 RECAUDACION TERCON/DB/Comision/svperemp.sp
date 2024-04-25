/************************************************************************/
/*      Archivo:                svperemp.sp                             */
/*      Stored procedure:       sp_tr_person_empresa                    */
/*      Base de datos:          cob_pagos                               */
/*      Producto: Credito                                               */
/*      Disenado por:         Ana Mendez                                */
/*      Fecha de escritura:     05/31/2001                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO S.A.                 */
/*      o su representante.                                             */
/*                              PROPOSITO                               */
/*      Este programa realiza Realia en ingreso, consulta y modificacion*/
/*      de los registro de personalizacion de las empresas que se les   */
/*      brinda el servicio de recaudacion                               */
/*                                                      		*/
/*                              MODIFICACIONES                          */
/*                                                                      */
/*      FECHA           AUTOR           RAZON                           */
/*      05/31/2001      Ana Mendez      Emision inicial                 */
/*      12/13/2002      Ricardo Davila  Cambios de Personalizacion para */
/*                Impuesto a la Renta.                                  */
/*      02/21/2003      Ricardo Davila  Incluir el porcentaje de perso- */
/*                                      nalizacion de la Empresa.       */
/*      06/11/2003      Ricardo Davila  Incluir referencia para estados */
/*                                      de Cuentas                      */
/*      06/Ene/2004     Galo Yanez      Aumentar campo de nombre a 100  */
/*  6   06/Feb/2012     Daniel Pereira  CNEL-308-CU-1817                */
/*  7   12/15/2012      Ana Mendez      Distribución del Gasto Social   */
/*  8   11/05/2014      sandra Merino  RECBEL-AP-SGC00016734-SGC00016735*/
/*  9   07/Abr/2016     Jorge Pazminno  Facturacion Diaria              */
/*                                      Tarea: RECA-CC-SGC00024431      */
/* 10   27/Abr/2018     Daniel Pereira  DEPONL-AP-SGC00031612-SGC00031777*/
/* 11   11/Dic/2018     Daniel Pereira  CRSRI-1  - Códigos de Retención Imp Rent-SRI*/
/************************************************************************/

use cob_pagos
go

--if exists (select * from sysobjects where name = 'sp_tr_person_empresa')
if exists (select 1 from sysobjects where name = 'sp_tr_person_empresa')
    drop proc sp_tr_person_empresa
go

create proc sp_tr_person_empresa (
   @s_ssn          int      = null,
   @s_user         login    = null,
   @s_sesn         int    = null,
   @s_term         descripcion = null,
   @s_date         datetime = null,
   @s_srv    varchar(30) = null,
   @s_lsrv     varchar(30) = null,
   @s_rol    smallint = null,
   @s_ofi          tinyint  = null,
   @s_org_err    char(1) = null,
   @s_error    int = null,
   @s_sev    tinyint = null,
   @s_msg    descripcion = '',
   @s_org    char(1) = null,
   @t_rty          char(1)  = null,
   @t_trn          int      = null,
   @t_debug        char(1)  = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(30) = null,
   @i_operacion    char(1)     = null,
   @i_modo         smallint    = null,
   @i_empresa      int         = null ,
   @i_direccion    descripcion = null ,
   @i_ruc    varchar(13) = null ,
   @i_dias         smallint    = null,
   @i_laborables      char(1)  = null,
   @i_fpago        varchar(6)  = null,
   @i_tipo_cta     varchar(3)  = null,
   @i_cta          varchar(10) = null,
   @i_nombre       varchar(100) = null,     -- GYC 2004/Ene/06
   @i_costo        money       = null,
   @i_impret       tinyint     = null,          -- RDG 12/13/2002
   @i_oricat       int         = null,          -- RDG 12/13/2002
   @i_conta        tinyint     = null,          -- RDG 12/13/2002
   @i_porcentaje   int         = null,          -- RDG 02/21/2003
   @i_refestcta    tinyint     = null,
   @i_porc_retimp  float       = null,
   @i_grupo        char(1)     = null,    --#6 DAPV
   @i_cod_grupo    int         = null,    --#6 DAPV
   @i_concilia_grp char(1)     = null,    --#6 DAPV
   @i_acedita_grp  char(1)     = null,    --#6 DAPV
   @i_region_pais  char(8)     = null,    --#6 DAPV
   @i_cod_proveed  int         = null,    --#6 DAPV
   @i_dias_reint   int         = null,    --#6 DAPV
   @i_cod_serv     catalogo    = null,    --#6 DAPV
   @i_rubro        catalogo    = null,    --#6 DAPV
   @i_pe_impiva    tinyint     = null,    -- REF 7
   @i_porc_impiva  float       = null,    -- REF 7
   @i_serv_com     catalogo     = null ,    -- REF 7
   @i_imdCost      char(1)      = null,   -- REF 8 smerino   
   @i_fact_diaria  char(1)      = null,    -- JPM Ref.9
   @e_periodo_com  char(1)      = null,     --ref 10
   @e_cod_ret      char(6)      = null      --ref 11
)
as

declare
   @w_today             datetime,     /* fecha del dia */
   @w_return            int,          /* valor que retorna */
   @w_sp_name           varchar(32),  /* nombre stored proc*/
   @w_existe            tinyint,      /* existe el registro*/
   @w_pe_ruc            varchar(13),
   @w_pe_direccion      descripcion,
   @w_pe_nombre         varchar(100),       -- GYC 2004/Ene/06
   @w_pe_dias           int,
   @w_pe_laborables     char(1),
   @w_pe_fpago          varchar(6),
   @w_pe_producto       varchar(3),
   @w_pe_cuenta         cuenta,
   @w_pe_costo          money,
   @w_pe_impret         tinyint,
   @w_pe_oricat         int,
   @w_pe_conta          tinyint,
   @w_porcentaje        int,                    -- RDG 02/21/2003
   @w_refestcta         tinyint,
   @w_porc_retimp       float,
   @w_grupo             char(1),    --#6 DAPV
   @w_cod_grupo         int,        --#6 DAPV
   @w_concilia_grp      char(1),    --#6 DAPV
   @w_acedita_grp       char(1),    --#6 DAPV
   @w_region_pais       char(8),    --#6 DAPV
   @w_cod_proveed       int,        --#6 DAPV
   @w_dias_reint        int,        --#6 DAPV
   @w_cod_serv          catalogo,   --#6 DAPV
   @w_rubro             catalogo,    --#6 DAPV
   @w_pe_impiva         tinyint,    -- REF 7
   @w_porc_impiva       float,      -- REF 7
   @w_serv_com          catalogo ,   -- REF 7
   @w_imdCost           char(1),     -- REF 8 smerino
   @w_fact_diaria       char(1),      -- JPM Ref.9
   @v_periodo_com       char(1),      --ref 10
   @v_cod_ret		char(6)  	--ref 11
   



select @w_today = @s_date
select @w_sp_name = 'sp_tr_person_empresa'

/***********************************************************/
/* Codigos de Transacciones                                */


if (@t_trn <> 3225 and (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'Q'))
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 2101006
    return 1
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    SELECT
                 @w_pe_ruc        =  pe_ruc,
                 @w_pe_direccion  =  pe_direccion,
                 @w_pe_nombre     =  pe_nombre,
                 @w_pe_dias       =  pe_dias,
                 @w_pe_laborables =  pe_laborables,
                 @w_pe_fpago      =  pe_fpago,
                 @w_pe_producto   =  pe_producto,
                 @w_pe_cuenta     =  pe_cuenta,
                 @w_pe_costo      =  pe_costo,
                 @w_pe_impret     =  pe_impret,        -- RDG 12/13/2002
                 @w_pe_oricat     =  pe_oricat,        -- RDG 12/13/2002
                 @w_pe_conta      =  pe_conta,         -- RDG 12/13/2002
                 @w_porcentaje    =  pe_porcentaje,    -- RDG 02/21/2003
                 @w_refestcta     =  pe_refestcta,
                 @w_porc_retimp   =  pe_porc_retimp,
                 @w_grupo         =  pe_grupo  ,        --#6 DAPV
                 @w_cod_grupo     =  pe_cod_grupo,      --#6 DAPV
                 @w_concilia_grp  =  pe_concilia_grp,   --#6 DAPV
                 @w_acedita_grp   =  pe_acedita_grp,    --#6 DAPV
                 @w_region_pais   =  pe_region_pais,    --#6 DAPV
                 @w_cod_proveed   =  pe_cod_proveedor,  --#6 DAPV
                 @w_dias_reint    =  pe_dias_reintent,  --#6 DAPV
                 @w_cod_serv      =  pe_cod_serv,       --#6 DAPV
                 @w_rubro         =  pe_rubro,          --#6 DAPV
                 @w_pe_impiva     =  pe_impiva,         -- REF 7
                 @w_porc_impiva   =  pe_porc_impiva,    -- REF 7
                 @w_serv_com      =  pe_serv_com ,       -- REF 7
                 @w_imdCost       =  pe_imdCostCanal,  -- REF 8  smerino
                 @w_fact_diaria   =  pe_fact_diaria,      -- JPM Ref.9
                 @v_periodo_com   = pe_periodo_comision,  --ref 10
                 @v_cod_ret       = pe_cod_ret     --ref 11
         
    FROM cob_pagos..pg_person_empresa
                WHERE pe_empresa = @i_empresa



    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_empresa is NULL
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101001
        return 1
    end
end


/* Insercion del registro */
/**************************/
if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101002
        return 1
    end

    if @i_oricat = 0 select @i_oricat = null         -- RDG 12/13/2002

    begin tran
   
        insert into cob_pagos..pg_person_empresa
         ( pe_empresa, pe_ruc, pe_direccion, pe_nombre, pe_dias, pe_laborables, pe_costo, pe_fpago,
           pe_producto, pe_cuenta, pe_oricat, pe_impret, pe_conta, pe_porcentaje, pe_refestcta, pe_porc_retimp,
           pe_grupo,pe_cod_grupo,pe_concilia_grp,pe_acedita_grp,pe_region_pais,pe_cod_proveedor,pe_dias_reintent,
           pe_cod_serv,pe_rubro,pe_impiva,pe_porc_impiva, pe_serv_com,pe_imdCostCanal, pe_fact_diaria, pe_periodo_comision,
           pe_cod_ret)  -- #6 DAPV  REF 7  REF8 SMERINO -- JPM Ref.9 (pe_fact_diaria)
         values (   @i_empresa,
                    @i_ruc,
                    @i_direccion,
                    @i_nombre,
                    @i_dias,
                    @i_laborables,
                    @i_costo,
                    @i_fpago,
                    @i_tipo_cta,
                    @i_cta,
                    @i_oricat,
                    @i_impret,
                    @i_conta ,
                    @i_porcentaje ,
                    @i_refestcta,
                    @i_porc_retimp,
                    @i_grupo,
                    @i_cod_grupo,
                    @i_concilia_grp,
                    @i_acedita_grp ,
                    @i_region_pais ,
                    @i_cod_proveed ,
                    @i_dias_reint ,
                    @i_cod_serv   ,
                    @i_rubro,
                    @i_pe_impiva,     -- REF 7
                    @i_porc_impiva,   -- REF 7
                    @i_serv_com ,      -- REF 7
                    @i_imdCost,        ---REF 8 SMERINO
                    @i_fact_diaria,    -- JPM Ref.9
                    @e_periodo_com,    --ref 10
                    @e_cod_ret        --ref 11
                )

         if @@error <> 0
         begin
         /* Error en insercion de registro */

             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103001
             return 1
         end

         /* Transaccion de Servicio INSERT */
         /***************************/

      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_moneda, ts_tipo, ts_hora, ts_referencia,ts_servicio,
              ts_cta_banco, ts_causa,ts_ced_ruc,
              ts_descripcion_ec,ts_nombre,ts_cheque_rec,ts_ciclo, ts_valor, ts_corresponsal,ts_indicador,ts_descuento_iess,ts_cod_banco,
              ts_tipo_promedio)                                                                                                                       -- JPM Ref.9
      values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term,
              null, 'L', @s_lsrv, @s_date, @i_operacion,
              1, 'L', getdate(),@i_fpago,@i_tipo_cta,
              @i_cta, convert(varchar(6),@i_empresa),@i_ruc,
              @i_direccion,@i_nombre,@i_dias,@i_laborables,@i_costo, null, @i_pe_impiva ,@i_porc_impiva,@i_serv_com,    -- REF 7
              @i_fact_diaria)                                                                                                                         -- JPM Ref.9

         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003,
             @i_msg = "Error Insercion Trn de Servicio INSERT"
             return 1
         end
    commit tran
end


/* Actualizacion del registro */
/******************************/
if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2105002
        return 1
    end

    if @i_oricat = 0 select @i_oricat = null          -- RDG 12/13/2002

    begin tran
        --En caso de que un grupo lo cambien a regional.
        if @i_grupo = 'N'--#6 DAPV
        begin
          if exists(select 1 from cob_pagos..pg_person_empresa
                    where pe_cod_grupo = @i_empresa)
          begin
            /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_debug   = "N",
            @i_msg     = "Empresa fue definida como Grupo y tiene regionales asociadas",
            @i_num     = 999990
            return 1
          end
        end



         update cob_pagos..pg_person_empresa
                set pe_ruc        =  @i_ruc,
                    pe_direccion  =  @i_direccion,
                    pe_nombre     =  @i_nombre,
                    pe_dias       =  @i_dias,
                    pe_laborables =  @i_laborables,
                    pe_fpago      =  @i_fpago,
                    pe_producto   =  @i_tipo_cta,
                    pe_cuenta     =  @i_cta,
                    pe_costo      =  @i_costo,
                    pe_impret     =  @i_impret,            -- RDG 12/13/2002
                    pe_oricat     =  @i_oricat,            -- RDG 12/13/2002
                    pe_conta      =  @i_conta,             -- RDG 12/13/2002
                    pe_porcentaje =  @i_porcentaje,        -- RDG 02/21/2003
                    pe_refestcta  =  @i_refestcta,
                    pe_porc_retimp=  @i_porc_retimp,
                    pe_grupo      =  isnull(@i_grupo,'N'),            --#6 DAPV
                    pe_cod_grupo  =  @i_cod_grupo,        --#6 DAPV
                    pe_concilia_grp= isnull(@i_concilia_grp,'N'),     --#6 DAPV
                    pe_acedita_grp = isnull(@i_acedita_grp,'N'),      --#6 DAPV
                    pe_region_pais = @i_region_pais,        --#6 DAPV
                    pe_cod_proveedor = @i_cod_proveed,  --#6 DAPV
                    pe_dias_reintent = @i_dias_reint,   --#6 DAPV
                    pe_cod_serv      =  @i_cod_serv,     --#6 DAPV
                    pe_rubro         = @i_rubro ,       --#6 DAPV
                    pe_impiva        = @i_pe_impiva,    -- REF 7
                    pe_porc_impiva   = @i_porc_impiva,  -- REF 7
                    pe_serv_com      = @i_serv_com ,     -- REF 7
                    pe_imdCostCanal      = @i_imdCost,   -- REF 8  smerino
                    pe_fact_diaria       = @i_fact_diaria,   -- JPM Ref.9
                    pe_periodo_comision  = @e_periodo_com,    --ref 10
                    pe_cod_ret   = @e_cod_ret    --ref 11
                    WHERE pe_empresa = @i_empresa 


         if @@error <> 0
         begin
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1
         end
         
         /* smerino belcorp*/ 
         
         if @i_imdCost  != 'S'
         begin
          if exists(select 1 from cob_pagos..pg_costo_com_canal
	                      where pg_empresa = @i_empresa)
          begin
          
                delete from cob_pagos..pg_costo_com_canal
	        where pg_empresa=@i_empresa 
                --and pg_canal=@i_canal
          
          end
         
         
         end

         /* Transaccion de Servicio   UPDATE */
         /***************************/


      -- Transaccion servicio
      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_moneda, ts_tipo, ts_hora, ts_referencia,ts_servicio,
              ts_cta_banco, ts_causa,ts_ced_ruc,
              ts_descripcion_ec,ts_nombre,ts_cheque_rec,ts_ciclo,ts_valor,ts_corresponsal,ts_indicador,ts_descuento_iess,ts_cod_banco,
              ts_tipo_promedio)                                                                                                          -- JPM Ref.9
      values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term,
              null, 'L', @s_lsrv, @s_date, @i_operacion,
              1, 'L', getdate(),@w_pe_fpago,@w_pe_producto,
              @w_pe_cuenta, convert(varchar(6),@i_empresa),@w_pe_ruc,
              @w_pe_direccion,@w_pe_nombre,@w_pe_dias,@w_pe_laborables,@w_pe_costo,null ,@w_pe_impiva , @w_porc_impiva,@w_serv_com,   -- REF 7
              @w_fact_diaria)                                                                                                           -- JPM Ref.9
         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003,
             @i_msg = "Error Insercion Trn de Servicio UPDATE ANTERIOR"
             return 1
         end


         /* Transaccion de Servicio UPDATE NUEVOS*/
         /***************************/

      -- Transaccion servicio
      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial,ts_cod_alterno, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_moneda, ts_tipo, ts_hora, ts_referencia,ts_servicio,
              ts_cta_banco, ts_causa,ts_ced_ruc,
              ts_descripcion_ec,ts_nombre,ts_cheque_rec,ts_ciclo,ts_valor,ts_corresponsal,ts_indicador,ts_descuento_iess,ts_cod_banco,
              ts_tipo_promedio)                                                                                                             -- JPM Ref.9
      values (@s_ssn,1, @t_trn, @s_ofi, @s_user, @s_rol, @s_term,
              null, 'L', @s_lsrv, @s_date, @i_operacion,
              1, 'L', getdate(),@i_fpago,@i_tipo_cta,
              @i_cta, convert(varchar(6),@i_empresa),@i_ruc,
              @i_direccion,@i_nombre,@i_dias,@i_laborables,@i_costo,null, @i_pe_impiva , @i_porc_impiva,@i_serv_com, -- REF 7
              @i_fact_diaria)                                                                                                               --JPM Ref.9

         if @@error <> 0
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2103003,
             @i_msg = "Error Insercion Trn de Servicio UPDATE NUEVOS"
             return 1
         end
    commit tran
end


/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
       begin
            select
                 @w_pe_ruc,
                 @w_pe_direccion,
                 @w_pe_nombre,
                 @w_pe_dias,
                 @w_pe_laborables,
                 @w_pe_fpago,
                 @w_pe_producto,
                 @w_pe_cuenta,
                 @w_pe_costo,
                 @w_pe_impret,
                 @w_pe_oricat,
                 @w_pe_conta,
                 @w_porcentaje,
                 @w_refestcta,
                 @w_porc_retimp,
                 @w_grupo,
                 @w_cod_grupo,
                 @w_concilia_grp,
                 @w_acedita_grp,
                 @w_region_pais,
                 @w_cod_proveed,
                 @w_dias_reint,
                 @w_cod_serv,
                 @w_rubro,
                 @w_pe_impiva,     -- REF 7
                 @w_porc_impiva,   -- REF 7
                 @w_serv_com  ,     -- REF 7
                 @w_imdCost,    ---REF 8
                 @w_fact_diaria,     -- JPM 9
                 @v_periodo_com, --ref 10
                 @v_cod_ret     --ref 11

       end
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1
    end
end
return 0
go
