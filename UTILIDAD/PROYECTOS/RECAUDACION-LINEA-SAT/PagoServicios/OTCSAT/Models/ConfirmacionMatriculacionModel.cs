using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTCSAT.Models
{
    public class ConfirmacionMatriculacionModel
    {
        public Respuesta Respuesta { get; set; }
        public string Ordenante { get; set; }
        public string Usuario { get; set; }
        public string NombreUsuario { get; set; }
        public string NombreOrdenante { get; set; }
        public string Nemonico { get; set; }
        public string TipoRecaudacion { get; set; }
        public string EmpresaRecaudacion { get; set; }
        public string NombreEmpresaRecaudacion { get; set; }
        public string Convenio { get; set; }
        public string NombreConvenio { get; set; }
        public string EtiquetaIdentificador { get; set; }
        public string Suministro { get; set; }
        public string Alias { get; set; }
        public string Estado { get; set; }
        
        public int Secuencia { get; set; }
        public string UsuarioModificacion { get; set; }
        public string PermisoAcciones { get; set; }
    }
}