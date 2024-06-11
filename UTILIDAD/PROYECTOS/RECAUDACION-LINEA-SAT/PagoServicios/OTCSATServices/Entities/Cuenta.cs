using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de una cuenta asociada a la empresa SAT
    /// </summary>
    public class Cuenta
    {
        public string Banco { get; set; }
        public string Tipo { get; set; }
        public string Codigo { get; set; }
        public string Referencia { get; set; }
        public double SaldoDisponible { get; set; }
        public string Nombre { get; set; }
        public bool EsDefault { get; set; }
    }
}
