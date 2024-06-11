using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de la respuesta de pago enviada por OTC
    /// </summary>
    public class RespuestaPago
    {
        public Respuesta Respuesta { get; set; }
        public DateTime ? FechaPago { get; set; }
        public DateTime? FechaDebito { get; set; }
        public string ReferenciaPago { get; set; }
        public long OrdenBanco { get; set; }
        public long OrdenEmpresa { get; set; }
    }
}
