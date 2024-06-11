using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Representacion de un comprobante de pago de OTC SAT
    /// </summary>
    [XmlRoot("desgloses")]
    public class Comprobante
    {
        [XmlIgnore]
        public int Ordenante { get; set; }
        [XmlIgnore]
        public string Usuario { get; set; }
        [XmlIgnore]
        public string Referencia { get; set; }
        [XmlIgnore]
        public int TipoCuenta { get; set; }
        [XmlIgnore]
        public string Cuenta { get; set; }
        [XmlIgnore]
        public double Monto { get; set; }
        [XmlIgnore]
        public double Comision { get; set; }
        [XmlIgnore]
        public string Grupo { get; set; }
        [XmlIgnore]
        public int EmpresaRecaudacion { get; set; }
        [XmlIgnore]
        public string Convenio { get; set; }
        [XmlIgnore]
        public string Suministro { get; set; }
        [XmlIgnore]
        public string NombreEmpresaRecaudacion { get; set; }
        [XmlIgnore]
        public string NombreConvenio { get; set; }
        [XmlIgnore]
        public string ComprobantePago { get; set; }
        [XmlIgnore]
        public string Estado { get; set; }
        [XmlIgnore]
        public int CodigoError { get; set; }
        [XmlIgnore]
        public string Alias { get; set; }
        [XmlIgnore]
        public string EtiquetaIdentificador { get; set; }
        [XmlIgnore]
        public string Abonado { get; set; }

        [XmlElement("desglose")]
        public List<DetalleComprobante> Detalles { get; set; }
    }
}
