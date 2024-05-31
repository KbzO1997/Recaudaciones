/**************************************************************************/
/*  Archivo:            ccde0017.sql                                      */
/*  Base de datos:      db_general                                        */
/*  Motor de Base:      SYBASE                                      	  */
/*  Servidor:           HP-ACT                                   		  */
/*  Aplicacion:         CyberBank                                  		  */
/*  Producto:           Recaudaciones                                     */
/*  Procesamiento:      BATCH                                        	  */
/*  Disenado por:       Dario Espinosa Aldean                             */
/*  Fecha de escritura: 04/Mar/2022                                       */
/**************************************************************************/
/*              IMPORTANTE                                                */
/*  Este programa es parte de los paquetes bancarios propiedad de         */
/*  "BANCO BOLIVARIANO".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier  */
/*  alteracion o agregado hecho por alguno de sus usuarios sin el debido  */
/*  consentimiento por escrito de la Presidencia Ejecutiva de             */
/*  BANCO BOLIVARIANO o su representante.                                 */
/**************************************************************************/
/*              PROPOSITO                                                 */
/*  Este programa crea la estructura para almacenar la información de las */
/*  Transacciones para el Archivo Consolidado de Banred                   */
/*********************************************************************************/
/*                              MODIFICACIONES                                   */
/*REF  FECHA       AUTOR          RAZON                      TAREA               */
/*01 04/Mar/2022 Dario Espinosa  Emisión Inicial    RECM-1368 CONCILIACION CNEL BANRED */
/*********************************************************************************/

use db_general
go

declare @w_instruccion varchar(50)
if exists (select 1 from sysobjects where name = 'reca_tmp_concilia_banred' and type = 'U')
  begin
     set @w_instruccion = 'drop table reca_tmp_concilia_banred'
     exec(@w_instruccion)
     print 'Tabla Borrada correctamente..'
  end
go

create table db_general..reca_tmp_concilia_banred(
     tc_tipo_transaccion int, 
     tc_secuencial       int, 
     tc_tsfecha          smalldatetime,
     tc_hora_tran        smalldatetime,
     tc_empresa          int,
     tc_referencia       varchar(15) null,
     tc_sec_bred         int null,
     tc_usuario          varchar(64),
     tc_terminal         varchar(64) null,
     tc_correccion       char(1) default 'N',
     tc_ssn_corr         int null,
     tc_tipocta          char(1) null,
     tc_cta_banco        varchar(24) null,
     tc_tipocta_bred     char(2) null,
     tc_oficina          smallint,
     tc_ciudad_of        varchar(64),
     tc_moneda           tinyint,
     tc_valor_total      bigint default 0,
     tc_comision         bigint default 0,
     tc_valor_servicio   int default 0,
     tc_subtipo_trans    char(6) null,
     tc_tipo_pago        char(3) null,
     tc_tipo_registro    varchar(5) null,
     tc_ori_registro     varchar(5) null,
     tc_servicio         varchar(10) null,
     tc_tipo_proceso     varchar(5) null,
     tc_tipo_disp        varchar(5) null,
     tc_cod_autoriza     varchar(15) null,
     tc_tipocta_dest     char(2) null,
     tc_cta_banco_dest   varchar(24) null,
     tc_unidad_negocio   varchar(6)
)
go


if exists (select 1 from sysobjects where name = 'reca_tmp_concilia_banred' and type = 'U')
  print 'Tabla reca_tmp_concilia_banred creada correctamente..'

go
