use cob_cuentas
go

if exists (select 1 from sysobjects where name = 'pruebarecaudaciones' and type='P')
 begin
   drop procedure dbo.pruebarecaudaciones
   if exists (select 1 from sysobjects where name = 'pruebarecaudaciones' and type='P')
   PRINT  '<<< drop procedure pruebarecaudaciones  error -->>>'
   else
   PRINT  '<<< drop procedure pruebarecaudaciones  OK -->>>'
   end   
go

create procedure dbo.pruebarecaudaciones  (
        @e_cuenta         varchar(10),
        @e_tipocta          varchar(3),
		@e_debito       money
)
as
if @e_cuenta = "0005247004"
	return 0
else
	return 25060
go

if exists (select 1 from sysobjects where name = 'pruebarecaudaciones' and type='P')
   PRINT  '<<< CREATE PROCEDURE  pruebarecaudaciones  OK -->>>'
   else
   PRINT  '<<< CREATE PROCEDURE pruebarecaudaciones  ERROR -->>>'
go

grant execute on pruebarecaudaciones to apl_osb_hpdes
go