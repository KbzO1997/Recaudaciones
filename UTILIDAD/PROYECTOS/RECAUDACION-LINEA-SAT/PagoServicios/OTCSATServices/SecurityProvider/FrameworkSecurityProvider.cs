using OTCSATServices.Entities;
using OTCSATServices.SecurityProvider.Interfaces;
using OTCSATServices.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace OTCSATServices.SecurityProvider
{
    /// <summary>
    /// Proveedor de credenciales via framework de seguridad
    /// </summary>
    class FrameworkSecurityProvider : ISecurityProvider
    {
        private static readonly int ARGUMENTO_SYBASE = 3;
        private static readonly int ARGUMENTO_SQL = 2;

        private readonly string usuario;
        private readonly string aplicacion;

        /*
        bool OverrideSecurityHandler(object sender, X509Certificate cert, X509Chain chain, System.Net.Security.SslPolicyErrors error)
        {
            return true;
        }
        */

        public FrameworkSecurityProvider(string usuario,string aplicacion)
        {
            this.usuario = usuario;
            this.aplicacion = aplicacion;

            //ServicePointManager.ServerCertificateValidationCallback += new System.Net.Security.RemoteCertificateValidationCallback(OverrideSecurityHandler);
        }
        
        /// <summary>
        /// Obtiene las credenciales de conexion a base de datos
        /// </summary>
        /// <returns>Las credenciales de conexion a base de datos</returns>
        public Credenciales ObtenerCredenciales()
        {
            ClienteFramework.ServicioSeguridadSCLSoap cliente = new ClienteFramework.ServicioSeguridadSCLSoapClient();
            string respuestaXML = cliente.LoginAplicacion(Int32.Parse(aplicacion), usuario);

            XmlDocument documento = new XmlDocument();
            documento.XmlResolver = null; // Prevencion de XXE

            documento.LoadXml(respuestaXML);

            XmlNode servidorSybase = documento.SelectSingleNode($"/Registro/Servidores/Servidor[@Tipo=\"{ARGUMENTO_SYBASE}\"][1]");
            XmlNode servidorSQL = documento.SelectSingleNode($"/Registro/Servidores/Servidor[@Tipo=\"{ARGUMENTO_SQL}\"][1]");

            var credenciales = new Credenciales
            {
                ServidorSybase = servidorSybase.Attributes["Servidor"].Value,
                ServidorSQL = servidorSQL.Attributes["Servidor"].Value,
                PuertoSybase = Int32.Parse(servidorSybase.Attributes["Puerto"].Value),
                PuertoSQL = Int32.Parse(servidorSQL.Attributes["Puerto"].Value),
                UsuarioSybase = servidorSybase.Attributes["Usuario"].Value,
                UsuarioSQL = servidorSQL.Attributes["Usuario"].Value,
                CredencialSybase = servidorSybase.Attributes["Clave"].Value,
                CredencialSQL = servidorSQL.Attributes["Clave"].Value
            };
            
            servidorSybase = null;
            servidorSQL = null;
            documento = null;
            cliente = null;
            
            return credenciales;
        }
    }
}
