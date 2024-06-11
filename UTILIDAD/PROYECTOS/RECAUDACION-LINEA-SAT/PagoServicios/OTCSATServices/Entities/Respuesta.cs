using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Respuesta Generica
    /// </summary>
    public class Respuesta
    {
        public int CodigoRespuesta { get; set; }
        public bool ExitoOperacion { get; set; }
        public string MensajeError { get; set; }
    }
}
