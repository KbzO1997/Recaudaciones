using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de los valores necesarios de enviar a OTC y core para realizar el pago de servicio
    /// </summary>
    public class Pago
    {
        public Comprobante Comprobante { get; set; }
        public string CodigoIdentificador { get; set; }
        public string Cliente { get; set;}
        public List<DatoAdicional> DatosAdicionales { get; set; }
        public List<DatoAdicional> EntradasAdicionales { get; set; } // Datos especiales para el caso de SRI Otras formas de pago
        public List<Recibo> Recibos { get; set; } // Usado por municipios, por el momento permitimos un pago
    }
}
