using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTCSAT.Models
{
    /// <summary>
    /// Modelo de consulta de comprobante existente
    /// </summary>
    public class ConsultaComprobanteModel
    {
        public int Ordenante;
        public string NombreOrdenante;
        public string Usuario;
        public List<DetalleComprobante> Comprobante;
    }
}