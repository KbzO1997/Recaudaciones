using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    public class RespuestaConsultaDeuda
    {
        public Respuesta Respuesta { get; set; }
        public List<DatoAdicional> DatosAdicionales { get; set; }
        public List<Recibo> Recibos { get; set; } // Usado por municipios, muestra un grid de seleccion unica
        public DateTime ?FechaVencimiento { get; set; }
        public string FormaPago { get; set; }
        public string FormaPagoRecibos { get; set; } // Usado por municipios, determina si el pago de grid selecciona el primer elemento o cualquiera de la lista
        public double LimiteMontoMaximo { get; set; }
        public double LimiteMontoMinimo { get; set; }
        public string IdentificadorDeuda { get; set; }
        public double MontoTotal { get; set; }
        public double MontoMinimo { get; set; }
        public string NombreCliente { get; set; }
    }
}
