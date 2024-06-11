using extranet;
using OTCSATServices.Utils.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Utils
{
    public class CifradorRCA : ICifrador
    {
        /// <summary>
        /// Permite desencriptar una cadena encriptada y codificada desde las utilidades del SAT
        /// </summary>
        /// <param name="cadenaEncriptada">La cadena encriptada y codificada (encode) desde SAT</param>
        /// <param name="llave">La llave con la cual se encripto la cadena</param>
        /// <returns>La cadena desencriptada en formato legible por el usuario final</returns>
        public string DesencriptarCadena(string cadenaEncriptada, string llave)
        {
            cadenaEncriptada = (string.IsNullOrEmpty(cadenaEncriptada)) ? "" : cadenaEncriptada;
            //cadenaEncriptada = HttpUtility.UrlDecode(cadenaEncriptada);

            extranet.cls_encriptar administradorEncriptacion = new cls_encriptar();
            string desencriptado = administradorEncriptacion.des_encriptar(Microsoft.JScript.GlobalObject.unescape(cadenaEncriptada), llave);
            administradorEncriptacion = null;

            return desencriptado;
        }
    }
}
