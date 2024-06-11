using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Entities
{
    /// <summary>
    /// Campos adicionales por definicion empresa
    /// </summary>
    public class DatoAdicional
    {
        public string Id { get; set; }
        public string Tipo { get; set; }
        public string Etiqueta { get; set; }
        public string ValorSeleccionado { get; set; }
        public bool EsVisible { get; set; }
        public bool EsEditable { get; set; }
        public string Formato { get; set; }
        public string Mascara { get; set; }
        public string RegExp { get; set; }
        public List<ItemSeleccion>Valores{get;set;}
    }
}
