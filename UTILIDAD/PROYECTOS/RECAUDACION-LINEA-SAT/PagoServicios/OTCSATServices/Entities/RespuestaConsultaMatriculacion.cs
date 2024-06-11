using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaConsultaMatriculacion
    {
        public Respuesta respuesta { get; set; }
        public Matriculacion cabecera { get; set; }
    }
}
