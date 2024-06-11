using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.SecurityProvider.Interfaces
{
    public interface ISecurityProvider
    {
        /// <summary>
        /// Obtiene las credenciales de conexion a base de datos
        /// </summary>
        /// <returns>Las credenciales de conexion a base de datos</returns>
        Credenciales ObtenerCredenciales();
    }
}
