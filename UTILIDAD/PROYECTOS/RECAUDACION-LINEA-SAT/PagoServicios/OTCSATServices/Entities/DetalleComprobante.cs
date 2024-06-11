using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace OTCSATServices.Entities
{
    [XmlRoot("desglose")]
    public class DetalleComprobante
    {
        [XmlElement("codigo")]
        public string Codigo { get; set; }
        [XmlElement("etiqueta")]
        public string Etiqueta { get; set; }
        [XmlElement("valor")]
        public string Valor { get; set; }
    }
}
