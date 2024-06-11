using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaValidacionDispositivo
    {
        public string CodigoRespuesta { get; set; }
        public bool ExitoOperacion { get; set; }
        public string MensajeError { get; set; }
    }
}
