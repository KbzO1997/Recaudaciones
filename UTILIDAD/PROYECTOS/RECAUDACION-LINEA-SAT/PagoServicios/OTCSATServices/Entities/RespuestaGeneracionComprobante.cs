using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaGeneracionComprobante
    {
        public Respuesta Respuesta { get; set; }
        public long OrdenBanco { get; set; }
        public long OrdenEmpresa { get; set; }
    }
}
