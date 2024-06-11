using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OTCSAT.Models
{
    /// <summary>
    /// Modelo de Matriculacion
    /// </summary>
    public class IndexModel
    {
        public int Empresa { get; set; }
        public string NombreEmpresa { get; set; }
        public string Nemonico { get; set; }
        public string Usuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Producto { get; set; }
        public string Servicio { get; set; }
        public string TipoServicio { get; set; }
        public string EmpresaRecaudacion { get; set; }
        public string Convenio { get; set; }
        public string Estado { get; set; }

        public string Alias { get; set; }

        // Datos necesarios para identificar datos de sesion SAT
        public int EmpresaCreacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }

        // Paginacion
        public int IndiceInicial { get; set; }
        public bool ExistenMasPaginas { get; set; }
        public bool EsPrimeraPagina { get; set; }

        public IEnumerable<SelectListItem> Estados{ get; set; }
        public IEnumerable<SelectListItem> TiposEmpresas { get; set; }
        public IEnumerable<SelectListItem> EmpresasRecaudacion { get; set; }
        public IEnumerable<SelectListItem> Convenios { get; set; }

        public IEnumerable<Matriculacion> Matriculaciones { get; set; }

        // Necesarios por pagos no matriculados
        public IEnumerable<SelectListItem> Cuentas { get; set;}
        public string PermisoAcciones { get; set; }
    }
}