using OTCSAT.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTCSAT.Models
{
    public class PagoModel
    {
        public string Usuario { get; set; }
        public string NombreUsuario { get; set; }
        public int Ordenante { get; set; }

        public List<TipoServicio> Grupos { get; set; }
    }
}