using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class EmpresaSAT
    {
        public int Codigo { get; set; }
        public string Nombre { get; set; }
        public string Nemonico { get; set; }
        public string Direccion{ get; set; }
        public string TipoIdentificacion { get; set; }
        public string Identificacion { get; set; }
    }
}
