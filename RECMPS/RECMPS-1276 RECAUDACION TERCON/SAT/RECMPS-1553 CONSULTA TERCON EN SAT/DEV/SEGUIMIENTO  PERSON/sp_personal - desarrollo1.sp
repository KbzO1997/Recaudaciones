create proc sp_personal (

        @s_ssn          int,

        @s_srv          varchar(30),

        @s_lsrv         varchar(30),

        @s_user         varchar(30),

        @s_sesn         int,

        @s_term         varchar(10),

        @s_date         datetime,

        @s_ofi          smallint,

        @s_rol          smallint = 1,

        @s_org_err      char(1)  = null,

        @s_error        int      = null,

        @s_sev          tinyint  = 0,

        @s_msg          mensaje  = null,

        @s_org          char(1),

        @t_rty          char(1) = 'N',

        @t_from         char(1) = null,

        @t_debug        char(1) = 'N',

        @t_file         char(1) =  null,

        @t_trn          int,

        @i_tipo         tinyint,

        @i_modo         tinyint = null,

        @i_fdate        tinyint = 101,

        @i_prodCobis    tinyint = null,

        @i_prodBanc     smallint = null,

        @i_tipoEnte     char(1) = 'P',

        @i_rubro        char(4) = null,

        @i_servicioDisp smallint = null,

        @i_servicioPer  smallint = null,

        @i_tipoServ     char(1) = 'R',

        @i_moneda       tinyint = null,

        @i_descripcion  char(64) = null,

        @i_tipoRango    tinyint = null,

        @i_grupoRango   smallint = null,

        @i_rango        tinyint = null,

        @i_categoria    char(10) = null,

        @i_oficina      smallint = null,

        @i_valorMedio   real = null,

        @i_valorMinimo  real = null,

        @i_valorMaximo  real = null,

        @i_secCosto     int  = null,

        @i_fechaVigenc  datetime = null,

        @i_secuencial   int = null,

	     @i_canal	      catalogo = null,		--VIVI, 29/Ago/2003

	     @i_sec		      int = null,        /*@i_secuencial     char(10) = null*/

	     @i_ubicacion    smallint = null    /*JPM 08112004*/



)

as

declare @w_sp_name        descripcion,

        @w_mercado        smallint,

        @w_servicioPer    smallint,

        @w_secCosto       int,

        @numreg           real,

        @w_estado_mercado char(1),

   @w_mensaje    descripcion,

        @w_return         int ,

        @w_producto       tinyint,

        @w_operacion      char(1)



/*  Captura nombre de Stored Procedure  */



select  @w_sp_name = 'sp_personal'







/*  Activacion del Modo de debug  */



if @t_debug = "S"

  begin

        exec @w_return = cobis..sp_begin_debug @t_file = @t_file

        select "/** Store Procedure **/ " = @w_sp_name,

                s_ssn           = @s_ssn,

                s_srv           = @s_srv,

                s_lsrv          = @s_lsrv,

                s_user          = @s_user,

                s_sesn          = @s_sesn,

                s_term          = @s_term,

                s_date          = @s_date,

                s_ofi           = @s_ofi,

                s_rol           = @s_rol,

                s_org_err       = @s_org_err,

                s_error         = @s_error,

                s_sev           = @s_sev,

                s_msg           = @s_msg,

                s_ori           = @s_org,

                t_rty           = @t_rty,

                t_from          = @t_from,

                t_file          = @t_file,

                t_trn           = @t_trn



        exec cobis..sp_end_debug

  end



  if @t_trn != 3675

  begin

     /* Error en codigo de transaccion */

     exec cobis..sp_cerror

          @t_debug        = @t_debug,

          @t_file         = @t_file,

          @t_from         = @w_sp_name,

          @i_num          = 171516

     return 1

  end



  set rowcount 0



  /* Consulta los servicios personalizados */

      if @i_tipo = 0

      begin

         set rowcount 20

         if @i_modo = 0

         begin

              select

                    'Descripc.Servicio' = substring(vs_descripcion,1,35),

                    'Tipo Rango' = sp_tipo_rango,

                    'Grupo Rango' = sp_grupo_rango,

                    'Rubro' = sp_rubro,

                    'Descripc.Prod.' = substring(pf_descripcion,1,35),

                    'Servic.Disp.' = sp_servicio_dis,

                    'Moneda' = pf_moneda,

                    'Descripc.Moneda' = substring(mo_descripcion,1,35),

                    'Mercado' = me_mercado,

                    'Fecha Estado' = convert(varchar(11), me_fecha_estado, @i_fdate),

                    'Estado Merc.' = substring(me_estado,1,1),

                    'Prod.Cobis' = pf_producto,

                    'Descripc.Prod.Cobis' = substring(pd_descripcion,1,35),

                    'Tipo Prod.' = substring(pf_tipo,1,1),

                    'Serv.Personaliz.' = sp_servicio_per

              from pe_mercado

                   , pe_pro_final

                   , pe_servicio_per

                   , pe_var_servicio

                   , cobis..cl_moneda m

                   , cobis..cl_producto

              where me_tipo_ente = @i_tipoEnte

                    and me_pro_bancario = @i_prodBanc

                    and pd_producto = pf_producto

                    and me_mercado = pf_mercado

                    and pf_mercado = sp_mercado

                    and pf_producto = sp_producto

                    and pf_moneda = sp_moneda

                    and pf_tipo = sp_tipo

                    and vs_servicio_dis = sp_servicio_dis

                    and vs_rubro = sp_rubro

                    and mo_moneda = pf_moneda

                    and mo_moneda = sp_moneda

          and vs_descripcion like @i_descripcion

              order by sp_servicio_per



              if @@rowcount = 0

               begin

                  exec cobis..sp_cerror

                      @t_debug     = @t_debug,

                      @t_file      = @t_file,

                      @t_from      = @w_sp_name,

                      @i_num       = 1901003

                  rollback tran

                  return 0

               end

         end



         if @i_modo = 1

         begin

              select

                    'Descripc.Servicio' = substring(vs_descripcion,1,35),

                    'Tipo Rango' = sp_tipo_rango,

                    'Grupo Rango' = sp_grupo_rango,

                    'Rubro' = sp_rubro,

                    'Descripc.Prod.' = substring(pf_descripcion,1,35),

                    'Servic.Disp.' = sp_servicio_dis,

                    'Moneda' = pf_moneda,

                    'Descripc.Moneda' = substring(mo_descripcion,1,35),

                    'Mercado' = me_mercado,

                    'Fecha Estado' = convert(varchar(11), me_fecha_estado, @i_fdate),

                    'Estado Merc.' = substring(me_estado,1,35),

                    'Prod.Cobis' = pf_producto,

                    'Descripc.Prod.Cobis' = substring(pd_descripcion,1,35),

                    'Tipo Prod.' = substring(pf_tipo,1,1),

                    'Serv.Personaliz.' = sp_servicio_per

               from pe_mercado

                    , pe_pro_final

                    , pe_servicio_per

                    , pe_var_servicio

                    , cobis..cl_moneda m

                    , cobis..cl_producto

               where me_tipo_ente = @i_tipoEnte

                     and me_pro_bancario = @i_prodBanc

                     and sp_servicio_per > @i_servicioPer

                     and pd_producto = pf_producto

                     and me_mercado = pf_mercado

                     and pf_mercado = sp_mercado

                     and pf_producto = sp_producto

                     and pf_moneda = sp_moneda

                     and pf_tipo = sp_tipo

                     and vs_servicio_dis = sp_servicio_dis

                     and vs_rubro = sp_rubro

                     and mo_moneda = pf_moneda

                     and mo_moneda = sp_moneda

           and vs_descripcion like @i_descripcion

               order by sp_servicio_per

         end

       end





  /* Consulta los costos de los servicios personalizados */



set rowcount 0

/** POR PETICION DE PRODUCTOS SE CREA TABLA TEMPORAL PARA ORDENAR **/

/** LOS DATOS DE LOS COSTOS POR CATEGORIA Y CANAL.		  **/

--VIVI, 1/Oct/2003

if @i_tipo = 1

begin



	create table #costos (

	co_secuencial 	  int  ,

	pf_descripcion 	  varchar(35),

	co_tipo_rango	  tinyint,

	tr_descripcion	  varchar(35),

	co_grupo_rango	  smallint,

	co_rango	  tinyint,

	ra_desde	  money,

	ra_hasta	  money,

	co_categoria	  varchar(3),

	valor		  varchar(35),

	co_fecha_vigencia varchar(11),

	co_val_medio	  money,

	co_minimo	  money,

	co_maximo	  money,

	sp_servicio_per	  smallint,

	co_canal	  varchar(4) null,

	co_ubicacion smallint null,         /*JPM*/

	ou_descripcion varchar(64) null,

	co_sec		  numeric(12,0) identity )



	insert into #costos

	select  co_secuencial, substring(pf_descripcion,1,35), co_tipo_rango, substring(tr_descripcion,1,35),

	 	co_grupo_rango, co_rango, ra_desde, ra_hasta, co_categoria, substring(t.valor,1,35),

	 	convert(varchar(11), co_fecha_vigencia, @i_fdate), convert(money, co_val_medio),

	 	convert(money, co_minimo), convert(money, co_maximo), sp_servicio_per, co_canal,

	 	co_ubicacion, ou_descripcion

         from pe_mercado, pe_pro_final, pe_servicio_per, pe_costo,

	      pe_tipo_rango, pe_rango, cobis..cl_tabla c, cobis.. cl_catalogo t,

	      re_ofic_ubicacion

        where me_tipo_ente = @i_tipoEnte

              and me_pro_bancario = @i_prodBanc

              and pf_moneda = @i_moneda

              and me_mercado = pf_mercado

              and sp_tipo = @i_tipoServ

              and sp_servicio_dis = @i_servicioDisp

	      and sp_servicio_per = @i_servicioPer	--VIVI, 1/Oct/2003

              and sp_rubro = @i_rubro

              and pf_mercado = sp_mercado

              and pf_producto = sp_producto

              and pf_moneda = sp_moneda

              and sp_servicio_per = co_servicio_per

              and sp_tipo_rango = co_tipo_rango

              and sp_grupo_rango = co_grupo_rango

              and ra_tipo_rango = co_tipo_rango

              and ra_grupo_rango = co_grupo_rango

              and ra_rango = co_rango

              and tr_tipo_rango = ra_tipo_rango

              and tr_tipo_rango = co_tipo_rango

              and co_oficina  = @i_oficina

              and co_oficina *= ou_oficina           /*JPM 08112004*/

              and co_ubicacion *= ou_ubicacion       /*JPM 08122004*/

              and (co_ubicacion = @i_ubicacion or @i_ubicacion is null)      /*JPM 08112004*/

              and c.tabla = 'pe_categoria'

              and c.codigo = t.tabla

              and t.codigo = co_categoria

              and (ra_rango = @i_rango or @i_rango = null )

	      and (co_canal  = @i_canal or @i_canal is null) --VIVI, 29/Ago/2003

          order by co_canal, co_categoria





end



    if @i_tipo = 1  and @i_modo = 0

    begin

            set rowcount 15

            select

                     'Sec.' = co_secuencial,

                     'Produc.Final'= pf_descripcion,

                     'Tipo Rango' = co_tipo_rango,

                     'Descripc.Rango' = tr_descripcion,

                     'Grupo Rango' = co_grupo_rango,

                     'Rango' = co_rango,

                     'Desde'= ra_desde,

                     'Hasta'= ra_hasta,

                     'Categoria' = co_categoria,

                     'Descripc.Categoria' = valor,

                     'Fecha Vig.' = co_fecha_vigencia,

                     'Valor Medio'= co_val_medio,

                     'Valor Min.' = co_minimo,

                     'Valor Max.' = co_maximo,

                     'Serv.Person.' = sp_servicio_per,

		    'Canal ' = co_canal,		--VIVI, 29/Ago/2003

		    'Ubicacion' = co_ubicacion,            /*JPM 08112004*/

		    'Descrip.Ubicacion' = ou_descripcion,  /*JPM 08112004*/

		    'Sec' = co_sec

              from   #costos

           return 1

    end



    if @i_tipo = 1 and @i_modo = 1

    begin

            set rowcount 15

               select 'Sec.' = co_secuencial,

                    'Produc.Final'= pf_descripcion,

                    'Tipo Rango' = co_tipo_rango,

                    'Descripc.Rango' = tr_descripcion,

                    'Grupo Rango' = co_grupo_rango,

                    'Rango' = co_rango,

                    'Desde'= ra_desde,

                    'Hasta'= ra_hasta,

                    'Categoria' = co_categoria,

                    'Descripc.Categoria' = valor,

          	    'Fecha Vig.' = co_fecha_vigencia,

                    'Valor Medio'= co_val_medio,

                    'Valor Min.' = co_minimo,

                    'Valor Max.' = co_maximo,

                    'Serv.Person.' = sp_servicio_per,

		    'Canal ' = co_canal,		--VIVI, 29/Ago/2003

		    'Ubicacion' = co_ubicacion,            /*JPM 08112004*/

		    'Descrip.Ubicacion' = ou_descripcion,  /*JPM 08112004*/

		    'Sec' = co_sec

               from #costos

    	       where co_sec > @i_sec

           return 1

   end





  /* Verifica que existan variables de servicio, tipo de rango y rango */

         if @i_tipo = 2 or @i_tipo = 5

         begin



            select @numreg = count(pb_pro_bancario) from pe_pro_bancario

            where pb_pro_bancario = @i_prodBanc

                  and pb_estado = 'V'



            if @numreg = 0

            begin

               print 'El producto bancario no se encuentra disponible'

               return 1

            end



            select @numreg = count(sd_servicio_dis) from pe_servicio_dis

            where sd_servicio_dis = @i_servicioDisp

                  and sd_estado = 'V'



            if @numreg = 0

            begin

               print 'El servicio no se encuentra disponible'

               return 1

            end





            select @numreg = count(vs_servicio_dis) from pe_var_servicio

            where vs_servicio_dis = @i_servicioDisp

                  and vs_rubro = @i_rubro

                  and vs_estado = 'V'



            if @numreg = 0

            begin

               print 'La variable de servicio no se encuentra disponible'

               return 1

            end

         end



         if @i_tipo = 5

         begin



            select @numreg = count(tr_tipo_rango) from pe_tipo_rango

            where tr_tipo_rango = @i_tipoRango

                  and tr_estado = 'V'



            if @numreg = 0

            begin

               print 'Eltipo de rango no se encuentra disponible'

               return 1

            end



            select @numreg = count(ra_tipo_rango) from pe_rango

            where ra_tipo_rango = @i_tipoRango

                  and ra_grupo_rango = @i_grupoRango

                  and ra_rango = @i_rango

                  and ra_estado = 'V'



            if @numreg = 0

            begin

               print 'El rango no se encuentra disponible'

               return 1

            end

         end



  /* Inserta un nuevo servicio personalizable */



         if @i_tipo = 2

         begin



            begin tran

            /* Se verifica la existencia de mercado. Si no existe, se inserta un nuevo registro */



            select @w_mercado = me_mercado,

                   @w_estado_mercado = me_estado

            from pe_mercado

            where me_tipo_ente = @i_tipoEnte

                  and me_pro_bancario = @i_prodBanc



            if @@rowcount = 0

            begin

               exec cobis..sp_cseqnos

                    @t_debug = @t_debug,

                    @t_file = @t_file,

                    @t_from = @w_sp_name,

                    @i_tabla = 'pe_mercado',

                    @o_siguiente = @w_mercado out

               print 'dat01'

               insert into pe_mercado (me_mercado, me_tipo_ente, me_pro_bancario,

                                       me_estado, me_fecha_estado)

                      values (@w_mercado, @i_tipoEnte, @i_prodBanc,

                              'V', getdate())



               if @@error != 0

               begin /* Error en creacion de mercado */

               print 'dat02'

                  exec cobis..sp_cerror

                       @t_debug  = @t_debug,

                       @t_file   = @t_file,

                       @t_from   = @w_sp_name,

                       @i_num    = 033005

                  rollback tran

                  return 1

               end

            end

            else

               if @w_estado_mercado != 'V'

                  update pe_mercado set me_estado = 'V'

                     where me_mercado = @w_mercado



            /* Se verifica la existencia de producto final. Si no existe, entonces */

            /* se inserta un nuevo registro                                        */



            select pf_mercado from pe_pro_final

                   where pf_mercado = @w_mercado and pf_producto = @i_prodCobis

                         and pf_moneda = @i_moneda and pf_tipo = @i_tipoServ



            if @@rowcount = 0

               insert into pe_pro_final (pf_mercado, pf_producto, pf_moneda,

                                         pf_tipo, pf_descripcion)

                      values (@w_mercado, @i_prodCobis, @i_moneda,

                              @i_tipoServ, @i_descripcion)



               if @@error != 0

               begin /* Error en creacion de producto final */

               print 'dat03'

                  exec cobis..sp_cerror

                       @t_debug  = @t_debug,

                       @t_file   = @t_file,

                       @t_from   = @w_sp_name,

                       @i_num    = 033005

                  rollback tran

                  return 1

               end



            /* Se verifica la existencia del servicio personalizado.               */

            /* Si no existe, se inserta un nuevo registro                          */



            select @numreg = count(sp_servicio_per) from pe_servicio_per

            where sp_mercado = @w_mercado

                  and sp_producto = @i_prodCobis

                  and sp_moneda = @i_moneda

                  and sp_tipo = @i_tipoServ

                  and sp_servicio_dis = @i_servicioDisp

                  and sp_rubro = @i_rubro

                  and sp_tipo_rango = @i_tipoRango

                  and sp_grupo_rango = @i_grupoRango



            if @numreg = 0

            begin

               exec cobis..sp_cseqnos

                    @t_debug = @t_debug,

                    @t_file = @t_file,

                    @t_from = @w_sp_name,

                    @i_tabla = 'pe_servicio_per',

                    @o_siguiente = @w_servicioPer out



               insert into pe_servicio_per

         (sp_servicio_per, sp_mercado, sp_producto, sp_moneda,

                                            sp_tipo, sp_servicio_dis, sp_rubro,

                                            sp_tipo_rango, sp_grupo_rango)

                    values (@w_servicioPer, @w_mercado, @i_prodCobis, @i_moneda,

                              @i_tipoServ, @i_servicioDisp, @i_rubro,

                              @i_tipoRango, @i_grupoRango)



               if @@error != 0

               begin /* Error en creacion de servicio personalizado */

               print 'dat04'

                  exec cobis..sp_cerror

                       @t_debug  = @t_debug,

                       @t_file   = @t_file,

                       @t_from   = @w_sp_name,

                       @i_num    = 033005

                  rollback tran

                  return 1

               end

            end

          else

           begin

            print'NO SE PUEDEN INSERTAR REGISTROS REPETIDOS'

           end







           commit tran

         end



   /* Inserta un nuevo costo de un servicio personalizable */

         if @i_tipo = 5

         begin

            /* Se verifica la existencia de costo. Si no existe, se inserta un nuevo registro */

            select @w_secCosto = co_secuencial

                   from pe_costo

                   where co_servicio_per = @i_servicioPer

                         and co_categoria = @i_categoria

                         and co_tipo_rango = @i_tipoRango

                         and co_grupo_rango = @i_grupoRango

                         and co_rango = @i_rango

                         and co_oficina = @i_oficina

                         and co_ubicacion = @i_ubicacion /*JPM 08112004*/

			 and co_canal   = @i_canal --VIVI, 29/Ago/2003



            if @@rowcount = 0

               select @w_operacion = 'I'

            else

               select @w_operacion = 'M'



            select @w_producto = sp_producto from pe_servicio_per where sp_servicio_per = @i_servicioPer

            /* Transaccion de Servicio */ /* TOMI */

            insert into pe_tran_servicio (ts_fecha_cambio, ts_secuencial, ts_tipo_transaccion,

                   ts_oficina, ts_usuario, ts_terminal, ts_reentry, ts_cod_alterno,

                   ts_tipo_default, ts_rol, ts_codigo, ts_producto,

                   ts_servicio_per, ts_categoria, ts_tipo_rango, ts_grupo_rango,

                   ts_rango, ts_fecha, ts_tipo_variacion,ts_cuenta,

                   ts_minimo, ts_maximo, ts_val_medio, ts_fecha_vigencia, ts_operacion)

            values (getdate(), @s_ssn, @t_trn, @s_ofi, @s_user, @s_term, 'N', 0,

                   '', '', 0, @w_producto,

                   @i_servicioPer, @i_categoria, @i_tipoRango, @i_grupoRango,

                   @i_rango,convert(char(10),@s_date,101) , '', ''

                   , @i_valorMinimo, @i_valorMaximo, @i_valorMedio

                   , @i_fechaVigenc, @w_operacion )

            if @@error != 0

               begin

                  /* Error de insercion en transaccion de servicio */

                  exec cobis..sp_cerror

                       @t_debug = @t_debug,

                       @t_file  = @t_file,

                       @t_from  = @w_sp_name,

                       @i_num   = 173515

                  rollback tran

                  return 1

               end



            if @w_operacion = 'I'

            begin

               exec cobis..sp_cseqnos

                    @t_debug = @t_debug,

                    @t_file = @t_file,

                    @t_from = @w_sp_name,

                    @i_tabla = 'pe_costo',

                    @o_siguiente = @w_secCosto out



               insert into pe_costo (co_secuencial, co_servicio_per, co_categoria,

                                     co_tipo_rango, co_grupo_rango, co_rango, co_val_medio,

                                     co_minimo, co_maximo, co_fecha_vigencia, co_oficina,

				     co_canal, co_ubicacion ) 	--VIVI, 29/Ago/2003 /*JPM 08112004 ubicacion*/

                      values (@w_secCosto, @i_servicioPer, @i_categoria,

                              @i_tipoRango, @i_grupoRango, @i_rango, @i_valorMedio,

                              @i_valorMinimo, @i_valorMaximo, @i_fechaVigenc, @i_oficina,

			      @i_canal, @i_ubicacion)



               if @@error != 0

               begin /* Error en creacion de costo de personalizacion */

               print 'dat05'

                  exec cobis..sp_cerror

                       @t_debug  = @t_debug,

                       @t_file   = @t_file,

                       @t_from   = @w_sp_name,

                       @i_num    = 033005

                  rollback tran

                  return 1

               end

               commit tran

            end

            else

            begin

               update pe_costo

                      set co_val_medio = @i_valorMedio,

                           co_minimo = @i_valorMinimo,

                           co_maximo = @i_valorMaximo,

                           co_fecha_vigencia = @i_fechaVigenc

                      where  co_servicio_per = @i_servicioPer

                             and co_categoria = @i_categoria

                             and co_tipo_rango = @i_tipoRango

                             and co_grupo_rango = @i_grupoRango

                             and co_rango = @i_rango

                             and co_oficina = @i_oficina

                             and co_ubicacion = @i_ubicacion /*JPM 08112004*/

			     and co_canal = @i_canal --VIVI, 29/Ago/2003

               if @@error != 0

      begin

print 'dat06'

print '@i_servicioPer%1!,@i_categoria%2!,@i_tipoRango%3!,@i_grupoRango%4!,@i_rango%5!,@i_oficina%6!,@i_ubicacion%7!,@i_canal%8! ', @i_servicioPer,@i_categoria, @i_tipoRango, @i_grupoRango,@i_rango, @i_oficina,@i_ubicacion,@i_canal

                     exec cobis..sp_cerror

                          @t_debug  = @t_debug,

                          @t_file   = @t_file,

                          @t_from   = @w_sp_name,

                          @i_num    = 033005

                     rollback tran

                     return 1

                  end

               commit tran

            end



         end





  /* Elimina un costo */



         if @i_tipo = 3

             begin

                begin tran

                delete from pe_costo

                       where co_servicio_per = @i_servicioPer

                             and co_categoria = @i_categoria

                             and co_tipo_rango = @i_tipoRango

                             and co_grupo_rango = @i_grupoRango

                             and co_rango = @i_rango

                             and co_secuencial = @i_secCosto

			     and co_canal = @i_canal  --VIVI, 29/Ago/2003

                if @@error != 0

                begin /* Error en eliminacion de registro de costo */

                   exec cobis..sp_cerror

                        @t_debug  = @t_debug,

                        @t_file   = @t_file,

                        @t_from   = @w_sp_name,

                        @i_num    = 033006

                   rollback tran

                   return 1

                end

                commit tran

             end



/**** ELIMINACION DE SERVICIOS PERSONALIZADOS ****/



   if @i_tipo = 6

    begin



   select cob_remesas..pe_costo.co_secuencial, cob_remesas..pe_costo.co_servicio_per, cob_remesas..pe_costo.co_categoria, cob_remesas..pe_costo.co_tipo_rango, cob_remesas..pe_costo.co_grupo_rango, cob_remesas..pe_costo.co_rango, cob_remesas..pe_costo.co_val_medio, cob_remesas..pe_costo.co_minimo, cob_remesas..pe_costo.co_maximo, cob_remesas..pe_costo.co_fecha_vigencia, cob_remesas..pe_costo.co_oficina, cob_remesas..pe_costo.co_canal, cob_remesas..pe_costo.co_ubicacion from cob_remesas..pe_costo

    where co_servicio_per = @i_servicioPer

          and  co_tipo_rango   = @i_tipoRango

          and  co_grupo_rango  = @i_grupoRango





     if @@rowcount <> 0

      begin

        print 'NO SE PUEDE ELIMINAR SERVICIOS CON COSTOS ASOCIADOS'

   /*exec cobis..sp_cerror

      @t_debug   = @t_debug,

      @t_file    = @t_file,

      @t_from    = @w_sp_name,

      @i_num     = 033006,

                @i_mensaje = @w_mensaje*/

           return 1

      end

     else

      begin



      /*Talia Rugel Sep/16/1998*/

       select @w_mercado = sp_mercado

            from cob_remesas..pe_servicio_per

         where sp_producto     = @i_prodCobis

         and   sp_moneda       = @i_moneda

         and   sp_tipo         = @i_tipoServ

         and   sp_servicio_per = @i_servicioPer





       delete cob_remesas..pe_servicio_per

        where sp_servicio_per = @i_servicioPer



        if @@error != 0

                begin /* Error en eliminacion de registro de costo */

                   exec cobis..sp_cerror

                        @t_debug  = @t_debug,

                        @t_file   = @t_file,

                        @t_from   = @w_sp_name,

                        @i_num    = 033006

                   rollback tran

                   return 1

                end



        /*Si no existen servicios de un producto final especifico este se*/

        /*debe eliminar*/

        select cob_remesas..pe_servicio_per.sp_mercado, cob_remesas..pe_servicio_per.sp_producto, cob_remesas..pe_servicio_per.sp_moneda, cob_remesas..pe_servicio_per.sp_tipo, cob_remesas..pe_servicio_per.sp_servicio_dis, cob_remesas..pe_servicio_per.sp_rubro, cob_remesas..pe_servicio_per.sp_servicio_per, cob_remesas..pe_servicio_per.sp_tipo_rango, cob_remesas..pe_servicio_per.sp_grupo_rango from cob_remesas..pe_servicio_per

           where sp_producto = @i_prodCobis

           and sp_moneda   = @i_moneda

           and sp_tipo     = @i_tipoServ

           and sp_mercado  = @w_mercado



        if @@rowcount = 0

          begin

              delete cob_remesas..pe_pro_final

                where pf_mercado  = @w_mercado

                 and  pf_producto = @i_prodCobis

                 and  pf_moneda   = @i_moneda

                 and  pf_tipo     = @i_tipoServ

              if @@error != 0

                 begin

                   exec cobis..sp_cerror

                   @t_debug  = @t_debug,

                   @t_file   = @t_file,

                   @t_from   = @w_sp_name,

                   @i_num    = 033006

                   rollback tran

                   return

                 end

          end



      end



    end   /*  i_tipo = 6 */



if @i_tipo = 7 /*JPM 08112004*/

   begin

     exec @w_return = cob_remesas..sp_oficina_ubicacion_rc

          @s_ssn                  = @s_ssn,

          @s_user                 = @s_user,

          @s_sesn                 = @s_sesn,

          @s_term                 = @s_term,

          @s_date                 = @s_date,

          @s_srv                  = @s_srv,

          @s_lsrv                 = @s_lsrv,

          @s_rol                  = @s_rol,

          @s_ofi                  = @s_ofi,

          @s_org_err              = @s_org_err,

          @s_error                = @s_error,

          @s_sev                  = @s_sev,

          @s_msg                  = @s_msg,

          @s_org                  = @s_org,

          @t_debug                = @t_debug,

          @t_file                 = @t_file,

          @t_from                 = @w_sp_name,

          @t_trn                  = @t_trn,

          @i_operacion            = 'A',

          @i_ofi                  = @i_oficina



          return @w_return



   end         /*JPM 08112004*/



if @i_tipo = 8 /*JPM 08112004*/

   begin

     exec @w_return = cob_remesas..sp_oficina_ubicacion_rc

          @s_ssn                  = @s_ssn,

          @s_user                 = @s_user,

          @s_sesn                 = @s_sesn,

          @s_term                 = @s_term,

          @s_date                 = @s_date,

          @s_srv                  = @s_srv,

          @s_lsrv                 = @s_lsrv,

          @s_rol                  = @s_rol,

          @s_ofi                  = @s_ofi,

          @s_org_err              = @s_org_err,

          @s_error                = @s_error,

          @s_sev                  = @s_sev,

          @s_msg                  = @s_msg,

          @s_org                  = @s_org,

          @t_debug                = @t_debug,

          @t_file                 = @t_file,

          @t_from                 = @w_sp_name,

          @t_trn                  = @t_trn,

          @i_operacion            = 'V',

          @i_ofi                  = @i_oficina,

          @i_ubicacion            = @i_ubicacion



          return @w_return



   end         /*JPM 08112004*/


return 0

