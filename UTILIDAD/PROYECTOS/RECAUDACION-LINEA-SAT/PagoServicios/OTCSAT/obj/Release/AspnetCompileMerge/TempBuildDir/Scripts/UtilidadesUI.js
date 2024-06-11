/**
* Utilidades para controles
* @author jvillavc SAT-CC-SGC00032585
*/

var UtilidadesUI = {
	/**
	* Permite mostrar un submenu con opciones de grid
	* @param configuraciones Estructura JSON con parametros de invocacion:
	*
	* {opciones:[{nombre:'',url:'',handler:null}...]}
	* Donde "opciones" es un arreglo de las N "opciones" de menu
	* Cada elemento de "opciones" tiene un "nombre" (titulo de item de menu)
	* "url" La url a disparar (en caso de que sea link sencillo) o en su defecto
	* "handler" que representa funcion anonima con codigo que se desea invocar en el
	* menu particular
	*/
	mostrarSubMenuGrid: function(origen,configuraciones){
		var contenedorMenuActual = document.getElementById("subMenuGrid");
		
		if(contenedorMenuActual!=null){
			contenedorMenuActual.parentNode.removeChild(contenedorMenuActual);
		}
		
		contenedorMenuActual = document.createElement("div");
        contenedorMenuActual.setAttribute("id", "subMenuGrid");

        contenedorMenuActual.setAttribute("style", "-webkit-box-shadow: 2px 2px 36px -5px rgba(0, 0, 0, 0.59);-moz-box-shadow: 2px 2px 36px -5px rgba(0, 0, 0, 0.59);box- shadow: 2px 2px 36px -5px rgba(0, 0, 0, 0.59);");
		
		contenedorMenuActual.addEventListener("mouseleave", function(e){
			// A firefox no le gusta e.fromElement
			if(e.fromElement!=null){
				e.fromElement.parentNode.removeChild(e.fromElement);
			}else{
				contenedorMenuActual.parentNode.removeChild(contenedorMenuActual);
			}
			
		});
		
		var contenedorItemsMenuActual = document.createElement("ul");
		
		configuraciones.opciones.forEach(function(item,index){
            var itemMenuActual = document.createElement("li");
            itemMenuActual.style.cursor = "pointer";
			
			itemMenuActual.addEventListener("click",function(e){
				if(item.url!=null && item.url!=""){
					document.location = item.url;
				}else if(item.handler!=null){
					try{
						item.handler();
					}catch(ex){}
				}
			});
			
			itemMenuActual.innerText = item.nombre;
			
			contenedorItemsMenuActual.appendChild(itemMenuActual);
		});
		
		contenedorMenuActual.appendChild(contenedorItemsMenuActual);
		
        document.body.appendChild(contenedorMenuActual);

        // A Firefox no le gusta window.event

        //contenedorMenuActual.style.left = (window.event!=null)?window.event.clientX:origen.getBoundingClientRect().top + 10;
        //contenedorMenuActual.style.top = (window.event!=null)?window.event.clientY + document.body.scrollTop :origen.getBoundingClientRect().left + 10;
        
        // A IE 11 no le gusta window.scrollY

        //contenedorMenuActual.style.top = ((window.event != null) ? window.event.clientY + window.scrollY : origen.getBoundingClientRect().top + window.scrollY) + "px";
        contenedorMenuActual.style.top = ((window.event != null) ? window.event.clientY + window.pageYOffset : origen.getBoundingClientRect().top + window.scrollY) + "px";
        contenedorMenuActual.style.display = "block";

        contenedorMenuActual.style.left = ((window.event != null) ? window.event.clientX - contenedorMenuActual.clientWidth : origen.getBoundingClientRect().left - contenedorMenuActual.clientWidth) + "px";

    },
    renderizarMoneda: function(total, simbolo) {
        simbolo = (simbolo != null) ? simbolo : "";
        var esNegativo = false;

        if (total < 0) {
            esNegativo = true;
            total = Math.abs(total);
        }

        return (esNegativo ? "-" + simbolo : simbolo) + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
    },
    renderizarFecha: function (fecha) {
        return new Date(parseInt(fecha.substr(6))).toLocaleDateString();
    },
    registrarCambioElemento: function(elm, callback) {
        var lastHeight = elm.clientHeight, newHeight;
        (function run() {
            newHeight = elm.clientHeight;
            if (lastHeight != newHeight)
                callback();
            lastHeight = newHeight;

            if (elm.onElementHeightChangeTimer)
                clearTimeout(elm.onElementHeightChangeTimer);

            elm.onElementHeightChangeTimer = setTimeout(run, 200);
        })();
    },
    handlerRegistroCambioElemento: function () {
        try {
            var panelCargaOTC = window.parent.document.getElementById("contenedorNavegador");
            panelCargaOTC.style.height = panelCargaOTC.contentWindow.document.body.offsetHeight + 125 + "px";
        } catch (ex) {

        }
    }
};

PanelPagos = function (config) {
    
    var configuraciones = {
        ordenante: 0,
        usuario: "",
        contenedor: "",
        seccionMensajes: "",
        contenedorTotales: "",
        urlBase: "",
        grupos: [],
        cuentas: [],
        pagoActual: {
            deuda: null, // Datos devueltos en consulta
            configuracion: null, // Datos ingresados por usuario
            descripcionPago:" " // Descripcion de pago
        },
        nodoFilaActual:null // Nodo de fila actualmente seleccionada
    };
    
    init(config);

    function init(config) {
        configuraciones.ordenante = config.ordenante;
        configuraciones.usuario = config.usuario;
        configuraciones.contenedor = config.contenedor;
        configuraciones.seccionMensajes = config.seccionMensajes;
        configuraciones.urlBase = config.urlBase;
        configuraciones.contenedorTotales = config.contenedorTotales;

        $.ajax({
            type: "POST",
            url: configuraciones.urlBase + "ObtenerCuentasPorEmpresaUsuario",
            dataType: "json",
            data: {
                ordenante: configuraciones.ordenante,
                usuario: configuraciones.usuario
            },
            success: function (cuentas) {
                configuraciones.cuentas = cuentas;

                if (cuentas != null && cuentas.length > 0) {
                    // Cuentas cargadas correctamente, cargar grupos

                    $.ajax({
                        type: "POST",
                        url: configuraciones.urlBase + "ObtenerGruposPorUsuarioEmpresa",
                        dataType: "json",
                        data: {
                            ordenante: configuraciones.ordenante,
                            usuario: configuraciones.usuario
                        },
                        success: function (gruposUsuario) {
                            configuraciones.grupos = gruposUsuario;
                            renderizarComponente();
                            registrarEventos();
                        },
                        error: function (ex) {
                            configuraciones.grupos = [];
                        }
                    });
                } else {
                    configuraciones.cuentas = [];
                    mostrarMensaje("Cuentas de debito empresa no definidas, contactar al oficial", "ERROR");
                }
                
            },
            error: function (ex) {
                configuraciones.cuentas = [];
                alert("Cuentas de debito empresa no definidas, contactar al oficial");
            }
        });
        
    }
    
    function renderizarComponente() {
        var contenedor = document.getElementById(configuraciones.contenedor);
        
        configuraciones.grupos.forEach(function (grupo) {

            var contenido = document.createElement("div");
            contenido.className = "panel";

            var texto = document.createTextNode("Contenido de opcion");
            contenido.appendChild(texto);

            var titulo = document.createElement("button");
            titulo.className = "accordion";
            
            titulo.appendChild(document.createTextNode(grupo.Descripcion));
            titulo.setAttribute("grupo", grupo.Codigo);

            contenedor.appendChild(titulo);
            titulo.parentNode.insertBefore(contenido, titulo.nextSibling);
        });

    }

    function registrarEventos() {
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {

                $("#" + configuraciones.contenedorTotales).text("Total a Pagar: 0.00 USD");
                configuraciones.nodoFilaActual = null;
                configuraciones.pagoActual.descripcionPago = " ";

                mostrarMensaje("Seleccione el servicio a pagar", "EXITO");

                this.classList.toggle("active");
                var panel = this.nextElementSibling;

                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                } else {

                    mostrarCargador();

                    $.ajax({
                        type: "POST",
                        url: configuraciones.urlBase + "ObtenerMatriculacionesPorGrupoUsuario",
                        dataType: "json",
                        data: {
                            ordenante: configuraciones.ordenante,
                            usuario: configuraciones.usuario,
                            grupo: this.getAttribute("Grupo")
                        },
                        success: function (matriculaciones) {

                            removerCargador();

                            var contenidoMatriculacion = "<table cellspacing='0' cellpadding='0' border='0' style='width:100%'>";
                            contenidoMatriculacion += "<thead><tr><td class='tittabla alineadorColumnasGrid'></td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Empresa/Servicio</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Alias</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Monto Deuda</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Monto a Pagar</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Fecha Vencimiento</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Cuenta D&eacute;bito</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Comisi&oacute;n</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'>Total a Pagar</td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'></td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'></td>";
                            contenidoMatriculacion += "<td class='tittabla alineadorColumnasGrid'></td>";
                            contenidoMatriculacion += "</tr></thead><tbody>";

                            matriculaciones.forEach(function (matriculacion) {
                                contenidoMatriculacion += "<tr>";
                                //contenidoMatriculacion += "<td class='list'><div style='cursor:pointer;width:32px;height:32px;'><img src='" + configuraciones.urlBase +"../Imagenes/icono_consulta_deuda.png' border='0' onclick='document.panelOTC.seleccionarFilaPago(this);document.panelOTC.consultarDeuda(this,\"" + matriculacion.Grupo + "\",\"" + matriculacion.EmpresaRecaudacion + "\",\""+matriculacion.Convenio+"\",\""+matriculacion.Identificador+"\",\""+matriculacion.Suministro+ "\")'></div></td>";

                                contenidoMatriculacion += "<td class='list'><div><input type='radio' onclick='document.panelOTC.seleccionarFilaPago(this);document.panelOTC.consultarDeuda(this,\"" + matriculacion.Grupo + "\",\"" + matriculacion.EmpresaRecaudacion + "\",\"" + matriculacion.Convenio + "\",\"" + matriculacion.Identificador + "\",\"" + matriculacion.Suministro + "\")'></div></td>";

                                contenidoMatriculacion += "<td class='list' title='" + matriculacion.NombreEmpresaRecaudacion+"'><div class='columnaReducida'>" + matriculacion.NombreEmpresaRecaudacion + "</div></td>";
                                contenidoMatriculacion += "<td class='list'>" + matriculacion.Alias + "</td>";
                                contenidoMatriculacion += "<td class='list'></td>";
                                contenidoMatriculacion += "<td class='list'> <table><tr><td><input type='text' class='datos datosPequeno inputMinimo' onkeypress='return ValidacionesUI.validarMoneda(event,this)' onblur='document.panelOTC.actualizarMontos(this);' disabled></td><td><div style='padding-left:5px;float:right;'>USD</div></td></tr></table></td>";
                                contenidoMatriculacion += "<td class='list'><div style='text-align:center;'></div></td>";
                                contenidoMatriculacion += "<td class='list'><select class='datos datosPequeno' style='width:100px;height:26px !important;' disabled onchange='document.panelOTC.recalcularComision(this.parentElement.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.firstChild.firstChild,\""+ matriculacion.Grupo + "\",\"" + matriculacion.EmpresaRecaudacion + "\",\"" + matriculacion.Convenio + "\")'>";

                                if (configuraciones.cuentas != null) {
                                    configuraciones.cuentas.forEach(function (cuenta) {
                                        //contenidoMatriculacion += "<option value='" + cuenta.Tipo + "@" + cuenta.Codigo + "' " + ((cuenta.EsDefault) ? "selected" : "") + ">" + cuenta.Referencia + " - " + cuenta.Nombre + " - " + ((cuenta.Tipo == "CTE") ? "CORRIENTE" : "AHORRO") + " - " + UtilidadesUI.renderizarMoneda(cuenta.SaldoDisponible, "") + " USD</option>";
                                        contenidoMatriculacion += "<option value='" + cuenta.Tipo + "@" + cuenta.Codigo + "' " + ((cuenta.EsDefault) ? "selected" : "") + ">" + cuenta.Referencia + " - " + cuenta.Nombre + " - " + ((cuenta.Tipo == "CTE") ? "CORRIENTE" : "AHORRO") + " </option>";
                                    });
                                }

                                contenidoMatriculacion += "</select ></td>";
                                contenidoMatriculacion += "<td class='list'></td>";
                                contenidoMatriculacion += "<td class='list'></td>";
                                contenidoMatriculacion += "<td class='list'>" + "<div style='display:none;' onclick=\"UtilidadesUI.mostrarSubMenuGrid(this,{opciones:[{nombre:'Pagar',url:null,handler:function(){document.panelOTC.pagar();}},{nombre:'Actualizar Montos',url:null,handler:function(){document.panelOTC.encerarMontoFilaActual();}},{nombre:'Configurar Pago',url:null,handler:function(){document.panelOTC.mostrarConfiguracionPago();}},{nombre:'Detalle',url:null,handler:function(){document.panelOTC.mostrarDetallesRecaudacion();}}]})\"><img src='" + configuraciones.urlBase + "../Imagenes/icono_acciones.png' /></div>" + "</td>";
                                contenidoMatriculacion += "<td class='list'><input type='hidden' value='" + matriculacion.EtiquetaConvenio + "'></td>";
                                contenidoMatriculacion += "<td class='list'><input type='hidden' value='" + matriculacion.EtiquetaIdentificador + "'></td>";
                                contenidoMatriculacion += "</tr>";
                            });

                            contenidoMatriculacion += "</tbody>";
                            contenidoMatriculacion += "</table>";

                            panel.innerHTML = contenidoMatriculacion;

                            panel.style.maxHeight = panel.scrollHeight + 64 + "px";
                        },
                        error: function (ex) {
                            removerCargador();

                            mostrarMensaje("Error al cargar matriculaciones por usuario", "ERROR");
                            console.log("Error");
                        }
                    });
                }

                var otros = document.getElementsByClassName("accordion");
                var j;

                for (j = 0; j < otros.length; j++) {
                    if (otros[j].firstChild.nodeValue != this.firstChild.nodeValue) {
                        otros[j].className = "accordion";
                        otros[j].nextElementSibling.style.maxHeight = null;
                    }
                }

            });
        }
    }

    /**
     * Muestra una alerta flotante que cubre toda la pantalla
     * @param {any} titulo El titulo de la ventana
     * @param {any} mensaje El mensaje a mostrar
     */
    function mostrarMensajeFlotante(titulo, mensaje) {

        regresarAPosicionScroll();

        var contenedorMensaje = document.getElementById("mensajeNotificacionFlotante");

        if (contenedorMensaje != null) {
            contenedorMensaje.parentNode.removeChild(contenedorMensaje);
        } else {
            contenedorMensaje = document.createElement("div");
        }

        contenedorMensaje.id = "mensajeNotificacionFlotante";
        contenedorMensaje.className = "covertorNotificacion";
        contenedorMensaje.innerHTML = "<div class='ventana_modal_contenedor'><div class='ventana_modal'><div class='ventana_modal_icono' ><img src='../imagenes/icono_rechazada.png' /></div><div class='ventana_modal_titulo'>" + titulo + "</div><div class='ventana_modal_mensaje'>" + mensaje + "</div><div class='ventana_modal_boton'><input class='button' type='button' value='Regresar' onclick='document.panelOTC.esconderMensajeFlotante();'></div></div></div>";

        document.body.appendChild(contenedorMensaje);
    }

    /**
     * Esconde la alerta flotante (de existir)
     */
    this.esconderMensajeFlotante = function () {
        var contenedorMensaje = document.getElementById("mensajeNotificacionFlotante");

        if (contenedorMensaje != null) {
            contenedorMensaje.parentNode.removeChild(contenedorMensaje);
        }
    };

    /**
     * Muestra un mensaje en la seccion de mensajes del componente
     * @param {any} mensaje El mensaje a mostrar
     * @param {any} tipo El tipo de mensaje (ERROR,EXITO)
     */
    function mostrarMensaje(mensaje, tipo) {

        tipo = (tipo != null) ? tipo : "ERROR";

        $("#" + configuraciones.seccionMensajes).removeClass((tipo == "EXITO") ? "mensajeErroneo" : "");
        $("#" + configuraciones.seccionMensajes).addClass((tipo != "EXITO") ? "mensajeErroneo" : "");
        $("#" + configuraciones.seccionMensajes).text(mensaje);

        if (tipo == "ERROR") {
            contraerGrupos();
            mostrarMensaje("Seleccione el servicio a pagar", "EXITO");

            // Nueva alerta solicitada por Wendy
            mostrarMensajeFlotante("Por favor revise el siguiente mensaje:", mensaje);
        }
        
    }

    function mostrarCargador() {
        mostrarMensaje("Seleccione el servicio a pagar", "EXITO");
        $("body").append("<div class='cargadorOTC'></div>");

        var contenedor = document.getElementById(configuraciones.contenedor);
        contenedor.style.filter = "blur(0px)"; // No les gusta en efecto blur
        contenedor.style.pointerEvents = "none";
    }

    function removerCargador() {
        var contenedor = document.getElementById(configuraciones.contenedor);
        contenedor.style.filter = "blur(0px)";
        $(".cargadorOTC").remove();
        contenedor.style.pointerEvents = "auto";
    }

    /**
     * Permite regresar el scroll de pantalla a la posicion inicial (tope)
     **/
    function regresarAPosicionScroll() {
        try {
            $("html, body").animate({ scrollTop: 0 }, "slow");
            window.parent.$("html, body").animate({ scrollTop: 0 }, "slow");
        } catch (ex) { }
    }

    function contraerGrupos() {
        var grupos = document.getElementsByClassName("accordion");
        var j;

        for (j = 0; j < grupos.length; j++) {
            grupos[j].className = "accordion";
            grupos[j].nextElementSibling.style.maxHeight = null;
        }
    }

    function actualizarTotalGlobalInterno(componenteOrigen) {
        var comision = 0;
        var monto = 0;

        try {
            comision = componenteOrigen.
                parentNode.parentNode.
                parentNode.parentNode.
                parentNode.nextSibling.
                nextSibling.nextSibling.
                innerText.replace("$", "").
                replace(",", "") * 1;

            monto = componenteOrigen.value.
                replace("$", "").
                replace(",", "") * 1;
        } catch (ex) {
            comision = 0;
            monto = 0;
        }

        $("#" + configuraciones.contenedorTotales).text("Total a Pagar: " + UtilidadesUI.renderizarMoneda(monto + comision, "") + " USD");
    }

    this.seleccionarFilaPago = function (instancia) {

        configuraciones.pagoActual.descripcionPago = " ";

        var principal = instancia.parentNode.parentNode.parentNode.parentNode;

        // forEach no funciona en IE11 :(
        // principal.childNodes.forEach(function (nodo) {

        for (var i = 0; i < principal.childNodes.length; i++) {
            var nodo = principal.childNodes[i];

            nodo.style.backgroundColor = "white";
            nodo.style.boxShadow = "0 0 0px";
            nodo.style.border = "0px none";
            
            // Quitar check a radiobutton de seleccion
            nodo.firstChild.firstChild.firstChild.checked = false;

            // Limpiar deuda total
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.innerText = "";

            // Limpiar y bloquear campo de monto
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                firstChild.nextSibling.
                firstChild.firstChild.
                firstChild.firstChild.value = "";

            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                firstChild.nextSibling.
                firstChild.firstChild.
                firstChild.firstChild.disabled = true;

            // Limpiar fecha de vencimiento
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.innerText = "";

            // Inhabilitar lista de cuentas
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                firstChild.disabled = true;

            // Limpiar tarifa
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.innerText = "";

            // Limpiar totales fila
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                innerText = "";

            // Inhabilitar submenu de acciones
            nodo.firstChild.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.
                nextSibling.nextSibling.nextSibling.firstChild.style.display = "none";
            
        }
        
        instancia.parentNode.parentNode.parentNode.style.backgroundColor = "#e5e5e5";
        instancia.parentNode.parentNode.parentNode.style.boxShadow = "0 0 5px black";
        instancia.parentNode.parentNode.parentNode.style.border = "1px solid black";

        // Marcar radiobutton y habilitar caja de texto de ingreso de montos
        $(instancia.parentNode.parentNode.parentNode)
            .find("input")
            .each(function (indice, elemento) {
                if (elemento.type == "text") {
                    elemento.removeAttribute("disabled");
                    elemento.focus();
                } else if (elemento.type == "radio") {
                    elemento.checked = true;
                }
            });

        $(instancia.parentNode.parentNode.parentNode)
            .find("select")
            .each(function (indice, elemento) {
                elemento.removeAttribute("disabled");
                elemento.focus();
            });

        configuraciones.nodoFilaActual = instancia.parentNode.parentNode.parentNode;
    };

    /**
     * Permite consultar la deuda de servicio
     * @param {any} instancia Apuntador a instancia de elemento desde donde se disparo la peticion
     * @param {any} grupo El grupo de recaudacion (LUZ, AGUA, TELEFONIA_FIJA, etc)
     * @param {any} empresaRecaudacion El codigo de la empresa de recaudacion
     * @param {any} convenio El codigo del convenio de pago
     * @param {any} tipoIdentificador El tipo de identificador de suministro
     * @param {any} suministro El identificador - suministro
     */
    this.consultarDeuda = function(instancia, grupo, empresaRecaudacion, convenio, tipoIdentificador, suministro) {

        mostrarCargador();

        $.ajax({
            type: "POST",
            url: configuraciones.urlBase + "ConsultarDeudaActual",
            dataType: "json",
            timeout: 60000,
            data: {
                ordenante: configuraciones.ordenante,
                usuario: configuraciones.usuario,
                grupo: grupo,
                empresaRecaudacion: empresaRecaudacion,
                convenio: convenio,
                tipoIdentificador: tipoIdentificador,
                suministro: suministro
            },
            success: function (deuda) {

                removerCargador();

                if (deuda.Respuesta.ExitoOperacion) {
                    // Carga exitosa

                    if (deuda.MontoTotal * 1 > 0) {
                        mostrarMensaje(deuda.Respuesta.MensajeError, "EXITO");

                        // Monto Total de deuda
                        instancia.parentNode.parentNode.
                            nextSibling.nextSibling.
                            nextSibling.innerText = UtilidadesUI.renderizarMoneda(deuda.MontoTotal, "$");

                        // Por defecto campo de monto paga la deuda total
                        instancia.parentNode.parentNode.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            firstChild.nextSibling.
                            firstChild.firstChild.
                            firstChild.firstChild.value = UtilidadesUI.renderizarMoneda(deuda.MontoTotal, "");

                        // Fecha de vencimiento
                        instancia.parentNode.parentNode.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            nextSibling.innerText = UtilidadesUI.renderizarFecha(deuda.FechaVencimiento);

                        // Consultar tarifa asociada

                        mostrarCargador();

                        var cuentaSeleccionada = instancia.parentNode.parentNode.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            firstChild.value;

                        // Habilitar submenu de acciones
                        instancia.parentNode.parentNode.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.
                            nextSibling.nextSibling.nextSibling.firstChild.style.display = "block";
                        
                        configuraciones.pagoActual.deuda = deuda;

                        // Limpieza
                        configuraciones.pagoActual.deuda.NombreCliente = configuraciones.pagoActual.deuda.NombreCliente.replace(/[^a-zA-Z 0-9]+/g, '');
                        
                        configuraciones.pagoActual.configuracion = {
                            ordenante: configuraciones.ordenante,
                            usuario: configuraciones.usuario,
                            grupo: grupo,
                            empresaRecaudacion: empresaRecaudacion,
                            convenio: convenio,
                            tipoIdentificador: tipoIdentificador,
                            suministro: suministro,
                            monto: deuda.MontoTotal,
                            tipoCuenta: cuentaSeleccionada.split("@")[0],
                            cuenta: cuentaSeleccionada.split("@")[1],
                            comision: 0,
                            nombreEmpresaRecaudacion: instancia.parentNode.parentNode.nextSibling.innerText,
                            alias: instancia.parentNode.parentNode.nextSibling.nextSibling.innerText,
                            nombreConvenio: instancia.parentNode.parentNode.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.firstChild.value,
                            etiquetaIdentificador: instancia.parentNode.parentNode.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.nextSibling.firstChild.value
                        };

                        // Bloquear edicion de campo de monto dependiendo de forma de pago

                        if (deuda.FormaPago!=null && (deuda.FormaPago == "TOTAL" || deuda.FormaPago == "UNICO_CRONOLOGICO")) {

                            instancia.parentNode.parentNode.
                                nextSibling.nextSibling.
                                nextSibling.nextSibling.
                                firstChild.nextSibling.
                                firstChild.firstChild.
                                firstChild.firstChild.setAttribute("disabled", "true");
                        }

                        $.ajax({
                            type: "POST",
                            url: configuraciones.urlBase + "ObtenerTarifa",
                            dataType: "json",
                            timeout: 60000,
                            data: {
                                ordenante: configuraciones.ordenante,
                                grupo: grupo,
                                empresaRecaudacion: empresaRecaudacion,
                                convenio: convenio,
                                monto: 1,
                                tipoCuenta: cuentaSeleccionada.split("@")[0],
                                cuenta: cuentaSeleccionada.split("@")[1]
                            },
                            success: function (tarifa) {
                                removerCargador();

                                var comisionAplicable = 0;

                                if (tarifa.Respuesta.ExitoOperacion) {
                                    comisionAplicable = tarifa.Comision;

                                    configuraciones.pagoActual.configuracion.comision = comisionAplicable * 1;
                                }

                                // Tarifa a aplicar
                                instancia.parentNode.parentNode
                                    .nextSibling.nextSibling
                                    .nextSibling.nextSibling
                                    .nextSibling.nextSibling
                                    .nextSibling
                                    .innerText = UtilidadesUI.renderizarMoneda(comisionAplicable, "$");

                                // Total por fila
                                instancia.parentNode.parentNode.
                                    nextSibling.nextSibling.
                                    nextSibling.nextSibling.
                                    nextSibling.nextSibling.
                                    nextSibling.nextSibling.
                                    innerText = UtilidadesUI.renderizarMoneda(deuda.MontoTotal + comisionAplicable, "$");

                                // Total global, notar el hack horrible...
                                actualizarTotalGlobalInterno(instancia.parentNode.parentNode.
                                    nextSibling.nextSibling.
                                    nextSibling.nextSibling.
                                    firstChild.nextSibling.
                                    firstChild.firstChild.
                                    firstChild.firstChild);

                            },
                            error: function (ex) {
                                removerCargador();

                                configuraciones.pagoActual.deuda = null;
                                configuraciones.pagoActual.configuracion = null;
                                configuraciones.pagoActual.descripcionPago = " ";

                                mostrarMensaje("[Tarifario] Tiempo de espera excedido, por favor reintente en unos minutos", "ERROR");
                            }
                        });



                    } else {
                        configuraciones.pagoActual.deuda = null;
                        configuraciones.pagoActual.configuracion = null;
                        configuraciones.pagoActual.descripcionPago = " ";

                        mostrarMensaje("CLIENTE SIN DEUDA", "ERROR");
                    }

                } else {
                    configuraciones.pagoActual.deuda = null;
                    configuraciones.pagoActual.configuracion = null;
                    configuraciones.pagoActual.descripcionPago = " ";

                    mostrarMensaje(deuda.Respuesta.MensajeError, "ERROR");
                }

            },
            error: function (ex) {
                removerCargador();

                configuraciones.pagoActual.deuda = null;
                configuraciones.pagoActual.configuracion = null;
                configuraciones.pagoActual.descripcionPago = "";
                
                mostrarMensaje("[OTC] Tiempo de espera excedido, por favor reintente en unos minutos", "ERROR");
            }
        });
    };

    /**
     * Permite reconsultar solo la comision aplicable al monto consultado de matricula actual
     * @param {any} instancia Instancia del elemento DOM asociado a la matriculacion en en panel de pagos
     * @param {any} grupo El grupo de pago (AGUA, LUZ, TELEFONIA_FIJA, etc)
     * @param {any} empresaRecaudacion El codigo de la empresa de recaudacion asociado
     * @param {any} convenio El codigo del convenio asociado
     */
    this.recalcularComision = function(instancia, grupo, empresaRecaudacion, convenio){
        
        var cuentaSeleccionada = instancia.parentNode.parentNode.
            nextSibling.nextSibling.
            nextSibling.nextSibling.
            nextSibling.nextSibling.
            firstChild.value;

        configuraciones.pagoActual.configuracion.tipoCuenta = cuentaSeleccionada.split("@")[0];
        configuraciones.pagoActual.configuracion.cuenta = cuentaSeleccionada.split("@")[1];
        
        mostrarCargador();

        $.ajax({
            type: "POST",
            url: configuraciones.urlBase + "ObtenerTarifa",
            dataType: "json",
            timeout: 60000,
            data: {
                ordenante: configuraciones.ordenante,
                grupo: grupo,
                empresaRecaudacion: empresaRecaudacion,
                convenio: convenio,
                monto: 1,
                tipoCuenta: cuentaSeleccionada.split("@")[0],
                cuenta: cuentaSeleccionada.split("@")[1]
            },
            success: function (tarifa) {
                removerCargador();

                var comisionAplicable = 0;

                if (tarifa.Respuesta.ExitoOperacion) {
                    comisionAplicable = tarifa.Comision;

                    configuraciones.pagoActual.configuracion.comision = comisionAplicable * 1;
                }

                // Tarifa a aplicar
                instancia.parentNode.parentNode
                    .nextSibling.nextSibling
                    .nextSibling.nextSibling
                    .nextSibling.nextSibling
                    .nextSibling
                    .innerText = UtilidadesUI.renderizarMoneda(comisionAplicable, "$");

                // Total por fila
                instancia.parentNode.parentNode.
                    nextSibling.nextSibling.
                    nextSibling.nextSibling.
                    nextSibling.nextSibling.
                    nextSibling.nextSibling.
                    innerText = UtilidadesUI.renderizarMoneda(configuraciones.pagoActual.configuracion.monto + comisionAplicable, "$");

                // Total global, notar el hack horrible...
                actualizarTotalGlobalInterno(instancia.parentNode.parentNode.
                    nextSibling.nextSibling.
                    nextSibling.nextSibling.
                    firstChild.nextSibling.
                    firstChild.firstChild.
                    firstChild.firstChild);
                
            },
            error: function (ex) {
                removerCargador();

                configuraciones.pagoActual.deuda = null;
                configuraciones.pagoActual.configuracion = null;
                configuraciones.pagoActual.descripcionPago = " ";

                mostrarMensaje("[Tarifario] Tiempo de espera excedido, por favor reintente en unos minutos", "ERROR");
            }
        });
    }

    /*
     *Permite realizar el pago de una linea de matriculacion OTC
     */
    this.pagar = function () {

        // Validaciones de montos

        var tieneMontosValidos = false;

        var limiteMaximo = (configuraciones.pagoActual.deuda.LimiteMontoMaximo != null && configuraciones.pagoActual.deuda.LimiteMontoMaximo>0) ? configuraciones.pagoActual.deuda.LimiteMontoMaximo*1 : 999999999999;
        var limiteMinimo = (configuraciones.pagoActual.deuda.LimiteMontoMinimo != null && configuraciones.pagoActual.deuda.LimiteMontoMinimo > 0) ? configuraciones.pagoActual.deuda.LimiteMontoMinimo * 1 : 0.01;
        var montoMinimo = (configuraciones.pagoActual.deuda.MontoMinimo != null && configuraciones.pagoActual.deuda.MontoMinimo > 0) ? configuraciones.pagoActual.deuda.MontoMinimo * 1 : 0.01;

        if (configuraciones.pagoActual.configuracion.monto > 0) {
            tieneMontosValidos = true;
        } else {
            tieneMontosValidos = false;
            mostrarMensaje("MONTO DE PAGO NO PUEDE SER CERO", "ERROR");
        }

        // FIXME jvillavc comentado temporalmente hasta que Wendy confirme temas de montos
        // Confirmado pero falta aclaracion funcional
        
        if (configuraciones.pagoActual.configuracion.monto < limiteMinimo) {
            // Monto menor al minimo de pago posible
            tieneMontosValidos = false;
            mostrarMensaje("MONTO DE PAGO INFERIOR AL PERMITIDO", "ERROR");
            
        } else {
            if (configuraciones.pagoActual.configuracion.monto > limiteMaximo) {
                // Monto ingresado supera el monto maximo cancelable
                tieneMontosValidos = false;
                mostrarMensaje("MONTO DE PAGO SUPERIOR AL PERMITIDO", "ERROR");
                
            } else {
                tieneMontosValidos = true;

                if (configuraciones.pagoActual.deuda.FormaPago != null && (configuraciones.pagoActual.deuda.FormaPago == "ABONO" || configuraciones.pagoActual.deuda.FormaPago == "MINIMO")) {
                    if (configuraciones.pagoActual.configuracion.monto < montoMinimo) {
                        // Monto ingresado supera el monto maximo cancelable (por monto minimo)
                        tieneMontosValidos = false;
                        mostrarMensaje("MONTO DE PAGO INFERIOR AL MINIMO PERMITIDO", "ERROR");

                    } else {
                        tieneMontosValidos = true;
                    }
                }

            }
        }
        
        if (tieneMontosValidos) {

            var randomizador = Math.floor(Math.random() * 100000000) + 1;

            var urlPago = configuraciones.urlBase + "../Seguridades/Index?udev=" + randomizador;

            var parametros = "";
            parametros += "&Ordenante=" + configuraciones.pagoActual.configuracion.ordenante;
            parametros += "&Usuario=" + configuraciones.pagoActual.configuracion.usuario;
            parametros += "&Referencia=" + encodeURIComponent(configuraciones.pagoActual.descripcionPago.trim());
            parametros += "&Alias=" + encodeURIComponent(configuraciones.pagoActual.configuracion.alias);
            parametros += "&TipoCuenta=" + ((configuraciones.pagoActual.configuracion.tipoCuenta == "CTE") ? "3" : "4");
            parametros += "&Cuenta=" + configuraciones.pagoActual.configuracion.cuenta;
            parametros += "&Monto=" + configuraciones.pagoActual.configuracion.monto;
            parametros += "&Comision=" + configuraciones.pagoActual.configuracion.comision;
            parametros += "&Grupo=" + configuraciones.pagoActual.configuracion.grupo;
            parametros += "&EmpresaRecaudacion=" + configuraciones.pagoActual.configuracion.empresaRecaudacion;
            parametros += "&Convenio=" + configuraciones.pagoActual.configuracion.convenio;
            parametros += "&TipoIdentificador=" + configuraciones.pagoActual.configuracion.tipoIdentificador;
            parametros += "&Suministro=" + configuraciones.pagoActual.configuracion.suministro;
            parametros += "&NombreEmpresaRecaudacion=" + encodeURIComponent(configuraciones.pagoActual.configuracion.nombreEmpresaRecaudacion);
            parametros += "&NombreConvenio=" + encodeURIComponent(configuraciones.pagoActual.configuracion.nombreConvenio);
            parametros += "&FechaVencimiento=" + encodeURIComponent(UtilidadesUI.renderizarFecha(configuraciones.pagoActual.deuda.FechaVencimiento));
            parametros += "&Cliente=" + encodeURIComponent(configuraciones.pagoActual.deuda.NombreCliente);
            parametros += "&EtiquetaIdentificador=" + encodeURIComponent(configuraciones.pagoActual.configuracion.etiquetaIdentificador);
            
            parametros += "&Deuda=" + encodeURIComponent(JSON.stringify(configuraciones.pagoActual.deuda));
            parametros += "&Configuracion=" + encodeURIComponent(JSON.stringify(configuraciones.pagoActual.configuracion));

            document.location = urlPago + parametros;
        }
    };

    this.actualizarMontos = function (componente) {
        
        if (componente != null) {
            
            if (componente.value.trim() == "") {
                componente.value = "0.00";
            }

            if (configuraciones.pagoActual.configuracion != null) {
                configuraciones.pagoActual.configuracion.monto = ((componente.value.trim() != "") ? componente.value:"0") * 1;
            }
            
            this.actualizarTotalGlobal(componente);
        }
    };

    this.actualizarTotalGlobal = function (componenteOrigen) {
        var comision = 0;
        var monto = 0;

        try {
            comision = componenteOrigen.
                parentNode.parentNode.
                parentNode.parentNode.
                parentNode.nextSibling.
                nextSibling.nextSibling.
                innerText.replace("$", "").
                replace(",", "") * 1;

            monto = componenteOrigen.value.
                replace("$", "").
                replace(",", "") * 1;

            componenteOrigen.
                parentNode.parentNode.
                parentNode.parentNode.
                parentNode.nextSibling.
                nextSibling.nextSibling.
                nextSibling.innerText = UtilidadesUI.renderizarMoneda(comision + monto, "$");

        } catch (ex) {
            comision = 0;
            monto = 0;
        }
        
        $("#" + configuraciones.contenedorTotales).text("Total a Pagar: " + UtilidadesUI.renderizarMoneda(monto + comision, "") + " USD");
    };

    this.encerarMontoFilaActual = function () {
        if (configuraciones.nodoFilaActual != null) {

            if (configuraciones.pagoActual.deuda.FormaPago != null && (configuraciones.pagoActual.deuda.FormaPago == "TOTAL" || configuraciones.pagoActual.deuda.FormaPago == "UNICO_CRONOLOGICO")) {
                // Forma de pago no permite pagos parciales o diferentes a la deuda
                alert("Forma de pago no permite pagos parciales o diferentes a la deuda");
            } else {

                // Encerar campo de forma de pago

                configuraciones.pagoActual.configuracion.monto = 0;
            
                var elementoMonto = configuraciones.nodoFilaActual.
                    firstChild.nextSibling.
                    nextSibling.nextSibling.
                    nextSibling.firstChild.
                    nextSibling.firstChild.
                    firstChild.firstChild.
                    firstChild;

                elementoMonto.value = "0.00";
                $(elementoMonto).trigger("blur");
            }
            
        }
    };

    /**
     * Muestra una pantalla flotante informativa con los detalles de una matriculacion previo al pago
     */
    this.mostrarDetallesRecaudacion = function () {
        if (configuraciones.nodoFilaActual != null) {

            regresarAPosicionScroll();

            var elementoMonto = configuraciones.nodoFilaActual.
                firstChild.nextSibling.
                nextSibling.nextSibling.
                nextSibling.firstChild.
                nextSibling.firstChild.
                firstChild.firstChild.
                firstChild;

            var contenido = "<div style='padding:0px;'><table border='0'>";
            contenido += "<div class='Vigente'>Detalle de servicio matriculado</div>";
            contenido += "<tr><td class='titCampo'>TIPO DE SERVICIO</td><td class='campo'>" + configuraciones.pagoActual.configuracion.grupo.replace(/_/g, " ") + "</td></tr>";
            contenido += "<tr><td class='titCampo'>EMPRESA/SERVICIO</td><td class='campo'>" + configuraciones.pagoActual.configuracion.nombreEmpresaRecaudacion + "</td></tr>";
            contenido += "<tr><td class='titCampo'>IDENTIFICACI&Oacute;N</td><td class='campo'>" + configuraciones.pagoActual.configuracion.suministro + "</td></tr>";
            contenido += "<tr><td class='titCampo'>ALIAS</td><td class='campo'>" + configuraciones.pagoActual.configuracion.alias + "</td></tr>";
            contenido += "<tr><td class='titCampo'>M&Iacute;NIMO A PAGAR</td><td class='campo'>" + UtilidadesUI.renderizarMoneda(configuraciones.pagoActual.deuda.MontoMinimo, "$") + "</td></tr>";
            contenido += "<tr><td class='titCampo'>MONTO DEUDA</td><td class='campo'>" + UtilidadesUI.renderizarMoneda(configuraciones.pagoActual.deuda.MontoTotal, "$") + "</td></tr>";
            contenido += "<tr><td class='titCampo'>FECHA VENCIMIENTO</td><td class='campo'>" + UtilidadesUI.renderizarFecha(configuraciones.pagoActual.deuda.FechaVencimiento) + "</td></tr>";
            contenido += "<tr><td class='titCampo'>NOMBRE ABONADO</td><td class='campo'>" + configuraciones.pagoActual.deuda.NombreCliente + "</td></tr>";
            
            contenido += "</table>";
            contenido += "<div class='separadorSeccion'></div>";
            contenido += "<div class='botonera'><input type='button' class='button' value='Volver' onclick='try{document.getElementById(\"dialogoInternoDetalleRecaudacion\").parentNode.removeChild(document.getElementById(\"dialogoInternoDetalleRecaudacion\"));}catch(ex){}'></div>";
            contenido += "</div> ";

            var contenedorFlotante = document.createElement("div");
            contenedorFlotante.id = "dialogoInternoDetalleRecaudacion";
            contenedorFlotante.className = "covertorNotificacion";
            contenedorFlotante.innerHTML = contenido;

            document.body.appendChild(contenedorFlotante);

            /*
            new $.Zebra_Dialog({
                title: null,
                type: false,
                keyboard: true,
                buttons: [{caption: "Volver", custom_class: "botonDialogoInterno", callback: function () { }}],
                message: contenido,
                width: 400,
                vcenter_short_message: true,
                center_buttons: true
            });
            */

        } else {
            alert("Debe consultar la deuda antes de ver el detalle de pago");
        }
    };

    /**
     * Obtiene una referencia a la instancia del campo de monto seleccionado actual
     **/
    this.obtenerReferenciaCampoMontoActual = function () {
        var elementoMonto = null;
        
        if (configuraciones.nodoFilaActual != null) {

            elementoMonto = configuraciones.nodoFilaActual.
                firstChild.nextSibling.
                nextSibling.nextSibling.
                nextSibling.firstChild.
                nextSibling.firstChild.
                firstChild.firstChild.
                firstChild;
        }

        return elementoMonto;
    };

    this.obtenerReferenciaConfiguracion = function () {
        return configuraciones;
    }

    /**
     * Muestra la configuracion de pago actual
     **/
    this.mostrarConfiguracionPago = function () {
        if (configuraciones.nodoFilaActual != null) {

            regresarAPosicionScroll();

            var elementoMonto = configuraciones.nodoFilaActual.
                firstChild.nextSibling.
                nextSibling.nextSibling.
                nextSibling.firstChild.
                nextSibling.firstChild.
                firstChild.firstChild.
                firstChild;

            var contenido = "<div style='padding:10px'><table border='0' cellspacing='0' cellpadding='0'>";
            contenido += "<div class='Vigente'>Configuraci&oacute;n de Pago</div>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>TIPO DE SERVICIO</td><td class='campo'>" + configuraciones.pagoActual.configuracion.grupo.replace(/_/g, " ") + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>EMPRESA/SERVICIO</td><td class='campo'>" + configuraciones.pagoActual.configuracion.nombreEmpresaRecaudacion + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>IDENTIFICACI&Oacute;N</td><td class='campo'>" + configuraciones.pagoActual.configuracion.suministro + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>ALIAS</td><td class='campo'>" + configuraciones.pagoActual.configuracion.alias + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>M&Iacute;NIMO A PAGAR</td><td class='campo'>" + UtilidadesUI.renderizarMoneda(configuraciones.pagoActual.deuda.MontoMinimo, "$") + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>MONTO DEUDA</td><td class='campo'>" + UtilidadesUI.renderizarMoneda(configuraciones.pagoActual.deuda.MontoTotal, "$") + "</td></tr>";
            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>FECHA VENCIMIENTO</td><td class='campo'>" + UtilidadesUI.renderizarFecha(configuraciones.pagoActual.deuda.FechaVencimiento) + "</td></tr>";

            contenido += "<tr style='background-color:white !important;height:5px;'><td></td><td></td></tr>";
            contenido += "<tr style='padding:10px;'><td class='titCampo'>NOMBRE ABONADO</td><td class='campo'>" + configuraciones.pagoActual.deuda.NombreCliente + "</td></tr>";
            
            contenido += "</table></div>";

            var esValorPagoEditable = !(configuraciones.pagoActual.deuda.FormaPago != null && (configuraciones.pagoActual.deuda.FormaPago == "TOTAL" || configuraciones.pagoActual.deuda.FormaPago == "UNICO_CRONOLOGICO"));

            contenido += "<div class='Vigente' style='margin-bottom:0px !important;padding-left:10px;'>Monto a Pagar</div><div style='padding-left:10px;'><input id='_subselectorMonto' type='text' class='datos datosPequeno' value='" + elementoMonto.value.replace(",", "") + "' style='padding: 1px!important;width:300px;' onkeypress='return ValidacionesUI.validarMoneda(event, this)' " + ((esValorPagoEditable)?"":"disabled")+"></div>";
            contenido += "<div class='Vigente' style='margin-bottom:0px !important;padding-left:10px;'>Descripci&oacute;n</div><div style='padding-left:10px;'><input type='text' id='_subselectorDescripcion' class='datos datosPequeno' value='" + configuraciones.pagoActual.descripcionPago.trim() + "' style='padding: 1px!important;width:300px;'></div>";

            contenido += "<div class='separadorSeccion'></div>";

            // hack horrible
            var handlerBotonActualizacion = "";
            handlerBotonActualizacion += "if ($(\"#_subselectorMonto\").val().trim() == \"\" || $(\"#_subselectorMonto\").val()*1 == 0 ) {";
            handlerBotonActualizacion += "	alert(\"Monto a pagar no puede ser cero\");";
            handlerBotonActualizacion += "} else {";
            handlerBotonActualizacion += "	document.panelOTC.obtenerReferenciaCampoMontoActual().value = $(\"#_subselectorMonto\").val().replace(\",\",\"\");";
            handlerBotonActualizacion += "	$(document.panelOTC.obtenerReferenciaCampoMontoActual()).trigger(\"blur\");";
            handlerBotonActualizacion += "	document.panelOTC.obtenerReferenciaConfiguracion().pagoActual.descripcionPago = $(\"#_subselectorDescripcion\").val();";
            handlerBotonActualizacion += "	try{document.getElementById(\"dialogoInternoConfiguracionPago\").parentNode.removeChild(document.getElementById(\"dialogoInternoConfiguracionPago\"));}catch(ex){}";
            handlerBotonActualizacion += "}";

            contenido += "<div class='botonera'><input type='button' class='button' value='Volver' onclick='try{document.getElementById(\"dialogoInternoConfiguracionPago\").parentNode.removeChild(document.getElementById(\"dialogoInternoConfiguracionPago\"));}catch(ex){}'>&nbsp;<input type='button' class='button botonAcentuado' value='Aceptar' onclick='" + handlerBotonActualizacion+"'></div>";

            var contenedorFlotante = document.createElement("div");
            contenedorFlotante.id = "dialogoInternoConfiguracionPago";
            contenedorFlotante.className = "covertorNotificacion";
            contenedorFlotante.innerHTML = contenido;

            document.body.appendChild(contenedorFlotante);

            /*
            new $.Zebra_Dialog({
                title: null,
                type: false,
                keyboard: false,
                custom_class: "alineacionBotoneraInterna",
                buttons: [
                    { caption: "Volver", custom_class:"botonDialogoInterno" ,callback: function () { } },
                    {
                        caption: "Aceptar",
                        custom_class: "botonDialogoInterno",
                        callback: function () {
                            if ($("#_subselectorMonto").val().trim() == "" || $("#_subselectorMonto").val()*1 == 0 ) {
                                alert("Monto a pagar no puede ser cero");
                            } else {
                                elementoMonto.value = $("#_subselectorMonto").val().replace(",","");
                                $(elementoMonto).trigger("blur");

                                configuraciones.pagoActual.descripcionPago = $("#_subselectorDescripcion").val();

                                return true;
                            }
                            return false;
                        }
                    }
                ],
                message: null,
                source: {
                    inline: contenido
                },
                overlay_close: false,
                show_close_button: false,
                width: 550,
                vcenter_short_message: true,
                center_buttons: false
            });
            */

        } else {
            alert("Debe consultar la deuda antes de ver el detalle de pago");
        }
    };
};

// FIXME Pendiente implementar selector para reemplazar codigo ad-hoc

SelectorEmpresas = function (config) {
    var configuraciones = {
        url: "",
        idCodigo: "",
        idDescripcion: "",
        onSeleccionEmpresa: function () {}
    };

    function init(config) {
        configuraciones.url = config.url;
        configuraciones.idCodigo = config.idCodigo;
        configuraciones.idDescripcion = config.idDescripcion;
        configuraciones.onSeleccionEmpresa = config.onSeleccionEmpresa;
        
    }

    init(config);

    this.mostrarBusquedaEmpresa = function () {
        window.open(configuraciones.url,"BUSQUEDA_EMPRESA","menubar=no,location=no,resizable=no,scrollbars=yes,status=no,width=600,height=400");
    }
}
