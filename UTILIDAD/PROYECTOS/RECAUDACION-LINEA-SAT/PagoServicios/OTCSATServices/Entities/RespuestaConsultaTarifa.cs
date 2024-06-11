using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Respuesta de la consulta de tarifario para OTC
    /// </summary>
    public class RespuestaConsultaTarifa
    {
        public Respuesta Respuesta { get; set; }
        public double Comision { get; set; }
    }
}
