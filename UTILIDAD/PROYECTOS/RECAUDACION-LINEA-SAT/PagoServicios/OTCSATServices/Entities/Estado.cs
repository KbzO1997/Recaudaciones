using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTCSAT.Entities
{
    public class Estado
    {
        public string Codigo { get; set; }
        public string Descripcion { get; set; }

        public Estado()
        {

        }

        public Estado(string codigo,string descripcion)
        {
            this.Codigo = codigo;
            this.Descripcion = descripcion;
        }
    }
}