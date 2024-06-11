using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class Identificador
    {
        public string Codigo { get; set; }
        public string Etiqueta { get; set; }
        public string Mascara { get; set; }
        public bool EsMatriculable { get; set; }
        public string RegExp { get; set; }
        public string TextoAyuda { get; set; }
        public bool EsVisible { get; set; }

        public List<DatoAdicional> DatosAdicionales { get; set; }
        public List<string> RegionalesArea { get; set; }
    }
}
