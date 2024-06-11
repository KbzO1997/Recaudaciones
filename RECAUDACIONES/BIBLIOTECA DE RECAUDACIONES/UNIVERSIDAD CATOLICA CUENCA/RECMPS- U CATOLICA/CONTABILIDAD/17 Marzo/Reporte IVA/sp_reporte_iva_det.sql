use cob_cuentas
go

if exists (select 1 from sysobjects where name = 'sp_reporte_iva_det')
   drop proc sp_reporte_iva_det
go

create procedure sp_reporte_iva_det

(

   @i_fecha_proceso                varchar(10)



)



as



declare

   @w_return               int,

   @w_sp_name              varchar(30),

   @w_msg_error            varchar(100),

   @w_tc_tipo_tran         int,

   @w_tc_causa_org         varchar(12),

   @w_dp_cuenta            varchar(12),

   @w_perfil               varchar(12),

   @w_producto             int,

   @w_cta_iva              varchar(20),

   @w_cta_puente           varchar(20),

   @w_debcred              char(1),

   @w_nme_puente           varchar(32),

   @w_nme_iva              varchar(32),

   @w_nme_ing           varchar(32)



select @w_sp_name = 'sp_reporte_iva_det'



truncate table db_general..cc_cuenta_tran1



--Ref10 creat tabla temporal catalgo

create table #tmp_ctas_contables

(codigo int,

 cta varchar(20))



--Ref10 extraer las cuentas contables

insert into #tmp_ctas_contables(codigo,cta)

select convert(int,b.codigo),ltrim(rtrim(valor)) cta from cobis..cl_tabla a,cobis..cl_catalogo b

where a.tabla= 'cc_cta_cont_iva'

and a.codigo=b.tabla

and estado ='V'



if @@error <> 0

   begin

      exec cobis..sp_cerror

           @t_debug  = 'N',

           @t_file   = null,

           @t_from   = @w_sp_name,

           @i_num    = 035000,

           @i_msg    = 'ERROR AL INSERTAR EN TABLA temporal #tmp_ctas_contables'

      return 1

   end



select distinct tc_tipo_tran,tc_causa_org,tc_contabiliza,dp_cuenta,tc_perfil,dp_producto,dp_debcred

into #cta_trx_iva1

from cob_remesas..re_tran_contable,cob_conta..cb_det_perfil, cob_conta..cb_perfil,#tmp_ctas_contables  --Ref10 agrega tabla temproal de catalgo

where tc_estado         = 'V'

and dp_empresa   = 1

  and dp_producto  in (3,4,16)

  and dp_perfil    = tc_perfil

  and pe_empresa   = dp_empresa

  and pe_producto  = dp_producto

  and pe_perfil    = dp_perfil

  and dp_codval    = convert(int,tc_causa_dst)


  and dp_cuenta like cta +'%'   --Ref10  campo ctas  contables

  and codigo in (1,2,3,4)	  --Ref10 solo las cuentas del 1 al nivel 4




declare cursor_tran cursor

for

select

  tc_tipo_tran,

  tc_causa_org,

  dp_cuenta,

  tc_perfil,

  dp_producto,

  dp_debcred,

  tc_contabiliza

from #cta_trx_iva1



open cursor_tran

fetch cursor_tran into

@w_tc_tipo_tran,

@w_tc_causa_org ,

@w_dp_cuenta,

@w_perfil,

@w_producto,

@w_debcred,

@w_nme_ing

while (@@sqlstatus <> 2)

begin  /*Control de error de lectura del cursor */



 if @@sqlstatus = 1

    begin



      exec cobis..sp_cerror

           @t_debug     = 'N',

           @t_file      = null,

           @t_from      = @w_sp_name,

           @i_num       = 031152

      close cursor_tran

      deallocate cursor cursor_tran

      return 031151

    end



       ---busca cuenta iva---



         select @w_cta_iva = dp_cuenta,@w_nme_iva = tc_contabiliza

	   from cob_remesas..re_tran_contable,cob_conta..cb_det_perfil, cob_conta..cb_perfil,#tmp_ctas_contables  --Ref10 agrega tabla temproal de catalgo

	   where tc_estado         = 'V'

	   and dp_empresa     = 1

	     and dp_producto  = @w_producto

	     and dp_perfil    = tc_perfil

	     and pe_empresa   = dp_empresa

	     and pe_producto  = dp_producto

	     and pe_perfil    = dp_perfil

	     and dp_codval    = convert(int,tc_causa_dst)

	     and tc_perfil = @w_perfil

	     and tc_tipo_tran = @w_tc_tipo_tran

	     and (tc_causa_org = '0')

	     and dp_cuenta  like  cta +'%'--"25909005%"  --"25040515%"  --Ref10 campo ctas  contables

             and codigo in (5)	  					  --Ref10 actualmente el codigo 6 es la cta contble "25909005%"



	  if @@rowcount = 0

	   begin

	      select @w_cta_iva = dp_cuenta,@w_nme_iva = tc_contabiliza

	     	   from cob_remesas..re_tran_contable,cob_conta..cb_det_perfil, cob_conta..cb_perfil,#tmp_ctas_contables  --Ref10 agrega tabla temproal de catalgo

	     	   where tc_estado         = 'V'

	     	   and dp_empresa     = 1

	     	     and dp_producto  = @w_producto

	     	     and dp_perfil    = tc_perfil

	     	     and pe_empresa   = dp_empresa

	     	     and pe_producto  = dp_producto

	     	     and pe_perfil    = dp_perfil

	     	     and dp_codval    = convert(int,tc_causa_dst)

	     	     and tc_perfil    = @w_perfil

	     	     and tc_tipo_tran = @w_tc_tipo_tran

	     	     and (tc_causa_org = '0')

	             and dp_cuenta  like cta +'%'  --"25040515%"    --Ref10 campo ctas  contables

	             and codigo in (6)	     	     			--Ref10 actualmente el codigo 6 es la cta contble "25040515%"



	           if @@rowcount = 0     --Ref3 smerino

	              select @w_cta_iva ='',@w_nme_iva = ''



	      end



	   ---busca cuenta puente----



	  select @w_cta_puente = dp_cuenta,@w_nme_puente = tc_contabiliza

	   from cob_remesas..re_tran_contable,cob_conta..cb_det_perfil c, cob_conta..cb_perfil

	   where tc_estado         = 'V'

	   and dp_empresa     = 1

	     and dp_producto  = @w_producto

	     and dp_perfil    = tc_perfil

	     and pe_empresa   = dp_empresa

	     and pe_producto  = dp_producto

	     and pe_perfil    = dp_perfil

	     and dp_codval    = convert(int,tc_causa_dst)

	     --and dp_cuenta not like '5490%'

	     and tc_perfil = @w_perfil

	     and tc_tipo_tran = @w_tc_tipo_tran

	     and (tc_causa_org = '0')

	    -- and dp_cuenta  not  like "25909005%"

             --and dp_cuenta  not  like "299090150522"

 	    and not exists (select 1 from #tmp_ctas_contables where codigo in (3,5,6,7) and c.dp_cuenta like cta + '%'  ) --Ref10 agrega tabla temproal de catalgo



          if @@rowcount = 0

	   begin

	    select @w_cta_puente = dp_cuenta,@w_nme_puente = tc_contabiliza

	     from cob_remesas..re_tran_contable,cob_conta..cb_det_perfil c, cob_conta..cb_perfil

	     where tc_estado         = 'V'

	     and dp_empresa     = 1

	       and dp_producto  = @w_producto

	       and dp_perfil    = tc_perfil

	       and pe_empresa   = dp_empresa

	       and pe_producto  = dp_producto

	       and pe_perfil    = dp_perfil

	       and dp_codval    = convert(int,tc_causa_dst)

	       --and dp_cuenta not like '5490%'

	       and tc_perfil = @w_perfil

	       and tc_tipo_tran = @w_tc_tipo_tran

	       and (tc_causa_org = '0')

	       --and dp_cuenta  not  like "25909005%"

 	       and not exists (select 1 from #tmp_ctas_contables where codigo in (3,5,7) and c.dp_cuenta like cta +'%'  ) --Ref10 agrega tabla temproal de catalgo



	        if @@rowcount = 0     --Ref3 smerino

	               select @w_cta_puente = '',@w_nme_puente = ''



	    end



	   insert into db_general..cc_cuenta_tran1 (cc_tipo_tran,cc_causa_org,cc_dp_cuenta,cc_nme_ing,cc_cta_iva,cc_nme_iva,cc_cta_puente,cc_nme_puente,cc_debcred,cc_producto)

	    values (@w_tc_tipo_tran,@w_tc_causa_org,@w_dp_cuenta,@w_nme_ing,@w_cta_iva,@w_nme_iva,@w_cta_puente,@w_nme_puente,@w_debcred,@w_producto)





	       if @@error <> 0

		begin

		 exec cobis..sp_cerror

		      @t_debug  = 'N',

		      @t_file   = null,

		      @t_from   = @w_sp_name,

		      @i_num    = 035000,

		      @i_msg    = 'ERROR AL INSERTAR EN TABLA DE db_general..cc_cuenta_tran1'



		 return 1

		end







SIGUE:

fetch cursor_tran into

@w_tc_tipo_tran,

@w_tc_causa_org ,

@w_dp_cuenta,

@w_perfil,

@w_producto,

@w_debcred,

@w_nme_ing

end



close cursor_tran

deallocate cursor cursor_tran



---cierra cursor

--print 'aqui2'

----insertar trx----

truncate table  db_general..cc_tmp_trx_iva



--inserta los datos del reporte  de las trx del iva--



insert into db_general..cc_tmp_trx_iva(cc_oficina,cc_des_ofic,cc_fecha_proceso,cc_fecha_real,cc_transaccion,cc_desc_trx,				--Ref06 pholguiv Colocar los campos para el insert

				 cc_cuasa,cc_des_causa,cc_cta_cliente,cc_tip_cta,cc_usuario,cc_val_com,cc_val_iva,cc_total,

				 cc_cta_ing,cc_cta_iva,cc_cta_puente,cc_moneda,cc_signo,cc_debcred,cc_oficina_cta,cc_secuencial,cc_cod_alterno,

                 cc_comp_iva,cc_oficina_adic,cc_cta_adic , cc_tipcta_comision, cc_cta_comision) --Ref007:msilvag



select ts_oficina ,

of_nombre,

ts_tsfecha ,

ts_hora ,

ts_tipo_transaccion ,

tn_descripcion,

ts_causa ,

(select  isnull(d.valor,'')

      from cobis..cl_tabla c,

	   cobis..cl_catalogo d

      where c.tabla = (select tc_tabla

			from cob_cuentas..cc_causas_cat

			where tc_transaccion=a.ts_tipo_transaccion)

      and c.codigo = d.tabla

      and d.codigo = a.ts_causa) , --c.descripcion,  --descripcion de causa saca de la tabla del catalogo

ts_cta_banco ,

ts_tipocta ,

ts_usuario ,

case cc_nme_ing

WHEN 'SLD'   then isnull(ts_saldo,0)

WHEN 'VTR'   then isnull(ts_valor,0)

WHEN 'MNT'   then isnull(ts_monto,0)

WHEN 'SCO'   then isnull(ts_contratado,0)

WHEN 'SOC'   then isnull(ts_ocasional,0)

WHEN 'AIE'   then isnull(ts_aporte_iess,0)

WHEN 'DIE'   then isnull(ts_descuento_iess,0)

WHEN 'FIE'   then isnull(ts_fonres_iess,0)

WHEN 'OIN'   then isnull(ts_valor,0) + isnull(ts_saldo,0)

WHEN 'SSI'   then isnull(ts_saldo,0) - isnull(ts_valor,0)

WHEN 'MTM'   then isnull(ts_contratado,0) + isnull(ts_monto,0)

WHEN 'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN 'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)

WHEN 'SER'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0)

WHEN 'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0)

WHEN 'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN 'SVV'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) - isnull(ts_fonres_iess,0)

end,

case cc_nme_iva

WHEN 'SLD'   then isnull(ts_saldo,0)

WHEN 'VTR'   then isnull(ts_valor,0)

WHEN 'MNT'   then isnull(ts_monto,0)

WHEN 'SCO'   then isnull(ts_contratado,0)

WHEN 'SOC'   then isnull(ts_ocasional,0)

WHEN 'AIE'   then isnull(ts_aporte_iess,0)

WHEN 'DIE'   then isnull(ts_descuento_iess,0)

WHEN 'FIE'   then isnull(ts_fonres_iess,0)

WHEN 'OIN'   then isnull(ts_valor,0) + isnull(ts_saldo,0)

WHEN 'SSI'   then isnull(ts_saldo,0) - isnull(ts_valor,0)

WHEN 'MTM'   then isnull(ts_contratado,0) + isnull(ts_monto,0)

WHEN 'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN 'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)

WHEN 'SER'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0)

WHEN 'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0)

WHEN 'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN 'SVV'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) - isnull(ts_fonres_iess,0)

end,

case cc_nme_puente

WHEN 'SLD'   then isnull(ts_saldo,0)

WHEN 'VTR'   then isnull(ts_valor,0)

WHEN 'MNT'   then isnull(ts_monto,0)

WHEN 'SCO'   then isnull(ts_contratado,0)

WHEN 'SOC'   then isnull(ts_ocasional,0)

WHEN 'AIE'   then isnull(ts_aporte_iess,0)

WHEN 'DIE'   then isnull(ts_descuento_iess,0)

WHEN 'FIE'   then isnull(ts_fonres_iess,0)

WHEN 'OIN'   then isnull(ts_valor,0) + isnull(ts_saldo,0)

WHEN 'SSI'   then isnull(ts_saldo,0) - isnull(ts_valor,0)

WHEN 'MTM'   then isnull(ts_contratado,0) + isnull(ts_monto,0)

WHEN 'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN 'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0)

WHEN 'SER'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) - isnull(ts_aporte_iess,0) + isnull(ts_descuento_iess,0)

WHEN 'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_ocasional,0)

WHEN 'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN 'SVV'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_contratado,0) + isnull(ts_descuento_iess,0) - isnull(ts_aporte_iess,0) - isnull(ts_fonres_iess,0)

end,

cc_dp_cuenta,

cc_cta_iva,

cc_cta_puente,

ts_moneda,

ts_correccion,

cc_debcred,

(select  convert(varchar,z.cc_oficina) + '-' + of_nombre

         from cob_cuentas..cc_ctacte z, cobis..cl_oficina

         where  cc_cta_banco= a.ts_cta_banco and of_oficina=cc_oficina),

ts_secuencial,

ts_cod_alterno,  --ref2 smerino

isnull(case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then isnull(ts_ocasional,0)

WHEN 'SLD'   then isnull(ts_ocasional,0)

WHEN 'VTR'   then isnull(ts_ocasional,0)

end,0),

case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then ts_oficina_pago

WHEN 'SLD'   then ts_oficina_pago

WHEN 'VTR'   then ts_oficina_pago

end,

case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then ts_cta_banco_dep

WHEN 'SLD'   then ts_cta_banco_dep

WHEN 'VTR'   then ts_cta_banco_dep

end,

--Ref007:msilvag Inicio

case when exists( select 1 from cc_tran_servicio inner join cc_ctacte on cc_cta_banco = ts_cta_banco where ts_secuencial = a.ts_secuencial and ts_tipo_transaccion in (3366,3372) and isnull(ts_monto, 0.00) != 0.00 ) --Ref008:msilvag

    then 'CTE'

     when exists( select 1 from cc_tran_servicio inner join cob_ahorros..ah_cuenta on ah_cta_banco = ts_cta_banco where ts_secuencial = a.ts_secuencial and ts_tipo_transaccion in (3366,3372) and isnull(ts_monto, 0.00) != 0.00 ) --Ref008:msilvag

    then 'AHO'

else ' ' end,

(select ts_cta_banco  from cc_tran_servicio where ts_secuencial = a.ts_secuencial and ts_tipo_transaccion in (3366,3372) and isnull(ts_monto, 0.00) != 0.00 and ts_usuario=a.ts_usuario)  --Ref09: agrega filtro usuario

--Ref007:msilvag Fin

from cob_cuentas..cc_tran_servicio a ,db_general..cc_cuenta_tran1 x,cobis..cl_oficina , cobis..cl_ttransaccion		--Ref05 pholguiv

where ts_tipo_transaccion=cc_tipo_tran

and isnull(ts_causa,'0') = case when cc_causa_org = '0' then isnull(ts_causa,'0') else cc_causa_org end --ref 2

and ts_oficina=of_oficina

and tn_trn_code=ts_tipo_transaccion

and ts_tsfecha='03/17/2021'

and ts_secuencial  in (33953753 )


union



select ts_oficina ,

of_nombre,

ts_tsfecha ,

ts_hora ,

ts_tipo_transaccion ,

tn_descripcion,

ts_causa ,

(select isnull(d.valor,'')

	      from cobis..cl_tabla c,

		   cobis..cl_catalogo d

	      where c.tabla = (select tc_tabla

				from cob_cuentas..cc_causas_cat

				where tc_transaccion=a.ts_tipo_transaccion)

	      and c.codigo = d.tabla

	      and d.codigo = a.ts_causa) , --c.descripcion,  --descripcion de causa saca de la tabla del catalogo

ts_cta_banco ,

ts_tipocta ,

ts_usuario ,

case cc_nme_ing

WHEN  'SLD'   then isnull(ts_saldo,0)

WHEN  'VTR'   then isnull(ts_valor,0)

WHEN  'OIN'   then isnull(ts_saldo,0) + isnull(ts_valor,0)

WHEN  'MNT'   then isnull(ts_monto,0)

WHEN  'INT'   then isnull(ts_interes,0)

WHEN  'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN  'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN  'SOC'   then isnull(ts_ocasional,0)

WHEN  'SCO'   then isnull(ts_interes,0)

WHEN  'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0) + isnull(ts_ocasional,0)

WHEN  'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0)

end ,

case cc_nme_iva

WHEN  'SLD'   then isnull(ts_saldo,0)

WHEN  'VTR'   then isnull(ts_valor,0)

WHEN  'OIN'   then isnull(ts_saldo,0) + isnull(ts_valor,0)

WHEN  'MNT'   then isnull(ts_monto,0)

WHEN  'INT'   then isnull(ts_interes,0)

WHEN  'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN  'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN  'SOC'   then isnull(ts_ocasional,0)

WHEN  'SCO'   then isnull(ts_interes,0)

WHEN  'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0) + isnull(ts_ocasional,0)

WHEN  'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0)

end,

case cc_nme_puente

WHEN  'SLD'   then isnull(ts_saldo,0)

WHEN  'VTR'   then isnull(ts_valor,0)

WHEN  'OIN'   then isnull(ts_saldo,0) + isnull(ts_valor,0)

WHEN  'MNT'   then isnull(ts_monto,0)

WHEN  'INT'   then isnull(ts_interes,0)

WHEN  'SMM'   then isnull(ts_saldo,0) + isnull(ts_monto,0)

WHEN  'VMM'   then isnull(ts_valor,0) + isnull(ts_monto,0)

WHEN  'SOC'   then isnull(ts_ocasional,0)

WHEN  'SCO'   then isnull(ts_interes,0)

WHEN  'AFB'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0) + isnull(ts_ocasional,0)

WHEN  'ADU'   then isnull(ts_saldo,0) + isnull(ts_monto,0) + isnull(ts_valor,0) + isnull(ts_interes,0)

end,

cc_dp_cuenta,

cc_cta_iva,

cc_cta_puente,

ts_moneda,

ts_correccion,

cc_debcred,

(select   convert(varchar,z.ah_oficina) + '-' + of_nombre

         from cob_ahorros..ah_cuenta z,cobis..cl_oficina

         where  ah_cta_banco= a.ts_cta_banco and of_oficina=ah_oficina),

ts_secuencial,

ts_cod_alterno, --ref2 smerino

isnull(case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then isnull(ts_ocasional,0)

WHEN 'SLD'   then isnull(ts_ocasional,0)

WHEN 'VTR'   then isnull(ts_ocasional,0)

end,0),

case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then ts_oficina_pago

WHEN 'SLD'   then ts_oficina_pago

WHEN 'VTR'   then ts_oficina_pago

end,

case cc_nme_iva --Ref06 pholguiv

WHEN 'OIN'   then ts_cta_banco_dep

WHEN 'SLD'   then ts_cta_banco_dep

WHEN 'VTR'   then ts_cta_banco_dep

end,

--Ref007:msilvag Inicio

'' ,

''

--Ref007:msilvag Fin

from cob_ahorros..ah_tran_servicio a ,db_general..cc_cuenta_tran1 x,cobis..cl_oficina , cobis..cl_ttransaccion  --Ref05 pholguiv

where ts_tipo_transaccion=cc_tipo_tran and isnull(ts_causa,'0') = case when cc_causa_org = '0' then isnull(ts_causa,'0') else cc_causa_org end	 --ref 2

and ts_oficina=of_oficina

and tn_trn_code=ts_tipo_transaccion

and ts_tsfecha='02/26/2021'

and 1=2



union



select tm_oficina ,

of_nombre,

tm_fecha ,

tm_hora ,

tm_tipo_tran ,

tn_descripcion,

tm_causa ,

(select isnull(d.valor,'')

	      from cobis..cl_tabla c,

		   cobis..cl_catalogo d

	      where c.tabla = (select tc_tabla

				from cob_cuentas..cc_causas_cat

				where tc_transaccion=a.tm_tipo_tran)

	      and c.codigo = d.tabla

	      and d.codigo = a.tm_causa) , --c.descripcion,  --descripcion de causa saca de la tabla del catalogo

tm_cta_banco ,

'CTE' ,

tm_usuario ,

case cc_nme_ing

WHEN  'VTR'    then isnull(tm_valor,0)

WHEN  'VCH'    then isnull(tm_chq_locales,0)

WHEN  'COM'    then isnull(tm_valor_comision,0)

WHEN  'INT'    then isnull(tm_valor_interes,0)

WHEN  'TDE'    then isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'    then isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'    then isnull(tm_valor,0) - isnull(tm_valor_interes,0)

WHEN  'CCO'    then isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'    then isnull(tm_efectivo,0)

WHEN  'SAC'    then isnull(tm_saldo_contable,0)

WHEN  'SAD'    then isnull(tm_saldo_disponible,0)

WHEN  'L24'    then isnull(tm_l24h,0)

WHEN  'REM'    then isnull(tm_remesas,0)

WHEN  'SCO'    then isnull(tm_contratado,0)

WHEN  'SOC'    then isnull(tm_ocasional,0)

WHEN  'IMP'    then isnull(tm_valor_impuesto,0)

WHEN  'ISO'    then isnull(tm_valor_solca,0)

WHEN  'VSI'    then isnull(tm_valor,0) - isnull(tm_valor_impuesto,0)

WHEN  'CAP'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'    then isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

WHEN  'CAI'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0) + isnull(tm_efectivo,0)

end,

case cc_nme_iva

WHEN  'VTR'    then isnull(tm_valor,0)

WHEN  'VCH'    then isnull(tm_chq_locales,0)

WHEN  'COM'    then isnull(tm_valor_comision,0)

WHEN  'INT'    then isnull(tm_valor_interes,0)

WHEN  'TDE'    then isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'    then isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'    then isnull(tm_valor,0) - isnull(tm_valor_interes,0)

WHEN  'CCO'    then isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'    then isnull(tm_efectivo,0)

WHEN  'SAC'    then isnull(tm_saldo_contable,0)

WHEN  'SAD'    then isnull(tm_saldo_disponible,0)

WHEN  'L24'    then isnull(tm_l24h,0)

WHEN  'REM'    then isnull(tm_remesas,0)

WHEN  'SCO'    then isnull(tm_contratado,0)

WHEN  'SOC'    then isnull(tm_ocasional,0)

WHEN  'IMP'    then isnull(tm_valor_impuesto,0)

WHEN  'ISO'    then isnull(tm_valor_solca,0)

WHEN  'VSI'    then isnull(tm_valor,0) - isnull(tm_valor_impuesto,0)

WHEN  'CAP'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'    then isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

WHEN  'CAI'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0) + isnull(tm_efectivo,0)

end,

case cc_nme_puente

WHEN  'VTR'    then isnull(tm_valor,0)

WHEN  'VCH'    then isnull(tm_chq_locales,0)

WHEN  'COM'    then isnull(tm_valor_comision,0)

WHEN  'INT'    then isnull(tm_valor_interes,0)

WHEN  'TDE'    then isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'    then isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'    then isnull(tm_valor,0) - isnull(tm_valor_interes,0)

WHEN  'CCO'    then isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'    then isnull(tm_efectivo,0)

WHEN  'SAC'    then isnull(tm_saldo_contable,0)

WHEN  'SAD'    then isnull(tm_saldo_disponible,0)

WHEN  'L24'    then isnull(tm_l24h,0)

WHEN  'REM'    then isnull(tm_remesas,0)

WHEN  'SCO'    then isnull(tm_contratado,0)

WHEN  'SOC'    then isnull(tm_ocasional,0)

WHEN  'IMP'    then isnull(tm_valor_impuesto,0)

WHEN  'ISO'    then isnull(tm_valor_solca,0)

WHEN  'VSI'    then isnull(tm_valor,0) - isnull(tm_valor_impuesto,0)

WHEN  'CAP'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'    then isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

WHEN  'CAI'    then isnull(tm_valor,0) + isnull(tm_valor_impuesto,0) + isnull(tm_efectivo,0)

end,

cc_dp_cuenta,

cc_cta_iva,

cc_cta_puente,

tm_moneda,

tm_correccion,

cc_debcred,

(select   convert(varchar,z.cc_oficina) + '-' + of_nombre

         from cob_cuentas..cc_ctacte z,cobis..cl_oficina

         where  cc_cta_banco= a.tm_cta_banco and of_oficina=cc_oficina),

tm_secuencial,

tm_cod_alterno, --ref2 smerino

iva_dev=0 ,	-- Ref06 pholguiv

oficina_orig=null,	-- Ref06 pholguiv,

cta_deb	=null,	-- Ref06 pholguiv

'' , '' --Ref007:msilvag

from cob_cuentas..cc_tran_monet a ,db_general..cc_cuenta_tran1 x,cobis..cl_oficina , cobis..cl_ttransaccion  --Ref05 pholguiv

where tm_tipo_tran=cc_tipo_tran and isnull(tm_causa,'0') = case when cc_causa_org = '0' then isnull(tm_causa,'0') else cc_causa_org end	 --ref 2

and tm_oficina=of_oficina

and tn_trn_code=tm_tipo_tran

and tm_fecha='03/17/2021'

--and tm_secuencial in (95196049,95195066,95195760)




union



select tm_oficina ,

of_nombre,

tm_fecha ,

tm_hora ,

tm_tipo_tran ,

tn_descripcion,

tm_causa ,

(select isnull(d.valor,'')

	      from cobis..cl_tabla c,

		   cobis..cl_catalogo d

	      where c.tabla = (select tc_tabla

				from cob_cuentas..cc_causas_cat

				where tc_transaccion=a.tm_tipo_tran)

	      and c.codigo = d.tabla

	      and d.codigo = a.tm_causa) , --c.descripcion,  --descripcion de causa saca de la tabla del catalogo

tm_cta_banco ,

'AHO' ,

tm_usuario ,

case cc_nme_ing

WHEN  'VTR'   then  isnull(tm_valor,0)

WHEN  'VCH'   then  isnull(tm_chq_locales,0)

WHEN  'COM'   then  isnull(tm_valor_comision,0)

WHEN  'INT'   then  isnull(tm_saldo_interes,0)

WHEN  'TDE'   then  isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'   then  isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'   then  isnull(tm_valor,0) - isnull(tm_saldo_interes,0)

WHEN  'CCO'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'   then  isnull(tm_efectivo,0)

WHEN  'SAL'   then  isnull(tm_saldo_lib,0)

WHEN  'SAC'   then  isnull(tm_saldo_contable,0)

WHEN  'SAD'   then  isnull(tm_saldo_disponible,0)

WHEN  'IN2'   then  isnull(tm_interes,0)

WHEN  'MCH'   then  isnull(tm_val_cheque,0)

WHEN  'IMP'   then  isnull(tm_valor_impuesto,0)

WHEN  'CAP'   then  isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

end,

case cc_nme_iva

WHEN  'VTR'   then  isnull(tm_valor,0)

WHEN  'VCH'   then  isnull(tm_chq_locales,0)

WHEN  'COM'   then  isnull(tm_valor_comision,0)

WHEN  'INT'   then  isnull(tm_saldo_interes,0)

WHEN  'TDE'   then  isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'   then  isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'   then  isnull(tm_valor,0) - isnull(tm_saldo_interes,0)

WHEN  'CCO'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'   then  isnull(tm_efectivo,0)

WHEN  'SAL'   then  isnull(tm_saldo_lib,0)

WHEN  'SAC'   then  isnull(tm_saldo_contable,0)

WHEN  'SAD'   then  isnull(tm_saldo_disponible,0)

WHEN  'IN2'   then  isnull(tm_interes,0)

WHEN  'MCH'   then  isnull(tm_val_cheque,0)

WHEN  'IMP'   then  isnull(tm_valor_impuesto,0)

WHEN  'CAP'   then  isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

end ,

case cc_nme_puente

WHEN  'VTR'   then  isnull(tm_valor,0)

WHEN  'VCH'   then  isnull(tm_chq_locales,0)

WHEN  'COM'   then  isnull(tm_valor_comision,0)

WHEN  'INT'   then  isnull(tm_saldo_interes,0)

WHEN  'TDE'   then  isnull(tm_valor,0) + isnull(tm_chq_locales,0)

WHEN  'VCO'   then  isnull(tm_valor,0) - isnull(tm_valor_comision,0)

WHEN  'VIN'   then  isnull(tm_valor,0) - isnull(tm_saldo_interes,0)

WHEN  'CCO'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_comision,0)

WHEN  'EFE'   then  isnull(tm_efectivo,0)

WHEN  'SAL'   then  isnull(tm_saldo_lib,0)

WHEN  'SAC'   then  isnull(tm_saldo_contable,0)

WHEN  'SAD'   then  isnull(tm_saldo_disponible,0)

WHEN  'IN2'   then  isnull(tm_interes,0)

WHEN  'MCH'   then  isnull(tm_val_cheque,0)

WHEN  'IMP'   then  isnull(tm_valor_impuesto,0)

WHEN  'CAP'   then  isnull(tm_valor,0) + isnull(tm_valor_impuesto,0)

WHEN  'VCC'   then  isnull(tm_chq_locales,0) + isnull(tm_valor_impuesto,0) - (isnull(tm_efectivo,0) - isnull(tm_valor,0))

end ,

cc_dp_cuenta,

cc_cta_iva,

cc_cta_puente,

tm_moneda,

tm_correccion,

cc_debcred,

(select   convert(varchar,z.ah_oficina) + '-' + of_nombre

         from cob_ahorros..ah_cuenta z,cobis..cl_oficina

         where  ah_cta_banco= a.tm_cta_banco and of_oficina=ah_oficina),

tm_secuencial,

tm_cod_alterno, --ref2 smerino

iva_dev=0,	-- Ref06 pholguiv

oficina_orig=null,	-- Ref06 pholguiv

cta_deb	=null,	-- Ref06 pholguiv

'' , '' --Ref007:msilvag

from cob_ahorros..ah_tran_monet a ,db_general..cc_cuenta_tran1 x,cobis..cl_oficina , cobis..cl_ttransaccion  --Ref05 pholguiv

where tm_tipo_tran=cc_tipo_tran and isnull(tm_causa,'0') = case when cc_causa_org = '0' then isnull(tm_causa,'0') else cc_causa_org end	 --ref 2

and tm_oficina=of_oficina

and tn_trn_code=tm_tipo_tran

and tm_fecha='02/26/2021'

--and tm_secuencial in (95196049,95195066,95195760)

--and tm_secuencial in (48669393,45991339,46963566,47877756)





	if @@error <> 0

	begin

	 exec cobis..sp_cerror

	      @t_debug  = 'N',

	      @t_file   = null,

	      @t_from   = @w_sp_name,

	      @i_num    = 035000,

	      @i_msg    = 'ERROR AL INSERTAR EN TABLA DE cc_tmp_trx_iva'



	 return 1

	end





return 0

