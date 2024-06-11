using log4net;
using OTCSAT.Entities;
using OTCSAT.Models;
using OTCSATServices.Entities;
using OTCSATServices.Services;
using OTCSATServices.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OTCSAT.Controllers
{
    [Filtros.FiltroAutenticacion]
    public class PagoController : Controller
    {
        private static ILog logger = LogManager.GetLogger(typeof(PagoController));

        // FIXME Reemplazar por IoC
        readonly IMatriculacionesService servicioMatriculaciones = new MatriculacionesService();
        readonly IRecaudacionesService servicioRecaudaciones = new RecaudacionesService();
        readonly ICatalogosService servicioCatalogos = new CatalogosService();
        readonly ISeguridadesService servicioSeguridades = new SeguridadesService();

        // GET: Pago
        public ActionResult Index(int ordenante = 0, string usuario = "", string grupo = "")
        {
            logger.Debug("Consolidada de Matriculaciones (Inicial)");

            List<TipoServicio> grupos = new List<TipoServicio>();

            try
            {
                grupos = servicioMatriculaciones.ObtenerGruposPorUsuarioEmpresa(ordenante, usuario);
                ViewBag.ExistenMatriculaciones = true;
            } catch (Exception ex)
            {
                logger.Error(ex);

                ViewBag.ExistenMatriculaciones = false;
                ViewBag.MensajeError = ex.Message;

                // En redireccion no usar ViewBag
                TempData["TituloMensaje"] = "Por favor revise el siguiente mensaje:";
                TempData["MensajeError"] = ex.Message;

                return RedirectToAction("Mensaje", "Home");
            }

            PagoModel modelo = new PagoModel()
            {
                Usuario = usuario,
                Ordenante = ordenante,
                Grupos = grupos.ToList()
            };

            return View(modelo);
        }
        
        /// <summary>
        /// Accion de consulta de comprobante existente
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante</param>
        /// <param name="nombreOrdenante">El nombre del ordenante</param>
        /// <param name="usuario"></param>
        /// <param name="ordenBanco"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Consultar(int ordenante=0,string nombreOrdenante="",string usuario="",long ordenBanco = 0)
        {
            
            var modelo = new ConsultaComprobanteModel
            {
                Usuario = usuario,
                Ordenante = ordenante,
                NombreOrdenante = servicioSeguridades.ObtenerNombreEmpresa(ordenante)
            };

            modelo.Comprobante = servicioRecaudaciones.ObtenerDetallesComprobante(ordenBanco);

            return View(modelo);
        }

        /// <summary>
        /// Punto de entrada inicial de un pago no matriculado
        /// </summary>
        /// <param name="Ordenante">La empresa logoneada</param>
        /// <param name="Usuario">El usuario logoneado</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult NoMatriculado(int Ordenante=0,string Usuario = "")
        {
            
            var modelo = new IndexModel
            {
                Empresa = Ordenante,
                NombreEmpresa = servicioSeguridades.ObtenerNombreEmpresa(Ordenante),
                Nemonico = servicioSeguridades.ObtenerNemonicoEmpresa(Ordenante),
                Estados = servicioCatalogos
                    .ObtenerEstados()
                    .Select(item => new SelectListItem()
                    {
                        Text = item.Descripcion,
                        Value = item.Codigo
                    }),

                TiposEmpresas = servicioRecaudaciones.
                ObtenerTiposServiciosNoMatriculables()
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),
                EmpresasRecaudacion = servicioRecaudaciones
                .ObtenerEmpresasPorTipoServicioNoMatriculables(null)
                .Select(item => new SelectListItem()
                {
                    Text = item.Descripcion,
                    Value = item.Codigo
                }),
                UsuarioCreacion = Usuario,
                EmpresaCreacion = Ordenante,
                Estado = "A",
                Cuentas = servicioCatalogos.
                    ObtenerCuentasPorEmpresaUsuario(Ordenante,Usuario).
                    Select(item=>new SelectListItem() {
                        Text = $"{item.Codigo.Substring(0, 3) + String.Empty.PadRight(4, 'X') + item.Codigo.Substring(7)} - {item.Nombre} - {item.Tipo}",
                        Value = $"{item.Tipo}@{item.Codigo}"
                    })
            };

            return View(modelo);
        }
        
        #region Servicios

        /// <summary>
        /// Obtiene los grupos existentes por usuario empresa
        /// </summary>
        /// <param name="ordenante"></param>
        /// <param name="usuario"></param>
        /// <returns></returns>
        public JsonResult ObtenerGruposPorUsuarioEmpresa(int ordenante=0,string usuario = "")
        {
            List<TipoServicio> grupos = new List<TipoServicio>();

            try
            {
                grupos = servicioMatriculaciones.ObtenerGruposPorUsuarioEmpresa(ordenante, usuario);
            }
            catch (Exception ex)
            {
                logger.Error(ex);
                ViewBag.MensajeError = ex.Message;
            }

            return Json(grupos);
        }

        /// <summary>
        /// Muestra el detalle de las matriculaciones por grupo usuario
        /// </summary>
        /// <param name="ordenante">Codigo del ordenante SAT</param>
        /// <param name="usuario">Alias de usuario SAT</param>
        /// <param name="grupo">Codigo de grupo a consultar</param>
        /// <returns>La lista de matriculaciones existentes por grupo indicado</returns>
        public JsonResult ObtenerMatriculacionesPorGrupoUsuario(int ordenante,string usuario,string grupo)
        {
            List<Matriculacion> matriculaciones = servicioMatriculaciones.ObtenerMatriculaciones(ordenante, usuario, grupo, 0,"T", "A", 0, 100).ToList<Matriculacion>();

            return Json(matriculaciones);
        }

        /// <summary>
        /// Obtiene un listado de cuentas por empresa para recaudacion de servicios
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante</param>
        /// <returns>La lista de cuentas disponibles por servicio empresa</returns>
        public JsonResult ObtenerCuentasPorEmpresa(int ordenante)
        {
            List<Cuenta> cuentas = servicioCatalogos.ObtenerCuentasPorServicioEmpresa(ordenante, "PAGSERV");
            return Json(cuentas);
        }

        /// <summary>
        /// Obtiene un listado de cuentas por empresa usuario para recaudacion de servicios
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante</param>
        /// <param name="usuario">El alias del usuario SAT</param>
        /// <returns>La lista de cuentas disponibles por empresa usuario</returns>
        public JsonResult ObtenerCuentasPorEmpresaUsuario(int ordenante,string usuario)
        {
            List<Cuenta> cuentas = servicioCatalogos.ObtenerCuentasPorEmpresaUsuario(ordenante, usuario);
            return Json(cuentas);
        }

        /// <summary>
        /// Permite consultar la deuda actual del cliente
        /// </summary>
        /// <param name="ordenante">Codigo de empresa SAT</param>
        /// <param name="usuario">Alias de usuario SAT</param>
        /// <param name="grupo">Codigo de grupo (AGUA, LUZ, TELEFONIA_FIJA, etc)</param>
        /// <param name="empresaRecaudacion">Codigo de empresa de recaudacion</param>
        /// <param name="convenio">Codigo de convenio</param>
        /// <param name="tipoIdentificador">Codigo de identificador</param>
        /// <param name="suministro">Suministro a consultar</param>
        /// <param name="datosAdicionales">Datos adicionales provenientes de la metadata de convenio</param>
        /// <returns>Los datos de consulta asociados a la recaudacion indicada</returns>
        public JsonResult ConsultarDeudaActual(int ordenante,string usuario,string grupo,string empresaRecaudacion,string convenio,string tipoIdentificador,string suministro,DatoAdicional[] datosAdicionales)
        {
            
            // Agregar validacion previa de verificacion de datos de matriculacion para impedir la tiendita de barrio
            RespuestaConsultaDeuda respuesta = servicioRecaudaciones.ConsultarDeuda(ordenante, usuario, grupo, empresaRecaudacion, convenio, tipoIdentificador, suministro,datosAdicionales);
            
            return Json(respuesta);
        }

        /// <summary>
        /// Permite consultar una tarifa por empresa de recaudacion y ordenante
        /// </summary>
        /// <param name="ordenante">Codigo del ordenante</param>
        /// <param name="grupo">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA,etc...)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion</param>
        /// <param name="convenio">El codigo del convenio asociado a la empresa de recaudacion</param>
        /// <param name="monto">El monto de pago ingresado por el cliente</param>
        /// <param name="tipoCuenta">El tipo de cuenta (AHO,CTE,BAS,etc)</param>
        /// <param name="cuenta">El codigo de la cuenta en Bolivariano</param>
        /// <returns>Los datos de respuesta de la consulta de tarifas</returns>
        public JsonResult ObtenerTarifa(int ordenante, string grupo, string empresaRecaudacion, string convenio, double monto, string tipoCuenta, string cuenta)
        {
            var datosEmpresa = servicioSeguridades.ObtenerDatosOrdenante(ordenante);
            string identificacionEmpresa = (datosEmpresa != null) ? datosEmpresa.Identificacion : "";

            var respuesta = servicioRecaudaciones.ObtenerTarifa(ordenante, grupo, empresaRecaudacion, convenio, monto, identificacionEmpresa, tipoCuenta, cuenta);
            return Json(respuesta);
        }

        #endregion
    }
}