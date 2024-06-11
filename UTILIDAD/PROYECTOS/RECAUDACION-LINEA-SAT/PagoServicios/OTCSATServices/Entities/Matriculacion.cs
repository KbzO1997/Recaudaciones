using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de la cabecera de una matriculacion
    /// </summary>
    public class Matriculacion
    {
        public int Ordenante { get; set; }
        public string Usuario { get; set; }
        public string Grupo { get; set; }
        public int EmpresaRecaudacion { get; set; }
        public string Convenio { get; set; }
        public string Identificador { get; set; }
        public string EtiquetaConvenio { get; set; }
        public string EtiquetaIdentificador { get; set; }
        public string EsEditable { get; set; }
        public string RegExp { get; set; }
        public string TextoAyuda { get; set; }
        public string Mascara { get; set; }
        public string Alias { get; set; }
        public string Suministro { get; set; }
        public string Regional { get; set; }
        public string UsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime ?FechaModificacion { get; set; }
        public string Estado { get; set; }
        public long Secuencia { get; set; }
        public string NombreEmpresaRecaudacion { get; set; }

        public string NombreOrdenante { get; set; }
        public string NombreUsuario { get; set; }
        public string NemonicoOrdenante { get; set; }
    }
}
