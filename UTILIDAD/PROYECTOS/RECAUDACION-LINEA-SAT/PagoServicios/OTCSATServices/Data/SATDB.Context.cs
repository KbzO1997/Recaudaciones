﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace OTCSATServices.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class SATDB : DbContext
    {
        public SATDB()
            : base("name=SATDB")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual int sp_con_nemonico_empresa(string i_empresa, ObjectParameter o_nemonico)
        {
            var i_empresaParameter = i_empresa != null ?
                new ObjectParameter("i_empresa", i_empresa) :
                new ObjectParameter("i_empresa", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_con_nemonico_empresa", i_empresaParameter, o_nemonico);
        }
    
        public virtual ObjectResult<string> sp_con_nombrempresa(string i_empresa)
        {
            var i_empresaParameter = i_empresa != null ?
                new ObjectParameter("i_empresa", i_empresa) :
                new ObjectParameter("i_empresa", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_con_nombrempresa", i_empresaParameter);
        }
    
        public virtual ObjectResult<sp_con_nombrempresas_producto_Result> sp_con_nombrempresas_producto(Nullable<short> i_producto)
        {
            var i_productoParameter = i_producto.HasValue ?
                new ObjectParameter("i_producto", i_producto) :
                new ObjectParameter("i_producto", typeof(short));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_con_nombrempresas_producto_Result>("sp_con_nombrempresas_producto", i_productoParameter);
        }
    
        public virtual ObjectResult<sp_con_usuario_Result> sp_con_usuario(string us_cod_empresa, string us_nem_empresa, string us_cod_usuario)
        {
            var us_cod_empresaParameter = us_cod_empresa != null ?
                new ObjectParameter("us_cod_empresa", us_cod_empresa) :
                new ObjectParameter("us_cod_empresa", typeof(string));
    
            var us_nem_empresaParameter = us_nem_empresa != null ?
                new ObjectParameter("us_nem_empresa", us_nem_empresa) :
                new ObjectParameter("us_nem_empresa", typeof(string));
    
            var us_cod_usuarioParameter = us_cod_usuario != null ?
                new ObjectParameter("us_cod_usuario", us_cod_usuario) :
                new ObjectParameter("us_cod_usuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_con_usuario_Result>("sp_con_usuario", us_cod_empresaParameter, us_nem_empresaParameter, us_cod_usuarioParameter);
        }
    
        public virtual ObjectResult<pa_sat_cdetmatriculacion_Result> pa_sat_cdetmatriculacion(Nullable<int> e_ordenante, string e_usuario, string e_grupo, Nullable<int> e_empresa_recaudacion, string e_convenio, string e_suministro, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            var e_grupoParameter = e_grupo != null ?
                new ObjectParameter("e_grupo", e_grupo) :
                new ObjectParameter("e_grupo", typeof(string));
    
            var e_empresa_recaudacionParameter = e_empresa_recaudacion.HasValue ?
                new ObjectParameter("e_empresa_recaudacion", e_empresa_recaudacion) :
                new ObjectParameter("e_empresa_recaudacion", typeof(int));
    
            var e_convenioParameter = e_convenio != null ?
                new ObjectParameter("e_convenio", e_convenio) :
                new ObjectParameter("e_convenio", typeof(string));
    
            var e_suministroParameter = e_suministro != null ?
                new ObjectParameter("e_suministro", e_suministro) :
                new ObjectParameter("e_suministro", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_sat_cdetmatriculacion_Result>("pa_sat_cdetmatriculacion", e_ordenanteParameter, e_usuarioParameter, e_grupoParameter, e_empresa_recaudacionParameter, e_convenioParameter, e_suministroParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual int pa_sat_icabmatriculacion(Nullable<int> e_ordenante, string e_usuario, string e_grupo, Nullable<int> e_empresa_recaudacion, string e_convenio, string e_identificador, string e_etiqueta_convenio, string e_etiqueta_identificador, string e_es_editable, string e_regexp, string e_texto_ayuda, string e_mascara, string e_alias, string e_suministro, string e_regional, string e_usuario_creacion, string e_usuario_modificacion, Nullable<System.DateTime> e_fecha_modificacion, string e_estado, string e_nombre_empresa_recaudacion, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            var e_grupoParameter = e_grupo != null ?
                new ObjectParameter("e_grupo", e_grupo) :
                new ObjectParameter("e_grupo", typeof(string));
    
            var e_empresa_recaudacionParameter = e_empresa_recaudacion.HasValue ?
                new ObjectParameter("e_empresa_recaudacion", e_empresa_recaudacion) :
                new ObjectParameter("e_empresa_recaudacion", typeof(int));
    
            var e_convenioParameter = e_convenio != null ?
                new ObjectParameter("e_convenio", e_convenio) :
                new ObjectParameter("e_convenio", typeof(string));
    
            var e_identificadorParameter = e_identificador != null ?
                new ObjectParameter("e_identificador", e_identificador) :
                new ObjectParameter("e_identificador", typeof(string));
    
            var e_etiqueta_convenioParameter = e_etiqueta_convenio != null ?
                new ObjectParameter("e_etiqueta_convenio", e_etiqueta_convenio) :
                new ObjectParameter("e_etiqueta_convenio", typeof(string));
    
            var e_etiqueta_identificadorParameter = e_etiqueta_identificador != null ?
                new ObjectParameter("e_etiqueta_identificador", e_etiqueta_identificador) :
                new ObjectParameter("e_etiqueta_identificador", typeof(string));
    
            var e_es_editableParameter = e_es_editable != null ?
                new ObjectParameter("e_es_editable", e_es_editable) :
                new ObjectParameter("e_es_editable", typeof(string));
    
            var e_regexpParameter = e_regexp != null ?
                new ObjectParameter("e_regexp", e_regexp) :
                new ObjectParameter("e_regexp", typeof(string));
    
            var e_texto_ayudaParameter = e_texto_ayuda != null ?
                new ObjectParameter("e_texto_ayuda", e_texto_ayuda) :
                new ObjectParameter("e_texto_ayuda", typeof(string));
    
            var e_mascaraParameter = e_mascara != null ?
                new ObjectParameter("e_mascara", e_mascara) :
                new ObjectParameter("e_mascara", typeof(string));
    
            var e_aliasParameter = e_alias != null ?
                new ObjectParameter("e_alias", e_alias) :
                new ObjectParameter("e_alias", typeof(string));
    
            var e_suministroParameter = e_suministro != null ?
                new ObjectParameter("e_suministro", e_suministro) :
                new ObjectParameter("e_suministro", typeof(string));
    
            var e_regionalParameter = e_regional != null ?
                new ObjectParameter("e_regional", e_regional) :
                new ObjectParameter("e_regional", typeof(string));
    
            var e_usuario_creacionParameter = e_usuario_creacion != null ?
                new ObjectParameter("e_usuario_creacion", e_usuario_creacion) :
                new ObjectParameter("e_usuario_creacion", typeof(string));
    
            var e_usuario_modificacionParameter = e_usuario_modificacion != null ?
                new ObjectParameter("e_usuario_modificacion", e_usuario_modificacion) :
                new ObjectParameter("e_usuario_modificacion", typeof(string));
    
            var e_fecha_modificacionParameter = e_fecha_modificacion.HasValue ?
                new ObjectParameter("e_fecha_modificacion", e_fecha_modificacion) :
                new ObjectParameter("e_fecha_modificacion", typeof(System.DateTime));
    
            var e_estadoParameter = e_estado != null ?
                new ObjectParameter("e_estado", e_estado) :
                new ObjectParameter("e_estado", typeof(string));
    
            var e_nombre_empresa_recaudacionParameter = e_nombre_empresa_recaudacion != null ?
                new ObjectParameter("e_nombre_empresa_recaudacion", e_nombre_empresa_recaudacion) :
                new ObjectParameter("e_nombre_empresa_recaudacion", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_icabmatriculacion", e_ordenanteParameter, e_usuarioParameter, e_grupoParameter, e_empresa_recaudacionParameter, e_convenioParameter, e_identificadorParameter, e_etiqueta_convenioParameter, e_etiqueta_identificadorParameter, e_es_editableParameter, e_regexpParameter, e_texto_ayudaParameter, e_mascaraParameter, e_aliasParameter, e_suministroParameter, e_regionalParameter, e_usuario_creacionParameter, e_usuario_modificacionParameter, e_fecha_modificacionParameter, e_estadoParameter, e_nombre_empresa_recaudacionParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual int pa_sat_idetmatriculacion(Nullable<int> e_ordenante, string e_usuario, string e_grupo, Nullable<int> e_empresa_recaudacion, string e_convenio, string e_identificador, string e_suministro, string e_codigo_dato_adicional, string e_etiqueta, string e_es_editable, string e_tipo, string e_valor, string e_es_visible, string e_formato, string e_mascara, string e_regexp, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            var e_grupoParameter = e_grupo != null ?
                new ObjectParameter("e_grupo", e_grupo) :
                new ObjectParameter("e_grupo", typeof(string));
    
            var e_empresa_recaudacionParameter = e_empresa_recaudacion.HasValue ?
                new ObjectParameter("e_empresa_recaudacion", e_empresa_recaudacion) :
                new ObjectParameter("e_empresa_recaudacion", typeof(int));
    
            var e_convenioParameter = e_convenio != null ?
                new ObjectParameter("e_convenio", e_convenio) :
                new ObjectParameter("e_convenio", typeof(string));
    
            var e_identificadorParameter = e_identificador != null ?
                new ObjectParameter("e_identificador", e_identificador) :
                new ObjectParameter("e_identificador", typeof(string));
    
            var e_suministroParameter = e_suministro != null ?
                new ObjectParameter("e_suministro", e_suministro) :
                new ObjectParameter("e_suministro", typeof(string));
    
            var e_codigo_dato_adicionalParameter = e_codigo_dato_adicional != null ?
                new ObjectParameter("e_codigo_dato_adicional", e_codigo_dato_adicional) :
                new ObjectParameter("e_codigo_dato_adicional", typeof(string));
    
            var e_etiquetaParameter = e_etiqueta != null ?
                new ObjectParameter("e_etiqueta", e_etiqueta) :
                new ObjectParameter("e_etiqueta", typeof(string));
    
            var e_es_editableParameter = e_es_editable != null ?
                new ObjectParameter("e_es_editable", e_es_editable) :
                new ObjectParameter("e_es_editable", typeof(string));
    
            var e_tipoParameter = e_tipo != null ?
                new ObjectParameter("e_tipo", e_tipo) :
                new ObjectParameter("e_tipo", typeof(string));
    
            var e_valorParameter = e_valor != null ?
                new ObjectParameter("e_valor", e_valor) :
                new ObjectParameter("e_valor", typeof(string));
    
            var e_es_visibleParameter = e_es_visible != null ?
                new ObjectParameter("e_es_visible", e_es_visible) :
                new ObjectParameter("e_es_visible", typeof(string));
    
            var e_formatoParameter = e_formato != null ?
                new ObjectParameter("e_formato", e_formato) :
                new ObjectParameter("e_formato", typeof(string));
    
            var e_mascaraParameter = e_mascara != null ?
                new ObjectParameter("e_mascara", e_mascara) :
                new ObjectParameter("e_mascara", typeof(string));
    
            var e_regexpParameter = e_regexp != null ?
                new ObjectParameter("e_regexp", e_regexp) :
                new ObjectParameter("e_regexp", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_idetmatriculacion", e_ordenanteParameter, e_usuarioParameter, e_grupoParameter, e_empresa_recaudacionParameter, e_convenioParameter, e_identificadorParameter, e_suministroParameter, e_codigo_dato_adicionalParameter, e_etiquetaParameter, e_es_editableParameter, e_tipoParameter, e_valorParameter, e_es_visibleParameter, e_formatoParameter, e_mascaraParameter, e_regexpParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual ObjectResult<pa_sat_ccabmatriculacion_Result> pa_sat_ccabmatriculacion(Nullable<int> e_ordenante, string e_usuario, string e_grupo, Nullable<int> e_empresa_recaudacion, string e_convenio, string e_estado, Nullable<int> e_indice_inicial, Nullable<int> e_registros_x_pagina, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            var e_grupoParameter = e_grupo != null ?
                new ObjectParameter("e_grupo", e_grupo) :
                new ObjectParameter("e_grupo", typeof(string));
    
            var e_empresa_recaudacionParameter = e_empresa_recaudacion.HasValue ?
                new ObjectParameter("e_empresa_recaudacion", e_empresa_recaudacion) :
                new ObjectParameter("e_empresa_recaudacion", typeof(int));
    
            var e_convenioParameter = e_convenio != null ?
                new ObjectParameter("e_convenio", e_convenio) :
                new ObjectParameter("e_convenio", typeof(string));
    
            var e_estadoParameter = e_estado != null ?
                new ObjectParameter("e_estado", e_estado) :
                new ObjectParameter("e_estado", typeof(string));
    
            var e_indice_inicialParameter = e_indice_inicial.HasValue ?
                new ObjectParameter("e_indice_inicial", e_indice_inicial) :
                new ObjectParameter("e_indice_inicial", typeof(int));
    
            var e_registros_x_paginaParameter = e_registros_x_pagina.HasValue ?
                new ObjectParameter("e_registros_x_pagina", e_registros_x_pagina) :
                new ObjectParameter("e_registros_x_pagina", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_sat_ccabmatriculacion_Result>("pa_sat_ccabmatriculacion", e_ordenanteParameter, e_usuarioParameter, e_grupoParameter, e_empresa_recaudacionParameter, e_convenioParameter, e_estadoParameter, e_indice_inicialParameter, e_registros_x_paginaParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual ObjectResult<pa_sat_cgruposxusuario_Result> pa_sat_cgruposxusuario(Nullable<int> e_ordenante, string e_usuario, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_sat_cgruposxusuario_Result>("pa_sat_cgruposxusuario", e_ordenanteParameter, e_usuarioParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual ObjectResult<sp_cuenta_empresa_Result> sp_cuenta_empresa(Nullable<int> i_empresa, string i_servicio)
        {
            var i_empresaParameter = i_empresa.HasValue ?
                new ObjectParameter("i_empresa", i_empresa) :
                new ObjectParameter("i_empresa", typeof(int));
    
            var i_servicioParameter = i_servicio != null ?
                new ObjectParameter("i_servicio", i_servicio) :
                new ObjectParameter("i_servicio", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_cuenta_empresa_Result>("sp_cuenta_empresa", i_empresaParameter, i_servicioParameter);
        }
    
        public virtual ObjectResult<pa_con_cempresa_esp_Result> pa_con_cempresa_esp(string e_nom_empresa, Nullable<int> e_rowcount)
        {
            var e_nom_empresaParameter = e_nom_empresa != null ?
                new ObjectParameter("e_nom_empresa", e_nom_empresa) :
                new ObjectParameter("e_nom_empresa", typeof(string));
    
            var e_rowcountParameter = e_rowcount.HasValue ?
                new ObjectParameter("e_rowcount", e_rowcount) :
                new ObjectParameter("e_rowcount", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_con_cempresa_esp_Result>("pa_con_cempresa_esp", e_nom_empresaParameter, e_rowcountParameter);
        }
    
        public virtual ObjectResult<pa_sat_cmatriculacion_Result> pa_sat_cmatriculacion(Nullable<int> e_secuencia, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_secuenciaParameter = e_secuencia.HasValue ?
                new ObjectParameter("e_secuencia", e_secuencia) :
                new ObjectParameter("e_secuencia", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_sat_cmatriculacion_Result>("pa_sat_cmatriculacion", e_secuenciaParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual ObjectResult<sp_con_empresa_Result> sp_con_empresa(string em_cod_empresa)
        {
            var em_cod_empresaParameter = em_cod_empresa != null ?
                new ObjectParameter("em_cod_empresa", em_cod_empresa) :
                new ObjectParameter("em_cod_empresa", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_con_empresa_Result>("sp_con_empresa", em_cod_empresaParameter);
        }
    
        public virtual int pa_sat_acupo_cliente_serv(Nullable<int> e_empresa, string e_cod_usuario, Nullable<byte> e_tipo_cuenta, string e_id_principal, string e_servicio, Nullable<decimal> e_valor, Nullable<decimal> e_comision, ObjectParameter s_cod_error, ObjectParameter s_mensaje_error, string e_band_consulta)
        {
            var e_empresaParameter = e_empresa.HasValue ?
                new ObjectParameter("e_empresa", e_empresa) :
                new ObjectParameter("e_empresa", typeof(int));
    
            var e_cod_usuarioParameter = e_cod_usuario != null ?
                new ObjectParameter("e_cod_usuario", e_cod_usuario) :
                new ObjectParameter("e_cod_usuario", typeof(string));
    
            var e_tipo_cuentaParameter = e_tipo_cuenta.HasValue ?
                new ObjectParameter("e_tipo_cuenta", e_tipo_cuenta) :
                new ObjectParameter("e_tipo_cuenta", typeof(byte));
    
            var e_id_principalParameter = e_id_principal != null ?
                new ObjectParameter("e_id_principal", e_id_principal) :
                new ObjectParameter("e_id_principal", typeof(string));
    
            var e_servicioParameter = e_servicio != null ?
                new ObjectParameter("e_servicio", e_servicio) :
                new ObjectParameter("e_servicio", typeof(string));
    
            var e_valorParameter = e_valor.HasValue ?
                new ObjectParameter("e_valor", e_valor) :
                new ObjectParameter("e_valor", typeof(decimal));
    
            var e_comisionParameter = e_comision.HasValue ?
                new ObjectParameter("e_comision", e_comision) :
                new ObjectParameter("e_comision", typeof(decimal));
    
            var e_band_consultaParameter = e_band_consulta != null ?
                new ObjectParameter("e_band_consulta", e_band_consulta) :
                new ObjectParameter("e_band_consulta", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_acupo_cliente_serv", e_empresaParameter, e_cod_usuarioParameter, e_tipo_cuentaParameter, e_id_principalParameter, e_servicioParameter, e_valorParameter, e_comisionParameter, s_cod_error, s_mensaje_error, e_band_consultaParameter);
        }
    
        public virtual int pa_sat_ccupo_cliente_serv(Nullable<int> e_empresa, string e_cod_usuario, Nullable<byte> e_tipo_cuenta, string e_id_principal, string e_servicio, ObjectParameter s_disponible, ObjectParameter s_utilizado, ObjectParameter s_asignado, ObjectParameter s_grupo, ObjectParameter s_cod_error, ObjectParameter s_mensaje_error)
        {
            var e_empresaParameter = e_empresa.HasValue ?
                new ObjectParameter("e_empresa", e_empresa) :
                new ObjectParameter("e_empresa", typeof(int));
    
            var e_cod_usuarioParameter = e_cod_usuario != null ?
                new ObjectParameter("e_cod_usuario", e_cod_usuario) :
                new ObjectParameter("e_cod_usuario", typeof(string));
    
            var e_tipo_cuentaParameter = e_tipo_cuenta.HasValue ?
                new ObjectParameter("e_tipo_cuenta", e_tipo_cuenta) :
                new ObjectParameter("e_tipo_cuenta", typeof(byte));
    
            var e_id_principalParameter = e_id_principal != null ?
                new ObjectParameter("e_id_principal", e_id_principal) :
                new ObjectParameter("e_id_principal", typeof(string));
    
            var e_servicioParameter = e_servicio != null ?
                new ObjectParameter("e_servicio", e_servicio) :
                new ObjectParameter("e_servicio", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_ccupo_cliente_serv", e_empresaParameter, e_cod_usuarioParameter, e_tipo_cuentaParameter, e_id_principalParameter, e_servicioParameter, s_disponible, s_utilizado, s_asignado, s_grupo, s_cod_error, s_mensaje_error);
        }
    
        public virtual int pa_sat_inotif_pagserv(Nullable<int> e_ordenante, string e_usuario, Nullable<short> e_tipo_cuenta, string e_numero_cuenta, string e_monto, string e_comision, string e_monto_total, string e_grupo, string e_nom_empresa_rec, string e_nom_convenio, string e_suministro, string e_orden_empresa, string e_fecha_pago, string e_tipo_ident, string e_alias, string e_nombre_abonado, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_ordenanteParameter = e_ordenante.HasValue ?
                new ObjectParameter("e_ordenante", e_ordenante) :
                new ObjectParameter("e_ordenante", typeof(int));
    
            var e_usuarioParameter = e_usuario != null ?
                new ObjectParameter("e_usuario", e_usuario) :
                new ObjectParameter("e_usuario", typeof(string));
    
            var e_tipo_cuentaParameter = e_tipo_cuenta.HasValue ?
                new ObjectParameter("e_tipo_cuenta", e_tipo_cuenta) :
                new ObjectParameter("e_tipo_cuenta", typeof(short));
    
            var e_numero_cuentaParameter = e_numero_cuenta != null ?
                new ObjectParameter("e_numero_cuenta", e_numero_cuenta) :
                new ObjectParameter("e_numero_cuenta", typeof(string));
    
            var e_montoParameter = e_monto != null ?
                new ObjectParameter("e_monto", e_monto) :
                new ObjectParameter("e_monto", typeof(string));
    
            var e_comisionParameter = e_comision != null ?
                new ObjectParameter("e_comision", e_comision) :
                new ObjectParameter("e_comision", typeof(string));
    
            var e_monto_totalParameter = e_monto_total != null ?
                new ObjectParameter("e_monto_total", e_monto_total) :
                new ObjectParameter("e_monto_total", typeof(string));
    
            var e_grupoParameter = e_grupo != null ?
                new ObjectParameter("e_grupo", e_grupo) :
                new ObjectParameter("e_grupo", typeof(string));
    
            var e_nom_empresa_recParameter = e_nom_empresa_rec != null ?
                new ObjectParameter("e_nom_empresa_rec", e_nom_empresa_rec) :
                new ObjectParameter("e_nom_empresa_rec", typeof(string));
    
            var e_nom_convenioParameter = e_nom_convenio != null ?
                new ObjectParameter("e_nom_convenio", e_nom_convenio) :
                new ObjectParameter("e_nom_convenio", typeof(string));
    
            var e_suministroParameter = e_suministro != null ?
                new ObjectParameter("e_suministro", e_suministro) :
                new ObjectParameter("e_suministro", typeof(string));
    
            var e_orden_empresaParameter = e_orden_empresa != null ?
                new ObjectParameter("e_orden_empresa", e_orden_empresa) :
                new ObjectParameter("e_orden_empresa", typeof(string));
    
            var e_fecha_pagoParameter = e_fecha_pago != null ?
                new ObjectParameter("e_fecha_pago", e_fecha_pago) :
                new ObjectParameter("e_fecha_pago", typeof(string));
    
            var e_tipo_identParameter = e_tipo_ident != null ?
                new ObjectParameter("e_tipo_ident", e_tipo_ident) :
                new ObjectParameter("e_tipo_ident", typeof(string));
    
            var e_aliasParameter = e_alias != null ?
                new ObjectParameter("e_alias", e_alias) :
                new ObjectParameter("e_alias", typeof(string));
    
            var e_nombre_abonadoParameter = e_nombre_abonado != null ?
                new ObjectParameter("e_nombre_abonado", e_nombre_abonado) :
                new ObjectParameter("e_nombre_abonado", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_inotif_pagserv", e_ordenanteParameter, e_usuarioParameter, e_tipo_cuentaParameter, e_numero_cuentaParameter, e_montoParameter, e_comisionParameter, e_monto_totalParameter, e_grupoParameter, e_nom_empresa_recParameter, e_nom_convenioParameter, e_suministroParameter, e_orden_empresaParameter, e_fecha_pagoParameter, e_tipo_identParameter, e_aliasParameter, e_nombre_abonadoParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual ObjectResult<pa_sat_ccuentas_xlogin_Result> pa_sat_ccuentas_xlogin(Nullable<int> e_empresa, string e_login, Nullable<byte> e_t_producto_usuario)
        {
            var e_empresaParameter = e_empresa.HasValue ?
                new ObjectParameter("e_empresa", e_empresa) :
                new ObjectParameter("e_empresa", typeof(int));
    
            var e_loginParameter = e_login != null ?
                new ObjectParameter("e_login", e_login) :
                new ObjectParameter("e_login", typeof(string));
    
            var e_t_producto_usuarioParameter = e_t_producto_usuario.HasValue ?
                new ObjectParameter("e_t_producto_usuario", e_t_producto_usuario) :
                new ObjectParameter("e_t_producto_usuario", typeof(byte));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<pa_sat_ccuentas_xlogin_Result>("pa_sat_ccuentas_xlogin", e_empresaParameter, e_loginParameter, e_t_producto_usuarioParameter);
        }
    
        public virtual int pa_sat_mcabmatriculacion(Nullable<int> e_secuencia, string e_alias, string e_estado, string e_usuario_modificacion, ObjectParameter s_codigo_respuesta, ObjectParameter s_mensaje_error)
        {
            var e_secuenciaParameter = e_secuencia.HasValue ?
                new ObjectParameter("e_secuencia", e_secuencia) :
                new ObjectParameter("e_secuencia", typeof(int));
    
            var e_aliasParameter = e_alias != null ?
                new ObjectParameter("e_alias", e_alias) :
                new ObjectParameter("e_alias", typeof(string));
    
            var e_estadoParameter = e_estado != null ?
                new ObjectParameter("e_estado", e_estado) :
                new ObjectParameter("e_estado", typeof(string));
    
            var e_usuario_modificacionParameter = e_usuario_modificacion != null ?
                new ObjectParameter("e_usuario_modificacion", e_usuario_modificacion) :
                new ObjectParameter("e_usuario_modificacion", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("pa_sat_mcabmatriculacion", e_secuenciaParameter, e_aliasParameter, e_estadoParameter, e_usuario_modificacionParameter, s_codigo_respuesta, s_mensaje_error);
        }
    
        public virtual int sp_grb_reg_auditoria(string i_au_cod_empresa, string i_au_cod_usuario, Nullable<int> i_au_cod_producto, string i_au_cod_servicio, Nullable<int> i_au_cod_modulo, Nullable<int> i_au_cod_transaccion, string i_au_opcion, string i_au_accion, string i_au_des_accion, Nullable<int> i_sesion)
        {
            var i_au_cod_empresaParameter = i_au_cod_empresa != null ?
                new ObjectParameter("i_au_cod_empresa", i_au_cod_empresa) :
                new ObjectParameter("i_au_cod_empresa", typeof(string));
    
            var i_au_cod_usuarioParameter = i_au_cod_usuario != null ?
                new ObjectParameter("i_au_cod_usuario", i_au_cod_usuario) :
                new ObjectParameter("i_au_cod_usuario", typeof(string));
    
            var i_au_cod_productoParameter = i_au_cod_producto.HasValue ?
                new ObjectParameter("i_au_cod_producto", i_au_cod_producto) :
                new ObjectParameter("i_au_cod_producto", typeof(int));
    
            var i_au_cod_servicioParameter = i_au_cod_servicio != null ?
                new ObjectParameter("i_au_cod_servicio", i_au_cod_servicio) :
                new ObjectParameter("i_au_cod_servicio", typeof(string));
    
            var i_au_cod_moduloParameter = i_au_cod_modulo.HasValue ?
                new ObjectParameter("i_au_cod_modulo", i_au_cod_modulo) :
                new ObjectParameter("i_au_cod_modulo", typeof(int));
    
            var i_au_cod_transaccionParameter = i_au_cod_transaccion.HasValue ?
                new ObjectParameter("i_au_cod_transaccion", i_au_cod_transaccion) :
                new ObjectParameter("i_au_cod_transaccion", typeof(int));
    
            var i_au_opcionParameter = i_au_opcion != null ?
                new ObjectParameter("i_au_opcion", i_au_opcion) :
                new ObjectParameter("i_au_opcion", typeof(string));
    
            var i_au_accionParameter = i_au_accion != null ?
                new ObjectParameter("i_au_accion", i_au_accion) :
                new ObjectParameter("i_au_accion", typeof(string));
    
            var i_au_des_accionParameter = i_au_des_accion != null ?
                new ObjectParameter("i_au_des_accion", i_au_des_accion) :
                new ObjectParameter("i_au_des_accion", typeof(string));
    
            var i_sesionParameter = i_sesion.HasValue ?
                new ObjectParameter("i_sesion", i_sesion) :
                new ObjectParameter("i_sesion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_grb_reg_auditoria", i_au_cod_empresaParameter, i_au_cod_usuarioParameter, i_au_cod_productoParameter, i_au_cod_servicioParameter, i_au_cod_moduloParameter, i_au_cod_transaccionParameter, i_au_opcionParameter, i_au_accionParameter, i_au_des_accionParameter, i_sesionParameter);
        }
    
        public virtual ObjectResult<sp_con_usuario_dispositivo_Result> sp_con_usuario_dispositivo(string i_empresa, string i_usuario, Nullable<int> i_transaccion, Nullable<int> i_producto, string i_servicio, string i_accion)
        {
            var i_empresaParameter = i_empresa != null ?
                new ObjectParameter("i_empresa", i_empresa) :
                new ObjectParameter("i_empresa", typeof(string));
    
            var i_usuarioParameter = i_usuario != null ?
                new ObjectParameter("i_usuario", i_usuario) :
                new ObjectParameter("i_usuario", typeof(string));
    
            var i_transaccionParameter = i_transaccion.HasValue ?
                new ObjectParameter("i_transaccion", i_transaccion) :
                new ObjectParameter("i_transaccion", typeof(int));
    
            var i_productoParameter = i_producto.HasValue ?
                new ObjectParameter("i_producto", i_producto) :
                new ObjectParameter("i_producto", typeof(int));
    
            var i_servicioParameter = i_servicio != null ?
                new ObjectParameter("i_servicio", i_servicio) :
                new ObjectParameter("i_servicio", typeof(string));
    
            var i_accionParameter = i_accion != null ?
                new ObjectParameter("i_accion", i_accion) :
                new ObjectParameter("i_accion", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_con_usuario_dispositivo_Result>("sp_con_usuario_dispositivo", i_empresaParameter, i_usuarioParameter, i_transaccionParameter, i_productoParameter, i_servicioParameter, i_accionParameter);
        }
    }
}
