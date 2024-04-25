use cob_internet
go
if exists(select 1 from sysobjects where name = 'pa_cash_cprocesar_tarifaBE' and type = 'P')
begin
     drop procedure dbo.pa_cash_cprocesar_tarifaBE
	 if exists (select 1 from sysobjects where name = 'pa_cash_cprocesar_tarifaBE' and type = 'P')
     PRINT '<<< DROP PROCEDURE pa_cash_cprocesar_tarifaBE -- ERROR -- >>>'
    else
     PRINT '== DROP PROCEDURE pa_cash_cprocesar_tarifaBE *OK* =='
end
go

/************************************************************************************/
/*  Archivo: 			pa_cash_cprocesar_tarifaBE.sp                    			*/
/*  Motor de Base: 		SYBASE                     					   				*/
/*  Base de datos: 		cob_internet                                     			*/
/*  Servidor: 			HP-ACT                                           			*/
/*  Aplicacion: 		Cyberbank	                                    			*/
/*  Stored Procedure: 	pa_cash_cprocesar_tarifaBE	                   				*/
/*  Procesamiento: 		OLTP	                                       	   			*/
/*  Producto: 			BIB                                              			*/
/*  Desarrollado Por: 	Daniela Garaicoa                                 			*/
/*  Derechos de Autor: 	Banco Bolivariano C.A.                           			*/
/*  Fecha de Escritura: 	30/1/2019                                       		*/
/************************************************************************************/
/*                               PROPOSITO                                         	*/
/* Consulta de comisiones para banca de empresas por tarifario ebanking            	*/
/************************************************************************************/
/*  REF      FECHA               AUTOR               RAZON              MOTIVO     	*/
/*    1  30/1/2019    Daniela Garaicoa  SAT-CE-SGC00034392Emision Inicial EBanking 	*/
/*    2  10/6/2019    jvillavc          SAT-CU-SGC00033011 Comision Por Canal SAT  	*/
/*    3  08/4/2021    kbastida          RECMPS-1553 - CONSULTA TERCON EN SAT  		*/
/************************************************************************************/

CREATE PROC dbo.pa_cash_cprocesar_tarifaBE (
	@e_identificacion VARCHAR(30),
	@e_id_funcionalidad VARCHAR(100),
	@e_canal VARCHAR(16),
	@e_servicio VARCHAR(20) = NULL,
	@e_codigo_empresa INT,
	@e_alcance CHAR(1) = NULL,
	@e_monto MONEY = NULL,
	@e_pais INT = NULL,
	@e_cargo CHAR(3) = NULL,
	@e_cuenta VARCHAR(20) = NULL,
	@e_tipo_cuenta CHAR(3) = NULL,
	@e_banco VARCHAR(100) = NULL,
	@e_forma_pago VARCHAR(10) = NULL,
	@e_accion_revocatoria_ch CHAR(4) = NULL,
	@e_tipo_impuesto_fiscal CHAR(10) = NULL,
	@e_codigo_empresa_proveedora INT = NULL,
	@s_segmento CHAR(10) = NULL OUTPUT,
	@s_comision FLOAT = 0 OUTPUT,
	@s_costo_envio MONEY = NULL OUTPUT,
	@s_forma_pago VARCHAR(10) = NULL OUTPUT,
	@s_tipo_comision VARCHAR(10) = NULL OUTPUT,
	@s_canal CHAR(3) = NULL OUTPUT,
	@s_region INT = NULL OUTPUT,
	@s_tipo_cuenta CHAR(2) = NULL OUTPUT,
	@s_agencia INT = NULL OUTPUT,
	@s_codigo_respuesta INT = 0 OUTPUT,
	@s_mensaje_usuario VARCHAR(132) = '' OUTPUT,
	@s_transaccion INT = 0 OUTPUT,
	@s_causa VARCHAR(5) = '' OUTPUT,
	@s_es_motor CHAR(1) = '' OUTPUT,
	@e_se_debita VARCHAR(5) = 'false',
	@s_cobrado_en_tarifario CHAR(1) = 'S' OUTPUT --REF2
	)
AS
BEGIN
	SELECT @s_codigo_respuesta = 1,
		@s_mensaje_usuario = 'ERROR GENERAL O PARAM. NO INGRESADA'

	--KBastida
	--RECMPS-1553 CREACION DE CATALOGO DE EMPRESAS PARA TARIFA BP
	--IF (@e_codigo_empresa_proveedora = 1111 OR @e_codigo_empresa_proveedora = 1112 OR @e_codigo_empresa_proveedora = 1113 OR @e_codigo_empresa_proveedora = 1114
	--	OR @e_codigo_empresa_proveedora = 1929)
	if exists ( select 1 from cobis..cl_tabla t inner join cobis..cl_catalogo c on t.codigo = c.tabla 
			    where t.tabla = 'sv_grp_emp_tarifabp' 
			    and c.estado = 'V' and c.codigo = convert(varchar(5) , @e_codigo_empresa_proveedora)) 
	BEGIN
		SELECT @e_codigo_empresa_proveedora = convert(INT, @e_servicio)
	END

	-- REF03 Se coloca para el pago de SRI
	IF (
			@e_codigo_empresa_proveedora = 5993
			AND @e_servicio = 'MATV'
			)
	BEGIN
		SELECT @e_codigo_empresa_proveedora = 2
	END

	DECLARE @v_tipo_comision CHAR(2),
		@v_tipo_cuenta INT,
		@v_retorno INT,
		@v_codigo_empresa VARCHAR(10),
		@v_producto_com VARCHAR(10),
		@v_opcion CHAR(1),
		@v_tabla VARCHAR(100),
		@v_codigo VARCHAR(10),
		@v_rubro VARCHAR(10),
		@v_transaccion VARCHAR(10),
		@v_canal_homologado CHAR(3)

	SET @s_region = 0
	SET @s_agencia = 0

	IF @e_identificacion = ''
		OR @e_identificacion IS NULL
	BEGIN
		SELECT @s_codigo_respuesta = 101474,
			@s_mensaje_usuario = 'DEBE INGRESAR NUMERO DE IDENTIFICACION'

		RETURN @s_codigo_respuesta
	END

	-- TRANSFORMACION DE NEMONICO DE TIPO DE CUENTAS A ID TIPO CUENTA
	IF @e_tipo_cuenta = 'AHO'
	BEGIN
		SELECT @v_tipo_cuenta = 4
	END
	ELSE IF @e_tipo_cuenta = 'CTE'
	BEGIN
		SELECT @v_tipo_cuenta = 3
	END
	ELSE IF @e_tipo_cuenta = 'BAS'
	BEGIN
		SELECT @v_tipo_cuenta = 12
	END
	ELSE IF @e_tipo_cuenta = 'VIR'
	BEGIN
		SELECT @v_tipo_cuenta = 12
	END

	IF (@e_servicio = 'TRANSWIFT')
	BEGIN
		IF (@e_pais IS NULL)
		BEGIN
			SELECT @s_codigo_respuesta = 300003488,
				@s_mensaje_usuario = 'PAIS DESTINO ES OBLIGATORIO'

			RETURN @s_codigo_respuesta
		END

		IF (@e_cargo IS NULL)
		BEGIN
			SELECT @s_codigo_respuesta = 300003497,
				@s_mensaje_usuario = 'TIPO DE CARGO ES OBLIGATORIO'

			RETURN @s_codigo_respuesta
		END
	END

	-- BUSCA TIPO DE COMISION
	EXEC @v_retorno = cob_internet..pa_cash_cfuncionalidad 
		@e_id_funcionalidad = @e_id_funcionalidad,
		@e_ambito = 'BE',
		@e_tipo_cuenta = @e_tipo_cuenta,
		@e_codigo_empresa_proveedora = @e_codigo_empresa_proveedora, -- REF03
		@s_tf_tipoComision = @v_tipo_comision OUTPUT,
		@s_tf_opcion = @v_opcion OUTPUT,
		@s_tf_tabla = @v_tabla OUTPUT,
		@s_tf_codigo = @v_codigo OUTPUT,
		@s_tf_rubro = @v_rubro OUTPUT,
		@s_tf_canal = @s_canal OUTPUT,
		@s_codigo_respuesta = @s_codigo_respuesta OUTPUT,
		@s_mensaje_usuario = @s_mensaje_usuario OUTPUT,
		@s_tf_transaccion = @v_transaccion OUTPUT,
		@s_tf_causa = @s_causa OUTPUT,
		@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario OUTPUT --REF2

	IF (@v_opcion = 'X')
	BEGIN
		SELECT @s_es_motor = 'S'
	END

	IF (@v_opcion <> 'X')
	BEGIN
		SELECT @s_es_motor = 'N'
	END

	IF @v_retorno <> 0
	BEGIN
		IF (
				@v_retorno = 1621006
				AND @e_se_debita = 'false'
				AND @s_es_motor = 'N'
				)
		BEGIN
			SELECT @s_codigo_respuesta = 0,
				@s_mensaje_usuario = convert(VARCHAR(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario,
				@s_comision = 0

			RETURN @s_codigo_respuesta
		END

		IF (
				@v_retorno = 1621006
				AND @e_se_debita = 'true'
				)
		BEGIN
			SELECT @s_codigo_respuesta = 0,
				@s_mensaje_usuario = convert(VARCHAR(10), @s_codigo_respuesta) + ' - ' + @s_mensaje_usuario,
				@s_comision = 0

			RETURN @s_codigo_respuesta
		END

		RETURN @s_codigo_respuesta
	END

	IF @s_codigo_respuesta <> 0
	BEGIN
		RETURN @s_codigo_respuesta
	END

	IF (
			@e_se_debita = 'true'
			AND (
				@v_transaccion IS NULL
				OR @s_causa IS NULL
				)
			)
	BEGIN
		SELECT @s_codigo_respuesta = 5005029,
			@s_mensaje_usuario = 'NO EXISTE TRANSACCION O CAUSA DEFINIDA PARA DEBITO'

		RETURN @s_codigo_respuesta
	END

	SELECT @s_transaccion = convert(INT, @v_transaccion)

	--PERSON
	IF (@v_opcion <> 'X')
	BEGIN
		EXEC @v_retorno = cob_internet..pa_cash_cprocesar_tarifaBPersn 
			@e_identificacion = @e_identificacion,
			@e_servicio = @e_servicio,
			@e_id_funcionalidad = @e_id_funcionalidad,
			@e_canal = @e_canal,--'IBK', REF02 jvillavc
			@e_codigo_empresa_proveedora = @e_codigo_empresa_proveedora,
			@e_accion_revocatoria_ch = @e_accion_revocatoria_ch,
			@e_cuenta = @e_cuenta,
			@e_tipo_impuesto_fiscal = @e_tipo_impuesto_fiscal,
			@e_codigo_empresa = @e_codigo_empresa,
			@e_tipo_cuenta = @e_tipo_cuenta,
			@e_pais = @e_pais,
			@e_opcion = @v_opcion,
			@e_tabla = @v_tabla,
			@e_cod_servicio = @v_codigo,
			@e_rubro = @v_rubro,
			@s_comision = @s_comision OUTPUT,
			@s_codigo_respuesta = @s_codigo_respuesta OUTPUT,
			@s_mensaje_usuario = @s_mensaje_usuario OUTPUT,
			@e_se_debita = @e_se_debita,
			@s_tf_cobrado_en_tarifario = @s_cobrado_en_tarifario OUTPUT --REF2

		IF @v_retorno <> 0
		BEGIN
			RETURN @s_codigo_respuesta
		END

		IF (@e_alcance = 'E')
		BEGIN
			SELECT @s_comision = 0
		END

		RETURN 0
	END

	DECLARE @v_codigo_producto INT

	-- BUSCA CODIDO DE PRODUCTO SEGUN EL SERVICIO
	SELECT @v_codigo_producto = se_cod_producto
	FROM db_biz_admempresa..ba_servicio
	WHERE se_cod_servicio = @e_servicio
		AND se_est_servicio = 'A'

	IF @@rowcount = 0
	BEGIN
		SELECT @s_codigo_respuesta = 101032,
			@s_mensaje_usuario = 'No existe producto'

		RETURN @s_codigo_respuesta
	END

	SET @s_mensaje_usuario = 'N'

	-- VERIFICA SI A EMPRESA YA HA SIDO MIGRADA
	EXEC @v_retorno = db_biz_admempresa..sp_con_parametroconf 
		@i_empresa = @e_codigo_empresa,
		@i_producto = @v_codigo_producto,
		@i_servicio = @e_servicio,
		@i_parametro = 'BIZTARIFARIO',
		@o_pa_val_booleano = @s_mensaje_usuario OUTPUT

	IF @v_retorno <> 0
	BEGIN
		SELECT @s_codigo_respuesta = 5005041,
			@s_mensaje_usuario = 'NO SE HA PODIDO VERIFICAR SI LA EMPRESA SE ENCUENTRA MIGRADA'

		RETURN @s_codigo_respuesta
	END

	SELECT @s_mensaje_usuario = isnull(@s_mensaje_usuario, 'N')

	IF @s_mensaje_usuario <> 'N'
	BEGIN
		SELECT @s_segmento = en_segmento_cart
		FROM cobis..cl_ente
		WHERE en_ced_ruc = @e_identificacion

		IF @@rowcount = 0
		BEGIN
			SELECT @s_codigo_respuesta = 101742,
				@s_mensaje_usuario = 'No existe Segmento o Marca'

			RETURN @s_codigo_respuesta
		END

		EXEC @v_retorno = cob_internet..pa_cash_ctablaparam 
			@e_tabla = 'cash_forma_pago_tarif',
			@e_parametro = @e_forma_pago,
			@s_valor = @s_forma_pago OUTPUT,
			@s_codigo_respuesta = @s_codigo_respuesta OUTPUT,
			@s_mensaje_usuario = @s_mensaje_usuario OUTPUT

		IF @v_retorno <> 0
		BEGIN
			SELECT @s_codigo_respuesta = 101462,
				@s_mensaje_usuario = 'NO EXISTE CODIGO DE FORMA DE PAGO'

			RETURN @s_codigo_respuesta
		END

		SELECT @v_producto_com = right('00' + convert(VARCHAR, @v_codigo_producto), 2)

		SELECT TOP 1 @s_tipo_comision = ct_otro_campo_catalogo
		FROM db_biz_admempresa..ba_tabla,
			db_biz_admempresa..ba_catalogo
		WHERE ltrim(rtrim(tb_nom_tabla)) = 'ad_comisiones'
			AND tb_cod_tabla = ct_cod_tabla
			AND substring(ct_cod_catalogo, 1, 2) = @v_producto_com
			AND substring(ct_cod_catalogo, 3, 6) = left(@e_servicio, 6)
			AND ct_est_catalogo = 'A'
			AND right(ct_cod_catalogo, 2) = @v_tipo_comision

		IF @@rowcount = 0
		BEGIN
			SELECT @s_codigo_respuesta = 300003360,
				@s_mensaje_usuario = 'NO EXISTE REGISTRO DE PARAMETRO COMISION '

			RETURN @s_codigo_respuesta
		END

		IF @e_tipo_cuenta = 'AHO'
		BEGIN
			SELECT @s_tipo_cuenta = '10'
		END
		ELSE IF @e_tipo_cuenta = 'CTE'
		BEGIN
			SELECT @s_tipo_cuenta = '00'
		END

		SELECT @s_codigo_respuesta = 300003478,
			@s_mensaje_usuario = 'EMPRESA YA SE ENCUENTRA MIGRADA'

		RETURN @s_codigo_respuesta
	END

	IF @e_pais IS NOT NULL
	BEGIN
		SELECT @v_codigo_empresa = convert(VARCHAR(10), @e_codigo_empresa)

		EXEC @v_retorno = db_biz_pagos..sp_con_valor_comi_swift 
			@i_pais = @e_pais,
			@i_cuenta_deb = @v_codigo_empresa, --'0558' ,
			@i_tipo_cta = @e_tipo_cuenta,
			@i_cargos = @e_cargo,
			@i_banco = @e_banco,
			@i_canal = 'SAT',
			@o_valor = @s_comision OUT,
			@o_valor2 = @s_costo_envio OUT,
			@i_cuenta_emp = @e_cuenta, -- '0005188774' ,
			@i_tipo_ctaemp = @v_tipo_cuenta,
			@o_existe_cat = 'N',
			@i_monto = @e_monto

		IF @e_alcance = 'E'
		BEGIN
			IF @e_cargo = 'SHA'
			BEGIN
				SELECT @s_comision
			END
		END

		IF @e_alcance = 'C'
		BEGIN
			SELECT @s_comision
		END

		IF @v_retorno <> 0
		BEGIN
			SELECT @s_codigo_respuesta = 300003479,
				@s_mensaje_usuario = 'NO SE HA PODIDO DETERMINAR COMISION'

			RETURN @s_codigo_respuesta
		END

		IF @v_retorno = 0
		BEGIN
			SELECT @s_codigo_respuesta = 0,
				@s_mensaje_usuario = 'TRANSACCION EXITOSA'

			RETURN @s_codigo_respuesta
		END

		RETURN 0
	END

	IF (@e_alcance = 'E')
	BEGIN
		SET @v_tipo_comision = '01'
	END
	ELSE IF (@e_alcance = 'C')
	BEGIN
		SET @v_tipo_comision = '02'
	END

	SELECT @v_canal_homologado = ct_nom_catalogo
	FROM db_biz_admempresa..ba_tabla
	INNER JOIN db_biz_admempresa..ba_catalogo ON tb_cod_tabla = ct_cod_tabla
	WHERE tb_nom_tabla = 'bib_homologacion_forma_pago'
		AND ct_cod_catalogo = @e_forma_pago
		AND tb_est_tabla = 'A'
		AND ct_est_catalogo = 'A'

	-- SE PROCEDE A CONSULTAR LA COMISION
	EXEC @v_retorno = db_biz_admempresa..sp_con_comision 
		@i_cod_empresa = @e_codigo_empresa,
		@i_cod_producto = @v_codigo_producto,
		@i_cod_servicio = @e_servicio,
		@i_cod_canal = @v_canal_homologado,
		@i_cod_alcance = @e_alcance,
		@i_tip_comision = @v_tipo_comision,
		@i_secuencia = 1,
		@i_aplcobis = 'N',
		@o_valor_por_tran = @s_comision OUTPUT

	IF @v_retorno <> 0
		AND @v_retorno <> 25100
	BEGIN
		SELECT @s_codigo_respuesta = 300003479,
			@s_mensaje_usuario = 'NO SE HA PODIDO DETERMINAR COMISION'

		RETURN @s_codigo_respuesta
	END

	IF @v_retorno = 25100
	BEGIN
		SELECT @s_comision = 0,
			@s_codigo_respuesta = 0,
			@s_mensaje_usuario = 'TRANSACCION EXITOSA'
	END

	IF @s_comision IS NOT NULL
	BEGIN
		SELECT @s_codigo_respuesta = 0,
			@s_mensaje_usuario = 'TRANSACCION EXITOSA'

		RETURN @s_codigo_respuesta
	END
	ELSE
	BEGIN
		SELECT @s_codigo_respuesta = 300003479,
			@s_mensaje_usuario = 'NO SE HA PODIDO DETERMINAR COMISION'

		RETURN @s_codigo_respuesta
	END

	RETURN 0
end


go
grant execute on pa_cash_cprocesar_tarifaBE to apl_osb_hpact
go

if exists(select 1 from sysobjects where name='pa_cash_cprocesar_tarifaBE' and type = 'P')
  PRINT '== CREATE PROCEDURE pa_cash_cprocesar_tarifaBE *OK* =='
 else
  PRINT '<<< CREATE PROCEDURE pa_cash_cprocesar_tarifaBE -- ERROR -- >>>'
  
go