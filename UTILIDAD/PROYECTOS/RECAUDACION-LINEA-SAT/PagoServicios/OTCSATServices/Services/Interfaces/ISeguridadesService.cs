using OTCSAT.Entities;
using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services.Interfaces
{
    public interface ISeguridadesService
    {

        /// <summary>
        /// Obtiene el nombre de la empresa indicada por codigo SAT
        /// </summary>
        /// <param name="codigo">El codigo de la empresa SAT</param>
        /// <returns>El nombre de la empresa asociada</returns>
        string ObtenerNombreEmpresa(int codigo);

        /// <summary>
        /// Obtiene el nemonico de la empresa indicada
        /// </summary>
        /// <param name="codigo">El codigo SAT de la empresa</param>
        /// <returns>El nemonico asociado a la empresa</returns>
        string ObtenerNemonicoEmpresa(int codigo);

        /// <summary>
        /// Obtiene los datos relevantes de un usuario
        /// </summary>
        /// <param name="empresa">Codigo de empresa SAT</param>
        /// <param name="nemonicoEmpresa">Nemonico de empresa SAT</param>
        /// <param name="usuario">Alias de usuario (sin nemonico)</param>
        /// <returns></returns>
        Usuario ObtenerDatosUsuario(int empresa, string nemonicoEmpresa, string usuario);

        /// <summary>
        /// Permite validar la clave de un dispositivo token
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El codigo del usuario de SAT que realiza la transaccion</param>
        /// <param name="token">El codigo del token generado para validar</param>
        /// <returns>El exito o fracaso de la operacion</returns>
        RespuestaValidacionDispositivo ValidarToken(int ordenante, string usuario, string token);

        /// <summary>
        /// Obtiene los datos basicos de una empresa SAT
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <returns>Los datos de la empresa</returns>
        EmpresaSAT ObtenerDatosOrdenante(int ordenante);

        /// <summary>
        /// Registra un evento de auditoria en SAT
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El usuario que realiza la accion</param>
        /// <param name="modulo">El modulo asociado a la opcion</param>
        /// <param name="transaccion">El codigo de transaccion invocado</param>
        /// <param name="accion">Nemonico de tres letras que define la accion realizada</param>
        /// <param name="descripcion">Descripcion de hasta 255 caracteres con el detalle de lo realizado</param>
        void RegistrarAuditoria(int ordenante, string usuario, int modulo, int transaccion, string accion, string descripcion);

        /// <summary>
        /// Determina si la sesion actual es valida
        /// </summary>
        /// <param name="token">El token de seguridad generado en el backend de SAT</param>
        /// <returns>Si la sesion es o no valida</returns>
        bool EsSesionValida(string token);

        /// <summary>
        /// Obtiene el tipo de dispositivo token asociado al usuario actual
        /// </summary>
        /// <param name="ordenante">El codigo del ordenante SAT</param>
        /// <param name="usuario">El alias del usaurio SAT</param>
        /// <returns>El tipo de dispositivo token asociado</returns>
        RespuestaConsultaTipoDispositivo ObtenerTipoDispositivo(int ordenante, string usuario);
    }
}
