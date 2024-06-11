using OTCSATServices.Services;
using OTCSATServices.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Filters;

namespace OTCSAT.Filtros
{
    /// <summary>
    /// Control de sesion y token de seguridad aplicativo
    /// </summary>
    public class FiltroAutenticacion : ActionFilterAttribute, IAuthenticationFilter
    {
        private bool _esAutorizado;
        private ISeguridadesService servicioSeguridades = new SeguridadesService();

        public void OnAuthentication(AuthenticationContext filterContext)
        {

            var usuario = filterContext.HttpContext.Session["Usuario"];

            if (usuario != null && usuario.ToString().Equals("HABILITADO"))
            {
                _esAutorizado = true;
            }
            else
            {
                string tokenAplicativo = filterContext.HttpContext.Request.QueryString["Token"];

                if (!string.IsNullOrEmpty(tokenAplicativo))
                {
                    filterContext.HttpContext.Session.Clear();

                    if (servicioSeguridades.EsSesionValida(tokenAplicativo))
                    {
                        // Habilitado para trabajar

                        filterContext.HttpContext.Session["Usuario"] = "HABILITADO";
                        _esAutorizado = true;
                    }
                    else
                    {
                        filterContext.HttpContext.Session["Usuario"] = null;
                        _esAutorizado = false;
                    }
                }
                else
                {
                    filterContext.HttpContext.Session.Clear();
                    filterContext.HttpContext.Session["Usuario"] = null;

                    _esAutorizado = false;
                }
            }
            
        }

        public void OnAuthenticationChallenge(AuthenticationChallengeContext filterContext)
        {
            var usuario = filterContext.HttpContext.Session["Usuario"];

            if (usuario == null || !usuario.ToString().Equals("HABILITADO"))
            {
                filterContext.Result = new HttpUnauthorizedResult();
            }
            
        }
    }
}