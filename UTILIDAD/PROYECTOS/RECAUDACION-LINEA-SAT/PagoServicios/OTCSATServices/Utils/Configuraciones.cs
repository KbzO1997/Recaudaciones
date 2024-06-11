using extranet;
using OTCSATServices.Data;
using OTCSATServices.Entities;
using OTCSATServices.SecurityProvider;
using OTCSATServices.SecurityProvider.Interfaces;
using OTCSATServices.Utils.Interfaces;
using Sybase.Data.AseClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

namespace OTCSATServices.Utils
{
    /// <summary>
    /// Utilidades generales de sistema
    /// </summary>
    public class Configuraciones
    {

        public readonly static string HOST_SYBASE;
        public readonly static string PUERTO_SYBASE;
        public readonly static string HOST_SQL;
        public readonly static string PUERTO_SQL;
        public readonly static string USUARIO_SQL;
        public readonly static string USUARIO_SYBASE;
        public readonly static string CREDENCIAL_SYBASE;
        public readonly static string CREDENCIAL_MSSQL;
        public readonly static bool EMPRESA_TIENE_TRATAMIENTO_ENTERO; //  desa1 tiene tratamiento entero, desa2 no
        public readonly static string USUARIO_FRAWEWORK;
        public readonly static string APLICACION_FRAMEWORK;
        public readonly static string PROTOCOLO_NEGOCIACION;

        public readonly static string SALT_KEY = "316d702a3531626c452b2b";
        public readonly static string VECTOR_INICIALIZACION = "5040737377307264";

        public readonly static ICifrador CIFRADOR;

        private static bool NoValidarCeritificado(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors policyErrors)
        {
            return true;
        }

        static Configuraciones(){

            USUARIO_FRAWEWORK = ConfigurationManager.AppSettings.Get("USUARIO_FRAWEWORK");
            APLICACION_FRAMEWORK = ConfigurationManager.AppSettings.Get("APLICACION_FRAMEWORK");
            
            EMPRESA_TIENE_TRATAMIENTO_ENTERO = (ConfigurationManager.AppSettings.Get("EMPRESA_TIENE_TRATAMIENTO_ENTERO").Equals("true"));
            PROTOCOLO_NEGOCIACION = (ConfigurationManager.AppSettings.Get("PROTOCOLO_NEGOCIACION"));

            CIFRADOR = new CifradorRCA();

            switch (PROTOCOLO_NEGOCIACION)
            {
                case "TLS1.2":
                    // Ejecutar comportamiento defecto
                    ServicePointManager.Expect100Continue = true;
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                    break;
                case "TLS1.1":
                    // Ejecutar comportamiento TLS1.1
                    ServicePointManager.Expect100Continue = true;
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11;
                    break;
                case "TLS1.0":
                    // Ejecutar comportamiento TLS1.0
                    ServicePointManager.Expect100Continue = true;
                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
                    break;
                case "OTROS":
                    ServicePointManager.ServerCertificateValidationCallback += new RemoteCertificateValidationCallback(NoValidarCeritificado);
                    break;
            }

            // TODO Reemplazar proveedor en produccion por framework de seguridad
            //ISecurityProvider proveedorSeguridad = new HardcodedSecurityProvider();
            ISecurityProvider proveedorSeguridad = new FrameworkSecurityProvider(USUARIO_FRAWEWORK, APLICACION_FRAMEWORK);

            Credenciales credenciales = proveedorSeguridad.ObtenerCredenciales();

            HOST_SYBASE = credenciales.ServidorSybase;
            PUERTO_SYBASE = credenciales.PuertoSybase.ToString();
            USUARIO_SYBASE = credenciales.UsuarioSybase;
            CREDENCIAL_SYBASE = credenciales.CredencialSybase;

            HOST_SQL = ConfigurationManager.AppSettings.Get("SERVIDOR_SQL"); // Necesario por los ambientes interno y externo credenciales.ServidorSQL;
            PUERTO_SQL = credenciales.PuertoSQL.ToString();
            USUARIO_SQL = credenciales.UsuarioSQL;
            CREDENCIAL_MSSQL = credenciales.CredencialSQL;
            
            credenciales = null;
            proveedorSeguridad = null;
        }
        
        public static string ObtenerConfiguracionConexionSybase()
        {
            return $"Data Source={Configuraciones.HOST_SYBASE};Port={Configuraciones.PUERTO_SYBASE};Database=db_biz_servicios;Uid={Configuraciones.USUARIO_SYBASE};Pwd={Configuraciones.CREDENCIAL_SYBASE};";
        }
        
        /// <summary>
        /// Genera el parametro indicado para una ejecucion en sybase
        /// </summary>
        /// <param name="comando">Instancia de comando activo</param>
        /// <param name="nombre">Nombre del parametro</param>
        /// <param name="tipo">Tipo de parametro</param>
        /// <param name="direccion">Direccion del parametro</param>
        /// <param name="valor">Valor del parametro</param>
        /// <returns>El parametro para considerar</returns>
        public static AseParameter ConstruirParametro(AseCommand comando,string nombre, AseDbType tipo, System.Data.ParameterDirection direccion, object valor)
        {
            var parametro = comando.CreateParameter();
            parametro.ParameterName = nombre;
            parametro.AseDbType = tipo;
            parametro.Direction = direccion;

            if (direccion.Equals(System.Data.ParameterDirection.Input))
            {
                parametro.Value = valor;
            }
            
            return parametro;
        }

        /// <summary>
        /// Permite serializar los detalles de un comprobante de pago para persistirlos en el central
        /// </summary>
        /// <param name="comprobante">El comprobante de pagos</param>
        /// <returns>El comprobante de pago</returns>
        public static string SerializarDesgloses(Comprobante comprobante)
        {
            string salida = null;

            using (var stream = new StringWriter())
            {

                var serializer = new XmlSerializer(typeof(Comprobante));

                using (var wr = XmlWriter.Create(stream))
                {
                    serializer.Serialize(wr, comprobante);
                    salida = stream.ToString();
                }

            }

            return salida;
        }

        /// <summary>
        /// Por cambios en SAT devuelve el codigo de empresa homologado para 4 ceros o el codigo en tipo integer
        /// </summary>
        /// <param name="empresa">El codigo de empresa</param>
        /// <returns>El codigo de empresa homologado</returns>
        public static string ObtenerCodigoEmpresaHomologado(int empresa)
        {
            return ((EMPRESA_TIENE_TRATAMIENTO_ENTERO) ? empresa.ToString() : empresa.ToString("0000"));
        }

        /// <summary>
        /// Determina si el servicio de recaudacion enviado es valido o existente
        /// </summary>
        /// <param name="servicio">El codigo del servicio en OTC (AGUA, LUZ, etc)</param>
        /// <returns>Si el servicio enviado es o no valido</returns>
        public static bool EsServicioRecaudacionValido(string servicio)
        {
            bool esValido = false;

            if (!string.IsNullOrEmpty(servicio))
            {
                esValido = (
                    servicio.Equals("AGUA") || 
                    servicio.Equals("AUTOMOTORES_PEATONES") || 
                    servicio.Equals("IMPUESTOS_OBLIGACIONES") || 
                    servicio.Equals("LUZ") || 
                    servicio.Equals("TELEFONIA_FIJA") ||                     
                    servicio.Equals("DEPOSITO_ESPECIAL_EN_LINEA") ||
                    servicio.Equals("CASAS_TARJETAS_COMERCIALES"));  //dpereirv 10/15/2020
            }
            
            return esValido;
        }

        /// <summary>
        /// Enmascara la cuenta indicada
        /// </summary>
        /// <param name="cuenta">El numero de cuenta a enmascarar</param>
        /// <returns>La cuenta enmascarada</returns>
        public static string ObtenerCuentaEnmascarada(string cuenta)
        {
            cuenta = (cuenta != null && !string.IsNullOrEmpty(cuenta)) ? cuenta : "0000000000";
            return cuenta.Substring(0,3)+"XXXX" + cuenta.Substring(7);
        }

        /// <summary>
        /// Determina si un convenio es o no matriculable
        /// </summary>
        /// <param name="grupo">El grupo de recaudacion (AGUA, LUZ, TELEFONIA_FIJA, etc)</param>
        /// <param name="empresa">El codigo de la empresa de recaudacion</param>
        /// <param name="convenio">El codigo del convenio-subempresa asociado a la empresa de recaudacion</param>
        /// <returns>Si el convenio es o no matriculable</returns>
        public static bool EsConvenioMatriculable(string grupo,string empresa,string convenio)
        {
            bool esMatriculable = false;

            esMatriculable = !(
                (grupo.Equals("IMPUESTOS_OBLIGACIONES") && empresa.Equals("1114")) ||
                (grupo.Equals("IMPUESTOS_OBLIGACIONES") && empresa.Equals("1113")) ||
                (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("2572") && convenio.Equals("TRA")) ||
                (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("6388") && convenio.Equals("SOL"))||
				(grupo.Equals("DEPOSITO_ESPECIAL_EN_LINEA") && empresa.Equals("6930")) || //dpereirv
                (grupo.Equals("DEPOSITO_ESPECIAL_EN_LINEA") && empresa.Equals("26")) //dolayas																			  
            );

            return esMatriculable;
        }

        /// <summary>
        /// Determina si la empresa es deposito temporal (usado por validaciones especiales)
        /// </summary>
        /// <param name="grupo">El grupo de recaudacion (AGUA, LUZ, TELEFONIA_FIJA, etc)</param>
        /// <param name="empresa">El codigo de la empresa de recaudacion</param>
        /// <returns>Si la empresa es o no deposito temporal</returns>
        public static bool EsDepositoTemporal(string grupo,string empresa)
        {
            return (grupo.Equals("IMPUESTOS_OBLIGACIONES") && empresa.Equals("1113"));
        }

        /// <summary>
        /// Genera un secuencial pseudo-aleatorio de la transaccion actual a enviar a OTC
        /// </summary>
        /// <returns>El secuencial de transaccion</returns>
        public static string ObtenerSecuencialTransaccion()
        {
            int secuencia = 10000;
            int minimo = 10000;
            int maximo = 999999;

            using (RNGCryptoServiceProvider proveedorCriptografico = new RNGCryptoServiceProvider())
            {
                uint escala = uint.MaxValue;
                while (escala == uint.MaxValue)
                {
                    byte[] chunkMemoria = new byte[4];
                    proveedorCriptografico.GetBytes(chunkMemoria);
                    escala = BitConverter.ToUInt32(chunkMemoria, 0);
                }

                secuencia = ((int)(minimo + (maximo - minimo) * (escala / (double)uint.MaxValue)));
            }
            
            // Inseguro
            //secuencia = new Random().Next(10000, 999999).ToString();

            return secuencia.ToString();
        }
        
        /// <summary>
        /// Determina si el token enviado es valido
        /// </summary>
        /// <param name="token">El token a validar</param>
        /// <returns>Si el token es o no valido</returns>
        public static bool EsTokenValido(string token)
        {
            bool esValido = false;
            bool esSaltKeyValido = false;
            string trama = CIFRADOR.DesencriptarCadena(token, VECTOR_INICIALIZACION);
            int tiempoMaximo = 10;
            
            if (!string.IsNullOrEmpty(trama) && trama.Contains("|"))
            {
                string[] lsConfiguraciones = trama.Split(new char[] { '|' });

                esSaltKeyValido = (lsConfiguraciones[1].Equals(SALT_KEY));

                DateTime fechaServidor = DateTime.Now;
                DateTime fechaCliente = new DateTime();
                fechaCliente = DateTime.ParseExact(lsConfiguraciones[0], "yyyy/MM/dd HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);

                TimeSpan diferenciaFechas = fechaServidor.Subtract(fechaCliente);

                long tiempoTranscurrido = ((fechaServidor.Subtract(fechaCliente).Days * 24 * 60) + (fechaServidor.Subtract(fechaCliente).Hours * 60) + fechaServidor.Subtract(fechaCliente).Minutes);
                
                esValido = (tiempoTranscurrido < tiempoMaximo);
            }
            else
            {
                esSaltKeyValido = false;
                esValido = false;
            }

            return (esValido && esSaltKeyValido);
        }
    }
}
