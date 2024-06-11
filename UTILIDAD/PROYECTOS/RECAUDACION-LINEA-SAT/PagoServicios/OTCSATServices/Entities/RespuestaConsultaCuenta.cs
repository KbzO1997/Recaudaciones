using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaConsultaCuenta
    {
        public bool ExitoOperacion { get; set; }
        public string MensajeError { get; set; }
        public double SaldoDisponible { get; set; }
        public string NombreCuenta { get; set; }
    }
}
