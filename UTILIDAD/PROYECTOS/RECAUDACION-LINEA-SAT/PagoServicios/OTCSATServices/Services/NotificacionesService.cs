using log4net;
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
    public class NotificacionesService : INotificacionesService
    {
        private static ILog logger = LogManager.GetLogger(typeof(NotificacionesService));

        /// <summary>
        /// Permite enviar una notificacion de pago de servicio
        /// </summary>
        /// <param name="comprobante">Los datos del comprobante de servicio</param>
        /// <param name="ordenEmpresa">Codigo de orden empresa generado</param>
        public void EnviarNotificacionPagoServicio(Comprobante comprobante,long ordenEmpresa)
        {
            logger.Debug(String.Format("Notificacion de Pago ordenEmpresa: {0} usuario: {1}", ordenEmpresa,comprobante.Usuario));
            
            using (var contexto = new PersistenceContext())
            {
                //Configuraciones.InyectarCredenciales(contexto);

                ObjectParameter codigoRespuesta = new ObjectParameter("s_codigo_respuesta", typeof(int));
                ObjectParameter mensajeError = new ObjectParameter("s_mensaje_error", typeof(string));

                // Si el servicio es matriculable, mostrar el alias en el comprobante, caso contrario no
                string aliasComprobante = (Configuraciones.EsConvenioMatriculable(
                    comprobante.Grupo,
                    comprobante.EmpresaRecaudacion.ToString(),
                    comprobante.Convenio)) ? comprobante.Alias.Trim().ToUpper() : "N/A";

                // Intercambiar nombre de empresa de recaudacion por convenio cuando la empresa sea deposito temporal
                string nombreEmpresaRecaudacion = (Configuraciones.EsDepositoTemporal(
                    comprobante.Grupo,
                    comprobante.EmpresaRecaudacion.ToString()
                    )) ? comprobante.NombreConvenio.Trim().ToUpper() : comprobante.NombreEmpresaRecaudacion.ToUpper();
                
                string nombreConvenio =  (Configuraciones.EsDepositoTemporal(
                    comprobante.Grupo,
                    comprobante.EmpresaRecaudacion.ToString()
                    )) ? comprobante.NombreEmpresaRecaudacion.ToUpper() : comprobante.NombreConvenio.Trim().ToUpper();
                
                contexto.pa_sat_inotif_pagserv(
                    comprobante.Ordenante, 
                    comprobante.Usuario, 
                    (short)comprobante.TipoCuenta, 
                    comprobante.Cuenta, 
                    String.Format("{0:n}",comprobante.Monto), 
                    String.Format("{0:n}", comprobante.Comision), 
                    String.Format("{0:n}", comprobante.Monto + comprobante.Comision), 
                    comprobante.Grupo.Replace("_"," "),
                    nombreEmpresaRecaudacion,
                    nombreConvenio, 
                    comprobante.Suministro.Replace(" ","").Trim(), 
                    ordenEmpresa.ToString(), 
                    DateTime.Now.ToString("MM/dd/yyyy H:mm"),
                    comprobante.EtiquetaIdentificador.Trim(),
                    aliasComprobante,
                    comprobante.Abonado.Trim().ToUpper(),
                    codigoRespuesta, 
                    mensajeError);
            }
        }
    }
}
