using OTCSAT.Entities;
using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services.Interfaces
{
    public interface ICatalogosService
    {
        /// <summary>
        /// Obtiene el listado de estados disponibles
        /// </summary>
        /// <returns>Los estados disponibles</returns>
        List<Estado> ObtenerEstados();

        /// <summary>
        /// Obtiene un listado de cuentas asociadas por servicio empresa
        /// </summary>
        /// <param name="empresa">El codigo de la empresa SAT</param>
        /// <param name="servicio">El servicio asociado a las cuentas empresa SAT</param>
        /// <returns>La lista de cuentas asociadas a la empresa servicio</returns>
        List<Cuenta> ObtenerCuentasPorServicioEmpresa(int empresa, string servicio);

        /// <summary>
        /// Obtiene una lista de cuentas asociadas por empresa usuario (aplica para pago de servicios)
        /// </summary>
        /// <param name="empresa">El codigo del ordenante SAT</param>
        /// <param name="usuario">El alias del usuario</param>
        /// <returns>La lista de cuentas asociadas por empresa usuario</returns>
        List<Cuenta> ObtenerCuentasPorEmpresaUsuario(int empresa, string usuario);

        /// <summary>
        /// Permite listar empresas SAT por filtro de busqueda nombre
        /// </summary>
        /// <param name="nombre">El nombre de la empresa (parcial o total)</param>
        /// <returns>La lista de empresas que cumplen con el parametro de nombre indicado</returns>
        List<Empresa> ObtenerEmpresasPorNombre(string nombre = "");

        /// <summary>
        /// Permite consultar los cupos asociados al servicio de recaudacion empresa indicado
        /// </summary>
        /// <param name="ordenante">El ordenante SAT</param>
        /// <param name="usuario">El codigo de usuario</param>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO)</param>
        /// <param name="cuenta">El codigo de la cuenta</param>
        /// <param name="grupo">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA,etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion OTC</param>
        /// <param name="convenio">El codigo del convenio</param>
        /// <returns>Los cupos vigentes para la empresa-servicio-grupo</returns>
        RespuestaConsultaCupos ObtenerCuposServicio(int ordenante, string usuario, string tipoCuenta, string cuenta, string grupo, int empresaRecaudacion, string convenio);

        /// <summary>
        /// Permite actualizar el cupo asociado al servicio de recaudacion empres indicado
        /// </summary>
        /// <param name="ordenante">El ordenante SAT</param>
        /// <param name="usuario">El codigo del usuario</param>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO)</param>
        /// <param name="cuenta">El codigo de la cuenta</param>
        /// <param name="grupo">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA,etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion OTC</param>
        /// <param name="convenio">El codigo del convenio</param>
        /// <param name="monto">El monto a transaccionar</param>
        /// <param name="comision">La comision asociada a la transaccion</param>
        /// <param name="consulta">Bandera de solo consulta: S/N</param>
        /// <returns>El exito o fracaso de la actualizacion de cupos</returns>
        Respuesta ActualizarCupoServicio(int ordenante, string usuario, string tipoCuenta, string cuenta, string grupo, int empresaRecaudacion, string convenio, double monto, double comision, string consulta);

        /// <summary>
        /// Obtiene el saldo disponible de una cuenta
        /// </summary>
        /// <param name="tipoCuenta">El tipo de cuenta (CTE|AHO|VIR)</param>
        /// <param name="cuenta">El numero de la cuenta</param>
        /// <returns>El saldo disponible de la cuenta</returns>
        RespuestaConsultaCuenta ObtenerSaldoCuenta(string tipoCuenta, string cuenta);
    }
}
