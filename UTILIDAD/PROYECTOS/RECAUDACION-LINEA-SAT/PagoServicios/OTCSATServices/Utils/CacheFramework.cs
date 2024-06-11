using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Utils
{
    public class CacheFramework
    {
        private static readonly int TiempoVigencia = 60;
        private static DateTime FechaUltimaActualizacion;
        private static Credenciales CredencialesCache = new Credenciales();

        /// <summary>
        /// Determina si el cache actual es vigente
        /// La vigencia esta dada por la vida de los parametros a 1 dia
        /// </summary>
        /// <returns>Si el cache es o no vigente</returns>
        [MethodImpl(MethodImplOptions.Synchronized)]
        public static bool EsCacheVigente()
        {
            bool esVigente = false;

            if (FechaUltimaActualizacion != null)
            {
                DateTime fechaServidor = DateTime.Now;

                TimeSpan diferenciaFechas = fechaServidor.Subtract(FechaUltimaActualizacion);
                long tiempoTranscurrido = ((fechaServidor.Subtract(FechaUltimaActualizacion).Days * 24 * 60) + (fechaServidor.Subtract(FechaUltimaActualizacion).Hours * 60) + fechaServidor.Subtract(FechaUltimaActualizacion).Minutes);

                esVigente = (tiempoTranscurrido < 1440);

            }

            return esVigente;
        }

        /// <summary>
        /// Determina si los datos en el cache son validos
        /// </summary>
        /// <returns></returns>
        [MethodImpl(MethodImplOptions.Synchronized)]
        public static bool EsCacheValido()
        {
            bool sonParametrosValidos = true;

            if(CredencialesCache != null)
            {
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.ServidorSybase));
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.ServidorSQL));
                sonParametrosValidos = sonParametrosValidos && (CredencialesCache.PuertoSybase>0);
                sonParametrosValidos = sonParametrosValidos && (CredencialesCache.PuertoSQL>0);
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.UsuarioSybase));
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.UsuarioSQL));
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.CredencialSybase));
                sonParametrosValidos = sonParametrosValidos && (!string.IsNullOrEmpty(CredencialesCache.CredencialSQL));
            }
            else
            {
                sonParametrosValidos = false;
            }
            
            sonParametrosValidos = sonParametrosValidos && (TiempoVigencia > 0);
            
            return sonParametrosValidos;
        }

        [MethodImpl(MethodImplOptions.Synchronized)]
        public static void ActualizarCache(Credenciales credenciales)
        {
            if (CredencialesCache == null)
            {
                CredencialesCache = new Credenciales();
            }

            CredencialesCache.ServidorSybase = credenciales.ServidorSybase;
            CredencialesCache.ServidorSQL = credenciales.ServidorSQL;
            CredencialesCache.PuertoSybase = credenciales.PuertoSybase;
            CredencialesCache.PuertoSQL = credenciales.PuertoSQL;
            CredencialesCache.UsuarioSybase = credenciales.UsuarioSybase;
            CredencialesCache.UsuarioSQL = credenciales.UsuarioSQL;
            CredencialesCache.CredencialSybase = credenciales.CredencialSybase;
            CredencialesCache.CredencialSQL = credenciales.CredencialSQL;

            FechaUltimaActualizacion = DateTime.Now;
            
        }

        [MethodImpl(MethodImplOptions.Synchronized)]
        public static Credenciales ObtenerCredenciales()
        {
            return CredencialesCache;
        }
    }
}
