using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class Credenciales
    {
        public string ServidorSQL { get; set; }
        public int PuertoSQL { get; set; }
        public string UsuarioSQL { get; set; }
        public string CredencialSQL { get; set; }

        public string ServidorSybase { get; set; }
        public int PuertoSybase { get; set; }
        public string UsuarioSybase { get; set; }
        public string CredencialSybase { get; set; }
    }
}
