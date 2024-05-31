/************************************************************************/
/*  Archivo:          ccontimp.sp                                     	*/
/*  Stored procedure:   sp_cont_impuesto                                */
/*  Base de datos:      cob_cuentas                                     */
/*  Producto:     Cuentas Corrientes                              	*/
/*  Disenado por:   María José Silva Goya                           	*/
/*  Fecha de escritura: 11/Dic/2012                                     */
/************************************************************************/
/*                  IMPORTANTE                              		*/
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*                  PROPOSITO                               		*/
/*  Inserta en la tabla de transaccion de servicio el valor del desglose*/
/* del cobro de IVA               					*/
/************************************************************************/
/*        MODIFICACIONES       						*/
/*REF FECHA   AUTOR       RAZON     TAREA 				*/
/* 1   11/Dic/2012  María Jo. Silva G. Emision inicial CTE-CC-SGC00006164*/
/*     10/Ene/2013  Galo Yanez  Grabar contabilidad por IVA   		*/
/*        transaccion 43087     					*/
/*        Tarea: CTE-CC-SGC00006747     				*/
/* 3   28/Ene/2013  Daniel Pereira    CTE-CC-SGC00007058  PROYECTO IVA  */
/* 4   08/Marzo/2013  Ana Mendez      CTE-CC-SGC00007605  PROYECTO IVA  */
/* 5   19/Ago/2013  J.Pazminno      CTE-CC-SGC00010002 - Regulatorio IVA*/
/* 6   15/MAY/2015  PAUL HOYOS V    CB-AP-SGC00018374-SGC00019171       */
/*15 03/Dic/2015  Galo Yanez	      Considerar trx de comision de     */
/*                                  protesto de cheques                 */
/*                                  Tarea: CTE-CC-SGC00023186           */
/*   07/Ene/2016  Galo Yanez   Adicionar permiso a usuario de bus       */
/*                             CTE-CE-SGC00023826                       */
/*08 22/Ago/2016  Pablo Holguin  CTE-CC-SGC00025809  Compensacion Iva	*/
/*				 Nuevo trx servicio valor del descuento	*/
/*09 07/Oct/2016 María Jo. Silva RECA-CE-SGC00026649  Registrar facturas de retiro */
/************************************************************************/

use cob_cuentas
go

if exists (select 1 from sysobjects where name = 'sp_cont_impuesto')
    drop procedure sp_cont_impuesto
go

create procedure sp_cont_impuesto (
  @t_trn            int,  --Codigo de transaccion (Cte 3188 , aho 4188, Rec, Bas 120061)
  @s_ssn            int,
  @s_date           datetime,
  @t_corr           char(1) = 'N',
  @t_ssn_corr       int     = null,  /* Transacción a ser reversada */
  @s_user           varchar(30) = null,
  @s_term           varchar(10),
  @s_ofi            tinyint = 1,    /* Localidad origen transaccion */
  @t_rty            char(1) = 'N',
  @s_org            char(1),
  @i_base_imp   money,
  @i_iva      money,
  @i_total    money,
  @i_cau      varchar(6) = null,
  @i_cta      varchar(20),  --Número de operación/Número de Cuenta
  @i_mon      int,    --Moneda
  @i_oficina_cta    smallint = null,
  @i_tipo_contable  char(2) = null, --tipo contable de cuenta
  @i_ubi      smallint = 0 ,  --Ubicacion de transaccion (oficina)
  @i_aplcobis   char(1) = 'S',
  @i_canal                varchar(3) = null,
  @i_cheque	int = null,				-- GYC 2015/Dic/03
  @o_mensaje    varchar(200) = null out,
  @i_fecha         datetime = null,
  @i_alterno       int      = 0,                -- JPM Ref.05
  @i_guardar_iva   char(1)  = 'S',               -- JPM Ref.05
  @i_cta_deb	  cuenta = null			 --Ref08 pholguiv
)
as

declare @w_sp_name varchar(50),
        @w_tipo_cta   char(3),----REF3
        @w_producto   varchar (10),----REF3
        @w_servicio   varchar (10),----REF3
        @w_return     int, ----REF3
        --Ref08
        @w_valor_dev 	  money,
	@w_porc_comp	  money,
        @w_ofi_homologada tinyint,
        @w_cta_deb	  cuenta
	--Ref08

select @w_sp_name = 'sp_cont_impuesto'

--3497   Cod. de Transaccion de Recaudaciones
--3484   Cod. de transaccion para otros ingresos
--3188   Cod. para registrar el impueso del IVA default de cuentas corrientes
--3793   Cod. Pago Interbancario CTE
--3721   Cod. para Transferencias enviadas exterior
--3471   TRX para registrar impuesto del IVA por Recuperacion de Valores Suspenso CTE

--4188   Cod. para registrar el impueso del IVA default de cuentas ahorros
--4283   Cod. Pago Interbancario AHO
--4284   CONTA DEVOLUCION IVA - COMISION CTAS AHORROS
--4189   TRX para registrar impuesto del IVA por Recuperacion de Valores Suspenso AHO

--43083  PAGO DE SERVICIOS A EMPRESAS
--43084  DB EMP.  COM. CONTABLE
--43085  REGULA PAGO EFECTIVO VIRTUAL
--43087  TRX PARA CONTABILIZAR N/D POR EMISION DE CHEQUERAS
--43088  CONTA DEVOLUCION IVA - COMISION CTAS CTE

--120049 Cod. para registrar el impuesto IVA en cuentas Virtuales
--120050 CONTA DEVOLUCION IVA - COMISION CTAS VIRTUALES
--120061 TRX PARA CONTAB DE ND CON IVA CTA.BASICA, SE ADICIONA NUEVA TRANSACCION
--120094 TRX CONTAB ND VAL NO COBR IVA CTA.VIRTUALES
--120072 TRX CONTAB ND VAL NO COBR IVA CTA.BASICA
--120161 TRX PARA CONTAB DE NC CON IVA CTA.BASICA
-- JPM Ref.05: agregar 3471, 4189
--PHOYOSV se agrega transaccion 120061 para basica
if @t_trn not in (3188,3484,3497,3793,3721,3471,4188,4283,4284,43083,43084,43085,43087,43088,4189,
                  120049,120050,120061,120072,120094,120161)  -- GYC 2013/Ene/10
begin
  if @i_aplcobis = 'S'
  begin
     exec cobis..sp_cerror
    @t_debug  = 'N',
    @t_file   = null,
    @t_from   = @w_sp_name,
    @i_num    = 99999,
    @i_msg    = 'TRANSACCION NO PERMITIDA'
     --return 99999
   end
   else
    select @o_mensaje = 'TRANSACCION NO PERMITIDA'

  return 99999
end

if @i_canal is null
      select @i_canal =  case @s_user
              when 'ope998'  then  'IBK'
              when 'SAT'     then  'SAT'
              when 'srolese' then  'SAT'
              when 'kiosko'  then  'KSK'
              when 'IVR'     then  'IVR'
              else 'VEN'    end



  if @i_cau in('11','10') and @t_trn = 3497
    select @w_producto = 'PAYK',  @w_servicio = 'PAYK',@w_tipo_cta = ''
  else
  if @t_trn in (3497,3484, 3471, 4189)        -- JPM Ref.05 Trx 3471, 4189
    select @w_producto = 'RECA',  @w_servicio = 'RECS',@w_tipo_cta = ''
  else
  if @t_trn = 3721
    select @w_producto = 'TRAN',  @w_servicio = 'TRIN',@w_tipo_cta = ''
  else
  if (@t_trn = 3188 and @i_cau = '959')
    select @w_producto = 'TRAN',  @w_servicio = 'ECHE',@w_tipo_cta = 'CTE'
  else
  if (@t_trn = 4188 and @i_cau = '959')
    select @w_producto = 'TRAN',  @w_servicio = 'ECHE',@w_tipo_cta = 'AHO'
  else
  if @t_trn in (3188,3793,43087,43088,43083,43084)
    select @w_producto = 'CTAS',  @w_servicio = 'CCTE',@w_tipo_cta = 'CTE'
  else
  if @t_trn in (4188, 4283,4284)
   select @w_producto = 'CTAS',   @w_servicio = 'CAHO',@w_tipo_cta = 'AHO'
  else
  if @t_trn in (120049,120050,43085)
    select @w_producto = 'CTAS',  @w_servicio = 'VIRT',@w_tipo_cta = 'VIR'
  else
  if @t_trn in (120061)
    select @w_producto = 'CTAS', @w_servicio = 'VIRT',@w_tipo_cta = 'BAS'
  else
  if @t_trn in (120072)
    select @w_producto = 'RECA', @w_servicio = 'RECS',@w_tipo_cta = 'BAS'
  else
  if @t_trn in (120094)
    select @w_producto = 'RECA', @w_servicio = 'RECS',@w_tipo_cta = 'VIR'
  else
  if @t_trn in (120161)
    select @w_producto = 'CTAS', @w_servicio = 'VIRT',@w_tipo_cta = 'BAS'


select @i_cheque = isnull(@i_cheque,0)		-- GYC 2015/Dic/03


--Ref08 pholguin 2016/Jul/18 Damnificado trx devolucion
---------------------------------------------------------------------------------
select @w_valor_dev = 0,
       @w_porc_comp = 0,
       @w_cta_deb   = ''


if exists ( select 1  from cobis..cl_catalogo c inner join cobis..cl_tabla t
		on c.tabla = t.codigo and t.tabla = 'cl_canal_devolucion'
	     where c.codigo = @i_canal and c.estado = 'V' )
   begin

	--Si paso las validaciones se ingresa el registro del descuento
	    exec cob_gov..pa_iva_pcompensacion
		 @e_oficina            = @s_ofi,
		 @e_monto              = @i_total,
		 @s_monto_compensa     = @w_valor_dev out,
		 @s_porc_compensa      = @w_porc_comp out

	--obtenemos la cuenta del canal
	if @i_canal = 'CNB'
	begin
	   select @w_ofi_homologada = @s_ofi
	   select @s_ofi = 0 ,
	   	  @w_cta_deb = ltrim(rtrim(@i_cta_deb))
	end
	else
	   select @w_cta_deb = ltrim(rtrim(@i_cta))

	--Si es con debito ,se valida la existencia de la misma , no se graba devolucion
	if isnull(@w_cta_deb,'') <> '' and @i_canal <> 'CNB'
	begin

	  if @t_trn=3484 and @i_cau ='36' --si es certificacion cheque
	   select @i_cau = '36'
	  else
	   begin
	   if exists (select 1 from cob_cuentas..cc_ctacte  where cc_cta_banco = @w_cta_deb)
	      Select @w_valor_dev = 0
	    else
	     if exists (select 1 from cob_ahorros..ah_cuenta  where ah_cta_banco = @w_cta_deb)
		Select @w_valor_dev = 0
	     else
	       if exists (select 1 from cob_ahorros..ah_cuenta_cerrada where ac_cta_banco = @w_cta_deb)
		  Select @w_valor_dev = 0
	       else
		 if exists (select 1 from cob_virtuales..vi_cuenta  where vi_cta_banco = @w_cta_deb)
			    Select @w_valor_dev = 0
		 else
		   if exists (select 1 from cob_virtuales..vi_cuenta_cerrada where ac_cta_banco = @w_cta_deb)
			      Select @w_valor_dev = 0
	   end
	end

   end
---Ref08 fin


if @t_trn in (3188,3484,3497,3793,3721,43083,43084,43085,43087,43088,3471)   -- GYC 2013/Ene/10); JPM Ref.05: 3471
begin
  insert into cob_cuentas..cc_tran_servicio
    (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,
    ts_correccion, ts_ssn_corr,
    ts_usuario, ts_terminal, ts_oficina, ts_reentry, ts_origen,
    ts_valor, ts_saldo,ts_monto, ts_causa, ts_ocasional,ts_oficina_pago,ts_cta_banco_dep,	 -- Ref07 pholguiv
    ts_cta_banco, ts_moneda, ts_estado, ts_cheque,						 -- GYC 2015/Dic/03
    ts_oficina_cta, ts_hora, ts_tipo_contable,ts_ubicacion,ts_tipo_chequera, ts_cod_alterno)     -- JPM Ref.05
  values (@s_ssn, @t_trn, @s_date, 'N', @t_corr, @t_ssn_corr,
    @s_user, @s_term, @s_ofi, @t_rty, @s_org,
    @i_base_imp, @i_iva,@i_total, @i_cau, @w_valor_dev,	@w_ofi_homologada,@i_cta_deb,		-- Ref07 pholguiv
    @i_cta, @i_mon, 'S', @i_cheque,								-- GYC 2015/Dic/03
    @i_oficina_cta, getdate(), @i_tipo_contable,@i_ubi,@i_canal, @i_alterno)                    -- JPM Ref.05
  if @@error != 0
  begin
    if @i_aplcobis = 'S'
    begin
      exec cobis..sp_cerror
        @t_debug        = 'N',
        @t_file         = null,
        @t_from         = @w_sp_name,
        @i_num          = 33005 --Error de insert en transaccion de servicio
      --return 033000
    end
    else
      select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
      from cobis..cl_errores
                  where numero = 33005

    return 33005
  end

  --Ref08 pholguiv si tiene valor devolucion damnificado inserta la trx
    -------------------------------------------------------------------------------
    if @w_valor_dev > 0
       begin

         insert into cob_cuentas..cc_tran_servicio
  	    (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,ts_correccion,
  	    ts_ssn_corr, ts_usuario, ts_terminal, ts_oficina, ts_reentry, ts_origen,
  	    ts_valor, ts_saldo,ts_monto, ts_causa, ts_oficina_pago,ts_cta_banco, ts_moneda,
  	    ts_estado, ts_cheque,ts_ocasional, ts_oficina_cta, ts_hora, ts_tipo_contable,
  	    ts_ubicacion,ts_tipo_chequera, ts_cod_alterno,ts_cta_banco_dep)
  	  values (@s_ssn, 43538, @s_date, 'N', @t_corr,
  	    @t_ssn_corr, @s_user, @s_term, @s_ofi, @t_rty, @s_org,
  	    @w_valor_dev,0, @i_total, @i_cau, @w_ofi_homologada, @i_cta, @i_mon,
  	    'S', @i_cheque, @w_porc_comp, @i_oficina_cta, getdate(), @i_tipo_contable,
  	    @i_ubi, @i_canal, @i_alterno, @i_cta_deb )
  	  if @@error != 0
  	  begin
  	    if @i_aplcobis = 'S'
  	    begin
  	      exec cobis..sp_cerror
  		@t_debug        = 'N',
  		@t_file         = null,
  		@t_from         = @w_sp_name,
  		@i_num          = 33005 --Error de insert en transaccion de servicio
  	    end
  	    else
  	      select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
  	      from cobis..cl_errores
  			  where numero = 33005

  	    return 33005
  	  end
       end
     --Ref08 fin

end
else
begin
  if @t_trn in (4188, 4283,4284, 4189)              -- JPM Ref.05: Trx 4189
  begin --4188
  insert into cob_ahorros..ah_tran_servicio
      (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,
      ts_correccion, ts_ssn_corr,
      ts_usuario, ts_terminal, ts_oficina,ts_reentry, ts_origen,
      ts_valor, ts_saldo, ts_monto, ts_causa,ts_ocasional,ts_oficina_pago,ts_cta_banco_dep,	--Ref07 pholguiv
      ts_cta_banco, ts_moneda, ts_estado,
      ts_oficina_cta, ts_hora, ts_ubicacion,ts_causa_rev, ts_cod_alterno)       		-- JPM Ref.05
    values (@s_ssn, @t_trn, @s_date, 'N', @t_corr, @t_ssn_corr,
      @s_user, @s_term, @s_ofi, @t_rty, @s_org,
      @i_base_imp, @i_iva,@i_total, @i_cau, @w_valor_dev,@w_ofi_homologada,@i_cta_deb,		-- Ref07 pholguiv
      @i_cta, @i_mon, 'S',
      @i_oficina_cta, getdate(),@i_ubi,@i_canal, @i_alterno)                    		-- JPM Ref.05
    if @@error != 0
    begin
      if @i_aplcobis = 'S'
      begin
        exec cobis..sp_cerror
          @t_debug        = 'N',
          @t_file         = null,
          @t_from         = @w_sp_name,
          @i_num          = 43004 --Error de insert en transaccion de servicio
        --return 043000
      end
      else
        select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
        from cobis..cl_errores
        where numero = 43004

      return 43004
    end

       --Ref08 pholguiv si tiene valor devolucion damnificado inserta la trx
       -------------------------------------------------------------------------------
        if @w_valor_dev > 0
        begin

    	insert into cob_ahorros..ah_tran_servicio
    	      (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,
    	       ts_correccion, ts_ssn_corr, ts_usuario, ts_terminal, ts_oficina,
    	       ts_reentry, ts_origen,ts_valor, ts_saldo, ts_monto, ts_causa,
    	       ts_oficina_pago ,ts_cta_banco, ts_moneda, ts_estado,ts_ocasional,
    	       ts_oficina_cta, ts_hora, ts_ubicacion,ts_causa_rev, ts_cod_alterno,ts_cta_banco_dep)
    	    values (@s_ssn, 4997, @s_date, 'N',
    	       @t_corr, @t_ssn_corr, @s_user, @s_term, @s_ofi,
    	       @t_rty, @s_org, @w_valor_dev, 0 ,@i_total, @i_cau,
    	       @w_ofi_homologada, @i_cta, @i_mon, 'S', @w_porc_comp,
    	       @i_oficina_cta, getdate(),@i_ubi,@i_canal, @i_alterno,@i_cta_deb)
    	  if @@error != 0
    	  begin
    	    if @i_aplcobis = 'S'
    	    begin
    	      exec cobis..sp_cerror
    		@t_debug        = 'N',
    		@t_file         = null,
    		@t_from         = @w_sp_name,
    		@i_num          = 33005 --Error de insert en transaccion de servicio
    	    end
    	    else
    	      select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
    	      from cobis..cl_errores
    			  where numero = 43004

    	    return 43004
    	  end

     	end
     	---Ref08 fin
  end
  else
  begin
    if @t_trn in (120049,120050,120061,120072,120094,120161)
    begin

      insert into cob_virtuales..vi_tran_servicio
                   (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,
                    ts_correccion, ts_ssn_corr,
                    ts_usuario, ts_terminal, ts_oficina,ts_reentry, ts_origen,
                    ts_valor, ts_saldo, ts_monto, ts_causa, ts_ocasional, ts_oficina_pago,ts_cta_banco_dep, --Ref009:msilvag
                    ts_cta_banco, ts_moneda, ts_estado,
                    ts_oficina_cta, ts_hora, ts_ubicacion, ts_indicador,ts_causa_rev)
            values (@s_ssn, @t_trn, @s_date, 'N',
                    @t_corr, @t_ssn_corr,
                    @s_user, @s_term, @s_ofi, @t_rty, @s_org,
                    @i_base_imp, @i_iva,@i_total, @i_cau, @w_valor_dev, isnull(@w_ofi_homologada,0),@i_cta_deb, --Ref009:msilvag
                    @i_cta, @i_mon, 'A',
                    @i_oficina_cta, getdate(),@i_ubi, 1,@i_canal)

      if @@error != 0
      begin
        if @i_aplcobis = 'S'
        begin
          exec cobis..sp_cerror
            @t_debug        = 'N',
            @t_file         = null,
            @t_from         = @w_sp_name,
            @i_num          = 033005 --Error de insert en transaccion de servicio
        end
        else
          select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
          from cobis..cl_errores
          where numero = 33005

          return 033005
      end --if @@error != 0

       --Ref08 pholguiv inserta valor si tiene devolucion a damnificado
         if @w_valor_dev > 0
              begin

	 	insert into cob_virtuales..vi_tran_servicio
                   (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_clase,
                    ts_correccion, ts_ssn_corr,ts_usuario, ts_terminal, ts_oficina,
                    ts_reentry, ts_origen, ts_valor, ts_saldo,ts_monto, ts_causa,ts_oficina_pago ,
                    ts_cta_banco, ts_moneda, ts_estado, ts_ocasional, ts_oficina_cta, ts_hora,
                    ts_ubicacion, ts_indicador,ts_causa_rev,ts_cta_banco_dep)
           	 values (@s_ssn, 120175, @s_date, 'N',
                    @t_corr, @t_ssn_corr, @s_user, @s_term, @s_ofi,
                    @t_rty, @s_org, @w_valor_dev,0,@i_total, @i_cau ,isnull(@w_ofi_homologada,0),
                    @i_cta, @i_mon, 'A', @w_porc_comp,@i_oficina_cta, getdate(),
                    @i_ubi, 1,@i_canal,@i_cta_deb)

          	  if @@error != 0
          	  begin
          	    if @i_aplcobis = 'S'
          	    begin
          	      exec cobis..sp_cerror
          		@t_debug        = 'N',
          		@t_file         = null,
          		@t_from         = @w_sp_name,
          		@i_num          = 33005 --Error de insert en transaccion de servicio
          	    end
          	    else
          	      select @o_mensaje = '[' + @w_sp_name + ']  ' + mensaje
          	      from cobis..cl_errores
          			  where numero = 033005

          	    return 033005
          	  end

           end
     ---Ref08 fin

    end --if @t_trn =  120049
  end  --else if @t_trn in (4188, 4283)
end --else if @t_trn in (3188, 3484 ,3497, 3793, 43083, 43084, 43085, 3721, 43087)



select @i_cta = isnull(@i_cta, " "),----REF3
       @w_tipo_cta = isnull(@w_tipo_cta, " ")

if @i_guardar_iva = 'S'                          -- JPM Ref.05
begin
if @t_corr = 'N'
begin
    --Llamar al sp de insert a la tabla  cob_remesas..re_cobro_iva----REF3
    exec @w_return =  cob_remesas..sp_registra_trx_iva
             @s_date     =   @s_date,
             @t_trn      =   43080,
             @i_ssn      =   @s_ssn,
             @i_ofi      =   @s_ofi,
             @i_cau      =   '0',
             @i_tipocta  =   @w_tipo_cta,
             @i_cta      =   @i_cta,
             @i_costo    =   @i_base_imp,
             @i_imp_iva  =   @i_iva,
             @i_cant     =   1,
             @i_ced_ruc    =  null,
             @i_nombre      = null,
             @i_desp_servi   = null,  --descripcion del servicio
             @i_servicio     = @w_servicio,  -- servicio
             @i_producto     = @w_producto,
             @i_tasa_iva     = 0,
             @i_operacion    = 'I',
             @i_referencia   = @i_cta,
             @i_factura      = '',
             @i_fecha        = @i_fecha

       if @w_return != 0
            return @w_return

end
else
begin
        exec @w_return = cob_remesas..sp_registra_trx_iva
               @s_date     =   @s_date,
               @t_trn      =   43080,
               @i_ssn      =   @t_ssn_corr,
               @i_ofi      =   @s_ofi,
               @i_cau      =   '0',
               @i_operacion  = 'R',
               @i_fecha     = @i_fecha

        if @w_return != 0
            return @w_return
End
end                                             -- JPM Ref.05: @i_guardar_iva = 'S'


return 0

go

-- PHOYOSV aplicar esta asignacion de permiso en ambiente desarrollo
-- FAVOR AL MOMENTO DE REALIZAR EL PASE EN PRODUCCION REALIZAR LO SIGUIENTE:
-- COMENTAR EL EXEC DEL "apl_osb_hpdes"
-- DESCOMENTAR EL EXEC DEL "apl_osb_hpact"
if exists (select 1 from sysobjects where name = 'sp_cont_impuesto')        -- PHOYOSV Ref.06
begin
  grant execute on sp_cont_impuesto to apl_osb_hpact
  --grant execute on sp_cont_impuesto to apl_osb_hpdes
  grant execute on sp_cont_impuesto to Petrousr
  grant execute on sp_cont_impuesto to ivr 
end
go

