using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services.Interfaces
{
    public interface INotificacionesService
    {
        /// <summary>
        /// Permite enviar una notificacion de pago de servicio
        /// </summary>
        /// <param name="comprobante">Los datos del comprobante de servicio</param>
        /// <param name="ordenEmpresa">Codigo de orden empresa generado</param>
        void EnviarNotificacionPagoServicio(Comprobante comprobante,long ordenEmpresa);
    }
}
