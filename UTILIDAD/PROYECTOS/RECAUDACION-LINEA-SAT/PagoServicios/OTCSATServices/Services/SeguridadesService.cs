using log4net;
using OTCSAT.Entities;
using OTCSATServices.Data;
using OTCSATServices.Entities;
using OTCSATServices.Services.Interfaces;
using OTCSATServices.Utils;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services
{
    public class SeguridadesService:ISeguridadesService
    {
        private static ILog logger = LogManager.GetLogger(typeof(SeguridadesService));
        
        /// <summary>
        /// Obtiene el nombre de la empresa indicada por codigo SAT
        /// </summary>
        /// <param name="codigo">El codigo de la empresa SAT</param>
        /// <returns>El nombre de la empresa asociada</returns>
        public string ObtenerNombreEmpresa(int codigo)
        {
            string nombreEmpresa = "";

            using (var contexto = new PersistenceContext())
            {
                
                try
                {
                    nombreEmpresa = contexto.sp_con_nombrempresa(Configuraciones.ObtenerCodigoEmpresaHomologado(codigo)).ToList<string>()[0];
                }
                catch (Exception e)
                {
                    //logger.Error(e);
                    nombreEmpresa = "";
                }
            }
            
            return nombreEmpresa;
        }

        /// <summary>
        /// Obtiene el nemonico de la empresa indicada
        /// </summary>
        /// <param name="codigo">El codigo SAT de la empresa</param>
        /// <returns>El nemonico asociado a la empresa</returns>
        public string ObtenerNemonicoEmpresa(int codigo)
        {
            string nemonico = "";
            
            using(var contexto = new PersistenceContext())
            {
                
                ObjectParameter salida = new ObjectParameter("o_nemonico", typeof(string));

                contexto.sp_con_nemonico_empresa(Configuraciones.ObtenerCodigoEmpresaHomologado(codigo), salida);
                nemonico = salida.Value.ToString();
            }
            
            return nemonico;
        }

        /// <summary>
        /// Obtiene los datos relevantes de un usuario
        /// </summary>
        /// <param name="empresa">Codigo de empresa SAT</param>
        /// <param name="nemonicoEmpresa">Nemonico de empresa SAT</param>
        /// <param name="usuario">Alias de usuario (sin nemonico)</param>
        /// <returns></returns>
        public Usuario ObtenerDatosUsuario(int empresa, string nemonicoEmpresa, string usuario)
        {
            Usuario datosUsuario = new Usuario();
            
            using(var contexto = new PersistenceContext())
            {
                
                try
                {
                    sp_con_usuario_Result respuesta = contexto.sp_con_usuario(Configuraciones.ObtenerCodigoEmpresaHomologado(empresa), nemonicoEmpresa, usuario).Single<sp_con_usuario_Result>();
                    datosUsuario.Nombres = respuesta.us_nom_usuario;
                    datosUsuario.Identificacion = respuesta.us_cedula;
                    datosUsuario.Estado = respuesta.us_est_usuario;
                }
                catch (Exception ex)
                {
                    logger.Error(ex);

                    datosUsuario.Nombres = "";
                    datosUsuario.Identificacion = "";
                    datosUsuario.Estado = "";
                }
            }
            
            return datosUsuario;
        }

        /// <summary>
        /// Obtiene los datos basicos de una empresa SAT
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <returns>Los datos de la empresa</returns>
        public EmpresaSAT ObtenerDatosOrdenante(int ordenante)
        {
            EmpresaSAT respuesta = null;

            using (var contexto = new PersistenceContext())
            {
                
                try
                {
                    var rst = contexto.sp_con_empresa(Configuraciones.ObtenerCodigoEmpresaHomologado(ordenante));

                    if (rst != null)
                    {
                        sp_con_empresa_Result empresa = rst.First();

                        if (empresa != null)
                        {
                            respuesta = new EmpresaSAT
                            {
                                Codigo = ordenante,
                                Direccion = empresa.em_dir_empresa,
                                Identificacion = empresa.em_nuc_empresa,
                                TipoIdentificacion = empresa.em_ctp_nuc_empresa,
                                Nemonico = empresa.em_nem_empresa,
                                Nombre = empresa.em_nom_empresa
                            };
                        
                        }
                    }
                    
                }
                catch (Exception ex)
                {
                    logger.Error(ex);

                    respuesta = null;
                }
            }

            return respuesta;
        }


        /// <summary>
        /// Permite validar la clave de un dispositivo token
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El codigo del usuario de SAT que realiza la transaccion</param>
        /// <param name="token">El codigo del token generado para validar</param>
        /// <returns>El exito o fracaso de la operacion</returns>
        public RespuestaValidacionDispositivo ValidarToken(int ordenante, string usuario, string token)
        {
            var respuesta = new RespuestaValidacionDispositivo
            {
                CodigoRespuesta = "UNAUTHORIZED",
                ExitoOperacion = false,
                MensajeError = "ERROR DE AUTORIZACION GENERAL"
            };
            
            ClienteEntrust.EntrustServicePortType cliente = new ClienteEntrust.EntrustServicePortTypeClient();

            try
            {
                string dispositivo = "";

                var respuestaConsultaDispositivo = cliente.userTokenGet(new ClienteEntrust.userTokenGet
                {
                    userId = usuario
                });

                if (respuestaConsultaDispositivo.@return.codigoRespuesta == 0)
                {
                    dispositivo = respuestaConsultaDispositivo.@return.tokenAsignado.serialNumber;

                    var respuestaValidacion = cliente.authenticateToken(new ClienteEntrust.authenticateToken
                    {
                        device = dispositivo,
                        token = token,
                        userId = usuario
                    });

                    if (respuestaValidacion.@return.codigoRespuesta == 0)
                    {
                        respuesta.CodigoRespuesta = "0";
                        respuesta.ExitoOperacion = true;
                        respuesta.MensajeError = "TRANSACCION EXITOSA";
                    }
                    else
                    {
                        respuesta.CodigoRespuesta = respuestaValidacion.@return.codigoRespuesta.ToString();
                        throw new Exception(respuestaValidacion.@return.mensajeUsuario);
                    }
                }
                else
                {
                    respuesta.CodigoRespuesta = respuestaConsultaDispositivo.@return.codigoErrorInterno;
                    throw new Exception(respuestaConsultaDispositivo.@return.mensajeUsuario);
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);
                
                respuesta.ExitoOperacion = false;
                respuesta.MensajeError = ex.Message;
            }

            return respuesta;
        }

        /// <summary>
        /// Registra un evento de auditoria en SAT
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El usuario que realiza la accion</param>
        /// <param name="modulo">El modulo asociado a la opcion</param>
        /// <param name="transaccion">El codigo de transaccion invocado</param>
        /// <param name="accion">Nemonico de tres letras que define la accion realizada</param>
        /// <param name="descripcion">Descripcion de hasta 255 caracteres con el detalle de lo realizado</param>
        public void RegistrarAuditoria(int ordenante, string usuario, int modulo, int transaccion, string accion, string descripcion)
        {
            using (var contexto = new PersistenceContext())
            {
                contexto.sp_grb_reg_auditoria(ordenante.ToString(), usuario, 10, "PAGSERV", modulo, transaccion, accion.Substring(0, 1), accion, descripcion, null);
            }
        }

        /// <summary>
        /// Determina si la sesion actual es valida
        /// </summary>
        /// <param name="token">El token de seguridad generado en el backend de SAT</param>
        /// <returns>Si la sesion es o no valida</returns>
        public bool EsSesionValida(string token)
        {
            return Configuraciones.EsTokenValido(token);
        }

        /// <summary>
        /// Obtiene el tipo de dispositivo token asociado al usuario actual
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El alias del usaurio SAT</param>
        /// <returns>El tipo de dispositivo token asociado</returns>
        public RespuestaConsultaTipoDispositivo ObtenerTipoDispositivo(int ordenante, string usuario)
        {
            var respuesta = new RespuestaConsultaTipoDispositivo
            {
                Tipo = TipoDispositivo.TOKEN
            };

            using (var contexto = new PersistenceContext())
            {
                var rst = contexto.sp_con_usuario_dispositivo(ordenante.ToString(), usuario, 0, 0, "", "D");

                if (rst != null)
                {
                    var fila = rst.First();

                    switch (fila.tipo_dispo)
                    {
                        case 1:
                            respuesta.Tipo = TipoDispositivo.TOKEN;
                            break;
                        case 2:
                            respuesta.Tipo = TipoDispositivo.SOFTTOKEN;
                            break;
                    }
                }
            }

            return respuesta;
        }
    }
}
