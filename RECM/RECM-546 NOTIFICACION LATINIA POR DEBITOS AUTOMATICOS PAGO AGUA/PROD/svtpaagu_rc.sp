use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_pago_agua_rc' and type = 'P')
begin
   drop procedure dbo.sp_pago_agua_rc
   if exists (select 1 from sysobjects where name = 'sp_pago_agua_rc' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_pago_agua_rc -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_pago_agua_rc *OK* =='
end

go

/************************************************************************/
/*  Archivo:          svtpaagu.sp_rc                                    */
/*  Stored procedure: sp_pago_agua_rc                                   */
/*  Motor de Base: 		SYBASE                     					              */
/*  Servidor: 			  HP-ACT                                            */
/*  Procesamiento: 		OLTP	                                       	    */
/*  Aplicacion: 		  Cyberbank	                                        */
/*  Base de datos:    cob_pagos                                         */
/*  Producto:         Cuentas Corrientes                                */
/*  Disenado por:     Ricardo Egas S.                                   */
/*  Fecha de escritura: Mar-2001                                        */
/************************************************************************/
/*                                IMPORTANTE                            */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      BANCO BOLIVARIANO S.A.                                          */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante.  */
/************************************************************************/
/*                           PROPOSITO                                  */
/*      Este programa realiza el cobro en ventanilla de Agua            */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*      09/May/2001    R. Egas   Evitar controles con pagos en diferido */
/*      07/Ago/2001    R. Egas   Control de pago por rangos             */
/*      28/Ago/2001    R. Egas   Control de pago por rangos solo min    */
/*      10/sep/2001    R. Castillo      Control del campo ingreso del   */
/*                                      comprobante.                    */
/*      2001/dic/27     R. Egas         control de trx original en rev  */
/*      2002/jul/10     W. REINBERG  ejecutar rollback de transacciones */
/*      2003/ene/23     W. Ramirez    Usar estandar de cajero           */
/*      2003/Ene/25     R. Davila   Agregar id del Archivo que se esta  */
/*                                  Procesando.                         */
/*      2003/Abr/10   G.Morales  Llamada desde BV como aplicacion COBIS */
/*  02/May/2003 SIPECOM. Reingenieria de Caja                           */
/*  28/Abr/2004 SIPECOM Control corte de empresa para diferido          */
/*      08/Nov/2004     J. Pazminno   Cobro comision por pago servicio  */
/* 23/Ene/2008  Galo Yanez    Mensaje de Alert Manager x debito a ctas  */
/* 14 17/Feb/2010  Tania Cumbicus   CTE-CC-8446 Recaudacion TRIPLE ORO  */
/* 15 22/Agosto/2011 Sandra Merino  ATMFULL-286-CU-1720                 */
/*  Jun 27/2012 Galo Yanez  Pasar parametro categoria de  		*/
/*          cuenta de ahorros   					*/
/*          Tarea: AHO-CC-11589   					*/
/* 17 20/Julio/2012  Daniel Pereira CTE-SGC00002999 - Comision Interagua*/
/* 18 14/Dic/2012    Daniel Pereira CTE-CC-SGC00006244 - IVA            */
/* 19 04/Marzo/2013  Daniel Pereira CTE-CE-SGC00007808                  */
/* 20 22/Marzo/2013  Sandra Merino CTE-CE-SGC00008133                  	*/
/* 21 02/Abril/2013  María José Silva CTE-CC-SGC00007264 - Comision EMAAP QAMAGUA AGUAPEN*/
/* 22  16/DIC/2013   Sandra Merino   CNB-316-CU-1901        		*/
/* 23  16/Ago/2014   Sandra Merino   CNB-316-CU-1902        		*/
/* 24  16/AGO/2014   Sandra Merino   CNB-316-CU-1903          		*/
/*     23/Sep/2014   smerino   CNB   Tarea: CNB-316-CU-1903             */
/* 26  06/Mar/2015   J.Pazminno     Cuenta Basica - CNB                 */
/*                     Tarea: CB-AP-SGC00018374-SGC00018798             */
/* 27  02/Ago/2016   Luis Banda  RECA-CC-SGC00025868 se valida comision para*/
/*                   oficina damnificados segun comercio                */
/* 28  17/ENE/2017   PAUL HOYOS V.  CB-AP-SGC00018374-SGC00018798       */
/* 29  22/MAR/2017	 DANNY OLAYA S.	RECA-CC-SGC00027972		*/
/*                   Se considera el canal DIR junta a la DBA           */
/* 30  17/MAY/2017   Andy Riofrio A. INRECL-AP-SGC00027264-SGC00027271  */
/*                   se agrega parametro @i_sec_atm, Asignacion de valor*/
/*                   0 a base imponible cuando es null                  */                  
/* 31  30/MAY/2017   Danny Olaya Soriano - RECA-CC-SGC00028091          */ 
/*                   Se considera el canal IBK para las empresas AMAGUA,*/
/*                   AGUAPEN y EMAAPQ                                   */
/* 32  09/JUN/2017   Pablo Ricaurte Arias - SGC00027271                 */ 
/************************************************************************/
/* 33  16/JUN/2017   Vanessa Miranda INRECL-AP-SGC00027264-SGC00027269  */ 
/*     Agregar parámetros de entrada al procedimiento sp_eventos para   */
/*     poder visualizar en el comprobante los cargos por servicios      */
/*     financieros y el total                                           */
/* 34  25/Jul/2017   Daniel Pereira  CAJ-CC-SGC00028304  cobro comision por canal ATM*/
/* 35  12/Oct/2017   María José Silva RECA-CE-SGC00029949  Control para el reverso*/
/* 36  04/oct/2017   Daniel Pereira  RECA-CC-SGC00029498 Comision con DB interagua*/
/* 37  16/Ago/2017  María José Silva SGC00028642  Recaudacion AMAGUA en Linea*/
/* 38  16/Nov/2017  María José Silva Urgente  Registrar nombre*/
/* 39  29/Mar/2018  Alejandro Proaño   INT-CC-SGC31474 Cambiar descripcion Canal 24online */
/* 40  13/Mar/2018    Maria Jose Silva Tarea:SGC00030409 - Facturacion OffLine Debitos*/
/* 41  12/Dic/2018  Danny Olaya S. Por RECA-CE-SGC00034205 - Actualizar campo nombre para notificaciones */
/* 42  25/Feb/2019  Maria Jose Silva RECA-CE-SGC00034664 - Optimizacion DBA */
/* 43  25/Feb/2019  Maria Jose Silva SAT-CU-SGC00033011 - Cambios por SAT */
/* 44  04/May/2020  Daniel Pereira    RECMPS-469 Migracion Latinia       */
/* 45  24/Mar/2021  Maria Jose Silva    RECMPS-373 Migracion Latinia       */
/* 46  11/Ago/2021  Maria Jose Silva    RECM-311 Control Reverso Tasa Recoleccion*/
/* 47  21/Oct/2021  Dario Espinosa    RECM-1182 TRB PAGO Y REVERSO SERVICIOS SAT*/
/* 48  16/Nov/2021  Jonathan Guerrero   RECMPS-1173 Validar monto efectivo en Servicios Publicos */ 
/* 49  09/05/2022   Kevin Bastidas    RECM-546  NOTIFICACION LATINIA POR*/
/*                                    DEBITOS AUTOMATICOS PAGO DE AGUA  */											 
/************************************************************************/

create proc dbo.sp_pago_agua_rc
 (
       @s_ssn          int,
       @s_user         varchar(30),
       @s_term         varchar(10),
       @s_date         datetime,
       @s_srv          varchar(30),
       @s_lsrv         varchar(30),
       @s_ofi          smallint,
       @s_rol          smallint,
       @s_org_err      char(1) = NULL,
       @s_error        int     = NULL,
       @s_sev          tinyint = NULL,
       @s_msg          mensaje = NULL,
       @s_org          char(1),
       @t_debug        char(1) = 'N',
       @t_file         varchar(14) = null,
       @t_from         varchar(32) = null,
       @t_trn          int , --Ref037:msilvag smallint,
       @t_corr         char(1) = 'N',
       @t_ssn_corr     int = null,
       @i_mon          tinyint,
       @i_empresa      smallint,
       @i_proceso      varchar(3),
       @i_codigo       varchar(15),
       @i_efe          money = 0,
       @i_val          money = 0,
       @i_valch        money = 0,
       @i_debito       money = 0,
       @i_reten        money = 0,
       @i_tipocta      char(3) = null,
       @i_cuenta       cuenta = null,
       @i_opcion       char(1),
       @i_autoriza     char(1) = 'N',
       @i_tsn          int = null,
       @i_aplcobis     char(1) = 'S',                                           -- JLS 23/FEB/2001
       @i_ind_costo    char(1) = 'N',                                           -- JLS 14/MAR/2001
       @i_costo        money = 0,                                               -- JLS 14/MAR/2001
       @i_canal        varchar(14) ='VEN', --smerino prueba el que va es VEN
       @i_comprob      char(15) = null, -- RCA 09/08/2001
       @i_ubi          int = null,           --- ame 11/13/2003
       @o_nombre       varchar(30) = null out,
       @o_saldo        money = null out,
       @o_horario      char(1) = null out, --TPE 23/10/2003
       @o_minimo       money = null out,
       @o_costo        money = null out,
       @o_fecha_tope   datetime = null out,
       @o_fecha_efe    datetime = null out,
       @o_inddb        varchar(1) = null out,
       @i_cant_chq     int = null,        -- ame 21.may.03
       @o_comisionven  money = null out,  -- JPM 08112004
       @i_comision     money = 0,         -- JPM 08112004
       @o_autorisri    varchar(30) = null out,--JPM 08122004
       @o_fecvensri    varchar(30) = null out, --JPM 08122204
       @o_nota_venta   varchar(15) = null out,  --REF 14
       @i_efe_com      money = 0,              --REF 14
       @i_chq_com      money = 0,              --REF 14
       @i_deb_com      money = 0,              --REF 14
       @o_tasa         money = 0 out,  --REF18
       @o_base_imp     float = 0 out,  --REF18
       @o_impuesto     float = 0 out,  --REF18
       @i_sec_atm      int = null,  --REF30
       @i_dat_emp      varchar(30) = null,  --REF30
       @i_nombre       varchar(50) = null , --REF 30 
       @i_motivo_reverso    varchar(10) = null, --Ref037:msilvag 
       --ini ref44
       @o_servicio_not 	varchar(5) = null out,	
       @o_nomb_ente     varchar(64) = null out,	
       @o_cod_ente      varchar(20) = null out,	
       @o_desccanal     varchar(16) = null out,	
       @o_celular       varchar(10) = null out,	
       @o_correo        varchar(64) = null out,	
       @o_desc_empresa  varchar(32)  = null out,
       @o_prod_deb      char(3) = null out, 
       @o_valor		varchar(11) = null out, 
       @o_fecha_deb	varchar(10) = null out, 
       @o_hora_deb 	varchar(8) = null out,  
       @o_valor_comi	varchar(11) = null out, 
       @o_valor_tot	varchar(11) = null out, 
       @o_cta_lat	char(3)  = null out 
       --fin ref44
)
as
declare @w_return      int,
		@w_empresa 	   char(6),  --ref048
        @w_sp_name     varchar(30),
        @w_nombre      descripcion,
        @w_monto       money,
        @w_maximo_p    money,
        @w_val_usd     money,
        @w_valch_usd   money,
        @w_debito_usd  money,
        @w_debito_usd_bak money,
        @w_reten_usd   money,
        @w_factor      smallint,
        @w_tipocta     char(1),
        @w_hora_tope   int,
        @w_hora_sys    char(8),
        @w_hora        int,
        @w_secuencial  int,		
        @w_control_nc  char(1),
		@w_mensaje     varchar(30), --ref048
        @w_desc_canal   varchar(16),    -- GYC 2008/Ene/23
        @w_desc_servicio  varchar(5),
        @w_desc_empresa   varchar(32),
        @w_valor_debito   varchar(11),
        @w_cliente    int,
        @w_fecha_deb    varchar(10),
        @w_fecha_proc   datetime,
        @w_ssn      int,
        @w_categoria  char(1),    -- GYC 2012/Jun/27        
        @w_codigo      char(15),
        @w_rubro       char(6),
        @w_ndcta       money,
        @w_debito_BR   money,
        @w_offline     char(1),
        @w_ind_diferido char(1),
        @w_emp         varchar(6),
        @w_swvalmonto  varchar(1),
        @w_sinbase     char(1),
        @w_trx_orig    smallint,
        @w_id_detalle  smallint,        -- RDG 01/24/2003
        @w_fecha_hoy   varchar(10),     --- ame 04/28/2004
        @w_comision_serv money,         -- JPM 08112004
        @w_comision_sat  money,         -- JPM 08112004
        @w_accion_iva_cero     char(1),  /*JPM 08112004*/
        @w_accion_iva          char(1),  /*JPM 08112004*/
        @w_iva            float,         /*JPM 08112004*/
        @w_valor_iva      money,         /*JPM 08112004*/       
        @w_total_comision money,         /*JPM 08112004*/
        @w_numdeci        tinyint,       /*JPM 08112004*/
        @w_usadeci        char(1) ,       /*JPM 08112004*/
        @w_trn            smallint, --REF 14
        @w_causa            char(3),   --REF 14
        @w_servicio         char(6) , --REF 14
        @w_serie            varchar(6),   --REF 14
        @w_secuencian       int,          --REF 14
        @w_secuenciac       varchar(7),    --REF 14
        @w_base             money,    --REF 14
        @w_tipo_comp        varchar(6), --REF 14
        @w_comprobante      varchar(20), --REF 14
        @w_efec_atm         money,   --ref 15
        @w_efec_com_atm     money,  ---ref 15        
        @wi_total_comision  money,  --ref 15
        @w_tasa             money, --REF18
        @w_base_imp         float, --REF18
        @w_impuesto2        float, --REF18
        @w_ced_ruc          varchar(13), --REF18
        @w_causal           varchar(3), --REF18
        @w_correo               varchar(64),   --Ref 9 smerino
  @w_telefono             varchar(10),--Ref 9 smerino  
        @w_tipo_cta         char(3),             -- JPM Ref.26 -->
        @w_ssn_corr         int,
        @w_rows             int,
        @w_msg              varchar(200),
        @w_error            int,
        @w_detalle_error    descripcion,     -- <-- JPM Ref.26
     /*REF27 Inicio LBP */ 
     @w_valor_compensa   money,
     @w_comi_total       money,     
     @w_ofi              int,
     @w_com_original     money,
     @w_aplica_des       char(1),
    /*REF27 Fin LBP */
     @v_causa_deb        char(5),--Ref30
    --*******ref033 inicio
    @w_total            varchar(11),
    @w_comision_tran    varchar(11),    
    @w_control_mostrar  varchar(20), -->para no mostrar ciertos campos en la plantilla, Cargo Servicio Financiero/total para quienes no envíen estos datos
    @w_total_sms        varchar(11),
    @w_hora_deb         varchar(8),
    @w_wap_linea        char(1),
    @w_comision_avi24   char(1),
    --*******ref033 fin
    @w_nombre_cli       varchar(64) --Ref038:msilvag 
    

--*******ref033 inicio
    select @w_control_mostrar ='considera',
           @w_hora_deb = convert(varchar(8),getdate(),108),
           @w_wap_linea='N',@w_comision_avi24='N'
    

if @i_canal='WAP'
begin
    /*
      pg_wap_emp_mig_paglinea es catálogo exclusivo de Wap de empresas Públicas que empiezen a cobrar en linea
      Actualmente 07/03/2017, solo empresas MEER e Interagua, no utlizar otros canales
    */
   if exists(select  1  from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla
             where t.tabla='pg_wap_emp_mig_paglinea' and c.codigo=convert(varchar,@i_empresa) and estado='V' )
       select @w_wap_linea ='S'
end

if exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on c.tabla=t.codigo
where t.tabla='pg_canales_serbas_comision' and estado='V' and c.codigo=@i_canal)
   select @w_comision_avi24 ='S'

--*******ref033 fin

/* Captura nombre del Store Procedure */
select @w_sp_name = 'sp_pago_agua_rc'
select @s_date = convert(varchar(10),@s_date,101)
select @w_fecha_hoy = convert(varchar(10), getdate(),101)   --- ame 04/28/2004

/*REF27 Inicio LBP*/
if @i_canal = 'CNB' and @i_opcion = 'T'
   select @w_ofi = @s_ofi, @s_ofi = 0 
   else
   if @i_canal = 'VEN' and @i_opcion = 'T'
      select @w_ofi = @s_ofi
/*REF27 Fin LBP*/


select @w_fecha_deb = convert(varchar(10),getdate(),101)  -- GYC 2008/Ene/28  -- Fecha debito

select @w_fecha_proc = fp_fecha         -- GYC 2008/Ene/28  -- Fecha proceso
from cobis..ba_fecha_proceso

--ref vmirandt inicio
select @w_sinbase = 'N'  -->ref vmirandt inicialización de variable

-->Canal Wap tiene una validación independiente porque se utiliza la bandera desde el FE, donde se trata de no usar muchas validaciones
-->para consultas más rápidas desde el dispositivo movil
If(@w_wap_linea ='S'  and @i_canal = 'WAP') 
   select @w_sinbase = 'S'

if @w_sinbase = 'N' -->solo si es N entra a validar catálogo -->ref vmirandt
begin
    -- TPE verificar si la empresa registra base o no
    if exists (select 1
           from cobis..cl_tabla a, cobis..cl_catalogo b
           where a.tabla = 'sv_emp_serv_sb'
             and a.codigo = b.tabla
             and b.codigo = convert(varchar,@i_empresa)
             and b.estado = 'V' )
          select @w_sinbase = 'S'
end


--Ref037:msilvag Inicio
--Si el canal aun no ha hecho su cambio para consider la empresa de Agua en validacion de linea, debe estar en este catálogo
if exists(select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo=c.tabla 
           where t.tabla='pg_canal_no_linea_agua' and c.codigo =@i_canal and c.valor=convert(varchar,@i_empresa) and c.estado='V')
        select @w_sinbase = 'N'
--Ref037:msilvag Fin


--> OBTIENE HORA TOPE >
 select @w_hora_sys = convert(varchar(08),getdate(),108)
 select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
select @w_hora_tope = convert(int, (substring (b.valor,1,2) + substring (b.valor,4,2) + substring (b.valor,7,2)))
  from cobis..cl_tabla a, cobis..cl_catalogo b
 where a.tabla = 'sv_horario_serv'
   and a.codigo = b.tabla
   and convert(smallint,b.codigo) = @i_empresa
   and estado = 'V'

if (@@rowcount = 0 or @w_hora_tope = 0)
begin
    if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
    begin                                                                -- JLS 23/FEB/2001
        exec cobis..sp_cerror
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_msg           = 'PARAMETRO DE HORA TOPE NO DEFINIDA',
                @i_num           = 37601  --smerinom
        return 37601  --smerinom
    end                                                                  -- JLS 23/FEB/2001
    else                                                                 -- JLS 23/FEB/2001
        return 37601                                                       -- JLS 23/FEB/2001
end
--< HORA TOPE <

if @i_opcion = 'C'   -- Consulta
begin


    select  @o_nombre     = sc_nombre,
            @o_saldo      = sr_saldo,
            @o_minimo     = sr_minimo,
            @o_fecha_tope = sr_fecha_tope,
            @o_inddb      = sc_inddb,
            @w_id_detalle = sr_id_detalle
      from cob_pagos..pg_clien_servicio,
           cob_pagos..pg_saldo_servicio
     where sc_empresa = @i_empresa
       and sc_codigo  = convert(varchar,@i_codigo)
       and sc_empresa = sr_empresa
       and sr_tipo    = @i_proceso
       and sc_codigo  = sr_codigo

	if @@rowcount <> 1 and @w_sinbase = 'N'
    begin
		if @i_aplcobis = 'S'                                                -- JLS 23/FEB/2001
        begin                                                               -- JLS 23/FEB/2001
            exec cobis..sp_cerror
                    @t_from = @w_sp_name,
                    @i_msg = "CLIENTE NO EXISTE EN LA BASE",
                    @i_num = 34007  --smerinom
            return 34007 --smerinom
        end
        else                                                                -- JLS 23/FEB/2001
            return 34007  --smerinom                                                  -- JLS 23/FEB/2001
    end

	if @i_ind_costo <> 'N'                                                        -- JLS 14/MAR/2001{
    begin
        if @i_ind_costo = 'R'                                                  -- R Red
            select @w_rubro = '53'
        else
            select @w_rubro = '52'

        exec cob_pagos..sp_verif_genera_costo                               -- RCS 16/MAR/2001
                @s_date         = @s_date,
                @i_mon          = @i_mon,
                @i_rubro        = @w_rubro,
                @i_servicio     = 'CPSV',
                @i_tipocta      = @i_tipocta,
                @i_cuenta       = @i_cuenta,
                @o_costo        = @o_costo out
    end

   --REF 14 VALIDACION POR EMPRESA PARA SACAR COSTO INICIO
    if @i_empresa =  114
    begin
		if @o_saldo <=0
      	begin
            exec cobis..sp_cerror
                    @t_from = @w_sp_name,
                    @i_msg = "CLIENTE NO REGISTRA DEUDA EN LA BASE",
                    @i_num = 34020  --smerinom
            return 34020 --smerinom
      	end

        -- Busqueda de [V]alores de Comision
        exec cob_pagos..sp_verif_genera_costo
                @s_date         = @s_date,
                @i_mon          = @i_mon,
                @i_rubro        = 'TROR',
                @i_servicio     = 'CSBA',
                @i_canal        = @i_canal,
                @o_costo        = @o_costo out

		if  @o_costo > 0  --INI REF18
      	begin
          	--  busqueda de la tasa del iva parametrizada en el person
			exec @w_return = cob_pagos..sp_verif_genera_costo
			@s_date         = @s_date,
			@i_mon          = @i_mon,
			@i_rubro        = 'IVA',
			@i_servicio     = 'CSBA',
			@i_canal        = 'VEN',
			@i_tipocta      = '3',
			--@i_cuenta       = @i_cuenta,
			@o_costo        = @o_tasa out
			if @w_return <> 0
            	return @w_return

			if @o_tasa > 0
          	begin
				--llamar al sp que retorna el valor del iva ----
				exec  @w_return = cob_cuentas..sp_cal_impuesto
					@i_tasa   = @o_tasa,
					@i_valor_serv = @o_costo,
					@o_base_imp = @o_base_imp out,
					@o_impuesto = @o_impuesto out
				if @w_return <> 0
					return @w_return
               
				select @o_base_imp=@o_base_imp,@o_impuesto=@o_impuesto
			end
			else
            	select @o_base_imp = @o_costo, @o_impuesto = 0
		end --FIN REF18

	end
   --REF 14 VALIDACION POR EMPRESA PARA SACAR COSTO FIN

    -- verificar que las trx se realicen dentro del horario establecido y devolver a front end
    select @w_offline = atm_offline
	from cobis..ba_fecha_proceso

    select @o_fecha_efe = @s_date

    select @w_hora_sys = convert(varchar(08),getdate(),108)
    select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))

    if @w_hora >= @w_hora_tope and @w_offline = 'N' and @s_date = @w_fecha_hoy  --- ame 04/28/2004
    begin
        select @o_fecha_efe = min(dl_fecha)
          from cob_cuentas..cc_dias_laborables
         where dl_ciudad   = 1
           and dl_num_dias = 1
    end

    if @i_canal = 'VEN'
	begin
         /*JPM 108122004 Busqueda de parametros de IVA*/
         select @o_fecvensri = pa_char
         from cobis..cl_parametro
         where pa_nemonico = 'FECVAL'
            and pa_producto = 'CTE'

         if @@rowcount <> 1
         begin
            if @i_aplcobis = 'S'
            begin
              exec cobis..sp_cerror
                    @t_from = @w_sp_name,
                    @i_num = 101085
              return 101085
            end
            else
              return 101085
         end

         select @o_autorisri = pa_char
         from cobis..cl_parametro
         where pa_nemonico = 'NUMAUT'
            and pa_producto = 'CTE'

         if @@rowcount <> 1
         begin
            if @i_aplcobis = 'S'
            begin
              exec cobis..sp_cerror
                    @t_from = @w_sp_name,
                    @i_num = 101085
              return 101085
            end
            else
              return 101085
         end
         /*JPM 08122004 Fin Busqueda de parametros de IVA*/


         /*JPM Busqueda de Valores de Comisión*/
		exec @w_return = sp_verif_comision_sat
		  @i_mon          = @i_mon,
		  @i_servicio     = 'AGU',
		  @i_empresa      = @i_empresa,
		  @i_canal        = @i_canal,
		  @i_aplcobis     = @i_aplcobis,
		  @i_cod_producto = 4,
		  @o_costo        = @o_comisionven out
		if @w_return <>0
            return @w_return

		if @i_empresa <> 114 --Ref021:msilvag = 361  --DAPV REF 17
		begin
           
            
            --ini ref 34
			select @w_servicio = pe_cod_serv,
				   @w_rubro = pe_rubro
			from cob_pagos..pg_person_empresa
			where pe_empresa  = @i_empresa
	    	--fin ref 34

			exec @w_return = cob_pagos..sp_verif_genera_costo
				  @s_date         = @s_date,
				  @i_mon          = @i_mon,
				  @i_rubro        = @w_rubro,
				  @i_servicio     = @w_servicio,
				  @i_tipocta      = @i_tipocta,
				  @i_cuenta       = @i_cuenta,
				  @o_costo        = @o_comisionven out,
				  @i_oficina      = @s_ofi,
				  @i_ubicacion    = @i_ubi,
				  @i_canal        = @i_canal
			if @w_return <> 0
				return @w_return

			if  @o_comisionven > 0  --INI REF18
			begin
				--  busqueda de la tasa del iva parametrizada en el person
				exec @w_return = cob_pagos..sp_verif_genera_costo
					@s_date         = @s_date,
					@i_mon          = @i_mon,
					@i_rubro        = 'IVA',
					@i_servicio     = @w_servicio, --'CSBA',
					@i_canal        = 'VEN',
					@i_tipocta      = '3',
					--@i_cuenta       = @i_cuenta,
					@o_costo        = @o_tasa out

                  if @w_return <> 0
                    return @w_return

                  if @o_tasa > 0
                  begin
                      --llamar al sp que retorna el valor del iva ----
                      exec  @w_return = cob_cuentas..sp_cal_impuesto
                        @i_tasa   = @o_tasa,
                        @i_valor_serv = @o_comisionven,
                        @o_base_imp = @o_base_imp out,
                        @o_impuesto = @o_impuesto out

                      if @w_return <> 0
                     return @w_return
                     
                    select @o_base_imp =@o_base_imp,@o_impuesto = @o_impuesto --smerino
                  end
                  else
                      select @o_base_imp = @o_comisionven,@o_impuesto = 0

              end --FIN REF18

            end --if @i_empresa = 361

       end
       
end

if @i_opcion = 'T'   -- Transaccion de Cobro
begin   

    select @w_ind_diferido = 'N'

    select @w_offline = atm_offline
      from cobis..ba_fecha_proceso

    select @o_fecha_efe = @s_date

    -- Modifica RCA 10/sep/2001
    -- Validar Montos de la retenci+n
    if @i_reten > 0 and @i_comprob = null
    begin
        exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_msg    = "Ingrese Codigo del Comprobante de retencion",
                @i_num    = 34000 --smerinom
        return 34000  --smerinom
    end

    if @i_reten > 0 and @i_empresa <> 361
    begin
        exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_msg    = "No se Puede recibir Pagos en Retenciones para esta Empresa",
                @i_num    = 34021  --smerinom
        return 34021  --smerinom
    end

    if @t_corr = 'S'
    begin
    
		if @t_ssn_corr is null or  @t_ssn_corr =0
		begin
			exec cobis..sp_cerror
				@t_debug         = @t_debug,
				@t_file          = @t_file,
				@t_from          = @w_sp_name,
				@i_msg           = 'NO EXISTE TRANSACCIÓN ORIGINAL',
				@i_num           = 34014 --smerinom
			return 34014 --smerinom
		end
        
		--Ref035:msilvag Inicio
		if not exists(select 1 from cob_cuentas..cc_tran_servicio
				where ts_secuencial = @t_ssn_corr 
				and ts_tipo_transaccion in(3137,3201, 3925, 3926, 3927) --Ref045:msilvag 
				and ts_causa = convert(varchar,@i_empresa) --Ref045:msilvag 
				and ts_tsfecha = @s_date )
		begin
			exec cobis..sp_cerror
				@t_debug         = @t_debug,
				@t_file          = @t_file,
				@t_from          = @w_sp_name,
				@i_msg           = 'NO EXISTE TRANSACCIÓN ORIGINAL',
				@i_num           = 34014
			return 34014
		end
		--Ref035:msilvag Fin

        
	    if @w_hora >= @w_hora_tope and
	       @t_corr = 'S'  and @s_date = @w_fecha_hoy  
	    begin
			select @w_ind_diferido = 'S'
			
			--Ref045:msilvag Inicio
			if @i_empresa = 8269
				select @t_trn = 3925
			else
				select @t_trn = 3201
			--Ref045:msilvag Fin
			
			select @o_fecha_efe = min(dl_fecha)
			  from cob_cuentas..cc_dias_laborables
			 where dl_ciudad = 1
			   and dl_num_dias = 1
	    end    
    
        select @w_factor = -1

        select @w_trx_orig = ts_tipo_transaccion    -- identifica trx original
            from cob_cuentas..cc_tran_servicio
           where ts_tsfecha = @s_date
             and ts_secuencial = @t_ssn_corr
             and ts_tipo_transaccion in(3137,3201, 3925, 3926, 3927) --Ref045:msilvag
             and ts_causa = convert(varchar,@i_empresa) --Ref045:msilvag 

		if @@rowcount <> 0
			select @t_trn = @w_trx_orig
            

	  ---REF 33
		if @w_hora >= @w_hora_tope  and @s_date = @w_fecha_hoy  and (@t_trn <> 3201 or @t_trn <> 3927) --Ref046:msilvag 
		begin
			exec cobis..sp_cerror
				@t_debug         = @t_debug,
				@t_file          = @t_file,
				@t_from          = @w_sp_name,
				@i_msg           = 'NO SE PUEDE REVERSAR UNA TRANSACCION DE HORARIO NORMAL EN HORARIO DIFERIDO',
				@i_num           = 34014 --smerinom
			return 34014 --smerinom
		end
	 ---REF 33
   
	end
    else
        select @w_factor =  1


    -- Valida si se ha aperturado caja
    if @s_org = 'U' and
       @i_aplcobis = 'S' and
       @i_canal = 'VEN'                -- GMD 10/ABR/2003
    begin
        exec @w_return = cob_remesas..sp_verifica_caja_rc
                @s_ssn   = @s_ssn,
                @s_srv   = @s_srv,
                @s_lsrv  = @s_lsrv,
                @s_user  = @s_user,
                @s_term  = @s_term,
                @s_date  = @s_date,
                @s_ofi   = @s_ofi,
                @s_rol   = @s_rol,
                @s_sev   = @s_sev,
                @s_msg   = @s_msg,
                @s_org   = @s_org,
                @t_trn   = @t_trn,
                @t_corr  = @t_corr,             --- ame 11/21/2003
                @i_mon   = @i_mon,
                @i_ubi   = @i_ubi,              --- ame 11/13/2003
                @o_horario = @o_horario out     --- TPE Horario Tran

        if @w_return != 0
            return @w_return
    end


   --REF048 JG:INI
   if @t_corr = 'N'
   begin 
	   select @w_empresa = convert(char(6),@i_empresa)
	   
	   exec @w_return = cob_pagos..pa_pg_pval_serv_pub
				@e_empresa		= @w_empresa,
				@e_valorEfe		= @i_efe,
				@e_valorDeb	 	= @i_debito,
				@e_valorChq	 	= @i_valch,
				@e_valorTC	 	= 0,
				@e_comision_Efe = @i_efe_com,
				@e_comision_Deb	= @i_deb_com,	
				@e_comision_Chq = @i_chq_com,
				@e_comision_TC  = 0,
				@e_canal	    = @i_canal,
				@e_suministro   = @i_codigo
			if @w_return <> 0
			begin
					
				select @w_mensaje = ltrim(rtrim(mensaje))  
				from cobis..cl_errores 
				where numero  = 70007

				if @i_aplcobis = 'S'
					exec cobis..sp_cerror
						@t_debug         = @t_debug,
						@t_file          = @t_file,
						@t_from          = @w_sp_name,
						@i_msg           = @w_mensaje,
						@i_num           = @w_return
					
				return @w_return
			end 
	end
		
	--REF048 JG:FIN	
		   
    --> ESTABLEZCO HORARIO DE PAGO >
    select @w_hora_sys = convert(varchar(08),getdate(),108)
    select @w_hora = convert(int, (substring (@w_hora_sys,1,2) + substring (@w_hora_sys,4,2) + substring (@w_hora_sys,7,2)))
        
        
    if @w_hora >= @w_hora_tope and
       @t_corr = 'N' and
       @i_autoriza = 'N' and
       @w_offline = 'N'  and @s_date = @w_fecha_hoy  --- ame 04/28/2004
    begin
        select @w_ind_diferido = 'S'
        --Ref045:msilvag Inicio
        if @i_empresa = 8269
        	select @t_trn = 3927
        else
        	select @t_trn = 3201
		--Ref045:msilvag Fin
		
		select @o_fecha_efe = min(dl_fecha)
		from cob_cuentas..cc_dias_laborables
		where dl_ciudad = 1
		and dl_num_dias = 1
    end
    else
    begin
		if @i_canal = "VEN" and @t_corr = 'N'
		begin
			if @o_horario = "D"
			begin
				--Ref045:msilvag Inicio
				if @i_empresa = 8269
					select @t_trn = 3926, @w_ind_diferido = 'S'
				else
				begin
				--Ref045:msilvag Fin
					if @i_valch > 0
					begin
						select @w_ind_diferido = 'S'
						select @t_trn = 3201

						select @o_fecha_efe = min(dl_fecha)
						from cob_cuentas..cc_dias_laborables
						where dl_ciudad = 1
						and dl_num_dias = 1
					end
					else
						select @t_trn = 3137
				end --Ref045:msilvag
			end
            --Ref037:msilvag Inicio
			else
			begin
				--Ref045:msilvag Inicio
				if @i_empresa = 8269
					select @t_trn = 3925
				else
					select @t_trn = 3137
            end --Ref045:msilvag Fin
		end
        --Ref037:msilvag Inicio
		else
		begin
			if @t_corr = 'N'
			--Ref045:msilvag Inicio
			begin
				if @i_empresa = 8269
					select @t_trn = 3925
				else
					select @t_trn = 3137
			end
			--Ref045:msilvag Fin
		end
        --Ref037:msilvag Fin
	end
    --< HORARIO DE PAGO <
     
     
    --REF 14  ASIGNACION DE VARIABLES PARA EMPRESA TRIPLE ORO INICIO
    select @w_codigo = null
    if @t_trn = 3137
         select  @w_trn = 3366 , @w_causa ="8"
        if @t_trn = 3201
         select  @w_trn = 3372 , @w_causa ="8"

        select @w_codigo = convert(varchar,@i_codigo)
    --REF 14  ASIGNACION DE VARIABLES PARA EMPRESA TRIPLE ORO FIN


    -- validar que la NC no se haya realizado
    select @w_control_nc = b.valor
      from cobis..cl_tabla a, cobis..cl_catalogo b
     where a.tabla = 'sv_nc_servicios'
       and a.codigo = b.tabla
       and convert(smallint,b.codigo) = @i_empresa
       and estado = 'V'
    if @w_control_nc = 'S' and @w_ind_diferido = 'N'
    begin
        if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
        begin                                                                -- JLS 23/FEB/2001
            exec cobis..sp_cerror
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_msg           = 'CREDITO A EMPRESA YA REALIZADO NO SE PUEDEN REALIZAR TRX',
                @i_num           = 37603  --smerinom
            return 37603  --smerinom
        end
        else                                                                 -- JLS 23/FEB/2001
            return 37603                                                       -- JLS 23/FEB/2001
    end


    -- Rutina que realiza verificacion de moneda de la cuenta
    exec @w_return = cob_cuentas..sp_convierte_valor
            @i_valor  = @i_efe,
            @i_val2   = @i_valch,
            @i_moneda = @i_mon,
            @o_val_usd_neto = @w_val_usd out,
            @o_val_usd_val2 = @w_valch_usd out
    if @w_return != 0
    begin
        if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
        begin                                                                -- JLS 23/FEB/2001
             exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'ERROR EN LA RUTINA DE CONVERSION',
                 @i_num           = 37607  --smerinom
             return 37607  --smerinom
        end
        else                                                                 -- JLS 23/FEB/2001
             return 37607                                                       -- JLS 23/FEB/2001
    end

    exec @w_return = cob_cuentas..sp_convierte_valor
         @i_valor  = @i_debito,
         @i_val2   = @i_reten,
         @i_moneda = @i_mon,
         @o_val_usd_neto = @w_debito_usd out,
         @o_val_usd_val2 = @w_reten_usd out

    if @w_return != 0
    begin
        if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
        begin                                                                -- JLS 23/FEB/2001
             exec cobis..sp_cerror
                 @t_debug         = @t_debug,
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name,
                 @i_msg           = 'ERROR EN LA RUTINA DE CONVERSION',
                 @i_num           = 37607 --smerinom
             return 37607  ---smerinom
        end
        else
            return 37607                                                        -- JLS 23/FEB/2001
    end



      select @w_accion_iva      = 'N',  -- 1era salida a produccion no cobrara iva
             @w_accion_iva_cero = 'N'

      -- calcular valor del iva
      if @w_accion_iva = 'S' and @w_accion_iva_cero ='N'
         begin
           /* Determinar el valor del IVA  */
           select @w_iva  = pa_float
           from cobis..cl_parametro
           where pa_producto = 'CTE'
                 and pa_nemonico = 'IVA'
           if @@rowcount <> 1 or @w_iva <= 0
              begin
                exec cobis..sp_cerror
                          @i_num  = 888888,
                          @i_msg  = 'ERROR EN LA LECTURA DEL VALOR IVA',
                          @i_sev  = 1
                return 888888
              end
         end
      /* DETERMINAR EL NUMERO DE DECIMALES A UTILIZAR (DSC970901) */
      select @w_usadeci = mo_decimales
        from cobis..cl_moneda
       where mo_moneda = @i_mon
      if @w_usadeci = 'S'
         select @w_numdeci = pa_tinyint
           from cobis..cl_parametro
          where pa_nemonico = 'DCI'
            and pa_producto = 'CTE'
      else
         select @w_numdeci = 0

    ----------------------------------------------
    -- Comision por pago servicio JPM 05112004
    ----------------------------------------------
    select @w_comision_serv = 0, @w_comision_sat = 0
    -- si canal es VEN calcular comision a partir del SAT,
    -- por los otros canales calcular comision deacuerdo al desglose de pago
    
    --Ref043:msilvag Inicio
    if @i_canal = 'SAT' and  (@i_empresa  = 361 or @i_empresa  = 8269) --ref047
    	select @i_comision = @i_deb_com
    --Ref043:msilvag Fin
    
    
    if @i_canal in ('VEN','CNB','SAT') --Ref043:msilvag  --SMERINO AUMENTA CANAL CNB
    begin
         if @i_ind_costo <> 'R' --and @t_corr = 'S'
            select @w_comision_sat = @i_comision
    end
    else
    begin
         -- existe debito, buscar valor de la comision (Person-Cobis)
        if @i_tipocta in ('CTE', 'AHO','PAG') and @w_debito_usd > 0 and @i_ind_costo <> 'R' -- REF 31
        begin

            --Ref021:msilvag Inicio ASIGNACION DE VARIABLES PARA BUSCAR COSTO INICIO    
            if @i_empresa = 360
                select @w_rubro  = 'CCAQ' , @w_servicio  = 'CSBA'  --EMMAPQ 'CEAQ'
            else
              if @i_empresa = 6
                select @w_rubro  = 'CCAM', @w_servicio  = 'CSBA'  --AMAGUA
              else
                if @i_empresa = 4
                  select @w_rubro  = 'CCAP', @w_servicio  = 'CSBA' --Aguapen
                else
                  if @i_empresa  = 361
                  begin
	                select @w_rubro  = 'INAG', @w_servicio  = 'CSBA'  --cOBRO DE COMISION DE AGUA
                    --DOS, REF 29 Inicio
                    if @i_canal = 'DBA' 
                         select  @i_canal = 'DIR'
                    --DOS, REF 29 Fin
                  end
                else
                    if @i_empresa  = 114
                      select @w_rubro  = 'TROR', @w_servicio  = 'CSBA'
                    else
                        select @w_rubro  = 'AGUA', @w_servicio  = 'CSBA'
            --Ref021:msilvag Fin ASIGNACION DE VARIABLES PARA BUSCAR COSTO INICIO

            --ref 34
            select @w_servicio = pe_cod_serv,
                  @w_rubro = pe_rubro
            from cob_pagos..pg_person_empresa
            where pe_empresa  = @i_empresa
            --ref 34
	    
            exec @w_return = cob_pagos..sp_verif_genera_costo
                @s_date         = @s_date,
                @i_mon          = @i_mon,
                @i_rubro        = @w_rubro,
                @i_servicio     = @w_servicio,
                @i_tipocta      = @i_tipocta,
                @i_cuenta       = @i_cuenta,
                @o_costo        = @w_comision_serv out,
                @i_oficina      = @s_ofi,
                @i_ubicacion    = @i_ubi,
                @i_canal        = @i_canal
            if @w_return <> 0
                return @w_return
        end
          
          -- existe efectivo y/o cheque, buscar valor comison (SAT)
        if (@i_efe + @i_valch)>0 and @i_ind_costo <> 'R'
        begin
              exec sp_verif_comision_sat
                   @i_mon          = @i_mon,
                   @i_servicio     = 'AGU',
                   @i_empresa      = @i_empresa,
                   @i_canal        = @i_canal,
                   @i_aplcobis     = @i_aplcobis,
                   @i_cod_producto = 4,
                   @o_costo        = @w_comision_sat out
        end                						   		
    end
       
       if @i_canal = 'ATM' and @i_tipocta = 'EFE'  --REF 34
          select @w_total_comision = @i_efe_com
       else
          select @w_total_comision = @w_comision_serv + @w_comision_sat

    -- fin cobro comision pago servicio JPM 05112004

    select @w_monto = @w_val_usd + @w_valch_usd + @w_debito_usd + @w_reten_usd
    --if @i_canal = 'VEN'  -- REF 17
    --begin
      --if @i_empresa  <> 114   --REF 14
         --select @w_monto = @w_monto - isnull(@w_total_comision,0) --JPM 15112004
    --end

    if @i_autoriza = 'N' and  @t_corr = 'N'
    begin
        select @w_maximo_p = pa_money
          from cobis..cl_parametro
         where pa_nemonico = 'MSVP'
           and  pa_producto = 'CTE'

        if (@w_maximo_p <= @w_monto)
        begin
            if @i_aplcobis = 'S'
            begin
                exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 311819
                return 311819
            end
            else                                                          -- JLS 23/FEB/2001
                return 37608                                                -- JLS 23/FEB/2001
        end
    end

    -- valida montos
    select @w_swvalmonto = isnull(b.valor,'S')
      from cobis..cl_tabla a, cobis..cl_catalogo b
     where a.tabla = 'sv_empser_noval'
       and a.codigo = b.tabla
       and b.codigo = convert(varchar,@i_empresa)
    if @@rowcount = 0
        select @w_swvalmonto = 'S'

    --TPE control para empresas que tienen base
    --if @w_sinbase = 'N' incluir interagua linea
    if @w_sinbase = 'N' or @i_proceso <> 'F' --ariofria Ref 30 incluir interagua linea
    begin
         if @w_sinbase = 'N' and @i_proceso = 'F' --control solo para empresas en base.
         begin		 

         select @o_nombre     = sc_nombre, 
                --@o_saldo    = sr_saldo - @w_monto, -- RCA 17/SEP/2001
                @o_saldo      = sr_saldo,
                @o_minimo     = sr_minimo,
                @w_id_detalle = sr_id_detalle,
                @w_base       = sr_base_imp,  --REF 14
                @w_tipo_comp  =  sr_tipo_comp,--REF 14
                @w_comprobante =  sr_num_comp --REF 14
         from cob_pagos..pg_clien_servicio,
              cob_pagos..pg_saldo_servicio
         where sc_empresa = @i_empresa
           and sc_codigo  = convert(varchar,@i_codigo)
           and sc_empresa = sr_empresa
           and sr_tipo    = @i_proceso
           and sc_codigo  = sr_codigo		   		 

         if (round(@w_monto,2) <> round(@o_minimo,2) and round(@w_monto,2) <> round(@o_saldo,2)) and @t_corr = 'N' and @w_swvalmonto = 'S'
         begin  -- si los montos no coinciden y es una operacion normal y no es una llamada de rec de mov a L1
            if @s_org <> 'D' or @i_canal = 'CNB'
               if @i_aplcobis = 'S' 
               begin
                     exec cobis..sp_cerror
                         @t_from = @w_sp_name,
                         @i_msg = "VALOR DE PAGO NO COINCIDE CON MONTOS DE BASE",
                         @i_num = 34022  --smerinom
                     return 34022  --smerinom
               end
               else
                  return 34022  --smerinom
         end

         if @w_swvalmonto = 'R' and not (@w_monto >= @o_minimo and @w_monto <= @o_saldo) and @t_corr = 'N'
         begin  -- si monto de pago no coinciden en el rango de min y max
            if @s_org <> 'D' or @i_canal = 'CNB'
               if @i_aplcobis = 'S'
               begin
                  exec cobis..sp_cerror
                         @t_from = @w_sp_name,
                         @i_msg = "MONTO DE PAGO NO COINCIDE CON RANGOS MONTOS DE BASE",
                         @i_num = 34023  --smerinom
                  return 34023 --smerinom
               end
               else
                  return 31183
         end
         		 
         if @w_swvalmonto = 'I' and not (@w_monto >= @o_minimo) and @t_corr = 'N'
         begin  -- para pagos que validen solo el minimo
            if @s_org <> 'D' or @i_canal = 'CNB'
               if @i_aplcobis = 'S'
               begin
                  exec cobis..sp_cerror
                         @t_from = @w_sp_name,
                         @i_msg = "MONTO DE PAGO DEBE SER MAYOR O IGUAL AL MINIMO",
                         @i_num = 34024  --smerinom
                  return 34024  --smerinom
               end
               else
                  return 34024 --smerinom
         end
   end --fin control solo empresas en base ariofria  REF 30 
  
   
    if @o_nombre = null or @o_nombre = '' --REF 30 ariofria si empresa no es en base se asigna nombre que ingresa como parametro
	begin
	  select @o_nombre =  @i_nombre
    end     
    
    exec @w_return = cobis..sp_cseqnos
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_tabla  = 'ts_luz',
      @o_siguiente = @w_secuencial out
    if @w_return != 0
        return @w_return   
            
    -- Modifica RCA 17/SEP/2001
    select @o_saldo = @o_saldo - @w_monto
    -- Fin MOdifica RCA 17/Sep/2001
    begin tran
        if @w_sinbase = 'N' and @i_proceso = 'F' --ariofria REF 30 actualización saldo empresas en base.
        begin 	   

            update cob_pagos..pg_saldo_servicio
            set 
                sr_saldo = sr_saldo - (@w_monto * @w_factor),
                sr_minimo = sr_minimo - (@w_monto * @w_factor),
                sr_fecha_pag = @s_date
            where sr_empresa = @i_empresa
            and sr_tipo    = @i_proceso 
            and sr_codigo = convert(varchar,@i_codigo)
            if @@rowcount <> 1
            begin
                if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
                begin                                                                -- JLS 23/FEB/2001
                   exec cobis..sp_cerror
                        @t_from = @w_sp_name,
                        @i_msg = "ERROR EN LA ACTUALIZACION DEL SALDO",
                        @i_num = 34017  --smerinom
                   return 34017  --smerinom
                end
                else                                                                 -- JLS 23/FEB/2001
                begin                                                                -- GMD 10/ABR/2003
                   rollback tran                                                      -- GMD 10/ABR/2003
                   return 34017    --smerinom                                                    -- JLS 23/FEB/2001
                end                                                                  -- GMD 10/ABR/2003
            end
        end --ariofria REF 30 fin actualización saldo empresas en base.
    end --fin control que tienen base

      

    --Ref037:msilvag Inicio
    if @w_secuencial is null or @w_secuencial = 0
    begin
        exec @w_return = cobis..sp_cseqnos
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_tabla  = 'ts_luz',
              @o_siguiente = @w_secuencial out
        if @w_return != 0
        begin
            if @@trancount > 0
                rollback tran
            
            return @w_return  
        end
    end
    --Ref037:msilvag Fin

      select @w_ndcta = @w_debito_usd + @i_costo
      /*JPM 08112004*/
      if @i_canal <> 'VEN'
      begin
         --select @w_ndcta = @w_ndcta + @w_total_comision  --smerinom ojo cambio por inconsitencia en valores
         --select @i_deb_com = @w_total_comision    ---smerinom
         select @w_ndcta = @w_ndcta 
      end

      -- JPM Ref.06: -->
      -- Anticipar query, para usar para validar si se procesa Cta AHO/BAS
      if @w_debito_usd > 0  or  @i_deb_com > 0  --Ref 36 
      begin
        select @w_tipo_cta = null
        select @w_error = 0
        if @i_tipocta = 'CTE'
        begin
          select @w_tipo_cta = @i_tipocta
          select @w_cliente = cc_cliente,
                 @w_categoria = cc_categoria        -- GYC 2012/Jun/27
           from cob_cuentas..cc_ctacte
          where cc_cta_banco = @i_cuenta
          if @@rowcount = 0
            select @w_error = 31004
        end
        else
        if @i_tipocta in ('AHO', 'PAG')
        begin
         select @w_cliente   = ah_cliente,
                @w_categoria = ah_categoria,
                @w_tipo_cta  = @i_tipocta
          from cob_ahorros..ah_cuenta
          where ah_cta_banco = @i_cuenta
         select @w_rows = @@rowcount
         if @w_rows = 0
           if @i_canal in ('CNB', 'ATM', 'IBK','DBA','DIR') --DOS, REF 29
           begin            
            select @w_cliente   = vi_cliente,
                   @w_categoria = vi_categoria,
                   @w_tipo_cta  = 'BAS'
             from cob_virtuales..vi_cuenta
             where vi_cta_banco = @i_cuenta and vi_prod_banc = 13
            select @w_rows = @@rowcount
           end
         if @w_rows = 0
          select @w_error = 41001
        end
       else
         select @w_error = 30073
       if @w_error <> 0
       begin
         select @w_msg = mensaje
          from cobis..cl_errores
          where numero = @w_error
         if @i_aplcobis = 'S'
             exec cobis..sp_cerror
                   @t_from   = @w_sp_name,
                   @i_msg    = @w_msg,
                   @i_num    = @w_error
         return @w_error
       end
       select @w_tipocta = substring(@w_tipo_cta, 1, 1)        -- incluir cta bas
     end
     -- <--- JPM Ref.06

      if @i_tipocta = 'CTE' and @w_debito_usd > 0 and @i_ind_costo <> 'R'
         begin
		 
			--Ref30 ini
			select @v_causa_deb = b.valor	--ref032 pricaura
			 from cobis..cl_tabla a, cobis..cl_catalogo b
			 where a.tabla = 'causa_nd_cte_servicios'
			 and a.codigo = b.tabla
			 and b.codigo = convert(varchar,@i_empresa)
			 and estado = 'V'
			 
			if @@rowcount = 0 or (@v_causa_deb = null or @v_causa_deb = ' ')  --ref 34
			begin
				if @i_aplcobis = 'S'
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
					@i_num   = 158693
			 
			 	return 158693			
			end
			--Ref30 fin
			--ref032 pricaura ini
			--if @@rowcount = 0
			--	select @v_causa_deb = '149'
			--ref032 pricaura fin
			
		 
            exec @w_return = cob_cuentas..sp_ccndc_automatica
                 @s_srv          = @s_srv,
                 @s_ofi          = @s_ofi,
                 @s_ssn          = @s_ssn,
                 @s_user         = @s_user,
                 @s_term         = @s_term,
                 @t_corr         = @t_corr,
                 @t_trn          = 3050,
                 @i_cta          = @i_cuenta,
                 @i_val          = @w_ndcta,
                 @i_cau          = @v_causa_deb,	--Ref30
                 @i_mon          = 1,
                 @i_ref          = @w_codigo,
                 @i_fecha        = @s_date,
                 @i_nchq         = @t_ssn_corr,
                 @i_aplcobis     = @i_aplcobis,
                 @s_rol          = @s_rol,
                 @i_ubi          = @i_ubi,
                 @i_tsn          = @i_tsn,
                 @i_detalle    = @w_codigo

            if @w_return <> 0
            begin
               rollback tran              --WRP20020625

               return @w_return
            end
            else
               begin
                  -- Llamado a sp cob_internet..sp_eventos por Alert Manager    -- GYC 2008/Ene/23

                  -- Descripcion de Servicio
                  if @t_corr = 'N'
                     begin
                        select @w_desc_servicio = 'PAGSB',
                               @w_ssn = @s_ssn
                     end
                  else
                     begin
                        select @w_desc_servicio = 'PAGSR',
                             @w_ssn = @t_ssn_corr
                     end

                  -- Descripcion de Canal
                  --Ref021:msilvag Inicio
                  
                  if @i_canal = 'ATM'
                     select @w_desc_canal = 'VEINTI4EFECTIVO'
                  else
                    if @i_canal in ('DBA','DIR') --DOS, REF 29
                        select @w_desc_canal = 'AUTOMATICO'
                    else
                      if @i_canal = 'IBK'
                          select @w_desc_canal = '24online' --Ref 39
                      else
                        if @i_canal = 'IVR'
                            select @w_desc_canal = 'VEINTI4FONO'
                        else
                          if @i_canal = 'KSK'
                              select @w_desc_canal = 'PUNTOVEINTI4'
                          else
                            if @i_canal = 'VEN'
                                select @w_desc_canal = 'VENTANILLA'
                            else
                              if @i_canal = 'WAP'
                                  select @w_desc_canal = 'WAP'
                              else
                                if @i_canal = 'CNB'
                                    select @w_desc_canal = 'CNB'
                                else
		                  if @i_canal = 'SAT' --ref047
		                      select @w_desc_canal = 'SAT'
      --Ref021:msilvag Fin
                  -- Descripcion de Empresa

                  select @w_desc_empresa = substring(b.valor,1,32)
                      from cobis..cl_tabla a, cobis..cl_catalogo b
                      where a.tabla = 'sv_empresas_agua'
                        and a.codigo = b.tabla
                          and convert(int,b.codigo) = @i_empresa

                  select @w_valor_debito = convert(varchar(11),@w_ndcta)

                 
           
          
           --- smerino llamado al sp que extrae CEL e email
	  exec  @w_return = cob_pagos..sp_consulta_celular
	  	@i_cliente = @w_cliente,
	  	@o_celular = @w_telefono  out,
		@o_correo=@w_correo  out
	  
	  	if @w_return <> 0
	        begin
	        	if @@trancount > 0
	            		rollback tran
	            		
	                return @w_return
          	end
          
         ---smerino
         --ref033 inicio
         select @w_total = convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ isnull(@w_total_comision,0))),
                @w_comision_tran = convert(varchar,isnull(@w_total_comision,0))
         
         if ((@i_canal ='WAP' and @w_wap_linea ='S') 
           or @w_comision_avi24='S') -->bandera indica canal envia comision
           select @w_total_sms       = @w_total
                   
         else         
            select @w_total_sms     = @w_valor_debito,@w_control_mostrar =''

         --ref033 fin
         
        --Ref037:msilvag Inicio
        --if @i_empresa = 6 -- Ref41
            select @w_nombre_cli = isnull(@o_nombre,@i_nombre)  --Ref038:msilvag
            --select @o_nombre = @i_nombre
        --Ref037:msilvag Fin
        
        	--ini ref44
        	--if @i_canal not in ( 'DBA','DIR') --KBastida RECM-546
        	
         	select @o_servicio_not = @w_desc_servicio,
         	       @o_nomb_ente = @w_nombre_cli,
         	       @o_cod_ente = convert(varchar(20),@w_cliente),
         	       @o_desccanal = @w_desc_canal,         	       
         	       @o_celular = @w_telefono,
         	       @o_correo  = @w_correo,
         	       @o_desc_empresa = @w_desc_empresa,
         	       @o_prod_deb = 'CTE',
         	       @o_valor = @w_valor_debito,
         	       @o_fecha_deb = @w_fecha_deb,
         	       @o_hora_deb = @w_hora_deb,
         	       @o_valor_comi = @w_comision_tran,
       		       @o_valor_tot = @w_total,
       		       @o_cta_lat = substring(@i_cuenta,8,3)
       		 
         	  --fin ref44
         	       
         		
                 /* exec  @w_return = cob_internet..sp_eventos
                      @i_operacion    = 'I',
                      @i_fecha        = @w_fecha_deb,
                      @i_retardo      = 'S',
                      @i_fecha_tope   = @w_fecha_proc,
                      @i_cliente      = @w_cliente,
                      @i_servicio     = @w_desc_servicio,
                      @i_producto     = 3,
                      @i_prod_deb     = 'CTE',
                      @i_cuenta       = @i_cuenta,
                      @i_empresa      = @w_desc_empresa,
                      @i_desc_servicio= 'AGUA',
                      @i_nombre       = @w_nombre_cli ,  --Ref038:msilvag @o_nombre,
                      @i_planilla     = @i_codigo,
                      @i_valor        = @w_valor_debito,
                      @i_canal        = @i_canal,
                      @i_desc_canal   = @w_desc_canal,
                      @i_ssn          = @w_ssn,
                      @i_categoria_cta= @w_categoria,
                      @i_mail          =@w_correo , --smerino
                      @i_telefono      =@w_telefono,  ---smerino-- GYC 2012/Jun/27
                      @i_motivo       = 'AGUA',
                      --ref033 inicio
                      @i_valor1       =@w_hora_deb,
                      @i_valor2       =@w_comision_tran, -->comision de la TRANSACCIÓN
                      @i_minimo       =@w_total,         -->Valor de deuda + comision de la TRANSACCIÓN
                      @i_cta          =@w_total_sms,     -->Para mostrar en sms, ya tiene validado si tiene agregada la Comisión o no
                      @i_tarjeta      =@w_control_mostrar -->indicador para mostrar nuevos campos en plantilla, ya validado
                      --ref033 fin

      if @w_return <> 0
         begin
           rollback tran
           return @w_return
         end
         
         */
               end
         end


      if @i_tipocta in ('AHO', 'PAG') and @w_debito_usd > 0 and @i_ind_costo <> 'R'   -- JPM Ref.26: agregar 'PAG'
      begin
         if @w_tipo_cta = 'AHO'                                        -- JPM Ref.26
         begin
			
			--Ref30 ini
	   select @v_causa_deb = b.valor	--ref032 pricaura
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'causa_nd_aho_servicios'
            and a.codigo = b.tabla
            and b.codigo = convert(varchar,@i_empresa)
            and estado = 'V'
            
	    if @@rowcount = 0 or (@v_causa_deb = null or @v_causa_deb = ' ')  --ref 34
	    begin
		if @i_aplcobis = 'S'
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
			@i_num   = 158693
			 
		return 158693			
	   end
            
			--Ref30 fin
			--ref032 pricaura ini
			--if @@rowcount = 0
			--	select @v_causa_deb = '114'
			--ref032 pricaura fin
		 
            exec @w_return = cob_ahorros..sp_ahndc_automatica
                 @s_srv          = @s_srv,
                 @s_ofi          = @s_ofi,
                 @s_ssn          = @s_ssn,
                 @s_user         = @s_user,
                 @s_term         = @s_term,
                 @t_trn          = 4264,
                 @t_corr         = @t_corr,
                 @i_cta          = @i_cuenta,
                 @i_val          = @w_ndcta,
                 @i_cau          = @v_causa_deb,	--Ref30
                 @i_mon          = 1,
                 @i_ref          = @w_codigo,
                 @i_fecha        = @s_date,
                 @i_referen      = @t_ssn_corr,
                 @i_aplcobis     = @i_aplcobis,
                 @s_rol          = @s_rol,
                 @i_ubi          = @i_ubi,
                 @i_tsn          = @i_tsn,
                 @i_tarjeta      = @w_codigo
         end                                                           -- JPM Ref.26 -->
         else
         begin
            if @w_tipo_cta = 'BAS'
            begin
			
				
		select @v_causa_deb = b.valor	--Ref032 pricaura
		from cobis..cl_tabla a, cobis..cl_catalogo b
		where a.tabla = 'causa_nd_bas_servicios'
		and a.codigo = b.tabla
		and b.codigo = convert(varchar,@i_empresa)
		and estado = 'V'
		
		if @@rowcount = 0 or (@v_causa_deb = null or @v_causa_deb = ' ')  --ref 34
		begin
			if @i_aplcobis = 'S'
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_msg   = 'CAUSA DE ND NO DEFINIDA PARA SERVICIO',
				@i_num   = 158693

			return 158693			
		end
				--ref032 pricaura ini
				--if @@rowcount = 0
				--	select @v_causa_deb = '114'
				--ref032 pricaura fin
			
               select @w_ssn_corr = isnull(@t_ssn_corr, 0)
               exec @w_return = cob_virtuales..sp_basndc_automatica
                      @s_srv              = @s_srv,
                      @s_ofi              = @s_ofi,
                      @s_ssn              = @s_ssn,
                      @s_user             = @s_user,
                      @s_term             = @s_term,
                      @s_rol              = @s_rol,
                      @t_trn              = 120060,
                      @t_corr             = @t_corr,
                      @i_cta              = @i_cuenta,
                      @i_val              = @w_ndcta,
                      @i_cau              = @v_causa_deb,	--Ref30
                      @i_mon              = 1,
                      @i_fecha            = @s_date,
                      @i_aplcobis         = @i_aplcobis,
                      @i_referen          = @w_ssn_corr,
                      @i_tarjeta          = @w_codigo,
                      @i_ref              = @w_codigo,
                      @i_ubi              = @i_ubi,
                      @i_tsn              = @i_tsn,
                      @i_con_tran         = 'N',
                      @o_msg              = @w_msg                 out,
                      @o_error            = @w_error               out,
                      @o_detalle_error    = @w_detalle_error       out,
                      @i_canal            = @i_canal
            end
         end                                                           -- <-- JPM Ref.26

         if @w_return <> 0
         begin
            rollback tran
            return @w_return
         end
         else
         begin
               -- Llamado a sp cob_internet..sp_eventos por Alert Manager    -- GYC 2008/Ene/23
               -- Descripcion de Servicio


            if @t_corr = 'N'
            begin
               select @w_desc_servicio = 'PAGSB',
                @w_ssn = @s_ssn
            end
               else
            begin
               select @w_desc_servicio ='PAGSR', 
              @w_ssn = @t_ssn_corr
            end


            -- Descripcion de Canal

            --Ref021:msilvag Inicio
            if @i_canal = 'ATM'
               select @w_desc_canal = 'VEINTI4EFECTIVO'
            else
              if @i_canal in ( 'DBA','DIR') -- --DOS, REF 29
                    select @w_desc_canal = 'AUTOMATICO'
              else
                if @i_canal = 'IBK'
                      select @w_desc_canal = '24online' --Ref 39
                else
                  if @i_canal = 'IVR'
                        select @w_desc_canal = 'VEINTI4FONO'
                  else
                    if @i_canal = 'KSK'
                          select @w_desc_canal = 'PUNTOVEINTI4'
                    else
                      if @i_canal = 'VEN'
                            select @w_desc_canal = 'VENTANILLA'
                      else
                        if @i_canal = 'WAP'
                            select @w_desc_canal = 'WAP'
		        else	    
                          if @i_canal = 'CNB'
                             select @w_desc_canal = 'CNB'
			  else	    
                            if @i_canal = 'SAT' --ref047
                                select @w_desc_canal = 'SAT'
			     
            --Ref021:msilvag Fin

            -- Descripcion de Empresa
            select @w_desc_empresa = substring(b.valor,1,32)
            from cobis..cl_tabla a, cobis..cl_catalogo b
            where a.tabla = 'sv_empresas_agua'
              and a.codigo = b.tabla
              and convert(int,b.codigo) = @i_empresa

            select @w_valor_debito = convert(varchar(11),@w_ndcta)
             
            
            exec  @w_return = cob_pagos..sp_consulta_celular
		@i_cliente = @w_cliente,
		@o_celular = @w_telefono  out,
		@o_correo=@w_correo  out
	    
	    	if @w_return <> 0
	    	begin
	    		if @@trancount > 0
	    			rollback tran
	    		return @w_return
                end
                
            ---smerino

         --ref033 inicio
         select @w_total = convert(varchar,(convert(money,isnull(@w_valor_debito,'0'))+ isnull(@w_total_comision,0))),
                @w_comision_tran = convert(varchar,isnull(@w_total_comision,0))
         
         if ((@i_canal ='WAP' and @w_wap_linea ='S') 
           or @w_comision_avi24='S') -->bandera indica canal envia comision
            select @w_total_sms       = @w_total                   
         else         
            select @w_total_sms     = @w_valor_debito,@w_control_mostrar =''

         --ref033 fin
        
        --Ref037:msilvag Inicio
        --if @i_empresa = 6 --Ref41
            select @w_nombre_cli = isnull(@o_nombre,@i_nombre)  --Ref038:msilvag
            --select @o_nombre = @i_nombre
        --Ref037:msilvag Fin
        
        --ini ref44
        --if @i_canal not in ( 'DBA','DIR')  --KBastida RECM-546
        
		    select @o_servicio_not = @w_desc_servicio,
		       @o_nomb_ente = @w_nombre_cli,
		       @o_cod_ente = convert(varchar(20),@w_cliente),
		       @o_desccanal = @w_desc_canal,
		       @o_celular = @w_telefono  ,
		       @o_correo = @w_correo,
		       @o_desc_empresa = @w_desc_empresa,
		       @o_prod_deb = 'AHO',
		       @o_valor = @w_valor_debito,
		       @o_fecha_deb = @w_fecha_deb,
		       @o_hora_deb = @w_hora_deb,
		       @o_valor_comi = @w_comision_tran,
		       @o_valor_tot = @w_total,
		       @o_cta_lat = substring(@i_cuenta,8,3)
	      
       	  --fin ref44
         	       
           /* exec  @w_return = cob_internet..sp_eventos
                  @i_operacion    = 'I',
                  @i_fecha                = @w_fecha_deb,
                  @i_retardo    = 'S',
                  @i_fecha_tope   = @w_fecha_proc,
                  @i_cliente    = @w_cliente,
                  @i_servicio     = @w_desc_servicio,
                  @i_producto     = 4,
                  @i_prod_deb             = 'AHO',
                  @i_cuenta     = @i_cuenta,
                  @i_empresa    = @w_desc_empresa,
                  @i_desc_servicio  = 'AGUA',
                  @i_nombre     = @w_nombre_cli , --Ref038:msilvag @o_nombre,
                  @i_planilla   = @i_codigo,
                  @i_valor    = @w_valor_debito,
                  @i_canal    = @i_canal,
                  @i_desc_canal     = @w_desc_canal,
                  @i_ssn      = @w_ssn,
                  @i_categoria_cta  = @w_categoria,      -- GYC 2012/Jun/27
                  @i_mail          =@w_correo , --smerino
                  @i_telefono      =@w_telefono,  ---smerino-- GYC 2012/Jun/27
                  @i_motivo         = 'AGUA',
                  --ref033 inicio
                  @i_valor1       =@w_hora_deb,
                  @i_valor2       =@w_comision_tran, -->comision de la TRANSACCIÓN
                  @i_minimo       =@w_total,         -->Valor de deuda + comision de la TRANSACCIÓN
                  @i_cta          =@w_total_sms,     -->Para mostrar en sms, ya tiene validado si tiene agregada la Comisión o no
                  @i_tarjeta      =@w_control_mostrar -->indicador para mostrar nuevos campos en plantilla, ya validado
                  --ref033 fin

            if @w_return <> 0
            begin
               rollback tran
               return @w_return
            end
            */
            
        end  --FIN else if @w_return <> 0
     end  --FIN if @i_tipocta in ('AHO', 'PAG') and @w_debito_usd 

      -- Actualizacion de Totales de cajero
      select @w_emp = convert(varchar(6),@i_empresa)


      /* SALVAR VARIABLES PARA UPD TOTALES */
      select @w_debito_usd_bak = @w_debito_usd


      -- identificar si monto de ND es de BB o de BanRed
      if @w_debito_usd > 0
         if @i_ind_costo = 'R'
            begin
               select @w_debito_BR  = @w_debito_usd + @i_costo
               select @w_debito_usd = 0
            end
         else
            select @w_debito_usd = @w_ndcta

      if  @i_empresa = 114    --REF 14
            select @w_debito_usd = @w_debito_usd_bak  --REF 14


      select @w_codigo = convert(varchar,@i_codigo)

      ---SMERINO
            if @i_canal ='ATM'     --ref 15
             begin
                    select @w_efec_atm = 0   --ref 34  --@i_efe  --@i_val   --ref 15 SMERINO
                    select @w_val_usd = @i_efe   --ref 34 --0
             end
             else
             begin --ref 15
                    select @w_efec_atm = 0    --ref 15
       end

      -- Transaccion servicio
      if  @i_empresa = 114  --or @i_empresa = 360 or @i_empresa = 4 or @i_empresa = 6 --Ref021:msilvag --REF 14
      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal, ts_correccion, ts_tipo_chequera,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia, ts_saldo, ts_ssn_corr, ts_cta_banco,
              ts_moneda, ts_tipo, ts_valor, ts_monto, ts_ocasional,
              ts_contratado, ts_aporte_iess, ts_descuento_iess, ts_tsn,
              ts_ccontable, ts_hora, ts_endoso, ts_causa, ts_tipocta,
              ts_nombre,ts_tipo_def, ts_cta_asociada, ts_oficina_cta,
              ts_cheque_rec,ts_ubicacion,  -- RCA 10/Sep/2001     RDG 07/Feb/2003
              ts_autoriz_aut, ts_fonres_iess,ts_campo_alt_uno, ts_campo_alt_dos,ts_autoriz_anula)     --JPM 15112004  --REF 14
      values (@s_ssn, @t_trn, @s_ofi, @s_user, @s_rol, @s_term, @t_corr, @i_canal,
              null, 'L', @s_lsrv, @s_date, @i_proceso, @w_codigo, @w_valch_usd, @t_ssn_corr, @i_cuenta,
              1, 'L',  @w_val_usd, @w_debito_usd, @w_reten_usd, @w_efec_atm, @i_costo, @w_debito_BR, @i_tsn, null, getdate(),
              @w_secuencial, @w_emp, @w_tipocta, @o_nombre,@i_aplcobis,
              @i_comprob , @w_id_detalle,@i_cant_chq,@i_ubi,  -- RCA 10/Sep/2001    RDG 07/Feb/2003
              convert(varchar(10), @w_total_comision), 0,@w_tipo_comp,@w_comprobante, convert(varchar(15),@w_base))  --JPM 15112004 --REF 14
      else	
      begin

      insert into cob_cuentas..cc_tran_servicio
             (ts_secuencial, ts_tipo_transaccion, ts_oficina,
              ts_usuario, ts_rol, ts_terminal, ts_correccion, ts_tipo_chequera,
              ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
              ts_referencia, ts_saldo, ts_ssn_corr, ts_cta_banco,
              ts_moneda, ts_tipo, ts_valor, ts_monto, ts_ocasional,
              ts_contratado, ts_aporte_iess, ts_descuento_iess, ts_tsn,
              ts_ccontable, ts_hora, ts_endoso, ts_causa, ts_tipocta,
              ts_nombre,ts_tipo_def, ts_cta_asociada, ts_oficina_cta,
              ts_cheque_rec,ts_ubicacion,  -- RCA 10/Sep/2001     RDG 07/Feb/2003
              ts_autoriz_aut, ts_fonres_iess,     --JPM 15112004  --REF 14
              ts_remoto_ssn,ts_campo_alt_dos, ts_campo_alt_uno , ts_fecha ) --Ref037:msilvag  --REF30
      values (@s_ssn, @t_trn, @s_ofi, 
             @s_user, @s_rol, @s_term, @t_corr, @i_canal,
              null, 'L', @s_lsrv, @s_date, @i_proceso,
              @w_codigo, @w_valch_usd, @t_ssn_corr, @i_cuenta,
              1, 'L',  @w_val_usd, @w_debito_usd, @w_reten_usd, 
              @w_efec_atm, @i_costo, @w_debito_BR, @i_tsn, null, getdate(),
              @w_secuencial, @w_emp, @w_tipocta, isnull(@o_nombre,@i_nombre),@i_aplcobis,
              @i_comprob , @w_id_detalle,@i_cant_chq,@i_ubi,  -- RCA 10/Sep/2001    RDG 07/Feb/2003
              --null, 0) --smerino cambios smerino  --Ref021:msilvag
              convert(varchar(10), @w_total_comision), 0,  --JPM 15112004 --REF 14 --Ref021:msilvag Se quito comentado
              @i_sec_atm,@i_dat_emp , @i_motivo_reverso, @o_fecha_efe ) --Ref037:msilvag  --REF30
        end 
      if @@rowcount <> 1
         begin
           if @i_aplcobis = 'S'                                                 -- JLS 23/FEB/2001
           begin                                                                -- JLS 23/FEB/2001
             exec cobis..sp_cerror
                 @t_from = @w_sp_name,
                 @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
                 @i_num = 34004  --smerinom
             return 34004
           end
           else                                                                 -- JLS 23/FEB/2001
           begin                                                                -- GMD 10/ABR/2003
             rollback tran                                                      -- GMD 10/ABR/2003
             return 34004                                                       -- JLS 23/FEB/2001
           end                                                                  -- GMD 10/ABR/2003
         end


      -- Transaccion servicio por comision JPM 05112004
-- @w_codigo --> codigo del cliente que paga

      if @w_total_comision > 0
         begin

           /* calculo del iva sobre la comision person JPM 15112004 */
          select @w_valor_iva = 0
          /* if @w_accion_iva = 'S' and @w_accion_iva_cero ='N'
              begin
           select @w_impuesto = 0
           select @w_impuesto = (@w_iva * 100) + 100
           select @w_valor_iva = @w_total_comision - round(((@w_total_comision * 100)/@w_impuesto),@w_numdeci)
           select @w_total_comision  = @w_total_comision - @w_valor_iva

              end*/
        /* (fin calculo IVA) JPM 15112004*/

          --  busqueda de la tasa del iva parametrizada en el person
                  exec @w_return = cob_pagos..sp_verif_genera_costo --REF18
                    @s_date         = @s_date,
                    @i_mon          = @i_mon,
                    @i_rubro        = 'IVA',
                    @i_servicio     = 'CSBA',
                    @i_canal        = 'VEN',
                    @i_tipocta      = '3',
                    --@i_cuenta       = @i_cuenta,
                    @o_costo        = @w_tasa out
                  if @w_return <> 0
                  begin
                     if @@trancount > 0
                        rollback tran

                      return @w_return
                  end

                  if @w_tasa > 0
                  begin
                      --llamar al sp que retorna el valor del iva ----
                      exec  @w_return = cob_cuentas..sp_cal_impuesto
                          @i_tasa   = @w_tasa,
                          @i_valor_serv = @w_total_comision,
                          @o_base_imp = @w_base_imp out,
                          @o_impuesto = @w_impuesto2 out

                      if @w_return <> 0
                      begin
                         if @@trancount > 0
                            rollback tran

                          return @w_return
                      end
                      
                      select @o_base_imp = @w_base_imp, @o_impuesto = @w_impuesto2  --smerino
                 end
                 else
                      select @w_base_imp = @w_total_comision, @w_impuesto2 = 0


if (@i_empresa = 361 or @i_empresa = 8269) and @i_canal in ('DBA','DIR') --Ref045:msilvag --DOS, REF 29
begin
    select @i_deb_com = @w_total_comision
end
     --transaccion de servicio por comision
    if  @i_empresa = 114    --REF 14
    begin

        ---cobro de Comisión smerino sino es tripleoro
        if @i_canal = 'ATM'--ref 15
        begin
              select @w_efec_com_atm = @w_total_comision   --ref 15 SMERINO
              select @wi_total_comision= 0
        end
        else  --ref 15
        begin
              select @wi_total_comision= @w_total_comision
              select @w_efec_com_atm = 0    --ref 15
        end

        if @w_base_imp > 0
        begin
            --insert la trx del iva 3497 para cobro de la comision ---
            exec @w_return = cob_cuentas..sp_cont_impuesto --REF18
                  @t_trn       = 3497 ,
                  @s_ssn       = @s_ssn,
                  @s_date      = @s_date,
                  @t_corr      = @t_corr,
                  @t_ssn_corr  = @t_ssn_corr,
                  @s_user      = @s_user,
                  @s_term      = @s_term,
                  @s_ofi       = @s_ofi,
                  --@t_rty       = @t_rty,
                  @s_org       = @s_org,
                  @i_base_imp = @w_base_imp,
                  @i_iva  = @w_impuesto2,
                  @i_total = @w_total_comision,
                  @i_cau  = @w_causa,
                  @i_cta  = @w_codigo, --referencia
                  @i_mon  = @i_mon,   --Moneda
                  @i_oficina_cta = @s_ofi,
                  @i_ubi  =@i_ubi,
                  @i_canal=@i_canal --smerino
            if @w_return <> 0
            begin
                if @@trancount > 0
                    rollback tran

                return @w_return
            end
       end
	   
        insert into cob_cuentas..cc_tran_servicio
           (ts_secuencial, ts_tipo_transaccion, ts_oficina,
        ts_usuario, ts_rol, ts_terminal, ts_correccion,
        ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
        ts_referencia, ts_ssn_corr, ts_cta_banco,
        ts_moneda, ts_tipo, ts_valor, ts_contratado, ts_tsn,
        ts_hora, ts_causa, ts_tipocta, ts_nombre, ts_tipo_def,
        ts_cta_asociada, ts_oficina_cta, ts_ubicacion, ts_servicio,
        ts_campo_alt_uno, ts_endoso, ts_tipo_chequera,ts_saldo, ts_monto)
        values (@s_ssn , @w_trn, @s_ofi,       --REF 14
        @s_user, @s_rol, @s_term, @t_corr,
        null, 'L', @s_lsrv, @s_date, @i_proceso,
        @w_codigo, @t_ssn_corr, @i_cuenta,
        1, 'L',  @wi_total_comision , @w_efec_com_atm, @i_tsn,
        getdate(), @w_causa, @w_tipocta, @o_nombre, @i_aplcobis,  --REF 14
        @i_comprob , @w_id_detalle, @i_ubi, @i_canal,
        @w_emp, @w_secuencial, @i_canal,@i_chq_com ,@i_deb_com)
        if @@rowcount <> 1
        begin
            if @i_aplcobis = 'S'
            begin
                exec cobis..sp_cerror
                    @t_from = @w_sp_name,
                    @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
                    @i_num =  34004
                return  34004
            end
            else
            begin
                rollback tran
                return  34004
            end
        end


        if @w_cliente > 0
        begin
 
            select @w_ced_ruc = en_ced_ruc,
                 @w_nombre = substring(ltrim(en_nombre) + " " + ltrim(p_p_apellido) + " " + rtrim(ltrim(p_s_apellido)),1,45)
            from cobis..cl_ente
            where en_ente = @w_cliente
        end

        if @i_canal = 'VEN'    --lfcm 08-abril-2009
        begin
            exec @w_return = cob_remesas..sp_upd_totales_rc
            @i_ofi            = @s_ofi,
            @i_rol            = @s_rol,
            @i_user           = @s_user,
            @i_producto       = 'CTE',
            @i_mon            = @i_mon,
            @i_ubi            = @i_ubi,
            @i_trn            = @w_trn,
            @i_nodo           = @s_srv,
            @i_tipo           = 'L',
            @i_corr           = @t_corr,
            @i_efectivo       = @i_efe_com,
            @i_cheque         = @i_chq_com,
            @i_otros          = @i_deb_com,
            @i_tipocta        = @i_tipocta,
            @i_causa          = @w_causa
            if @w_return != 0
            begin
                if @i_aplcobis = 'S'
                begin
                    exec cobis..sp_cerror
                        @t_debug         = @t_debug,
                        @t_file          = @t_file,
                        @t_from          = @w_sp_name,
                        @i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                        @i_num           = 34019 --smerinom
                    return 34019
                end
                else
                begin
                    rollback tran
                    return 34019  --smerinom
                end
            end

        end
    end
    else
    begin
        ---cobro de Comisión smerino sino es tripleoro
        if @i_canal not in ('DBA') --DAPV  REF 16 --DOS, REF 29 -- DOS, REF 31
        begin
  
            --Cobro de la comision
            if  @i_efe_com > 0 or  @i_chq_com > 0 or   @i_deb_com > 0
            begin
                select     @w_trn =     @t_trn

                if @t_trn = 3137
                    select  @w_trn = 3366 , @w_servicio ="8"
                else
                    if @t_trn = 3201
                        select  @w_trn = 3372 , @w_servicio ="8"
				
				--Ref045:msilvag Inicio
				if @i_empresa = 8269
				begin
					select @w_servicio = pe_serv_com
					from cob_pagos..pg_person_empresa
            		where pe_empresa  = @i_empresa
					
					select @w_causa = @w_servicio
					
					if @t_trn = 3925
						select  @w_trn = 3366
					else
						select  @w_trn = 3372
				end				
				--Ref045:msilvag Fin

                --Ref021:msilvag Inicio
                /* if @i_empresa = 114
                  select @w_causal = '838'
                else
                  if @i_empresa = 361
                    select @w_causal = '837'
                  else
                    if @i_empresa = 360 --EMAAPQ
                      select @w_causal = '651'
                    else
                      if @i_empresa = 6 --Amagua
                        select @w_causal = '652'
                      else
                        if @i_empresa = 4 --Aguapen
                          select @w_causal = '653'*/
                --Ref021:msilvag Fin

                --ini ref 34
                if  (@i_tipocta = 'CTE' or @i_tipocta = 'AHO'  or @i_tipocta = 'PAG') and (@i_debito>0  or @i_deb_com > 0) --Ref 36
                begin
                    if @i_tipocta = 'CTE'
                    begin
                        select @w_causal = b.valor		
                        from cobis..cl_tabla a, cobis..cl_catalogo b
                        where a.tabla = 'causa_nd_comision_servcte'		
                        and a.codigo = b.tabla
                        and convert(int,b.codigo) = @i_empresa
                        and estado = 'V'			
                    end	
                    else if @i_tipocta = 'AHO'
                    begin
                        select @w_causal = b.valor			
                        from cobis..cl_tabla a, cobis..cl_catalogo b		
                        where a.tabla = 'causa_nd_comision_servaho'		
                        and a.codigo = b.tabla		
                        and convert(int,b.codigo) = @i_empresa			
                        and estado = 'V'

                    end
                    else if @i_tipocta = 'PAG'
                    begin
                        select @w_causal = b.valor			
                        from cobis..cl_tabla a, cobis..cl_catalogo b		
                        where a.tabla = 'causa_nd_comision_servbas'		
                        and a.codigo = b.tabla		
                        and convert(int,b.codigo) = @i_empresa			
                        and estado = 'V'

                    end
                    if @@rowcount = 0 or (@w_causal = null or @w_causal = ' ')
                    begin
                        if @i_aplcobis = 'S'
                        begin
                            exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_msg   = 'CAUSA DE ND NO DEFINIDA PARA COMISION',
                            @i_num   = 158693
                            
                            return 158693
                        end 
                        --Ref037:msilvag Inicio
                        begin
                            if @@trancount > 0
                                rollback tran
                            return 158693
                        end
                        --Ref037:msilvag Fin		
                    end
                end
                --fin ref 34	
	
                /*REF27 Inicio LBP*/
                select @w_aplica_des = 'N'
                if exists(select 1 from cob_pagos..pg_p_rubro_ser_dam 
	               where rs_empresa = @i_empresa 
	               and rs_canal = @i_canal and rs_estado = 'V')  
	            begin
	     
                     if @i_canal in ('VEN', 'CNB')
                     begin
                 
	                    select @w_comi_total = isnull(@i_efe_com,0) + isnull(@i_chq_com,0) + isnull(@i_deb_com,0)
	          
                        exec @w_return = cob_pagos..pa_pg_ivalor_comcal
                              @e_valor_comision  = @w_comi_total,
                              @e_oficina         = @w_ofi,
                              @e_empresa         = @i_empresa,
                              @e_canal           = @i_canal,
                              @s_valor_com_final = @w_com_original out, -- obtengo comision original
                              @s_aplica          = @w_aplica_des out
                        if @w_return <> 0
                            return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
	          
                        if @w_aplica_des = 'S'
                        begin
                            exec @w_return = cob_gov..pa_iva_pcompensacion
                              @e_oficina        = @w_ofi,
                              @e_monto          = @w_com_original,
                              @s_monto_compensa = @w_valor_compensa out 
                            if @w_return <> 0
                                return 300003360  -- NO EXISTE REGISTRO DE PARAMETRO COMISION 
                        end
                    end
                end
                else
				    select @w_com_original = @i_efe_com + @i_chq_com + @i_deb_com

                /*REF27 Fin LBP*/
            
                exec @w_return = cob_remesas..sp_cobro_comision_rc
                  @s_ssn     = @s_ssn,
                  @s_lsrv    = @s_lsrv,
                  @s_srv     = @s_srv,
                  @s_user    = @s_user,
                  --@s_sesn    = @s_sesn,
                  @s_term    = @s_term,
                  @s_date    = @s_date,
                  @s_ofi     = @s_ofi,
                  @s_rol     = @s_rol,
                  @s_org     = @s_org,
                  @s_org_err = @s_org_err, /* Origen de error: [A], [S] */
                  @s_error   = @s_error,
                  @s_sev     = @s_sev,
                  @t_corr    = @t_corr,
                  @t_ssn_corr= @t_ssn_corr, /* Trans a ser reversada */
                  @t_debug   = @t_debug,
                  @t_file    = @t_file,
                  @t_from    = @t_from,
                 -- @t_rty     = @t_rty,
                  @t_trn     = @w_trn,
                  @i_ubi     = @i_ubi,
                  @i_mon     = @i_mon,
                  @i_causal   = @w_causal,
                  @i_opcion  = "T",
                  @i_servicio= @w_servicio,
                  @i_codigo   = @w_codigo, --@i_codigo,	--Ref032 pricaura
                  @i_efectivo= @i_efe_com,
                  @i_cheque  = @i_chq_com,
                  @i_debito  = @i_deb_com, -- DEBITO A CTAS
                  @i_canal   = @i_canal,
                  @i_cuenta   = @i_cuenta,
                  @i_tipocta  = @w_tipo_cta,        -- JPM Ref.06: antes @i_tipocta,
                  @i_tsn      = @i_tsn
                if @w_return != 0
                begin
                    if @i_aplcobis = 'S'
                    begin
                        --Ref040:msilvag Inicio Comento Bloque
                       /* exec cobis..sp_cerror
                          @t_debug  = @t_debug,
                          @t_file   = @t_file,
                          @t_from   = @w_sp_name,
                          @i_num    =  035000 */
                        --Ref040:msilvag Fin
                        if @@trancount > 0
                            rollback tran
                            
                        return @w_return --Ref040:msilvag 1
                    end --if @i_aplcobis = 'S'
                    else
                        return @w_return --Ref040:msilvag 1
                end --if @w_return != 0

                if @w_base_imp > 0
                begin
                    /*REF27 Inicio LBP*/
                    if @w_valor_compensa > 0 and @w_aplica_des = 'S' and (@i_canal = 'CNB' or @i_canal = 'VEN')
                    begin
                        -- llamar al sp que retorna el valor del iva ----
                        exec @w_return = cob_cuentas..sp_cal_impuesto
                            @i_tasa         = @w_tasa,
                            @i_valor_serv   = @w_com_original,
                            @o_base_imp     = @w_base_imp out,
                            @o_impuesto     = @w_impuesto2 out
              
                        select @o_base_imp = @w_base_imp,
                               @o_impuesto = @w_impuesto2,
                               @o_tasa     = @w_tasa
                        if @w_return <> 0
                        begin
                            if @@trancount > 0
                              rollback tran
                            return @w_return
                        end
                    end
                    /*REF27 Fin LBP*/
                  
                  
                    /*REF27 Inicio LBP*/
                    if (@i_canal = 'CNB' or @i_canal = 'VEN') and @w_aplica_des = 'S' and @w_valor_compensa > 0
		            begin
                         --insert la trx del iva 3497 para cobro de la comision ---
                         exec @w_return = cob_cuentas..sp_cont_impuesto --REF18
                            @t_trn       = 3497 ,
                            @s_ssn       = @s_ssn,
                            @s_date      = @s_date,
                            @t_corr      = @t_corr,
                            @t_ssn_corr  = @t_ssn_corr,
                            @s_user      = @s_user,
                            @s_term      = @s_term,
                            @s_ofi       = @w_ofi, -- Oficina Damnificado
                            --@t_rty       = @t_rty,
                            @s_org       = @s_org,
                            @i_base_imp  = @w_base_imp,
                            @i_iva       = @w_impuesto2,
                            @i_total     = @w_com_original, -- Comision Original al 14
                            @i_cau       = @w_causa,
                            @i_cta       = @w_codigo, --referencia
                            @i_mon       = @i_mon,   --Moneda
                            @i_oficina_cta= @w_ofi, -- Oficina Damnificado
                            @i_ubi       = @i_ubi,
                            @i_canal     = @i_canal, --smerino
                            @i_cta_deb   = @i_cuenta -- REF25 LBP se agrega cuenta
		     
		            end
                    else
		            begin
                        /*REF27 Fin LBP*/
                        --insert la trx del iva 3497 para cobro de la comision ---
                        exec @w_return = cob_cuentas..sp_cont_impuesto --REF18
                            @t_trn       = 3497 ,
                            @s_ssn       = @s_ssn,
                            @s_date      = @s_date,
                            @t_corr      = @t_corr,
                            @t_ssn_corr  =@t_ssn_corr,
                            @s_user      = @s_user,
                            @s_term      = @s_term,
                            @s_ofi       = @s_ofi,
                            --@t_rty       = @t_rty,
                            @s_org       = @s_org,
                            @i_base_imp =@w_base_imp,
                            @i_iva  =@w_impuesto2,
                            @i_total = @w_total_comision,
                            @i_cau  = @w_causa,
                            @i_cta  =@w_codigo, --referencia
                            @i_mon  =@i_mon,   --Moneda
                            @i_oficina_cta= @s_ofi,
                            @i_ubi  =@i_ubi,
                            @i_canal=@i_canal --smerino

                    end -- if @i_canal = 'CNB' or @i_canal = 'VEN' LBP

                    if @w_return <> 0
                    begin
                        if @@trancount > 0
                            rollback tran

                        return @w_return
                    end
                end


                if @w_cliente > 0
                begin
                    select @w_ced_ruc = en_ced_ruc,
                             @w_nombre = substring(ltrim(en_nombre) + " " + ltrim(p_p_apellido) + " " + rtrim(ltrim(p_s_apellido)),1,45)
                    from cobis..cl_ente
                    where en_ente = @w_cliente
                end
            end  --if  @i_efe_com > 0 or  @i_chq_com > 0 or   @i_deb_com > 0
        end --if @i_canal <> 'DBA'
             
    end --else
      
           if @w_valor_iva > 0
           begin
  
                -- transaccion por iva sobre la comision
                insert into cob_cuentas..cc_tran_servicio
                  (ts_secuencial, ts_tipo_transaccion, ts_oficina,
                   ts_usuario, ts_rol, ts_terminal, ts_correccion,
                   ts_reentry, ts_origen, ts_nodo, ts_tsfecha, ts_clase,
                   ts_referencia, ts_ssn_corr, ts_cta_banco,
                   ts_moneda, ts_tipo, ts_valor, ts_contratado, ts_tsn,
                   ts_hora, ts_causa, ts_tipocta, ts_nombre, ts_tipo_def,
                   ts_cta_asociada, ts_oficina_cta, ts_ubicacion, ts_servicio,
                   ts_campo_alt_uno, ts_campo_alt_dos, ts_endoso, ts_tipo_chequera)
                values (@s_ssn + 2, 3867, @s_ofi,
                   @s_user, @s_rol, @s_term, @t_corr,
                   null, 'L', @s_lsrv, @s_date, @i_proceso,
                   @w_codigo, @t_ssn_corr, @i_cuenta,
                   1, 'L', @w_valor_iva, 0, @i_tsn,
                   getdate(), null, @w_tipocta, @o_nombre, @i_aplcobis,
                   @i_comprob , @w_id_detalle, @i_ubi, @i_canal,
                   '2', @w_emp, @w_secuencial, @i_canal)
                if @@rowcount <> 1
                   begin
                     if @i_aplcobis = 'S'
                        begin
                          exec cobis..sp_cerror
                              @t_from = @w_sp_name,
                              @i_msg = "ERROR EN LA GENERACION DE TRX DE SERVICIO",
                              @i_num = 34004  --smerinom
                          return 34004  --smerinom
                        end
                     else
                        begin
                          rollback tran
                          return 34004 --smerinom
                        end
                   end



           --  busqueda de la tasa del iva parametrizada en el person
                 exec @w_return = cob_pagos..sp_verif_genera_costo
                      @s_date         = @s_date,
                      @i_mon          = @i_mon,
                      @i_rubro        = 'IVA',
                      @i_servicio     = 'CSBA4',
                      @i_canal        = 'VEN',
                      @i_tipocta      = '3',
                      @i_cuenta       = @i_cuenta,
                      @o_costo        = @w_tasa out

                      if @w_return <> 0
                      begin
                         if @@trancount > 0
                            rollback tran

                          return @w_return
                      end

                if @w_tasa > 0
                begin
                  -- smerino llamar al sp que retorna el valor del iva ----
                   exec  @w_return = cob_cuentas..sp_cal_impuesto
                         @i_tasa          = @w_tasa,
                         @i_valor_serv  = @i_comision,
                         @o_base_imp  = @w_base_imp out,
                      @o_impuesto = @w_impuesto2 out

                      if @w_return <> 0
                      begin
                         if @@trancount > 0
                            rollback tran

                          return @w_return
                      end
                      select @o_base_imp = @w_base_imp, @o_impuesto = @w_impuesto2   --smerino
                end
                else
                      select @w_base_imp = @i_comision, @w_impuesto2 = 0

              if @w_base_imp > 0
              begin
                      --insert la trx del iva 3497 para cobro de la comision ---
                       exec @w_return = cob_cuentas..sp_cont_impuesto
                            @t_trn        = 3497,
                            @s_ssn       = @s_ssn,
                            @s_date      = @s_date,
                            @t_corr      = @t_corr,
                            @t_ssn_corr  =@t_ssn_corr,
                            @s_user      = @s_user,
                            @s_term      = @s_term,
                            @s_ofi       = @s_ofi,
                            --@t_rty     = @t_rty,
                            @s_org       = @s_org,
                            @i_costo =@w_base_imp,
                            @i_iva =@w_impuesto2,
                            @i_cau = @w_causa,
                            @i_cta =@w_codigo, --referencia
                            @i_mon =@i_mon,   --Moneda
                            @i_oficina_cta= @s_ofi,
                            @i_ubi =@i_ubi,
                            @i_canal=@i_canal --smerino

                              if @w_return <> 0
                              begin
                                 if @@trancount > 0
                                    rollback tran

                                  return @w_return
                              end
              end
           end -- fin valor iva
         end
      -- Fin transaccion servicio por comision --JPM 05112004
  if @i_canal = 'VEN'    --lfcm 08-abril-2009
  begin
        exec @w_return = cob_remesas..sp_upd_totales_rc
                 @i_ofi            = @s_ofi,
                 @i_rol            = @s_rol,
                 @i_user           = @s_user,
                 @i_producto       = 'CTE',
                 @i_mon            = @i_mon,
                 @i_ubi            = @i_ubi,           --- ame 11/13/2003
                 @i_trn            = @t_trn,
                 @i_nodo           = @s_srv,
                 @i_tipo           = 'L',
                 @i_corr           = @t_corr,
                 @i_efectivo       = @w_val_usd,
                 @i_cheque         = @w_valch_usd,
                 @i_tipocta        = @i_tipocta,
                 @i_otros          = @w_debito_usd_bak,
                 @i_retencion      = @w_reten_usd,
                 @i_causa          = @w_emp,
                 @i_cant_chq       = @i_cant_chq

            if @w_return != 0
               begin
                  if @i_aplcobis = 'S'                                                        -- JLS 23/FEB/2001
                  begin                                                                       -- JLS 23/FEB/2001
                     exec cobis..sp_cerror
                          @t_debug         = @t_debug,
                          @t_file          = @t_file,
                          @t_from          = @w_sp_name,
                          @i_msg           = 'ERROR EN LA GENERACION DE TOTALES',
                          @i_num           = 34019  --smerinom
                     return 34019 --smerinom
                  end
                  else                                                                        -- JLS 23/FEB/2001
                  begin                                                                 -- GMD 10/ABR/2003
                     rollback tran                                                      -- GMD 10/ABR/2003
                     return 37609                                                              -- JLS 23/FEB/2001
                  end                                                                   -- GMD 10/ABR/2003
               end
  end


    if @t_corr = 'N'
    begin
      if @w_ind_diferido = "S"
        select @o_horario = "D"
      else
        select @o_horario = "N"

     if  @i_empresa = 114     --REF 14  genera la secuencia de nota de venta inicia

     begin
      select @w_serie = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'SERNV'
       and pa_producto = 'CTE'



      --Armar el numero de nota de venta
      select @w_secuenciac = convert(varchar(7),@w_secuencian)
      select @w_secuenciac = replicate('0',7-datalength(@w_secuenciac))+@w_secuenciac
      select @o_nota_venta = substring(@w_serie,1,3)+'-'+substring(@w_serie,4,3)+'-'+@w_secuenciac
    end --REF 14  genera la secuencia de nota de venta fin

    end
    --REF30
	if @o_base_imp = null or  convert(varchar(100),@o_base_imp)  = ''
         begin
    	   select @o_base_imp = 0 
    end
    if @o_impuesto  = null or convert(varchar(100),@o_impuesto)  = '' 
        begin
          select @o_impuesto = 0
       end             
	 --FIN REF30

    commit tran
end     -- Fin de Opcion = T

    
return 0
go
if exists(select 1 from sysobjects where name='sp_pago_agua_rc' and type = 'P')
  PRINT '== CREATE PROCEDURE sp_pago_agua_rc *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE sp_pago_agua_rc -- ERROR -- >>>'
go
grant execute on sp_pago_agua_rc  to apl_osb_hpact
--grant execute on sp_pago_agua_rc  to apl_osb_hpdes
go




