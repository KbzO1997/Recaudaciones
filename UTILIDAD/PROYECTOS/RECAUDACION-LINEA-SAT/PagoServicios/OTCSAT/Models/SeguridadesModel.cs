using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace OTCSAT.Models
{
    /// <summary>
    /// Modelo de validacion de token
    /// </summary>
    public class SeguridadesModel
    {
        public string Token { get; set; }

        public int Ordenante { get; set; }
        public string Usuario { get; set; }
        public string Referencia { get; set; }
        public string Alias { get; set; }
        public int TipoCuenta { get; set; }
        public string Cuenta { get; set; }

        [DisplayFormat(DataFormatString = "{0:n}", ApplyFormatInEditMode = false)]
        public double Monto { get; set; }

        [DisplayFormat(DataFormatString = "{0:n}", ApplyFormatInEditMode = false)]
        public double Comision { get; set; }

        public string Grupo { get; set; }
        public int EmpresaRecaudacion { get; set; }
        public string Convenio { get; set; }
        public string Suministro { get; set; }
        public string NombreEmpresaRecaudacion { get; set; }
        public string NombreConvenio { get; set; }
        public string FechaVencimiento { get; set; }
        public string Cliente { get; set; }
        public string TipoIdentificador { get; set; }
        public string EtiquetaIdentificador { get; set; }

        public string DatosAdicionalesJSON { get; set; } // Datos adicionales seleccionados por el usuario en formato JSON
        public string RecibosJSON { get; set; } // Recibos seleccionados por el usuario en formato JSON

        // Estructura JSON con datos de pago adicionales
        public string Deuda { get; set; }
        public string Configuracion { get; set; }

        // Caso especiar SRI-Otras formas de pago (mas campos dinamicos de entrada)
        public string EntradasAdicionalesJSON { get; set; }

        // Respuesta de validacion de token
        public bool EsTokenValido { get; set; }
        public string MensajeError { get; set; }

        // Respuesta de pago en core-OTC
        public string OrdenBanco { get; set; }
        public bool EsPagoExitoso { get; set; }

        // Tipo de dispositivo asociado al cliente
        public TipoDispositivo TipoDispositivo { get; set; }
    }
}