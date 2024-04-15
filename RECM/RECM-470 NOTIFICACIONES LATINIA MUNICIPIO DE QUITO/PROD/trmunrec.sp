use cob_pagos
go

if exists(select 1 from sysobjects where name = 'sp_tr_municipio_recaudacion' and type = 'P')
begin
   drop procedure dbo.sp_tr_municipio_recaudacion
   if exists (select 1 from sysobjects where name = 'sp_tr_municipio_recaudacion' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_tr_municipio_recaudacion -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_tr_municipio_recaudacion *OK* =='
end
go

/************************************************************************/
/*  Archivo:            trmunrec.sp                                     */
/*  Stored procedure:   sp_tr_municipio_recaudacion                     */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACTIVA                                       */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_servicios                                   */
/*  Producto:           Cuentas Corrientes                              */
/*  Disenado por:       Hugo Y�pez                                      */
/*  Fecha de escritura: 25-dic-2005                                     */
/*  Procesamiento:      OLTP                                            */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "BANCO BOLIVARIANO".                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.      */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las recaudaciones de municipio de quito       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/dic/2005 Hugo Y�pez  Emisi�n inicial                             */
/*  10/ene/2006 Hugo Y�pez  Inlcuir tarjeta credito como forma de pago  */
/*  11/ene/2006 Hugo Y�pez  Incluir el ssn reverso en tran_servicio     */
/*  12/ene/2006 Hugo Y�pez  Para los imptos q no existen mostrar OTROS  */
/*  18/ene/2006 MGavilanez  Condicionar mensajes de error para aplic.   */
/*                          cobis y no cobis.                           */
/*  23/ene/2006 D. Gomez    Establecer horarios de pago                 */
/*  01/feb/2006 D. Gomez    Habilitar pago con tarjeta de credito       */
/*  15/feb/2006 Hugo Y�pez  Inicializar la variable fecha con getdate   */
/*  14/ago/2006 Hugo Y�pez  Mun.quito ahora trabaja con tramas          */
/*  20/oct/2006 Luis Chacha Permitir forma de pago: Tarjeta de credito  */
/*  21/dic/2006 Hugo Y�pez  Quitar la validaci�n del cliente bb         */
/*  22/feb/2007 Hugo Y�pez  Incorporar municipio 1800                   */
/*  25/Jun/2007 Luis Chacha Parametro @i_con_tran en D�bito Corriente   */
/*  05/Nov/2007 Hugo Y�pez  Inclusi�n mun ibarra archivos locales       */
/*  23/Feb/2008 German Medina C.  Muni. de Samborondon pagos prediales  */
/*  07/Mar/2008 German Medina C.  Muni. de Salinas pagos prediales    */
/*  09/Abr/2008 German Medina C.  Muni. de Sta. Elena pagos prediales   */
/*  15/Agt/2008 Wise Computer S.A.  Muni. de LIBERTAD pagos prediales   */
/*  28/Oct/2008 Luis F. Chacha M.  Municipio Gye Recaudacion no clientes*/
/*  20/Jun/2009 Luis F. Chacha M. Mi Lote(M.I. Municipio de Guayaquil)  */
/*22 21/ENE/2011 German Medina C. Comisiones Municipios CTE-7598        */
/*23 30/Jun/2010   Ana Mendez  CTE-CC-8966  Muni Cuenca otros rubros  */
/*24 04/Mar/2011   Ana Mendez  CTE-CC-9737  Muni Gye mercados  */
/*25 04/Mar/2011   Ana Mendez  CTE-CC-10088 ATM en anio en campo @i_agno para 1433   */
/*3 06/08/2011     Sandra Merino    CTE-CC-10040 Autoimpresores         */
/*26 04/Ago/2011   Natalia Chavez   CTE-CC-10305 Municipio Daule         */
/*27 24/Ago/2011   Daniel Pereira   CTE-CC-10305 Municipio Daule         */
/*   13/12/2012     Sandra Merino    CTE-CC-SGC00006244                  */
/*29 10/Ene/2013   Daniel Pereira   CTE-CC-SGC00006747/CTE-CC-SGC00006892*/
/*30 20/Ene/2014   Daniel Pereira   SGC00012170 Facturacion Electronica */
/*31 05/Ago/2015   Mar�a Jos� Silva  SOA fase 2 Otros Municipios */
/*32 29/Jul/2016 Luis Banda   RECA-CC-SGC00025868 se agrega validacion  */
/*               para obtener descuento de la comision para damnificados*/
/*33 16/febr/2017 	smerinom      RECA-CC-SGC00027947		*/
/*34 26/Nov/2015    Mar�a Jos� Silva          CEP                */
/*35 02/Ene/2019  Danny Olaya Soriano RECA-CC-SGC00034201 - Mensaje de Advertencia SAMBORONDON */
/*36 21/Ene/2019  Daniel Pereira     RECA-CC-SGC00034259 Optimizaci�n   */ 
/*37 24/DIC/2020  Josu� Rocafuerte   RECM-227 Parametrizaci�n de Mensaje Advertencia SAMBORONDON */ 
/*38 17/Feb/2021  Daniel pereira     RECMPS-655 Pago con TC     */
/*39 21/Abr/2021  Josu� Rocafuerte   RECMPS-580 Notificacion Latinia   */
/************************************************************************/



create proc dbo.sp_tr_municipio_recaudacion (
    @s_ssn         int,
    @s_srv         varchar(30),
    @s_lsrv        varchar(30),
    @s_user        varchar(30),
    @s_sesn        int         = null,
    @s_term        varchar(10),
    @s_date        datetime , -- = '01/13/2014' ,
    @s_ofi         smallint,           /* Localidad origen transaccion */
    @s_rol         smallint,
    @s_org_err     char(1)     = null, /* Origen de error: [A], [S] */
    @s_error       int         = null,
    @s_sev         tinyint     = null,
    @s_org         char(1),
    @t_corr        char(1)     = 'N',
    @t_ssn_corr    int         = null, /* Trans a ser reversada */
    @t_debug       char(1)     = 'N',
    @t_file        varchar(14) = null,
    @t_from        varchar(32) = null,
    @t_rty         char(1)     = 'N',
    @t_trn         int,                --hy-22-febrero-2007 antes era tipo smallint	
    @i_opcion      char(1)     = 'T',
    @i_municipio   int         = 0,
    @i_cod_impto   varchar(3)  = null,
    @i_no_predio   int         = null,
    @i_identifica  varchar(15) = null,
    @i_agno        smallint    = 0,
    @i_semestre    varchar(2)  = null,
    @i_prioridad   smallint    = null,
    @i_nombre      varchar(80) = null,
    @i_cant_chq    int         = null,
    @i_efe         money       = 0,
    @i_cheque      money       = 0,
    @i_producto    char(3)     = null,
    @i_cuenta      cuenta      = null,
    @i_debito      money       = null,
    @i_tarjeta     money       = null,
    @i_mon         tinyint     = 1,
    @i_tsn         int         = 0,
    @i_autoriza    char(1)     = 'N',
    @i_supautor    login       = null,
    @i_ubi         int         = null,
    @i_canal       varchar(3)  = 'VEN',
    @i_valch       money       = null,     -- DGA 23/Ene/2006
    @i_aplcobis    varchar(1)  = 'S',     --mgavilat 18-ene-2006. para VEN e IBK no necesitan enviarlo.
    @i_efe_com     money = 0,             --hy-15-feb-2006
    @i_chq_com     money = 0,             --hy-15-feb-2006
    @i_deb_com     money = 0,             --hy-15-feb-2006
    @i_tipocta_com char(3) = null,        --hy-15-feb-2006
    @i_cta_com     cuenta  = null,        --hy-15-feb-2006
    @i_cod_cat     varchar(40)= null,    --hy-15-feb-2006
    @i_psector         varchar(5)      = null,
    @i_pmanzana         varchar(5)      = null,
    @i_plote            varchar(5)      = null,
    @i_pdivision        varchar(5)      = null,
    @i_pphv             varchar(5)      = null,
    @i_pphh             varchar(5)      = null,
    @i_pnumero          varchar(10)      = null, --Ref034:msilvag 
    @i_panio_vigencia   varchar(4)      = null,
    @i_transac     char(1)    = 'S',     --hy-15-feb-2006
    @i_secuencial  varchar(6) = null,    --hy-15-feb-2006
    @i_psecuencial_adq       int  = null,    --REF 23 ame
    @i_hora_trama  varchar(6) = null,    --hy-15-feb-2006
    @i_titulo      varchar(25) = null,   --hy-14-ago-2006
    @i_tipo_impto  varchar(10) = null,   --hy-14-ago-2006
    @i_cedruc      varchar(14) = null,   --hy-14-ago-2006
    @i_catastro    varchar(20) = null,   --hy-05-nov-2007
    @i_catastro2   varchar(60) = null,   --GAMC - 23/02/2008
    @i_catastro3   varchar(20) = null,   --GAMC - 23/02/2008
    @i_catastro4   varchar(20) = null,   --GAMC - 23/02/2008
    @i_referencia  varchar(20) = null,   --hy-05-nov-2007
    @i_referencia2 varchar(30) = null,   --GAMC - 23/02/2008
    @i_fecven      datetime    = null,   --hy-05-nov-2007
    @i_empresa     varchar(4)  = null,   --lfcm 26-junio-2009
    @i_cuota       varchar(4)  = null,   --lfcm 06-julio-2009
    @i_codresbr    varchar(6)  = null,   --lfcm 06-julio-2009
   ---- @o_codresbr    varchar(6)  = null out, --lfcm 06-julio-2009  ref3
    @o_ssn         int         = 0  out,
    @o_nombcta     descripcion = '' out, -- ref3
    @o_horario     char(1)     = '' out,   --hy-12-enero-2006
    @o_autorisri   varchar(30) = null out, --hy-15-feb-2006
    @o_fecvensri   varchar(30) = null out, --hy-15-feb-2006
    @o_nota_venta  varchar(15) = null out, --hy-15-feb-2006
    @o_fechora     varchar(16) = '' out,   --hy-15-feb-2006
    @o_feccontable varchar(10) = '' out,   --hy-15-feb-2006
    @o_fecha_efe   datetime    = null out, -- DGA 23/Ene/2006
    @o_comision    money       = 0 out,    --hy-15-feb-2006
    @o_secuencial  int         = 0  out,   --hy-15-feb-2006
    @o_nom_cli     varchar(40) = null out, --hy-15-feb-2006,
    @o_fecha_ef    varchar(10) = null out,  --hy-15-feb-2006
    @o_referencia2 varchar(30) = null out,   --GAMC - 23/02/2008
    @o_direccion   varchar(30) = null out,   --GAMC - 23/02/2008
    @o_solar     varchar(30) = null out,   --GAMC - 23/02/2008
    @o_valorpredio money     = null out,   --GAMC - 23/02/2008
    @o_valorotros  money     = null out,   --GAMC - 23/02/2008
    @o_doc_ident   varchar(14) = null out,   --GAMC - 05/03/2008
    @i_ofiretiro   varchar(10) = null,     --GAMC - 17/03/2008
    @o_cod_ident   char(1)     = null out,   --GAMC - 26/03/2008
    @o_msg         varchar(200)    = null out,    --lfcm 26-junio-2009
    @o_fecha_comp  varchar(8)      = null out,    --lfcm 26-junio-2009
    @o_pcuic           varchar(10)     = null out,    --GAMC 21ENE2010
    @o_pautorizacion   varchar(10)     = null out,     --GAMC 21ENE2010
    ----@o_nombcta     descripcion = '' out ref3
    @o_codresbr    varchar(6)  = null out, --lfcm 06-julio-2009
    @o_tasa              money = 0 out,  --smerino
    @o_base_imp          float = 0 out,  --smerino
    @o_impuesto          float = 0 out,  --smerino
   /* INI REF39 */
   @o_servicio_not 	varchar(5) = null out,
   @o_nomb_ente     varchar(64) = null out,
   @o_cod_ente      varchar(20) = null out,
   @o_desccanal     varchar(16) = null out,
   @o_celular       varchar(10) = null out,
   @o_correo        varchar(64) = null out,
   @o_desc_empresa  varchar(40)  = null out,
   @o_prod_deb      char(3) = null out,
   @o_valor		varchar(11) = null out,
   @o_fecha_deb	varchar(10) = null out,
   @o_hora_deb 	varchar(8) = null out,
   @o_valor_comi	varchar(11) = null out,
   @o_valor_tot	varchar(11) = null out,
   @o_cta_lat	char(3)  = null out,
   @o_tipo_serv varchar(16)  = null out
   /* FIN REF39*/
    )
as
declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_factor      int,
    @w_maximo_p    money,
    @w_secuencial  int,
    @w_contador    int,
    @w_empresa     varchar(6),
    @w_hora_tope   int,        --hy-12-enero-2006
    @w_hora_sys    char(8),    --hy-12-enero-2006
    @w_hora        int,        --hy-12-enero-2006
    @w_offline     char(1),    -- DGA 23/Ene/2006
    @w_ind_diferido char(1),   -- DGA 23/Ene/2006
    @w_fecha_hoy   varchar(10), -- DGA 23/Ene/2006
    @w_trn         int,         --hy-15-feb-2006
    @w_servicio    varchar(6),  --hy-15-feb-2006
    @w_com         money,       --hy-15-feb-2006
    @w_rubro       char(4),     --hy-15-feb-2006
    @w_serie       varchar(6),  --hy-15-feb-2006
    @w_cod_cat     varchar(40), --hy-15-feb-2006
    @w_tipocta     char(3),     --hy-15-feb-2006
    @w_cuenta      cuenta,      --hy-15-feb-2006
    @w_fechora         datetime,    --hy-15-feb-2006
    @w_hh              varchar(2),  --hy-15-feb-2006
    @w_mm              varchar(2),  --hy-15-feb-2006
    @w_ss              varchar(2),  --hy-15-feb-2006
    @w_ms              varchar(2),  --hy-15-feb-2006
    @w_secuencia_ssn   varchar(20), --hy-15-feb-2006
    @w_causal          varchar(4),  --hy-14-agosto-2006
    @w_clave_concilia  varchar(40), --hy-14-agosto-2006
    @w_cedruc          varchar(14), --hy-14-agosto-2006
    @w_causalcom       varchar(3),  --hy-14-agosto-2006
    @w_referencia      varchar(30), --Ref034:msilvag     varchar(15),  --hy-14-agosto-2006
    @w_tipoid          char(1),     --hy-05-noviembre-2007
    @w_catastrotemp    varchar(30), --hy-05-noviembre-2007 --GAMC - 24/02/2008 - Se incremento en 10
    @w_alt_dos         varchar(30), --hy-05-noviembre-2007
    @w_fecven          datetime,    --hy-05-noviembre-2007
    @w_fec_susp        datetime,    --hy-05-noviembre-2007
    @w_flag_susp       char(1),     --hy-05-noviembre-2007
    @w_descripcion_ec  varchar(60), --GAMC - 25/02/2008
    @w_valor1      varchar(10), --GAMC - 18/03/2008
    @w_valor2      varchar(10), --GAMC - 18/03/2008
    @w_valor3      varchar(10), --GAMC - 18/03/2008
    @w_cadena      varchar(10), --GAMC - 18/03/2008
   @w_fecha_comp          varchar(10), --lfcm 26-junio-2009
   -->Validaciones de Fondos Disponibles en las Cuentas.
   @w_estado_cta_cte      char(1),     --lfcm 26-junio-2009
   @w_estado_cta_aho      char(1),     --lfcm 26-junio-2009
   @w_disponible_cte      money,       --lfcm 26-junio-2009
   @w_disponible_aho      money,       --lfcm 26-junio-2009
   @w_saldo_contable      money,       --lfcm 26-junio-2009
   @w_disponible_valsus   money,       --lfcm 26-junio-2009
   @w_saldo_valsus        money,       --lfcm 26-junio-2009
   @w_cta_cte             int,         --lfcm 26-junio-2009
   @w_cta_aho             int,         --lfcm 26-junio-2009
   @w_hora_trn            varchar(5),  --lfcm 26-junio-2009
   @w_hora_dif            varchar(9),   --lfcm 26-junio-2009
   @w_trx_orig            int  ,         --- REF 24
    --smerino
   @w_tasa         money,
   @w_base_imp     float,
   @w_impuesto2     float,
   @w_valor_tot    money, --REF29
   @w_fecha_desde_excep   datetime, --REF 30
   @w_fecha_hasta_excep   datetime, --REF 30
   @w_hora_dif_excep      varchar(8), --REF 30 
	@w_tipoSer_cep     varchar(30), --Ref034:msilvag
   /*REF32 Inicio LBP */ 
   @w_valor_compensa   money,
   @w_comi_total       money,
   @w_com_original     money,
   @w_aplica_des       char(1),
   /*REF32 Fin LBP */ 
   /*REF35 Ini*/
   @w_mensaje       varchar(200),
   /*REF35 Fin*/
   /* INI REF39 */
   @w_servicio_alert      char(5), 
   @w_ssn      		  int, 
   @w_desc_canal   	  varchar(16), 
   @w_empresaLAT   	  varchar(40), 
   @w_valor_debito	  varchar(11),
   @w_desc_serv 	  varchar(11),
   @v_cliente         	  int,
   @v_telefono         	  varchar(10), 
   @v_correo           	  varchar(64), 
   @v_return		  int,
   /* FIN REF3 */
   @w_val_date        datetime  -- REF37
   


select @w_sp_name = 'sp_tr_municipio_recaudacion'
select @o_ssn     = @s_ssn
select @o_nombcta = ''
select @w_fecha_hoy = convert(varchar(10), getdate(),101)  --hy-15-feb-2006

select @w_valor_tot = isnull(@i_efe,0) + isnull(@i_cheque,0) + isnull(@i_debito,0) + isnull(@i_tarjeta,0) --REF29

--<GAMC - 21ENE10>--<VALIDACION DE HORARIO PARA: MUNI QUITO - GUAYAQUIL>--
if (@t_trn = 62166 or @t_trn = 62170 or @t_trn=62233 or @t_trn= 62168 or   @t_trn= 62027) and @i_opcion = 'T' --nchavezb 03/16/2011
begin
  if @i_canal = 'VEN'
  begin
    --Identifico si estoy en el horario normal o diferido oficina
    select @w_hora_trn = convert(varchar,getdate(),108)
    select @w_hora_dif = rh_inicio,
           @w_fecha_desde_excep =rh_fecha_desde,  --REF 30
           @w_fecha_hasta_excep = rh_fecha_hasta, --REF 30
           @w_hora_dif_excep = rh_nuevo_inicio   --REF 30
    from cob_remesas..re_horario where rh_oficina = @s_ofi and rh_ubicacion = @i_ubi

    ---Si la fecha de proceso esta dentro delperiodo de excepcion reemplazo la hora del diferido por la hora de excepcion
    if  @s_date >= @w_fecha_desde_excep  and @s_date <= @w_fecha_hasta_excep --REF *30
        select @w_hora_dif = @w_hora_dif_excep

    if  @w_hora_trn >= @w_hora_dif  ----and @i_cheque > 0
      select @t_trn = 4112   --- REF 24  ---- 3216      --Horario Diferido    3221 = TrxLuzAjusteDiferido
    else
      select @t_trn = 3215      --Horario Normal
  end
  else
    select @t_trn = 3215
end


if @i_empresa is null
   select @i_empresa = convert(varchar,@i_municipio)

if @i_municipio = 1435 or (@i_municipio = 7749 and @i_tipo_impto = "003" ) --Ref034:msilvag
    select @i_agno = @i_no_predio



-->Opcion de Validacion para Municipios desde el CPS
if @i_opcion = 'M'
begin
   select @w_fecha_hoy = convert(varchar(10), getdate(),101)
   select @w_fecha_comp = convert(varchar(10),fp_fecha,101) + ' ' + convert(varchar(10),getdate(),108) from cobis..ba_fecha_proceso
   -->lfcm 15-dic-2008
   --> OBTIENE HORA TOPE >
   select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
   from cobis..cl_tabla a, cobis..cl_catalogo b
   where a.tabla = 'sv_horario_serv'
   and a.codigo = b.tabla
   and b.codigo = @i_empresa    --1434=MiLote
   and estado = 'V'
   if @@rowcount = 0 or @w_hora_tope = 0
   begin
      if @i_aplcobis = 'S'
      begin
         exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
         @i_num           = 111111
         return 1
      end
      else
         return 37601
   end

   select @w_hora_sys = convert(varchar(08),getdate(),108)
   select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
   select @w_offline = atm_offline from cobis..ba_fecha_proceso


   --Diferido Oficina, Oficina Mi Lote
   if @w_hora >= @w_hora_tope and @w_offline = 'N' and @s_date = @w_fecha_hoy --and @t_corr = 'N'
   begin
      select @w_fecha_comp = convert(varchar(10), min(dl_fecha),101)
      from cob_cuentas..cc_dias_laborables
      where dl_ciudad = 1
      and dl_num_dias = 1
   end
   select @o_fecha_comp = substring(@w_fecha_comp,7,4) + substring(@w_fecha_comp,1,2) + substring(@w_fecha_comp,4,2)
    --<lfcm 15-dic-2008

   if @t_corr = 'S'
   begin
      return 0
   end

   if @i_canal = 'VEN'
   begin
      exec @w_return = cob_remesas..sp_verifica_caja_rc
      @s_ssn    = @s_ssn,
      @s_srv    = @s_srv,
      @s_lsrv   = @s_lsrv,
      @s_user   = @s_user,
      @s_sesn   = @s_sesn,
      @s_term   = @s_term,
      @s_date   = @s_date,
      @s_ofi    = @s_ofi,
      @s_rol    = @s_rol,
      @s_sev    = @s_sev,
      @s_org    = @s_org,
      @t_trn    = @t_trn,
      @t_corr   = @t_corr,
      @i_mon    = @i_mon,
      @i_ubi    = @i_ubi,
      @o_horario = @o_horario out  --hy-15-feb-2006
      if @w_return != 0
         return @w_return
   end


   if @w_valor_tot <= 0 --REF29
   begin
       exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_msg           = 'VALOR A PAGAR, NO PUEDE SER CERO',
         @i_num           = 111111
         return 1
   end


   if @i_producto = 'CTE' and @i_debito > 0
   begin
      select
      @v_cliente = cc_cliente, --REF39
      @w_cta_cte = cc_ctacte,
      @w_estado_cta_cte = cc_estado
      from cob_cuentas..cc_ctacte
      where cc_cta_banco = @i_cuenta

      exec @w_return = cob_cuentas..sp_calcula_saldo
      @i_cuenta           = @w_cta_cte,
      @i_fecha            = @s_date,
      @i_ofi              = @s_ofi,
      @o_disponible       = @w_disponible_valsus out,
      @o_saldo_para_girar = @w_disponible_cte out,
      @o_saldo_contable   = @w_saldo_contable out,
      @o_saldo_valsus     = @w_saldo_valsus out

      if @w_estado_cta_cte <> 'A'
      begin
         if @i_aplcobis = 'S'
            exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'CUENTA NO ESTA ACTIVA',
            @i_num           = 111111
         else
            select @o_msg = '[' + @w_sp_name + ']  ' + 'CUENTA NO ESTA ACTIVA'
         return 1
      end

      --OJO - QUITAR
      --set @w_disponible_cte = 0

      if @i_debito > @w_disponible_cte
      begin
         if @i_aplcobis = 'S'
            exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'FONDOS INSUFICIENTES',
            @i_num           = 111111
         else
            select @o_msg = '[' + @w_sp_name + ']  ' + 'FONDOS INSUFICIENTES'
         return 1
      end
   end

   if @i_producto = 'AHO' and @i_debito > 0
   begin
      select
      @v_cliente = ah_cliente, --REF39
      @w_estado_cta_aho = ah_estado,
      @w_cta_aho = ah_cuenta
      from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cuenta

      if @w_estado_cta_aho <> 'A'
      begin

         if @i_aplcobis = 'S'
            exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'CUENTA NO ESTA ACTIVA',
            @i_num           = 111111
         else
            select @o_msg = '[' + @w_sp_name + ']  ' + 'CUENTA NO ESTA ACTIVA'
         return 1
      end

      exec @w_return = cob_ahorros..sp_ahcalcula_saldo
      @t_debug            = null,
      @t_file             = null,
      @t_from             = @w_sp_name,
      @i_cuenta           = @w_cta_aho,
      @i_fecha            = @s_date,
      @i_ofi              = @s_ofi,
      @o_saldo_para_girar = @w_disponible_aho out,
      @o_saldo_contable   = @w_saldo_contable out


      --OJO - QUITAR
      --set @w_disponible_aho = 0

      if @i_debito > @w_disponible_aho
      begin
         if @i_aplcobis = 'S'
            exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'FONDOS INSUFICIENTES',
            @i_num           = 111111
         else
            select @o_msg = '[' + @w_sp_name + ']  ' + 'FONDOS INSUFICIENTES'
         return 1
      end
  end
  return 0
end
--<Opcion de Validacion para Municipios desde el CPS


--GAMC - 25/02/2008
--SE PARTIO EL CODIGO DE CATASTRO POR QUE LOS PAREMETROS PARA LOS REVERSOS
--SOPORTAN STRING DE 20.
if @i_municipio = 2319
begin
  if @i_catastro4 <> ""
    set @i_catastro2 = @i_catastro2 + @i_catastro3 + @i_catastro4
  else
    set @i_catastro2 = @i_catastro2 + @i_catastro3
end

--GAMC - 18/03/2008 - Obtener la ciudad de la oficina de retiro


if (@i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236 or @i_municipio = 1430) and @i_opcion = 'X' /* Wise M. Libertad=2236 Wise - 15/Agt/2008 */
begin --if @i_municipio = 2237 and @i_opcion = 'X' - INI

  select @o_direccion = a.valor
  from cobis..cl_catalogo a, cobis..cl_tabla b
  where b.tabla like 'cl_muni_ciudad_titulos'
  and b.codigo = a.tabla
  and a.codigo = @i_ofiretiro

  return 0
end --if @i_municipio = 2237 and @i_opcion = 'X' - FIN

-->lfcm 25-junio-2007
if @i_municipio = 9999
begin
  return 0
end
--<lfcm 25-junio-2007

-->hy-22-febrero-2007
if @i_municipio = 2234
begin
   if (@i_canal='VEN') or (@i_canal='IBK' and @i_opcion <> 'C')
   begin
      select @w_flag_susp = b.valor
      from cobis..cl_tabla a, cobis..cl_catalogo b
      where a.tabla = 'sv_emp_susp_serv'
        and a.codigo = b.tabla
        and b.codigo = convert(varchar(10),@i_municipio)
        and estado = 'V'
      if @w_flag_susp = 'S'
      begin
         if @i_aplcobis = 'S'
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 031064,
                 @i_msg   = 'MUNICIPIO SE ENCUENTRA EN ACTUALIZACION, INTENTE EN UNOS MINUTOS'
            return 1
         end
         else
            return 31064
      end

      if exists (select 1
                 from cobis..cl_tabla a, cobis..cl_catalogo b
                 where a.tabla = 'sv_emp_aplica_susp'
                   and a.codigo = b.tabla
                   and b.codigo = convert(varchar(10),@i_municipio)
                   and estado = 'V')
      begin
         select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
         from cobis..cl_tabla a, cobis..cl_catalogo b
         where a.tabla = 'sv_horario_serv'
           and a.codigo = b.tabla
           and b.codigo = convert(varchar(10),@i_municipio)
           and estado = 'V'
         if @@rowcount = 0 or @w_hora_tope = 0
         begin
            if @i_aplcobis = 'S'
            begin
               exec cobis..sp_cerror
                    @t_debug         = @t_debug,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
                    @i_num           = 111111
               return 1
            end
         else
            return 111111
         end

         select @w_hora_sys = convert(varchar(08),getdate(),108)
         select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))

         if @w_hora >= @w_hora_tope
         begin
            --Revisar si el proceso esta suspendido o no
            select @w_fec_susp = convert(datetime,b.valor)
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'sv_emp_susp_fec'
              and a.codigo = b.tabla
              and b.codigo = convert(varchar(10),@i_municipio)
              and estado = 'V'
            if @w_fec_susp <= @s_date
            begin
               if @i_aplcobis = 'S'
               begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 031064,
                       @i_msg   = 'MUNICIPIO SE ENCUENTRA EN ACTUALIZACION, INTENTE EN UNOS MINUTOS'
                  return 1
               end
               else
                  return 31064
            end
         end
      end
   end
end
--<hy-22-febrero-2007

-->hy-22-febrero-2007
if @i_municipio = 1800
begin
   select @t_trn = 3215
   if @i_hora_trama = 'D'
      select @t_trn = 3216
end
--<hy-22-febrero-2007

if @i_municipio = 1417
   select @i_identifica = replicate('0',14-datalength(rtrim(ltrim(@i_identifica)))) + rtrim(ltrim(@i_identifica))

-->hy-15-feb-2006
if @i_opcion = 'S' or @t_corr = 'S'
begin
   select @w_fechora     = getdate()
   select @w_hh          = convert(varchar(2),datepart(hh,@w_fechora))
   select @w_hh          = replicate('0',2-datalength(@w_hh)) + @w_hh
   select @w_mm          = convert(varchar(2),datepart(mi,@w_fechora))
   select @w_mm          = replicate('0',2-datalength(@w_mm)) + @w_mm
   select @w_ss          = convert(varchar(2),datepart(ss,@w_fechora))
   select @w_ss          = replicate('0',2-datalength(@w_ss)) + @w_ss
   select @w_ms          = convert(varchar(2),datepart(ms,@w_fechora)/10)
   select @w_ms          = replicate('0',2-datalength(@w_ms)) + @w_ms
   select @o_fechora     = convert(varchar(8),@w_fechora,112) + @w_hh + @w_mm + @w_ss + @w_ms

   select @o_feccontable = convert(varchar(10),@w_fechora,101)


   select @o_secuencial = @s_ssn

--Ref034:msilvag Inicio
 if @i_municipio = 7749  --smerino cep
   begin
   
               select @w_tipoSer_cep=b.valor
               from cobis..cl_tabla a, cobis..cl_catalogo b
               where a.tabla = 'cl_tipo_servicio_cep'
                 and a.codigo = b.tabla
                 and b.codigo = @i_tipo_impto   ---'STH-TRT'
                 and estado = 'V'
                 
     select @o_referencia2=@w_tipoSer_cep
   
   end
--Ref034:msilvag Fin
   if @t_corr = 'N'
      return 0
end
--<hy-15-feb-2006

-->hy-15-feb-2006
--Si es municipio de guayaquil armar el codigo catastral
if @i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) --Ref034:msilvag 
begin
   if @i_canal = 'ATM'
      select @w_cod_cat = @i_cod_cat
   else
   begin

      select @i_psector = replicate('0',3-datalength(@i_psector)) + @i_psector
      select @i_pmanzana = replicate('0',4-datalength(@i_pmanzana)) + @i_pmanzana
      select @i_plote = replicate('0',3-datalength(@i_plote)) + @i_plote
      select @i_pdivision = replicate('0',4-datalength(@i_pdivision)) + @i_pdivision
      select @i_pphv = replicate('0',4-datalength(@i_pphv)) + @i_pphv
      select @i_pphh = replicate('0',4-datalength(@i_pphh)) + @i_pphh

      set @w_cod_cat = @i_psector + @i_pmanzana + @i_plote + @i_pdivision + @i_pphv + @i_pphh
   end
   select @o_pcuic = @o_pcuic --GAMC - 21ENE10 - Comprobante de Ingreso de Caja
end



--fecha del sri
select @o_fecvensri = pa_char
from cobis..cl_parametro
where pa_nemonico = 'FECVAL'
and pa_producto = 'CTE'

--aurorizacion del sri
select @o_autorisri = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NUMAUT'
and pa_producto = 'CTE'

if @i_canal = 'VEN' and ( @i_municipio = 1434 or (@i_municipio = 7749 and @i_tipo_impto = "002" ) ) --Ref034:msilvag
   set @o_fecvensri = @o_autorisri || " - " || @o_fecvensri

select @w_offline = atm_offline
from cobis..ba_fecha_proceso

--Determinar el valor de la comisi�n y devolverlo
--hy-14-agosto-2006 incluir las comisiones de mun.quito
--SMERINO EXTREA BASE IMPONIBLE E IVA
if @i_opcion = 'V' or @i_opcion = 'C'
begin



   if @i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) --Ref034:msilvag 
   begin
      if @i_canal = 'VEN'
      begin
         select @w_rubro = 'CPMG'
         select @w_tipocta = null
         select @w_cuenta  = null
      end
      else
      begin
         select @w_rubro   = 'CIMP'
         select @w_tipocta = @i_producto
         select @w_cuenta  = @i_cuenta
      end
   end
   else
      if @i_municipio = 1417
      begin
         if @i_canal = 'VEN'
         begin
            select @w_rubro = 'CPMQ'
            select @w_tipocta = null
            select @w_cuenta  = null
         end
         else
         begin
            select @w_rubro   = 'CIMP'
            select @w_tipocta = @i_producto
            select @w_cuenta  = @i_cuenta
         end
      end
      else
         begin
            if @i_municipio = 1800
            begin
               --agregar para municipio 1800
               if @i_canal = 'VEN'
               begin
                  select @w_rubro = 'PIMC'
                  select @w_tipocta = null
                  select @w_cuenta  = null
               end
               else
               begin
                  select @w_rubro   = 'CIMP'
                  select @w_tipocta = @i_producto
                  select @w_cuenta  = @i_cuenta
               end
            end
            else
             begin
       if @i_municipio = 2236
        begin
         /* Wise M. Libertad 2236 19/Agt/2008 */
         if @i_canal = 'VEN'
         begin
      select @w_rubro = 'PMLB'
      select @w_tipocta = null
      select @w_cuenta  = null
         end
         else
         begin
      select @w_rubro   = 'CIMP'
      select @w_tipocta = @i_producto
      select @w_cuenta  = @i_cuenta
         end
        end
             else
     begin
           if @i_municipio = 1434 or (@i_municipio = 7749 and @i_tipo_impto = "002" ) --Ref034:msilvag    --1434 : Mi Lote      --1434 : Mi Lote
           begin
                          if @i_canal = 'VEN'
                          begin
                             select @w_rubro = 'CMIL'
                             select @w_tipocta = null
                             select @w_cuenta  = null
                          end
           end
           else
           if @i_municipio = 1435  or (@i_municipio = 7749 and @i_tipo_impto = "003" ) --Ref034:msilvag  --1435 Mercados y Credenciales nchavezb 
               begin
                  if @i_canal = 'VEN'
                  begin
                     select @w_rubro = 'CPMC'
                     select @w_tipocta = null
                     select @w_cuenta  = null
                  end
           end
           else
           begin
                          -->hy-05-noviembre-2007
                          --Inclusi�n del municipio de ibarra
                          if @i_canal = 'VEN'
                          begin
                             select @w_rubro = 'PIMI'
                             select @w_tipocta = null
                             select @w_cuenta  = null
                          end
              else
              begin
                             select @w_rubro   = 'CIMP'
                             select @w_tipocta = @i_producto
                             select @w_cuenta  = @i_cuenta
                          end
                          --<hy-05-noviembre-2007
                       end
           --<lfcm 20-junio-2009 Mi Lote
     end
        end
         end

        
    -- ref: 22 - Comision de Municipios Samborondon - Salinas - Sta. Elena


 if @i_canal = 'VEN'
    begin
        if @i_municipio = 2319
        begin
            select @w_rubro = 'PMSM'
            select @w_tipocta = null
            select @w_cuenta  = null
        end
        if @i_municipio = 2237
        begin
            select @w_rubro = 'PMSL'
            select @w_tipocta = null
            select @w_cuenta  = null
        end
        if @i_municipio = 2235
        begin
            select @w_rubro = 'PMSE'
            select @w_tipocta = null
            select @w_cuenta  = null
        end

    end

 if @i_canal in ('VEN','ATM','IBK','KSK','IVR','WAP')---DAPV 23/08/2011 --Para todos los canales
    begin
      if @i_municipio = 1430 --nchavezb 04/08/2011 Municipio Daule
            begin
                select @w_rubro = 'PCMD'
                select @w_tipocta = null
                select @w_cuenta  = null
            end
    end

	
	--Ref034:msilvag Inicio
	if @i_municipio = 7749 and @i_tipo_impto = "004"    --CEP
	begin
		select @w_rubro = 'MCEP'
		select @w_tipocta = null
		select @w_cuenta  = null
	end
	--Ref034:msilvag Fin

	
   exec cob_pagos..sp_verif_genera_costo
        @s_date         = @s_date,
        @i_mon          = @i_mon,
        @i_rubro        = @w_rubro,
        @i_servicio     = 'IMPM',
        @i_canal        = @i_canal,
        @i_tipocta      = @w_tipocta,
        @i_cuenta       = @w_cuenta,
        @o_costo        = @o_comision out


if  @o_comision > 0
  begin
  -- smerino busqueda de la tasa del iva parametrizada en el person
    exec @w_return = cob_pagos..sp_verif_genera_costo
         @s_date         = @s_date,
         @i_mon          = @i_mon,
         @i_rubro        = 'IVA',
         @i_servicio     = 'IMPM',  ---se coloco para poder probar senae
         @i_canal        = @i_canal,
         @i_tipocta      = @w_tipocta,
         @o_costo        = @o_tasa out

       if @w_return <> 0
      return @w_return



  --smerino llamar al sp que retorna el valor del iva ----
    exec  @w_return = cob_cuentas..sp_cal_impuesto
          @i_tasa   = @o_tasa,
        @i_valor_serv = @o_comision,
        @o_base_imp = @o_base_imp out,
    @o_impuesto = @o_impuesto out

      if @w_return <> 0
      return @w_return



   end --fin de smerino

   if @i_opcion = 'V'
      return 0

end


--<hy-15-feb-2006

if @i_opcion = 'C' and (@i_municipio = 2319 or @i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236 or  @i_municipio = 1430 )  /* Wise  15/Agt/2008 se agrago M. de Libertad =2236 */
begin
  select @o_nom_cli = pm_nombre
  from cob_pagos..pg_municipios (index i_pg_municipios_04)   --Ref 36
  where pm_municipio          = @i_municipio
  and pm_catastro = @i_catastro2



  if @i_municipio = 1430
  begin
    select @o_nom_cli = pm_nombre
        from cob_pagos..pg_municipios
        where pm_municipio          = @i_municipio
        and pm_no_predio = @i_no_predio
        and pm_referencia= @i_referencia
        and pm_cod_pago = 'N'

  end --1430

  if @i_municipio = 2319  --GAMC 18/03/2008
  begin --if @i_municipio = 2319 - INI
    select
      "A�o" =         pm_ano_tributacion,
      "Prioridad de pago" = pm_prioridad_orden,
      "Sem/Div." =      pm_semestre_cobro,
      "Cod. tipo Imp." =    pm_cod_impuesto,
      "Tipo de Imp." =    (select b.valor
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla  = 'sv_impto_munsam'
                        and a.codigo = b.tabla
                        and b.codigo = c.pm_cod_impuesto
                        and b.estado = 'V'),
      "Total" =       pm_valor_total

    from
      cob_pagos..pg_municipios c (index i_pg_municipios_04)  --Ref 36
    where
      c.pm_municipio  = @i_municipio
    and c.pm_catastro = @i_catastro2
    and c.pm_cod_pago = 'N'
    --and ((pm_cod_impuesto       = @i_cod_impto) or (@i_cod_impto = '0'))
    order by pm_ano_tributacion, pm_prioridad_orden, pm_semestre_cobro
    --order by pm_ano_tributacion, pm_semestre_cobro, pm_prioridad_orden


    if @@rowcount <= 0
             begin --if @@rowcount <= 0
       if exists (select 1 from cob_pagos..pg_municipios c  (index i_pg_municipios_04)   --Ref 36
       where c.pm_municipio = @i_municipio 
                            and c.pm_catastro = @i_catastro2
                            and c.pm_cod_pago = 'P')
       begin

        if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
        begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 031064,
            @i_msg   = 'CONTRIBUYENTE NO REGISTRA PAGOS PENDIENTES'  --11-hy-enero-2006cambio de mensaje
         return 1
        end
        else
         return 31064
       end
       else --NO REGISTRA PAGOS Y NO ESTA EN LA BASE
       begin
        if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
        begin
			/*REF35 INI*/
			if @i_municipio = 2319
			begin
				/* REF37 INI Obtener parametro Fecha */
				select @w_val_date = pa_datetime 
				from cobis..cl_parametro 
				where pa_nemonico = 'FCAMS'
 				and pa_producto = 'CTE'
				
				if @s_date <= @w_val_date
				 begin
				 -- Obtener Mensaje
				 select @w_mensaje = valor + (select ' '+ valor 
				 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
				 where b.tabla = 'sv_errores_munfda'
				   and b.codigo = a.tabla
				   and a.codigo = '02')
				 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
				 where b.tabla = 'sv_errores_munfda'
				   and b.codigo = a.tabla
				   and a.codigo = '01'
				 end
				else
				 begin
				  select @w_mensaje = valor 
				    from cobis..cl_catalogo a , cobis..cl_tabla b 
				   where b.tabla = 'sv_errores_munfda'
				     and b.codigo = a.tabla
				     and a.codigo = '03'
				 end
				
				/* REF37 FIN Obtener parametro Fecha */
				
			   -- select @w_mensaje = 'EL CODIGO CONSULTADO NO EXISTE'
			end 
			else
				select @w_mensaje = 'CLIENTE NO EXISTE FAVOR ACERQUESE AL MUNICIPIO A CANCELAR'
			/*REF35 FIN*/
		 exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 031064,
            @i_msg   = @w_mensaje  --11-hy-enero-2006cambio de mensaje --REF 35
         return 1
        end
        else
         return 31064
       end
    end --if @@rowcount <= 0
  end --if @i_municipio = 2319 - FIN

  --GAMC 18/03/2008 - Municipio de Salinas - INI

  if @i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236   /* Wise M. Libertad 15/Agt/2008 */
  begin --if @i_municipio = 2237 - INI
    select
      "A�o" =         pm_ano_tributacion,
      "Prioridad de pago" = pm_prioridad_orden,
      "Cod. tipo Imp." =    pm_cod_impuesto,
      "Tipo de Imp." =    (case @i_municipio            --GAMC 10/04/2008 - Municipio de Santa Elena
                      when 2235 then isnull ((select b.valor
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla  = 'sv_impto_munselena'
                        and a.codigo = b.tabla
                        and b.codigo = c.pm_cod_impuesto
                        and b.estado = 'V'),'OTROS')
                      when 2237 then isnull ((select b.valor
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla  = 'sv_impto_munsal'
                        and a.codigo = b.tabla
                        and b.codigo = c.pm_cod_impuesto
                        and b.estado = 'V'),'OTROS')
                      /*Wise M. Libertad = 2236 15/Agt/2208 */
                      when 2236 then isnull ((select b.valor
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla  = 'sv_impto_munlib'
                        and a.codigo = b.tabla
                        and b.codigo = c.pm_cod_impuesto
                        and b.estado = 'V'),'OTROS')
                        end),
      "Sem/Div." =      pm_semestre_cobro,
      "Total" =       pm_valor_total

    from
      cob_pagos..pg_municipios c (index i_pg_municipios_04)  --Ref 36
    where
      c.pm_municipio  = @i_municipio
    and c.pm_catastro = @i_catastro2
    and c.pm_cod_pago = 'N'
    --and ((pm_cod_impuesto       = @i_cod_impto) or (@i_cod_impto = '0'))
    order by pm_ano_tributacion, pm_prioridad_orden, pm_semestre_cobro


     if @@rowcount <= 0
     begin --if @@rowcount <= 0
       if exists (select 1 from cob_pagos..pg_municipios c (index i_pg_municipios_04)   --Ref 36
       		  where c.pm_municipio = @i_municipio 
                            and c.pm_catastro = @i_catastro2
                            and c.pm_cod_pago = 'P')
       begin

        if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
        begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 031064,
            @i_msg   = 'CONTRIBUYENTE NO REGISTRA PAGOS PENDIENTES'  --11-hy-enero-2006cambio de mensaje
         return 1
        end
        else
         return 31064
       end
       else --NO REGISTRA PAGOS Y NO ESTA EN LA BASE
       begin
        if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
        begin
			/*
			if @i_municipio = 2319 
				select @w_mensaje = 'EL CODIGO CONSULTADO NO EXISTE'
			else
				select @w_mensaje = 'CLIENTE NO EXISTE FAVOR ACERQUESE AL MUNICIPIO A CANCELAR'
			*/
			
			
			/* REF37 INI Obtener parametro Fecha */
			select @w_val_date = pa_datetime 
			from cobis..cl_parametro 
			where pa_nemonico = 'FCAMSA'
			and pa_producto = 'CTE'

			if @s_date <= @w_val_date
			 begin
			 -- Obtener Mensaje
			 select @w_mensaje = valor + (select ' '+ valor 
			 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
			 where b.tabla = 'sv_errores_munfda'
			   and b.codigo = a.tabla
			   and a.codigo = '02')
			 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
			 where b.tabla = 'sv_errores_munfda'
			   and b.codigo = a.tabla
			   and a.codigo = '01'
			 end
			else
			 begin
			  select @w_mensaje = valor 
			    from cobis..cl_catalogo a , cobis..cl_tabla b 
			   where b.tabla = 'sv_errores_munfda'
			     and b.codigo = a.tabla
			     and a.codigo = '03'
			 end
							
			/* REF37 FIN Obtener parametro Fecha */
			
			
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 031064,
            @i_msg   = @w_mensaje  --11-hy-enero-2006cambio de mensaje --REF35
         return 1
        end
        else
         return 31064
       end
    end --if @@rowcount <= 0

  end --if @i_municipio = 2237 - FIN
  --GAMC 18/03/2008 - Municipio de Salinas - FIN


  --nchavezb 04/08/2011 Municipio Daule 1430
  if   @i_opcion = 'C' and @i_municipio = 1430  /* MUNICIPIO DAULE */
    begin


      select
            "A�o" =         pm_ano_tributacion,
             "Prioridad de pago" = pm_prioridad_orden,
             "Cod. tipo Imp." =    pm_cod_impuesto,
             "Tipo de Imp." =  (select b.valor
                              from cobis..cl_tabla a, cobis..cl_catalogo b
                              where a.tabla  = 'sv_impto_mundau'
                                and a.codigo = b.tabla
                                and b.codigo = c.pm_cod_impuesto
                                and b.estado = 'V'),
             "Total" =       pm_valor_total 
             from
             cob_pagos..pg_municipios c
             where c.pm_municipio  = @i_municipio
             and c.pm_no_predio = @i_no_predio
             and c.pm_referencia= @i_referencia
             and c.pm_cod_pago = 'N'
      order by pm_ano_tributacion, pm_prioridad_orden, pm_semestre_cobro

       if @@rowcount  <= 0  
       begin
         if exists (select 1 from cob_pagos..pg_municipios c where c.pm_municipio = @i_municipio
                              and c.pm_no_predio = @i_no_predio
                      and c.pm_referencia= @i_referencia
                              and c.pm_cod_pago = 'P')
         begin

          if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
          begin
           exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031064,
              @i_msg   = 'CONTRIBUYENTE NO REGISTRA PAGOS PENDIENTES'  --11-hy-enero-2006cambio de mensaje
           return 1
          end
          else
           return 31064
         end
         else --NO REGISTRA PAGOS Y NO ESTA EN LA BASE
         begin
          if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
          begin
		  /*
		  if @i_municipio = 2319 
				select @w_mensaje = 'EL CODIGO CONSULTADO NO EXISTE'
			else
				select @w_mensaje = 'CLIENTE NO EXISTE FAVOR ACERQUESE AL MUNICIPIO A CANCELAR'
		  */
		  
		  /* REF37 INI Obtener parametro Fecha */
			select @w_val_date = pa_datetime 
			from cobis..cl_parametro 
			where pa_nemonico = 'FCAMD'
			and pa_producto = 'CTE'

			if @s_date <= @w_val_date
			 begin
			 -- Obtener Mensaje
			 select @w_mensaje = valor + (select ' '+ valor 
			 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
			 where b.tabla = 'sv_errores_munfda'
			   and b.codigo = a.tabla
			   and a.codigo = '02')
			 from cobis..cl_catalogo as a , cobis..cl_tabla as b 
			 where b.tabla = 'sv_errores_munfda'
			   and b.codigo = a.tabla
			   and a.codigo = '01'
			 end
			else
			 begin
			  select @w_mensaje = valor 
			    from cobis..cl_catalogo a , cobis..cl_tabla b 
			   where b.tabla = 'sv_errores_munfda'
			     and b.codigo = a.tabla
			     and a.codigo = '03'
			 end
		  							
			/* REF37 FIN Obtener parametro Fecha */
		  
           exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031064,
              @i_msg   = @w_mensaje  --11-hy-enero-2006cambio de mensaje --REF35
           return 1
          end
          else
           return 31064
         end
      end --if @@rowcount <= 0

    end
  --- Municipio de DAULE - FIN
   return 0
end --if @i_opcion = 'C' and @i_municipio = 2319

if @i_opcion = 'C' and @i_municipio = 1417  --hy-15-feb-2006 agregar @i_municipio = 1417
begin

   select 'A�o'            = c.pm_ano_tributacion,
          'Sem/Div'        = c.pm_semestre_cobro,    --hy-10-enero-2006
          'Prioridad'      = c.pm_prioridad_orden,
          'Contribuyente'  = c.pm_nombre,
          'Identificaci�n' = c.pm_doc_identificacion,
          'Predio/rubro'   = c.pm_cod_impuesto,
          'Impto'          = isnull ((select b.valor
                              from cobis..cl_tabla a, cobis..cl_catalogo b
                              where a.tabla  = 'sv_impto_mun'
                                and a.codigo = b.tabla
                                and b.codigo = c.pm_cod_impuesto
                                and b.estado = 'V'),'OTROS'),  --hy-12-enero-2006
          'No.Pred/Pat'    = c.pm_no_predio,
          'Total'          = c.pm_valor_total,
          'Valor'          = c.pm_valor_impuestos,
          'Otros'          = c.pm_valor_otros,
          'Direcci�n'      = c.pm_direccion
          /*'Estado'         = case c.pm_cod_pago
                                when 'N' then 'No pagado'
                                when 'P' then 'Pagado'
                             end hy-11-enero-2006*/
   from cob_pagos..pg_municipios c
   where c.pm_municipio          = @i_municipio
     and c.pm_doc_identificacion = @i_identifica
     and c.pm_cod_pago           = 'N'  --hy-11-enero-2006
     and ((pm_cod_impuesto       = @i_cod_impto) or (@i_cod_impto = '0'))
   order by pm_ano_tributacion, pm_semestre_cobro, pm_prioridad_orden

   if @@rowcount <= 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031064,
              @i_msg   = 'CONTRIBUYENTE NO REGISTRA PAGOS PENDIENTES'  --11-hy-enero-2006cambio de mensaje
         return 1
      end
      else
         return 31064
   end

   return 0
end

-->hy-05-noviembre-2007
if @i_opcion = 'C' and @i_municipio = 2234
begin

   if @i_canal='VEN' and @i_cod_impto <> '0'
   begin
      --Obtener la fecha de vencimiento menor del tipo de impto seleccionado
      select @w_fecven = min(pm_fec_ven)
      from cob_pagos..pg_municipios
      where pm_municipio          = @i_municipio
        and pm_doc_identificacion = @i_identifica
        and pm_cod_impuesto       = @i_cod_impto
        and pm_cod_pago           = 'N'

      if @w_fecven <> null
      begin
         select @w_contador = count(1)
         from cob_pagos..pg_municipios
         where pm_municipio          = @i_municipio
           and pm_doc_identificacion = @i_identifica
           and pm_cod_impuesto      <> @i_cod_impto
           and pm_fec_ven            < @w_fecven
           and pm_cod_pago           = 'N'

         if @w_contador > 0
         begin
            if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
            begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 031063,
                    @i_msg   = 'CLIENTE REGISTRA DEUDAS ANTERIORES, FAVOR CONSULTE TODOS LOS IMPUESTOS'
               return 1
            end
            else
            begin
               rollback
               return 31063
            end
         end
      end
   end

   select @o_nom_cli = pm_nombre
   from cob_pagos..pg_municipios
   where pm_municipio          = @i_municipio
     and pm_doc_identificacion = @i_identifica

   if @@rowcount <= 0
   begin
      if @i_aplcobis = 'S'
      begin
		/*REF35 INI*/
		if @i_municipio = 2319 
			select @w_mensaje = 'EL CODIGO CONSULTADO NO EXISTE'
		else
			select @w_mensaje = 'CLIENTE NO EXISTE FAVOR ACERQUESE AL MUNICIPIO A CANCELAR'
	   /*REF35 FIN*/
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031064,
              @i_msg   = @w_mensaje
         return 1
      end
      else
         return 31064
   end

   select 'A�o'            = c.pm_ano_tributacion,
          'Sem/Div'        = c.pm_semestre_cobro,
          'Impto'          = c.pm_cod_impuesto,
          'Descripci�n'    = isnull ((select b.valor
                              from cobis..cl_tabla a, cobis..cl_catalogo b
                              where a.tabla  = 'sv_impto_mibarra'
                                and a.codigo = b.tabla
                                and b.codigo = c.pm_cod_impuesto
                                and b.estado = 'V'),'OTROS'),
          'No.Pred/Pat'    = c.pm_catastro,
          'Direcci�n'      = c.pm_direccion,
          'Total'          = c.pm_valor_total,
          'Valor'          = c.pm_valor_impuestos,
          'Otros'          = c.pm_valor_otros,
          'Prioridad'      = c.pm_referencia,
          'FecVen'         = convert(varchar(10),c.pm_fec_ven,101)
   from cob_pagos..pg_municipios c
   where c.pm_municipio          = @i_municipio
     and c.pm_doc_identificacion = @i_identifica
     and c.pm_cod_pago           = 'N'
     and ((pm_cod_impuesto       = @i_cod_impto) or (@i_cod_impto = '0'))
   order by pm_fec_ven, pm_ano_tributacion, pm_semestre_cobro, pm_cod_impuesto

   if @@rowcount <= 0
   begin
      if @i_aplcobis = 'S'
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031064,
              @i_msg   = 'CLIENTE NO REGISTRA DEUDAS PENDIENTES'
         return 1
      end
      else
         return 31064
   end

   return 0

end
--<hy-05-noviembre-2007

-->hy-15-feb-2006
--Consulta para municipio de guayaquil
--Registrar el log de la consulta
--Cobrar comisi�n (para los canales distintos a ventanilla)
if @i_opcion = 'C' and @i_municipio = 1433
begin
   if @i_canal in ('ATM','IBK','KSK','IVR')
   begin
      exec cob_pagos..sp_verif_genera_costo
           @s_date         = @s_date,
           @i_mon          = @i_mon,
           @i_rubro        = 'CIMP',
           @i_servicio     = 'IMPM',
           @i_canal        = @i_canal,
           @i_tipocta      = @i_producto,
           @i_cuenta       = @i_cuenta,
           @o_costo        = @i_deb_com out
   end

   if @i_efe_com <> 0 or @i_chq_com <> 0 or @i_deb_com <> 0
   begin
      if @t_trn = 3215
         select  @w_trn = 3366 , @w_servicio ="4"
      else
         select  @w_trn = 3372 , @w_servicio ="4"
         
         
     /*REF32: Inicio LBP */ 
     if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
               where rs_empresa = @i_municipio
               and rs_canal = @i_canal and rs_estado = 'V')  
     begin
     
          select @w_comi_total = isnull(@i_efe_com,0) + isnull(@i_chq_com,0) + isnull(@i_deb_com,0) -- Comision que debe venir del 12%
     
          exec @w_return = cob_pagos..pa_pg_ivalor_comcal
               @e_valor_comision  = @w_comi_total,
               @e_oficina         = @s_ofi,
               @e_empresa         = @i_municipio,
               @e_canal           = @i_canal,
               @s_valor_com_final = @w_com_original out, -- obtengo comision original al 14%
               @s_aplica          = @w_aplica_des out
          if @w_return <> 0
             return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 

             
          if @w_aplica_des = 'S'
          begin
              exec @w_return = cob_gov..pa_iva_pcompensacion
                   @e_oficina        = @s_ofi,
                   @e_monto          = @w_com_original,
                   @s_monto_compensa = @w_valor_compensa out   
          if @w_return <> 0
             return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
          end
     
     end
     /*REF32: Fin LBP */ 

      exec @w_return = cob_remesas..sp_cobro_comision_rc
           @s_ssn      = @s_ssn,
           @s_lsrv     = @s_lsrv,
           @s_srv      = @s_srv,
           @s_user     = @s_user,
           @s_sesn     = @s_sesn,
           @s_term     = @s_term,
           @s_date     = @s_date,
           @s_ofi      = @s_ofi,
           @s_rol      = @s_rol,
           @s_org      = @s_org,
           @s_org_err  = @s_org_err, /* Origen de error: [A], [S] */
           @s_error    = @s_error,
           @s_sev      = @s_sev,
           @t_corr     = @t_corr,
           @t_ssn_corr = @t_ssn_corr, /* Trans a ser reversada */
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @t_from,
           @t_rty      = @t_rty,
           @t_trn      = @w_trn,
           @i_ubi      = @i_ubi,
           @i_mon      = @i_mon,
           @i_opcion   = "T",
           @i_servicio = @w_servicio,
           @i_codigo   = @i_identifica,
           @i_efectivo = @i_efe_com,
           @i_cheque   = @i_chq_com,
           @i_tipocta  = @i_producto,  ---@i_tipocta_com smerino REF33
           @i_cuenta   = @i_cuenta,   ---@i_cta_com smerino REF33
           @i_debito   = @i_deb_com,  -- DEBITO A CTAS
           @i_causal   = '366',  --hy-15-feb-2006 agregar el causal
           @i_aplcobis = @i_aplcobis  --hy-15-feb-2006

      if @w_return != 0
      begin
         if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
         begin
            exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 035000
            return 1
         end
         else
            return 35000
      end


end

   select @w_com = isnull(@i_efe_com + @i_chq_com + @i_deb_com,0)  --smerino01022012

   --smerino iva
   --smerino busca calculo dle iva
          -- smerino busqueda de la tasa del iva parametrizada en el person

   if   @w_com > 0    --smerino10022012
   begin

    exec @w_return = cob_pagos..sp_verif_genera_costo
        @s_date         = @s_date,
        @i_mon          = @i_mon,
        @i_rubro        = 'IVA',
        @i_servicio     = 'IMPM',  --'ICAE',
        @i_canal        = @i_canal,
        @i_tipocta      = @w_tipocta,
        @o_costo        = @w_tasa out

       if @w_return <> 0
      begin

         if @@trancount >0
    rollback

    return @w_return

             end




        if @w_tasa > 0
        begin
        
             /*REF32: Inicio LBP */ 
            if @w_aplica_des = 'S' and @i_canal = 'VEN'
            begin
                 -- smerino llamar al sp que retorna el valor del iva ----
                 exec  @w_return  = cob_cuentas..sp_cal_impuesto
                 @i_tasa          = @w_tasa,
                 @i_valor_serv    = @w_com_original, -- Comision Original al 14
                 @o_base_imp      = @w_base_imp out,
                 @o_impuesto      = @w_impuesto2 out

                 if @w_return <> 0
                 begin
                    if @@trancount >0
                       rollback
                    return @w_return
                 end
            end
            else
            begin 
            /*REF32: Fin LBP */
            
                 -- smerino llamar al sp que retorna el valor del iva ----
                 --PRINT 'Variable 12 = %12!', @w_com
                 exec  @w_return  = cob_cuentas..sp_cal_impuesto
                 @i_tasa          = @w_tasa,
                 @i_valor_serv    = @w_com,
                 @o_base_imp      = @w_base_imp out,
                 @o_impuesto      = @w_impuesto2 out

                 if @w_return <> 0
                 begin
                    if @@trancount >0
                       rollback
                    return @w_return
                 end
            
            end -- Fin if @w_aplica_des = 'S' and @i_canal = 'VEN' LBP
                 
        end
        else
            select @w_base_imp=@w_com,@w_impuesto2=0
        end


        if @w_base_imp > 0
        begin
        
        /*REF32: Inicio LBP */ 
        if @w_aplica_des = 'S' and @i_canal = 'VEN'
        begin
            --insert la trx del iva 3497 para cobro de la comision ---
            exec @w_return = cob_cuentas..sp_cont_impuesto
                 @t_trn         = 3497 ,
                 @s_ssn         = @s_ssn,
                 @s_date        = @s_date,
                 @t_corr        = @t_corr,
                 @t_ssn_corr    = @t_ssn_corr,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_ofi         = @s_ofi,
                 @t_rty         = @t_rty,
                 @s_org         = @s_org,
                 @i_base_imp    = @w_base_imp,
                 @i_iva         = @w_impuesto2,
                 @i_total       = @w_com_original, -- Comision Original al 14 
                 @i_cau         = @w_servicio,   --servivio que debe de enviarse
                 @i_cta         = @i_identifica, --referencia
                 @i_mon         = 1,   --Moneda
                 @i_oficina_cta = @s_ofi,
                 @i_ubi         = @i_ubi
       
            if @w_return <> 0
            begin
                if @@trancount > 0
                   rollback
                return @w_return
            end
       
        end
        else
        begin
        /*REF32: Fin LBP */ 
            --insert la trx del iva 3497 para cobro de la comision ---
            exec @w_return = cob_cuentas..sp_cont_impuesto
                 @t_trn         = 3497 ,
                 @s_ssn         = @s_ssn,
                 @s_date        = @s_date,
                 @t_corr        = @t_corr,
                 @t_ssn_corr    = @t_ssn_corr,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_ofi         = @s_ofi,
                 @t_rty         = @t_rty,
                 @s_org         = @s_org,
                 @i_base_imp    = @w_base_imp,
                 @i_iva         = @w_impuesto2,
                 @i_total       = @w_com,
                 @i_cau         = @w_servicio,   --servivio que debe de enviarse
                 @i_cta         = @i_identifica, --referencia
                 @i_mon         = 1,   --Moneda
                 @i_oficina_cta = @s_ofi,
                 @i_ubi         = @i_ubi
     
            if @w_return <> 0
            begin
                if @@trancount > 0
                   rollback
                return @w_return
            end
        end   ----smerino10022012  print 'fin inserto trx 3497'
        end


   if (@i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) )  and @i_canal <> 'ATM' --Ref034:msilvag --REF 25  --<GAMC - 21ENE10
     set @i_agno = convert(smallint, @i_panio_vigencia)

   insert into cob_cuentas..cc_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_rol,
    ts_terminal, ts_correccion, ts_propietario, ts_tipo_chequera, ts_reentry,
    ts_origen, ts_nodo, ts_tsfecha, ts_clase, ts_sec_correccion,
    ts_moneda, ts_cta_banco, ts_valor, ts_saldo, ts_monto,
    ts_cheque_rec, ts_tsn, ts_hora, ts_tipocta, ts_ubicacion,
    ts_campo_alt_uno, ts_autoriz_anula, ts_referencia, ts_stick_imp, ts_autorizante,
    ts_causa, ts_nombre, ts_cta_asociada,
    ts_ssn_corr, ts_autoriz_aut,
    ---- REF21 ts_descripcion_ec,ts_estado_sob)  --hy-14-agosto-2006
    ts_descripcion_ec,ts_corresponsal)
   values
   (@s_ssn, 3605, @s_ofi, @s_user, @s_rol,
    @s_term, @t_corr, @i_cod_impto, @i_canal, @t_rty,
    'L', @s_lsrv, @s_date, 'NOR', @t_ssn_corr,
    @i_mon, @i_cuenta, @i_efe, @i_cheque, @i_debito,
    @i_cant_chq, @i_tsn, getdate(), substring(@i_producto,1,1), @i_ubi,
    @i_identifica, @i_supautor, convert(varchar(10),@i_no_predio), convert(varchar(4),@i_agno), @i_semestre,
    convert(varchar(4),@i_municipio), @i_nombre, convert(varchar,@i_tarjeta),
    @t_ssn_corr, @w_com,
    @i_titulo,@i_tipo_impto)

   return 0
end
--<hy-15-feb-2006

if @i_opcion = 'T' -- DGA 23/Ene/2006
begin

  if @i_mon = 0
  begin
     if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
     begin
       exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 031063,
      @i_msg   = 'ESTA TRANSACCION SOLO PUEDE SER REALIZADA EN DOLARES'
       return 1
     end
     else
       return 31063
  end

   if @w_valor_tot <= 0 --REF29
   begin
       exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_msg           = 'VALOR A PAGAR, NO PUEDE SER CERO',
         @i_num           = 111111
         return 1
   end

   -->lfcm 26-junio-2009 MiLote
   /*if @i_municipio in (1434,1435) Ref031:msilvag 
   begin*/
      --Validar que esto solo sea para 1434
      --Diferido Oficina, Oficina Mi Lote
      --> OBTIENE HORA TOPE >
      select @w_fecha_hoy = convert(varchar(10), getdate(),101)
      select @w_fecha_comp = convert(varchar(10),fp_fecha,101) + ' ' + convert(varchar(10),getdate(),108) from cobis..ba_fecha_proceso
      select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
      from cobis..cl_tabla a, cobis..cl_catalogo b
      where a.tabla = 'sv_horario_serv'
      and a.codigo = b.tabla
      and b.codigo = @i_empresa
      and estado = 'V'
      if @@rowcount = 0 or @w_hora_tope = 0
      begin
         if @i_aplcobis = 'S'
         begin
            exec cobis..sp_cerror
            @t_debug         = @t_debug,
            @t_file          = @t_file,
            @t_from          = @w_sp_name,
            @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
            @i_num           = 111111
            return 1
         end
         else
            return 37601
      end

      --Establecer el tipo de transaccion dependiendo
      if @i_canal = 'VEN'
      begin
         --Identifico si estoy en el horario normal o diferido
         select @w_hora_trn = convert(varchar,getdate(),108)
         select @w_hora_dif = rh_inicio,
                @w_fecha_desde_excep =rh_fecha_desde,  --REF 30
                @w_fecha_hasta_excep = rh_fecha_hasta, --REF 30
                @w_hora_dif_excep = rh_nuevo_inicio   --REF 30
          from cob_remesas..re_horario where rh_oficina = @s_ofi and rh_ubicacion = @i_ubi

         ---Si la fecha de proceso esta dentro delperiodo de excepcion reemplazo la hora del diferido por la hora de excepcion
         if  @s_date >= @w_fecha_desde_excep  and @s_date <= @w_fecha_hasta_excep --REF 30
            select @w_hora_dif = @w_hora_dif_excep

         if  @w_hora_trn >= @w_hora_dif ---and @i_cheque > 0
            select @t_trn = 4112 ---- REF 24 ---3216      --Horario Diferido    3213 = TrxLuzAjusteDiferido
         else
            select @t_trn = 3215      --Horario Normal
      end


      select @w_hora_sys = convert(varchar(08),getdate(),108)
      select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
      select @w_offline = atm_offline from cobis..ba_fecha_proceso
      if @w_hora >= @w_hora_tope and @w_offline = 'N' and @s_date = @w_fecha_hoy --and @t_corr = 'N'
      begin
         select @t_trn = 3216      --REF 24 Horario Diferido empresa
         select @w_fecha_comp = convert(varchar(10), min(dl_fecha),101)
         from cob_cuentas..cc_dias_laborables
         where dl_ciudad = 1
         and dl_num_dias = 1
      end

      select @o_comision = 0
      select @o_fecha_comp = substring(@w_fecha_comp,7,4) + substring(@w_fecha_comp,1,2) + substring(@w_fecha_comp,4,2)

   --end Ref031:msilvag 
   --<lfcm 26-junio-2009 MiLote


-->hy-05-noviembre-2007
if @i_municipio = 2234
begin
   if @i_canal='IBK' and @i_cod_impto <> '0'
   begin
      --Obtener la fecha de vencimiento menor del tipo de impto seleccionado
      select @w_fecven = min(pm_fec_ven)
      from cob_pagos..pg_municipios
      where pm_municipio          = @i_municipio
        and pm_doc_identificacion = @i_identifica
        and pm_cod_impuesto       = @i_cod_impto
        and pm_cod_pago           = 'N'

      if @w_fecven <> null
      begin
         select @w_contador = count(1)
         from cob_pagos..pg_municipios
         where pm_municipio          = @i_municipio
           and pm_doc_identificacion = @i_identifica
           and pm_cod_impuesto      <> @i_cod_impto
           and pm_fec_ven            < @w_fecven
           and pm_cod_pago           = 'N'

         if @w_contador > 0
         begin
            if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
            begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 031063,
                    @i_msg   = 'CLIENTE REGISTRA DEUDAS ANTERIORES, FAVOR CONSULTE TODOS LOS IMPUESTOS'
               return 1
            end
            else
            begin
               rollback
               return 31063
            end
         end
      end
   end
end
--<hy-05-noviembre-2007


--GAMC - 23/02/2008 - INI
if @i_municipio = 2319 or @i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236 /* Wise - 15/Agt/2008 M. Libertad = 2236 */
begin

   if @i_canal='IBK' and @i_cod_impto <> '0'
   begin
      --Obtener la fecha de vencimiento menor del tipo de impto seleccionado
      select @w_fecven = min(pm_fec_ven)
      from cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
      where pm_municipio          = @i_municipio
        and pm_catastro       = @i_catastro2
        and pm_cod_impuesto       = @i_cod_impto
        and pm_cod_pago           = 'N'

      if @w_fecven <> null
      begin
         select @w_contador = count(1)
         from cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
         where pm_municipio          = @i_municipio
           and pm_catastro       = @i_catastro2
           and pm_cod_impuesto      <> @i_cod_impto
           and pm_fec_ven            < @w_fecven
           and pm_cod_pago           = 'N'

         if @w_contador > 0
         begin
            if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
            begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 031063,
                    @i_msg   = 'CLIENTE REGISTRA DEUDAS ANTERIORES, FAVOR CONSULTE TODOS LOS IMPUESTOS'
               return 1
            end
            else
            begin
               rollback
               return 31063
            end
         end
      end
   end
end
--GAMC - 23/02/2008 - FIN

--DAPV - 23/08/2011 - INI
if @i_municipio = 1430
begin

   if @i_canal='IBK' and @i_cod_impto <> '0'
   begin
      --Obtener la fecha de vencimiento menor del tipo de impto seleccionado
      select @w_fecven = min(pm_fec_ven)
      from cob_pagos..pg_municipios
      where pm_municipio  = @i_municipio
             and pm_no_predio = @i_no_predio
             and pm_referencia= @i_referencia
             and pm_cod_impuesto      <> @i_cod_impto
             and pm_cod_pago = 'N'

      if @w_fecven <> null
      begin
         select @w_contador = count(1)
         from cob_pagos..pg_municipios
        where pm_municipio  = @i_municipio
             and pm_no_predio = @i_no_predio
             and pm_referencia= @i_referencia
             and pm_cod_impuesto      <> @i_cod_impto
             and pm_fec_ven            < @w_fecven
             and pm_cod_pago = 'N'


         if @w_contador > 0
         begin
            if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
            begin
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 031063,
                    @i_msg   = 'CLIENTE REGISTRA DEUDAS ANTERIORES, FAVOR CONSULTE TODOS LOS IMPUESTOS'
               return 1
            end
            else
            begin
               rollback
               return 31063
            end
         end
      end
   end
end
--DAPV - 23/08/2011 - FIN

--lfcm 20/octubre/2006 Permitir pago con Tarjeta de Credito
/*
-->hy-10-enero-2006
if @i_tarjeta > 0
begin
   if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 031063,
           @i_msg   = 'POR EL MOMENTO NO ESTA HABILITADO EL SERVICIO DE TARJETA DE CREDITO'
      return 1
   end
   else
       return 31063
end
--<hy-10-enero-2006
*/

if @i_autoriza = 'N'and @t_corr = 'N'
   select @i_supautor = ""

-- Valida montos de ingreso

if @i_autoriza = 'N' and @t_corr = 'N'
begin
   select @w_maximo_p = pa_money
   from cobis..cl_parametro
   where pa_nemonico = 'MSVP'
     and  pa_producto = 'CTE'

   if (@w_maximo_p <= (@i_efe))
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 311819
         return 311819
      end
      else
         return 311819
   end
end

/* Valida si se ha aperturado caja */
if @i_canal = 'VEN'
begin
   exec @w_return = cob_remesas..sp_verifica_caja_rc
        @s_ssn    = @s_ssn,
        @s_srv    = @s_srv,
        @s_lsrv   = @s_lsrv,
        @s_user   = @s_user,
        @s_sesn   = @s_sesn,
        @s_term   = @s_term,
        @s_date   = @s_date,
        @s_ofi    = @s_ofi,
        @s_rol    = @s_rol,
        @s_sev    = @s_sev,
        @s_org    = @s_org,
        @t_trn    = @t_trn,
        @t_corr   = @t_corr,
        @i_mon    = @i_mon,
        @i_ubi    = @i_ubi,
        @o_horario = @o_horario out  --hy-15-feb-2006

   if @w_return != 0
   begin
      return @w_return
   end
end


   -->hy-12-enero-2006
   --Establecer el horario de la empresa
   select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
   from cobis..cl_tabla a, cobis..cl_catalogo b
   where a.tabla = 'sv_horario_serv'
     and a.codigo = b.tabla
     and b.codigo = convert(varchar(10),@i_municipio)
     and estado = 'V'
   if @@rowcount = 0 or @w_hora_tope = 0
   begin
       if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
       begin
        
          exec cobis..sp_cerror
               @t_debug         = @t_debug,
               @t_file          = @t_file,
               @t_from          = @w_sp_name,
               @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
               @i_num           = 111111
          return 1
       end
       else
         return 111111
   end

    --> ESTABLEZCO HORARIO DE PAGO > DGA 23/Ene/2006 (Orig: HY)

   select @w_hora_sys = convert(varchar(08),getdate(),108)
   select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
   select @o_fecha_efe = @s_date

   if @w_hora >= @w_hora_tope and
      @t_corr = 'N' and
      @i_autoriza = 'N' and
      @w_offline = 'N' and @s_date = @w_fecha_hoy
   begin
      select @w_ind_diferido = 'S'
      select @t_trn = 3216
      select @o_fecha_efe = min(dl_fecha)
      from cob_cuentas..cc_dias_laborables
      where dl_ciudad   = 1
        and dl_num_dias = 1
   end
   else
   begin
       if @i_canal = "VEN" and @t_corr = 'N'
       begin

          if @o_horario = "D"
          begin
             if @i_cheque > 0
             begin
                select @w_ind_diferido = 'S'
                select @t_trn = 4112   --- REF 24 ----3216

                select @o_fecha_efe = min(dl_fecha)
                  from cob_cuentas..cc_dias_laborables
                 where dl_ciudad = 1
                   and dl_num_dias = 1
             end
             else
                select @t_trn = 3215
          end
       end
       else
       begin
          if @w_hora >= @w_hora_tope and @t_corr = 'S'
             and @w_offline = 'N' and @s_date = @w_fecha_hoy
          begin
             select @w_ind_diferido = 'S'
             select @t_trn = 3216

             select @o_fecha_efe = min(dl_fecha)
             from cob_cuentas..cc_dias_laborables
             where dl_ciudad = 1
               and dl_num_dias = 1
          end
       end
   end
   
   --< HORARIO DE PAGO < --
   -->hy-15-feb-2006
   if @t_corr = 'N'
      if @w_ind_diferido = "S"
         select @o_horario = "D"
      else
         select @o_horario = "N"


   --if @t_trn = 3216 hy-21-diciembre-2006 estaba como tercer if y se agreg� el else
      if @i_canal = 'VEN'
         if @t_corr <> 'N'
            begin

      select @w_trx_orig = ts_tipo_transaccion    -- identifica trx original
      from cob_cuentas..cc_tran_servicio
      where ts_secuencial = @t_ssn_corr
      and ts_tipo_transaccion in (3215,3216,4112) ---REF 24
      if @@rowcount <> 0
         select @t_trn = @w_trx_orig

                if @w_hora >= @w_hora_tope and @t_trn = 3215
         begin
         exec cobis..sp_cerror
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @w_sp_name,
         @i_msg           = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO',
         @i_num           = 358750
        return 1
         end

                  if @t_trn = 3216
                     begin
           select @o_horario = "D"
           select @o_fecha_efe = min(dl_fecha)
            from cob_cuentas..cc_dias_laborables
            where dl_ciudad = 1
            and dl_num_dias = 1
                     end

            end

   --<hy-15-feb-2006


   -->hy-14-agosto-2006
   ---nchavezb 08/Agosto Municipio Daule 1430
   if @i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" )  or @i_municipio = 1800 or @i_municipio = 2319 or @i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236 or @i_municipio = 1430 /*Wise - 18/Agt/2008 - M. Libertad=2236 */
      select @o_fecha_ef = convert(varchar(10),@o_fecha_efe,101)
   else
      select @o_fecha_ef = convert(varchar(10),@s_date,101)
   --<hy-14-agosto-2006

   select @o_feccontable = convert(varchar(8),@o_fecha_efe,112)   --- REF 21



/*  Modo de correccion */
if @t_corr = 'N'
   select  @w_factor = 1
else
   select @w_factor = -1



-->hy-15-feb-2006
if @w_factor = 1 and @i_canal = 'VEN'
begin
   Select @w_serie = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'SERNV'
     and pa_producto = 'CTE'

   --Obtener la secuencia de la nota de venta
  /* exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'sv_seq_nota_venta',
        @o_siguiente = @w_secuencian out

   if @w_return != 0
   begin                    --lfcm 25-junio-2007
      rollback              --lfcm 25-junio-2007
      return @w_return
   end                      --lfcm 25-junio-2007

   --Armar el numero de nota de venta
   select @w_secuenciac = convert(varchar(7),@w_secuencian)
   select @w_secuenciac = replicate('0',7-datalength(@w_secuenciac))+@w_secuenciac
   select @o_nota_venta = substring(@w_serie,1,3)+'-'+substring(@w_serie,4,3)+'-'+@w_secuenciac*/

end
--<hy-15-feb-2006


-->hy-14-agosto-2006
--Comentar ya no se usa tablas locales
-->hy-05-noviembre-2007
--Descomentar por causa del municipio de ibarra que usa tablas locales

if @i_municipio = 2234  --hy-30-ene-2006
begin

if @w_factor = 1
begin
   select @w_contador = count(1)
   from cob_pagos..pg_municipios
   where pm_municipio          = @i_municipio
     and pm_doc_identificacion = @i_identifica
     and pm_fec_ven            < @i_fecven
     and pm_cod_pago           = 'N'

/*     and (      (pm_ano_tributacion    = @i_agno
     and pm_semestre_cobro     < convert(smallint,@i_semestre)  )
or
         (pm_ano_tributacion    <> @i_agno
     and pm_ano_tributacion    < @i_agno)    )*/

   if @w_contador > 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031063,
              @i_msg   = 'TIENE CUENTAS PENDIENTES FAVOR CONSULTE TODAS LAS DEUDAS'
         return 1
      end
      else
      begin
         rollback
         return 31063
      end
   end

   exec @w_return = cobis..sp_cseqnos
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_tabla  = 'ts_telefono',
        @o_siguiente = @w_secuencial out

   if @w_return != 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031063,
              @i_msg   = 'ERROR AL OBTENER SEQNO'
         return @w_return
      end
      else
      begin
         rollback
         return @w_return
      end
   end


   if @i_municipio = 2234
    update cob_pagos..pg_municipios
    set pm_cod_pago   = 'P',
      pm_fecha_pago = @s_date
    where pm_municipio          = @i_municipio
    and pm_doc_identificacion = @i_identifica
    and pm_cod_impuesto       = @i_cod_impto
    and pm_ano_tributacion    = @i_agno
    and pm_semestre_cobro     = convert(tinyint,@i_semestre)
    and pm_cod_pago           = 'N'
    and pm_catastro           = @i_catastro
    and pm_referencia         = @i_referencia
   else

    update cob_pagos..pg_municipios
    set pm_cod_pago   = 'P',
      pm_fecha_pago = @s_date
    where pm_municipio          = @i_municipio
    and pm_doc_identificacion = @i_identifica
    and pm_no_predio          = @i_no_predio
    and pm_cod_impuesto       = @i_cod_impto
    and pm_ano_tributacion    = @i_agno
    and pm_prioridad_orden    = @i_prioridad
    and pm_semestre_cobro     = convert(tinyint,@i_semestre)
    and pm_cod_pago           = 'N'

   if @@error != 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031063,
              @i_msg   = 'REGISTRO SE ENCUENTRA PAGADO'
         return @w_return
      end
      else
      begin
         rollback
         return @w_return
      end
   end
end
else /* Correccion */
begin
   -->hy-05-noviembre-2007


   select @w_contador = count(1)
   from cob_pagos..pg_municipios
   where pm_municipio          = @i_municipio
   and pm_doc_identificacion = @i_identifica
   and pm_fec_ven            > @i_fecven
   and pm_cod_pago           = 'P'

/*     and (      (pm_ano_tributacion    = @i_agno
     and pm_semestre_cobro     > convert(smallint,@i_semestre)  )
or
         (pm_ano_tributacion    <> @i_agno
     and pm_ano_tributacion    > @i_agno)    ) */

   if @w_contador > 0
   begin
      if @i_aplcobis = 'S'
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 031063,
              @i_msg   = 'NO PUEDE REVERSAR ESTA TRX, RESPETE EL ORDEN DE PAGO'
         return 1
      end
      else
      begin
         rollback
         return 31063
      end
   end
   --<hy-05-noviembre-2007

   /* Encuentra datos actuales */

   if @i_municipio = 2234
    update cob_pagos..pg_municipios
    set pm_cod_pago   = 'N',
      pm_fecha_pago = '01/01/1900'
    where pm_municipio          = @i_municipio
    and pm_doc_identificacion = @i_identifica
    and pm_cod_impuesto       = @i_cod_impto
    and pm_ano_tributacion    = @i_agno
    and pm_semestre_cobro     = convert(tinyint,@i_semestre)
    and pm_catastro           = @i_catastro
    and pm_referencia         = @i_referencia
   else
    update cob_pagos..pg_municipios
    set pm_cod_pago   = 'N',
      pm_fecha_pago = '01/01/1900'
    where pm_municipio          = @i_municipio
    and pm_doc_identificacion = @i_identifica
    and pm_no_predio          = @i_no_predio
    and pm_cod_impuesto       = @i_cod_impto
    and pm_ano_tributacion    = @i_agno
    and pm_prioridad_orden    = @i_prioridad
    and pm_semestre_cobro     = convert(tinyint,@i_semestre)

   if @@error != 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 033017
         return 1
      end
      else
      begin
         rollback
         return 33017
      end
   end
end
end  --hy-30-ene-2006
--<hy-05-noviembre-2007
--<hy-14-agosto-2006

/****************************************************/
-- GAMC - 23/02/2008 - MUNICIPIO DE SAMBORONDON  -INI
/****************************************************/
-- GAMC - 05/03/2008 - SE AGREGO MUNICIPIO DE SALINAS POR LLEVAR LA MISMA LOGICA
--nchavezb 08/Agosto/2011 Municipio Daule 1430
if @i_municipio = 2319 OR @i_municipio = 2237 OR @i_municipio = 2235 OR @i_municipio = 2236  or @i_municipio = 1430 /* Wise - 15/Agt/2008 M. Libertad = 2236 */
begin --if @i_municipio = 2319
  if @w_factor = 1
  begin --if @w_factor = 1

     exec @w_return = cobis..sp_cseqnos
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_tabla  = 'ts_telefono',
      @o_siguiente = @w_secuencial out

     if @w_return != 0
     begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
       exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 031063,
          @i_msg   = 'ERROR AL OBTENER SEQNO'
       return @w_return
      end
      else
      begin
       rollback
       return @w_return
      end
     end

  --print "%1! @i_municipio ",@i_municipio
  --print "%1! @i_catastro2 ",@i_catastro2
  --print "%1! @i_cod_impto ",@i_cod_impto
  --print "%1! @i_agno ",@i_agno
  --print "%1! @i_semestre ",@i_semestre

     --if @i_municipio = 2319
     --if @i_municipio = 2319 or @i_municipio = 2237 --GAMC - 05/03/2008
     ---Update para municipio 1430 nchavezb 11/Agosto/2011



    if @i_municipio = 1430


        update cob_pagos..pg_municipios
        set pm_cod_pago   = 'P',
        pm_fecha_pago = @s_date
        where pm_municipio          = @i_municipio
        and pm_cod_impuesto       = @i_cod_impto
        and pm_ano_tributacion    = @i_agno
        and pm_cod_pago           = 'N'
        and pm_no_predio          = @i_no_predio
        and pm_referencia         = @i_referencia

     else
        update cob_pagos..pg_municipios 
        set pm_cod_pago   = 'P',
        pm_fecha_pago = @s_date
        from cob_pagos..pg_municipios (index i_pg_municipios_04)
        where pm_municipio          = @i_municipio
        and pm_catastro       = @i_catastro2
        and pm_cod_impuesto       = @i_cod_impto
        and pm_ano_tributacion    = @i_agno
        and pm_semestre_cobro     = convert(tinyint,@i_semestre)
        and pm_cod_pago           = 'N'

     /*
     else
      update cob_pagos..pg_municipios
      set pm_cod_pago   = 'P',
        pm_fecha_pago = @s_date
      where pm_municipio          = @i_municipio
      and pm_doc_identificacion = @i_identifica
      and pm_no_predio          = @i_no_predio
      and pm_cod_impuesto       = @i_cod_impto
      and pm_ano_tributacion    = @i_agno
      and pm_prioridad_orden    = @i_prioridad
      and pm_semestre_cobro     = convert(tinyint,@i_semestre)
      and pm_cod_pago           = 'N'
     */

       if @@error != 0
       begin
        if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
        begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 031063,
            @i_msg   = 'REGISTRO SE ENCUENTRA PAGADO'
         return @w_return
        end
        else
        begin
         rollback
         return @w_return
        end
       end
  end --if @w_factor = 1
  else /* Correccion */
  begin -- else if @w_factor = 1
     -->hy-05-noviembre-2007
    --GAMC - 23/02/2008 - INI

     --if @i_municipio = 2319
     --if @i_municipio = 2319 or @i_municipio = 2237 --GAMC - 05/03/2008
     --begin
         --print 'Reverso'
       select @w_contador = count(1)
       from cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
       where pm_municipio          = @i_municipio
       and pm_catastro       = @i_catastro2
       and pm_ano_tributacion    > @i_agno
       and pm_cod_pago           = 'P'
    --print '@w_contador: %1!', @w_contador
     --end
     /*else
       select @w_contador = count(1)
       from cob_pagos..pg_municipios
       where pm_municipio          = @i_municipio
       and pm_doc_identificacion = @i_identifica
       and pm_fec_ven            > @i_fecven
       and pm_cod_pago           = 'P'
    */


     if @w_contador > 0
     begin
      if @i_aplcobis = 'S'
      begin
       exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 031063,
          @i_msg   = 'NO PUEDE REVERSAR ESTA TRX, RESPETE EL ORDEN DE PAGO'
       return 1
      end
      else
      begin
       rollback
       return 31063
      end
     end

     /* Encuentra datos actuales */
     --if @i_municipio = 2319
     --if @i_municipio = 2319 or @i_municipio = 2237 --GAMC - 05/03/2008
     --Municipio de Daule 1430 nchavezb


     if @i_municipio = 1430

      update cob_pagos..pg_municipios
      set pm_cod_pago   = 'N',
      pm_fecha_pago = @s_date
      where pm_municipio        = @i_municipio
      and pm_cod_impuesto       = @i_cod_impto
      and pm_ano_tributacion    = @i_agno
      and pm_no_predio          = @i_no_predio
  and pm_referencia         = @i_referencia
     else
     update cob_pagos..pg_municipios
     set pm_cod_pago   = 'N',
       pm_fecha_pago = '01/01/1900'
     from cob_pagos..pg_municipios (index i_pg_municipios_04)
     where pm_municipio          = @i_municipio
       and pm_catastro       = @i_catastro2
       and pm_cod_impuesto       = @i_cod_impto
       and pm_ano_tributacion    = @i_agno
       and pm_semestre_cobro     = convert(tinyint,@i_semestre)
       --and pm_referencia         = @i_referencia2
     /*else
      update cob_pagos..pg_municipios
      set pm_cod_pago   = 'N',
        pm_fecha_pago = '01/01/1900'
      where pm_municipio          = @i_municipio
      and pm_doc_identificacion = @i_identifica
      and pm_no_predio          = @i_no_predio
      and pm_cod_impuesto       = @i_cod_impto
      and pm_ano_tributacion    = @i_agno
      and pm_prioridad_orden    = @i_prioridad
      and pm_semestre_cobro     = convert(tinyint,@i_semestre)
    */
     if @@error != 0
     begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
       exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 033017
       return 1
      end
      else
      begin
         rollback
       return 33017
      end
     end
  end -- else if @w_factor = 1
end --if @i_municipio = 2319
/****************************************************/
-- GAMC - 23/02/2008 - MUNICIPIO DE SAMBORONDON  -FIN
/****************************************************/

--Ini Ref33 smerino --- 

-->hy-14-agosto-2006
--if @i_municipio = 1433
   --select @w_causal = '367'
--else
  --if @i_municipio = 1435                ---REF 24
     --select @w_causal = '481'
   --else
     --if @i_municipio = 1417
        --select @w_causal = '356'
      --else
        --if @i_municipio = 1800
           --select @w_causal = '530'
         --else
           --select @w_causal = '334'
   --hy-22-febrero-2007 agregar municipio 1800
   --hy-05-noviembre-2007 considerar municipio 2234 ibarra

--<hy-14-agosto-2006


--GAMC - 23/02/2008 - MUNICIPIO DE SAMBORONDON
--if @i_municipio = 2319
   --select @w_causal = '337'

--GAMC - 05/03/2008 - MUNICIPIO DE SALINAS
--if @i_municipio = 2237
--if @i_municipio = 2237 OR @i_municipio = 2235 --GAMC - 14/04/2008
   --select @w_causal = '335'

--if @i_municipio = 2236  Wise - 15/Agt/2008 - M. Libertad = 2236 
  -- select @w_causal = '348'

--if @i_municipio = 1430  DAPV - 23/08/2011-- M. Daule
   --select @w_causal = '479' 

--fin Ref33 smerino --- 




--hy-14-agosto-2006 antes era solo para ventanilla ahora son todos los medios
--if @i_canal = 'VEN'
--begin
if @i_municipio <> 1800   --hy-22-febrero-2007
begin
   select @w_secuencia_ssn = convert(varchar(20),@s_ssn)
   if @i_municipio in (1417,1434)    --- REF23
      begin
       select @w_secuencia_ssn = convert(varchar(20),@i_psecuencial_adq)
      end
   if @i_municipio in (1433,1435, 7749)   --Ref034:msilvag --- REF23 
      begin
       select @w_secuencia_ssn = @i_secuencial
      end

   if datalength(rtrim(ltrim(@w_secuencia_ssn))) > 6
      select @i_secuencial = right(rtrim(@w_secuencia_ssn),6)
   else
      select @i_secuencial = replicate('0',6-datalength(rtrim(ltrim(@w_secuencia_ssn)))) + rtrim(ltrim(@w_secuencia_ssn))
end
--end
--<hy-15-feb-2006

-->hy-14-agosto-2006
if @i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) --Ref034:msilvag 
begin
   select @w_clave_concilia = @w_cod_cat
   select @w_cedruc         = @i_identifica
   select @w_referencia     = convert(varchar(10),@i_no_predio)
end
else
begin
   select @w_clave_concilia = replicate('0',22-datalength(rtrim(ltrim(@i_identifica)))) + rtrim(ltrim(@i_identifica))
   select @w_cedruc         = @i_cedruc
   select @w_referencia     = right(@w_clave_concilia,15)
 ---  if @i_municipio = 1435   ---- CTE-CC-9737
 ---     select @w_clave_concilia = replicate('0',27-datalength(rtrim(ltrim(convert(varchar,@i_no_predio))))) + rtrim(ltrim(convert(varchar,@i_no_predio)))
end
--<hy-14-agosto-2006

-->hy-05-noviembre-2007
select @w_tipoid = null
--if @i_municipio = 2319 --GAMC - 23/02/2008 - Municipio de Samborondon
--if @i_municipio = 2319 or @i_municipio = 2237 --GAMC - 05/03/2008 - Municipio de Salinas
/* if @i_municipio = 2319 or @i_municipio = 2237 or @i_municipio = 2235 --GAMC - 14/04/2008 - Municipio de Santa Elena */
--nchavezb Municipio Daule
if @i_municipio = 2319 or @i_municipio = 2237 or @i_municipio = 2235 or @i_municipio = 2236 or @i_municipio = 1430 /* Wise - 15/Agt/2008 - M.Libertad = 2236 */
begin
   select @w_tipoid = pm_cod_identificacion,
        @w_alt_dos = pm_referencia,
        @w_valor1  = convert(varchar(10), convert(int, pm_valor_impuestos * 100)),
        @w_valor2  = convert(varchar(10), convert(int, pm_valor_otros * 100)),
        @w_valor3  = convert(varchar(10), convert(int, pm_valor_total * 100)),
        @w_catastrotemp = (case @i_municipio when 2319 then convert(varchar(30), pm_no_predio)
                             when 2237 then convert(varchar(30), pm_referencia)
                             when 2235 then convert(varchar(30), pm_no_predio)
                             when 2236 then convert(varchar(30), pm_referencia) /*Wise 15/Agt/2008 M. Libertad = 2236 */
                             end),
        @w_referencia = (case @i_municipio when 2319 then convert(varchar(15), pm_no_predio)
                           when 2237 then convert(varchar(15), pm_catastro)
                           when 2235 then convert(varchar(15), pm_catastro)
                           when 2236 then convert(varchar(15), pm_referencia)    /*Wise 15/Agt/2008 M. Libertad = 2236 */

                           end)

   from cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
   where pm_municipio          = @i_municipio
     and pm_catastro       = @i_catastro2
     and pm_cod_impuesto       = @i_cod_impto
     and pm_ano_tributacion    = @i_agno
     and pm_semestre_cobro     = convert(tinyint,@i_semestre)

    --GAMC - 18/03/2008 - MUNICIPIO DE SALINAS
    --OBTENER VALORES PARA ENVIAR AL ARCHIVO DE SALIDA
    set @w_cadena = '0000000000'

  if convert(money, @w_valor1) < 0
  begin
    select @w_valor1 = convert(varchar(10), convert(int, @w_valor1) * -1)
    select @w_valor1 = substring(@w_cadena, 1, 10 - datalength(@w_valor1)) || @w_valor1
    select @w_valor1 = "-" || substring(@w_valor1, 2, 9)
  end
  else
    select @w_valor1 = substring(@w_cadena, 1, 10 - datalength(@w_valor1)) || @w_valor1

  if convert(money, @w_valor2) < 0
    begin
    select @w_valor2 = convert(varchar(10), convert(int, @w_valor2) * -1)
    select @w_valor2 = substring(@w_cadena, 1, 10 - datalength(@w_valor2)) || @w_valor2
    select @w_valor2 = "-" || substring(@w_valor2, 2, 9)
  end
  else
    select @w_valor2 = substring(@w_cadena, 1, 10 - datalength(@w_valor2)) || @w_valor2

    if convert(money, @w_valor3) < 0
        begin
      select @w_valor3 = convert(varchar(10), convert(int, @w_valor3) * -1)
      select @w_valor3 = substring(@w_cadena, 1, 10 - datalength(@w_valor3)) || @w_valor3
      select @w_valor3 = "-" || substring(@w_valor3, 2, 9)
    end
    else
    select @w_valor3 = substring(@w_cadena, 1, 10 - datalength(@w_valor3)) || @w_valor3

   if @i_municipio = 1430 --nchavezb 15/Agosto/2011
   select
         @o_referencia2      = pm_referencia,
         @o_direccion      = substring(pm_direccion, 1, 30),
         @o_solar        = pm_num_casa + '      ' + pm_letra_casa,
         @o_valorpredio      = isnull(pm_valor_impuestos,0) , --Ref031:msilvag 
         @o_valorotros     = isnull(pm_valor_otros,0) , --Ref031:msilvag 
         @o_doc_ident      = pm_doc_identificacion,
         @o_cod_ident      = pm_cod_identificacion
        from
        cob_pagos..pg_municipios
        where pm_municipio       = @i_municipio
        and pm_no_predio = @i_no_predio
        and pm_referencia= @i_referencia
        and pm_ano_tributacion    = @i_agno
   else
   select
      @o_referencia2      = pm_referencia,
      @o_direccion      = substring(pm_direccion, 1, 30),
      @o_solar        = pm_num_casa + '      ' + pm_letra_casa,
      @o_valorpredio      = isnull(pm_valor_impuestos,0) , --Ref031:msilvag
      @o_valorotros     = isnull(pm_valor_otros,0) , --Ref031:msilvag
      @o_doc_ident      = pm_doc_identificacion,
      @o_cod_ident      = pm_cod_identificacion
    from
      cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
    where
      pm_municipio          = @i_municipio
  and pm_catastro         = @i_catastro2
  and pm_cod_impuesto       = @i_cod_impto
  and pm_ano_tributacion    = @i_agno
  and pm_semestre_cobro     = convert(tinyint,@i_semestre)
  --and pm_referencia       = @i_referencia2


end
else
  if @i_municipio = 2234
  begin
     select @w_catastrotemp = @i_catastro
     select @w_alt_dos      = @i_referencia
     select @w_tipoid = pm_cod_identificacion
     from cob_pagos..pg_municipios
     where pm_municipio          = @i_municipio
     and pm_doc_identificacion = @i_identifica
     and pm_cod_impuesto       = @i_cod_impto
     and pm_ano_tributacion    = @i_agno
     and pm_semestre_cobro     = convert(tinyint,@i_semestre)
     and pm_catastro           = @i_catastro
     and pm_referencia         = @i_referencia
  end
  else
  begin
     select @w_catastrotemp = @w_cedruc
     select @w_alt_dos = @w_clave_concilia
  end
--<hy-05-noviembre-2007
if @i_municipio <> 2319 --GAMC - 24/02/2008
  set @w_descripcion_ec = @i_titulo
else
  set @w_descripcion_ec = @i_catastro2

--if @i_municipio = 2237 or @i_municipio = 2235 --GAMC - 14/04/2008
/*if @i_municipio = 2237 --GAMC - 17/03/2008  */
if @i_municipio = 2237 or @i_municipio = 2236   /* Wise - 15/Agt/2008 M. Libertad = 2236 */
  select  @w_descripcion_ec = @w_valor1 || @w_valor2 || @w_valor3 || pm_doc_identificacion,
      @w_alt_dos = @i_catastro2
      --@i_identifica = pm_doc_identificacion
  from cob_pagos..pg_municipios (index i_pg_municipios_04)   --Ref 36
    where pm_municipio          = @i_municipio
     and  pm_catastro      = @i_catastro2
     and  pm_cod_impuesto       = @i_cod_impto
     and  pm_ano_tributacion    = @i_agno

if @i_municipio = 2235 --GAMC - 23/04/2008
                                    --substring(@w_cadena, 1, 10 - datalength(@w_valor3)) || @w_valor3
  select  @w_descripcion_ec = (substring('                    ', 1, 20 - datalength(pm_referencia)) || pm_referencia) || '          ' || (substring('00000000000000', 1, 14 - datalength(pm_doc_identificacion)) || pm_doc_identificacion),
      @w_alt_dos = @i_catastro2
  from cob_pagos..pg_municipios (index i_pg_municipios_04)  --Ref 36
    where pm_municipio          = @i_municipio
     and  pm_catastro      = @i_catastro2
     and  pm_cod_impuesto       = @i_cod_impto
     and  pm_ano_tributacion    = @i_agno

  /*
  select  @w_descripcion_ec = convert(varchar(10), pm_valor_impuestos) + '|' +
                  convert(varchar(10), pm_valor_otros) + '|' +
                  convert(varchar(10), pm_valor_total),
        @w_alt_dos = @i_catastro2
    from cob_pagos..pg_municipios
      where pm_municipio          = @i_municipio
       and  pm_catastro      = @i_catastro2
       and  pm_cod_impuesto       = @i_cod_impto
     and  pm_ano_tributacion    = @i_agno
  */
else
  set @i_prioridad = null --GAMC - 18/03/2008

--print 'Valores: %1!', @w_descripcion_ec

/* Grabar transaccion de servicio local */


-->lfcm 29-junio-2009
if @i_municipio = 1434--Ref034:msilvag 
begin
   select @w_referencia = @i_identifica
   select @w_catastrotemp = @i_codresbr
   --select @i_agno = @i_cuota

end

--Ref034 pricaura Ini
if @i_municipio = 7749 and @i_tipo_impto = "002"
begin 
	select @w_referencia = @i_identifica
   select @w_catastrotemp = @i_pnumero
end
--Ref034 pricaura Fin

--<lfcm 29-junio-2009
--Ref034:msilvag  Inicio
if  @i_municipio = 7749 and @i_tipo_impto = "004"  
 set @w_referencia = right('0000000000' + convert(varchar(10),@i_no_predio),10) ,  --Ref032:smerinom --RTRIM(LTRIM((convert(varchar(10),@i_no_predio)))),
  @w_catastrotemp = @i_pnumero,
  @w_alt_dos=convert(varchar,@i_psecuencial_adq)
  

if @i_municipio = 1433 or @i_municipio = 1435 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) or (@i_municipio = 7749 and @i_tipo_impto = "003" ) 
    set @w_catastrotemp = @i_pnumero
--Ref034:msilvag Fin

if (@i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) ) and @i_canal <> 'ATM' --Ref034:msilvag ---REF 25  --<GAMC - 21ENE10
  set @i_agno = convert(smallint, @i_panio_vigencia)

if @i_municipio = 1430 --DAPV --24/08/2011 --M. Daule
   set @w_referencia = RTRIM(LTRIM((convert(char(10),@i_no_predio))))+ '-' + RTRIM(LTRIM(@i_referencia))  ,
       @w_catastrotemp = convert(char(10),@i_no_predio),
       @w_alt_dos   = RTRIM(LTRIM((convert(char(10),@i_no_predio))))+ '-' + RTRIM(LTRIM(@i_referencia))

if  @i_municipio = 7749 and @i_tipo_impto = "001"    
	set @w_referencia = @i_psector+@i_pmanzana+@i_plote+@i_pdivision+@i_pphv+@i_pphh+@i_pnumero+@i_panio_vigencia
	   
	   
--Ref034 pricaura ini	   
if @i_producto = 'CTE' and @i_debito > 0
begin
   select @o_nombcta = cc_nombre,
          @w_disponible_cte = cc_disponible,
          @v_cliente = cc_cliente --REF39
   from cob_cuentas..cc_ctacte
   where cc_cta_banco = @i_cuenta
   
        --Ini Ref33 smerino --- 
         select @w_causal = b.valor
         from cobis..cl_tabla a, cobis..cl_catalogo b
         where a.tabla = 'causa_nd_cte_servicios'
         and a.codigo = b.tabla
         and b.codigo = convert(varchar(10),@i_municipio)
         and estado = 'V'
       --fin Ref33 smerino --- 


   exec @w_return = cob_cuentas..sp_ccndc_automatica
        @s_srv    = @s_srv,
        @s_ofi    = @s_ofi,
        @s_ssn    = @s_ssn,
        @s_user   = @s_user,
        @s_term   = @s_term,
        @t_corr   = @t_corr,
        @t_trn    = 3050,
        @i_cta    = @i_cuenta,
        @i_val    = @i_debito,
        @i_cau    = @w_causal,   --hy-14-agosto-2006 antes: '367',
        @i_mon    = 1,
        --@i_ref    = @i_cedula,
        @i_fecha  = @s_date,
        @s_rol    = @s_rol,
        @i_ubi    = @i_ubi,
        @i_con_tran = 'N' ,-- lfcm 25-junio-2007
		@i_detalle  = @w_referencia  --Ref034:msilvag

  if @w_return <> 0
  begin
    if @i_municipio = 1430
     begin
      update cob_pagos..pg_municipios
      set pm_cod_pago   = 'N',
      pm_fecha_pago = @s_date
      where pm_municipio        = @i_municipio
      and pm_cod_impuesto       = @i_cod_impto
      and pm_ano_tributacion    = @i_agno
      and pm_no_predio          = @i_no_predio
      and pm_referencia         = @i_referencia
    end
  end

   if @w_return <> 0
   begin
      rollback
      return @w_return
   end
--else
--   select @o_nombcta = ''
end

if @i_producto = 'AHO' and @i_debito > 0
begin


   select @o_nombcta = ah_nombre, 
   @v_cliente = ah_cliente --REF39
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cuenta
   
   

--Ini Ref33 smerino --- 
select @w_causal = b.valor
from cobis..cl_tabla a, cobis..cl_catalogo b
where a.tabla = 'causa_nd_aho_servicios'
and a.codigo = b.tabla
and b.codigo = convert(varchar(10),@i_municipio)
and estado = 'V'
--fin Ref33 smerino --- 	
	
   exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv    = @s_srv,
        @s_ofi    = @s_ofi,
        @s_ssn    = @s_ssn,
        @s_user   = @s_user,
        @s_term   = @s_term,
        @t_trn    = 4264,
        @t_corr   = @t_corr,
        @i_cta    = @i_cuenta,
        @i_val    = @i_debito,
        @i_cau    = @w_causal,   --hy-14-agosto-2006 antes: '367',
        @i_mon    = 1,
        --@i_ref    = @i_cedula,
        @i_fecha  = @s_date,
        @s_rol    = @s_rol,
        @i_ubi    = @i_ubi ,
		@i_tarjeta= @w_referencia  --Ref034:msilvag

  if @w_return <> 0
  begin
    if @i_municipio = 1430
     begin
      update cob_pagos..pg_municipios
      set pm_cod_pago   = 'N',
      pm_fecha_pago = @s_date
      where pm_municipio        = @i_municipio
      and pm_cod_impuesto       = @i_cod_impto
      and pm_ano_tributacion    = @i_agno
      and pm_no_predio          = @i_no_predio
      and pm_referencia         = @i_referencia
    end
  end

   if @w_return <> 0
   begin
      rollback
      return @w_return
   end

--else
   --select @o_nombcta = ''
end




-->hy-15-feb-2006
--if @i_canal = 'VEN' and (@i_efe_com > 0 or @i_chq_com > 0 or @i_deb_com > 0)  --hy-14-agosto-2006 antes era solo para ventanilla ahora es para todos los medios
if (@i_efe_com > 0 or @i_chq_com > 0 or @i_deb_com > 0)
begin
   if @t_trn = 3215
      select  @w_trn = 3366 , @w_servicio ="4"
   else
      select  @w_trn = 3372 , @w_servicio ="4"

   -->hy-14-agosto-2006
   --if @i_municipio = 1433
      select @w_servicio ="4"
   --else
      --select @w_servicio ="5"

/* Ref034 pricaura ini
   if @i_canal = 'VEN'
      select @w_causalcom = null
   else
   Ref034 pricaura fin
      */
      --Ini Ref33 smerino --- 
      --select @w_causalcom = '340'  smerino comenta
      
      if @i_producto = 'CTE' 
      begin
	      select @w_causalcom = b.valor
	      from cobis..cl_tabla a, cobis..cl_catalogo b
	      where a.tabla = 'causa_nd_comision_servcte'
	      and a.codigo = b.tabla
	      and b.codigo = convert(varchar(10),@i_municipio)
	      and estado = 'V'
       end
       else
      begin

		select @w_causalcom = b.valor
		from cobis..cl_tabla a, cobis..cl_catalogo b
		where a.tabla = 'causa_nd_comision_servaho'
		and a.codigo = b.tabla
		and b.codigo = convert(varchar(10),@i_municipio)
		and estado = 'V'
       end
       --FIN Ref33 smerino --- 
   --<hy-14-agosto-2006
   
  /*REF32: Inicio LBP */
if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
          where rs_empresa = @i_municipio
          and rs_canal = @i_canal and rs_estado = 'V')  
               
begin
     
          select @w_comi_total = isnull(@i_efe_com,0) + isnull(@i_chq_com,0) + isnull(@i_deb_com,0) -- Comision que debe venir del 12%
     
          exec cob_pagos..pa_pg_ivalor_comcal
             @e_valor_comision  = @w_comi_total,
             @e_oficina         = @s_ofi,
             @e_empresa         = @i_municipio,
             @e_canal           = @i_canal,
             @s_valor_com_final = @w_com_original out, -- obtengo comision original
             @s_aplica          = @w_aplica_des out
             
          if @w_aplica_des = 'S'
          begin
              exec cob_gov..pa_iva_pcompensacion
                 @e_oficina        = @s_ofi,
                 @e_monto          = @w_com_original,
                 @s_monto_compensa = @w_valor_compensa out   
          end
     
end
/*REF32: Fin LBP */   

   exec @w_return = cob_remesas..sp_cobro_comision_rc
        @s_ssn      = @s_ssn,
        @s_lsrv     = @s_lsrv,
        @s_srv      = @s_srv,
        @s_user     = @s_user,
        @s_sesn     = @s_sesn,
        @s_term     = @s_term,
        @s_date     = @s_date,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @s_org      = @s_org,
        @s_org_err  = @s_org_err, /* Origen de error: [A], [S] */
        @s_error    = @s_error,
        @s_sev      = @s_sev,
        @t_corr     = @t_corr,
        @t_ssn_corr = @t_ssn_corr, /* Trans a ser reversada */
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @t_from,
        @t_rty      = @t_rty,
        @t_trn      = @w_trn,
        @i_ubi      = @i_ubi,
        @i_mon      = @i_mon,
        @i_opcion   = "T",
        @i_servicio = @w_servicio,
        @i_codigo   = @i_identifica,
        @i_efectivo = @i_efe_com,
        @i_cheque   = @i_chq_com,
        @i_tipocta  = @i_producto,
        @i_cuenta   = @i_cuenta,   ---@i_cta_com,
        @i_debito   = @i_deb_com,  -- DEBITO A CTAS
        @i_aplcobis = @i_aplcobis, --hy-15-feb-2006
        @i_causal   = @w_causalcom  --hy-14-agosto-2006

   if @w_return != 0
   begin
      if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
      begin
         exec cobis..sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 035000
              rollback --lfcm 25-junio-2007
         return 1
      end
      else
      begin              --lfcm 25-junio-2007
         rollback        --lfcm 25-junio-2007
         return 35000
      end                --lfcm 25-junio-2007
   end

       select @w_com = @i_efe_com + @i_chq_com + @i_deb_com

    --smerino iva
      --smerino busca calculo dle iva
             -- smerino busqueda de la tasa del iva parametrizada en el person

       exec @w_return = cob_pagos..sp_verif_genera_costo
          @s_date         = @s_date,
          @i_mon          = @i_mon,
          @i_rubro        = 'IVA',
          @i_servicio     = 'IMPM',  --'ICAE',
          @i_canal        = @i_canal,
          @i_tipocta      = @w_tipocta,
          @o_costo        = @w_tasa out

        if @w_return <> 0
             begin
                  if @@trancount >0
            rollback

            return @w_return
       end


       
       
       if  @w_tasa > 0
       begin
           /*REF32: Inicio LBP */ 
           if @w_aplica_des = 'S' and @w_valor_compensa > 0 and @i_canal = 'VEN'
           begin
                -- smerino llamar al sp que retorna el valor del iva ----
                --print 'sp_cal_impuesto @w_com S: %1! ', @w_com
                --print 'sp_cal_impuesto @w_com_aux S: %1! ', @w_com_aux
                exec @w_return = cob_cuentas..sp_cal_impuesto
                     @i_tasa        = @w_tasa,
                     @i_valor_serv  = @w_com_original, -- Comision Original al 14
                     @o_base_imp    = @w_base_imp out,
                     @o_impuesto    = @w_impuesto2 out

                if @w_return <> 0
                begin
                    if @@trancount >0
                       rollback
                    return @w_return
                end
           end
           else
           begin
           /*REF32: Fin LBP */ 
                -- smerino llamar al sp que retorna el valor del iva ----
                --print 'sp_cal_impuesto @w_com N: %1! ', @w_com
                --print 'sp_cal_impuesto @w_com_aux N: %1! ', @w_com_aux
                exec @w_return = cob_cuentas..sp_cal_impuesto
                     @i_tasa        = @w_tasa,
                     @i_valor_serv  = @w_com,
                     @o_base_imp    = @w_base_imp out,
                     @o_impuesto    = @w_impuesto2 out

                if @w_return <> 0
                begin
                    if @@trancount >0
                       rollback
                    return @w_return
                end
           end
       end
       else
           select @w_base_imp=@w_com,@w_impuesto2=0



         --insert la trx del iva 3497 para cobro de la comision ---
         if @w_base_imp > 0
         begin
         
               /*REF32: Inicio LBP */ 
               if @w_aplica_des = 'S' and @w_valor_compensa > 0 and @i_canal = 'VEN'
               begin
                    --print '3497 @w_com_aux S: %1! ', @w_com_aux
                    --print '3497 @w_com S: %1! ', @w_com
                    exec @w_return = cob_cuentas..sp_cont_impuesto
                         @t_trn        = 3497 ,
                         @s_ssn        = @s_ssn,
                         @s_date       = @s_date,
                         @t_corr       = @t_corr,
                         @t_ssn_corr   = @t_ssn_corr,
                         @s_user       = @s_user,
                         @s_term       = @s_term,
                         @s_ofi        = @s_ofi,
                         @t_rty        = @t_rty,
                         @s_org        = @s_org,
                         @i_base_imp   = @w_base_imp,
                         @i_iva        = @w_impuesto2,
                         @i_total      = @w_com_original,
                         @i_cau        = @w_servicio,   --servivio que debe de enviarse
                         @i_cta        = @w_referencia, --referencia
                         @i_mon        = 1,   --Moneda
                         @i_oficina_cta= @s_ofi,
                         @i_ubi        = @i_ubi
               end
               else
               begin
               /*REF32: Fin LBP */ 
                    --print '3497 @w_com_aux N: %1! ', @w_com_aux
                    --print '3497 @w_com N: %1! ', @w_com
                    exec @w_return = cob_cuentas..sp_cont_impuesto
                         @t_trn        = 3497 ,
                         @s_ssn        = @s_ssn,
                         @s_date       = @s_date,
                         @t_corr       = @t_corr,
                         @t_ssn_corr   = @t_ssn_corr,
                         @s_user       = @s_user,
                         @s_term       = @s_term,
                         @s_ofi        = @s_ofi,
                         @t_rty        = @t_rty,
                         @s_org        = @s_org,
                         @i_base_imp   = @w_base_imp,
                         @i_iva        = @w_impuesto2,
                         @i_total      = @w_com,
                         @i_cau        = @w_servicio,   --servivio que debe de enviarse
                         @i_cta        = @w_referencia, --referencia
                         @i_mon        = 1,   --Moneda
                         @i_oficina_cta= @s_ofi,
                         @i_ubi        = @i_ubi
               end -- Fin if @w_aplica_des = 'S' and @w_valor_compensa > 0 and @i_canal = 'VEN' LBP


               if @w_return <> 0
               begin
                   if @@trancount >0
                      rollback
                   return @w_return
               end
         end


 
end

select @w_com = @i_efe_com +  @i_chq_com +   @i_deb_com
--Ref034 pricaura fin	   
	   
	   
	   
insert into cob_cuentas..cc_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_usuario, ts_rol,
    ts_terminal, ts_correccion, ts_propietario, ts_tipo_chequera, ts_reentry,
    ts_origen, ts_nodo, ts_tsfecha, ts_clase, ts_sec_correccion,
    ts_moneda, ts_cta_banco, ts_valor, ts_saldo, ts_monto,
    ts_cheque_rec, ts_tsn, ts_hora, ts_tipocta, ts_ubicacion,
    ts_campo_alt_uno, ts_autoriz_anula, ts_referencia, ts_stick_imp, ts_autorizante,
    --ts_causa, ts_nombre, ts_cta_asociada, -- DGA 01/Feb/2006
    ts_causa, ts_nombre, ts_contratado, --lfcm 20/octubre/2006 'Pago con Tarjeta de Credito el valor se guarda en ts_contratado. Ver Perfil contable.
    ts_ssn_corr,  --hy-01/11/2006
    ts_autoriz_aut, ts_campo_alt_dos, ts_agente, ts_cta_banco_dep, ts_ced_ruc, --hy-15-feb-2006
    ----REF 21 ts_descripcion_ec,ts_estado_sob,  --hy-14-agosto-2006
    ts_descripcion_ec, ts_corresponsal,
    ts_servicio,
    ts_default, ts_direccion_ec,
    ts_plazo,ts_cta_asociada    )  ---ref38
values
   (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol,
    @s_term, @t_corr, @i_cod_impto, @i_canal, @t_rty,
    'L', @s_lsrv, @s_date, 'NOR', @t_ssn_corr,
    @i_mon, @i_cuenta, @i_efe, @i_cheque, @i_debito,
    @i_cant_chq, @i_tsn, getdate(), substring(@i_producto,1,1), @i_ubi,
    @w_catastrotemp, @i_supautor, @w_referencia, convert(varchar(4),@i_agno), @i_semestre,   --hy-14-agosto-2006 antes @i_identifica ahora @w_cedruc antes convert(varchar(10),@i_no_predio) ahora @w_referencia
    --convert(varchar(4),@i_municipio), @i_nombre, convert(varchar,@i_tarjeta), -- DGA 01/Feb/2006
    convert(varchar(4),@i_municipio), @i_nombre, @i_tarjeta, -- lfcm 20/octubre/2006 Se quita el convert a la variable @i_tarjeta. El campo ts_contratado y la variable son de tipo money
    @t_ssn_corr,  --hy-01/11/2006
    @w_com, @w_alt_dos, @i_secuencial, @i_hora_trama, @i_identifica,       --hy-15-feb-2006  hy-14-agosto-2006 antes w_cod_cat ahora @w_clave_concilia
    @w_descripcion_ec, --GAMC - 24/02/2008
    @i_tipo_impto,  --hy-14-agosto-2006
    @w_tipoid,  --hy-05-noviembre-2007
    @i_prioridad, convert(tinyint, @i_ofiretiro),
    @i_cuota,@i_referencia2) ---ref38


if @@error != 0
begin
   if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
   begin
   /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 033005
           rollback --lfcm 25-junio-2007
      return 1
   end
   else
   begin
     rollback
     return 33005
   end
end

select @w_empresa = convert(varchar(6),@i_municipio)


--GAMC - 21ENE10 - Comprobante de Ingreso de Caja
--@o_pcuic = @o_pcuic


if (@i_canal = 'IBK' or @i_canal = 'KSK') and (@i_municipio = 1433 or (@i_municipio = 7749 and @i_tipo_impto = "001" ) ) --Ref034:msilvag
begin

    select "results_submit_rpc",
        r_cuic      = @o_pcuic,
        r_fecha_efe = @o_fecha_ef,
        r_aut_br    = @o_pautorizacion

end

if (@i_canal = 'IBK' or @i_canal = 'KSK') and (@i_municipio = 1417 or @i_municipio = 1800)
begin

    select "results_submit_rpc",
        r_fecha_efe  = @o_fecha_ef,
        r_referencia = @s_ssn
end

--Ini Ref33 smerino --- 
if @i_canal = 'VEN'  
--Fin Ref33 Smerino --
begin
/* Actualizacion de Totales de cajero */
exec @w_return = cob_remesas..sp_upd_totales_rc
     @i_ofi         = @s_ofi,
     @i_rol         = @s_rol,
     @i_user        = @s_user,
     @i_producto    = 'CTE',
     @i_mon         = @i_mon,
     @i_ubi         = @i_ubi,
     @i_trn         = @t_trn,
     @i_nodo        = @s_srv,
     @i_tipo        = 'L',
     @i_corr        = @t_corr,
     @i_efectivo    = @i_efe,
     @i_cant_chq    = @i_cant_chq,
     @i_cheque      = @i_cheque,
     @i_efecto_chq  = 0,
     @i_efecto_odb  = 0,
     @i_nc_fiscales = 0,
     @i_tipocta     = @i_producto,
     @i_otros       = @i_debito,
     @i_tarjetas    = @i_tarjeta,   --hy-10-enero-2006
     @i_causa       = @w_empresa    --hy-12-enero-2006

if @w_return != 0
begin
   if @i_aplcobis = 'S'  ---mgavilat 18-ene-2006.
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 035000
           rollback --lfcm 25-junio-2007
      return 1
   end 
   else
   begin
      rollback
      return @w_return
   end
end
end
end --smerino 02142017

 /* INI REF39 */
	   exec  @v_return  = cob_pagos..sp_consulta_celular
              @i_cliente = @v_cliente,
              @o_celular = @v_telefono  out,
              @o_correo  = @v_correo    out
        if @v_return <> 0
        begin
            if @@trancount > 0
                rollback tran
            return @v_return
        end
		if @t_corr = 'N'
			select @w_servicio_alert = 'PAGSB', @w_ssn = @s_ssn, @w_desc_serv="Pago Fact."
		else
			select @w_servicio_alert = 'PAGSR', @w_ssn = @s_ssn, @w_desc_serv="Pago Fact."
			
		-- Obtener Nombre/Descripcion del Municipio
		select @w_empresaLAT = valor 
		  from cobis..cl_catalogo 
		 where tabla = (select codigo 
		 		  from cobis..cl_tabla 
				 where tabla = 'sv_municipios')
  		and codigo = @i_empresa	
		
		select @w_valor_debito = convert(varchar(11),@i_debito)
		
		if @i_canal = 'ATM'
			select @w_desc_canal = 'VEINTI4EFECTIVO'
		if @i_canal = 'DBA'
			select @w_desc_canal = 'AUTOMATICO'
		if @i_canal = 'IBK'
			select @w_desc_canal = '24Online'  
		if @i_canal = 'IVR'
			select @w_desc_canal = 'VEINTI4FONO'
		if @i_canal = 'KSK'
			select @w_desc_canal = 'PUNTOVEINTI4'
		if @i_canal = 'VEN'
			select @w_desc_canal = 'VENTANILLA'
		if @i_canal = 'WAP'
			select @w_desc_canal = 'WAP'
		if @i_canal = 'CNB'
			select @w_desc_canal = 'CNB'
      if @i_canal = 'SAT'  --KBastida RECM-470
			select @w_desc_canal = 'SAT'
		select  @w_hora_sys = convert(varchar(08),getdate(),108)
		
		
		
		
	 select @o_servicio_not = @w_servicio_alert,
	     @o_nomb_ente = @o_nombcta, --@v_nombre_cta,
	     @o_cod_ente =  convert(varchar(20),@v_cliente) ,
	     @o_desccanal = @w_desc_canal ,         	       
	     @o_celular = @v_telefono,
	     @o_correo  = @v_correo,
	     @o_desc_empresa = @w_empresaLAT,
	     @o_prod_deb = @i_producto,--@e_tipo_cta,
	     @o_valor = @w_valor_debito,
	     @o_fecha_deb = @w_fecha_hoy,
	     @o_hora_deb = @w_hora_sys,
	     @o_valor_comi = convert(varchar, @i_deb_com),
	     @o_valor_tot =  convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ @i_deb_com))  ,
	     @o_cta_lat = substring(@i_cuenta,8,3),
	     @o_tipo_serv = @w_desc_serv
/* FIN REF39 */
if @i_transac = 'S'  --hy-15-feb-2006
--commit tran


return 0


go
if exists(select 1 from sysobjects where name='sp_tr_municipio_recaudacion' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_tr_municipio_recaudacion *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_tr_municipio_recaudacion -- ERROR -- >>>'
go

go

--Ref031:msilvag Inicio
grant execute on sp_tr_municipio_recaudacion to apl_osb_hpact  --apl_osb_hpdes
--grant execute on sp_tr_municipio_recaudacion to apl_osb_hpdes
go
--Ref031:msilvag Fin
