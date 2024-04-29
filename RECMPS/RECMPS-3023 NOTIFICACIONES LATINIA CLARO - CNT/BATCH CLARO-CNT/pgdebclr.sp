/************************************************************************/
/*    Archivo           : pgdebclr.sp                                   */
/*    Stored procedure  : sp_cobr_deb_claro                             */
/*    Base de datos     : cob_pagos                                     */
/*    Producto          : Cuentas de pagos                              */
/*    Disenado por      : Daniel Pereira V.                             */
/*    Fecha de escritura: 15/Nov/2011                                   */
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
/*  Este proceso Genera el cobro de debitos automaticos de claro        */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*   1  28/Nov/2011   Daniel Pereira V.    CTE-CC-10665 Emision Inicial */
/*   2  18/Jul/2012   Daniel Pereira V.    CTE-CC-11619                 */
/*   3  10/25/2012    Daniel Pereira V.    CTE-CE-SGC00005307           */
/*   4  12/Jun/2013   Daniel Pereira V.    SGC00009048 Debitos Ecutel   */
/*   5  05/Nov/2015   Miriam Lindao R.     RETIVA-AP-SGC00021353-SGC00021355*/
/*                                         Retención IVA Bienes/Servicio    */
/*   6  03/Ene/2017   María José Silva     RECA-CC-SGC00027525          */
/*   7  02/Feb/2017   María José Silva     RECA-CE-SGC00027860 Quitar control de error*/
/*   8  06/Sep/2018   Danny Olaya S.       RECA-CC-SGC00030102 - RECA-CC-SGC00031890 Mejoras Batch de Claro*/
/*   9  13/Feb/2019   Daniel Pereira       SDEB-1 Suspensión de débitos empresas*/
/*  10  02/Jul/2019   Danny Olaya          RECMPS-38 (JIRA) - REPROCESO CLARO POSTPAGO */
/*  11  17/Ene/2020   Daniel Pereira       RECM-73 Ajuste en validacion de saldos */
/*  12  09/Mar/2020   Luis Gusñay C.  RECMPS-91 (JIRA) - CLARO BATCH FINES DE SEMANA */
/*  13  26/Dic/2023	  Sandra Arroba S.     RECMPS-2980 Notificaciones Latinia  */
/****************************************************************************/

use cob_pagos
go

if exists (select 1 from sysobjects where name = 'sp_cobr_deb_claro' and type = 'P')
begin
   drop procedure dbo.sp_cobr_deb_claro
   if exists(select 1 from sysobjects where name = 'sp_cobr_deb_claro' and type = 'P')
	PRINT '<<< DROP PROCEDURE sp_cobr_deb_claro -- ERROR -- >>>'
   else
   	PRINT '== DROP PROCEDURE sp_cobr_deb_claro *OK* =='
end

go

create procedure dbo.sp_cobr_deb_claro

(
   @s_ssn                  int          = null,
   @s_srv                  varchar(30)  = null,
   @s_user                 varchar(30)  = null,
   @s_term                 varchar(10)  = null,
   @s_ofi                  smallint     = null,
   @t_debug                char(1)      =  'N',
   @t_file                 varchar(14)  = null,
   @t_trn                  int          = null,
   @i_fecha                varchar(10),
   @i_tipo                 char(1)    ,
   @i_reproceso            char(1)      = null,
   @o_return               int          = null  out,
   @i_empresa              varchar(5),  --REF 4
   @i_intento			   int 			= null  --REF 10
)

as

declare
   @w_return               int,
   @w_tipo_cta             char(2),
   @w_num_cta              varchar(10),
   @w_trn                  int,
   @w_cuenta               int,
   @w_error                int,
   @w_desc_error           varchar(40),
   @w_sec_file             int,
   @w_valor_rec            money ,
   @w_causa_deb            char(5),
   @w_ssn_monet            int,
   @w_contrato             varchar(18),
   @w_identificacion       varchar(14),
   @w_nombre               varchar(60),
   @w_notaVenta            varchar(15),
   @w_fecha_pro            datetime,
   @w_base_imp             money,
   @w_sp_name              varchar(32),
   @w_estado               char(1),
   @w_tipo_doc             char(3),
   @w_graba                char(1),
   -->Ref05
   --@w_cont_especial        char(1),
   @w_baseimp0             money,
   @w_baseimp12            money,
   @w_ivabienes            money,
   @w_ivaservicios         money,
   @w_exo_ivabienes        money,
   @w_exo_ivaservicios     money,
   --<--Ref05
   --Ref006:msilvag Inicio
   @w_comision              money,
   @w_rubro                 varchar(5),
   @w_servicio              varchar(4),
   @w_causal_com_cte        varchar(5),
   @w_causal_com_aho        varchar(5),
   @w_ssn_monet1            int,
   @w_tasa                  float,
   @w_impuesto2             float,
   @w_base_imp2             money,
   --Ref006:msilvag Fin
   --Ref008 Inicio
   @w_valor_minimo          money,
   @w_param                 char(1),
   @w_servi_person          varchar(5),
   @w_disponible_cte        money,
   @w_disponible_aho		money,
   @w_disponible_valsus     money,
   @w_saldo_contable        money,
   @w_saldo_valsus          money,
   @w_valor_debito          money,
   @w_val_deb_min           money,
   @w_total                 money,
   @w_valor                 money,
   @w_tipocta               char(3),
   @w_rowcount              int,
   @w_base_imponible        money,
   @w_estado_p				char(1),
   @w_valor_pagado			money,
   --Ref008 Fin
   @v_ruc_emp		varchar(13),  --ref9
   @v_estado		char(1),    --ref9
   @v_nombcta       varchar(30), --KBastidz
   @s_celular      varchar(10),  --KBastidz
   @s_correo        varchar(64), --KBastidz
   @v_cliente       int
   

					  
select @w_sp_name = 'sp_cobr_deb_claro'
select @w_graba = 'S'
select @w_estado_p = 'F' --Ref008

--Ref008 Inicio
/*select @w_param = pa_char 
from cobis..cl_parametro
where pa_nemonico = 'PBCL'
and pa_producto = 'CTE'*/
--Ref008 Fin

select @w_param = ltrim(rtrim(c.valor)) 
from cobis..cl_tabla t,
cobis..cl_catalogo c
where t.tabla = 'cl_cobro_par_claro' 
and c.tabla = t.codigo
and c.estado = 'V'
and c.codigo = @i_empresa 

--------------------------------------------------------------------------------------------
------------------------------PROCESO DEBITOS AUTOMATICOS-----------------------------------
--------------------------------------------------------------------------------------------
if @i_tipo = 'P'
begin
   
  --lee la fecha proceso de cobis
  select @w_fecha_pro = fp_fecha
  from cobis..ba_fecha_proceso

    --Ref008 Inicio
    select  @w_servi_person = pe_cod_serv, 
            @w_rubro        = pe_rubro ,
            @w_servicio     = pe_serv_com,
            @v_ruc_emp      = pe_ruc    --ref9
    from cob_pagos..pg_person_empresa  
    where pe_empresa = convert(int,@i_empresa)
    
    select @w_tasa = 0
    --Obtener la tasa del IVA
    exec @w_return= cob_pagos..sp_verif_genera_costo
        @s_date         = @w_fecha_pro,
        @i_mon          = 1,
        @i_rubro        = 'IVA',
        @i_servicio     = @w_servi_person , --'CSPR',
        @i_canal        = 'DIR',
        @i_tipocta      = '3',
        @o_costo        = @w_tasa out    
    if @w_return <> 0
    begin
        exec cobis..sp_cerror
            @t_debug         = '',
            @t_file          = '',
            @t_from          = @w_sp_name,
            @i_num           = 300003361
        return @w_return
    end
        
    --Ref008 Fin 

    --Ref006:msilvag Inicio
    /*if @i_empresa = '38'
        select @w_rubro = 'CDCP' , @w_servicio = '598'
    else
        select @w_rubro = 'CDCF' , @w_servicio = '749'*/
        
    
    --Obtener causales de debito comisión
    select @w_causal_com_cte = b.valor
    from cobis..cl_tabla a, cobis..cl_catalogo b
    where a.tabla = 'causa_nd_comision_servcte'
    and a.codigo = b.tabla
    and b.codigo = @i_empresa
    and estado = 'V'
    
    select @w_causal_com_aho = b.valor
    from cobis..cl_tabla a, cobis..cl_catalogo b
    where a.tabla = 'causa_nd_comision_servaho'
    and a.codigo = b.tabla
    and b.codigo = @i_empresa
    and estado = 'V'
    --Ref006:msilvag Fin

  declare proc_nd_claro cursor for
    select cd_sec_file,
          cd_tipo_cta,
          cd_num_cta,
          cd_valor_rec,
          cd_cod_contrato,
          cd_identificacion,
          cd_nombre_deudor,
          cd_num_cmpbte_vta ,
          cd_base_imponible,
          cd_estado,
          cd_tipo_doc,
          -->Ref05
          --cd_contrib_especial,
          cd_baseimp0,
          cd_baseimp12,
          cd_mont_ivabienes , --Ref008 cd_ivabienes,
          cd_mont_ivaserv   , --Ref008 cd_ivaservicio,
          cd_exonera_ivabienes,
          cd_exonera_ivaserv,
          --<--Fin Ref05
          cd_valor_minimo  --Ref008
          from cob_pagos..pg_cobro_debitos_servicio
          where cd_fecha_arc = @i_fecha
          and cd_empresa = @i_empresa  --REF 4
          and cd_forma_cobro = 'CUE'
          and cd_estado = 'I' --REF 4
		  and cd_no_archivo = @i_intento --REF 10
          and cd_cod_error is null
          order by cd_sec_file

  open proc_nd_claro

  fetch proc_nd_claro
  into  @w_sec_file,
        @w_tipo_cta,
        @w_num_cta,
        @w_valor_rec,
        @w_contrato,
        @w_identificacion,
        @w_nombre,
        @w_notaVenta ,
        @w_base_imponible , --Ref008 @w_base_imp,
        @w_estado,
        @w_tipo_doc,
        -->Ref05 MLR ini
        --@w_cont_especial,
        @w_baseimp0,
        @w_baseimp12,
        @w_ivabienes,
        @w_ivaservicios,
        @w_exo_ivabienes,
        @w_exo_ivaservicios,
        --<--Ref05 fin
        @w_valor_minimo  --Ref008 
  while @@sqlstatus = 0
  begin
	
	
      select @w_graba = 'S'

begin tran
    select @w_comision = 0, @w_valor_debito = 0 , @w_val_deb_min  = 0, @w_valor = 0, @w_total = 0, @w_base_imp2 = 0, @w_impuesto2 = 0, @w_cuenta = 0
    select @w_base_imp = 0

    if @w_tipo_cta = '03'
        select @w_tipocta = 'CTE'
    else
        select @w_tipocta = 'AHO'
    
    --Ref008 Inicio
    if @w_tipo_cta not in ('03','04')
    begin	
        rollback tran

        select @w_graba = 'N'
        select @w_error = 21006

        select @w_desc_error = mensaje
        from cobis..cl_errores
        where numero= @w_error

        update cob_pagos..pg_cobro_debitos_servicio
        set cd_procesar = 'N',
            cd_estado = 'E',
            cd_cod_error = @w_error,
            cd_desc_error = @w_desc_error
        where cd_fecha_arc = @i_fecha
        and cd_empresa = @i_empresa  
        and cd_sec_file = @w_sec_file
		and cd_no_archivo = @i_intento --REF 10
        and cd_estado = 'I' 

        goto FETCH_REGISTRO 
    end  --if @w_tipo_cta not in ('03','04')
    --Ref008 Fin
    
    --ref9 ini
            
    select @v_estado = ''
    exec cob_servicios..pa_reca_csuspension_cta
    	@e_ruc_emp = @v_ruc_emp,
    	@e_cta = @w_num_cta,
	@s_estado = @v_estado out	
	
    if @v_estado = 'B'
    begin   
    	rollback tran
        select @w_graba = 'N'
        select @w_error = 303527

        select @w_desc_error = mensaje
        from cobis..cl_errores
        where numero= @w_error

        update cob_pagos..pg_cobro_debitos_servicio
        set cd_procesar = 'N',
            cd_estado = 'E',
            cd_cod_error = @w_error,
            cd_desc_error = @w_desc_error
        where cd_fecha_arc = @i_fecha
        and cd_empresa = @i_empresa  
        and cd_sec_file = @w_sec_file
		and cd_no_archivo = @i_intento --REF 10
        and cd_estado = 'I' 
   
        goto FETCH_REGISTRO    
    end  --if @v_estado = 'B'
    --ref9 ini
    
    --Obtiene la comisión
    exec @w_return = cob_pagos..sp_verif_genera_costo
            @s_date         = @i_fecha,
            @i_mon          = 1,
            @i_rubro        = @w_rubro ,
            @i_servicio     = @w_servi_person ,
            @i_canal        = 'DIR',
            @i_tipocta      = @w_tipocta,
            @i_cuenta       = @w_num_cta,
            @o_costo        = @w_comision out
    if @w_return <> 0
    begin
        rollback tran
		
        select @w_graba = 'N'
        select @w_error = @w_return
        select @w_desc_error = mensaje
        from cobis..cl_errores
        where numero= @w_return
        
        update cob_pagos..pg_cobro_debitos_servicio
        set cd_procesar = 'N',
            cd_estado = 'E',
            cd_cod_error = @w_error,
            cd_desc_error = @w_desc_error
        where cd_fecha_arc = @i_fecha
        and cd_empresa = @i_empresa  
        and cd_sec_file = @w_sec_file
		and cd_no_archivo = @i_intento --REF 10
        and cd_estado = 'I'

        goto FETCH_REGISTRO 
    end
    
    --Realiza la obtencion de la base imponible y del impuesto IVA
    if @w_comision > 0
    begin
        if @w_tasa > 0
        begin
            exec @w_return = cob_cuentas..sp_cal_impuesto
                @i_tasa         = @w_tasa,
                @i_valor_serv   = @w_comision,
                @o_base_imp     = @w_base_imp2 out,
                @o_impuesto     = @w_impuesto2 out
            if @w_return <> 0
            begin
                rollback tran
                        
                select @w_graba = 'N'
                select @w_error = @w_return
                select @w_desc_error = mensaje
                from cobis..cl_errores
                where numero= @w_return

                update cob_pagos..pg_cobro_debitos_servicio
                set cd_procesar = 'N',
                    cd_estado = 'E',
                    cd_cod_error = @w_error,
                    cd_desc_error = @w_desc_error
                where cd_fecha_arc = @i_fecha
                and cd_empresa = @i_empresa  
                and cd_sec_file = @w_sec_file
                and cd_estado = 'I'
                
                goto FETCH_REGISTRO 
            end --if @w_return <> 0
        end --if @w_tasa > 0
        else
            select @w_base_imp2 = 0, @w_impuesto2 = 0

    end  --fin if @w_comision > 0
    else
        select @w_base_imp2 = 0, @w_impuesto2 = 0


    select @w_valor_pagado = sum(cd_valor_pagado) from pg_cobro_debitos_servicio where cd_empresa = @i_empresa and cd_fecha_arc = @i_fecha and cd_estado = 'F' and cd_sec_file = @w_sec_file and cd_cod_contrato = @w_contrato
	
  -- ejecutar NDC automatica
      --CORRIENTE
      if  @w_tipo_cta = '03'
      begin

	--validar si cuenta existe en el maestro
	select @w_cuenta = cc_ctacte,
			@v_nombcta = substring(cc_nombre,1,32), --KBastidz
			@v_cliente = cc_cliente --KBastidz
	from cob_cuentas..cc_ctacte
	where cc_cta_banco = @w_num_cta
    	select @w_rowcount = @@rowcount
    	if @w_rowcount = 0 or @w_rowcount is null
	begin
	    rollback tran

	    select @w_graba = 'N'
	    select @w_error = 18755

	    select @w_desc_error = mensaje
	    from cobis..cl_errores
	    where numero= @w_error

	    update cob_pagos..pg_cobro_debitos_servicio
	    set cd_procesar = 'N',
		cd_estado = 'E',
		cd_cod_error = @w_error,
		cd_desc_error = @w_desc_error
	    where cd_fecha_arc  = @i_fecha
	    and cd_empresa      = @i_empresa 
	    and cd_sec_file     = @w_sec_file
	    and cd_estado       = 'I'  

	    goto FETCH_REGISTRO
        end

         select  @w_trn = 3050

         select @w_causa_deb = isnull(b.valor,'484') --REF 4
         from cobis..cl_tabla a, cobis..cl_catalogo b
         where a.tabla = 'causa_nd_cte_servicios'
         and a.codigo = b.tabla
         and b.codigo = @i_empresa
         and estado = 'V'
        
        --Ref008 Inicio
        if @w_param = 'S'
        begin

            exec @w_return = cob_cuentas..sp_calcula_saldo
                @i_cuenta           = @w_cuenta,
                @i_fecha            = @i_fecha,
                @i_ofi              = 0,
                @o_disponible       = @w_disponible_valsus out,
                @o_saldo_para_girar = @w_disponible_cte out,
                @o_saldo_contable   = @w_saldo_contable out,
                @o_saldo_valsus     = @w_saldo_valsus out
            if @w_return <> 0
            begin
                rollback tran

                select @w_graba = 'N'
                select @w_error = @w_return
				

                select @w_desc_error = mensaje
                from cobis..cl_errores
                where numero= @w_return

                update cob_pagos..pg_cobro_debitos_servicio
                set cd_procesar = 'N',
                    cd_estado = 'E',
                    cd_cod_error = @w_error,
                    cd_desc_error = @w_desc_error
                where cd_fecha_arc  = @i_fecha
                and cd_empresa      = @i_empresa 
                and cd_sec_file     = @w_sec_file
                and cd_estado       = 'I'  

                goto FETCH_REGISTRO
            end
			
            select @w_disponible_cte = floor(@w_disponible_cte * 100) / 100
			
				if @w_valor_pagado > 0 
				begin
					select @w_valor_debito = (@w_valor_rec + @w_comision)-@w_valor_pagado 
					select @w_val_deb_min  = @w_valor_pagado - (@w_valor_minimo + @w_comision)
				end
				else
				begin
					select @w_valor_debito = @w_valor_rec + @w_comision
					select @w_val_deb_min  = @w_valor_minimo + @w_comision
				end
            
				if @w_disponible_cte >= @w_valor_debito
				begin
					if @w_valor_pagado > 0
					begin
						select @w_valor = @w_valor_rec - @w_valor_pagado
						select @w_base_imp = @w_base_imponible
					end
					else
					begin
						select @w_valor = @w_valor_rec
						select @w_base_imp = @w_base_imponible
						select @w_estado_p = 'P'
					end
				end
				else
				begin
					if @w_disponible_cte > @w_val_deb_min
					begin
						if @w_valor_pagado > 0
						begin
							select @w_valor = @w_val_deb_min - @w_valor_pagado
							select @w_base_imp = @w_disponible_cte - @w_val_deb_min
						end
						else
						begin
							select @w_total = @w_disponible_cte - @w_val_deb_min
							select @w_valor = @w_total + @w_valor_minimo
							select @w_base_imp = @w_total
						end
					end
					else
					begin
						if @w_disponible_cte = @w_val_deb_min
						begin
							if @w_valor_pagado > 0
							begin
								select @w_valor = @w_valor_minimo - @w_valor_pagado
								select @w_base_imp = 0.00
							end
							else
							begin
								select @w_valor = @w_valor_minimo
								select @w_base_imp = 0.00
							end
						end
						else
						begin
							rollback tran
							select @w_graba = 'N'
                        
							select @w_error = 31017
							select @w_desc_error = mensaje
							from cobis..cl_errores
							where numero= @w_error
                        
							update cob_pagos..pg_cobro_debitos_servicio
							set cd_procesar = 'N',
								cd_estado = 'E',
								cd_cod_error = @w_error,
								cd_desc_error = @w_desc_error
							where cd_fecha_arc = @i_fecha
							and cd_empresa = @i_empresa  
							and cd_sec_file = @w_sec_file
							and cd_estado = 'I'
                                       
							goto FETCH_REGISTRO 
						end
					end
				end
        end
        else
        begin
            select @w_valor = @w_valor_rec
            select @w_base_imp = @w_base_imponible
        end
        --Ref008 Fin
        
			exec @w_return = cob_cuentas..sp_ccndc_automatica
				@s_srv              = @s_srv,
				@s_ofi              = @s_ofi,
				@s_ssn              = @s_ssn,
				@s_user             = @s_user,
				@s_term             = @s_term,
				@t_trn              = @w_trn ,
				@i_cta              = @w_num_cta,
				@i_val              = @w_valor , --Ref008 @w_valor_rec,
				@i_cau              = @w_causa_deb,
				@i_mon              = 1,
				@i_con_tran         = 'N',
				@i_ref              = @w_contrato,
				@i_detalle          = @w_contrato,
				@i_fecha            = @w_fecha_pro ,
				@i_aplcobis         = 'N',
				@o_ssn_monet        = @w_ssn_monet out

				 if @w_return <> 0
				 begin
					  rollback tran
					  select @w_graba = 'N'
					  select @w_error = @w_return
					  select @w_desc_error = mensaje
					  from cobis..cl_errores
					  where numero= @w_return
					  update cob_pagos..pg_cobro_debitos_servicio
						set cd_procesar = 'N',
							cd_estado = 'E',
							cd_cod_error = @w_error,
							cd_desc_error = @w_desc_error
						where cd_fecha_arc = @i_fecha
						and cd_empresa = @i_empresa  --REF 4
						and cd_sec_file = @w_sec_file
						and cd_estado = 'I' --REF 4
					   
						goto FETCH_REGISTRO --REF 4
				 end     
		end
      else
        --AHORROS
        if @w_tipo_cta = '04'
        begin              
        	--validar si cuenta esta cerrada        	
		if exists (select 1 from cob_ahorros..ah_cuenta_cerrada
			   where ac_cta_banco = @w_num_cta)
		begin
		    rollback tran

		    select @w_graba = 'N'
		    select @w_error = 41057

		    select @w_desc_error = mensaje
		    from cobis..cl_errores
		    where numero= @w_error

		    update cob_pagos..pg_cobro_debitos_servicio
		    set cd_procesar = 'N',
			cd_estado = 'E',
			cd_cod_error = @w_error,
			cd_desc_error = @w_desc_error
		    where cd_fecha_arc  = @i_fecha
		    and cd_empresa      = @i_empresa 
		    and cd_sec_file     = @w_sec_file
		    and cd_estado       = 'I'  

		    goto FETCH_REGISTRO
        	end
        
        
        	--validar si cuenta existe en el maestro
        	select @w_cuenta = ah_cuenta,
				   @v_nombcta = substring(ah_nombre,1,32), --KBastidz
				   @v_cliente = ah_cliente	 --KBastidz
	        from cob_ahorros..ah_cuenta 
	        where ah_cta_banco = @w_num_cta
	        select @w_rowcount = @@rowcount
	        if @w_rowcount = 0 or @w_rowcount is null
	        begin
	            rollback tran
	            
	            select @w_graba = 'N'
	            select @w_error = 18755
	
	            select @w_desc_error = mensaje
	            from cobis..cl_errores
	            where numero= @w_error
	
	            update cob_pagos..pg_cobro_debitos_servicio
	            set cd_procesar = 'N',
	                cd_estado = 'E',
	                cd_cod_error = @w_error,
	                cd_desc_error = @w_desc_error
	            where cd_fecha_arc  = @i_fecha
	            and cd_empresa      = @i_empresa 
	            and cd_sec_file     = @w_sec_file
	            and cd_estado       = 'I'  
	            
	            goto FETCH_REGISTRO
        	end
        
        
            select  @w_trn = 4272

            select @w_causa_deb = isnull(b.valor,'484') --REF 4
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'causa_nd_aho_servicios'
            and a.codigo = b.tabla
            and b.codigo = @i_empresa
            and estado = 'V'
            
            --Ref008 Inicio
            if @w_param = 'S'
            begin
                
                --Obtener saldo de cuenta de ahorros
                exec @w_return = cob_ahorros..sp_ahcalcula_saldo
                    @t_debug            = null,
                    @t_file             = null,
                    @t_from             = @w_sp_name,
                    @i_cuenta           = @w_cuenta,
                    @i_fecha            = @i_fecha,
                    @i_ofi              = 0,
                    @o_saldo_para_girar = @w_disponible_aho out,
                    @o_saldo_contable   = @w_saldo_contable out
                if @w_return <> 0
                begin
                    rollback tran
                    
                    select @w_graba = 'N'
                    select @w_error = @w_return

                    select @w_desc_error = mensaje
                    from cobis..cl_errores
                    where numero= @w_return

                    update cob_pagos..pg_cobro_debitos_servicio
                    set cd_procesar = 'N',
                        cd_estado = 'E',
                        cd_cod_error = @w_error,
                        cd_desc_error = @w_desc_error
                    where cd_fecha_arc  = @i_fecha
                    and cd_empresa      = @i_empresa 
                    and cd_sec_file     = @w_sec_file
                    and cd_estado       = 'I'  

                    goto FETCH_REGISTRO
                end
                 
                select @w_disponible_aho = floor(@w_disponible_aho * 100) / 100
				
				if @w_valor_pagado > 0 
				begin
					select @w_valor_debito = (@w_valor_rec + @w_comision)-@w_valor_pagado 
					select @w_val_deb_min  = @w_valor_pagado - (@w_valor_minimo + @w_comision)
				end
				else
				begin
					select @w_valor_debito = @w_valor_rec + @w_comision
					select @w_val_deb_min  = @w_valor_minimo + @w_comision
				end
				
                if @w_disponible_aho >= @w_valor_debito
                begin
                    if @w_valor_pagado > 0
					begin
						select @w_valor = @w_valor_rec - @w_valor_pagado
						select @w_base_imp = @w_base_imponible
					end
					else
					begin
						select @w_valor = @w_valor_rec
						select @w_base_imp = @w_base_imponible
						select @w_estado_p = 'P'
					end
                end
                else
                begin
                    if @w_disponible_aho > @w_val_deb_min
                    begin
						if @w_valor_pagado > 0
						begin
							select @w_valor = @w_val_deb_min - @w_valor_pagado
							select @w_base_imp = @w_disponible_aho - @w_val_deb_min
						end
						else
						begin
							select @w_total = @w_disponible_aho - @w_val_deb_min
							select @w_valor = @w_total + @w_valor_minimo
							select @w_base_imp = @w_total
						end
                    end
                    else
                    begin
                        if @w_disponible_aho = @w_val_deb_min
                        begin
							if @w_valor_pagado > 0
							begin
								select @w_valor = @w_valor_minimo - @w_valor_pagado
								select @w_base_imp = 0.00
							end
							else
							begin
								select @w_valor = @w_valor_minimo
								select @w_base_imp = 0.00
							end
                        end
                        else
                        begin
                            rollback tran
                            select @w_graba = 'N'

                            select @w_error = 41033
                            select @w_desc_error = mensaje
                            from cobis..cl_errores
                            where numero= @w_error 

                            update cob_pagos..pg_cobro_debitos_servicio
                            set cd_procesar = 'N',
                                cd_estado = 'E',
                                cd_cod_error = @w_error,
                                cd_desc_error = @w_desc_error
                            where cd_fecha_arc = @i_fecha
                            and cd_empresa = @i_empresa  
                            and cd_sec_file = @w_sec_file
                            and cd_estado = 'I' 

                            goto FETCH_REGISTRO 
                        end
                    end
                end
            end
            else
            begin
                select @w_valor = @w_valor_rec
                select @w_base_imp = @w_base_imponible
            end
            --Ref008 Fin
        
            exec @w_return = cob_ahorros..sp_ahndc_automatica
                 @s_srv              = @s_srv,
                 @s_ofi              = @s_ofi,
                 @s_ssn              = @s_ssn,
                 @s_user             = @s_user,
                 @s_term             = @s_term,
                 @t_trn              = @w_trn,
                 @i_cta              = @w_num_cta,
                 @i_val              = @w_valor , --Ref008 @w_valor_rec,
                 @i_cau              = @w_causa_deb,
                 @i_mon              = 1,
                 @i_con_tran         = 'N',
                 @i_ref              = @w_contrato,
                 @i_tarjeta          = @w_contrato,
                 @i_fecha            = @w_fecha_pro ,
                 @i_aplcobis         = 'N',
                 @o_ssn_monet        = @w_ssn_monet out

                if @w_return <> 0
                begin
                  rollback tran
                  select @w_graba = 'N'
                  select @w_error = @w_return
                  
                  select @w_desc_error = mensaje
                  from cobis..cl_errores
                  where numero= @w_return
                  
                  update cob_pagos..pg_cobro_debitos_servicio
                  set cd_procesar = 'N',
                      cd_estado = 'E',
                      cd_cod_error = @w_error,
                      cd_desc_error = @w_desc_error
                  where cd_fecha_arc = @i_fecha
                  and cd_empresa = @i_empresa --REF 4
                  and cd_sec_file = @w_sec_file
                  and cd_estado = 'I'  --REF 4
                
                  goto FETCH_REGISTRO --REF 4
                 end

                 
          end
        
        --Ref006:msilvag Inicio
        if @w_comision > 0
        begin
            if @w_tipo_cta = '04'
            begin
                exec @w_return = cob_ahorros..sp_ahndc_automatica
                     @s_srv              = @s_srv,
                     @s_ofi              = @s_ofi,
                     @s_ssn              = @s_ssn,
                     @s_user             = @s_user,
                     @s_term             = @s_term,
                     @t_trn              = 4272,
                     @i_cta              = @w_num_cta,
                     @i_val              = @w_comision,
                     @i_cau              = @w_causal_com_aho,
                     @i_mon              = 1,
                     @i_con_tran         = 'N',
                     @i_ref              = @w_contrato,
                     @i_tarjeta          = @w_contrato,
                     @i_fecha            = @w_fecha_pro ,
                     @i_aplcobis         = 'N',
                     @o_ssn_monet        = @w_ssn_monet1 out
                if @w_return <> 0
                begin
                    rollback tran

                    select @w_graba = 'N'
                    select @w_error = @w_return

                    select @w_desc_error = mensaje
                    from cobis..cl_errores
                    where numero= @w_return

                    update cob_pagos..pg_cobro_debitos_servicio
                    set cd_procesar = 'N',
                        cd_estado = 'E',
                        cd_cod_error = @w_error,
                        cd_desc_error = @w_desc_error
                    where cd_fecha_arc = @i_fecha
                    and cd_empresa = @i_empresa 
                    and cd_sec_file = @w_sec_file
                    and cd_estado = 'I'
                    --Ref007:comento control de error
                    /*if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                            @i_num= 033028

                        close proc_nd_claro
                        deallocate cursor proc_nd_claro
                        return 033028
                    end*/
                  
                    goto FETCH_REGISTRO 
                 
                end
            end --@w_tipo_cta = '04'
            else
            begin
                if @w_tipo_cta = '03'
                begin
                    --Debito automático comisión
                    exec @w_return = cob_cuentas..sp_ccndc_automatica
                         @s_srv              = @s_srv,
                         @s_ofi              = @s_ofi,
                         @s_ssn              = @s_ssn,
                         @s_user             = @s_user,
                         @s_term             = @s_term,
                         @t_trn              = 3050 ,
                         @i_cta              = @w_num_cta,
                         @i_val              = @w_comision,
                         @i_cau              = @w_causal_com_cte,
                         @i_mon              = 1,
                         @i_con_tran         = 'N',
                         @i_ref              = @w_contrato,
                         @i_detalle          = @w_contrato,
                         @i_fecha            = @w_fecha_pro ,
                         @i_aplcobis         = 'N',
                         @o_ssn_monet        = @w_ssn_monet1 out
                    if @w_return != 0
                    begin
                        rollback tran
                        select @w_graba = 'N'
                        select @w_error = @w_return
                        
                        select @w_desc_error = mensaje
                        from cobis..cl_errores
                        where numero= @w_return
                        
                        update cob_pagos..pg_cobro_debitos_servicio
                        set cd_procesar = 'N',
                          cd_estado = 'E',
                          cd_cod_error = @w_error,
                          cd_desc_error = @w_desc_error
                        where cd_fecha_arc = @i_fecha
                        and cd_empresa = @i_empresa 
                        and cd_sec_file = @w_sec_file
                        and cd_estado = 'I'  
                        --Ref007:comento control de error
                        /*if @@error <> 0
                        begin
                            exec cobis..sp_cerror
                                @i_num= 033028

                            close proc_nd_claro
                            deallocate cursor proc_nd_claro
                            return 033028
                        end*/
                    
                        goto FETCH_REGISTRO 
                    end
             
                end --@w_tipo_cta = '03'

            end 
          
            if @w_base_imp2 > 0
            begin

                exec @w_return = cob_cuentas..sp_cont_impuesto
                   @t_trn       = 3497 ,
                   @s_ssn       = @w_ssn_monet,
                   @s_date      = @w_fecha_pro,
                   @t_corr      = 'N',
                   @t_ssn_corr  = null,
                   @s_user      = @s_user,
                   @s_term      = @s_term,
                   @s_ofi       = @s_ofi,
                   @t_rty       = '' ,
                   @s_org       = 'U' ,
                   @i_base_imp  = @w_base_imp2,
                   @i_iva       = @w_impuesto2,
                   @i_total     = @w_comision,
                   @i_cau       = @w_servicio,
                   @i_cta       = @w_contrato, 
                   @i_mon       = 1 ,   
                   @i_oficina_cta= @s_ofi,
                   @i_ubi       = 0 ,
                   @i_canal     = 'DIR'
                if @w_return != 0
                begin
                    rollback tran
                    select @w_graba = 'N'
                    select @w_error = @w_return

                    select @w_desc_error = mensaje
                    from cobis..cl_errores
                    where numero= @w_return

                    update cob_pagos..pg_cobro_debitos_servicio
                    set cd_procesar = 'N',
                      cd_estado = 'E',
                      cd_cod_error = @w_error,
                      cd_desc_error = @w_desc_error
                    where cd_fecha_arc = @i_fecha
                    and cd_empresa = @i_empresa 
                    and cd_sec_file = @w_sec_file
                    and cd_estado = 'I'  
                    --Ref007:comento control de error
                    /*if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                            @i_num= 033028

                        close proc_nd_claro
                        deallocate cursor proc_nd_claro
                        return 033028
                    end*/
                    
                    goto FETCH_REGISTRO 
                end

            end --fin if @w_base_imp > 0
                
        end      --if @w_comision > 0
        --Ref006:msilvag Fin
        
        
     /*  --Obtengo Secuencial de Tran_servicio
       execute @w_return = cob_cuentas..sp_gen_sec2
       @o_ssn = @s_ssn out

       if @w_return = 0  --REF 4
       begin
          rollback tran
          update cob_pagos..pg_cobro_debitos_servicio
          set cd_procesar = 'N',
              cd_estado = 'E',
              cd_cod_error = 11111,
              cd_desc_error = 'NO GENERO SECUENCIAL DE TRAN SERVICIO'
          where cd_fecha_arc = @i_fecha
          and cd_empresa = @i_empresa
          and cd_sec_file = @w_sec_file
          and cd_estado = 'I'
          goto FETCH_REGISTRO
        end*/

        if @w_param != 'S' --Ref008
        begin
          if @w_base_imp = 0
              select @w_base_imp = @w_valor_rec
        end --Ref008


      select @w_notaVenta = @w_tipo_doc+@w_notaVenta

      if @w_graba = 'S'
      begin
            ---INSERTANDO LA TRAN SERVICIO PARA QUE GENERE LA LINEA DE CREDITO
            insert into cob_cuentas..cc_tran_servicio
            (ts_secuencial  ,ts_tipo_transaccion  ,ts_oficina       ,ts_usuario       ,ts_rol         ,ts_terminal      ,
            ts_origen       ,ts_nodo              ,ts_tsfecha       ,ts_clase         ,ts_referencia  ,ts_correccion    ,
            ts_cta_banco    ,ts_moneda            ,ts_tipo          ,ts_monto         ,ts_ocasional   ,ts_autoriz_anula ,
            ts_contratado   ,ts_aporte_iess       ,ts_descuento_iess,ts_hora          ,ts_causa       ,ts_tipo_contable ,
            ts_nombre       ,ts_fonres_iess       ,ts_campo_alt_uno ,ts_campo_alt_dos ,ts_fecha       ,ts_endoso        ,ts_tipo_chequera ,
            ts_autoriz_aut, ts_default)--Ref006:msilvag --REF 10
            values
            (@w_ssn_monet   ,3427                 ,@s_ofi           ,@s_user          ,52               ,@s_term        ,
            'L'             ,'BOLIVSRV'           ,@w_fecha_pro     ,'F'              ,@w_contrato      ,'N'            ,
            @w_num_cta      ,1                    ,'L'              ,@w_valor         ,null             ,@w_base_imp    ,  --Ref008 @w_valor_rec,
            0   			,0                    ,null             ,getdate()        ,@i_empresa       ,@w_tipo_cta    ,
            @w_nombre       ,0                    ,@w_notaVenta     ,@w_identificacion,@w_fecha_pro     ,@w_sec_file    ,'DBA' ,
            convert(varchar,isnull(@w_comision, 0.00)),@i_intento) --Ref006:msilvag --REF 10

            if @@error != 0 --REF 4
            begin
              rollback tran
              select @w_graba = 'N' --Ref05 MLR
              update cob_pagos..pg_cobro_debitos_servicio
              set cd_procesar = 'N',
                  cd_estado = 'E',
                  cd_cod_error = 11111,
                  cd_desc_error = 'ERROR EN INSERCION DE TRAN SERVICIO'
              where cd_fecha_arc = @i_fecha
              and cd_empresa = @i_empresa --REF 4
              and cd_sec_file = @w_sec_file
              and cd_estado = 'I'
              
              goto FETCH_REGISTRO --REF 4
            end
            -->Ref05 MLR 
            --se comenta porque se valida el ingreso de la Retención
            /*else
            begin
              --agrego un indicador que finaliza el debito
              update cob_pagos..pg_cobro_debitos_servicio
              set cd_estado = 'F',  --FINALIZADO
                  cd_procesar = 'S',
                  cd_ejecutado = 'S'
              where cd_fecha_arc = @i_fecha
              and cd_empresa = @i_empresa --REF 4
              and cd_sec_file = @w_sec_file
              and cd_estado = 'I'
           end*/ 
           
           -- Se valida el registro de la retención
           if @w_graba = 'S' --and @w_cont_especial != ''
           begin
               -- Registro de la información relacionada a la retención IVA Biens y Servicios
                 exec @w_return = cob_pagos..sp_ins_retiva_bieserv 
                        @s_ssn           = @w_ssn_monet,
                        @s_srv           = @s_srv,
                        @s_user          = @s_user,
                        @s_term          = @s_term,
                        @s_date          = @w_fecha_pro, --ref12
                        @s_ofi           = @s_ofi,
                        @t_debug         = @t_debug,
                        @t_file          = @t_file,
                        @t_trn           = 3427,--@t_trn,
                        @t_corr          = 'N',
                        @i_clase         = 'F',
                        @i_cod_alterno   = 0, --Se registra el default
                        @i_cod_cliente   = @i_empresa,
                        --@i_cont_especial = null,--@w_cont_especial,
                        @i_valor_trx     = @w_valor , --Ref009:msilvag @w_valor_rec,
                        @i_base_iva0     = @w_baseimp0,
                        @i_base_iva12    = @w_baseimp12,
                        @i_iva_bienes    = @w_ivabienes,
                        @i_iva_servicio  = @w_ivaservicios,
                        @i_exon_ivabie   = @w_exo_ivabienes,
                        @i_exon_ivaser   = @w_exo_ivaservicios
              
                  if @w_return != 0
                   begin
                      rollback tran
                      select @w_graba = 'N'
                      select @w_error = @w_return
                      select @w_desc_error = mensaje
                        from cobis..cl_errores
                       where numero= @w_return
                      update cob_pagos..pg_cobro_debitos_servicio
                      set cd_procesar = 'N',
                          cd_estado = 'E',
                          cd_cod_error = @w_error,
                          cd_desc_error = @w_desc_error
                      where cd_fecha_arc = @i_fecha
                      and cd_empresa = @i_empresa 
                      and cd_sec_file = @w_sec_file
                      and cd_estado = 'I'
                      
                      goto FETCH_REGISTRO
                  end
           end
           --
           
           if @w_graba = 'S'
           begin
             --agrego un indicador que finaliza el debito
             update cob_pagos..pg_cobro_debitos_servicio
             set cd_estado    = @w_estado_p,
                 cd_procesar  = 'S',
                 cd_ejecutado = 'S' ,
                 cd_comision  = isnull(@w_comision,0),  --Ref006:msilvag 
                 cd_valor_pagado = @w_valor             --Ref009:msilvag 
             where cd_fecha_arc = @i_fecha
             and cd_empresa = @i_empresa --REF 4
             and cd_sec_file = @w_sec_file
             and cd_estado = 'I'
             
           end
           --<-- Fin Ref05
		   
		   --Ref13
		   if @w_graba = 'S'
		   begin
				exec  @w_return = cob_pagos..sp_consulta_celular
					@i_cliente = @v_cliente,
					@o_celular = @s_celular out,
					@o_correo  = @s_correo  out
					  
				if @w_return <> 0
					begin
						if @@trancount > 0
							begin
							rollback 
							return @w_return
						end
					end
				  
				declare @i_tipo_cta int		
				
				select @i_tipo_cta = convert(int,@w_tipo_cta)
				
				PRINT '=========	PARAM SP_EVENTOS	========='
				PRINT 'i_operacion = I ' 
				PRINT 'i_fecha 1 = %1!', @i_fecha
				PRINT 'i_cliente 1 = %1!', @v_cliente
				PRINT 'i_canal = DBA ' 
				PRINT 'i_servicio = DAPSB ' 
				PRINT 'i_producto 1 = %1!', @i_tipo_cta
				PRINT 'i_prod_deb 1 = %1!', @w_tipo_cta
				PRINT 'i_cuenta 1 = %1!', @w_num_cta
				PRINT 'i_valor 1 = %1!', @w_valor
				PRINT 'i_empresa 1 = %1!', @i_empresa
				PRINT 'i_desc_canal = AUTOMATICO '
				PRINT 'i_cta 1 = %1!', @w_num_cta
				PRINT 'i_nombre 1 = %1!', @v_nombcta
				PRINT 'i_planilla 1 = %1!', @w_identificacion
				PRINT 'i_mail 1 = %1!', @s_correo
				PRINT '=========	PARAM SP_EVENTOS	========='
				
			  exec cob_internet..sp_eventos
				 @i_operacion 	=  'I'
				,@i_fecha       = 	@i_fecha
				,@i_cliente 	= 	@v_cliente --@w_nombre
				,@i_canal 		= 	'DBA'
				,@i_servicio	=	'DAPSB'
				,@i_producto	=	@i_tipo_cta	
				,@i_prod_deb    = 	@w_tipo_cta				
				,@i_cuenta		=	@w_num_cta 				
				,@i_valor		=	@w_valor
				,@i_empresa		=	@i_empresa
				,@i_desc_canal 	=	'AUTOMATICO' 
				,@i_cta			=	@w_num_cta				
				,@i_nombre		=	@v_nombcta
				,@i_planilla 	=	@w_identificacion,
				,@i_desc_servicio= 'Pago de Servicio ',				
				,@i_mail		=	@s_correo
				
			end
			-- Fin Ref13
      end
  commit tran

  FETCH_REGISTRO:  --REF 4 /* Localizar el siguiente registro */
  fetch proc_nd_claro
  into  @w_sec_file,
        @w_tipo_cta,
        @w_num_cta,
        @w_valor_rec,
        @w_contrato,
        @w_identificacion,
        @w_nombre,
        @w_notaVenta ,
        @w_base_imponible  , --Ref008 @w_base_imp,
        @w_estado,
        @w_tipo_doc,
        -->Ref05 MLR ini
        --@w_cont_especial,
        @w_baseimp0,
        @w_baseimp12,
        @w_ivabienes,
        @w_ivaservicios,
        @w_exo_ivabienes,
        @w_exo_ivaservicios,
        --<--Ref05 fin
        @w_valor_minimo  --Ref008
        
  end --sqlstatus

  close proc_nd_claro
  deallocate cursor proc_nd_claro

end

return 0

go

if exists(select 1 from sysobjects where name='sp_cobr_deb_claro' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_cobr_deb_claro *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_cobr_deb_claro -- ERROR -- >>>'
go

