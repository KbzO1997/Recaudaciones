using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaConsultaCupos
    {
        public Respuesta Respuesta { get; set; }
        public double Disponible { get; set; }
        public double Utilizado { get; set; }
        public double Asignado { get; set; }
        public string AgrupadorCupo { get; set; }
    }
}
