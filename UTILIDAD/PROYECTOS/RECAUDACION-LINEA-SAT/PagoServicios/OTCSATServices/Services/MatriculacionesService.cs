using OTCSAT.Entities;
using OTCSATServices.Data;
using OTCSATServices.Entities;
using OTCSATServices.Services.Interfaces;
using OTCSATServices.Utils;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services
{
    public class MatriculacionesService:IMatriculacionesService
    {
        public MatriculacionesService()
        {

        }

        /// <summary>
        /// Consulta las matriculaciones existentes por los filtros de busqueda indicados
        /// </summary>
        /// <param name="ordenante">Codigo de Empresa SAT</param>
        /// <param name="usuario">Codigo de Usuario SAT</param>
        /// <param name="grupo">Agrupacion de Recaudacion</param>
        /// <param name="empresaRecaudacion">Empresa de Recaudacion</param>
        /// <param name="convenio">Convenio asociado a la empresa de recaudacion</param>
        /// <param name="indiceInicial">Indice de Busqueda Inicial</param>
        /// <param name="registrosPorPagina">Registros Por Pagina</param>
        /// <returns>La lista de matriculaciones segun los filtros de busqueda</returns>
        public IEnumerable<Matriculacion> ObtenerMatriculaciones(
            int ordenante = 0,
            string usuario = "T",
            string grupo = "T",
            int empresaRecaudacion = 0,
            string convenio = "T",
            string estado = "T",
            int indiceInicial = 0,
            int registrosPorPagina = 10)
        {

            List<Matriculacion> detalles = new List<Matriculacion>();

            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta",typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error",typeof(string));

                ObjectResult<pa_sat_ccabmatriculacion_Result> matriculaciones = contexto.pa_sat_ccabmatriculacion(
                    ordenante, 
                    usuario, 
                    grupo, 
                    empresaRecaudacion,
                    convenio,
                    estado, 
                    indiceInicial, 
                    registrosPorPagina, 
                    codigoRespuesta, 
                    mensajeError);

                foreach (pa_sat_ccabmatriculacion_Result filaMatriculacion in matriculaciones)
                {
                    detalles.Add(new Matriculacion {
                        Alias = filaMatriculacion.cm_alias,
                        Convenio = filaMatriculacion.cm_convenio,
                        EmpresaRecaudacion = filaMatriculacion.cm_empresa_recaudacion,
                        EsEditable = filaMatriculacion.cm_es_editable,
                        Estado = filaMatriculacion.cm_estado,
                        EtiquetaConvenio = filaMatriculacion.cm_etiqueta_convenio,
                        EtiquetaIdentificador = filaMatriculacion.cm_etiqueta_identificador,
                        FechaCreacion = filaMatriculacion.cm_fecha_creacion,
                        FechaModificacion = filaMatriculacion.cm_fecha_modificacion,
                        Grupo = filaMatriculacion.cm_grupo,
                        Identificador = filaMatriculacion.cm_identificador,
                        Mascara = filaMatriculacion.cm_mascara,
                        Ordenante = filaMatriculacion.cm_ordenante,
                        RegExp = filaMatriculacion.cm_regexp,
                        Regional = filaMatriculacion.cm_regional,
                        Secuencia = filaMatriculacion.cm_secuencia,
                        Suministro = filaMatriculacion.cm_suministro,
                        TextoAyuda = filaMatriculacion.cm_texto_ayuda,
                        Usuario = filaMatriculacion.cm_usuario,
                        UsuarioCreacion = filaMatriculacion.cm_usuario_creacion,
                        UsuarioModificacion = filaMatriculacion.cm_usuario_modificacion,
                        NombreEmpresaRecaudacion = filaMatriculacion.cm_nombre_empresa_recaudacion
                    });
                }

                matriculaciones.Dispose();
                matriculaciones = null;

            }

            return detalles;
        }
        
        /// <summary>
        /// Permite guardar una matriculacion
        /// </summary>
        /// <param name="cabecera">Cabecera de la matriculacion</param>
        /// <param name="datosAdicionales">Datos o campos adicionales a ingresar</param>
        /// <returns></returns>
        public Respuesta GuardarMatriculacion(Matriculacion cabecera,List<DatoAdicional> datosAdicionales)
        {
            Respuesta respuesta = new Respuesta();
            
            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                contexto.pa_sat_icabmatriculacion(
                    cabecera.Ordenante, 
                    cabecera.Usuario, 
                    cabecera.Grupo, 
                    cabecera.EmpresaRecaudacion, 
                    cabecera.Convenio, 
                    cabecera.Identificador, 
                    cabecera.EtiquetaConvenio, 
                    cabecera.EtiquetaIdentificador, 
                    cabecera.EsEditable, 
                    cabecera.RegExp, 
                    cabecera.TextoAyuda, 
                    cabecera.Mascara, 
                    cabecera.Alias.ToUpper(), 
                    cabecera.Suministro, 
                    cabecera.Regional, 
                    cabecera.UsuarioCreacion, 
                    cabecera.UsuarioModificacion, 
                    cabecera.FechaModificacion, 
                    cabecera.Estado, 
                    cabecera.NombreEmpresaRecaudacion, 
                    codigoRespuesta, 
                    mensajeError);

                respuesta.CodigoRespuesta = (int)codigoRespuesta.Value;
                respuesta.MensajeError = mensajeError.Value.ToString();
                respuesta.ExitoOperacion = (respuesta.CodigoRespuesta == 0);

                if (respuesta.ExitoOperacion)
                {
                    if (datosAdicionales != null && datosAdicionales.Count() > 0)
                    {
                        // La matriculacion tiene datos adicionales que registrar

                        foreach (DatoAdicional detalle in datosAdicionales)
                        {
                            ObjectParameter codigoRespuestaDetalle = new ObjectParameter("s_codigo_respuesta", typeof(int));
                            ObjectParameter mensajeErrorDetalle = new ObjectParameter("s_mensaje_error", typeof(string));

                            contexto.pa_sat_idetmatriculacion(
                                cabecera.Ordenante,
                                cabecera.Usuario,
                                cabecera.Grupo,
                                cabecera.EmpresaRecaudacion,
                                cabecera.Convenio,
                                cabecera.Identificador,
                                cabecera.Suministro,
                                detalle.Id,
                                detalle.Etiqueta,
                                (detalle.EsEditable) ? "S" : "N",
                                detalle.Tipo,
                                detalle.ValorSeleccionado,
                                (detalle.EsVisible) ? "S" : "N",
                                detalle.Formato,
                                detalle.Mascara,
                                detalle.RegExp,
                                codigoRespuestaDetalle,
                                mensajeErrorDetalle);

                            respuesta.CodigoRespuesta = (int)codigoRespuestaDetalle.Value;
                            respuesta.MensajeError = mensajeErrorDetalle.Value.ToString();
                            respuesta.ExitoOperacion = (respuesta.CodigoRespuesta == 0);
                            
                        }
                    }
                }
                
            }
            
            return respuesta;
        }

        /// <summary>
        /// Obtiene los grupos (tipos) de recaudacion matriculados y activos para el usuario SAT indicado
        /// </summary>
        /// <param name="ordenante">Codigo de la empresa SAT</param>
        /// <param name="usuario">Codigo del usuario SAT</param>
        /// <returns>Lista de grupos (tipos) de recaudaciones matriculadas y disponibles para el usuario</returns>
        public List<TipoServicio> ObtenerGruposPorUsuarioEmpresa(int ordenante, string usuario)
        {
            List<TipoServicio> grupos = new List<TipoServicio>();

            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                var respuesta = contexto.pa_sat_cgruposxusuario(ordenante, usuario,codigoRespuesta,mensajeError);
                
                grupos = respuesta.Select(x => new TipoServicio
                {
                    Codigo = x.GRUPO,
                    Descripcion = x.DESCRIPCION
                }).ToList();

                if ((int)(codigoRespuesta.Value) > 0)
                {
                    throw new Exception(mensajeError.Value.ToString());
                }
            }

            return grupos;
        }

        /// <summary>
        /// Obtiene los datos de una matriculacion en especifico segun el identificador unico
        /// </summary>
        /// <param name="secuencia">Identificador unico de la matriculacion</param>
        /// <returns>La matriculacion existente en el sistema</returns>
        public RespuestaConsultaMatriculacion ObtenerMatriculacion(int secuencia)
        {
            RespuestaConsultaMatriculacion respuesta = new RespuestaConsultaMatriculacion
            {
                respuesta = new Respuesta()
                {
                    CodigoRespuesta = -1,
                    ExitoOperacion = false,
                    MensajeError = "Error General al Obtener Datos de Matriculacion"
                }
            };

            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                var matriculacion = contexto.pa_sat_cmatriculacion(secuencia, codigoRespuesta, mensajeError);

                pa_sat_cmatriculacion_Result matriculacionActual = null;
                
                try
                {
                    matriculacionActual= matriculacion.First();
                }
                catch (Exception) {}

                if ((int)(codigoRespuesta.Value) > 0)
                {
                    respuesta.respuesta.CodigoRespuesta = (int)(codigoRespuesta.Value);
                    respuesta.respuesta.ExitoOperacion = false;
                    respuesta.respuesta.MensajeError = mensajeError.Value.ToString();
                }
                else
                {
                    respuesta.cabecera = new Matriculacion
                    {
                        Alias = matriculacionActual.cm_alias,
                        Ordenante = matriculacionActual.cm_ordenante,
                        Usuario = matriculacionActual.cm_usuario,
                        EmpresaRecaudacion = matriculacionActual.cm_empresa_recaudacion,
                        Convenio = matriculacionActual.cm_convenio,
                        Suministro = matriculacionActual.cm_suministro,
                        EsEditable = matriculacionActual.cm_es_editable,
                        Grupo = matriculacionActual.cm_grupo,
                        Estado = matriculacionActual.cm_estado,
                        EtiquetaConvenio = matriculacionActual.cm_etiqueta_convenio,
                        EtiquetaIdentificador = matriculacionActual.cm_etiqueta_identificador,
                        Identificador = matriculacionActual.cm_identificador,
                        Mascara = matriculacionActual.cm_mascara,
                        RegExp = matriculacionActual.cm_regexp,
                        NombreEmpresaRecaudacion = matriculacionActual.cm_nombre_empresa_recaudacion,
                        Secuencia = matriculacionActual.cm_secuencia,
                        Regional = matriculacionActual.cm_regional,
                        FechaCreacion = matriculacionActual.cm_fecha_creacion,
                        FechaModificacion = matriculacionActual.cm_fecha_modificacion,
                        TextoAyuda = matriculacionActual.cm_texto_ayuda,
                        UsuarioCreacion = matriculacionActual.cm_usuario_creacion,
                        UsuarioModificacion = matriculacionActual.cm_usuario_modificacion
                    };

                    respuesta.respuesta.CodigoRespuesta = 0;
                    respuesta.respuesta.ExitoOperacion = true;
                    respuesta.respuesta.MensajeError = "TRANSACCION EXITOSA";
                }
                
                
            }

            return respuesta;
        }

        /// <summary>
        /// Permite modificar una matriculacion
        /// </summary>
        /// <param name="secuencia">El identificador de matriculacion</param>
        /// <param name="cabecera">Los datos a modificar</param>
        /// <returns>El exito o fracaso de la operacion</returns>
        public Respuesta ModificarMatriculacion(int secuencia, Matriculacion cabecera)
        {
            var respuesta = new Respuesta
            {
                CodigoRespuesta = -1,
                ExitoOperacion = false,
                MensajeError = "Error General al Modificar Matriculacion"
            };

            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                contexto.pa_sat_mcabmatriculacion(
                    secuencia,
                    cabecera.Alias.ToUpper(),
                    cabecera.Estado, 
                    cabecera.UsuarioModificacion, 
                    codigoRespuesta, 
                    mensajeError);

                respuesta.CodigoRespuesta = (int)codigoRespuesta.Value;
                respuesta.MensajeError = mensajeError.Value.ToString();
                respuesta.ExitoOperacion = (respuesta.CodigoRespuesta == 0);
                
            }

            return respuesta;
        }
    }
}
