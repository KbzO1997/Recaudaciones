use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_pago_servicio_luz' and type = 'P')
begin
   drop procedure dbo.sp_pago_servicio_luz
   if exists (select 1 from sysobjects where name = 'sp_pago_servicio_luz' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_pago_servicio_luz -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_pago_servicio_luz *OK* =='
end
go

/**********************************************************************************/
/*  Archivo:            pgpagsl.sp                                                */
/*  Motor de Base:      SYBASE                                                    */
/*  Base de datos:      cob_pagos                                                 */
/*  Servidor:           HP-ACT                                                    */
/*  Aplicacion:         CyberBank                                      	          */
/*  Stored procedure:   sp_pago_servicio_luz                                      */
/*  Procesamiento:      OLTP                              			              */
/*  Ult.ControlTarea:   J-RECMPS-2375                          		              */
/*  Ult.Referencia:     REF 32                          			              */
/*  Disenado por:       Daniel Pereira V.                                         */
/*  Fecha de escritura: 02/Mar/2012                                               */
/**********************************************************************************/
/*              IMPORTANTE                                                        */
/*  Este programa es parte de los paquetes bancarios propiedad de                 */
/*  "BANCO BOLIVARIANO".                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como                    */
/*  cualquier alteracion o agregado hecho por alguno de sus                       */
/*  usuarios sin el debido consentimiento por escrito de la                       */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.                */
/**********************************************************************************/
/*              PROPOSITO                                                         */
/*  Este programa procesa la recaudacion de CNEL                                  */
/**********************************************************************************/
/*              MODIFICACIONES                                                    */
/*REF  FECHA       AUTOR           RAZON                                          */
/*    02/Mar/2012   Daniel Perira    CNEL-308-CU-1816  Emisión inicial            */
/*    05/09/2012    Daniel Perira   CNEL-308-CU-1818                              */
/*    30/Mayo/2012  Daniel Pereira  CTE-CC-11287                                  */
/*    19/Jun/2012   Daniel Pereira  CTE-CC-10524                                  */
/*    Jun 27/2012   Galo Yanez  Pasar parametro categoria de                      */
/*                  cuenta de ahorros                                             */
/*                  Tarea: AHO-CC-11589                                           */
/* 6  25/Oct/2012   Daniel Pereita  CTE-CC-SGC00004849                            */
/* 7  17/Dic/2012   Daniel Pereira  CTE-CC-SGC00006244 - IVA                      */
/* 8  25/Ene/2013   Daniel Pereira  CTE-CC-SGC00007058 - PROYECTO IVA             */
/* 9  20/Ene/2014   Daniel Pereira  SGC00012170 Facturacion Electronica           */
/* 9  16/DIC/2013   Sandra Merino   CNB-316-CU-1901                               */
/*10  16/AGO/2014   Sandra Merino   CNB-316-CU-1902                               */
/*11  16/AGO/2014   Sandra Merino   CNB-316-CU-1903                               */
/*12  05/Nov/2014	Ana Mendez  CTE-CE-SGC00018176 		                          */
/*13  03/Marz/2015  Daniel Pereira  RECA-CC-21099 Migración EEQ a CNEL            */
/*14  07/Sep/2015   smerino  CTE-CE-SGC00022682                                   */
/*15  03/Mar/2016   Daniel Pereira  CTE-CC-SGC00024474		                      */
/*16  02/Julio/2015 Sandra Merino   CENSUR-AP-SGC00019459-SGC00019464             */
/*17  09/Mar/2015   J.Pazminno      Cuenta Basica - CNB                           */
/*                                  Tarea: CB-AP-SGC00018374-SGC00018798          */
/*18  02/Ago/2016   Luis Banda  RECA-CC-SGC00025868 se valida comision para       */
/*                  oficina damnificados segun comercio                           */
/*19  18/Nov/2016  María José Silva CNEL nombre cliente Tarea: RECA-CE-SGC00027123*/
/*20  21/Nov/2016  Daniel Pereira   MEER-AP-SGC00026606-SGC00026617               */
/*21  04/Ene/2017  Pablo Ricaurte   SGC00027539/MEER-AP-SGC00026606-SGC00026623   */
/*22  05/Ene/2017  Vanessa Miranda  MEER-AP-SGC00026606-SGC00026623 Hacer referencia*/
/*                 a empresa MEER por medio de catálogo                             */
/*23  15/Abr/2017  Maria Jose Silva   Tarea:RECA-CC-SGC00028461  Cobro Debito Automatico*/
/*24  25/Jul/2017  Daniel Pereira     CAJ-CC-SGC00028304 cobro comision canal ATM */
/*25  14/Dic/2017  Danny Olaya Soriano RECA-CC-SGC00030521 Cobro comisión empresas MEER */
/*26  29/Mar/2018  Alejandro Proaño  INT-CC-SGC31474 Cambiar descripcion Canal 24online */
/*27  23/Ene/2017  Maria Jose Silva  Tarea:SGC00030409 - Facturacion OffLine Debitos*/
/*28  04/May/2020  Daniel Pereira    RECMPS-502  Migracion Latinia                  */
/*29  16/Sept/2020 Luis Gusñay C.    RECMPS-171 PAGO DOMICILIADO BB                 */
/*30  08/Agos/2022 Dario Espinosa.   RECM-603 MEJORA CONTRAPARTIDAS PAGO DE LUZ     */
/*31  03/Jul/2023  Dario Espinosa.   RECM-418 NOTIFICACIONES LATINIA CNEL CANAL SAT */
/*32  07/Jul/2023  Jonathan Guerrero RECMPS-2375 EXONERACION DE COMISION            */
/************************************************************************************/

create procedure dbo.sp_pago_servicio_luz (
       @s_ssn               int,
       @s_user              varchar(30),
       @s_sesn              int=null,
       @s_term              varchar(10),
       @s_date              datetime,
       @s_srv               varchar(30),
       @s_lsrv              varchar(30),
       @s_ofi               smallint,
       @s_rol               smallint,
       @s_org_err           char(1) = NULL,
       @s_error             int     = NULL,
       @s_sev               tinyint = NULL,
       @s_msg               mensaje = NULL,
       @s_org               char(1),
       @t_debug             char(1) = 'N',
       @t_file              varchar(14) = null,
       @t_from              varchar(32) = null,
       @t_rty               char(1) = 'N',
       @t_trn               int,
       @t_corr              char(1) = 'N',
       @t_ssn_corr          int = null,
       @i_mon               tinyint,
       @i_empresa           int,
       @i_codigo            varchar(15),
       @i_digver            char(1),
       @i_val               money = 0,
       @i_valch             money = null,
       @i_debito            money = null,
       @i_reten             money = null,
       @i_tipocta           char(3) = null,
       @i_cuenta            cuenta = null,
       @i_opcion            char(1) = null,
       @i_autoriza          char(1) = 'N',
       @i_tsn               int = null,
       @i_aplcobis          char(1) = 'S',
       @i_ind_costo         char(1) = 'N',
       @i_costo             money = 0,
       @i_canal             varchar(14) = 'VEN',
       @i_comprob           char(15) = null,
       @i_ubi               int      = null,
       @i_cant_chq          int = null,
       @i_comision          money = 0,
       @i_efe_com           money = 0,
       @i_chq_com           money = 0,
       @i_deb_com           money = 0,
       @i_nombre            varchar(30) = null,
       @i_ptotal_pendiente  int         = null,
       @i_phoralocal        varchar(6)  = null,
       @i_pnumero           varchar(20) = null,
       @i_pfactura          varchar(15) = null,
       @i_pcuenta           varchar(64) = null,   --REF:20
       @i_psecmactrans      varchar(6) = null,
       @i_pcodseguridad     varchar(6)  = null,
       @o_fecha_comp        varchar(8) = null out,
       @o_secmt             varchar(6) = null out,
       @o_codautorizador    int = null out,
       @o_nombre            varchar(30) = null out,
       @o_saldo             money = null out,
       @o_horario           char(1) = null out,
       @o_digver            char(1) = null out,
       @o_costo             money = null out,
       @o_fecha_efe         varchar(8) = null out,
       @o_comisionven       money = null out,
       @o_autorisri         varchar(30) = null out,
       @o_fecvensri         varchar(30) = null out,
       @o_nota_venta        varchar(15) = null out,
       @o_ssn               int = null out,
       @o_consulta          int = null out,
       @o_msg               varchar(200) = null output,
       @o_fecha_emision     varchar(20) = null out,
       @o_fechacontable     varchar(10) = null out,
       @i_user              varchar(30) = null,
       @o_base_imp          float = 0 out,  --REF36 CNB
       @o_impuesto          float = 0 out , --REF36
       @i_sec_atm	    int = null ,
       @o_servicio_not 	varchar(5) = null out,
       @o_nomb_ente     varchar(64) = null out,	
       @o_cod_ente      varchar(20) = null out,	
       @o_desccanal     varchar(16) = null out,	
       @o_celular       varchar(10) = null out,	
       @o_correo        varchar(64) = null out,	
       @o_desc_empresa  varchar(32)  = null out,	
       @o_prod_deb      char(3) = null out, 
       @o_valor		varchar(11) = null out, 
       @o_fecha_deb	varchar(10) = null out,  
       @o_hora_deb 	varchar(8) = null out,     
       @o_valor_comi	varchar(11) = null out, 
       @o_valor_tot	varchar(11) = null out, 	
       @o_cta_lat	char(3)  = null out 
       )
as
declare
        @w_return           int,
        @w_sp_name          varchar(30),
        @w_monto            money,
        @w_val_usd          money,
        @w_valch_usd        money,
        @w_debito_usd       money,
        @w_debito_usd_bak   money,
        @w_reten_usd        money,
        @w_tipocta          char(1),
        @w_hora_tope        int,
        @w_hora_sys         char(8),
        @w_hora             int,
        @w_secuencial       int,
        @w_control_nc       char(1),
        @w_codigo           varchar(30),
        @w_rubro            char(4),
        @w_servicio         char(4),
        @w_desc_canal       varchar(16),
        @w_desc_empresa     varchar(32),
        @w_valor_debito     varchar(11),
        @w_cliente          int,
        @w_fecha_deb        varchar(10),
        @w_fecha_proc       datetime,
        @w_ssn              int,
        @w_ndcta            money,
        @w_debito_BR        money,
        @w_offline          char(1),
        @w_ind_diferido     char(1),
        @w_emp              varchar(6),
        @w_id_detalle       smallint,
        @w_fecha_hoy        varchar(10),
		@w_comision		    money,
        @w_comision_serv    money,
        @w_comision_sat     money,
        @w_accion_iva_cero  char(1),
        @w_accion_iva       char(1),
        @w_iva              float,
        @w_total_comision   money,
        @w_total_com        money,
        @w_numdeci          tinyint,
        @w_usadeci          char(1),
        @w_categoria      char(1),      -- GYC 2012/Jun/27
        @w_ret_planilla     money,
        @w_ret_factor       money,
        @w_causa            varchar(10),
        @w_caus_comi        varchar(10), --smerino
        @w_trn              int,
        @w_serie            varchar(6),
        @w_band             tinyint,
        @w_hora_trn         varchar(5),
        @w_hora_dif         varchar(9),
        @w_efec_atm         money ,
        @w_grupo            char(1),
        @w_cod_provee       int,
        @w_cod_grupo        int,
        @w_error            varchar(64),
        @w_errCliente       varchar(15),
        @w_monto_maximo     money,
        @w_maximo_p         money,
        @w_fecha_desde_excep    datetime,
        @w_fecha_hasta_excep    datetime,
        @w_hora_dif_excep       varchar(8),
        @w_resul            char(5),
        @w_cont             int,
        @w_flag             int,
        @w_tasa             money, --REF7
        @w_base_imp         float, --REF7
        @w_impuesto2        float,  --REF7
        @w_correo               varchar(64),   --Ref 9 smerino
        @w_telefono             varchar(10),--Ref 9 smerino
        @w_codservicio          varchar(5),--Ref 9 smerino
        @w_trx_orig             int, --SMERINO CNB
        @w_trx_sec_orig         int, --SMERINO 
        @w_hora_deb             varchar(8),     --SMERINO 
        @w_rows                 int,            -- JPM Ref.17 -->
        @w_tipo_cta             char(3),
        @w_mensaje              varchar(132),
        @w_num_error            int,
        @w_producto             char(3),
        @w_detalle_error        descripcion,
        @w_tab_causrv           char(30) ,       -- <-- JPM Ref.17
     @w_valor_compensa   money,
     @w_ofi              int,
     @w_com_original     money,
     @w_aplica_des       char(1),
	@w_causa_orig	varchar(6),	--REF:21 pricaura
	@w_numTransacciones int,	--REF:21 pricaura
    @w_empresa          varchar(5), --Ref023:msilvag 
    @w_total            varchar(11),
    @w_comision_tran    varchar(11),    
    @w_control_mostrar  varchar(20), -->para no mostrar ciertos campos en la plantilla, Cargo Servicio Financiero/total para quienes no envíen estos datos
    @w_total_sms        varchar(11),
    @w_es_meer          char(1),
    @w_comision_avi24   char(1),
	@w_codigo_servicio			varchar(24) ,
	@w_area				char(2)		,
	@w_oficina_asume	int			,
	@w_es_banco		char(1),
	@w_estado		char(1),
	@w_existe		char(1),
	@o_codigo_error int,
	@o_descri_error varchar(64),
	@o_tipo_trn int

    select @w_control_mostrar ='considera', @w_es_meer ='N',@w_comision_avi24 ='N'

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_pago_servicio_luz'
select @w_empresa = convert(varchar, @i_empresa)
 
/*REF18 Inicio LBP*/
if @i_canal = 'CNB'
   select @w_ofi = @s_ofi, @s_ofi = 0 
   else
   if @i_canal = 'VEN'
      select @w_ofi = @s_ofi
/*REF18 Fin LBP*/

select @o_base_imp=0 ,@o_impuesto=0 ,@w_trx_sec_orig =0
select @w_hora_deb = convert(varchar(8),getdate(),108)  -- HORA debito smerino

select @t_trn = 3916 ,@o_ssn = @s_ssn --REF8

---ref22 inicio
select @s_date =convert(varchar(10), @s_date,101) --se le quita la hora
   
--***********ref24 inicio
if @i_empresa in(select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
   select @w_es_meer='S'
  
if exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on c.tabla=t.codigo
where t.tabla='pg_canales_serbas_comision' and estado='V' and c.codigo=@i_canal)
   select @w_comision_avi24 ='S'
 --***********ref24 fin
    
--EEQutiliza otra transacción
if exists(select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
          and t.tabla='sv_emp_meer_tran_pers' and estado='V' and convert(int, c.codigo) =  @i_empresa)
          select @t_trn = 3173
---ref22 fin

--obtengo el usuario de ATM
if @i_canal in  ('ATM','IVR','KSK')  --REF15    -- Ref.16 smerino se comenta 'IBK'
begin 
      --ref22 inicio
      if @i_canal in  ('ATM')
          select @s_user = isnull(@i_user,@s_user)
      else--ref22 fin      
          select @s_user = @i_user
end
   
 if @i_canal in  ('CNB')
   select @i_costo = 0  

--INI REF:20
if exists(select 1 from cobis..cl_tabla a, cobis..cl_catalogo b
 	  where a.tabla = 'pg_reca_emp_elect_meer'
 	  and a.codigo = b.tabla
   	  and convert(int,b.codigo) = @i_empresa
          and estado = 'V')  
begin
	select @w_errCliente = convert(varchar,@i_codigo) 
end
else
--FIN REF:20
    select @w_errCliente = convert(varchar,@i_codigo)  --Ref023:msilvag (convert(varchar,@i_codigo) + @i_digver)


/*Asignar Fecha de Proceso a la variable @s_date*/
if @s_date is null
begin
     select @s_date = fp_fecha from cobis..ba_fecha_proceso
end

select @w_fecha_hoy = convert(varchar(10), getdate(),101)
select @w_fecha_deb = convert(varchar(10),getdate(),101)   -- Fecha debito

select @w_fecha_proc = fp_fecha        -- Fecha proceso
from cobis..ba_fecha_proceso

select @w_ret_factor = 0.11  --VALOR MAS MENOS PARA PAGO CON RETENCION EN EMELGUR
select @w_band  = 0

select
  @w_servicio   = pe_cod_serv,
  @w_rubro      = pe_rubro,
  @w_grupo      = pe_grupo,
  @w_cod_provee = pe_cod_proveedor,
  @w_cod_grupo  = pe_cod_grupo
from cob_pagos..pg_person_empresa
where pe_empresa  = @i_empresa

--< HORA TOPE <
select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
  from cobis..cl_tabla a, cobis..cl_catalogo b
 where a.tabla = 'sv_horario_serv'
   and a.codigo = b.tabla
   and convert(int,b.codigo) = @i_empresa
   and estado = 'V'
if @@rowcount = 0 or @w_hora_tope = 0
begin
  if @i_aplcobis = 'S'
  begin
     exec cobis..sp_cerror
     @t_debug         = @t_debug,
     @t_file          = @t_file,
     @t_from          = @w_sp_name,
     @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
     @i_num           = 37601 --smerinom
      return 37601 --smerinom
   end
   else
      return 37601
end
--Ref029:lgusnayc Inicio
if @i_canal in ('DIR') 
begin
	select @w_emp = convert(varchar(6),@i_empresa)

	exec @w_return= cob_pagos..pa_cc_cservicioBanco	
		@e_referencia		= @i_codigo ,
		@e_tipo_servicio    = 'L',
		@s_codigo			= @w_codigo_servicio out,
		@s_area				= @w_area	out,
		@s_oficina_asume	= @w_oficina_asume out,
		@s_es_banco		= @w_es_banco out,
		@s_estado = @w_estado out,
		@s_existe = @w_existe out

	if @w_return != 0
	begin
		return @w_return
	end

	if @w_es_banco = 'S' --S:es del banco
	begin
		if @w_existe = 'S' --Si existe en la pg_servicios
		begin
			if @w_estado = 'A' --Si el domiciliado BB esta Activo
			begin
				exec @w_return = cob_pagos..pa_cc_iconservicioBanco
					@s_ssn				= @s_ssn			,
					@s_date				= @s_date	,
					@s_user				= @s_user ,
					@s_term             = @s_term ,
					@t_corr				= @t_corr ,
					@t_ssn_corr			= @t_ssn_corr ,
					@t_debug            = @t_debug ,
					@t_file             = @t_file ,
					@s_rol              = @s_rol ,
					@e_empresa			= @w_emp	,
					@e_referencia	 	= @i_codigo ,
					@e_debito			= @i_debito	,
					@e_deb_com			= 0 ,
					@e_aplcobis			= 'N' ,
					@e_nombre			= @i_nombre ,
					@e_canal			= @i_canal 	,
					@e_autorizante      = 'automatico',
					@e_codigo			= @w_codigo_servicio ,
					@e_area				= @w_area		,
					@e_oficina_asume	= @w_oficina_asume		,
					@e_psecmactrans		= @i_psecmactrans,
					@e_tipo_servicio    = 'L',
					@s_codigo_error		= @o_codigo_error out,
					@s_descri_error		= @o_descri_error out,
					@s_nombre			= @o_nombre out,
					@s_horario 			= @o_horario out ,
					@s_trn				= @o_tipo_trn out
					
					if @w_return != 0
					begin
						return @w_return
					end
					return 0
			end -- w_estado ='A'
			else
			begin --Es banco pero esta Inactivo.
					update pg_dbautomatico_servicio
                      set sd_errores = "DOMICILIADO NO ACTIVO",
                      sd_fecha_ult_pag = @w_fecha_hoy
                      where sd_empresa = @i_empresa
                      and sd_codigo  = @i_codigo

				  if @@error !=0
					begin
						rollback tran
						return 1
					end
					commit tran
					return 0
			end-- domiciliado inactivo
		end -- existe en la pg_servicios
		else
		begin --No existe en la pg_servicios
			update pg_dbautomatico_servicio
			  set sd_errores = "ES DOMICILIADO BB PERO NO EXISTE EN LA PG_SERVICIOS",
			  sd_fecha_ult_pag = @w_fecha_hoy
			  where sd_empresa = @i_empresa
			  and sd_codigo  = @i_codigo

			if @@error !=0
			begin
				rollback tran
				return 1
			end
			commit tran
			return 0
		end --No existe en la pg_servicios
	end --S:es del banco
end
--Ref029:lgusnayc Fin

if @i_canal in ('VEN' ,'CNB')
begin
   --Identifico si estoy en el horario normal o diferido
   select @w_hora_trn = convert(varchar,getdate(),108)
   select @w_hora_dif = rh_inicio ,
          @w_fecha_desde_excep =rh_fecha_desde,
          @w_fecha_hasta_excep = rh_fecha_hasta,
          @w_hora_dif_excep = rh_nuevo_inicio
   from cob_remesas..re_horario where rh_oficina = @s_ofi and rh_ubicacion = @i_ubi

   ---Si la fecha de proceso esta dentro delperiodo de excepcion reemplazo la hora del diferido por la hora de excepcion
   if  @s_date >= @w_fecha_desde_excep  and @s_date <= @w_fecha_hasta_excep
      select @w_hora_dif = @w_hora_dif_excep
   if  @w_hora_trn >= @w_hora_dif
   begin
      select @t_trn = 3917,@w_ind_diferido = 'S'      --Horario Diferido    3213 = TrxLuzAjusteDiferido
      ---ref22 inicio
      --EEQutiliza otra transacción
      if exists(select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                and t.tabla='sv_emp_meer_tran_pers' and estado='V' and convert(int, c.codigo) =  @i_empresa)
                select @t_trn = 3202
      ---ref22 fin   
   end
   else
   begin
      select @t_trn = 3916      --Horario Normal
      
      ---ref22 inicio
      --EEQutiliza otra transacción
      if exists(select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                and t.tabla='sv_emp_meer_tran_pers' and estado='V' and convert(int, c.codigo) =  @i_empresa)
                select @t_trn = 3173
      ---ref22 fin
   end   
end

select @o_nombre = @i_nombre
select @o_codautorizador = convert(int,@i_pcodseguridad)
select @o_secmt = @i_psecmactrans
select @o_fechacontable = convert(varchar(10),@s_date,101)

   select @o_autorisri = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'NUMAUT'
     and pa_producto = 'CTE'

   if @@rowcount <> 1
   begin
      if @i_aplcobis = 'S'
      begin
         exec cobis..sp_cerror
              @t_from = @w_sp_name,
              @i_num = 101085
         return 101085
      end
      else
         return 101085
   end


 select @w_serie = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'SERNV'
     and pa_producto = 'CTE'

    select @w_offline = atm_offline
    from cobis..ba_fecha_proceso

    select @o_fecha_efe = convert(varchar(8),@s_date,112)
    -- Validar Montos de la retencion
    if @i_reten > 0 and @i_comprob = null
    begin
      if @i_aplcobis = 'S'  -- Controlar el error para aplicaciones COBIS
      begin
        exec cobis..sp_cerror
                  @t_debug  = @t_debug,
                  @t_file   = @t_file,
                  @t_from   = @w_sp_name,
                  @i_msg    = "Ingrese Codigo del Comprobante de retencion",
                  @i_num    = 34000  --031063
      return 34000    --smerinomwrp
      end
      else  -- Controlar el error para aplicaciones como ATM
        return 34000   --smerinom
      end

    -- Valida si se ha aperturado caja
    if @s_org = 'U' and @i_aplcobis = 'S' and @i_canal = 'VEN'
    begin
        exec @w_return = cob_remesas..sp_verifica_caja_rc
                @s_ssn   = @s_ssn,
                @s_srv   = @s_srv,
                @s_lsrv  = @s_lsrv,
                @s_user  = @s_user,
                @s_term  = @s_term,
                @s_date  = @s_date,
                @s_ofi   = @s_ofi,
                @s_rol   = @s_rol,
                @s_sev   = @s_sev,
                @s_msg   = @s_msg,
                @s_org   = @s_org,
                @t_trn   = @t_trn,
                @t_corr  = @t_corr,
                @i_mon   = @i_mon,
                @i_ubi   = @i_ubi,
                @o_horario = @o_horario out
        if @w_return != 0
            return @w_return
    end

    --> ESTABLEZCO HORARIO DE PAGO >
    if @i_canal in ( 'VEN','CNB') and @w_ind_diferido = 'S' and isnull(@i_valch,0) = 0
    begin
       select @t_trn = 3916, @w_ind_diferido = 'N'
       
    ---ref22 inicio
    --EEQutiliza otra transacción
      if exists(select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
          and t.tabla='sv_emp_meer_tran_pers' and estado='V' and convert(int, c.codigo) =  @i_empresa)
          select @t_trn = 3173
    ---ref22 fin
       
    end

    select @w_hora_sys = convert(varchar(08),getdate(),108)
    select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))

    select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
    if @w_hora >= @w_hora_tope  and @s_date = @w_fecha_hoy
     begin
      select @t_trn = 3919, @w_ind_diferido = 'S'
      
      ---ref22 inicio
      --EEQutiliza otra transacción
      if exists(select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
          and t.tabla='sv_emp_meer_tran_pers' and estado='V' and convert(int, c.codigo) =  @i_empresa)
          select @t_trn = 3202
      ---ref22 fin
      
      select @o_fecha_efe = convert(varchar(8),min(dl_fecha),112),
             @o_fechacontable = convert(varchar(10),min(dl_fecha),101) --ref22
              from cob_cuentas..cc_dias_laborables
             where dl_ciudad = 1
               and dl_num_dias = 1
     end

    -- validar que la NC no se haya realizado
      select @w_control_nc = b.valor
      from cobis..cl_tabla a, cobis..cl_catalogo b
      where a.tabla = 'sv_nc_servicios'
        and a.codigo = b.tabla
        and convert(smallint,b.codigo) = @i_empresa
        and estado = 'V'

      if @w_control_nc = 'S' and @w_ind_diferido = 'N'
      begin
         if @i_aplcobis = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'CREDITO A EMPRESA YA REALIZADO NO SE PUEDEN REALIZAR TRX',
                 @i_num           = 37603  --smerinom
            return 37603 --smerinom WRP
         end
         else
            return 37603
      end

    -- Rutina que realiza verificacion de moneda de la cuenta
      exec @w_return = cob_cuentas..sp_convierte_valor
           @i_valor  = @i_val,
           @i_val2   = @i_valch,
           @i_moneda = @i_mon,
           @o_val_usd_neto = @w_val_usd out,
           @o_val_usd_val2 = @w_valch_usd out
      if @w_return != 0
         begin
           if @i_aplcobis = 'S'
           begin
             exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'ERROR EN LA RUTINA DE CONVERSION',
                 @i_num           = 37607 --smerinom

                 return 37607 --smerinom WRP
           end
           else
             return 37607
         end

          exec @w_return = cob_cuentas..sp_convierte_valor
           @i_valor  = @i_debito,
           @i_val2   = @i_reten,
           @i_moneda = @i_mon,
           @o_val_usd_neto = @w_debito_usd out,
           @o_val_usd_val2 = @w_reten_usd out
      if @w_return != 0
         begin
           if @i_aplcobis = 'S'
           begin
             exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'ERROR EN LA RUTINA DE CONVERSION',
                 @i_num           = 37607  --smerinom
             return 37607  --WRP smerinom
           end
           else
            return 37607
         end
         
         
         ---SMERINO 
         if @t_corr = 'S'
	 begin
	           
	           select @w_trx_orig = ts_tipo_transaccion,    -- identifica trx original
	                  @w_trx_sec_orig = ts_secuencial,     -- identifica trx original
					  @w_causa_orig = ts_causa	--REF:21 pricaura
	       	      from cob_cuentas..cc_tran_servicio
	       	      where ts_secuencial = @t_ssn_corr
	       	      and ts_tipo_transaccion in (3916,3917,3919,3173,3202)--ref22 se agrega 3173,3202
	       	             
	       	      if @@rowcount <> 0
	                 select @t_trn = @w_trx_orig
	       
	 
	           if @w_hora >= @w_hora_tope and  (@t_trn = 3916 or @t_trn =  3173)  and @i_canal in ( 'VEN' ,'CNB')	--REF:21 pricaura --ref22 se agrega @t_trn =  3173
	            begin
	              exec cobis..sp_cerror
	                  @t_debug         = @t_debug,
	                  @t_file          = @t_file,
	                  @t_from          = @w_sp_name,
	                  @i_msg           = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO',
	                  @i_num           = 358750
	               return 1
	            end
	    
	         
	        if @w_trx_sec_orig = 0
		begin

			exec cobis..sp_cerror
		       @t_debug         = @t_debug,
		       @t_file          = @t_file,
		       @t_from          = @w_sp_name,
		       @i_msg           = 'NO EXISTE TRANSACCIÓN ORIGINAL',
		       @i_num           = 34014 --smerinom
			return 34014 --smerinom
                  end
		--Ini REF:21 pricaura		  
		select @w_numTransacciones=sum(1) from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion =@w_trx_orig and ts_causa = @w_causa_orig and ts_fecha=@s_date and ts_ssn_corr = @t_ssn_corr
		if @w_numTransacciones > 1
			return 169503
		--Fin REF:21 pricaura
    end


    select @w_accion_iva      = 'N',  -- 1era salida a produccion no cobrara iva
           @w_accion_iva_cero = 'N'

      -- calcular valor del iva
      if @w_accion_iva = 'S' and @w_accion_iva_cero ='N'
      begin
           /* Determinar el valor del IVA  */
           select @w_iva  = pa_float
           from cobis..cl_parametro
           where pa_producto = 'CTE'
                 and pa_nemonico = 'IVA'
           if @@rowcount <> 1 or @w_iva <= 0
            begin
              if @i_aplcobis = 'S'
              begin
                exec cobis..sp_cerror
                    @i_num  = 34001, --smerinom
                    @i_msg  = 'ERROR EN LA LECTURA DEL VALOR IVA',
                    @i_sev  = 1
                return 34001 --smerinom
              end
            else
                return 34001 --smerinom
            end
      end

      /* DETERMINAR EL NUMERO DE DECIMALES A UTILIZAR (DSC970901) */
      select @w_usadeci = mo_decimales
        from cobis..cl_moneda
       where mo_moneda = @i_mon
      if @w_usadeci = 'S'
         select @w_numdeci = pa_tinyint
           from cobis..cl_parametro
          where pa_nemonico = 'DCI'
            and pa_producto = 'CTE'
      else
         select @w_numdeci = 0

   -- JPM Ref.17 -->
   -- anticipar queries de validacion de cuenta
   select @w_num_error = 0
   if @i_debito > 0 or @i_deb_com > 0 --ref25
   begin
     if @i_tipocta = 'CTE'
     begin
       select @w_tipo_cta = @i_tipocta,
              @w_cliente = cc_cliente,
              @w_categoria = cc_categoria
        from cob_cuentas..cc_ctacte
        where cc_cta_banco = @i_cuenta
        if @@rowcount = 0
          select @w_num_error = 31004
     end
     else
     if @i_tipocta in ('AHO', 'PAG')
     begin
       -- JPM Ref.17: anticipar query
       select @w_tipo_cta = @i_tipocta,
              @w_cliente = ah_cliente,
              @w_categoria = ah_categoria
        from cob_ahorros..ah_cuenta
        where ah_cta_banco = @i_cuenta
       select @w_rows = @@rowcount
       if @w_rows = 0
         if @i_canal in ('CNB', 'ATM', 'IBK', 'DBA', 'DIR') --Ref023:msilvag
         begin
          select @w_cliente   = vi_cliente,
                 @w_categoria = vi_categoria,
                 @w_tipo_cta  = 'BAS'
           from cob_virtuales..vi_cuenta
           where vi_cta_banco = @i_cuenta and vi_prod_banc = 13
          select @w_rows = @@rowcount
         end
       if @w_rows = 0
         select @w_num_error = 41001
     end
     else
       select @w_num_error = 30073
     select @w_tipocta = substring(@w_tipo_cta, 1, 1)        -- incluir cta bas
   end
   if @w_num_error <> 0
   begin
     select @w_mensaje = mensaje,
            @w_num_error = numero
      from cobis..cl_errores
      where numero = @w_num_error
     if @i_aplcobis = 'S'
     exec cobis..sp_cerror
          @t_from   = @w_sp_name,
          @i_msg    = @w_mensaje,
          @i_num    = @w_num_error
     else
       select @o_msg = '[' + @w_sp_name + ']  ' + @w_mensaje
     return @w_num_error
   end
   -- <-- JPM Ref.17

    ----------------------------------------------
    -- Comision por pago servicio
    ----------------------------------------------
    select @w_comision_serv = 0, @w_comision_sat = 0
    -- si canal es VEN o DBA calcular comision a partir del SAT,
    -- por los otros canales calcular comision deacuerdo al desglose de pago
    if @i_canal in ('VEN', 'DBA' ,'CNB', 'DIR') --Ref023:msilvag --SMERINO AUMENTA CANAL CNB
     begin
         if @i_ind_costo <> 'R'
            select @w_comision_sat = @i_comision
       end
    else
       begin
         -- existe debito, buscar valor de la comision (Person-Cobis)
         -- <-- JPM Ref.17 SE ADCIONA TIPO DE CUENTA A PROCESAR
         if @i_tipocta in ('CTE', 'AHO', 'PAG') and @w_debito_usd > 0 and @i_ind_costo <> 'R'
         begin
            select @w_producto = case 
                                    when (@i_tipocta = 'PAG' or (@i_tipocta = 'AHO' and @w_tipocta = 'B')) then 'VIR'
                                    else @i_tipocta
                                 end
            exec @w_return = cob_pagos..sp_verif_genera_costo
                    @s_date         = @s_date,
                    @i_mon          = @i_mon,
                    @i_rubro        = @w_rubro,
                    @i_servicio     = @w_servicio,
                    @i_tipocta      = @w_producto,      -- JPM Ref.17 antes @i_tipocta,
                    @i_cuenta       = @i_cuenta,
                    @o_costo        = @w_comision_serv out,
                    @i_oficina      = @s_ofi,
                    @i_ubicacion    = @i_ubi,
                    @i_canal        = @i_canal
            if @w_return <> 0
               return @w_return
         end

         -- existe efectivo y/o cheque, buscar valor comison (SAT)
         if (@i_val + @i_valch) > 0 and @i_ind_costo <> 'R'
            begin
              exec sp_verif_comision_sat
                   @i_mon          = @i_mon,
                   @i_servicio     = 'LUZ',
                   @i_empresa      = @i_empresa,
                   @i_canal        = @i_canal,
                   @i_aplcobis     = @i_aplcobis,
                   @i_cod_producto = 4,
                   @o_costo        = @w_comision_sat out
            end
           select @i_deb_com=@w_comision_serv
		   	 
		   /*<REF 32 INI>*/ 	 
		   exec @w_return = cob_pagos..pa_pg_cexonera_comision
								@e_cuenta      = @i_cuenta,
								@e_tipo_cuenta = @i_tipocta,
								@e_canal       = @i_canal,
								@e_empresa	   = @w_empresa,
								@e_comision	   = @i_deb_com,
								@s_comision    = @w_comision out						
		   if @@error=0 and @w_return=1
				begin
					select @i_deb_com = @w_comision 
				end
		   /*<REF 32 FIN>*/ 		
							
       end

    select @w_total_comision =  @i_efe_com + @i_chq_com +  @i_deb_com      ---- 05/09/2012
    select @w_monto = @w_val_usd + @w_valch_usd + @w_debito_usd + @w_reten_usd
    select @w_monto = @w_monto - isnull(@w_total_comision,0)

    if @i_autoriza = 'N' and  @t_corr = 'N'
    begin
        select @w_maximo_p = pa_money
        from cobis..cl_parametro
        where pa_nemonico = 'MSVP'
        and  pa_producto = 'CTE'

        if (@w_maximo_p <= @w_monto )
        begin
            if @i_aplcobis = 'S'
            begin
                exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 311819
                  --Actualizar error
                  if @i_canal = 'DBA' or @i_canal = 'DIR' --Ref023:msilvag
                  begin
                      select @w_error = mensaje
                      from cobis..cl_errores
                      where numero= 311819

                      update pg_dbautomatico_servicio
                      set sd_errores = @w_error,
                      sd_fecha_ult_pag = @w_fecha_hoy
                      where sd_empresa = @i_empresa
                      and sd_codigo  = @w_errCliente
                  end
                  return 311819
            end
            else
                 return 37608
        end
    end

    exec @w_return = cobis..sp_cseqnos
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_tabla  = 'ts_luz',
         @o_siguiente = @w_secuencial out
         if @w_return != 0
            return @w_return    

    select @w_ndcta = @w_debito_usd + @i_costo

    if @i_canal = "DBA" or @i_canal = 'DIR' --Ref023:msilvag
    begin
        select
        @w_monto_maximo = sd_monto_max
        from cob_pagos..pg_dbautomatico_servicio
        where sd_empresa = @i_empresa
        and sd_codigo = @w_errCliente

        if @w_ndcta > @w_monto_maximo and @w_monto_maximo > 0
        begin
            --rollback tran
            select @w_error = mensaje
            from cobis..cl_errores
            where numero= 41217

            update pg_dbautomatico_servicio
            set sd_errores = @w_error,
            sd_fecha_ult_pag = @w_fecha_hoy
            where sd_empresa = @i_empresa
            and sd_codigo  = @w_errCliente

            exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_msg = "MONTO MAXIMO",
            @i_num = 41217
            return 41217  --smerinom
        end
    end

Begin tran  --REF 9

   if  @i_canal <> 'DBA'
   begin
    --Cobro de la comision
        if  @i_efe_com > 0 or  @i_chq_com > 0 or   @i_deb_com > 0
         begin
           if @t_trn = 3173 or @t_trn = 3916
              select  @w_trn = 3366 , @w_servicio ="6"

           if @t_trn = 3202 or @t_trn = 3917 or @t_trn = 3919
              select  @w_trn = 3372 , @w_servicio ="6"
                    
if  (@i_tipocta = 'CTE' or @i_tipocta = 'AHO'  or @i_tipocta = 'PAG') and (@i_debito>0 or @i_deb_com>0) --ref 24 --ref25
begin
	if @i_tipocta = 'CTE'
	begin
		select @w_caus_comi = b.valor		
		from cobis..cl_tabla a, cobis..cl_catalogo b
		where a.tabla = 'causa_nd_comision_servcte'		
		and a.codigo = b.tabla
		and convert(int,b.codigo) = @i_empresa
		and estado = 'V'			
	end	
	else if @i_tipocta = 'AHO'
	begin
		select @w_caus_comi = b.valor			
		from cobis..cl_tabla a, cobis..cl_catalogo b		
		where a.tabla = 'causa_nd_comision_servaho'		
		and a.codigo = b.tabla		
		and convert(int,b.codigo) = @i_empresa			
        	and estado = 'V'
        	        	
	end
	else if @i_tipocta = 'PAG'  --ref 24
	begin
		select @w_caus_comi = b.valor			
		from cobis..cl_tabla a, cobis..cl_catalogo b		
		where a.tabla = 'causa_nd_comision_servbas'		
		and a.codigo = b.tabla		
		and convert(int,b.codigo) = @i_empresa			
		and estado = 'V'	        	        	
	end
	if @@rowcount = 0 or (@w_caus_comi = null or @w_caus_comi = ' ')
	begin
		if @i_aplcobis = 'S'
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA COMISION',
			@i_num   = 158693

		return 158693	 --ref 24		
	end
end          
           
           /*REF18 Inicio LBP*/
             select @w_aplica_des = 'N'
             if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
	               where rs_empresa = @i_empresa 
	               and rs_canal = @i_canal and rs_estado = 'V')  
	     begin
	     
	         if @i_canal in ('VEN', 'CNB')
	         begin
	              exec @w_return = cob_pagos..pa_pg_ivalor_comcal
	              @e_valor_comision  = @w_total_comision,
	              @e_oficina         = @w_ofi,
	              @e_empresa         = @i_empresa,
	              @e_canal           = @i_canal,
                      @s_valor_com_final = @w_com_original out, -- obtengo comision original
                      @s_aplica          = @w_aplica_des out
                      if @w_return <> 0
                         return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
                  
                      if @w_aplica_des = 'S'
                      begin
                          exec @w_return = cob_gov..pa_iva_pcompensacion
                          @e_oficina        = @w_ofi,
                          @e_monto          = @w_com_original,
                          @s_monto_compensa = @w_valor_compensa out   
                          if @w_return <> 0
                             return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
                      end
                 end
                 
             end
             else
                      select @w_com_original = @w_total_comision
             /*REF18 Fin LBP*/
		
          -- cobro de comision si es canal ATM
                 exec @w_return = cob_remesas..sp_cobro_comision_rc
                        @s_ssn      = @s_ssn,
                        @s_lsrv     = @s_lsrv,
                        @s_srv      = @s_srv,
                        @s_user     = @s_user,
                        @s_sesn     = @s_sesn,
                        @s_term     = @s_term,
                        @s_date     = @s_date,
                        @s_ofi      = @s_ofi,
                        @s_rol      = @s_rol,
                        @s_org      = @s_org,
                        @s_org_err  = @s_org_err, /* Origen de error: [A], [S] */
                        @s_error    = @s_error,
                        @s_sev      = @s_sev,
                        @t_corr     = @t_corr,
                        @t_ssn_corr = @t_ssn_corr, /* Trans a ser reversada */
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @t_from,
                        @t_rty      = @t_rty,
                        @t_trn      = @w_trn,
                        @i_ubi      = @i_ubi,
                        @i_mon      = @i_mon,
                        @i_causal   = @w_caus_comi,  --- Ref.16: ,smerino CS antes '627'
                        @i_opcion   = "T",
                        @i_servicio = @w_servicio,
                        @i_codigo   = @i_codigo,  --Ref.16: ,smerino CS antes 
                        @i_efectivo = @i_efe_com,
                        @i_cheque   = @i_chq_com,
                        @i_debito   = @i_deb_com, -- DEBITO A CTAS
                        @i_canal    = @i_canal,   --- canal
                        @i_cuenta   = @i_cuenta,
                        @i_tipocta  = @w_tipo_cta,          -- JPM Ref.17: antes @i_tipocta
                        @i_tsn      = @i_tsn,
                        @i_nomb_tramite = @w_empresa  --Ref023:msilvag 

                     if @w_return != 0
                     begin
                        if @i_aplcobis = 'S'
                        begin
                          exec cobis..sp_cerror
                            @t_debug  = @t_debug,
                            @t_file   = @t_file,
                            @t_from   = @w_sp_name,
                            @i_num    = @w_return --Ref023:msilvag 035000
                            if @i_empresa <> 1 and (@i_canal = 'DBA' or @i_canal = 'DIR') --Ref023:msilvag
                            begin
                                select @w_error = mensaje
                                from cobis..cl_errores
                                where numero= @w_return --035000

                                update pg_dbautomatico_servicio
                                set sd_errores = @w_error,
                                sd_fecha_ult_pag = @w_fecha_hoy
                                where sd_empresa = @i_empresa
                                and sd_codigo  = @w_errCliente
                            end
                            return 1
                        end
                      else
                        return 1
                      end --if @w_return != 0

                  --INI REF7 - IVA
                  --  busqueda de la tasa del iva parametrizada en el person
                  exec  @w_return = cob_pagos..sp_verif_genera_costo
                        @s_date         = @s_date,
                        @i_mon          = @i_mon,
                        @i_rubro        = 'IVA',
                        @i_servicio     = 'CSBA',
                        @i_canal        = 'VEN',
                        @i_tipocta      = '3',
                        --@i_cuenta       = @i_cuenta,
                        @o_costo        = @w_tasa out

                      if @w_return <> 0
                      begin
                         if @@trancount > 0
                            rollback tran

                          return @w_return
                      end

                 if @w_tasa > 0
                 begin
                 
                    /*REF18 Inicio LBP*/
                    if @w_valor_compensa > 0 and @w_aplica_des = 'S' and (@i_canal = 'CNB' or @i_canal = 'VEN')
                    begin
                           -- llamar al sp que retorna el valor del iva ----
                           exec @w_return = cob_cuentas..sp_cal_impuesto
                                @i_tasa        = @w_tasa,
                                @i_valor_serv  = @w_com_original,
                                @o_base_imp    = @w_base_imp out,
                                @o_impuesto    = @w_impuesto2 out

                           if @w_return <> 0
                           begin
                               if @@trancount > 0
                                  rollback tran
                               return @w_return
                           end  
                    end
                    else
                    begin
                    /*REF18 Fin LBP*/
                 
			      -- llamar al sp que retorna el valor del iva ----
			     exec @w_return = cob_cuentas..sp_cal_impuesto
				  @i_tasa           = @w_tasa,
				  @i_valor_serv = @w_total_comision,
				  @o_base_imp = @w_base_imp out,
				  @o_impuesto = @w_impuesto2 out

				  if @w_return <> 0
				  begin
				     if @@trancount > 0
					rollback tran

				      return @w_return
				  end
                          
                       end -- Fin if @w_valor_compensa > 0
                          
                    select @o_base_imp =   @w_base_imp,    @o_impuesto = @w_impuesto2
                 end
                 else
                      select @w_base_imp = @w_total_comision,@w_impuesto2 = 0
                      
                 

                if @w_base_imp > 0
                begin

                     /*REF18 Inicio LBP*/
		     if (@i_canal = 'CNB' or @i_canal = 'VEN') and @w_aplica_des = 'S' and @w_valor_compensa > 0
		     begin
		     
                        --insert la trx del iva 3497 para cobro de la comision ---
                        exec @w_return = cob_cuentas..sp_cont_impuesto
                             @t_trn       = 3497 ,
                             @s_ssn       = @s_ssn,
                             @s_date      = @s_date,
                             @t_corr      = @t_corr,
                             @t_ssn_corr  = @t_ssn_corr,
                             @s_user      = @s_user,
                             @s_term      = @s_term,
                             @s_ofi       = @w_ofi, -- Oficina Damnificado
                             @t_rty       = @t_rty,
                             @s_org       = @s_org,
                             @i_base_imp  = @w_base_imp,
                             @i_iva       = @w_impuesto2,
                             @i_total     = @w_com_original,  -- Comision Original al 14
                             @i_cau       = @w_servicio,
                             @i_cta       = @i_codigo, --referencia
                             @i_mon       = @i_mon,   --Moneda
                             @i_oficina_cta= @w_ofi, -- Oficina Damnificado
                             @i_ubi       = @i_ubi,
                             @i_canal     = @i_canal, --smerino new09232014
                             @i_cta_deb   = @i_cuenta -- REF17 LBP se agrega cuenta

                             
		     end
		     else
		     begin
                     /*REF18 Fin LBP*/
                
			  --insert la trx del iva 3497 para cobro de la comision ---
			  exec @w_return = cob_cuentas..sp_cont_impuesto
			       @t_trn       = 3497 ,
			       @s_ssn       = @s_ssn,
			       @s_date      = @s_date,
			       @t_corr      = @t_corr,
			       @t_ssn_corr  =@t_ssn_corr,
			       @s_user      = @s_user,
			       @s_term      = @s_term,
			       @s_ofi       = @s_ofi,
			       @t_rty       = @t_rty,
			       @s_org       = @s_org,
			       @i_base_imp =@w_base_imp,
			       @i_iva =@w_impuesto2,
			       @i_total = @w_total_comision,
			       @i_cau = @w_servicio,
			       @i_cta =@i_codigo, --referencia
			       @i_mon =@i_mon,   --Moneda
			       @i_oficina_cta= @s_ofi,
			       @i_ubi =@i_ubi,
			       @i_canal=@i_canal --smerino new09232014

                   end -- Fin if @i_canal = 'CNB' or @i_canal = 'VEN' LBP

                      if @w_return <> 0
                      begin
                         if @@trancount > 0
                            rollback tran

                          return @w_return
                      end
                 end
                    --FIN REF7 - IVA

         end --if  @i_efe_com > 0 or  @i_chq_com > 0 or   @i_deb_com > 0
   end --if  @i_canal <> 'DBA'


     if @i_tipocta = 'AHO' and @i_debito > 0
         select @w_tipocta = 'A'

      if @i_tipocta = 'CTE' and @i_debito > 0
         select @w_tipocta = 'C'

    if @i_canal <> 'VEN' and @i_canal <> 'CNB'
         select @w_ndcta = @w_debito_usd + case when @i_canal in ('IBK','WAP','ATM')--= 'IBK' 
          --and @i_empresa = 144  --ref22 comentado, empresa se valida en catálogo
          --ref22 inicio
          and @i_empresa in(select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
          --ref22 fin
         then 0 else 0 end   --Ref022 -- Ref.16 smerino: no sumar por CS


    
    if @i_tipocta = 'CTE' and @i_debito  > 0	--REF:21 pricaura
    begin
       select @w_causa = isnull(b.valor,' ')
         from cobis..cl_tabla a, cobis..cl_catalogo b       
         where a.tabla = 'causa_nd_cte_servicios'       
         and a.codigo = b.tabla       
         and convert(smallint,b.codigo) = @i_empresa         --dbl
         and estado = 'V'
                     
         if @@rowcount = 0 or (@w_causa = null or @w_causa = ' ')
         begin
       		if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001                                                                -- JLS 23/FEB/2001
             		exec cobis..sp_cerror
                  	@t_debug = @t_debug,
                  	@t_file  = @t_file,
                  	@t_from  = @w_sp_name,
                  	@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
                  	@i_num   = 158693
                  	
                return 158693      --ref 24     
       
  	end
   end
   else
   if @i_tipocta in ('AHO', 'PAG') and @i_debito  > 0   --REF:21 pricaura                          -- JPM Ref.17: incluir PAG
   begin
    select @w_tab_causrv = case @w_tipo_cta when 'AHO' then 'causa_nd_aho_servicios' when 'BAS' then 'causa_nd_bas_servicios' end
   	select @w_causa = isnull(b.valor,' ')
        from cobis..cl_tabla a, cobis..cl_catalogo b
        where a.tabla = @w_tab_causrv  --JPM Ref.17: 'causa_nd_aho_servicios' 
        and a.codigo = b.tabla
        and convert(smallint,b.codigo) = @i_empresa         --dbl
      	and estado = 'V'
    
      	if @@rowcount = 0 or (@w_causa = null or @w_causa = ' ')    
	begin    
        	if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001            	                                                                -- JLS 23/FEB/2001    
        	  exec cobis..sp_cerror    
        	  @t_debug = @t_debug,    
        	  @t_file  = @t_file,    
               	  @t_from  = @w_sp_name,    
               	  @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',    
               	  @i_num   = 158693 
               	  
                 return 158693  --ref 24
                           -- dbl
        end
  end

    if @i_canal = 'DBA' or @i_canal = 'DIR' --Ref023:msilvag 
        select @w_causa = '466'

                      -- Descripcion de Servicio
    if @t_corr = 'N'
    begin
        select @w_codservicio = 'PAGSB',
               @w_ssn = @s_ssn
    end
    else
    begin
        select @w_codservicio = 'PAGSR',
             @w_ssn = @t_ssn_corr
    end

    -- Descripcion de Canal
    if @i_canal = 'ATM'
       select @w_desc_canal = 'VEINTI4EFECTIVO'
    if @i_canal = 'DBA' or @i_canal = 'DIR' --Ref023:msilvag
       select @w_desc_canal = 'AUTOMATICO'
    if @i_canal = 'IBK'
       select @w_desc_canal = '24online' --Ref 26
    if @i_canal = 'IVR'
       select @w_desc_canal = 'VEINTI4FONO'
    if @i_canal = 'KSK'
       select @w_desc_canal = 'PUNTOVEINTI4'
    if @i_canal = 'VEN'
       select @w_desc_canal = 'VENTANILLA'
    if @i_canal = 'WAP'
       select @w_desc_canal = 'WAP'
    if @i_canal = 'CNB'
      select @w_desc_canal = 'CNB'    --SMERINO
	if @i_canal = 'SAT' /*<REF 31 Canal SAT REF 31>*/
      select @w_desc_canal = 'SAT' /*<REF 31 Descripcion canal REF 31>*/


    -- Descripcion de Empresa
    select @w_desc_empresa = substring(b.valor,1,32)
    from cobis..cl_tabla a, cobis..cl_catalogo b
    where a.tabla = 'sv_energia_elec'
    and a.codigo = b.tabla
    and convert(int,b.codigo) = @i_empresa
    
    --ref22 inicio, sv_energia_elec_meer se utiliza para empresas que están en Base 
    if @@rowcount=0
       select @w_desc_empresa = substring(b.valor,1,32)
       from cobis..cl_tabla a, cobis..cl_catalogo b
       where a.tabla = 'sv_energia_elec_meer'
       and a.codigo = b.tabla
       and convert(int,b.codigo) = @i_empresa
    --ref22 fin

    select @w_valor_debito = convert(varchar(11),@w_ndcta)
    if @i_canal <> 'VEN' and @i_canal <> 'CNB' 
         select @w_ndcta = @w_ndcta + case when @i_canal in ('IBK','WAP','ATM')--= 'IBK' 
          --and @i_empresa = 144  --ref22 comentado, empresa se valida en catálogo
          --ref22 inicio
          and @i_empresa in(select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
          --ref22 fin
         then 0  else 0 end    --Ref022 -- Ref.16: no sumar por caso de CS y canal IBK

    if @w_debito_usd > 0  and @i_tipocta is null
    begin
        exec cobis..sp_cerror
                 @t_from = @w_sp_name,
                 @i_msg = "ERROR EN TIPO CUENTA",
                 @i_num = 34003  --smerinom
                 return 34003
    end

    if @i_tipocta = 'CTE' and @w_debito_usd > 0 and @i_ind_costo <> 'R'
    begin
            
            select       @w_cliente = cc_cliente,
	                 @w_categoria = cc_categoria,
	                 @o_nombre = cc_nombre ----SMERINO CNB FASEII
	           from cob_cuentas..cc_ctacte
                 where cc_cta_banco = @i_cuenta
        
          exec @w_return = cob_cuentas..sp_ccndc_automatica
              @s_srv          = @s_srv,
              @s_ofi          = @s_ofi,
              @s_ssn          = @s_ssn,
              @s_user         = @s_user,
              @s_term         = @s_term,
              @t_corr         = @t_corr,
              @t_trn          = 3050,
              @i_cta          = @i_cuenta,
              @i_val          = @w_ndcta,
              @i_cau          = @w_causa,
              @i_mon          = 1,
              @i_ref          = @w_emp,       --Campo CtaDestino
              @i_detalle      = @i_codigo,    --codigo de Suministro
              @i_fecha        = @s_date,
              @i_nchq         = @t_ssn_corr,
              @i_aplcobis     = @i_aplcobis,
              @i_tsn          = @i_tsn,
              @i_ubi          = @i_ubi,
              @s_rol          = @s_rol,
              @i_con_tran     = 'N',
              @i_con_tran_categ = 'N'

             if @w_return <> 0
             begin
                if @@trancount > 0
                  rollback tran

                select @w_error = mensaje
                from cobis..cl_errores
                where numero= @w_return

                update pg_dbautomatico_servicio
                set sd_errores = @w_error,
                sd_fecha_ult_pag = @w_fecha_hoy
                where sd_empresa = @i_empresa
                and sd_codigo  = @w_errCliente
                 return @w_return
              end
              else
             begin
               /* Llamado a sp cob_internet..sp_eventos por Alert Manager */
                     select @w_valor_debito = convert(varchar(11),@w_ndcta)
     
	 	exec  @w_return = cob_pagos..sp_consulta_celular
          	@i_cliente = @w_cliente,
          	@o_celular = @w_telefono  out,
          	@o_correo=@w_correo  out

          	if @w_return <> 0
          	begin
             		if @@trancount > 0
                		rollback tran

              		return @w_return
         	end

		---smerino

                 --ref24 inicio
                      select @w_total = convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @w_total_comision)),
                             @w_comision_tran = convert(varchar,@w_total_comision)
                     
                     
                    if (@i_canal in('WAP') and @w_es_meer ='S')
                        or @w_comision_avi24='S' -->bandera indica canal envia comision
                       select @w_total_sms       = @w_total                              
                    else                    
                       select @w_total_sms     = @w_valor_debito,@w_control_mostrar = ''
                    --ref24 fin
			
				select @o_servicio_not = @w_codservicio,
			       @o_nomb_ente = @o_nombre,
			       @o_cod_ente = convert(varchar(20),@w_cliente),
			       @o_desccanal = @w_desc_canal,         	       
			       @o_celular = @w_telefono,
			       @o_correo  = @w_correo,
			       @o_desc_empresa = @w_desc_empresa,
			       @o_prod_deb = 'CTE',
			       @o_valor = @w_valor_debito,
			       @o_fecha_deb = @w_fecha_deb,
			       @o_hora_deb = @w_hora_deb,
			       @o_valor_comi = @w_comision_tran,
			       @o_valor_tot = @w_total,
       			       @o_cta_lat = substring(@i_cuenta,8,3)
       			
                end
      end

      if @i_tipocta in ('AHO', 'PAG') and @w_debito_usd > 0 and @i_ind_costo <> 'R'     -- JPM Ref.17: incluir PAG
      begin
         if @w_tipo_cta = 'AHO'                                                         -- JPM Ref.17
         begin
		
             select    @w_cliente = ah_cliente,
	                   @w_categoria = ah_categoria,
	                   @o_nombre = ah_nombre --SMERINO CNB FASEII
	             from cob_ahorros..ah_cuenta
                     where ah_cta_banco = @i_cuenta         
         
            exec @w_return = cob_ahorros..sp_ahndc_automatica
                 @s_srv          = @s_srv,
                 @s_ofi          = @s_ofi,
                 @s_ssn          = @s_ssn,
                 @s_user         = @s_user,
                 @s_term         = @s_term,
                 @t_trn          = 4264,
                 @t_corr         = @t_corr,
                 @i_cta          = @i_cuenta,
                 @i_val          = @w_ndcta,
                 @i_cau          = @w_causa,
                 @i_mon          = 1,
                 @i_ref          = @w_emp,     --Campo Tarjeta
                 @i_tarjeta      = @i_codigo,  --Codigo de Suministro
                 @i_fecha        = @s_date,
                 @i_referen      = @t_ssn_corr,
                 @i_aplcobis     = @i_aplcobis,
                 @i_tsn          = @i_tsn,
                 @i_ubi          = @i_ubi,
                 @s_rol          = @s_rol,
                 @i_con_tran     = 'N'
          end
          else                                                          -- JPM Ref.17 -->
          if @w_tipo_cta = 'BAS'
          begin
             select        @w_cliente = vi_cliente,
	                   @w_categoria = vi_categoria,
	                   @o_nombre = vi_nombre --SMERINO CNB FASEII
	             from cob_virtuales..vi_cuenta
                     where vi_cta_banco = @i_cuenta          
          
            exec @w_return = cob_virtuales..sp_basndc_automatica
                   @s_srv              = @s_srv,
                   @s_ofi              = @s_ofi,
                   @s_ssn              = @s_ssn,
                   @s_user             = @s_user,
                   @s_term             = @s_term,
                   @s_rol              = @s_rol,
                   @t_trn              = 120060,
                   @t_corr             = @t_corr,
                   @i_cta              = @i_cuenta,
                   @i_val              = @w_ndcta,
                   @i_cau              = @w_causa,
                   @i_mon              = 1,
                   @i_fecha            = @s_date,
                   @i_aplcobis         = @i_aplcobis,
                   @i_referen          = @t_ssn_corr,
                   @i_tarjeta          = @i_codigo,
                   @i_ref              = @w_codigo,
                   @i_ubi              = @i_ubi,
                   @i_tsn              = @i_tsn,
                   @i_con_tran         = 'N',
                   @o_msg              = @w_mensaje                 out,
                   @o_error            = @w_num_error               out,
                   @o_detalle_error    = @w_detalle_error           out,
                   @i_canal            = @i_canal                       -- <-- JPM Ref.17
          end

                if @w_return <> 0
                begin
                    if @@trancount > 0
                      rollback tran

                    if @i_empresa <> 1 and (@i_canal = 'DBA' or @i_canal = 'DIR') --Ref023:msilvag
                    begin
                        select @w_error = mensaje
                        from cobis..cl_errores
                        where numero= @w_return

                        update pg_dbautomatico_servicio
                        set sd_errores = @w_error,
                        sd_fecha_ult_pag = @w_fecha_hoy
                        where sd_empresa = @i_empresa
                        and sd_codigo  = @w_errCliente
                    end
                    return @w_return
               end
               else
               begin

 		exec  @w_return = cob_pagos..sp_consulta_celular
        	@i_cliente = @w_cliente,
            	@o_celular = @w_telefono  out,
            	@o_correo=@w_correo  out

          	if @w_return <> 0
          	begin
             		if @@trancount > 0
                		rollback tran

			return @w_return
		end
            
                     --ref24 inicio
                          select @w_total = convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @w_total_comision)),
                                 @w_comision_tran = convert(varchar,@w_total_comision)
                         
                         
                    if (@i_canal in('WAP') and @w_es_meer ='S')
                        or @w_comision_avi24='S' -->bandera indica canal envia comision
                           select @w_total_sms       = @w_total
                        else                    
                           select @w_total_sms     = @w_valor_debito,@w_control_mostrar = ''
                        --ref24 fin

			select @o_servicio_not = @w_codservicio,
		       @o_nomb_ente = @o_nombre,
		       @o_cod_ente = convert(varchar(20),@w_cliente),
		       @o_desccanal = @w_desc_canal,
		       @o_celular = @w_telefono  ,
		       @o_correo = @w_correo,
		       @o_desc_empresa = @w_desc_empresa,
		       @o_prod_deb = 'AHO',
		       @o_valor = @w_valor_debito,
		       @o_fecha_deb = @w_fecha_deb,
		       @o_hora_deb = @w_hora_deb,
		       @o_valor_comi = @w_comision_tran,
		       @o_valor_tot = @w_total,
		       @o_cta_lat = substring(@i_cuenta,8,3)
			   
             end
      end




      /* SALVAR VARIBALE DE DEBITO USD */
      select @w_debito_usd_bak = @w_debito_usd

      select @w_emp = convert(varchar(6),@i_empresa)

      if @i_canal <> 'VEN'  and @i_canal <> 'CNB'  --(Para que canal IBK no grabe incluido el valor de la Comision)
          select @w_debito_usd = @w_ndcta - case when @i_canal in ('IBK','WAP','ATM') --= 'IBK' 
          --ref22 inicio
          and @i_empresa in(select convert(int, c.codigo) from cobis..cl_catalogo c inner join cobis..cl_tabla t  on c.tabla=t.codigo
                                and t.tabla='pg_reca_emp_elect_meer' and estado='V')
          --ref22 fin
          then 0  else 0 end  --Ref022  Ref.16 smerino: excluir resta por CS

      if @i_canal = 'ATM'
      begin
        select @o_ssn      = @s_ssn
        select @w_efec_atm = 0  --@i_val ref 24
        select @w_val_usd = @i_val --0 ref24
      end
      else
      begin
         select @w_efec_atm = 0
      end

     insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal, ts_correccion, ts_tipo_chequera,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia, ts_saldo, ts_ssn_corr, ts_cta_banco,
              ts_moneda, ts_tipo, ts_valor, ts_monto, ts_ocasional, ts_contratado, ts_aporte_iess, ts_descuento_iess,
              ts_tsn, ts_ccontable, ts_hora, ts_endoso, ts_causa, ts_tipocta,ts_nombre,ts_tipo_def,
              ts_cta_asociada, ts_oficina_cta,ts_cheque_rec,ts_ubicacion,
              ts_autoriz_aut, ts_fonres_iess, ts_agente,
              ts_stick_imp,
              ts_campo_alt_uno, ts_campo_alt_dos, ts_cod_banco, ts_corresponsal, ts_propietario, ts_carta, ts_fecha, ts_cheque, ts_tarjcred,ts_autorizante , --REF:20 ts_autorizante
			  ts_remoto_ssn) --REF 23

      values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term, @t_corr, @i_canal,
              null, 'L', @s_lsrv, @s_date, 'F', @i_codigo, @w_valch_usd, @t_ssn_corr, @i_cuenta,
              1, 'L',  @w_val_usd, @w_debito_usd, @w_reten_usd,@w_efec_atm,@i_costo, @w_debito_BR, @i_tsn, null, getdate(),
              @w_secuencial, @w_emp, @w_tipocta, @i_nombre,@i_aplcobis, --Ref019:msilvag @o_nombre
              @i_comprob, @w_id_detalle,@i_cant_chq,@i_ubi,
              convert(varchar(10), @w_total_comision), @w_total_com, @i_pcodseguridad,
              convert(varchar(12),@w_ret_planilla),
              @i_pnumero, @i_pfactura, @i_phoralocal, @w_fecha_proc,convert(varchar(8),@w_cod_grupo), @i_ptotal_pendiente, @o_fecha_efe, convert(int,@i_psecmactrans), convert(varchar(6),@o_codautorizador),@i_pcuenta, --REF:20 @i_pcuenta
              @i_sec_atm) --REF 23
      if @@rowcount <> 1
      begin
         if @i_aplcobis = 'S'
          begin
             exec cobis..sp_cerror
                 @t_from = @w_sp_name,
                 @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
                 @i_num =  34004   --smerinom
                 return  34004  --smerinom
           end
           else
           begin
             if @@trancount > 0
                rollback tran

             return 33005
           end
      end

    if @i_canal = 'VEN'
      begin
          exec @w_return = cob_remesas..sp_upd_totales_rc
                     @i_ofi            = @s_ofi,
                     @i_rol            = @s_rol,
                     @i_user           = @s_user,
                     @i_producto       = 'CTE',
                     @i_mon            = @i_mon,
                     @i_ubi            = @i_ubi,
                     @i_trn            = @t_trn,
                     @i_nodo           = @s_srv,
                     @i_tipo           = 'L',
                     @i_corr           = @t_corr,
                     @i_efectivo       = @w_val_usd,
                     @i_cheque         = @w_valch_usd,
                     @i_cant_chq       = @i_cant_chq,
                     @i_otros          = @w_debito_usd_bak,
                     @i_tipocta        = @i_tipocta,
                     @i_retencion      = @w_reten_usd,
                     @i_causa          = @w_emp

                if @w_return != 0
                begin
                    if @i_aplcobis = 'S'
                    begin
                        exec cobis..sp_cerror
                             @t_debug         = @t_debug,
                             @t_file          = @t_file,
                             @t_from          = @w_sp_name,
                             @i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                             @i_num           = 111111
                            return 1 --WRP
                         end
                      else
                      begin
                         if @@trancount > 0
                            rollback tran

                         return 37609
                      end
                 end
      end


      if @t_corr = 'N'
        if @w_ind_diferido = "S"
            select @o_horario = "D"
        else
            select @o_horario = "N"

  if @@trancount > 0
    commit tran
return 0
go
if exists(select 1 from sysobjects where name='sp_pago_servicio_luz' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_pago_servicio_luz *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_pago_servicio_luz -- ERROR -- >>>'
go
--grant execute on sp_pago_servicio_luz to apl_osb_hpact
grant execute on sp_pago_servicio_luz to apl_osb_hpdes  --apl_osb_hpdes
go

