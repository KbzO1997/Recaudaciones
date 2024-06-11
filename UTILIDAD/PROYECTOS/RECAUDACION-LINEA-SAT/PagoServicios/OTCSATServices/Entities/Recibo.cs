using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class Recibo
    {
        public string Concepto { get; set; }
        public string Fecha { get; set; }
        public string Impuesto { get; set; }
        public string Referencia { get; set; }
        public string Secuencia { get; set; }
        public double TotalAPagar { get; set; }
        public string Cuota { get; set; }
        public List<DatoAdicional> DatoAdicional { get; set; }
    }
}
