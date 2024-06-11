using OTCSATServices.Entities;
using OTCSATServices.SecurityProvider.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.SecurityProvider
{
    /// <summary>
    /// Proveedor de credenciales quemadas, usar solo en desarrollo para pruebas internas
    /// </summary>
    class HardcodedSecurityProvider: ISecurityProvider
    {
        /// <summary>
        /// Obtiene las credenciales de conexion a base de datos
        /// </summary>
        /// <returns>Las credenciales de conexion a base de datos</returns>
        public Credenciales ObtenerCredenciales()
        {
            
            return new Credenciales
            {
                ServidorSQL = "sat2k8bdesa2srv",
                PuertoSQL = 2668,
                CredencialSQL = "P@ssw0rd",
                ServidorSybase = "172.16.23.22",
                PuertoSybase = 2050,
                CredencialSybase = "P@ssw0rd",
                UsuarioSQL = "sa",
                UsuarioSybase = "operadorSat"
            };
            /*
            
            return new Credenciales
            {
                ServidorSQL = "sat2008bdsrv",
                PuertoSQL = 2668,
                CredencialSQL = "P@ssw0rd",
                ServidorSybase = "172.16.23.22",
                PuertoSybase = 2030,
                CredencialSybase = "SAT*2013",
                UsuarioSQL = "sa",
                UsuarioSybase = "operadorSat"
            };
            */
        }
    }
}
