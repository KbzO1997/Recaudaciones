using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class Convenio
    {
        public string Codigo { get; set; }
        public string Etiqueta { get; set; }
        public List<Identificador> Identificadores { get; set; }
    }
}
