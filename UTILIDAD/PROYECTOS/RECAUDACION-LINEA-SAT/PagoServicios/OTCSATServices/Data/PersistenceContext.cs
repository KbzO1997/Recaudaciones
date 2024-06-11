using OTCSATServices.Utils;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Data
{
    /// <summary>
    /// Contexto inicial de EF MSSQL
    /// </summary>
    public class PersistenceContext:SATDB
    {
        public PersistenceContext():base()
        { 
            this.Database.Connection.ConnectionString = $"data source={Configuraciones.HOST_SQL},{Configuraciones.PUERTO_SQL};initial catalog=db_seguridad;persist security info=True;user id={Configuraciones.USUARIO_SQL};PWD={Configuraciones.CREDENCIAL_MSSQL};multipleactiveresultsets=True;application name=EntityFramework";
        }
    }
}
