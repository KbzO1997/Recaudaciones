use cob_pagos
go

if exists (select 1 from [dbo].sysobjects where name = 'sp_arch_debitos_automaticos')
    drop proc [dbo].sp_arch_debitos_automaticos
go

/************************************************************************/
/*  Archivo:            pgarcdba.sp                                     */
/*  Stored procedure:   sp_arch_debitos_automaticos                     */
/*  Motor de Base:      SYBASE                                          */
/*  Servidor:           HP-ACT                                          */
/*  Aplicacion:         CyberBank                                       */
/*  Base de datos:      cob_pagos                                       */
/*  Producto:           Cuentas de pagos                                */
/*  Disenado por:       Daniel Pereira V.                               */
/*  Fecha de escritura: 28/Nov/2011                                     */
/*  Procesamiento:      OLTP                                            */
/*  Ult.ControlTarea:   J-RECM-774                                   */
/*  Ult.Referencia:     REF 9                                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*    Este programa es parte de los paquetes bancarios propiedad del    */
/*    "BANCO BOLIVARIANO".                                              */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus usuarios  */
/*    sin el debido consentimiento por escrito de la Presidencia        */
/*    Ejecutiva del BANCO BOLIVARIANO o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa Genera el Archivo de Pagos Exitosos para Claro    */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/*   1  28/Nov/2011   Daniel Pereira V.    CTE-CC-10665 Emision Inicial */
/*   2  18/Jul/2012   Daniel Pereira V.    CTE-CC-11619                 */
/*   3  24/Agt/2012   Daniel Pereira V.    NUMCEL-317-SGC00003090 Adicion de digito celular*/  
/*   4  06/Sep/2018   Danny Olaya S.       RECA-CC-SGC00030102 - RECA-CC-SGC00031890 Mejoras Batch de Claro*/
/*   5  16/Ene/2019   Danny Olaya S.       RECA-CE-SGC00034214 - Inclusión de 6 digitos en la trama de la trx*/
/*   6  03/Jul/2019   Danny Olaya S.       RECMPS-38 (JIRA) - REPROCESO CLARO POSTPAGO */
/*	 7	28/Ago/2023	  Kevin Bastidas	   RECMPS-2673	CAMBIOS EN ARCHIVO DE RESPUESTA CLARO PROCESO BATCH*/
/*	 8	08/Sep/2023	  Kevin Bastidas	   RECM-773	AJUSTE EN ARCHIVO DE RESPUESTA CLARO PROCESO BATCH*/
/*	 9	11/Sep/2023	  Kevin Bastidas	   RECM-774	GENRACION DE PROCESO BATCH ECUTE -> 8523*/
/************************************************************************/

create proc [dbo].sp_arch_debitos_automaticos
(
    @t_debug            char(1) = 'N',
    @t_file             varchar(14) = null,
    @t_from             varchar(32) = null,
    @i_fecha_proceso    datetime ,
    @i_opcion           tinyint  = 0,
    @i_empresa          int     ,
    @i_usuario          char(10) = null,
	@i_intento			int = null --REF 6 
)
as

declare @w_sp_name      varchar(30),
        @w_fecha            char(10),
        @w_ced_ruc          varchar(15),
        @w_empresa          int,
        @w_emp_chr          varchar(6),
        @w_num_int          int,
        @w_num_chr          varchar(6),
        @w_producto         char(2),
        @w_cod_serv         varchar(10),
        @w_fecha_arch       char(8),
        @w_hora_arch        char(8),
        @w_usuario          char(10),
        @w_valor_tot        money,
        @w_valtot_chr       varchar(15),
        @w_cabecera         varchar(200),
        @w_hora             char(2),
        @w_mm               char(2),
        @w_ss               char(2),
        @w_tipo_cta         char(3),
        @w_pos              smallint,
        @w_len              smallint,
        @w_trama            varchar(216),
        @w_trama1           varchar(200),
        @w_contrato         varchar(18),
        @w_cta_banco        varchar(20),
        @w_valor_rec        money,
        @w_tipocta          char(2),
        @w_identificacion   varchar(15),
        @w_sec_file         int  ,
        @w_tipo_id          char(1),
        @w_nombre_deudor    varchar(60),
        @w_forma_cobro      char(3),
        @w_codigo_pais      char(3),
        @w_codigo_bco       char(2),
        @w_moneda           char(1),
        @w_concepto         varchar(69),
        @w_num_cmpbte_vta   varchar(15),
        @w_base_imponible   money,
        @w_cod_servicio     char(3),
        @w_cod_empresa      int,
        @w_valor_minimo     money,
        @w_tipo_doc         char(3),
        @w_cod_error        int,
        @w_desc_error       char(40),
        @w_fecha_mov        char(8),
        @w_id_ente          int,
        @w_id_ente_chr      varchar(20),
        @w_valorc_rec       varchar(15),
        @w_nombre_cta       varchar(75),
        @w_estado_p         char(1),
        @w_cod_error_chr    char(6),
        @w_contrato_chr     varchar(20),
        @w_procesar         char(1),
        --Ref004 Inicio
        @w_valor_pagado     money
        --Ref004 Fin

if @i_opcion = 0
begin
    --trunca tabla que genera archivo
    truncate table pg_archivo_debitos_auto

    select @w_num_int   = 0,
           @w_fecha     = convert(char(8), @i_fecha_proceso, 112)


     select @w_fecha_arch = convert(char(8),getdate(),112)
     select @w_hora_arch  = convert(char(8),getdate(),108)
     select @w_hora  = substring(@w_hora_arch,1,2)
     select @w_mm    = substring(@w_hora_arch,4,5)
     select @w_ss    = substring(@w_hora_arch,7,8)


    --obtiene la cantidad de registros de debitos en el dia
    select  @w_num_int = count(1),
            @w_valor_tot = sum(cd_valor_rec)
    from pg_cobro_debitos_servicio
    where cd_fecha_arc =  @i_fecha_proceso
    and cd_empresa = convert(varchar,@i_empresa)
    and cd_forma_cobro  = 'CUE'
    and cd_procesar  <> ''
	and cd_no_archivo = @i_intento --REF 6

     if @w_num_int = 0
     begin
      /*exec cobis..sp_cerror
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_msg           = 'NO HAY REGISTROS PARA GENERAR EL ARCHIVO',
                @i_num           = 22222*/
                return 1
     end

     --obtiene los datos de la personalizacion de la empresa
     select @w_ced_ruc = pe_ruc,
            @w_empresa = pe_empresa,
            @w_producto = case pe_producto when 'CTE' then '03' else '04' end
     from pg_person_empresa
     where pe_empresa  = @i_empresa


    /*****************************************************/
    ---------se genera la cabecera del archivo---------
    /*****************************************************/

    ---Cedula o Ruc de la empresa
    select @w_len     = datalength(@w_ced_ruc)
    select @w_ced_ruc =  replicate('0', 15 - @w_len) + @w_ced_ruc

    --codigo de la mepresa
    select @w_emp_chr = convert(char(6), @w_empresa)
    select @w_len     = datalength(@w_emp_chr)
    select @w_emp_chr = replicate('0', 6 - @w_len) + @w_emp_chr

    --codigo del servicio
    select @w_cod_serv = 'REC'
    select @w_len      = datalength(@w_cod_serv)
    if @w_len is not null
        select @w_cod_serv = @w_cod_serv + replicate(' ', 10 - @w_len)
    else
        select @w_cod_serv = replicate(' ', 10)

    --cantidad de registros
    select @w_num_chr = convert(char(6), @w_num_int)
    select @w_len     = datalength(@w_num_chr)
    select @w_num_chr = replicate('0', 6 - @w_len) + @w_num_chr

    --Nombre del Usuario
    select @w_len     = datalength(@i_usuario)
    if @w_len is not null
        select @w_usuario = replicate(' ', 10 - @w_len) + @i_usuario
    else
        select @w_usuario = replicate(' ', 10)

    --Valor Total Generado
    select @w_valtot_chr = convert(varchar(16), @w_valor_tot)
    select @w_len       = datalength(@w_valtot_chr)
    select @w_pos       = charindex('.', @w_valtot_chr)
    select @w_valtot_chr = substring(@w_valtot_chr, 1, @w_pos - 1) + substring(@w_valtot_chr, @w_pos + 1, @w_len - @w_pos)
    select @w_valtot_chr = replicate('0', 16 - @w_len) + @w_valtot_chr

    --Hora del Archivo
    select @w_hora_arch = @w_hora + @w_mm + @w_ss

    select @w_cabecera = 'BZCAB' + 'R' + @w_ced_ruc + @w_emp_chr + @w_producto + @w_cod_serv + @w_fecha_arch + @w_hora_arch + 'MOVI' + @w_usuario + @w_num_chr +@w_valtot_chr

    insert into pg_archivo_debitos_auto values (@w_cabecera,null)
	
	if @@error <> 0
    begin
        return 1
    end

    --Ref004 Inicio
	
	if object_id('tempdb..#reca_tmp_det_claro') is not null
		drop table #reca_tmp_det_claro		
	
    create table #reca_tmp_det_claro
    (   
        cd_fecha_arc        varchar(8) null, cd_cod_contrato    varchar(18) null, cd_num_cta     varchar(20) null, cd_valor_rec       money      null, cd_tipo_cta       char(2) null,
        cd_identificacion   varchar(14)null, cd_sec_file        int         null, cd_tipo_id     char(1)     null, cd_nombre_deudor   varchar(60)null, cd_forma_cobro    char(3) null,
        cd_codigo_pais      char(3)    null, cd_codigo_bco      char(2)     null, cd_moneda      char(1)     null, cd_concepto        varchar(60)null, cd_num_cmpbte_vta varchar(15) null,
        cd_base_imponible   money      null, cd_cod_servicio    char(3)     null, cd_cod_empresa int         null, cd_valor_minimo    money      null, cd_tipo_doc       char(3) null,
        cd_cod_error        int        null, cd_desc_error      varchar(40) null, cd_procesar    char(1)     null, cd_valor_pagado    money null )
    
    
    insert into #reca_tmp_det_claro (
		cd_fecha_arc        , cd_cod_contrato    , cd_num_cta     , cd_valor_rec       , cd_tipo_cta       ,
        cd_identificacion   , cd_sec_file        , cd_tipo_id     , cd_nombre_deudor   , cd_forma_cobro    ,
        cd_codigo_pais      , cd_codigo_bco      , cd_moneda      , cd_concepto        , cd_num_cmpbte_vta ,
        cd_base_imponible   , cd_cod_servicio    , cd_cod_empresa , cd_valor_minimo    , cd_tipo_doc       ,
        cd_cod_error        , cd_desc_error      , cd_procesar    , cd_valor_pagado    
    )
    select  convert(char(8),cd_fecha_arc,112)     ,
            cd_cod_contrato       ,
            isnull(cd_num_cta,'0')        ,
            cd_valor_rec      ,
            cd_tipo_cta       ,
            cd_identificacion ,
            cd_sec_file       ,
            cd_tipo_id        ,
            cd_nombre_deudor  ,
            cd_forma_cobro    ,
            cd_codigo_pais    ,
            cd_codigo_bco     ,
            cd_moneda         ,
            cd_concepto       ,
            cd_num_cmpbte_vta ,
            cd_base_imponible ,
            cd_cod_servicio   ,
            cd_cod_empresa    ,
            cd_valor_minimo   ,
            cd_tipo_doc       ,
			
			case when p.cd_empresa = '8523' /*<REF 9, KBastida REC_ECUTE REF 9>*/
				then cd_cod_error
			else             
				case when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on t.codigo = c.tabla  /*<REF 7, KBastida Homolgador de códigos REF 7>*/
				   where t.tabla = 'sv_error_cobros_claro' and  c.codigo = convert(varchar,p.cd_cod_error) and c.estado = 'V') 			   
				then (select convert(int,valor) from cobis..cl_catalogo c inner join cobis..cl_tabla t on t.codigo = c.tabla  /*<REF 8, KBastida Ajuste Homolgador de códigos REF 8>*/
					where t.tabla = 'sv_error_cobros_claro' and c.codigo = convert(varchar,p.cd_cod_error)) else  cd_cod_error end 
			end,			
			
			case when p.cd_empresa = '8523' /*<REF 9, KBastida REC_ECUTE REF 9>*/
				then cd_desc_error
			else
				case when exists (select 1 from cobis..cl_catalogo c inner join cobis..cl_tabla t on t.codigo = c.tabla  /*<REF 7, KBastida Ajuste Homolgador de mensajes REF 7>*/
				   where t.tabla = 'sv_errordesc_cobros_claro' and c.codigo = convert(varchar,p.cd_cod_error) and c.estado = 'V') 
				then (select valor from cobis..cl_catalogo c inner join cobis..cl_tabla t on t.codigo = c.tabla  /*<REF 8, KBastida Ajuste Homolgador de códigos REF 8>*/
					where t.tabla = 'sv_errordesc_cobros_claro' and c.codigo = convert(varchar,p.cd_cod_error)) else  cd_desc_error end
			end,
			
            cd_procesar       ,
            isnull(cd_valor_pagado,0.00)     --Ref004
    from pg_cobro_debitos_servicio p
    where cd_fecha_arc =  @i_fecha_proceso
    and cd_empresa = convert(varchar,@i_empresa)
    and cd_forma_cobro  = 'CUE'
	and cd_no_archivo = @i_intento --REF 10
    
    /*******************************************************/
    ---Se genera el detalle a partir de la tabla diaria--
    /*******************************************************/
    declare extrae_det_claro cursor for

        select  cd_fecha_arc      ,
                cd_cod_contrato   ,
                cd_num_cta        ,
                cd_valor_rec      ,
                cd_tipo_cta       ,
                cd_identificacion ,
                cd_sec_file       ,
                cd_tipo_id        ,
                cd_nombre_deudor  ,
                cd_forma_cobro    ,
                cd_codigo_pais    ,
                cd_codigo_bco     ,
                cd_moneda         ,
                cd_concepto       ,
                cd_num_cmpbte_vta ,
                cd_base_imponible ,
                cd_cod_servicio   ,
                cd_cod_empresa    ,
                cd_valor_minimo   ,
                cd_tipo_doc       ,
                cd_cod_error      ,
                cd_desc_error     ,
                cd_procesar       ,
                cd_valor_pagado
        from #reca_tmp_det_claro     --Ref004
        order by cd_sec_file    --Ref004
    for read only

    open extrae_det_claro

    fetch extrae_det_claro into
            @w_fecha_mov,
            @w_contrato,
            @w_cta_banco,
            @w_valor_rec,
            @w_tipocta,
            @w_identificacion,
            @w_sec_file ,
            @w_tipo_id  ,
            @w_nombre_deudor  ,
            @w_forma_cobro  ,
            @w_codigo_pais  ,
            @w_codigo_bco   ,
            @w_moneda       ,
            @w_concepto     ,
            @w_num_cmpbte_vta,
            @w_base_imponible,
            @w_cod_servicio   ,
            @w_cod_empresa    ,
            @w_valor_minimo ,
            @w_tipo_doc     ,
            @w_cod_error    ,
            @w_desc_error   ,
            @w_procesar     ,
            @w_valor_pagado         --Ref004 


    while @@sqlstatus <> 2
    begin

        select @w_id_ente = 0

        --Código del Cliente de la Empresa
        select @w_id_ente = isnull(en_ente,0)
        from cobis..cl_ente
        where en_ced_ruc = @w_identificacion

        select @w_len = datalength(@w_contrato)
        select @w_contrato_chr = replicate('0' ,20 - @w_len) + @w_contrato


        select @w_id_ente_chr = convert(varchar(20),@w_id_ente)
        select @w_len = datalength(@w_id_ente_chr)
        select @w_id_ente_chr = replicate('0' ,20 - @w_len) + @w_id_ente_chr

        --Número de identificación
        select @w_len = datalength(@w_identificacion)

        if @w_len is not null
          select @w_identificacion = replicate('0' , 15 -@w_len) +@w_identificacion
        else
          select @w_identificacion = replicate(' ', 15)

        --Referencia
        select @w_len = datalength(@w_concepto)
        if @w_len is not null
          select @w_concepto = @w_concepto + replicate(' ',69 - @w_len)
        else
          select @w_concepto = replicate(' ', 69 )


        --Valor Movimiento
        select @w_valorc_rec = convert(varchar(16), @w_valor_pagado) --Ref004 convert(varchar(16), @w_valor_rec)
        select @w_len       = datalength(@w_valorc_rec)
        select @w_pos       = charindex('.', @w_valorc_rec)
        select @w_valorc_rec = substring(@w_valorc_rec, 1, @w_pos - 1) + substring(@w_valorc_rec, @w_pos + 1, @w_len - @w_pos)
        select @w_valorc_rec = replicate('0', 16 - @w_len) + @w_valorc_rec


        --Nombre Cuenta
        --corriente
        if @w_tipocta = '03'
        begin
            select @w_nombre_cta = cc_nombre
            from cob_cuentas..cc_ctacte
            where cc_cta_banco = @w_cta_banco
        end
        --ahorros
        if @w_tipocta = '04'
        begin
            select @w_nombre_cta = ah_nombre
            from cob_ahorros..ah_cuenta
            where ah_cta_banco = @w_cta_banco
        end

        --nombre de la cuenta
        select @w_len = datalength(@w_nombre_cta)
        if @w_len is not null
          select @w_nombre_cta = @w_nombre_cta + replicate(' ' , 75 -@w_len)
        else
          select @w_nombre_cta = replicate(' ' ,75)

        --Numero de la cuenta
        select @w_len = datalength(@w_cta_banco)
        if @w_len is not null
          select @w_cta_banco = replicate('0', 20 - @w_len) + @w_cta_banco
        else
          select @w_cta_banco = replicate('0',20)


        --Descripcion de error
        if @w_desc_error is null and @w_procesar = 'S'
            select @w_estado_p = 'P'
        else
            select @w_estado_p = 'X'

        --Código de Error
        select @w_cod_error_chr = convert(char(6),@w_cod_error)
        select @w_len = datalength(@w_cod_error_chr)
        if @w_len is not null
          select @w_cod_error_chr = replicate('0',6 - @w_len) + @w_cod_error_chr
        else
          select @w_cod_error_chr = replicate('0',6)

		
		--<REF 7,  KBastida Transacciones Exitosas 
		if @w_desc_error is null and @w_procesar = 'S' and @w_cod_empresa = 38 /*<REF 9, KBastida REC_ECUTE REF 9>*/
			begin
				select @w_cod_error_chr = replicate('0',5)
			end
		--REF 7>
		
        --Descripcion de Error
        select @w_len = datalength(@w_desc_error)
        if @w_len is not null
          select @w_desc_error = @w_desc_error + replicate(' ' ,40 -@w_len)
        else
          select @w_desc_error = replicate(' ' ,40)

		--<REF 7,  KBastida Transacciones Exitosas 
		if @w_procesar = 'S' and  @w_cod_empresa = 38 /*<REF 9, KBastida REC_ECUTE REF 9>*/
			begin
				select @w_desc_error = 'TRANSACCION EXITOSA'
			end
		--REF 7>
		
		
        --contruye la primera parte de la linea concatenada 
        select @w_trama = 'BZMOV' +'0000000000'+'0000000000'+'000000'+@w_fecha_mov+@w_fecha+@w_contrato_chr+@w_tipo_id+@w_identificacion+--ref005
                           'C'+'B'+@w_concepto+'000000000000000'+'001'+@w_valorc_rec+@w_codigo_pais+'34'+@w_tipocta+@w_cta_banco    
        --construye la segunda parte de la linea concatenada
        select @w_trama1 = @w_nombre_cta +'0000000000'+'00000'+'000000'+@w_estado_p+'DIR'+@w_forma_cobro+'00000'+'000000000000000'+
                           '2'+@w_cod_error_chr+@w_desc_error +'0000000000'+'000000000000000'

        --inserta las lineas a la tabla
        insert into pg_archivo_debitos_auto values (@w_trama,@w_trama1)

        if @@error <> 0
        begin
			close extrae_det_claro
			deallocate cursor extrae_det_claro
            exec cobis..sp_cerror
				@i_msg     = 'ERROR EN INSERCION ARCHIVO_DEBITOS_AUTO',
				@i_num     = 99999
			return 99999
        end

        fetch extrae_det_claro into
            @w_fecha_mov,
            @w_contrato,
            @w_cta_banco,
            @w_valor_rec,
            @w_tipocta,
            @w_identificacion,
            @w_sec_file ,
            @w_tipo_id        ,
            @w_nombre_deudor  ,
            @w_forma_cobro  ,
            @w_codigo_pais  ,
            @w_codigo_bco ,
            @w_moneda       ,
            @w_concepto   ,
            @w_num_cmpbte_vta,
            @w_base_imponible,
            @w_cod_servicio   ,
            @w_cod_empresa    ,
            @w_valor_minimo   ,
            @w_tipo_doc     ,
            @w_cod_error    ,
            @w_desc_error  ,
            @w_procesar     ,
            @w_valor_pagado         --Ref004

    end

    close extrae_det_claro
    deallocate cursor extrae_det_claro

--Ref004 Ini
if object_id('tempdb..#reca_tmp_det_claro') is not null
		drop table #reca_tmp_det_claro		
--Ref004 Fin		

end
go
