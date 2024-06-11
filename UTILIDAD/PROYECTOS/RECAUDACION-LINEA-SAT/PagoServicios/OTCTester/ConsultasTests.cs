using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OTCSATServices.Services;

namespace OTCTester
{
    [TestClass]
    public class ConsultasTests
    {
        readonly SeguridadesService servicio = new SeguridadesService();

        public void FixEfProviderServicesProblem()
        {
            //The Entity Framework provider type 'System.Data.Entity.SqlServer.SqlProviderServices, EntityFramework.SqlServer'
            //for the 'System.Data.SqlClient' ADO.NET provider could not be loaded. 
            //Make sure the provider assembly is available to the running application. 
            //See http://go.microsoft.com/fwlink/?LinkId=260882 for more information.

            System.Data.Entity.

            var instance = System.Data.Entity.SqlServer.SqlProviderServices.Instance;
        }

        [TestMethod]
        public void ObtenerNombreEmpresa()
        {
            string nombreEmpresa = servicio.obtenerNombreEmpresa(9999);
            Assert.IsNotNull(nombreEmpresa);
        }

        [TestMethod]
        public void ObtenerNemonicoEmpresa()
        {
            string nemomico = servicio.obtenerNemonicoEmpresa(9999);
            Assert.IsNotNull(nemomico);
            Assert.Equals(nemomico, "BCBOL");
        }
    }
}
