using log4net;
using OTCSAT.Entities;
using OTCSATServices.ClienteOTC;
using OTCSATServices.Entities;
using OTCSATServices.Services.Interfaces;
using OTCSATServices.Utils;
using Sybase.Data.AseClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace OTCSATServices.Services
{
    public class RecaudacionesService : IRecaudacionesService
    {

        private static ILog logger = LogManager.GetLogger(typeof(RecaudacionesService));

        public RecaudacionesService()
        {

        }

        /// <summary>
        /// Obtiene los tipos de servicios disponibles para pago desde OTC en SAT no matriculables
        /// </summary>
        /// <returns></returns>
        public List<TipoServicio> ObtenerTiposServiciosNoMatriculables()
        {
            List<TipoServicio> servicios = new List<TipoServicio>
            {
                new TipoServicio { Codigo = "PAGO_ADUANA", Descripcion = "Servicios Aduaneros" }, //KBastida RECMPS-1553
                new TipoServicio { Codigo = "AUTOMOTORES_PEATONES", Descripcion = "Automotores y Peatones" },
                new TipoServicio { Codigo = "IMPUESTOS_OBLIGACIONES", Descripcion = "Impuestos y Obligaciones" },
                new TipoServicio { Codigo = "DEPOSITO_ESPECIAL_EN_LINEA", Descripcion = "Deposito especial en línea"},  //dpereirv																							  
                new TipoServicio { Codigo = "CASAS_TARJETAS_COMERCIALES", Descripcion = "Tarjetas comerciales / almacenes"},  //dpereirv 10/15/2020
                new TipoServicio { Codigo = "OTROS", Descripcion = "Otros"} //despinoa RECMPS-449
            };

            return servicios;
        }

        /// <summary>
        /// Obtiene los tipos de servicios disponibles para pago desde OTC en SAT
        /// </summary>
        /// <param name="mostrarSoloMatriculables"></param>
        /// <returns></returns>
        public List<TipoServicio> ObtenerTiposServicios(bool mostrarSoloMatriculables)
        {
            List<TipoServicio> servicios = new List<TipoServicio>
            {
                new TipoServicio { Codigo = "AGUA", Descripcion = "Agua" },
                new TipoServicio { Codigo = "AUTOMOTORES_PEATONES", Descripcion = "Automotores y Peatones" },
                // jvillavc SATM-185 No mostrar municipios como matriculable
                //new TipoServicio { Codigo = "IMPUESTOS_OBLIGACIONES", Descripcion = "Impuestos y Obligaciones" },
                new TipoServicio { Codigo = "LUZ", Descripcion = "Luz" },
                new TipoServicio { Codigo = "TELEFONIA_FIJA", Descripcion = "Telefonia Fija" }
            };

            return servicios;
        }

        /// <summary>
        /// Muestra un listado de empresas por servicios no matriculables
        /// </summary>
        /// <param name="servicio">El grupo de recaudacion (AGUA,LUZ,TELEFONIA_FIJA, ect)</param>
        /// <returns>La lista de empresas por tipo servicio no matriculables</returns>
        public List<Empresa> ObtenerEmpresasPorTipoServicioNoMatriculables(string servicio)
        {

            List<Empresa> empresas = new List<Empresa>();

            if (!String.IsNullOrEmpty(servicio))
            {

                ClienteOTC.OTCEndpointClient cliente = new ClienteOTC.OTCEndpointClient();

                ClienteOTC.mensajeEntradaConsultarEmpresa entradaCliente = new ClienteOTC.mensajeEntradaConsultarEmpresa
                {
                    canal = "SAT",
                    depuracion = "N",
                    oficina = "0",
                    secuencial = DateTime.Now.ToLongTimeString(),
                    tipoBanca = "BP",
                    transaccion = "2056",
                    usuario = "srolese",
                    tipoServicio = (servicio.Equals("DEPOSITO_ESPECIAL_EN_LINEA")) ? "TRANSFERENCIA_ESPECIAL" : servicio   //dpereirv, por solicitud de PO
                };

                ClienteOTC.mensajeSalidaConsultarEmpresa respuesta = cliente.consultarEmpresa(entradaCliente);

                logger.Debug(string.Format("Consulta de Empresas OTC No Matriculables codigoError: {0}", respuesta.codigoError));

                if (respuesta.codigoError.Equals("0") && respuesta.empresas != null && respuesta.empresas.Length > 0)
                {
                    foreach (var item in respuesta.empresas)
                    {
                        if (((servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1114")) ||
                            (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1113")) ||
                            // SATM-185 Mostrar pago de municipios como no matriculable
                            (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1112")) ||
                            (servicio.Equals("AUTOMOTORES_PEATONES") && item.codigoEmpresa.Equals("6388")) ||
                            (servicio.Equals("AUTOMOTORES_PEATONES") && item.codigoEmpresa.Equals("2572")) ||
                            (servicio.Equals("AUTOMOTORES_PEATONES") && item.codigoEmpresa.Equals("8461")) || // jrocafuf 23/02/2021
                            (servicio.Equals("DEPOSITO_ESPECIAL_EN_LINEA") && item.codigoEmpresa.Equals("6930")) ||
                            (servicio.Equals("DEPOSITO_ESPECIAL_EN_LINEA") && item.codigoEmpresa.Equals("26")) ||  //dolayas
                            (servicio.Equals("CASAS_TARJETAS_COMERCIALES") && item.codigoEmpresa.Equals("8462")) ||  // dpereirv	10/15/2020
                            (servicio.Equals("OTROS") && item.codigoEmpresa.Equals("8269")) || //despinoa RECMPS-449
                            (servicio.Equals("PAGO_ADUANA") && item.codigoEmpresa.Equals("1929"))) //KBastida RECMPS-1553

                            )
                        {
                            empresas.Add(new Empresa() { Codigo = item.codigoEmpresa, Descripcion = item.etiquetaEmpresa });
                        }


                    }
                }
            }

            return empresas;
        }

        /// <summary>
        /// Obtiene la lista de empresas configuradas en OTC por tipo de servicio
        /// </summary>
        /// <param name="servicio"></param>
        /// <param name="mostrarSoloMatriculables"></param>
        /// <returns></returns>
        public List<Empresa> ObtenerEmpresasPorTipoServicio(string servicio, bool mostrarSoloMatriculables)
        {

            List<Empresa> empresas = new List<Empresa>();

            if (!String.IsNullOrEmpty(servicio) && Configuraciones.EsServicioRecaudacionValido(servicio))
            {

                ClienteOTC.OTCEndpointClient cliente = new ClienteOTC.OTCEndpointClient();

                ClienteOTC.mensajeEntradaConsultarEmpresa entradaCliente = new ClienteOTC.mensajeEntradaConsultarEmpresa
                {
                    canal = "SAT",
                    depuracion = "N",
                    oficina = "0",
                    secuencial = DateTime.Now.ToLongTimeString(),
                    tipoBanca = "BP",
                    transaccion = "2056",
                    usuario = "srolese",
                    tipoServicio = servicio
                };

                cliente.InnerChannel.OperationTimeout = TimeSpan.FromSeconds(8);

                ClienteOTC.mensajeSalidaConsultarEmpresa respuesta = cliente.consultarEmpresa(entradaCliente);

                logger.Debug(string.Format("Consulta de Empresas OTC codigoError: {0}", respuesta.codigoError));

                if (respuesta.codigoError.Equals("0") && respuesta.empresas != null && respuesta.empresas.Length > 0)
                {
                    foreach (var item in respuesta.empresas)
                    {
                        if (mostrarSoloMatriculables)
                        {
                            if (!(
                                    (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1114")) ||
                                    // jvillavc SATM-185 No mostrar municipios como matriculable
                                    (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1112")) ||
                                    (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("1113")) ||
                                    (servicio.Equals("AUTOMOTORES_PEATONES") && item.codigoEmpresa.Equals("8461")) || // jrocafuf 23/02/2021
                                    (servicio.Equals("IMPUESTOS_OBLIGACIONES") && item.codigoEmpresa.Equals("940")) ||
                                    (servicio.Equals("OTROS") && item.codigoEmpresa.Equals("8269")) || // despinoa RECMPS-449
                                    (servicio.Equals("PAGO_ADUANA") && item.codigoEmpresa.Equals("1929")) //KBastida RECMPS-1553
                                    )
                             )
                            {
                                empresas.Add(new Empresa() { Codigo = item.codigoEmpresa, Descripcion = item.etiquetaEmpresa });
                            }
                        }
                        else
                        {
                            empresas.Add(new Empresa() { Codigo = item.codigoEmpresa, Descripcion = item.etiquetaEmpresa });
                        }

                    }
                }
            }

            return empresas;
        }

        /// <summary>
        /// Obtiene la definicion inicial de una empresa de recaudacion
        /// </summary>
        /// <param name="grupo">El tipo de servicio o grupo de recaudacion</param>
        /// <param name="empresa">El codigo de la empresa de recaudacion seleccionado</param>
        /// <param name="mostrarMatriculables">Marca que indica si se muestran o no los convenios matriculables, caso contrario mostrara los no matriculables</param>
        /// <returns></returns>
        public DefinicionEmpresa ObtenerDefinicionEmpresaRecaudacion(string grupo, string empresa, bool mostrarMatriculables)
        {
            DefinicionEmpresa definicion = new DefinicionEmpresa();

            ClienteOTC.OTCEndpointClient cliente = new ClienteOTC.OTCEndpointClient();

            ClienteOTC.mensajeEntradaConsultarEmpresa entradaCliente = new ClienteOTC.mensajeEntradaConsultarEmpresa
            {
                canal = "SAT",
                depuracion = "N",
                oficina = "0",
                secuencial = DateTime.Now.ToLongTimeString(),
                tipoBanca = "BP",
                transaccion = "2056",
                usuario = "srolese",
                tipoServicio = (grupo.Equals("DEPOSITO_ESPECIAL_EN_LINEA")) ? "TRANSFERENCIA_ESPECIAL" : grupo   //dpereirv, por solicitud de PO
            };

            ClienteOTC.mensajeSalidaConsultarEmpresa respuesta = cliente.consultarEmpresa(entradaCliente);

            logger.Debug(string.Format("Definicion Empresa: {0}", respuesta.codigoError));

            if (respuesta.codigoError.Equals("0") && respuesta.empresas != null && respuesta.empresas.Length > 0)
            {
                ClienteOTC.empresa empresaActual = respuesta
                    .empresas
                    .Where(x => x.codigoEmpresa.Equals(empresa.ToString()))
                    .First();

                definicion.Empresa = empresa;
                definicion.Grupo = grupo;
                definicion.NombreEmpresa = empresaActual.etiquetaEmpresa;
                definicion.Convenios = new List<Convenio>();

                foreach (ClienteOTC.convenio convenioActual in empresaActual.convenios)
                {
                    Convenio convenio = new Convenio
                    {
                        Codigo = convenioActual.codigo,
                        Etiqueta = convenioActual.etiquetaCodigo,
                        Identificadores = new List<Identificador>()
                    };

                    foreach (ClienteOTC.tipoIdentificador identificadorActual in convenioActual.tipoIdentificadores)
                    {

                        List<DatoAdicional> adicionalesIdentificador = new List<DatoAdicional>();
                        List<string> regionales = new List<string>();

                        if (identificadorActual.datosAdicionales != null && identificadorActual.datosAdicionales.Count() > 0)
                        {
                            foreach (datoAdicional datoInterno in identificadorActual.datosAdicionales)
                            {
                                var datoInternoConvenio = new DatoAdicional
                                {
                                    Id = datoInterno.codigo,
                                    Etiqueta = datoInterno.etiqueta,
                                    EsEditable = datoInterno.editable,
                                    Mascara = datoInterno.mascara,
                                    RegExp = datoInterno.regexp,
                                    Tipo = datoInterno.tipo,
                                    EsVisible = datoInterno.visible,
                                    ValorSeleccionado = datoInterno.valor
                                };

                                if (datoInterno.listasSeleccion != null && datoInterno.listasSeleccion.Count() > 0)
                                {
                                    List<ItemSeleccion> comboInterno = new List<ItemSeleccion>();

                                    foreach (listaSeleccion comboOTC in datoInterno.listasSeleccion)
                                    {
                                        comboInterno.Add(new ItemSeleccion
                                        {
                                            Codigo = comboOTC.codigo,
                                            Descripcion = comboOTC.etiqueta
                                        });
                                    }

                                    datoInternoConvenio.Valores = comboInterno;
                                }

                                adicionalesIdentificador.Add(datoInternoConvenio);
                            }

                        }

                        if (identificadorActual.regionalAreas != null && identificadorActual.regionalAreas.Count() > 0)
                        {
                            foreach (regionalArea regionalActual in identificadorActual.regionalAreas)
                            {
                                regionales.Add(regionalActual.codigo);
                            }
                        }

                        Identificador identificador = new Identificador
                        {
                            Codigo = identificadorActual.codigo,
                            EsMatriculable = identificadorActual.matriculable,
                            Etiqueta = identificadorActual.etiquetaCodigo,
                            Mascara = identificadorActual.mascara,
                            RegExp = identificadorActual.regexp,
                            TextoAyuda = identificadorActual.textoAyuda
                        };

                        if (adicionalesIdentificador != null && adicionalesIdentificador.Count() > 0)
                        {
                            identificador.DatosAdicionales = adicionalesIdentificador;
                        }

                        if (regionales != null && regionales.Count() > 0)
                        {
                            identificador.RegionalesArea = regionales;
                        }

                        convenio.Identificadores.Add(identificador);
                    }

                    bool mostrarEsteConvenio = false;

                    if (mostrarMatriculables)
                    {
                        // Solo se mostraran convenios matriculables

                        mostrarEsteConvenio = !(
                            (grupo.Equals("IMPUESTOS_OBLIGACIONES") && empresa.Equals("1114")) ||
                            (grupo.Equals("IMPUESTOS_OBLIGACIONES") && empresa.Equals("1113")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("2572") && convenio.Codigo.Equals("TRA")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("6388") && convenio.Codigo.Equals("SOL"))
                        );
                    }
                    else
                    {
                        // Mostrar convenios no matriculables

                        mostrarEsteConvenio = !(
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("2572") && convenio.Codigo.Equals("CIT")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("5993") && convenio.Codigo.Equals("IVM")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("5993") && convenio.Codigo.Equals("MAT")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("6388") && convenio.Codigo.Equals("CIT")) ||
                            (grupo.Equals("AUTOMOTORES_PEATONES") && empresa.Equals("6388") && convenio.Codigo.Equals("REN")) ||
                            (grupo.Equals("DEPOSITO_ESPECIAL_EN_LINEA") && (!empresa.Equals("6930") && !empresa.Equals("26")) || //dolayas
                            (grupo.Equals("CASAS_TARJETAS_COMERCIALES") && !empresa.Equals("8462"))) //dpereirv 10/15/2020
                        );
                    }

                    if (mostrarEsteConvenio)
                    {
                        definicion.Convenios.Add(convenio);
                    }

                }
            }

            return definicion;
        }

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
        public RespuestaConsultaDeuda ConsultarDeuda(int ordenante, string usuario, string grupo, string empresaRecaudacion, string convenio, string tipoIdentificador, string suministro, DatoAdicional[] datosAdicionales)
        {
            logger.Info($"Consulta de Deuda: Ordenante {ordenante} Usuario {usuario} Grupo {grupo} EmpresaRecaudacion {empresaRecaudacion} Convenio {convenio} TipoIdentificador {tipoIdentificador} Suministro {suministro}");

            RespuestaConsultaDeuda respuesta = new RespuestaConsultaDeuda
            {
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = -1,
                    ExitoOperacion = false,
                    MensajeError = "ERROR GENERAL EN CONSULTA"
                }
            };

            try
            {
                ClienteOTC.OTCEndpointClient cliente = new ClienteOTC.OTCEndpointClient();

                List<datoAdicional> datosAdicionalesConvenio = null;

                if (datosAdicionales != null && datosAdicionales.Count() > 0)
                {
                    // El convenio tiene datos adicionales de consulta que llenar
                    // Usado en el caso de SRI
                    datosAdicionalesConvenio = new List<datoAdicional>();

                    foreach (var datoAdicicionalActual in datosAdicionales)
                    {
                        datosAdicionalesConvenio.Add(new datoAdicional
                        {
                            codigo = datoAdicicionalActual.Id,
                            valor = datoAdicicionalActual.ValorSeleccionado
                        });
                    }
                }

                mensajeSalidaConsultarDeuda respuestaOTC = cliente.consultarDeuda(new ClienteOTC.mensajeEntradaConsultarDeuda
                {
                    canal = "SAT",
                    depuracion = "N",
                    fecha = DateTime.Now,
                    oficina = "0",
                    transaccion = "2056",
                    usuario = usuario,
                    servicio = new ClienteOTC.servicio
                    {
                        codTipoServicio = (grupo == "DEPOSITO_ESPECIAL_EN_LINEA") ? "TRANSFERENCIA_ESPECIAL" : grupo,   //dpereirv, por solicitud de PO,
                        codigoConvenio = convenio,
                        codigoEmpresa = empresaRecaudacion,
                        codigoTipoBanca = "BP",
                        identificador = suministro,
                        codigoTipoIdentificador = tipoIdentificador,
                        datosAdicionales = ((datosAdicionalesConvenio != null && datosAdicionalesConvenio.Count() > 0) ? datosAdicionalesConvenio.ToArray() : null)
                    },
                    fechaSpecified = true
                });

                if (respuestaOTC.codigoError.Equals("0"))
                {
                    // Consulta exitosa

                    respuesta.Respuesta.ExitoOperacion = true;
                    respuesta.Respuesta.CodigoRespuesta = 0;
                    respuesta.Respuesta.MensajeError = "TRANSACCION EXITOSA";

                    // Asumir fecha de vencimiento a 30 dias en caso de que OTC no muestre ninguna
                    respuesta.FechaVencimiento = (respuestaOTC.fechaVencimientoSpecified) ? respuestaOTC.fechaVencimiento : DateTime.Today.AddDays(30);
                    respuesta.FormaPago = respuestaOTC.formaPago.ToString();

                    respuesta.IdentificadorDeuda = respuestaOTC.identificadorDeuda;
                    respuesta.LimiteMontoMaximo = respuestaOTC.limiteMontoMaximo;
                    respuesta.LimiteMontoMinimo = respuestaOTC.limiteMontoMinimo;
                    respuesta.MontoTotal = respuestaOTC.montoTotal;
                    respuesta.MontoMinimo = respuestaOTC.montoMinimo;
                    respuesta.NombreCliente = respuestaOTC.nombreCliente;

                    List<Recibo> itemsRecibos = new List<Recibo>();

                    if (respuestaOTC.recibos != null && respuestaOTC.recibos.Count() > 0)
                    {
                        respuesta.FormaPagoRecibos = respuestaOTC.formaPagoRecibos;

                        // Recibos, tipo de dato grid usado por municipio santa elena
                        foreach (recibo reciboGrid in respuestaOTC.recibos)
                        {
                            List<DatoAdicional> listReciboAdicional = new List<DatoAdicional>();

                            if (reciboGrid.datosAdicionales != null && reciboGrid.datosAdicionales.Count() > 0)
                            {
                                foreach (datoAdicional reciboAdicional in reciboGrid.datosAdicionales)
                                {
                                    listReciboAdicional.Add(new DatoAdicional
                                    {
                                        Id = reciboAdicional.codigo,
                                        ValorSeleccionado = reciboAdicional.valor,
                                        EsVisible = reciboAdicional.visible
                                    });
                                }

                            }
                            itemsRecibos.Add(new Recibo
                            {
                                Concepto = reciboGrid.concepto,
                                Fecha = reciboGrid.fecha,
                                Impuesto = reciboGrid.impuesto,
                                Secuencia = reciboGrid.secuencia,
                                Referencia = reciboGrid.referencia,
                                TotalAPagar = reciboGrid.totalAPagar,
                                Cuota = reciboGrid.cuota, // caso especial de SRI RISE
                                DatoAdicional = listReciboAdicional
                            });
                        }

                        respuesta.Recibos = itemsRecibos;
                    }

                    if (respuestaOTC.datosAdicionales != null && respuestaOTC.datosAdicionales.Count() > 0)
                    {

                        respuesta.DatosAdicionales = new List<DatoAdicional>();
                        List<ItemSeleccion> itemsComboAdicional = new List<ItemSeleccion>();

                        foreach (datoAdicional adicional in respuestaOTC.datosAdicionales)
                        {
                            if (adicional.tipo != null && adicional.tipo.Equals("COMBO"))
                            {
                                if (adicional.listasSeleccion != null && adicional.listasSeleccion.Count() > 0)
                                {
                                    foreach (listaSeleccion itemCombo in adicional.listasSeleccion)
                                    {
                                        itemsComboAdicional.Add(new ItemSeleccion
                                        {
                                            Codigo = itemCombo.codigo,
                                            Descripcion = itemCombo.etiqueta
                                        });
                                    }
                                }
                            }

                            respuesta.DatosAdicionales.Add(new DatoAdicional
                            {
                                EsEditable = adicional.editable,
                                EsVisible = adicional.visible,
                                Etiqueta = adicional.etiqueta,
                                Formato = adicional.formato,
                                Id = adicional.codigo,
                                Mascara = adicional.mascara,
                                RegExp = adicional.regexp,
                                Tipo = adicional.tipo,
                                ValorSeleccionado = adicional.valor,
                                Valores = itemsComboAdicional
                            });
                        }

                    }

                }
                else
                {
                    logger.Debug(string.Format("Error en consulta de deuda OTC: {0} - {1}", respuestaOTC.codigoError, respuestaOTC.mensajeUsuario));

                    respuesta.Respuesta.ExitoOperacion = false;
                    respuesta.Respuesta.CodigoRespuesta = 70011;
                    respuesta.Respuesta.MensajeError = respuestaOTC.mensajeUsuario;
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);

                respuesta.Respuesta.ExitoOperacion = false;
                respuesta.Respuesta.CodigoRespuesta = 70011;
                respuesta.Respuesta.MensajeError = "INDISPONIBILIDAD DE SERVICIO - " + ex.Message;
            }

            return respuesta;
        }

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
        public RespuestaConsultaTarifa ObtenerTarifa(int ordenante, string grupo, string empresaRecaudacion, string convenio, double monto, string rucEmpresa, string tipoCuenta, string cuenta)
        {
            RespuestaConsultaTarifa respuesta = new RespuestaConsultaTarifa
            {
                Comision = 0,
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = 0,
                    ExitoOperacion = true,
                    MensajeError = "TRANSACCION EXITOSA"
                }
            };

            ClienteTarifario.TarifarioPTClient cliente = new ClienteTarifario.TarifarioPTClient();
            ClienteTarifario.procesarTarifaResponse respuestaTarifa = cliente.procesarTarifa(new ClienteTarifario.procesarTarifaRequest()
            {
                mensajeEntradaProcesarTarifa = new ClienteTarifario.MensajeEntradaProcesarTarifa()
                {
                    canal = "SAT",
                    archivo = "",
                    usuario = "srolese",
                    cliente = new ClienteTarifario.Identificacion()
                    {
                        identificacion = rucEmpresa,
                        tipoIdentificacion = ClienteTarifario.TipoIdentificacionPersona.R
                    },
                    depuracion = "N",
                    cuenta = new ClienteTarifario.Cuenta()
                    {
                        identificadorCuenta = new ClienteTarifario.IdentificadorCuenta()
                        {
                            familiaProducto = ClienteTarifario.FamiliaProducto.CUENTAS,
                            cuenta = cuenta,
                            tipo = (ClienteTarifario.TipoCuenta)Enum.Parse(typeof(ClienteTarifario.TipoCuenta), tipoCuenta, true)
                        }
                    },
                    fecha = DateTime.Now,
                    idFuncionalidad = "2056",
                    empresaProveedor = empresaRecaudacion,
                    servicio = convenio,
                    monto = monto,
                    seDebita = false,
                    tipoBanca = ClienteTarifario.MensajeEntradaProcesarTarifaTipoBanca.BANCA_EMPRESA,
                    oficina = 0
                }
            });

            if (respuestaTarifa.mensajeSalidaProcesarTarifa.codigoError.Equals("0"))
            {
                // Consulta exitosa

                respuesta.Respuesta.CodigoRespuesta = 0;
                respuesta.Respuesta.ExitoOperacion = true;
                respuesta.Respuesta.MensajeError = "TRANSACCION EXITOSA";
                respuesta.Comision = respuestaTarifa.mensajeSalidaProcesarTarifa.comisionCliente;
            }
            else
            {
                respuesta.Respuesta.CodigoRespuesta = int.Parse(respuestaTarifa.mensajeSalidaProcesarTarifa.codigoError);
                respuesta.Respuesta.ExitoOperacion = false;
                respuesta.Respuesta.MensajeError = respuestaTarifa.mensajeSalidaProcesarTarifa.mensajeUsuario;
                respuesta.Comision = respuestaTarifa.mensajeSalidaProcesarTarifa.comisionCliente;
            }

            //respuesta.Comision = 0.34;

            return respuesta;
        }

        /// <summary>
        /// Permite generar un comprobante de transaccion en SAT
        /// </summary>
        /// <param name="comprobante">Los datos del comprobante de pagos</param>
        /// <returns>La respuesta de la generacion del comprobante</returns>
        public RespuestaGeneracionComprobante GenerarComprobante(Comprobante comprobante)
        {

            var respuesta = new RespuestaGeneracionComprobante
            {
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = -1,
                    ExitoOperacion = false,
                    MensajeError = "ERROR GENERAL AL INSERTAR COMPROBANTE DE PAGO"
                }
            };

            // A Sybase no le gusta linq ni entity framework

            using (var con = new AseConnection())
            {
                con.ConnectionString = Configuraciones.ObtenerConfiguracionConexionSybase();

                con.Open();

                AseCommand comando = new AseCommand("db_biz_servicios..pa_sat_icabcomprobante", con);
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandTimeout = 120;

                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_ordenante", AseDbType.Integer, System.Data.ParameterDirection.Input, comprobante.Ordenante));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_usuario", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.Usuario));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_referencia", AseDbType.VarChar, System.Data.ParameterDirection.Input, (comprobante.Referencia != null ? comprobante.Referencia : " ")));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_tipo_cuenta", AseDbType.SmallInt, System.Data.ParameterDirection.Input, comprobante.TipoCuenta));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_numero_cuenta", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.Cuenta));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_monto", AseDbType.Money, System.Data.ParameterDirection.Input, comprobante.Monto));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_comision", AseDbType.Money, System.Data.ParameterDirection.Input, comprobante.Comision));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_grupo", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.Grupo));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_empresa_recaudacion", AseDbType.Integer, System.Data.ParameterDirection.Input, comprobante.EmpresaRecaudacion));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_convenio", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.Convenio));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_suministro", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.Suministro));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_nom_empresa_rec", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.NombreEmpresaRecaudacion));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_nom_convenio", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.NombreConvenio));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_comprobante", AseDbType.VarChar, System.Data.ParameterDirection.Input, comprobante.ComprobantePago));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_estado", AseDbType.Char, System.Data.ParameterDirection.Input, comprobante.Estado));
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_cod_error", AseDbType.Integer, System.Data.ParameterDirection.Input, comprobante.CodigoError));


                var desgloses = Utils.Configuraciones.SerializarDesgloses(comprobante);
                // Desgloses
                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_desgloses", AseDbType.VarChar, System.Data.ParameterDirection.Input, desgloses));

                // Salidas

                var codigoRespuesta = Configuraciones.ConstruirParametro(comando, "@s_codigo_respuesta", AseDbType.Integer, System.Data.ParameterDirection.Output, null);
                var mensajeError = Configuraciones.ConstruirParametro(comando, "@s_mensaje_error", AseDbType.VarChar, System.Data.ParameterDirection.Output, null);
                var ordenBanco = Configuraciones.ConstruirParametro(comando, "@s_orden_banco", AseDbType.Integer, System.Data.ParameterDirection.Output, null);
                var ordenEmpresa = Configuraciones.ConstruirParametro(comando, "@s_orden_empresa", AseDbType.Integer, System.Data.ParameterDirection.Output, null);

                comando.Parameters.Add(codigoRespuesta);
                comando.Parameters.Add(mensajeError);
                comando.Parameters.Add(ordenBanco);
                comando.Parameters.Add(ordenEmpresa);

                int respuestaCentral = comando.ExecuteNonQuery();

                respuesta.Respuesta.CodigoRespuesta = (int)codigoRespuesta.Value;

                respuesta.Respuesta.ExitoOperacion = (respuesta.Respuesta.CodigoRespuesta == 0);

                respuesta.Respuesta.MensajeError = mensajeError.Value.ToString();
                respuesta.OrdenBanco = long.Parse(ordenBanco.Value.ToString());
                respuesta.OrdenEmpresa = long.Parse(ordenEmpresa.Value.ToString());
            }

            return respuesta;
        }

        /// <summary>
        /// Permite realizar un pago en OTC y generar el comprobante de pago (de ser exitoso)
        /// </summary>
        /// <param name="datosPago">Los datos del pago a enviar a OTC</param>
        /// <returns>La respuesta del pago realizado</returns>
        public RespuestaPago Pagar(Pago datosPago)
        {

            var respuestaPago = new RespuestaPago
            {
                Respuesta = new Respuesta
                {
                    CodigoRespuesta = -1,
                    MensajeError = "ERROR GENERAL AL EJECUTAR PAGO",
                    ExitoOperacion = false
                },
                OrdenBanco = 0,
                OrdenEmpresa = 0
            };

            try
            {
                ClienteOTC.OTCEndpointClient cliente = new ClienteOTC.OTCEndpointClient();

                List<datoAdicional> adicionalesOTC = new List<datoAdicional>();
                List<recibo> recibosOTC = new List<recibo>();

                if (datosPago.DatosAdicionales != null && datosPago.DatosAdicionales.Count() > 0)
                {
                    foreach (DatoAdicional adicional in datosPago.DatosAdicionales)
                    {

                        var nuevoAdicional = new datoAdicional
                        {
                            codigo = adicional.Id,
                            valor = adicional.ValorSeleccionado,
                            visible = adicional.EsVisible,
                            editable = adicional.EsEditable,
                            visibleSpecified = true,
                            editableSpecified = true
                        };

                        if (adicional.Etiqueta != null && !String.IsNullOrEmpty(adicional.Etiqueta))
                        {
                            nuevoAdicional.etiqueta = adicional.Etiqueta;
                        }

                        adicionalesOTC.Add(nuevoAdicional);
                    }
                }

                if (datosPago.Recibos != null && datosPago.Recibos.Count() > 0)
                {

                    List<datoAdicional> listReciboAdicionales = new List<datoAdicional>(); ;

                    foreach (Recibo recibo in datosPago.Recibos)
                    {

                        if (recibo.DatoAdicional != null && recibo.DatoAdicional.Count() > 0)
                        {

                            foreach (DatoAdicional adicional in recibo.DatoAdicional)
                            {

                                var reciboAdicional = new datoAdicional
                                {
                                    codigo = adicional.Id,
                                    valor = adicional.ValorSeleccionado,
                                    visible = adicional.EsVisible
                                };

                                listReciboAdicionales.Add(reciboAdicional);
                            }
                        }


                        recibosOTC.Add(new ClienteOTC.recibo
                        {
                            concepto = recibo.Concepto,
                            fecha = recibo.Fecha,
                            impuesto = recibo.Impuesto,
                            referencia = recibo.Referencia,
                            secuencia = recibo.Secuencia,
                            totalAPagarSpecified = true,
                            totalAPagar = recibo.TotalAPagar,
                            cuota = recibo.Cuota,
                            datosAdicionales = listReciboAdicionales.ToArray()
                        });
                    }
                }

                var entradaServicioOTC = new mensajeEntradaEjecutarPago
                {
                    canal = "SAT",
                    depuracion = "N",
                    fecha = DateTime.Now,
                    oficina = "0",
                    transaccion = "2056",
                    usuario = datosPago.Comprobante.Usuario,
                    nombreCliente = datosPago.Cliente,
                    moneda = "1",
                    fechaPago = DateTime.Now,
                    servicio = new servicio
                    {
                        codigoConvenio = datosPago.Comprobante.Convenio,
                        codigoEmpresa = datosPago.Comprobante.EmpresaRecaudacion.ToString(),
                        codigoTipoBanca = "BP",
                        codigoTipoIdentificador = datosPago.CodigoIdentificador,
                        identificador = datosPago.Comprobante.Suministro,
                        codTipoServicio = (datosPago.Comprobante.Grupo.Equals("DEPOSITO_ESPECIAL_EN_LINEA")) ? "TRANSFERENCIA_ESPECIAL" : datosPago.Comprobante.Grupo   //dpereirv, por solicitud de PO
                    },
                    datosAdicionales = adicionalesOTC.ToArray(),
                    recibos = (recibosOTC != null && recibosOTC.Count() > 0) ? recibosOTC.ToArray() : null,
                    tipoCuenta = (datosPago.Comprobante.TipoCuenta == 3) ? "CTE" : "AHO",
                    cuenta = datosPago.Comprobante.Cuenta,
                    valorComision = datosPago.Comprobante.Comision,
                    valorPago = datosPago.Comprobante.Monto,
                    valorComisionSpecified = true,
                    valorPagoSpecified = true,
                    secuencial = Configuraciones.ObtenerSecuencialTransaccion(), // CNT no le gusta un codigo tan grande DateTime.Now.Ticks.ToString(),
                    fechaPagoSpecified = true,
                    fechaSpecified = true
                };

                // Caso especial de SRI - Otras Formas de Pago
                // Campos adicionales de ingreso hiperdinamicos

                if (datosPago.EntradasAdicionales != null && datosPago.EntradasAdicionales.Count() > 0)
                {
                    List<datoAdicional> listaOTCEditablesAdicionales = new List<datoAdicional>();

                    foreach (var entradaAdicional in datosPago.EntradasAdicionales)
                    {
                        listaOTCEditablesAdicionales.Add(new datoAdicional
                        {
                            codigo = entradaAdicional.Id,
                            valor = entradaAdicional.ValorSeleccionado,
                            visible = false,
                            visibleSpecified = true
                        });
                    }

                    entradaServicioOTC.servicio.datosAdicionales = listaOTCEditablesAdicionales.ToArray();
                }

                // Pago en OTC
                var respuestaOTC = cliente.ejecutarPago(entradaServicioOTC);

                logger.Debug(string.Format("Respuesta Pago OTC codigoError: {0} mensajeError: {1} suministro: {2}", respuestaOTC.codigoError, respuestaOTC.mensajeUsuario, datosPago.Comprobante.Suministro));

                if (respuestaOTC.codigoError.Equals("0"))
                {
                    respuestaPago.Respuesta.CodigoRespuesta = 0;
                    respuestaPago.Respuesta.ExitoOperacion = true;
                    respuestaPago.Respuesta.MensajeError = "TRANSACCION EXITOSA";

                    respuestaPago.ReferenciaPago = respuestaOTC.referencia;
                    respuestaPago.FechaDebito = respuestaOTC.fechaDebito;
                    respuestaPago.FechaPago = respuestaOTC.fechaPago;

                    // Con la respuesta OK desde OTC, proceder a guardar comprobante en core

                    datosPago.Comprobante.CodigoError = 0;
                    datosPago.Comprobante.Estado = "P";
                    datosPago.Comprobante.Detalles = new List<DetalleComprobante>();

                    if (datosPago.Comprobante.Detalles != null)
                    {
                        // No existieron datos adicionales ni en la consulta de deuda ni en el resultado de pago, guardar campos genericos

                        // Comentado por problema de comprobantes de jpiguave...

                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Tipo de Servicio", Valor = datosPago.Comprobante.Grupo.Replace("_", " ") });

                        if (Configuraciones.EsDepositoTemporal(datosPago.Comprobante.Grupo, datosPago.Comprobante.EmpresaRecaudacion.ToString()))
                        {
                            // Empresa es deposito temporal, invertir campos segun lo solicitado por Julio
                            datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Empresa/Servicio", Valor = datosPago.Comprobante.NombreConvenio });
                            datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Tipo de Pago", Valor = datosPago.Comprobante.NombreEmpresaRecaudacion });
                        }
                        else
                        {
                            // Condicion normal
                            datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Empresa/Servicio", Valor = datosPago.Comprobante.NombreEmpresaRecaudacion });
                            datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Tipo de Pago", Valor = datosPago.Comprobante.NombreConvenio });
                        }

                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Tipo Identificación", Valor = datosPago.Comprobante.EtiquetaIdentificador });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Identificación", Valor = datosPago.Comprobante.Suministro });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Referencia", Valor = (!string.IsNullOrEmpty(datosPago.Comprobante.Referencia)) ? datosPago.Comprobante.Referencia : "-" });


                        bool esPagoMatriculable = Configuraciones.EsConvenioMatriculable(
                            datosPago.Comprobante.Grupo,
                            datosPago.Comprobante.EmpresaRecaudacion.ToString(),
                            datosPago.Comprobante.Convenio
                            );

                        if (esPagoMatriculable)
                        {
                            // Es pago matriculable, guardar alias
                            if (datosPago.Comprobante.Alias != null && !string.IsNullOrEmpty(datosPago.Comprobante.Alias))
                            {
                                datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Alias", Valor = datosPago.Comprobante.Alias });
                            }
                        }

                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Canal", Valor = "SAT" });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Nombre", Valor = datosPago.Cliente });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "No. Autorización", Valor = respuestaOTC.referencia });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Cuenta Débito", Valor = Utils.Configuraciones.ObtenerCuentaEnmascarada(datosPago.Comprobante.Cuenta) + " - " + ((datosPago.Comprobante.TipoCuenta == 3) ? "CTE" : "AHO") });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Fecha y hora", Valor = DateTime.Now.ToString("MM/dd/yyyy H:mm") });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Fecha Proceso", Valor = respuestaOTC.fechaPago.ToString("MM/dd/yyyy") });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Monto", Valor = String.Format("{0:n} USD", datosPago.Comprobante.Monto) });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Cargo Financiero", Valor = String.Format("{0:n} USD", datosPago.Comprobante.Comision) });
                        datosPago.Comprobante.Detalles.Add(new DetalleComprobante { Codigo = ":", Etiqueta = "Total", Valor = String.Format("{0:n} USD", datosPago.Comprobante.Monto + datosPago.Comprobante.Comision) });
                    }

                    if (datosPago.DatosAdicionales != null && datosPago.DatosAdicionales.Count() > 0)
                    {
                        foreach (DatoAdicional adic in datosPago.DatosAdicionales)
                        {
                            // Solo mostrar los datos visibles de entrada de OTC (probablemente consulta)
                            if (adic.EsVisible)
                            {
                                datosPago.Comprobante.Detalles.Add(new DetalleComprobante
                                {
                                    Codigo = " ", // por comprobante jpiguave adic.Id,
                                    Etiqueta = adic.Etiqueta,
                                    Valor = adic.ValorSeleccionado
                                });
                            }

                        }
                    }

                    if (respuestaOTC.datosAdicionales != null && respuestaOTC.datosAdicionales.Count() > 0)
                    {
                        // En caso de que OTC devuelva datos adicionales al ejecutar el pago se agregan a la lista

                        foreach (datoAdicional adic in respuestaOTC.datosAdicionales)
                        {
                            // Solo mostrar los datos visibles de entrada de OTC (probablemente consulta)
                            if (adic.visible)
                            {
                                datosPago.Comprobante.Detalles.Add(new DetalleComprobante
                                {
                                    Codigo = ":",//adic.codigo,
                                    Etiqueta = adic.etiqueta.Replace(":", ""),
                                    Valor = adic.valor
                                });
                            }

                        }
                    }

                    // Generar megacomprobante en core

                    var respuestaCore = GenerarComprobante(datosPago.Comprobante);

                    if (respuestaCore.Respuesta.ExitoOperacion)
                    {
                        respuestaPago.OrdenBanco = respuestaCore.OrdenBanco;
                        respuestaPago.OrdenEmpresa = respuestaCore.OrdenEmpresa;

                    }
                    else
                    {
                        // Por algun motivo no se pudo almacenar el comprobante de pago
                        throw new Exception(respuestaCore.Respuesta.MensajeError);
                    }

                }
                else
                {
                    // Respuesta fallida de OTC
                    throw new Exception(respuestaOTC.mensajeUsuario);
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex);

                respuestaPago.Respuesta.ExitoOperacion = false;
                respuestaPago.Respuesta.CodigoRespuesta = -1;
                respuestaPago.Respuesta.MensajeError = ex.Message;
            }

            return respuestaPago;
        }

        /// <summary>
        /// Obtiene los detalles a mostrar de un comprobante de pagos existente
        /// </summary>
        /// <param name="ordenBanco">El codigo de orden banco asociado</param>
        /// <returns>Los detalles del comprobante seleccionado</returns>
        public List<DetalleComprobante> ObtenerDetallesComprobante(long ordenBanco)
        {
            var detalles = new List<DetalleComprobante>();

            using (var con = new AseConnection())
            {
                con.ConnectionString = Configuraciones.ObtenerConfiguracionConexionSybase();
                con.Open();

                AseCommand comando = new AseCommand("db_biz_servicios..pa_sat_cdesglose_orden", con);
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandTimeout = 120;

                comando.Parameters.Add(Configuraciones.ConstruirParametro(comando, "@e_orden_banco", AseDbType.Integer, System.Data.ParameterDirection.Input, ordenBanco));

                var rst = comando.ExecuteReader();

                while (rst.Read())
                {
                    detalles.Add(new DetalleComprobante
                    {
                        Etiqueta = rst.GetString(1),
                        Codigo = ":",
                        Valor = rst.GetString(0)
                    });

                }

                rst.Close();
                rst = null;
            }

            return detalles;
        }
    }
}
