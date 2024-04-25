create proc sp_seqnos (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@i_tabla 	        varchar(30), 
	@o_siguiente 		int=null out
	)
as
declare @w_return       int,
        @w_sp_name      varchar(30),
	@w_num_error	int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = name
  from sysobjects
 where id = @@procid

/*  Modo de debug  */
if @t_debug = 'S'
begin
        exec cobis..sp_begin_debug @t_file = @t_file
        select  '/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn			   = @s_ssn,
		s_user			   = @s_user,
		s_sesn			   = @s_sesn,
		s_term			   = @s_term,	
		s_date			   = @s_date,	
		s_srv			   = @s_srv,	
		s_lsrv			   = @s_lsrv,	
		s_rol			   = @s_rol,
		s_ofi			   = @s_ofi,
		s_org_err		   = @s_org_err,
		s_error			   = @s_error,
		s_sev			   = @s_sev,
		s_msg			   = @s_msg,
		s_org			   = @s_org,
		t_debug			   = @t_debug,	
		t_file			   = @t_file,
		t_from			   = @t_from,
		i_tabla			   = @i_tabla
        exec cobis..sp_end_debug
end

select @o_siguiente = null

begin tran
   --actualizar la tabla
   update re_seqnos
      set siguiente = siguiente + 1
    where tabla = @i_tabla
   if @@error != 0
   begin
      --Error en actualizacion de seqnos
      select @w_num_error = 105001
      goto lbl_error
   end

   --retornar el nuevo secuencial
   select @o_siguiente = siguiente
     from re_seqnos
    where tabla = @i_tabla

   --validar si existe la tabla,
   --no se lo hace al inicio para evitar compartir el recurso -> deadlocks
   if @o_siguiente = null
   begin
      --No existe tabla
      select @w_num_error = 151028
      goto lbl_error
   end

   --mensaje si secuencial llega al limite
   if @o_siguiente = 2147483647
      print 'Secuencial llego al limite'

   if @t_debug = 'S'
   begin
      exec cobis..sp_begin_debug @t_file = @t_file
      select o_siguiente = @o_siguiente
      exec cobis..sp_end_debug
   end

commit tran

return 0

lbl_error:
   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_num_error

   return 1

