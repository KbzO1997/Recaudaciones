using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de la metadefinicion de una empresa de recaudacion
    /// </summary>
    public class DefinicionEmpresa
    {
        public string Grupo { get; set; }
        public string Empresa { get; set; }
        public string Convenio { get; set; }
        public string Identificador { get; set; }
        public string EtiquetaConvenio { get; set; }
        public string EtiquetaIdentificador { get; set; }
        public bool EsEditable { get; set; }
        public string RegExp { get; set; }
        public string TextoAyuda { get; set; }
        public string Mascara { get; set; }
        public string Suministro { get; set; }
        public string Regional { get; set; }
        public string NombreEmpresa { get; set; }
        public List<Convenio> Convenios { get; set; }
        public List<DatoAdicional> DatosAdicionales { get; set; }
    }
}
