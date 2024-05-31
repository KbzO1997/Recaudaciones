/************************************************************************/
/*      Archivo:                procmatrsri.sp                          */
/*      Stored procedure:       sp_procesa_matricula_sri                */
/*      Base de datos:          cob_cuentas                             */
/*      Producto: Cuentas Corrientes                                    */
/*      Disenado por:  Jorge Pazminno Medina                            */
/*      Fecha de escritura: 24-Oct-2005                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios pr@iiedad de       */
/*  "BANCO BOLIVARIANO".                                                */  
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*                              PR@iOSITO                               */
/*      Este programa realiza la transaccion de solicitud de fondos     */
/*      de reservar.                                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA      AUTOR           RAZON                                  */
/*  24/Oct/2005  J.Pazminno      Emision inicial                        */
/*  30/Nov/2005  J.Pamzinno      Incluir totales por tipo de pago       */
/*  25/Ene/2006  Hugo Yépez      Corregir Identif transac no existe     */
/*  16/Nov/2006  Luis F Chacha   Agregar campo en conciliacion. CPS     */
/*  04/Dic/2006  Luis F Chacha   Considerar reversos de Bco en Conc.    */  
/*  20/Nov/2006  German Medina   Conciliacion entre Bco y Credimatic.   */ 
/*  12/Agos/2013 Sandra Merino    AJUSMV-AP-SGC00010154-SGC00010429     */  
/*  10/Oct/2013 Sandra Merino    SGC00011769                            */ 
/*  20/Sep/2023 Jonathan Guerrero RECM-778 CONCILIACION TRANSFERENCIA DE DOMINIO */ 
/************************************************************************/

use cob_servicios
go

if exists(select 1 from sysobjects where name = 'sp_procesa_matricula_sri' and type = 'P')
  drop proc sp_procesa_matricula_sri
go

create proc sp_procesa_matricula_sri (
  @s_ssn      int,
  @s_srv      varchar(30) = null,
  @s_lsrv     varchar(30) = null,
  @s_user     varchar(30) = null,
  @s_sesn     int,
  @s_term     varchar(10),
  @s_date     datetime,
  @s_org      char(1),
  @s_ofi      smallint,
  @s_rol      smallint,
  @s_org_err    char(1)     = null,
  @s_error    int         = null,
  @s_sev      tinyint     = null,
  @s_msg      varchar(255)= null,
  @t_debug    char(1)     = 'N',
  @t_file     varchar(14) = null,
  @t_from     varchar(32) = null,
  @t_rty      char(1)     = 'N',
  @t_trn      int,
  @i_operacion            char(2), 
  @i_fecha_carga  datetime = null,
  @i_sec    smallint = 0
)
as

declare  
  @w_return     int,
  @w_sp_name      varchar(32),
  @w_estado           char(1), 
  @w_cheque   money,
  @w_secuencial   varchar(20),
  @w_estado_deb         char(2),
  @w_ruc                varchar(13),
  @w_impuesto           varchar(30),
  @w_valor              money,
  @w_fecha_pago         smalldatetime,
  @w_efec               money,
  @w_nota_debito        money,
  @w_tarjeta            money,
  @w_corr               char(1),
  @w_msg_error          varchar(100),
  @w_tipo_tx            varchar(20),
  @w_corr_bb            char(1),
  @w_num_carga          int,
  @w_existe             char(1),
  @w_oficina            smallint,
  @w_usuario            descripcion,
  @w_hora_real          datetime,
  @w_canal              varchar(5),
  @w_fecha              datetime,
  @w_codlog_monitor     numeric,
  @w_sec_trx_sri        int, ---varchar(30),
  @w_sec_trx_bb         int, --varchar(30),
  @w_referencia         varchar(15),
  @w_referencia_bb      varchar(15),
  @w_trn_normal         int,
  @w_trn_diff           int,
  @w_tipo_pago          varchar(20),
  @w_causa              varchar(6),  --smerino
  @w_rubros              varchar, --smerino
  @w_num_proc_matr       int , --smerino
  @w_monto_proc_matr     money , --smerino
  @w_num_noproc_matr     int , --smerino
  @w_monto_noproc_matr   money , --smerino
  @w_monto_proc          money , --smerino
  @w_num_proc               int, --smerino
  @w_num_noproc            int,  --smerino
  @w_monto_noproc         money --smerino


/* Capture nombre del store procedure */
select @w_sp_name = object_name(@@procid)

/* Valida codigo de transaccion */
if  @t_trn not in (3678)
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 031048
   return 1
end  



/** OPERACIONES **/   


--set rowcount 20

/* BUSCAR TODA LA INFORMACION DEPENDIENDO LA FECHA INGRESADA COMO PROCESO*/  

if @i_operacion = 'Q'
  begin
    set rowcount 15
    
      -- GAMC - CONCILIACION BANKCARD - BANCO --==> INI
	  -- HABILITA EL PROCESO DE CONCILIACION SI SE HA REALIZADO LA CONCILIACION DEL BANCO CON BANKCARD
	  -- SE ACTIVA UNA BANDERA LOGICA QUE ES UN PARAMETRO EN LA COBIS..CL_PARAMETRO
	  if convert(varchar, @i_fecha_carga, 101) >= convert(varchar, getdate(), 101)
	  begin -- FECHA DE CONCILIACION - INI

		  if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'BALB' 
					and pa_char = 'N')
		  begin -- BANDERA LOGICA = 'N' - INI

			if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'BLAB' 
						and pa_char = 'N')
			begin -- SEGUNDA BANDERA LOGICA = 'N' - INI

				--SI LA CONCILIACION ENTRE EL BANCO Y CREDIMATIC NO SE HA REALIZADO NO SE PERMITE
				--REALIZAR LA CONCILIACION ENTRE EL BANCO Y EL SRI
				--print 'No se realizo la conciliacion'
				exec cobis..sp_cerror
							@t_debug = @t_debug,
							@t_file  = @t_file,
							@t_from  = @w_sp_name,
							@i_num   = 33332, --OJO PEDIR CODIGO DE ERROR
							@i_msg   = 'NO SE HA REALIZADO LA CONCILIACION ENTRE EL BANCO Y CREDIMATIC.'
				return 33332

			end -- SEGUNDA BANDERA LOGICA = 'N' - FIN

		  end -- BANDERA LOGICA = 'N' - FIN

	  end -- FECHA DE CONCILIACION - FIN
	-- GAMC - CONCILIACION BANKCARD - BANCO <==-- FIN
    
    select
      ' ',
      Estado = rm_estado,
      tipoPago = rm_tipo_pago,
      codTranIFIRev = rm_codtranifirev,
      tipoTx = rm_tipo_tx,
      codLogMon = rm_codlog_monitor,
      codTranIFI = rm_sectrx_bb,
      codValRec = rm_codvalrec,
      placaCpnCamv = rm_num_placa,
      valorDebitar = rm_valordebito,
      fechaPago = convert(varchar, rm_fecha_pago, 101),
      estadoDebito = rm_estado_debito,
      Oficina = rm_oficina,
      "Nombre Oficina" = of_nombre,
      Efectivo = rm_efectivo,
      Cheque = rm_cheque,
      Tarjeta = rm_tarjeta,
      Debito = rm_debito_cuenta,
      Usuario = rm_usuario,
      Canal = rm_canal,
      "Fecha Real Trx" = convert(varchar, rm_hora, 101) + ' ' + convert(varchar, rm_hora, 108),
      Mensaje = rm_error,
      Secuencia = rm_sec
    from cob_servicios..sv_matricula_sri_carga, cob_servicios..sv_recauda_matricula_sri,
         cobis..cl_oficina
    where mc_fecha = @i_fecha_carga and --op_estado = 'N' and
          mc_numero = rm_carga and
          rm_sec > @i_sec and
          rm_oficina *= of_oficina
    order by rm_sec
    
    set rowcount 0
    
    return 0
  end
  
  
if @i_operacion = 'V' -- Verificar Pago
  begin
  
     select @w_msg_error = null
     
     select @w_num_carga = mc_numero
     from   cob_servicios..sv_matricula_sri_carga
     where  mc_fecha = @i_fecha_carga
     
     if @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33332,
            @i_msg   = 'NO EXISTE ARCHIVO DE CARGA PARA PAGO MATRICULACA SRI'
        return 33332
       end
       

     select @w_estado         = rm_estado,
            @w_estado_deb     = rm_estado_debito,
            @w_codlog_monitor = convert(numeric, rm_codlog_monitor),
            @w_sec_trx_sri    = convert(int, rm_sectrx_bb),
            @w_referencia     = rm_num_placa,
            @w_impuesto       = rm_codvalrec,
            @w_tipo_pago      = rm_tipo_pago,
            @w_valor          = rm_valordebito,
            @w_fecha_pago     = rm_fecha_pago,
            @w_tipo_tx        = rm_tipo_tx
     from   cob_servicios..sv_recauda_matricula_sri
     where  rm_carga = @w_num_carga and
            rm_sec = @i_sec
     
     if @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33333,
            @i_msg   = 'NO EXISTE REGISTRO SOLICITADO DE OTRA FORMA DE PAGO SRI'
        return 33333
       end

     if @w_estado <> 'N'
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33334,
            @i_msg   = 'REGISTRO SOLICITADO DE OTRA FORMA DE PAGO SRI YA FUE PROCESADO'
        return 33334
       end
     
     select @w_estado = 'P' -- cambiar el estado si no hay error
     
     if @w_tipo_pago = 'MATRICULA'
       select @w_trn_normal = 3142,
              @w_trn_diff   = 3331,
              @w_causa      = '2'
              
     --'SMERINO
      if @w_tipo_pago = 'AJUSTES'
        select @w_trn_normal = 3142,
               @w_trn_diff   = 3331,
               @w_causa      = '5993'

     if @w_tipo_pago = 'TRANSF_DOM'
       select @w_trn_normal = 3295,
              @w_trn_diff   = 3336,
			  @w_causa  = '9718'

     
     -- ver si fecha es feriado
    select @w_fecha = @w_fecha_pago

  --smerino ajustes 
  ---  while 1 = 1
      ---begin
       --if exists(select 1
    while  exists(select 1   
	 from cobis..cl_dias_feriados
	 where df_ciudad = 1 and df_fecha = @w_fecha)
         --select @w_fecha = dateadd(dd,-1, @w_fecha) -- JPM 05/Dic/2005
     begin
        
        select @w_fecha = dateadd(dd,1, @w_fecha)
        
     end
         
      
    select @w_fecha_pago =@w_fecha  --'09/09/2013'   --@w_fecha
    select @w_existe = 'S'
    
    select @w_efec           = isnull(ts_saldo, 0),
          @w_tarjeta         = isnull(ts_monto, 0),
          @w_nota_debito     = isnull(ts_ocasional, 0),
          @w_cheque          = isnull(ts_valor, 0),
          @w_referencia_bb   = ts_referencia,
          @w_sec_trx_bb      = convert(int, ts_propietario),
          @w_oficina         = ts_oficina,
          @w_canal           = ts_tipo_chequera,
          @w_usuario         = ts_usuario,
          @w_hora_real       = ts_hora
    from  cob_cuentas..cc_tran_servicio_resp
    where ts_tipo_transaccion in (@w_trn_normal, @w_trn_diff)
          and ts_causa=@w_causa   ---smerino
          and ts_tsfecha  = @w_fecha_pago and
          ( ( @w_causa != '9718'  and convert(numeric, ts_campo_alt_dos) = @w_codlog_monitor )or 
            ( @w_causa != '9718'  and convert(int, ts_propietario) = @w_sec_trx_sri ) or 
            ts_secuencial = @w_sec_trx_sri ) and       --lfcm 16-noviembre-2006 Cambios por el secuencial CPS
          ts_correccion = 'N'

    -- si no existe, buscar la transaccion historica
    if @@rowcount = 0
     begin
       select @w_efec            = isnull(hs_saldo, 0),
              @w_tarjeta         = isnull(hs_monto, 0),
              @w_nota_debito     = isnull(hs_ocasional, 0),
              @w_cheque          = isnull(hs_valor, 0),
              @w_referencia_bb  = hs_referencia,
              @w_sec_trx_bb     = convert(int, hs_propietario),
              @w_oficina        = hs_oficina,
              @w_canal          = hs_tipo_chequera,
              @w_usuario        = hs_usuario,
              @w_hora_real      = hs_hora
       from   cob_cuentas_his..cc_his_servicio
       where  hs_tipo_transaccion in (@w_trn_normal, @w_trn_diff) 
              and hs_causa=@w_causa ---smerino
              and hs_tsfecha  = @w_fecha_pago and
          ( ( @w_causa != '9718'  and convert(numeric, hs_campo_alt_dos) = @w_codlog_monitor ) or 
            ( @w_causa != '9718'  and convert(int, hs_propietario) = @w_sec_trx_sri ) or
            hs_secuencial = @w_sec_trx_sri ) and	--lfcm 27-noviembre-2006 Cambios por el secuencial CPS
              hs_correccion = 'N'

       if @@rowcount = 0
         begin
           select @w_msg_error = 'REGISTRO DE PAGO NO EXISTE',
                  @w_estado    = 'E',
                  @w_existe    = 'N',
                  @w_estado_deb = 'NO'
         end
      end
      
      
	if @w_existe = 'S'
        begin
		-- buscar el reverso
		if @w_tipo_tx = 'TX_REVERSA'
		begin
		
			select @w_efec     = isnull(ts_saldo, 0),
			@w_tarjeta         = isnull(ts_monto, 0),
			@w_nota_debito     = isnull(ts_valor, 0),
			@w_cheque          = isnull(ts_ocasional, 0),
			@w_referencia_bb   = ts_referencia,
			@w_sec_trx_bb      = convert(int, ts_propietario),
			@w_oficina         = ts_oficina,
			@w_canal           = ts_tipo_chequera,
			@w_usuario         = ts_usuario,
			@w_hora_real       = ts_hora
			from  cob_cuentas..cc_tran_servicio_resp
			where ts_tipo_transaccion in (@w_trn_normal, @w_trn_diff)
			and ts_causa=@w_causa  ---smerino
			and ts_tsfecha  = @w_fecha_pago and
			( ( @w_causa != '9718' and convert(numeric, ts_campo_alt_dos) = @w_codlog_monitor ) or 
			  ( @w_causa != '9718' and convert(int, ts_propietario) = @w_sec_trx_sri ) or 
			   ts_ssn_corr   = @w_sec_trx_sri ) and		--lfcm 27-noviembre-2006 Cambios por el secuencial CPS
			--ts_secuencial = @w_sec_trx_sri ) and	--lfcm 27-noviembre-2006 Cambios por el secuencial CPS
			ts_correccion = 'S'
			
			-- si no existe, buscar la transaccion historica
			if @@rowcount = 0
			begin
				select @w_efec    = isnull(hs_saldo, 0),
				@w_tarjeta        = isnull(hs_monto, 0),
                          	@w_nota_debito    = isnull(hs_valor, 0),
                          	@w_cheque         = isnull(hs_ocasional, 0),
                          	@w_referencia_bb  = hs_referencia,
                          	@w_sec_trx_bb     = convert(int, hs_propietario),
                          	@w_oficina        = hs_oficina,
                          	@w_canal          = hs_tipo_chequera,
                          	@w_usuario        = hs_usuario,
                          	@w_hora_real      = hs_hora
                   		from   cob_cuentas_his..cc_his_servicio
                   		where  hs_tipo_transaccion in (@w_trn_normal, @w_trn_diff) 
                   		and hs_causa=@w_causa ---smerino
                   	       	and hs_tsfecha  = @w_fecha_pago and
          			( ( @w_causa != '9718'  and convert(numeric, hs_campo_alt_dos) = @w_codlog_monitor ) or 
          			  ( @w_causa != '9718'  and convert(int, hs_propietario) = @w_sec_trx_sri ) or
          			 hs_secuencial = @w_sec_trx_sri ) and	--lfcm 27-noviembre-2006 Cambios por el secuencial CPS
          	                hs_correccion = 'S' 

                   		if @@rowcount = 0
                     		begin
                       			select @w_msg_error = 'REGISTRO DE REVERSO DE PAGO NO EXISTE',
                              		@w_estado    = 'E',
                              		@w_existe    = 'N',
                              		@w_estado_deb = 'SI'
                     		end
                 	end
          	end
          	else	--> lfcm 04-diciembre-2006 (Inicio)
          	begin	
          		
          		select @w_efec     = isnull(ts_saldo, 0),
			@w_tarjeta         = isnull(ts_monto, 0),
			@w_nota_debito     = isnull(ts_valor, 0),
			@w_cheque          = isnull(ts_ocasional, 0),
			@w_referencia_bb   = ts_referencia,
			@w_sec_trx_bb      = convert(int, ts_propietario),
			@w_oficina         = ts_oficina,
			@w_canal           = ts_tipo_chequera,
			@w_usuario         = ts_usuario,
			@w_hora_real       = ts_hora
			from cob_cuentas..cc_tran_servicio_resp 
			where ts_tipo_transaccion in (@w_trn_normal, @w_trn_diff)
			and ts_causa=@w_causa ---smerino
			and ts_tsfecha = @w_fecha_pago		
			and ts_referencia = @w_referencia	
			and ts_ssn_corr = @w_sec_trx_sri  	
  			and ts_correccion = 'S'
  			
  			if @@rowcount > 0
  			begin
				--print 'Placa: %1! %2!', @w_referencia_bb, ' reversada en Banco'
				select @w_estado = 'E'
				select @w_msg_error = 'REVERSO EN BANCO'
				select @w_existe    = 'N'
	                        select @w_estado_deb = 'NO'
			end
          	end	--< lfcm 04-diciembre-2006 (Fin)
          	

		--Comparar la sumatoria de valores de la tran_servicio contra el valor cargado del archivo del SRI
         	if @w_efec + @w_cheque + @w_nota_debito + @w_tarjeta <> @w_valor 
	           	select @w_msg_error = 'VALOR DE PAGO NO COINCIDE',
	                @w_estado    = 'E',
	                @w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
         
	         	--lfcm 16-noviembre-2006 Cambios por el secuencial CPS (Inicio)
	         	/*
		else
        	
		        if @w_sec_trx_sri <> convert(int,@w_sec_trx_bb)  --hy-25-ene-2006 antes: if @w_sec_trx_sri <> @w_sec_trx_bb
				select @w_msg_error = 'IDENTIFICADOR DE TRANSACCION NO EXISTE',
				@w_estado    = 'E',
				@w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
		         */
	         	--lfcm 16-noviembre-2006 Cambios por el secuencial CPS (Fin)
	         
	         /* -- JPM 07/Dic/2005 no validar placa
	         else
	         if @w_referencia <> @w_referencia_bb
	           select @w_msg_error = 'NUMERO DE PLACA NO COINCIDE',
	                  @w_estado    = 'E',
	                  @w_estado_deb = case @w_estado_deb when 'NO' then 'SI' else 'NO' end
	         */
	end
     
	-- actualizar estado de pago/sri
	update cob_servicios..sv_recauda_matricula_sri
	set rm_estado         = @w_estado,
            rm_error          = @w_msg_error,
            rm_oficina        = @w_oficina,
            rm_estado_debito  = @w_estado_deb,
            rm_debito_cuenta  = @w_nota_debito,
            rm_tarjeta        = @w_tarjeta,
            rm_efectivo       = @w_efec,
            rm_cheque         = @w_cheque,
            rm_canal          = @w_canal,
            rm_usuario        = @w_usuario,
            rm_hora           = @w_hora_real
	where  rm_carga = @w_num_carga and rm_sec = @i_sec

	if @@error <> 0 or @@rowcount = 0
	begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33335,
            @i_msg   = 'ERROR AL ACTUALIZAR REGISTRO DE PAGO MATRICULA'
	return 33335
	end
  end


if @i_operacion = 'B' -- SUMA DE LOS VALORES POR PROCESAR, NO PROCESADOS Y PROCESADOS (CON ERROR INCLUIDO)
  begin
    -- total de la fecha
    select @w_num_carga = mc_numero
    from   cob_servicios..sv_matricula_sri_carga
    where  mc_fecha = @i_fecha_carga
    
     if @@rowcount = 0
       begin
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 33332,
            @i_msg   = 'NO EXISTE ARCHIVO DE PAGO MATRICULACION DE SRI'
        return 33332
       end
    create table #totale_ofp (
      monto_tot           money null,
      num_tot             int null,
      monto_proc          money null,
      num_proc            int null,
      monto_noproc        money null,
      num_noproc          int null,
      num_proc_matr       int null,
      monto_proc_matr     money null,
      num_noproc_matr     int null,
      monto_noproc_matr   money null,
      num_proc_trans      int null,
      monto_proc_trans    money null,
      num_noproc_trans    int null,
      monto_noproc_trans  money null,
      num_proc_ajus       int null,
      monto_proc_ajus     money null,
      num_noproc_ajus     int null,
      monto_noproc_ajus   money null,
      -- JPM 30/NOv/2005 --->
      monto_tot_matr      money null,
      num_tot_matr        int null,
      monto_tot_trans     money null,
      num_tot_trans       int null,
      monto_tot_ajus      money null,
      num_tot_ajus        int null 
      -- <--- JPM 30/Nov/2005
    )
    
    --smerino crea tabla de totales
     create table #totales_finales 
        (
          rubros              varchar(10),
          num_proc_matr       int null,
	  monto_proc_matr     money null,
	  num_noproc_matr     int null,
          monto_noproc_matr   money null
      
          -- <--- JPM 30/Nov/2005
         )
        
       delete from totales_finales
       
      if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al eliminar totales_finales',
	  @i_num    = 31183
	 return 31183
       end
       
    
    insert into #totale_ofp (monto_tot)
    select sum(rm_valordebito)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_tipo_tx = 'TX_DIRECTA'

     if @@error <> 0
      begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al Ingresar totale_ofp',
	  @i_num    = 31183
	 return 31183
      end
      

    update #totale_ofp 
        set  num_tot = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga



     if @@error <> 0
      begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar  totale_ofp ',
	  @i_num    = 31183
	 return 31183
      end
      



    update #totale_ofp 
        set monto_proc = sum(rm_valordebito),
            num_proc = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado in ('P') and 
           rm_tipo_tx = 'TX_DIRECTA'
           
	if @@error <> 0
	  begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar  ctotale_ofp ',
	  @i_num    = 31183
	 return 31183
	  end
      
           
           
    select  @w_monto_proc = sum(rm_valordebito),
            @w_num_proc = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado in ('P') and 
           rm_tipo_tx = 'TX_DIRECTA'


    update #totale_ofp 
        set monto_noproc = sum(rm_valordebito),
            num_noproc = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado <> 'P' and 
           rm_tipo_tx = 'TX_DIRECTA'
           

       if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar totale_ofp ',
	  @i_num    = 31183
	 return 31183
	 end
      
           
    select @w_monto_noproc = sum(rm_valordebito),
            @w_num_noproc = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado <> 'P' and 
           rm_tipo_tx = 'TX_DIRECTA'
                 
           

    -- valores de matriculacion
    update #totale_ofp 
        set monto_proc_matr = sum(rm_valordebito),
            num_proc_matr = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado in ('P') and 
           rm_tipo_pago = 'MATRICULA' and
           rm_tipo_tx = 'TX_DIRECTA'
           
           
if @@error <> 0
 begin

 exec cobis..sp_cerror
  @t_debug  = @t_debug,
  @t_file   = @t_file,
  @t_from   = @w_sp_name,
  @i_mensaje= 'Error al actualizar totale_ofp ',
  @i_num    = 31183
 return 31183
end

    
    select  @w_monto_proc_matr =sum(rm_valordebito),
            @w_num_proc_matr  =count(1)
    from   cob_servicios..sv_recauda_matricula_sri
        where  rm_carga = @w_num_carga and 
               rm_estado in ('P') and 
               rm_tipo_pago = 'MATRICULA' and
               rm_tipo_tx = 'TX_DIRECTA'


    update #totale_ofp 
        set monto_noproc_matr = sum(rm_valordebito),
            num_noproc_matr = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado <> 'P' and 
           rm_tipo_pago = 'MATRICULA' and
           rm_tipo_tx = 'TX_DIRECTA'
           
       if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar totale_ofp ',
	  @i_num    = 31183
	 return 31183
        end
           
           
     select    @w_monto_noproc_matr  =sum(rm_valordebito),
               @w_num_noproc_matr =count(1)  
     from   cob_servicios..sv_recauda_matricula_sri
     where  rm_carga = @w_num_carga and 
           rm_estado <> 'P' and 
           rm_tipo_pago = 'MATRICULA' and
           rm_tipo_tx = 'TX_DIRECTA'    

     insert into totales_finales (rubros,num_proc_matr,monto_proc_matr,num_noproc_matr,monto_noproc_matr)
     values("Matriculación",@w_num_proc_matr,@w_monto_proc_matr,@w_num_noproc_matr,@w_monto_noproc_matr)
     
        if @@error <> 0
     	 begin
     
     	 exec cobis..sp_cerror
     	  @t_debug  = @t_debug,
     	  @t_file   = @t_file,
     	  @t_from   = @w_sp_name,
     	  @i_mensaje= 'Error al insertar totales_finales',
     	  @i_num    = 31183
     	 return 31183
         end
           
      
    -- valors de transferencia de dominio    
    update #totale_ofp 
        set monto_proc_trans = sum(rm_valordebito),
            num_proc_trans = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado in ('P') and 
           rm_tipo_pago = 'TRANSF_DOM' and
           rm_tipo_tx = 'TX_DIRECTA'
           
        if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar totale_ofp ',
	  @i_num    = 31183
	 return 31183
        end
        
           
     select    @w_monto_proc_matr  = sum(rm_valordebito),
               @w_num_proc_matr  = count(1)  
     from   cob_servicios..sv_recauda_matricula_sri
         where  rm_carga = @w_num_carga and 
                rm_estado in ('P') and 
                rm_tipo_pago = 'TRANSF_DOM' and
                rm_tipo_tx = 'TX_DIRECTA'

    update #totale_ofp 
        set monto_noproc_trans = sum(rm_valordebito),
            num_noproc_trans = count(1)
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
           rm_estado <> 'P' and 
           rm_tipo_pago = 'TRANSF_DOM' and
           rm_tipo_tx = 'TX_DIRECTA'
           
     if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar  totale_ofp ',
	  @i_num    = 31183
	 return 31183
    end
           
           
           
   select     @w_monto_noproc_matr =sum(rm_valordebito),
              @w_num_noproc_matr  =count(1)  
    from   cob_servicios..sv_recauda_matricula_sri
    where  rm_carga = @w_num_carga and 
	              rm_estado <> 'P' and 
	              rm_tipo_pago = 'TRANSF_DOM' and
                      rm_tipo_tx = 'TX_DIRECTA'
           
    
    insert into totales_finales (rubros,num_proc_matr,monto_proc_matr,num_noproc_matr,monto_noproc_matr)
    values("Transf Dom (1%)",@w_num_proc_matr,@w_monto_proc_matr,@w_num_noproc_matr,@w_monto_noproc_matr)
    
      if @@error <> 0
    	 begin
    
    	 exec cobis..sp_cerror
    	  @t_debug  = @t_debug,
    	  @t_file   = @t_file,
    	  @t_from   = @w_sp_name,
    	  @i_mensaje= 'Error al insertar  totales_finales',
    	  @i_num    = 31183
    	 return 31183
        end
           
   --smerino aumenta conciliación para ajustes---
   
       -- valors de Ajustes    
       update #totale_ofp 
           set monto_proc_ajus = sum(rm_valordebito),
               num_proc_ajus = count(1)
       from   cob_servicios..sv_recauda_matricula_sri
       where  rm_carga = @w_num_carga and 
              rm_estado in ('P') and 
              rm_tipo_pago = 'AJUSTES' and
              rm_tipo_tx = 'TX_DIRECTA'
              

    if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar totale_ofp ',
	  @i_num    = 31183
	 return 31183
    end
              
              
        select    @w_monto_proc_matr = sum(rm_valordebito),
                  @w_num_proc_matr  = count(1)  
       from   cob_servicios..sv_recauda_matricula_sri
       where  rm_carga = @w_num_carga and 
              rm_estado in ('P') and 
              rm_tipo_pago = 'AJUSTES' and
              rm_tipo_tx = 'TX_DIRECTA'
                   
              
   
       update #totale_ofp 
           set monto_noproc_ajus = sum(rm_valordebito), 
               num_noproc_ajus = count(1)
       from   cob_servicios..sv_recauda_matricula_sri
       where  rm_carga = @w_num_carga and 
              rm_estado <> 'P' and 
              rm_tipo_pago = 'AJUSTES' and
              rm_tipo_tx = 'TX_DIRECTA'
              
              
              
       if @@error <> 0
       	 begin
       
       	 exec cobis..sp_cerror
       	  @t_debug  = @t_debug,
       	  @t_file   = @t_file,
       	  @t_from   = @w_sp_name,
       	  @i_mensaje= 'Error al actualizar totale_ofp ',
       	  @i_num    = 31183
       	 return 31183
       end
              
              
       select    @w_monto_noproc_matr =sum(rm_valordebito),
                 @w_num_noproc_matr   =count(1)         
       from   cob_servicios..sv_recauda_matricula_sri
       where  rm_carga = @w_num_carga and 
	      rm_estado <> 'P' and 
	      rm_tipo_pago = 'AJUSTES' and
	      rm_tipo_tx = 'TX_DIRECTA'
              
              
    insert into totales_finales (rubros,num_proc_matr,monto_proc_matr,num_noproc_matr,monto_noproc_matr)
    values("Ajustes",@w_num_proc_matr,@w_monto_proc_matr,@w_num_noproc_matr,@w_monto_noproc_matr)
    
    
       if @@error <> 0
           	 begin
           
           	 exec cobis..sp_cerror
           	  @t_debug  = @t_debug,
           	  @t_file   = @t_file,
           	  @t_from   = @w_sp_name,
           	  @i_mensaje= 'Error al insertar totales_finales',
           	  @i_num    = 31183
           	 return 31183
       end
       
              
---fin smerino

    -- JPM 30/Nov/2005 --->
    
    update #totale_ofp
     set num_tot_matr     = mc_trx_total,
         monto_tot_matr   = mc_recaudacion_pago,
         num_tot_trans    = mc_trx_total_transf_dom,
         monto_tot_trans  = mc_monto_pago_transf_dom,
         num_tot_ajus     = mc_trx_total_ajuste, 
         monto_tot_ajus   = mc_monto_pago_ajuste
    from  cob_servicios..sv_matricula_sri_carga
    where mc_numero = @w_num_carga
    -- <--- JPM 30/Nov/2005
    
       if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al actualizar totale_ofp ',
	  @i_num    = 31183
	 return 31183
       end
    
    insert into totales_finales (rubros,num_proc_matr,monto_proc_matr,num_noproc_matr,monto_noproc_matr)
    values("Total",@w_num_proc,@w_monto_proc,@w_num_noproc,@w_monto_noproc)
    
         if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al insertar totales_finales',
	  @i_num    = 31183
	 return 31183
        end
    

    set rowcount 0
    select 
        monto_tot           = isnull(monto_tot, 0),
        num_tot             = isnull(num_tot, 0),
        monto_proc          = isnull(monto_proc, 0),
        num_proc            = isnull(num_proc, 0),
        monto_noproc        = isnull(monto_noproc, 0),
        num_noproc          = isnull(num_noproc, 0),
        monto_proc_trans    = isnull(monto_proc_trans, 0),
        monto_noproc_trans  = isnull(monto_noproc_trans, 0),
        num_proc_trans      = isnull(num_proc_trans, 0),
        num_noproc_trans    = isnull(num_noproc_trans, 0),
        monto_proc_matr     = isnull(monto_proc_matr, 0),
        monto_noproc_matr   = isnull(monto_noproc_matr, 0),
        num_proc_matr       = isnull(num_proc_matr, 0),
        num_noproc_matr     = isnull(num_noproc_matr, 0),
        monto_proc_ajus     = isnull(monto_proc_ajus, 0),
        monto_noproc_ajus   = isnull(monto_noproc_ajus, 0),
        num_proc_ajus       = isnull(num_proc_ajus, 0),
        num_noproc_ajus     = isnull(num_noproc_ajus, 0), -- JPM 30/Nov/2005 --->
        num_tot_matr        = isnull(num_tot_matr, 0),
        monto_tot_matr      = isnull(monto_tot_matr, 0),
        num_tot_trans       = isnull(num_tot_trans, 0),
        monto_tot_trans     = isnull(monto_tot_trans, 0),
        num_tot_ajus        = isnull(num_tot_ajus, 0),
        monto_tot_ajus      = isnull(monto_tot_ajus, 0)   -- <--- JPM 30/Nov/2005
    from #totale_ofp   
    
   /* set rowcount 0
    select  
          'Rubros' =  rubros ,
          'Procesados' = isnull(num_proc_matr,0),
	  'Monto_Proc' = isnull(monto_proc_matr,0),
	  'No_Proce'   = isnull(num_noproc_matr,0),
          'Monto_No_Proc' =isnull(monto_noproc_matr,0)
    from totales_finales */

    
    return 0
  end

if @i_operacion = 'T' -- SUMA DE LOS VALORES POR PROCESAR, NO PROCESADOS Y PROCESADOS (CON ERROR INCLUIDO)
  begin
   
   set rowcount 0
      select  
            'Rubros' =  rubros ,
            'Procesados' = isnull(num_proc_matr,0),
  	    'Monto_Proc' = isnull(monto_proc_matr,0),
  	    'No_Proce'   = isnull(num_noproc_matr,0),
            'Monto No Proc' =isnull(monto_noproc_matr,0)
      from totales_finales 
  
      delete from totales_finales
      
    
    if @@error <> 0
	 begin

	 exec cobis..sp_cerror
	  @t_debug  = @t_debug,
	  @t_file   = @t_file,
	  @t_from   = @w_sp_name,
	  @i_mensaje= 'Error al elimnar registros totales_finales',
	  @i_num    = 31183
	 return 31183
    end
       
      
    return 0
  
  end
  


if @i_operacion = 'C'
  begin
    select mc_archivo,
        mc_cod_banco,
        mc_nombre_banco,
        mc_fecha_recauda = convert(varchar, mc_fecha_recauda, 101),
        mc_trx_pago_ajuste,
	mc_trx_rev_ajuste,
	mc_trx_total_ajuste,
	mc_monto_pago_ajuste,
	mc_monto_rev_ajuste,
        mc_monto_total_ajuste,
        mc_trx_pago,
        mc_trx_rev,
        mc_trx_total,
        mc_recaudacion_pago,
        mc_recaudacion_rev,
        mc_recaudacion_total,
        mc_trx_pago_transf_dom,
        mc_trx_rev_transf_dom,
        mc_trx_total_transf_dom,
        mc_monto_pago_transf_dom,
        mc_monto_rev_transf_dom,
        mc_monto_total_transf_dom,
        -- esta columna posee los nombres de cada tag para el archivo xml: el orden corresponde
        -- a cada columna devuelta por este select desde cg_cod_banco hasta cg_declaraciones_rev
        cabecera_tags0 = 'codigoBanco,nombreBanco,fechaRecaudacion,',
        cabecera_tags1 = 'numeroTransaccionesDirectasAJUSTES,numeroTransaccionesReversadasAJUSTES,' +
	                  'numeroTransaccionesTotalesAJUSTES,montoTransaccionesDirectasAJUSTES,' +
                         'montoTransaccionesReversasAJUSTES,montoTotalTransaccionesAJUSTES,',
        cabecera_tags2 =  'numeroTransaccionesDirectasMATRICULA,numeroTransaccionesReversadasMATRICULA,' +
                         'numeroTransaccionesTotalesMATRICULA,montoTransaccionesDirectasMATRICULA,' +
                         'montoTransaccionesReversasMATRICULA,montoTotalTransaccionesMATRICULA,' ,
        cabecera_tags3 = 'numeroTransaccionesDirectasTRANSF_DOM,numeroTransaccionesReversadasTRANSF_DOM,' +
                         'numeroTransaccionesTotalesTRANSF_DOM,montoTransaccionesDirectasTRANSF_DOM,' +
                         'montoTransaccionesReversasTRANSF_DOM,montoTotalTransaccionesTRANSF_DOM,' 
    from  cob_servicios..sv_matricula_sri_carga
    where mc_fecha = @i_fecha_carga

    if @@rowcount = 0
     begin
      exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 33335,
          @i_msg   = 'SE EXITE ARCHIVO DE PAGO MATRICULACION SRI PARA LA FECHA SOLICITADA'
      return 33333
     end
  end

return 0

go

