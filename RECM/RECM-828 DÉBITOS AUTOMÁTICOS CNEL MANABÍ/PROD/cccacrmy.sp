use cob_pagos
go
if exists(select 1 from sysobjects where name = 'sp_carga_categ_cmoney' and type = 'P')
begin
   drop procedure dbo.sp_carga_categ_cmoney
   if exists (select 1 from sysobjects where name = 'sp_carga_categ_cmoney' and type = 'P')
     PRINT '<<< DROP PROCEDURE sp_carga_categ_cmoney -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE sp_carga_categ_cmoney *OK* =='
end
go

/*----------------------------------------------------------------------------------*/
/*  Archivo:            cccacrmy.sp                                     			*/
/*  Stored procedure:   sp_carga_categ_cmoney                          				*/
/*  Motor de Base:      SYBASE                                          			*/
/*  Servidor:           HP-ACT                                          			*/
/*  Aplicacion:         CyberBank                                       			*/
/*  Base de datos:      cob_pagos                                       			*/
/*  Producto:           Cuentas Corrientes                                   		*/
/*  Disenado por:       Guillermo Martillo                               			*/
/*  Fecha de escritura: 05-Noviembre-2008                                     		*/
/*  Procesamiento:      OLTP                                            			*/
/*  Ult.ControlTarea:   J-RECM-828                                   				*/
/*  Ult.Referencia:     REF 2                                           			*/
/*----------------------------------------------------------------------------------*/
/*                            IMPORTANTE                                            */
/*      Este programa es parte de los paquetes bancarios propiedad de               */
/*      BANCO BOLIVARIANO S.A.                                                      */
/*      Su uso no autorizado queda expresamente prohibido asi como                  */
/*      cualquier alteracion o agregado hecho por alguno de sus                     */
/*      usuarios sin el debido consentimiento por escrito de la                     */
/*      Presidencia Ejecutiva de BANCO BOLIVARIANO o su representante .             */
/*----------------------------------------------------------------------------------*/
/*                            PROPOSITO                                             */
/*  Este programa realiza la carga de datos de la CATEG al creditmoney              */
/*----------------------------------------------------------------------------------*/
/*                          MODIFICACIONES                                          */
/* Ref    FECHA             AUTOR                      RAZON                        */
/*  	05/Nov/2008  Guillermo Martillo      Emision inicial                        */
/*  	12/Mar/2012  Daniel Pereira V.       CNEL-308-CU-1818/CTE-CC-11473 Incluir regionales de Cnel*/
/* 2 	26/Dic/2023  Kevin Bastidas          RECM-828 DEBITOS AUTOMATICOS CNEL MANABI*/
/*----------------------------------------------------------------------------------*/

create proc sp_carga_categ_cmoney (
    @i_empresa     int,
    @i_fecha     datetime
)

as
declare @w_flag      int,
  @w_emp_dom     smallint,
  @w_cseqnos     int,
  @w_return          int,
  @w_sec_carga     int,
  @w_detalle     int,
  @w_fecha_pago      datetime,
  @w_emp_valida    smallint

select @w_emp_valida = convert(smallint,@i_empresa)

if exists (select 1
  from cobis..cl_empresas
  where  em_codigo = @w_emp_valida
  and em_estado  = 'V')
begin
  select @w_flag = 1
end
else
begin
  print 'Empresa no existe'
  return 1
end
if @w_flag = 1
begin
  if @i_empresa = 1165  --codigo categ para creditmoney
    select @w_emp_dom  = 1 -- Codigo de categ en domiciliado
  else
    select @w_emp_dom = @i_empresa  --DAPV/03122012/CNEL

  exec @w_return = cobis..sp_cseqnos
  @i_tabla  = 'pg_roles_empresa',
  @o_siguiente = @w_cseqnos out
  if @w_return != 0
  begin
    -- rollback tran
    print 'Error al obtener Secuencial de cabecera'
    return 1
  end

  if exists (select 1
  from cob_pagos..pg_roles_empresa
  where re_secuencial = @w_cseqnos)
  begin
    print 'Secuencial ya existe en la cabecera'
    return 1
  end
  --Obtengo secuencial de carga para la fecha de proceso

  select @w_sec_carga = isnull(max(re_secuencia_carga),0) + 1
  from cob_pagos..pg_roles_empresa
  where re_empresa     = @i_empresa
  and re_fecha_carga = @i_fecha

  if @@rowcount = 0
  Begin
    print 'Error al obtener secuencial de carga'
    return 1
  End

--<REF 2 Kbastidz Update a trx resagadas
begin
	update cob_pagos..pg_roles_empresa
	set re_estado = 'P'    
	WHERE re_secuencial IN (
    			SELECT re_secuencial 
    			FROM cob_pagos..pg_roles_empresa
    			WHERE re_estado IN ('I', 'T', 'W')
        		AND ((re_fecha_carga != @i_fecha AND re_empresa NOT IN (1081))
            		OR
            		(re_fecha_carga = @i_fecha AND re_empresa NOT IN (1081) AND re_secuencia_carga NOT IN (1))
		       ))
			   
	if @@error <> 0
	begin
		print 'Error al grabar actualizar'
		return 1
	end
end
--REF 2>


  begin tran

  insert into cob_pagos..pg_roles_empresa(
  re_empresa,re_secuencial,re_secuencia_carga,re_fecha_carga,re_tipo_servicio,re_mto_deb_suc,
  re_mto_cre_suc,re_reg_dol,re_mto_deb_dol,re_mto_cre_dol,re_estado,re_status,re_noprocesados,
  re_fecha_proceso,re_fecha_archivo,re_hora_proceso)
  values (@i_empresa,@w_cseqnos,@w_sec_carga,@i_fecha,2,0,
  0,0,0,0,'I','E',0,
  null,@i_fecha,null)

  if @@error <> 0
  begin
    rollback tran
    print 'Error al grabar cabecera'
    return 1
  end
  else
  begin

    exec @w_return = cob_pagos..sp_inserta_categ_cmoney
    @i_empresa= @w_emp_dom,
    @i_fecha = @w_fecha_pago,
    @i_operacion = 'D',
    @i_fproc = @i_fecha,
    @i_cabecera = @w_cseqnos,
    @i_emp_cred = @w_emp_valida

    if @w_return != 0
    begin
      rollback tran
      print 'Error al ingresar detalles'
      return 1
    end
  end

  commit tran
end
return 0
go
