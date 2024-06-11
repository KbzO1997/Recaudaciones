using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Utils.Interfaces
{
    public interface ICifrador
    {
        /// <summary>
        /// Permite desencriptar una cadena encriptada y codificada desde las utilidades del SAT
        /// </summary>
        /// <param name="cadenaEncriptada">La cadena encriptada y codificada (encode) desde SAT</param>
        /// <param name="llave">La llave con la cual se encripto la cadena</param>
        /// <returns>La cadena desencriptada en formato legible por el usuario final</returns>
        string DesencriptarCadena(string cadenaEncriptada, string llave);
    }
}
