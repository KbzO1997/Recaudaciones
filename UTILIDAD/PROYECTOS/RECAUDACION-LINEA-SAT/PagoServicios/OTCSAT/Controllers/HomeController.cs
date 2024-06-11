using log4net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using OTCSAT.Entities;
using OTCSAT.Models;
using OTCSATServices.Entities;
using OTCSATServices.Services;
using OTCSATServices.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace OTCSAT.Controllers
{
    
    /// <summary>
    /// Consulta de matriculaciones
    /// </summary>
    [Filtros.FiltroAutenticacion]
    public class HomeController : Controller
    {
        private static ILog logger = LogManager.GetLogger(typeof(HomeController));

        static readonly int REGISTROS_POR_PAGINA = 10;

        // FIXME: reemplazar por Inversion de Control
        readonly ICatalogosService servicioCatalogos = new CatalogosService();
        readonly IRecaudacionesService servicioRecaudaciones = new RecaudacionesService();
        readonly ISeguridadesService servicioSeguridades = new SeguridadesService();
        readonly IMatriculacionesService servicioMatriculaciones = new MatriculacionesService();

        /// <summary>
        /// Pagina principal de consulta de matriculaciones
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            logger.Debug("Consulta de Matriculaciones (Inicial)");

            string usuarioLogoneado = (Request.QueryString["UsuarioLogoneado"] != null && !string.IsNullOrEmpty(Request.QueryString["UsuarioLogoneado"])) ? Request.QueryString["UsuarioLogoneado"].ToUpper() : "NO_DEFINIDO";
            int empresaLogoneada = (Request.QueryString["EmpresaLogoneada"] != null && !string.IsNullOrEmpty(Request.QueryString["EmpresaLogoneada"])) ? int.Parse(Request.QueryString["EmpresaLogoneada"]) : 9999;
            string permisoAcciones = (Request.QueryString["PermisoAcciones"] != null && !string.IsNullOrEmpty(Request.QueryString["PermisoAcciones"])) ? Request.QueryString["PermisoAcciones"].ToUpper() : "C";

            var modelo = new IndexModel
            {
                //Empresa = 0,
                UsuarioCreacion = usuarioLogoneado,
                EmpresaCreacion = empresaLogoneada,
                NombreEmpresa = servicioSeguridades.ObtenerNombreEmpresa(0),
                Nemonico = servicioSeguridades.ObtenerNemonicoEmpresa(0),
                Estados = servicioCatalogos
                    .ObtenerEstados()
                    .Select(item => new SelectListItem()
                    {
                        Text = item.Descripcion,
                        Value = item.Codigo,
                        Selected = (item.Codigo.Equals("T"))
                    }),

                TiposEmpresas = servicioRecaudaciones.
                ObtenerTiposServicios(false)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),

                EmpresasRecaudacion = servicioRecaudaciones
                .ObtenerEmpresasPorTipoServicio(null,true)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),
                Convenios = new List<SelectListItem>() {},
                PermisoAcciones = permisoAcciones
            };

            return View(modelo);
        }

        /// <summary>
        /// Consulta de matriculaciones
        /// </summary>
        /// <param name="modelo"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index([Bind(Include = "Empresa,NombreEmpresa,Nemonico,Usuario,NombreUsuario,Producto,Servicio,TipoServicio,EmpresaRecaudacion,Convenio,Estado,Alias,EmpresaCreacion,UsuarioCreacion,UsuarioModificacion,IndiceInicial,ExistenMasPaginas,EsPrimeraPagina,Estados,TiposEmpresas,EmpresasRecaudacion,Convenios,Matriculaciones,Cuentas,PermisoAcciones")]IndexModel modelo)
        {
            logger.Debug("Consulta de Matriculaciones (Busqueda)");

            int siguienteIndiceConsulta = 0;
            
            modelo.TiposEmpresas = servicioRecaudaciones.
                ObtenerTiposServicios(false)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                });

            modelo.EmpresasRecaudacion = servicioRecaudaciones
                .ObtenerEmpresasPorTipoServicio(modelo.TipoServicio,true)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo,
                    Selected = (modelo.TipoServicio.Equals(item.Codigo))
                });

            if (!String.IsNullOrEmpty(modelo.Convenio))
            {
                var conveniosAsociados = servicioRecaudaciones.ObtenerDefinicionEmpresaRecaudacion(modelo.TipoServicio, modelo.EmpresaRecaudacion, true);
            
                modelo.Convenios = conveniosAsociados.Convenios.Select(item => new SelectListItem() {
                        Text = item.Etiqueta,
                        Value = item.Codigo,
                        Selected = (modelo.Convenio.Equals(item.Codigo))
                });
            }
            else
            {
                modelo.Convenios = new List<SelectListItem>() { };
            }
            
            modelo.Estados = servicioCatalogos
                .ObtenerEstados()
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo,
                    Selected = (!string.IsNullOrEmpty(modelo.Estado) && modelo.Estado.Equals(item.Codigo))
                });

            if (modelo.IndiceInicial > 0)
            {
                modelo.EsPrimeraPagina = false;
            }

            modelo.Matriculaciones = null;
            
            modelo.Matriculaciones = servicioMatriculaciones.ObtenerMatriculaciones(
                modelo.Empresa,
                (!string.IsNullOrEmpty(modelo.Nemonico) && !string.IsNullOrEmpty(modelo.Usuario))?modelo.Nemonico + modelo.Usuario:"T",
                (!string.IsNullOrEmpty(modelo.TipoServicio)) ? modelo.TipoServicio : "T",
                (modelo.EmpresaRecaudacion != null) ? int.Parse(modelo.EmpresaRecaudacion) : 0,
                (!string.IsNullOrEmpty(modelo.Convenio)) ? modelo.Convenio : "T",
                modelo.Estado,
                modelo.IndiceInicial,
                REGISTROS_POR_PAGINA);
            
            if(modelo.Matriculaciones != null && modelo.Matriculaciones.Count() > 0)
            {
                siguienteIndiceConsulta = (int)modelo.Matriculaciones.Last().Secuencia;

                IEnumerable<Matriculacion> siguienteLote = servicioMatriculaciones.ObtenerMatriculaciones(
                    modelo.Empresa,
                    (!string.IsNullOrEmpty(modelo.Nemonico) && !string.IsNullOrEmpty(modelo.Usuario)) ? modelo.Nemonico + modelo.Usuario : "T",
                    (!string.IsNullOrEmpty(modelo.TipoServicio)) ? modelo.TipoServicio : "T",
                    (modelo.EmpresaRecaudacion != null) ? int.Parse(modelo.EmpresaRecaudacion) : 0,
                    (!string.IsNullOrEmpty(modelo.Convenio))?modelo.Convenio:"T",
                    modelo.Estado,
                    siguienteIndiceConsulta,
                    REGISTROS_POR_PAGINA);
                
                if(siguienteLote!=null && siguienteLote.Count() > 0)
                {
                    modelo.ExistenMasPaginas = true;
                    modelo.IndiceInicial = siguienteIndiceConsulta;
                }
                else
                {
                    modelo.ExistenMasPaginas = false;
                }
            }
            else
            {
                modelo.ExistenMasPaginas = false;
            }

            // Limpiar estado de modelo para refrescar campos y evitar bug de paginacion
            ModelState.Clear();

            return View(modelo);
        }
        
        /// <summary>
        /// Presentacion de pantalla de nueva matriculacion
        /// </summary>
        /// <returns></returns>
        public ActionResult NuevaMatriculacion(int secuencia=0)
        {
            logger.Debug("NuevaMatriculacion secuencia: "+secuencia);

            string usuarioCreacion = (Request.QueryString["UsuarioLogoneado"] != null && !string.IsNullOrEmpty(Request.QueryString["UsuarioLogoneado"])) ? Request.QueryString["UsuarioLogoneado"].ToUpper() : "NO_DEFINIDO";
            int empresaCreacion = (Request.QueryString["EmpresaLogoneada"] != null && !string.IsNullOrEmpty(Request.QueryString["EmpresaLogoneada"])) ? int.Parse(Request.QueryString["EmpresaLogoneada"]) : 9999;
            string permisoAcciones = (Request.QueryString["PermisoAcciones"] != null && !string.IsNullOrEmpty(Request.QueryString["PermisoAcciones"])) ? Request.QueryString["PermisoAcciones"].ToUpper() : "C";
            var modelo = new IndexModel
            {
                Empresa = 0,
                NombreEmpresa = servicioSeguridades.ObtenerNombreEmpresa(0),
                Nemonico = servicioSeguridades.ObtenerNemonicoEmpresa(0),
                Estados = servicioCatalogos
                    .ObtenerEstados()
                    .Select(item => new SelectListItem()
                    {
                        Text = item.Descripcion,
                        Value = item.Codigo
                    }),

                TiposEmpresas = servicioRecaudaciones.
                ObtenerTiposServicios(false)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),
                EmpresasRecaudacion = servicioRecaudaciones
                .ObtenerEmpresasPorTipoServicio(null,true)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),
                UsuarioCreacion = usuarioCreacion,
                EmpresaCreacion = empresaCreacion,
                PermisoAcciones = permisoAcciones
            };

            if (secuencia > 0)
            {
                // Se reutiliza pantalla para modificacion
                ViewBag.Secuencia = secuencia;
            }

            return View(modelo);
        }
        
        /// <summary>
        /// Accion de guardado de matriculacion
        /// </summary>
        /// <param name="forma">Parametros dinamicos de formulario de nueva matriculacion</param>
        /// <returns>Vista con modelo</returns>
        [HttpPost]
        public ActionResult GuardarMatriculacion(FormCollection forma)
        {
            logger.Debug("GuardadoMatriculacion (Guardado)");
            
            // FormCollection porque los campos son dinamicos
            dynamic metadatosEmpresa = JObject.Parse(forma.Get("MetadataEmpresa"));
            dynamic metadatosConvenio = JObject.Parse(forma.Get("MetadataConvenio"));
            
            JToken identificador = ((JArray)metadatosConvenio.Identificadores)
                .Where(m => m.Value<string>("Codigo").Equals(forma.Get("TipoIdentificador")))
                .First();

            // Caso especial de CNT zona de discado

            var regionalActual = forma.Get("Identificador_Reg_" + forma.Get("TipoIdentificador"));
            regionalActual = (string.IsNullOrEmpty(regionalActual)) ? "" : regionalActual;
            
            var cabecera = new Matriculacion {
                Alias = forma.Get("Alias").Trim(),
                Convenio = forma.Get("Convenio").Trim(),
                EmpresaRecaudacion = int.Parse(forma.Get("EmpresaRecaudacion")),
                EsEditable = ((bool)metadatosEmpresa.EsEditable) ? "S" : "N",
                Estado = forma.Get("Estado"),
                FechaCreacion = DateTime.Now,
                FechaModificacion = null,
                Grupo = forma.Get("TipoServicio").Trim(),
                UsuarioCreacion = forma.Get("UsuarioCreacion"),
                Ordenante = int.Parse(forma.Get("Empresa")),
                UsuarioModificacion = null,
                NombreEmpresaRecaudacion = ((string)metadatosEmpresa.NombreEmpresa).ToUpper(),
                EtiquetaConvenio = metadatosConvenio.Etiqueta,
                Suministro = regionalActual + forma.Get("Identificador_"+ forma.Get("TipoIdentificador")),
                EtiquetaIdentificador = identificador["Etiqueta"].ToString(),
                Identificador = forma.Get("TipoIdentificador"),
                Usuario = forma.Get("Nemonico").ToUpper() + forma.Get("Usuario").Trim().ToUpper(),
                Mascara = identificador["Mascara"].ToString(),
                RegExp = identificador["RegExp"].ToString(),
                TextoAyuda = identificador["TextoAyuda"].ToString(),
                Regional = regionalActual
            };

            List<DatoAdicional> datosAdicionales = new List<DatoAdicional>();

            Respuesta respuestaGuardado = servicioMatriculaciones.GuardarMatriculacion(cabecera, datosAdicionales);

            logger.Debug("Resultado de Matriculacion: "+respuestaGuardado.CodigoRespuesta + " - " + respuestaGuardado.MensajeError);

            // Registro de auditoria
            Task.Run(() => servicioSeguridades.RegistrarAuditoria(9999,cabecera.UsuarioCreacion,102,10220,"ING",$"[ING] Ordenante: {cabecera.Ordenante} Matriculacion de Servicio Grupo: {cabecera.Grupo} Empresa: {cabecera.NombreEmpresaRecaudacion} Suministro: {cabecera.Suministro}"));

            ConfirmacionMatriculacionModel modelo = new ConfirmacionMatriculacionModel{
                Alias = cabecera.Alias,
                Convenio = cabecera.EtiquetaConvenio,
                EmpresaRecaudacion = cabecera.NombreEmpresaRecaudacion,
                Estado = (cabecera.Estado.Equals("A"))?"Activo":"Inactivo",
                EtiquetaIdentificador = cabecera.EtiquetaIdentificador,
                Suministro = cabecera.Suministro,
                TipoRecaudacion = cabecera.Grupo,
                Usuario = cabecera.Usuario,
                Respuesta = respuestaGuardado,
                UsuarioModificacion = forma.Get("UsuarioCreacion"),
                PermisoAcciones = forma.Get("PermisoAcciones")
            };

            return View(modelo);
        }

        /// <summary>
        /// Permite cargar una matriculacion para modificacion
        /// </summary>
        /// <param name="secuencia">Identificador unico de matriculacion</param>
        /// <returns></returns>
        public ActionResult ModificarMatriculacion(int secuencia)
        {
            ViewBag.EsModificacionConfirmada = false;

            string usuarioModificacion = (Request.QueryString["UsuarioLogoneado"] != null && !string.IsNullOrEmpty(Request.QueryString["UsuarioLogoneado"])) ? Request.QueryString["UsuarioLogoneado"] : "";
            string permisoAcciones = (Request.QueryString["PermisoAcciones"] != null && !string.IsNullOrEmpty(Request.QueryString["PermisoAcciones"])) ? Request.QueryString["PermisoAcciones"] : "C";

            var matriculacion = servicioMatriculaciones.ObtenerMatriculacion(secuencia);

            var modelo = new ConfirmacionMatriculacionModel
            {
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = -1,
                    ExitoOperacion = false,
                    MensajeError = "ERROR GENERAL AL CARGAR MATRICULACION"
                }
            };

            if (matriculacion.respuesta.ExitoOperacion)
            {
                modelo.Alias = matriculacion.cabecera.Alias;
                modelo.Convenio = matriculacion.cabecera.Convenio;
                modelo.EmpresaRecaudacion = matriculacion.cabecera.EmpresaRecaudacion.ToString();
                modelo.Estado = matriculacion.cabecera.Estado;
                modelo.Ordenante = matriculacion.cabecera.Ordenante.ToString();
                modelo.TipoRecaudacion = matriculacion.cabecera.Grupo;
                modelo.Suministro = matriculacion.cabecera.Suministro;
                modelo.NombreEmpresaRecaudacion = matriculacion.cabecera.NombreEmpresaRecaudacion;
                modelo.EtiquetaIdentificador = matriculacion.cabecera.EtiquetaIdentificador;
                modelo.NombreConvenio = matriculacion.cabecera.EtiquetaConvenio;
                modelo.Usuario = matriculacion.cabecera.Usuario;
                modelo.Nemonico = matriculacion.cabecera.Usuario.Substring(0,5);

                modelo.NombreOrdenante = servicioSeguridades.ObtenerNombreEmpresa(matriculacion.cabecera.Ordenante);
                var datosUsuario = servicioSeguridades.ObtenerDatosUsuario(matriculacion.cabecera.Ordenante,modelo.Nemonico,matriculacion.cabecera.Usuario.Substring(5));

                modelo.NombreUsuario = datosUsuario.Nombres.Trim();

                modelo.UsuarioModificacion = usuarioModificacion;

                modelo.Respuesta.CodigoRespuesta = 0;
                modelo.Respuesta.ExitoOperacion = true;
                modelo.Respuesta.MensajeError = "TRANSACCION EXITOSA";
                
            }
            else
            {
                modelo.Respuesta.ExitoOperacion = false;
                modelo.Respuesta.MensajeError = matriculacion.respuesta.MensajeError;
                modelo.Respuesta.CodigoRespuesta = matriculacion.respuesta.CodigoRespuesta;
            }
            modelo.PermisoAcciones = permisoAcciones;

            return View(modelo);
        }

        /// <summary>
        /// Permite modificar una matriculacion
        /// </summary>
        /// <param name="modeloInicial">Model Inicial</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ModificarMatriculacion([Bind(Include = "Respuesta,Ordenante,Usuario,NombreUsuario,NombreOrdenante,Nemonico,TipoRecaudacion,EmpresaRecaudacion,NombreEmpresaRecaudacion,Convenio,NombreConvenio,EtiquetaIdentificador,Suministro,Alias,Estado,Secuencia,UsuarioModificacion,PermisoAcciones")]ConfirmacionMatriculacionModel modeloInicial)
        {
            ViewBag.EsModificacionConfirmada = true;

            var respuestaConsulta = servicioMatriculaciones.ObtenerMatriculacion(modeloInicial.Secuencia);

            if(respuestaConsulta!=null && respuestaConsulta.respuesta.ExitoOperacion)
            {
                respuestaConsulta.cabecera.Alias = modeloInicial.Alias;
                respuestaConsulta.cabecera.Estado = modeloInicial.Estado;
                respuestaConsulta.cabecera.UsuarioModificacion = modeloInicial.UsuarioModificacion;
                respuestaConsulta.cabecera.FechaModificacion = DateTime.Now;
            }
            
            var respuestaModificacion = servicioMatriculaciones.ModificarMatriculacion(modeloInicial.Secuencia, respuestaConsulta.cabecera);

            // Registro de auditoria
            Task.Run(() => servicioSeguridades.RegistrarAuditoria(9999,modeloInicial.UsuarioModificacion, 102, 10220, "MOD", $"[MODIF] Matriculacion de Servicio Ordenante: {respuestaConsulta.cabecera.Ordenante} Grupo: {respuestaConsulta.cabecera.Grupo} Empresa: {modeloInicial.NombreEmpresaRecaudacion} Suministro: {modeloInicial.Suministro}"));

            ConfirmacionMatriculacionModel modelo = new ConfirmacionMatriculacionModel
            {
                Alias = modeloInicial.Alias,
                Convenio = respuestaConsulta.cabecera.EtiquetaConvenio,
                EmpresaRecaudacion = respuestaConsulta.cabecera.NombreEmpresaRecaudacion,
                Estado = (modeloInicial.Estado.Equals("A")) ? "Activo" : "Inactivo",
                EtiquetaIdentificador = respuestaConsulta.cabecera.EtiquetaIdentificador,
                Suministro = respuestaConsulta.cabecera.Suministro,
                TipoRecaudacion = respuestaConsulta.cabecera.Grupo,
                Nemonico = modeloInicial.Nemonico,
                Usuario = modeloInicial.Usuario,
                Respuesta = respuestaModificacion,
                UsuarioModificacion = modeloInicial.UsuarioModificacion,
                PermisoAcciones = modeloInicial.PermisoAcciones
            };

            return View(modelo);
        }

        /// <summary>
        /// Estado inicial de pantalla de busqueda de empresa
        /// </summary>
        /// <returns></returns>
        public ActionResult BusquedaEmpresa()
        {
            return View(new BusquedaEmpresaModel());
        }

        /// <summary>
        /// Estado de consulta de pantalla de busqueda de empresa
        /// </summary>
        /// <param name="Nombre">El nombre parcial de la empresa</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult BusquedaEmpresa(string Nombre="")
        {
            List<Empresa> empresas = servicioCatalogos.ObtenerEmpresasPorNombre(Nombre);

            var modelo = new BusquedaEmpresaModel
            {
                Nombre = Nombre,
                Empresas = empresas
            };

            return View(modelo);
        }

        /// <summary>
        /// Accion disparada mediante redirect, muestra alerta en caso de error
        /// </summary>
        /// <returns></returns>
        public ActionResult Mensaje()
        {

            // Proviene de TempData cuando se realiza un forward desde controlador, querystring si viene de consulta de servicio no matriculado
            ViewBag.Titulo = (TempData["TituloMensaje"]!=null && !string.IsNullOrEmpty(TempData["TituloMensaje"].ToString()))?TempData["TituloMensaje"]:Request.QueryString["TituloMensaje"];
            ViewBag.Mensaje = (TempData["MensajeError"] != null && !string.IsNullOrEmpty(TempData["MensajeError"].ToString())) ? TempData["MensajeError"] : Request.QueryString["MensajeError"];

            return View();
        }

        #region ServiciosREST

        /// <summary>
        /// Servicio de consulta de empresas de servicio por tipo de recaudacion
        /// </summary>
        /// <param name="tipo">El tipo de servicio-recaudacion asociado a las empresas</param>
        /// <returns></returns>
        public JsonResult ObtenerEmpresasRecaudacion(string tipo)
        {
            return Json(new SelectList(servicioRecaudaciones.ObtenerEmpresasPorTipoServicio(tipo,true), "codigo", "descripcion"));
        }

        /// <summary>
        /// Servicio de consulta de empresas de servicio por tipo de recaudacion no matriculables
        /// </summary>
        /// <param name="tipo">El tipo de servicio-recaudacion asociado a las empresas (no matriculables)</param>
        /// <returns></returns>
        public JsonResult ObtenerEmpresasRecaudacionNoMatriculables(string tipo)
        {
            return Json(new SelectList(servicioRecaudaciones.ObtenerEmpresasPorTipoServicioNoMatriculables(tipo), "codigo", "descripcion"));
        }

        /// <summary>
        /// Determina el nombre de la empresa definida
        /// </summary>
        /// <param name="empresa">El codigo SAT de la empresa</param>
        /// <returns></returns>
        public JsonResult ObtenerNombreEmpresa(int empresa)
        {
            return Json(servicioSeguridades.ObtenerNombreEmpresa(empresa));
        }

        /// <summary>
        /// Obtiene el nemonico asociado a la empresa definida
        /// </summary>
        /// <param name="empresa">El codigo SAT de la empresa</param>
        /// <returns></returns>
        public JsonResult ObtenerNemonicoEmpresa(int empresa)
        {
            return Json(servicioSeguridades.ObtenerNemonicoEmpresa(empresa));
        }

        /// <summary>
        /// Obtiene el nombre del usuario por nemonico empresa
        /// </summary>
        /// <param name="empresa">El codigo SAT de la empresa</param>
        /// <param name="nemonico">El nemonico de empresa</param>
        /// <param name="usuario">El alias del usuario (sin la parte del nemonico)</param>
        /// <returns>El nombre del usuario</returns>
        public JsonResult ObtenerNombreUsuario(int empresa,string nemonico,string usuario)
        {
            Usuario datosUsuario = servicioSeguridades.ObtenerDatosUsuario(empresa, nemonico, usuario);
            return Json(datosUsuario.Nombres);
        }

        /// <summary>
        /// Obtiene los convenios disponibles por empresa de recaudacion
        /// </summary>
        /// <param name="grupo">El grupo de la empresa de recaudacion</param>
        /// <param name="empresa">El codigo de la empresa de recaudacion</param>
        /// <param name="mostrarMatriculables">Determina si se muestran los convenios matriculables o no matriculables de la empresa</param>
        /// <returns></returns>
        public JsonResult ObtenerConveniosEmpresaRecaudacion(string grupo,int empresa,bool mostrarMatriculables)
        {
            DefinicionEmpresa definicion = servicioRecaudaciones.ObtenerDefinicionEmpresaRecaudacion(grupo, empresa.ToString(),mostrarMatriculables);
            return Json(definicion);
        }
        
        /// <summary>
        /// Obtiene un listado de empresas por nombre
        /// </summary>
        /// <param name="nombre">El nombre completo o incompleto de la empresa a buscar</param>
        /// <returns>La lista de empresas existentes que cumplen el criterio</returns>
        public JsonResult ObtenerEmpresasPorNombre(string nombre)
        {
            List<Empresa> empresas = servicioCatalogos.ObtenerEmpresasPorNombre(nombre);
            return Json(empresas);
        }

        /// <summary>
        /// Obtiene una matriculacion existente para consulta
        /// </summary>
        /// <param name="secuencia">El identificador de la matriculacion</param>
        /// <returns>La matriculacion existente o el error en caso de no existir</returns>
        public JsonResult ObtenerDatosMatriculacion(int secuencia)
        {
            var respuesta = servicioMatriculaciones.ObtenerMatriculacion(secuencia);

            if (respuesta.respuesta.ExitoOperacion)
            {
                // Datos adicionales no guardados en la matriculacion directamente
                respuesta.cabecera.NombreOrdenante = servicioSeguridades.ObtenerNombreEmpresa(respuesta.cabecera.Ordenante).Trim();

                var usuario = servicioSeguridades.ObtenerDatosUsuario(
                    respuesta.cabecera.Ordenante, 
                    respuesta.cabecera.Usuario.Substring(0, 5), 
                    respuesta.cabecera.Usuario.Substring(5));

                respuesta.cabecera.NombreUsuario = usuario.Nombres.Trim();
                respuesta.cabecera.NemonicoOrdenante = respuesta.cabecera.Usuario.Substring(0, 5);
            }
            
            return Json(respuesta);
        }

        #endregion ServiciosREST
    }
}