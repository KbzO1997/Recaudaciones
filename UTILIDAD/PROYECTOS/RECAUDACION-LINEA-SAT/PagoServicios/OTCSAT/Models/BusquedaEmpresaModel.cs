using OTCSAT.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTCSAT.Models
{
    public class BusquedaEmpresaModel
    {
        public String Nombre { get; set; }
        public List<Empresa> Empresas { get; set; }
    }
}