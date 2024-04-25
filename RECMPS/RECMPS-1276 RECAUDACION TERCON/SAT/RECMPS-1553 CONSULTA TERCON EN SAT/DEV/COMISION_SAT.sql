cob_internet..sp_helptext pa_cash_cprocesar_tarifaBE,null,null,showsql
cob_internet..sp_helptext pa_cash_cfuncionalidad ,null,null,showsql
cob_internet..sp_helptext pa_cash_cprocesar_tarifaBPersn ,null,null,showsql
cob_internet..sp_helptext pa_cash_ccons_otrbcos,null,null,showsql
cob_internet..sp_helptext pa_cash_cvalor_contratado,null,null,showsql
cob_remesas..sp_helptext sp_genera_costos,null,null,showsql

select * from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla

where t.tabla = 'sv_grp_emp_tarifabp' 

and c.estado = 'V' and c.codigo = convert(varchar(5) , '1929')

---

EXEC cob_internet..pa_cash_cprocesar_tarifaBE
@e_identificacion = '0990000085001',
@e_id_funcionalidad = '2056',
@e_canal = 'SAT',
@e_servicio = '8459' ,
@e_codigo_empresa = null,
@e_alcance = 'C',
@e_monto = 1,
@e_pais = null,
@e_cargo= null,
@e_cuenta = '0000064323',
@e_tipo_cuenta = 'CTE',
@e_banco = '',
@e_forma_pago = NULL,
@e_accion_revocatoria_ch = '',
@e_tipo_impuesto_fiscal = '',
@e_codigo_empresa_proveedora = 1929,
@e_se_debita = false


---

declare
@v_retorno int,
@s_mensaje_usuario varchar(132),
@v_opcion varchar,
@v_rubro varchar,
@v_codigoEmpresaProveedora int,
@v_codigo_respuesta int,
@v_tabla varchar


begin
exec @v_retorno = cob_internet..pa_cash_cfuncionalidad
@e_id_funcionalidad = '2056',
@e_ambito = 'BE',
@e_tipo_cuenta = 'CTE',
@e_codigo_empresa_proveedora = 8459, -- REF03
--@s_tf_tipoComision = @v_tipo_comision OUTPUT,
@s_tf_codigoEmpresaProveedora = @v_codigoEmpresaProveedora OUTPUT,
@s_tf_opcion = @v_opcion OUTPUT,
@s_tf_tabla = @v_tabla OUTPUT,
--@s_tf_codigo = @v_codigo OUTPUT,
@s_tf_rubro = @v_rubro OUTPUT,
--@s_tf_canal = @s_canal OUTPUT,
@s_codigo_respuesta = @v_codigo_respuesta OUTPUT,
@s_mensaje_usuario = @s_mensaje_usuario OUTPUT
--@s_tf_transaccion = @v_transaccion OUTPUT,
--@s_tf_causa = ''
--@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario

print '%1!,%2!,%3!,%4!,%5!,%6!,%7!' , 
@s_mensaje_usuario, @v_retorno, @v_opcion, @v_rubro, @v_codigoEmpresaProveedora, @v_codigo_respuesta,@v_tabla
end


--

declare
@v_retorno int,
@v_comision float,
@v_codigo_respuesta int,
@v_mensaje_usuario varchar,
@v_cobrado_en_tarifario varchar
begin

exec @v_retorno = cob_internet..pa_cash_cprocesar_tarifaBPersn 
	@e_identificacion = '0990000085001',
	@e_servicio = '8459',
	@e_id_funcionalidad = '2056',
	@e_canal = 'SAT',
	@e_codigo_empresa_proveedora = 8459,
	@e_accion_revocatoria_ch = NULL,
	@e_cuenta = '0000064323',
	@e_tipo_impuesto_fiscal = null,
	@e_codigo_empresa = null,
	@e_tipo_cuenta = 'CTE',
	@e_pais = null,
	@e_opcion = 'N',
	@e_tabla = NULL,
	@e_cod_servicio = 'CSPR',
	@e_rubro = 'TRCN',
	@s_comision = @v_comision OUTPUT,
	@s_codigo_respuesta = @v_codigo_respuesta OUTPUT,
	@s_mensaje_usuario = @v_mensaje_usuario OUTPUT,
	@e_se_debita = 'false',
	@s_tf_cobrado_en_tarifario = @v_cobrado_en_tarifario OUTPUT


print '%1!,%2!,%3!,%4!,%5!' , 
@v_retorno, @v_comision, @v_codigo_respuesta, @v_mensaje_usuario, @v_cobrado_en_tarifario
end



begin
	declare
	@v_retorno int,
	@v_tipo_identificacion char(1),
	@v_identificacion varchar(20)

		exec @v_retorno = cob_internet..pa_cash_cidentTipoIdentxCta
			@e_cuenta_destino = '0000064323',
			@s_tipo_identificacion = @v_tipo_identificacion output,
			@s_identificacion = @v_identificacion  output
	print '%1!', @v_retorno
end

--
begin

declare
@s_ssn              int,
@s_user             VARCHAR(30),
@s_sesn             int,
@s_term             varchar(30) ,
@s_date             datetime,
@s_srv              varchar(30) ,
@s_lsrv             varchar(30),
@s_ofi              smallint,
@s_rol              smallint,
@s_org_err          char(1),
@s_error            int,
@s_sev              tinyint,
@s_msg              varchar(4000),
@s_org              char(1),
@t_debug            char(1),
@t_file             varchar(10),
@t_from             varchar(32),
@t_trn              int,
@o_msj_error        varchar(132),
@v_id_servicio		int,
@v_retorno 		 	int,
@v_transaccion 		varchar(10)

exec cobis..pa_CanalesNoCobis_interfase
		@i_canal            = 'IBK',    
		@s_ssn              = @s_ssn out,
		@s_user             = @s_user out,
		@s_sesn             = @s_sesn out,
		@s_term             = @s_term out,
		@s_date             = @s_date out,
		@s_srv              = @s_srv  out,
		@s_ofi              = @s_ofi  out,
		@s_rol              = @s_rol  out,
		@s_error            = @s_error  out,
		@s_org              = @s_org  out

exec @v_retorno = cob_internet..pa_cash_ccons_otrbcos
	@e_user = @s_user,  
	@e_ofi = @s_ofi,  
	@e_date = @s_date, 
	@e_term = @s_term, 
	@e_rol = @s_rol, 
	@e_srv = @s_srv,  
	@e_trn = 18664,   
	@e_ejec = 'R',  
	@e_opcion = 'N', 
	@e_codigo = 'CSPR',
	@s_servicio  = @v_id_servicio out
	print '%1!,%2!', @v_retorno,@v_id_servicio
end


select *
  from cob_remesas..pe_servicio_dis
  where sd_nemonico = 'CSPR' --CSPB
  and sd_estado='V'

select *, sd_nemonico
	from cob_remesas..pe_servicio_dis
	where sd_servicio_dis = 123 --77


select  *
	from cob_remesas..pe_var_servicio, cob_remesas..pe_servicio_dis
	where sd_nemonico = 'CSPB' --'CSPB' --CSPR
	and vs_servicio_dis = sd_servicio_dis
	and vs_rubro = 'ITRB' --TRCN

select *
	from cobis..cl_tabla a, cobis..cl_catalogo b
	where a.tabla = 'pe_tipo_dato'
	and b.tabla = a.codigo
	and b.codigo = 'M'


select  v_tipo_ente = cc_tipocta,
		cc_moneda,
		cc_categoria,
		cc_prod_banc,
		cc_tipo,
		cc_tipo_def,
		cc_default,
		cc_rol_ente,
		cc_disponible,
		cc_promedio1,
		cc_prom_disponible,
		cc_personalizada
		from cob_cuentas..cc_ctacte
		where cc_cta_banco = '0000064323'


select * from  cob_remesas..pe_mercado
    where  me_tipo_ente        = 'C'
    and me_pro_bancario = 3
    and me_estado = 'V'


select w_servicio_per = sp_servicio_per,
	w_tipo_rango   = sp_tipo_rango,
	w_grupo_rango  = sp_grupo_rango,*
	from cob_remesas..pe_servicio_per
	where sp_servicio_dis = 123 --77
	and sp_rubro        = 'ITRB' --TRCN
	and sp_mercado      = 8 --
	and sp_producto     = 3 --4
	and sp_tipo         = 'R'
	and sp_moneda       = 1

--ESTE ES EL Q VALIDAR Q EXISTA ESTO
--w_servicio_per w_tipo_rango w_grupo_rango sp_mercado sp_producto sp_moneda sp_tipo sp_servicio_dis sp_rubro   sp_servicio_per sp_tipo_rango sp_grupo_rango 
--	2310           4            5             8(ESTE)    3           1         R       77              TRCN       2310            4             5              
select w_servicio_per = sp_servicio_per,  
	w_tipo_rango   = sp_tipo_rango,
	w_grupo_rango  = sp_grupo_rango,*
	from cob_remesas..pe_servicio_per
	where sp_servicio_dis = 77 --77
	and sp_rubro        = 'TRCN' --TRCN
	and sp_mercado      = 8 
	and sp_producto     = 3 --4
	and sp_tipo         = 'R'
	and sp_moneda       = 1


select * 
	from cob_internet..cash_p_tarifario_funcionalidad 
	where tf_idFuncionalidad = '2056'
	and tf_codigoEmpresaProveedora in (8459, 8269)