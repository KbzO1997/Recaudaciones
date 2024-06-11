using log4net;
using Newtonsoft.Json.Linq;
using OTCSAT.Models;
using OTCSATServices.Entities;
using OTCSATServices.Services;
using OTCSATServices.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace OTCSAT.Controllers
{
    [Filtros.FiltroAutenticacion]
    public class SeguridadesController : Controller
    {
        private static ILog logger = LogManager.GetLogger(typeof(SeguridadesController));

        readonly IRecaudacionesService servicioRecaudaciones = new RecaudacionesService();
        readonly ISeguridadesService servicioSeguridades = new SeguridadesService();
        readonly ICatalogosService servicioCatalogos = new CatalogosService();
        readonly INotificacionesService servicioNotificaciones = new NotificacionesService();

        // GET: Seguridades
        [HttpGet]
        public ActionResult Index(SeguridadesModel modelo)
        {
            var tipoDispositivo = servicioSeguridades.ObtenerTipoDispositivo(modelo.Ordenante, modelo.Usuario);
            modelo.TipoDispositivo = tipoDispositivo.Tipo;

            logger.Debug($"Tipo de dispositivo {modelo.TipoDispositivo} usuario {modelo.Usuario} ");

            return View(modelo);
        }
        
        [HttpPost]
        public ActionResult ConfirmarPago(SeguridadesModel modelo)
        {
            var respuestaEntrust = servicioSeguridades.ValidarToken(modelo.Ordenante, modelo.Usuario, modelo.Token);

            logger.Debug(String.Format("Validacion de Token ordenante: {0} usuario: {1} token: {2}", modelo.Ordenante, modelo.Usuario, modelo.Token));
            logger.Debug(String.Format("Respuesta Token: {0} - {1} ", respuestaEntrust.ExitoOperacion,respuestaEntrust.CodigoRespuesta));

            // Registro de auditoria token
            Task.Run(() => servicioSeguridades.RegistrarAuditoria(modelo.Ordenante, modelo.Usuario, 1004, 100401, "TKN", $"TOKENRO Token: {modelo.Token} Resp: {respuestaEntrust.MensajeError}"));

            if (respuestaEntrust.ExitoOperacion)
            {
                modelo.EsTokenValido = true;
                modelo.MensajeError = "TOKEN OK";

                // Recrear entradas necesarias para el pago real
                
                modelo.Cliente = (string.IsNullOrEmpty(modelo.Cliente))?servicioSeguridades.ObtenerNombreEmpresa(modelo.Ordenante):modelo.Cliente;

                var entradaPago = new OTCSATServices.Entities.Pago
                {
                    Cliente = modelo.Cliente,
                    Comprobante = new OTCSATServices.Entities.Comprobante
                    {
                        Usuario = modelo.Usuario.ToUpper(),
                        Comision = modelo.Comision,
                        Convenio = modelo.Convenio,
                        Cuenta = modelo.Cuenta,
                        TipoCuenta = modelo.TipoCuenta,
                        EmpresaRecaudacion = modelo.EmpresaRecaudacion,
                        Grupo = modelo.Grupo,
                        Monto = modelo.Monto,
                        NombreEmpresaRecaudacion = modelo.NombreEmpresaRecaudacion,
                        NombreConvenio = modelo.NombreConvenio,
                        Ordenante = modelo.Ordenante,
                        Referencia = modelo.Referencia,
                        Suministro = modelo.Suministro,
                        CodigoError = 0,
                        Estado = "P",
                        Alias = modelo.Alias,
                        EtiquetaIdentificador = modelo.EtiquetaIdentificador,
                        Abonado = modelo.Cliente
                    },
                    CodigoIdentificador = modelo.TipoIdentificador,
                    DatosAdicionales = new List<OTCSATServices.Entities.DatoAdicional>(),
                    Recibos = new List<OTCSATServices.Entities.Recibo>(),
                    EntradasAdicionales = new List<OTCSATServices.Entities.DatoAdicional>()
                };

                // no se esta usando modelo.Configuracion
                //var configuracion = JObject.Parse(modelo.Configuracion);
                var deuda = JObject.Parse(modelo.Deuda);

                // FIXME Validar montos en base a metadata
                // configuracion.GetValue("alias").ToString();

                // Obtener campos adicionales e incluirlos en el pago

                // Campos arbitrarios 
                //string oficina = Request.Form["Adicional_ofi_entrega"];
                
                // Datos adicionales
                if (deuda != null && deuda["DatosAdicionales"] != null && deuda["DatosAdicionales"].Count()>0)
                {
                    JArray datosAdicionalesDefinidos = (JArray)deuda["DatosAdicionales"];

                    foreach(var detalleDefinido in datosAdicionalesDefinidos)
                    {

                        string valorSeleccionadoActual = Request.Form["Adicional_" + detalleDefinido.SelectToken("Id").ToString()];

                        if(valorSeleccionadoActual==null || String.IsNullOrEmpty(valorSeleccionadoActual))
                        {
                            // En caso de no tratarse de un campo dinamico editable, tomar valor de metadefinicion en consulta (caso CNEL)
                            valorSeleccionadoActual = detalleDefinido.SelectToken("ValorSeleccionado").ToString();
                        }

                        entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional
                        {
                            Id = detalleDefinido.SelectToken("Id").ToString(),
                            EsVisible = bool.Parse(detalleDefinido.SelectToken("EsVisible").ToString()),
                            Etiqueta = detalleDefinido.SelectToken("Etiqueta").ToString(),
                            ValorSeleccionado = valorSeleccionadoActual
                        });
                    }
                }

                if (modelo.EntradasAdicionalesJSON != null && !string.IsNullOrEmpty(modelo.EntradasAdicionalesJSON))
                {
                    try
                    {
                        JArray entradasAdicionales = JArray.Parse(modelo.EntradasAdicionalesJSON);

                        foreach(var datoEntrada in entradasAdicionales)
                        {
                            entradaPago.EntradasAdicionales.Add(new OTCSATServices.Entities.DatoAdicional{
                                Id = datoEntrada.SelectToken("nombre").ToString().Split('_')[1],
                                ValorSeleccionado = datoEntrada.SelectToken("valor").ToString()
                            });
                        }
                    }
                    catch (Exception) { }
                }

                // Agregar campos adicionales quemados para el caso especial de SRI - Otras formas de pago
                // Gracias OTC >:(
                /*
                if(modelo.EmpresaRecaudacion==1114 && modelo.Convenio.Equals("8368"))
                {
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional{Id = "s_date",EsVisible = false,Etiqueta = "s_date",ValorSeleccionado = DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss.fffK")});
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_srv", EsVisible = false, Etiqueta = "s_srv", ValorSeleccionado = "BOLIVSRV" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_lsrv", EsVisible = false, Etiqueta = "s_lsrv", ValorSeleccionado = "BOLIVSRV" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_org_err", EsVisible = false, Etiqueta = "s_org_err", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_org", EsVisible = false, Etiqueta = "s_org", ValorSeleccionado = "U" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_error", EsVisible = false, Etiqueta = "s_error", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_sev", EsVisible = false, Etiqueta = "s_sev", ValorSeleccionado = "0" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "s_msg", EsVisible = false, Etiqueta = "s_msg", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "t_debug", EsVisible = false, Etiqueta = "t_debug", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "t_file", EsVisible = false, Etiqueta = "t_file", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "t_from", EsVisible = false, Etiqueta = "t_from", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "t_trn", EsVisible = false, Etiqueta = "t_trn", ValorSeleccionado = "" });
                    entradaPago.DatosAdicionales.Add(new OTCSATServices.Entities.DatoAdicional { Id = "o_msj_error", EsVisible = false, Etiqueta = "o_msj_error", ValorSeleccionado = "" });
                }
                */

                // Recibos
                if (deuda != null && deuda["Recibos"] != null && deuda["Recibos"].Count()>0)
                {
                    // FIXME esto no debe ser un solo recibo, cambiar desde la pantalla para que aca llegue una lista
                    List<DatoAdicional> datosReciboAdicional = new List<DatoAdicional>();
                    var elementosRecibo = Request.Form["Recibo"].Split('|');
                    
                    if (elementosRecibo[7] != null)
                    {
                        JArray listReciboAdicional = JArray.Parse(elementosRecibo[7]);
                        foreach (var datos in listReciboAdicional) {
                            datosReciboAdicional.Add(new DatoAdicional { 
                                Id = datos.SelectToken("Id").ToString(),
                                ValorSeleccionado = datos.SelectToken("ValorSeleccionado").ToString(),
                                EsVisible = (bool) datos.SelectToken("EsVisible")
                            });
                        }
                    }
                    
                    entradaPago.Recibos.Add(new OTCSATServices.Entities.Recibo {
                        Concepto = elementosRecibo[0],
                        Fecha = elementosRecibo[1],
                        Impuesto = elementosRecibo[2],
                        Referencia = elementosRecibo[3],
                        Secuencia = elementosRecibo[4],
                        TotalAPagar = double.Parse(elementosRecibo[5]),
                        Cuota = elementosRecibo[6],
                        DatoAdicional = datosReciboAdicional
                    });
                }
                
                // Intentar actualizar cupos
                // Cristel indica que la validacion de cupos es sin considerar la comision, es decir se envia solo monto de pago
                var respuestaConsultaCupos = servicioCatalogos.ActualizarCupoServicio(
                    modelo.Ordenante, 
                    modelo.Usuario, 
                    (modelo.TipoCuenta == 3) ? "CTE" : "AHO", 
                    modelo.Cuenta, 
                    modelo.Grupo, 
                    modelo.EmpresaRecaudacion, 
                    modelo.Convenio, 
                    modelo.Monto, 
                    0,
                    "S"
                );

                logger.Debug(String.Format("Validacion Cupos exitoOperacion: {0} codigoError: {1} mensajeError: {2}",respuestaConsultaCupos.ExitoOperacion, respuestaConsultaCupos.CodigoRespuesta,respuestaConsultaCupos.MensajeError));

                if (respuestaConsultaCupos.ExitoOperacion)
                {
                    var respuestaPago = servicioRecaudaciones.Pagar(entradaPago);

                    logger.Debug(String.Format("Respuesta Pago Compuesto: exitoOperacion: {0} codigoError: {1} mensajeError: {2} ",respuestaPago.Respuesta.ExitoOperacion,respuestaPago.Respuesta.CodigoRespuesta,respuestaPago.Respuesta.MensajeError));

                    if (respuestaPago.Respuesta.ExitoOperacion)
                    {
                        logger.Debug(String.Format("Orden Generada: {0} OrdenBanco: {1}", respuestaPago.OrdenEmpresa,respuestaPago.OrdenBanco));
                        
                        modelo.MensajeError = "PAGO DE SERVICIO EXITOSO - COMPROBANTE # "+respuestaPago.OrdenEmpresa;
                        modelo.EsPagoExitoso = true;
                        modelo.EsTokenValido = true;
                        modelo.OrdenBanco = respuestaPago.OrdenBanco.ToString();

                        var respuestaConsultaCuposReg = servicioCatalogos.ActualizarCupoServicio(
                           modelo.Ordenante,
                           modelo.Usuario,
                           (modelo.TipoCuenta == 3) ? "CTE" : "AHO",
                           modelo.Cuenta,
                           modelo.Grupo,
                           modelo.EmpresaRecaudacion,
                           modelo.Convenio,
                           modelo.Monto,
                           0,
                           "N"
                        );

                        if (respuestaConsultaCuposReg.ExitoOperacion)
                        {

                            // Envio de notificacion de Avisos24
                            Task.Run(() => servicioNotificaciones.EnviarNotificacionPagoServicio(
                                entradaPago.Comprobante,
                                respuestaPago.OrdenEmpresa
                            ));

                            // Registro de auditoria
                            Task.Run(() => servicioSeguridades.RegistrarAuditoria(
                                modelo.Ordenante,
                                modelo.Usuario, 
                                1004,
                                100401, 
                                "PAG",
                                $"[OK] Pago de Servicio: Ordenante: {modelo.Ordenante} Servicio: {modelo.Grupo} Monto Pago: {modelo.Monto} Comision: {modelo.Comision} Fch. Venc: {modelo.FechaVencimiento} Orden: {respuestaPago.OrdenEmpresa} Empresa Rec: {modelo.NombreEmpresaRecaudacion} Suministro: {modelo.Suministro} Cuenta: {modelo.Cuenta.Substring(0, 3) + String.Empty.PadRight(4, 'X') + modelo.Cuenta.Substring(7)}")
                            );
                        }
                        else
                        {
                            //REF1
                            modelo.EsPagoExitoso = false;
                            modelo.EsTokenValido = false;
                            modelo.MensajeError = respuestaConsultaCuposReg.MensajeError;
                            // Registro de auditoria - error al registrar cupo 
                            Task.Run(() => servicioSeguridades.RegistrarAuditoria(
                                modelo.Ordenante,
                                modelo.Usuario,
                                1004,
                                100401,
                                "PAG",
                                $"[FAIL] Pago Fallido Servicio-Cupo: Ordenante: {modelo.Ordenante} Servicio: {modelo.Grupo} Monto Pago: {modelo.Monto} Comision: {modelo.Comision} Fch. Venc: {modelo.FechaVencimiento} Orden: {respuestaPago.OrdenEmpresa} Empresa Rec: {modelo.NombreEmpresaRecaudacion} Suministro: {modelo.Suministro}  Cuenta: {modelo.Cuenta.Substring(0, 3) + String.Empty.PadRight(4, 'X') + modelo.Cuenta.Substring(7)} Error: {respuestaPago.Respuesta.MensajeError}")
                            );
                        }
                    }
                    else
                    {
                        modelo.EsPagoExitoso = false;
                        modelo.EsTokenValido = true;
                        modelo.MensajeError = respuestaPago.Respuesta.MensajeError;

                        // Registro de auditoria
                        Task.Run(() => servicioSeguridades.RegistrarAuditoria(
                            modelo.Ordenante, 
                            modelo.Usuario, 
                            1004, 
                            100401, 
                            "PAG",
                            $"[FAIL] Pago Fallido Servicio: Ordenante: {modelo.Ordenante} Servicio: {modelo.Grupo} Monto Pago: {modelo.Monto} Comision: {modelo.Comision} Fch. Venc: {modelo.FechaVencimiento} Orden: {respuestaPago.OrdenEmpresa} Empresa Rec: {modelo.NombreEmpresaRecaudacion} Suministro: {modelo.Suministro}  Cuenta: {modelo.Cuenta.Substring(0, 3) + String.Empty.PadRight(4, 'X') + modelo.Cuenta.Substring(7)} Error: {respuestaPago.Respuesta.MensajeError}")
                        );
                    }
                }
                else
                {
                    // Error en actualizacion de cupos
                    modelo.EsPagoExitoso = false;
                    modelo.EsTokenValido = false;
                    modelo.MensajeError = respuestaConsultaCupos.MensajeError;
                }
                
            }
            else
            {
                modelo.EsPagoExitoso = false;
                modelo.EsTokenValido = false;

                // Invento de Kristel...

                string mensajeErrorToken = "TOKEN INVÁLIDO";

                switch (respuestaEntrust.CodigoRespuesta)
                {
                    case "5203000":
                        mensajeErrorToken = "NÚMERO INGRESADO INCORRECTAMENTE. USTED TIENE UN NÚMERO DETERMINADO DE INTENTOS. SI LLEGASE AL MÁXIMO DE ERRORES INGRESADOS SU CLAVE DIGITAL SERÁ BLOQUEADA";
                        break;
                    case "5203004":
                        mensajeErrorToken = "USUARIO NO TIENE ASIGNADO UN DISPOSITIVO DE SEGURIDAD - TOKEN. POR FAVOR COMUNÍQUESE CON SOPORTE SAT";
                        break;
                    case "5203017":
                        mensajeErrorToken = "SU CLAVE DIGITAL HA SIDO BLOQUEADA POR INTENTOS FALLIDOS. POR FAVOR COMUNÍQUESE CON SOPORTE SAT";
                        break;
                    case "5203016":
                        mensajeErrorToken = "SU CLAVE DIGITAL HA SIDO BLOQUEADA POR INTENTOS FALLIDOS. POR FAVOR COMUNÍQUESE CON SOPORTE SAT";
                        break;
                    default:
                        mensajeErrorToken = $"ERROR DE AUTENTICACIÓN TOKEN - {respuestaEntrust.CodigoRespuesta}";
                        break;
                }

                modelo.MensajeError = mensajeErrorToken;
            }

            // Aqui tenemos los datos necesarios para el pago

            if(!modelo.EsPagoExitoso || !modelo.EsTokenValido)
            {
                //No es pago valido

                TempData["TituloMensaje"] = "No hemos podido procesar su transacción";
                TempData["MensajeError"] = modelo.MensajeError;

                return RedirectToAction("Mensaje", "Home");
            }
            else
            {
                // Exito pago
                return View(modelo);
            }

            
        }
    }
}