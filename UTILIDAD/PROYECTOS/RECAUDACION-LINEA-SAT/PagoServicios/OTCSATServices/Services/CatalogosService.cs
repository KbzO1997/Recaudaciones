using OTCSAT.Entities;
using OTCSATServices.Data;
using OTCSATServices.Entities;
using OTCSATServices.Services.Interfaces;
using OTCSATServices.Utils;
using Sybase.Data.AseClient;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services
{
    public class CatalogosService:ICatalogosService
    {
        private const int CONSULTA_TODOS_PRODUCTOS = 0;
        private const int CONSULTA_CUENTAS = 99;
        private const int CONSULTA_TARJETAS_CREDITO = 43;
        private const int CONSULTA_TARJETAS_CORPORATIVAS = 25;

        public CatalogosService()
        {

        }

        /// <summary>
        /// Obtiene las cuentas por servicio empresa disponibles
        /// </summary>
        /// <param name="empresa">Codigo de la empresa SAT</param>
        /// <param name="servicio">El nemonico de servicio SAT</param>
        /// <returns>Las cuentas asociadas al servicio empresa</returns>
        public List<Cuenta> ObtenerCuentasPorServicioEmpresa(int empresa, string servicio)
        {
            List<Cuenta> cuentas = new List<Cuenta>();

            using (var contexto = new PersistenceContext())
            {
                
                ObjectResult<sp_cuenta_empresa_Result> respuesta = contexto.sp_cuenta_empresa(empresa, servicio);

                foreach(sp_cuenta_empresa_Result cuenta in respuesta)
                {
                    cuentas.Add(new Cuenta {
                        Banco = cuenta.codigo.Split('@')[1],
                        Codigo = cuenta.codigo.Split('@')[3],
                        EsDefault = (cuenta.cod_default.ToUpper().Equals("A")),
                        Referencia = cuenta.referencia,
                        Tipo = (cuenta.codigo.Split('@')[2].Equals("3")) ? "CTE":"AHO"
                    });
                }

            }

            return cuentas;
        }

        /// <summary>
        /// Obtiene una lista de cuentas asociadas por empresa usuario (aplica para pago de servicios)
        /// </summary>
        /// <param name="empresa">El codigo del ordenante SAT</param>
        /// <param name="usuario">El alias del usuario</param>
        /// <returns>La lista de cuentas asociadas por empresa usuario</returns>
        public List<Cuenta> ObtenerCuentasPorEmpresaUsuario(int empresa, string usuario)
        {
            List<Cuenta> cuentas = new List<Cuenta>();

            using (var contexto = new PersistenceContext())
            {
                
                var resultado = contexto.pa_sat_ccuentas_xlogin(empresa, usuario, CONSULTA_CUENTAS);

                int indiceActual = 0;

                foreach(pa_sat_ccuentas_xlogin_Result cuentaPorUsuario in resultado)
                {
                    indiceActual++;

                    var respuestaConsultaCuenta = ObtenerSaldoCuenta(cuentaPorUsuario.mr_tipo_cta,cuentaPorUsuario.mr_cuenta);

                    cuentas.Add(new Cuenta
                    {
                        Banco = "34",
                        Codigo = cuentaPorUsuario.mr_cuenta,
                        EsDefault = (indiceActual==1),
                        Referencia = Utils.Configuraciones.ObtenerCuentaEnmascarada(cuentaPorUsuario.mr_cuenta),
                        Tipo = cuentaPorUsuario.mr_tipo_cta,
                        SaldoDisponible = respuestaConsultaCuenta.SaldoDisponible,
                        Nombre = respuestaConsultaCuenta.NombreCuenta
                    });
                }
            }

            return cuentas;
        }

        /// <summary>
        /// Obtiene los estados disponibles
        /// </summary>
        /// <returns></returns>
        public List<Estado> ObtenerEstados()
        {
            List<Estado> listaEstados = new List<Estado>
            {
                new Estado { Codigo = "T", Descripcion = "(Todos)" },
                new Estado { Codigo = "A", Descripcion = "Activo" },
                new Estado { Codigo = "I", Descripcion = "Inactivo" }
            };

            return listaEstados;
        }

        /// <summary>
        /// Devuelve una lista de empresas por nombre 
        /// </summary>
        /// <param name="nombre">El nombre completo o incompleto de la empresa</param>
        /// <returns></returns>
        public List<Empresa> ObtenerEmpresasPorNombre(string nombre="")
        {
            nombre = nombre.ToUpper();

            List<Empresa> empresas = new List<Empresa>();

            using (var contexto = new PersistenceContext())
            {
                
                ObjectResult<pa_con_cempresa_esp_Result> salida = contexto.pa_con_cempresa_esp(nombre,30);

                foreach (pa_con_cempresa_esp_Result empresa in salida)
                {
                    empresas.Add(new Empresa
                    {
                        Codigo = empresa.codigo,
                        Descripcion = empresa.nombre.ToUpper()
                    });
                }

            }

            return empresas;
        }

        /// <summary>
        /// Permite consultar los cupos asociados al servicio de recaudacion empresa indicado
        /// </summary>
        /// <param name="ordenante">El ordenante SAT</param>
        /// <param name="usuario">El codigo de usuario</param>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO)</param>
        /// <param name="cuenta">El codigo de la cuenta</param>
        /// <param name="grupo">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA,etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion OTC</param>
        /// <param name="convenio">El codigo del convenio</param>
        /// <returns>Los cupos vigentes para la empresa-servicio-grupo</returns>
        public RespuestaConsultaCupos ObtenerCuposServicio(int ordenante, string usuario, string tipoCuenta, string cuenta, string grupo, int empresaRecaudacion, string convenio)
        {
            var respuesta = new RespuestaConsultaCupos
            {
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = -1,
                    ExitoOperacion = false,
                    MensajeError = "ERROR GENERAL AL OBTENER CUPOS TRANSACCIONALES"
                },
                Asignado = 0,
                Disponible = 0,
                Utilizado = 0
            };

            using (var contexto = new PersistenceContext())
            {
                ObjectParameter disponible = new ObjectParameter("s_disponible", typeof(double));
                ObjectParameter utilizado = new ObjectParameter("s_utilizado", typeof(double));
                ObjectParameter asignado = new ObjectParameter("s_asignado", typeof(double));
                ObjectParameter grupoCupo = new ObjectParameter("s_grupo", typeof(string));
                ObjectParameter codigoRespuesta = new ObjectParameter("s_cod_error", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                string codigoGrupoCupo = "S-" + grupo;

                if (codigoGrupoCupo.Equals("IMPUESTOS_OBLIGACIONES") && (empresaRecaudacion == 1113 || empresaRecaudacion == 1114 || empresaRecaudacion == 1112))
                {
                    codigoGrupoCupo += "-" + empresaRecaudacion.ToString();
                }

                contexto.pa_sat_ccupo_cliente_serv(ordenante, usuario, ((byte)(tipoCuenta.Equals("CTE") ? 3 : 4)), cuenta, codigoGrupoCupo, disponible, utilizado, asignado, grupoCupo, codigoRespuesta, mensajeError);
                
                if (((int)codigoRespuesta.Value) == 0)
                {
                    // Respuesta exitosa

                    respuesta.Respuesta.CodigoRespuesta = 0;
                    respuesta.Respuesta.ExitoOperacion = true;
                    respuesta.Respuesta.MensajeError = "TRANSACCION EXITOSA";
                    
                    respuesta.Disponible = double.Parse(disponible.Value.ToString());
                    respuesta.Utilizado = double.Parse(utilizado.Value.ToString());
                    respuesta.Asignado = double.Parse(asignado.Value.ToString());
                    respuesta.AgrupadorCupo = grupoCupo.Value.ToString();
                }
                else
                {
                    respuesta.Respuesta.CodigoRespuesta = (int)codigoRespuesta.Value;
                    respuesta.Respuesta.MensajeError = mensajeError.Value.ToString();
                }
            }

            return respuesta;
        }

        /// <summary>
        /// Permite actualizar el cupo asociado al servicio de recaudacion empres indicado
        /// </summary>
        /// <param name="ordenante">El ordenante SAT</param>
        /// <param name="usuario">El codigo del usuario</param>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO)</param>
        /// <param name="cuenta">El codigo de la cuenta</param>
        /// <param name="grupo">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA,etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion OTC</param>
        /// <param name="convenio">El codigo del convenio</param>
        /// <param name="monto">El monto a transaccionar</param>
        /// <param name="comision">La comision asociada a la transaccion</param>
        /// <param name="consulta">Bandera de solo consulta: S/N</param>
        /// <returns>El exito o fracaso de la actualizacion de cupos</returns>
        public Respuesta ActualizarCupoServicio(int ordenante, string usuario, string tipoCuenta, string cuenta, string grupo, int empresaRecaudacion, string convenio, double monto, double comision, string consulta)
        {
            var respuesta = new Respuesta
            {
                ExitoOperacion = false,
                CodigoRespuesta = -1,
                MensajeError = "ERROR GENERAL AL ACTUALIZAR CUPOS DE SERVICIO"
            };

            using (var contexto = new PersistenceContext())
            {
                
                ObjectParameter codigoRespuesta = new ObjectParameter("s_cod_error", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                string grupoCupo = "S-" + grupo;

                if (grupo.Equals("IMPUESTOS_OBLIGACIONES") && (empresaRecaudacion == 1113 || empresaRecaudacion == 1114 || empresaRecaudacion == 1112))
                {
                    grupoCupo += "-"+ empresaRecaudacion.ToString();
                }

                contexto.pa_sat_acupo_cliente_serv(ordenante, usuario, ((byte)(tipoCuenta.Equals("CTE") ? 3 : 4)), cuenta,grupoCupo, (decimal)monto, (decimal)comision, codigoRespuesta, mensajeError,consulta);

                if (((int)codigoRespuesta.Value) == 0)
                {
                    // Respuesta exitosa

                    respuesta.CodigoRespuesta = 0;
                    respuesta.ExitoOperacion = true;
                    respuesta.MensajeError = "TRANSACCION EXITOSA";
                }
                else
                {
                    respuesta.CodigoRespuesta = (int)codigoRespuesta.Value;
                    respuesta.MensajeError = mensajeError.Value.ToString();
                }
            }
            
            return respuesta;
        }

        /// <summary>
        /// Obtiene el saldo disponible de una cuenta
        /// </summary>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO|VIR)</param>
        /// <param name="cuenta">El numero de la cuenta</param>
        /// <returns>El saldo disponible de la cuenta</returns>
        public RespuestaConsultaCuenta ObtenerSaldoCuenta(string tipoCuenta, string cuenta)
        {

            var respuesta = new RespuestaConsultaCuenta
            {
                ExitoOperacion = false,
                MensajeError = "ERROR GENERAL CONSULTA CUENTA",
                NombreCuenta = "",
                SaldoDisponible = 0
            };

            try
            {

                using (var con = new AseConnection())
                {
                    con.ConnectionString = Configuraciones.ObtenerConfiguracionConexionSybase();
                    con.Open();

                    var comando = new AseCommand("db_biz_servicios..pa_sat_csaldoscuenta", con)
                    {
                        CommandType = System.Data.CommandType.StoredProcedure,
                        CommandTimeout = 120
                    };

                    // Entradas
                    comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_tipo_cuenta", AseDbType.Integer, System.Data.ParameterDirection.Input, (tipoCuenta.Equals("CTE")) ? 3 : (tipoCuenta.Equals("AHO")) ? 4 : 12));
                    comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_numero_cuenta", AseDbType.VarChar, System.Data.ParameterDirection.Input, cuenta));

                    // Salidas
                    var codigoRespuesta = Configuraciones.ConstruirParametro(comando, "@s_codigo_respuesta", AseDbType.Integer, System.Data.ParameterDirection.Output, null);
                    var mensajeError = Configuraciones.ConstruirParametro(comando, "@s_mensaje_error", AseDbType.VarChar, System.Data.ParameterDirection.Output, null);
                    var saldoDisponible = Configuraciones.ConstruirParametro(comando, "@s_disponible", AseDbType.Money, System.Data.ParameterDirection.Output, null);
                    var nombreCuenta = Configuraciones.ConstruirParametro(comando, "@s_nombre_cuenta", AseDbType.VarChar, System.Data.ParameterDirection.Output, null);

                    comando.Parameters.Add(codigoRespuesta);
                    comando.Parameters.Add(mensajeError);
                    comando.Parameters.Add(saldoDisponible);
                    comando.Parameters.Add(nombreCuenta);

                    int respuestaCentral = comando.ExecuteNonQuery();
                    bool exitoOperacion = (((int)codigoRespuesta.Value) == 0);

                    respuesta.ExitoOperacion = exitoOperacion;
                    respuesta.MensajeError = mensajeError.Value.ToString();
                    respuesta.SaldoDisponible = (exitoOperacion) ? double.Parse(saldoDisponible.Value.ToString()) : 0;
                    respuesta.NombreCuenta = (exitoOperacion)?nombreCuenta.Value.ToString():"";
                    
                }
            }catch(Exception ex)
            {
                respuesta.ExitoOperacion = false;
                respuesta.MensajeError = ex.Message;
                respuesta.SaldoDisponible = 0;
                respuesta.NombreCuenta = "";
            }

            return respuesta;
        }
    }
}