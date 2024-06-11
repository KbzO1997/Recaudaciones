using OTCSAT.Entities;
using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services.Interfaces
{
    public interface IRecaudacionesService
    {

        /// <summary>
        /// Obtiene los tipos de servicios disponibles para pago desde OTC en SAT no matriculables
        /// </summary>
        /// <returns></returns>
        List<TipoServicio> ObtenerTiposServiciosNoMatriculables();

        /// <summary>
        /// Obtiene los tipos de servicios disponibles para pago desde OTC en SAT
        /// </summary>
        /// <param name="mostrarSoloMatriculables"></param>
        /// <returns></returns>
        List<TipoServicio> ObtenerTiposServicios(bool mostrarSoloMatriculables);

        /// <summary>
        /// Obtiene la lista de empresas configuradas en OTC por tipo de servicio
        /// </summary>
        /// <param name="servicio"></param>
        /// <param name="mostrarSoloMatriculables"></param>
        /// <returns></returns>
        List<Empresa> ObtenerEmpresasPorTipoServicio(string servicio, bool mostrarSoloMatriculables);

        /// <summary>
        /// Muestra un listado de empresas por servicios no matriculables
        /// </summary>
        /// <param name="servicio">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA, ect)</param>
        /// <returns>La lista de empresas por tipo servicio no matriculables</returns>
        List<Empresa> ObtenerEmpresasPorTipoServicioNoMatriculables(string servicio);

        /// <summary>
        /// Obtiene la definicion inicial de una empresa de recaudacion
        /// </summary>
        /// <param name="grupo">El tipo de servicio o grupo de recaudacion</param>
        /// <param name="empresa">El codigo de la empresa de recaudacion seleccionado</param>
        /// <param name="mostrarMatriculables">Marca que indica si se muestran o no los convenios matriculables, caso contrario mostrara los no matriculables</param>
        /// <returns></returns>
        DefinicionEmpresa ObtenerDefinicionEmpresaRecaudacion(string grupo, string empresa,bool mostrarMatriculables);

        /// <summary>
        /// Permite consultar la deuda de una recaudacion
        /// </summary>
        /// <param name="ordenante">El codigo de empresa SAT</param>
        /// <param name="usuario">El alias de usuario SAT</param>
        /// <param name="grupo">El grupo o tipo de empresa (AGUA, LUZ, TELEFONIA_FIJA, etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion</param>
        /// <param name="convenio">El convenio o subempresa de recaudacion</param>
        /// <param name="tipoIdentificador">El tipo de identificador</param>
        /// <param name="suministro">El codigo de suministro asociado</param>
        /// <param name="datosAdicionales">Datos adicionales de consulta provenientes del convenio</param>
        /// <returns>Los datos de consulta de la deuda y demas relevantes para la recaudacion</returns>
        RespuestaConsultaDeuda ConsultarDeuda(int ordenante, string usuario, string grupo, string empresaRecaudacion, string convenio, string tipoIdentificador, string suministro,DatoAdicional[]datosAdicionales);

        /// <summary>
        /// Obtiene la tarifa asociada a la empresa indicada por OTC
        /// </summary>
        /// <param name="ordenante">El codigo de la empresa SAT</param>
        /// <param name="grupo">El grupo o tipo de empresa (AGUA, LUZ, TELEFONIA_FIJA, etc)</param>
        /// <param name="empresaRecaudacion">El codigo de la empresa de recaudacion</param>
        /// <param name="convenio">El convenio o subempresa de recaudacion</param>
        /// <param name="monto">El monto de pago (sin comision)</param>
        /// <param name="rucEmpresa">RUC de la empresa SAT</param>
        /// <param name="tipoCuenta">Tipo de cuenta (AHO, CTE, VIR)</param>
        /// <param name="cuenta">Cuenta de debito de comision</param>
        /// <returns>La comision a aplicar para la recaudacion enviada</returns>
        RespuestaConsultaTarifa ObtenerTarifa(int ordenante, string grupo, string empresaRecaudacion, string convenio, double monto, string rucEmpresa, string tipoCuenta, string cuenta);

        /// <summary>
        /// Permite generar un comprobante de transaccion en SAT
        /// </summary>
        /// <param name="comprobante">Los datos del comprobante de pagos</param>
        /// <returns>La respuesta de la generacion del comprobante</returns>
        RespuestaGeneracionComprobante GenerarComprobante(Comprobante comprobante);

        /// <summary>
        /// Permite realizar un pago en OTC y generar el comprobante de pago (de ser exitoso)
        /// </summary>
        /// <param name="datosPago">Los datos del pago a enviar a OTC</param>
        /// <returns>La respuesta del pago realizado</returns>
        RespuestaPago Pagar(Pago datosPago);

        /// <summary>
        /// Obtiene los detalles a mostrar de un comprobante de pagos existente
        /// </summary>
        /// <param name="ordenBanco">El codigo de orden banco asociado</param>
        /// <returns>Los detalles del comprobante seleccionado</returns>
        List<DetalleComprobante> ObtenerDetallesComprobante(long ordenBanco);
    }
}
