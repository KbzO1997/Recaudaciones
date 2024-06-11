using OTCSAT.Entities;
using OTCSATServices.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services.Interfaces
{
    public interface IMatriculacionesService
    {
        /// <summary>
        /// Consulta las matriculaciones existentes por los filtros de busqueda indicados
        /// </summary>
        /// <param name="ordenante">Codigo de Empresa SAT</param>
        /// <param name="usuario">Codigo de Usuario SAT</param>
        /// <param name="grupo">Agrupacion de Recaudacion</param>
        /// <param name="empresaRecaudacion">Empresa de Recaudacion</param>
        /// <param name="convenio">Convenio asociado a la empresa</param>
        /// <param name="indiceInicial">Indice de Busqueda Inicial</param>
        /// <param name="registrosPorPagina">Registros Por Pagina</param>
        /// <returns>La lista de matriculaciones segun los filtros de busqueda</returns>
        IEnumerable<Matriculacion> ObtenerMatriculaciones(
            int ordenante = 0,
            string usuario = "T",
            string grupo = "T",
            int empresaRecaudacion = 0,
            string convenio = "T",
            string estado = "T",
            int indiceInicial = 0,
            int registrosPorPagina = 10);

        /// <summary>
        /// Permite guardar una matriculacion
        /// </summary>
        /// <param name="cabecera">Cabecera de la matriculacion</param>
        /// <param name="datosAdicionales">Datos o campos adicionales a ingresar</param>
        /// <returns></returns>
        Respuesta GuardarMatriculacion(Matriculacion cabecera, List<DatoAdicional> datosAdicionales);

        /// <summary>
        /// Obtiene los grupos (tipos) de recaudacion matriculados y activos para el usuario SAT indicado
        /// </summary>
        /// <param name="ordenante">Codigo de la empresa SAT</param>
        /// <param name="usuario">Codigo del usuario SAT</param>
        /// <returns>Lista de grupos (tipos) de recaudaciones matriculadas y disponibles para el usuario</returns>
        List<TipoServicio> ObtenerGruposPorUsuarioEmpresa(int ordenante, string usuario);

        /// <summary>
        /// Obtiene los datos de una matriculacion en especifico segun el identificador unico
        /// </summary>
        /// <param name="secuencia">Identificador unico de la matriculacion</param>
        /// <returns>La matriculacion existente en el sistema</returns>
        RespuestaConsultaMatriculacion ObtenerMatriculacion(int secuencia);

        /// <summary>
        /// Permite modificar una matriculacion
        /// </summary>
        /// <param name="secuencia">El identificador de matriculacion</param>
        /// <param name="cabecera">Los datos a modificar</param>
        /// <returns>El exito o fracaso de la operacion</returns>
        Respuesta ModificarMatriculacion(int secuencia, Matriculacion cabecera);
    }
}
