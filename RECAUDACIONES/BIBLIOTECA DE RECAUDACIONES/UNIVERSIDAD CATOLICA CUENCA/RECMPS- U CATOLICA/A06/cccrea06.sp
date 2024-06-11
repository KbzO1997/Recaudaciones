/************************************************************************/
/*      Archivo           : cccrea06.sp                                 */
/*      Stored procedure  : sp_selecciona_a06                           */
/*      Base de datos     : cob_super                                 */
/*      Producto          : Cuentas Corrientes                          */
/*      Disenado por      : German Medina Cevallos                      */
/*      Fecha de escritura: 07-Diciembre-2009                           */
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
/*      Selecciona los diferentes programas del A06                     */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA          AUTOR              RAZON                             */
/*  07/DIC/2009    German Medina C.   Emision Inicial                   */
/*2 12/MAR/2010    German Medina C.   CTE-CC-8434 - Tasa Ponderada      */
/*3 10/JUN/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-8977                       */
/*4 25/JUL/2010    German Medina C.   Modificaciones A06                */
/*                                    CTE-CC-9200                       */
/*5 30/Jul/2015    Jorge Pazminno M  Cuenta Basica                      */
/*                                   Tarea:CB-AP-SGC00018374-SGC00018869*/
/*6 17/Dic/2015    Miriam Lindao R.   CNB-316-SGC00017506               */
/*                                    Nuevo Canal N(Corresponsal No Banc*/
/*7 29-Ago-2016  Jonathan Lopez Torres BTNPAG-AP-SGC00021269 - Nueva Recaudacion    */
/*                                   Boton de Pago   */
/*8 30/Mar/2017  Daniel Pereira      MEER-AP-SGC00026606-SGC00026625  canal WAP */
/************************************************************************/

use cob_super

go

if exists (select 1 from sysobjects where name = 'sp_selecciona_a06')
  drop proc sp_selecciona_a06

go

create proc sp_selecciona_a06
(
  @i_fecha_ini                datetime        = null,
  @i_fecha_fin                datetime        = null,  
  @i_canal                    char(1)         = null,
  @i_servicio                 varchar(10)     = null,
  @i_tipo_producto            varchar(10)     = null,
  @i_tipo_cliente             char(1)         = null,  
  @i_moneda                   smallint        = null,
  @i_producto                 smallint        = null
  
)
as
  
--> Variables
declare
  @w_usu1       varchar(10),
  @w_usu2       varchar(10),
  @w_usu3       varchar(10),
  @w_usu4       varchar(10),
  @w_usu5       varchar(10),
  @w_return     int,
  @w_producto   smallint,                -- JPM Ref.5
  @w_rowcount   int
  
  
set
  @w_usu1 = '',
  @w_usu2 = '',
  @w_usu3 = '',
  @w_usu4 = '',
  @w_usu5 = ''
        

--> SP de Seleccion de Programas para la creacion de la estructura A06
if @i_producto = 4
begin  --if @i_producto = 4 - ini
  select @w_producto = case when @i_tipo_producto like 'CB%' then 12 else @i_producto end       -- JPM Ref.5
  if @i_canal = 'O' or @i_canal = 'H'
  begin  --if @i_canal = 'O' or @i_canal = 'H' - ini
    --< ref: 4 >--
    if @i_canal = 'O'
        set
          @w_usu1 = 'ope998',
          @w_usu2 = 'srolese',
          @w_usu3 = 'IVR',
          @w_usu4 = 'SAT',
          @w_usu5 = 'kiosko'
    
    exec @w_return = sp_inserta_aho_a06_ofi
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @w_producto                 --JPM Ref.5: antes @i_producto
      
    if @w_return <> 0
    begin
        return @w_return
        /*
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = ''
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return @w_return
        */
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end
    
  end    --if @i_canal = 'O' or @i_canal = 'H' - fin

  if @i_canal = 'I'
  begin  --if @i_canal = 'I' - ini
    set
      @w_usu1 = 'ope998',
      @w_usu2 = 'srolese',
      @w_usu3 = 'cpv001', --ref 7
      @w_usu4 = 'SAT'
      
    exec @w_return = sp_inserta_aho_a06_int
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @w_producto                 --JPM Ref.5: antes @i_producto
      
      
    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end
    
  end    --if @i_canal = 'I' - fin
  

  if @i_canal = 'K' or @i_canal = 'F'
  begin  --if @i_canal = 'I' - ini
    
    if @i_canal = 'K'
      set @w_usu1 = 'kiosko'
    else 
      set @w_usu1 = 'IVR'
    
    exec @w_return = sp_inserta_aho_a06_kio
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @w_producto                 --JPM Ref.5: antes @i_producto
      
    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end
    
  end    --if @i_canal = 'I' - fin

  if @i_canal = 'C'
  begin  --if @i_canal = 'I' - ini
    exec @w_return = sp_inserta_aho_a06_atm
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_moneda           = @i_moneda,
      @i_producto         = @w_producto                 --JPM Ref.5: antes @i_producto
      
      

    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end      
      
  end    --if @i_canal = 'I' - fin
  
  if @i_canal = 'T'
  begin  --if @i_canal = 'T' - ini

    
    exec @w_return = sp_inserta_aho_a06_tar
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,      
      @i_moneda           = @i_moneda,
      @i_producto         = @w_producto                 --JPM Ref.5: antes @i_producto
      
    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
       update cob_super..cc_a06_parametros
       set pa_error = 0, pa_desc_error = 'OK'
       from cob_super..cc_a06_parametros
       where pa_canal        = @i_canal   
         and pa_tip_producto = @i_tipo_producto
         and pa_tip_cliente  = @i_tipo_cliente
         and pa_tip_producto = @i_tipo_producto
         and pa_tip_servicio = null
       return 0
    end      
   
  end    --if @i_canal = 'T' - fin
  --<Ref05 MLR nuevo canal cnb
  if @i_canal = 'N'
  begin  
     set @w_usu1 = 'cnb001'
     exec @w_return = sp_inserta_aho_a06_cnb
       @i_fecha_ini        = @i_fecha_ini,
       @i_fecha_fin        = @i_fecha_fin,
       @i_canal            = @i_canal,
       @i_servicio         = @i_servicio,
       @i_tipo_producto    = @i_tipo_producto,
       @i_tipo_cliente     = @i_tipo_cliente,
       @i_usu1             = @w_usu1,
       @i_moneda           = @i_moneda,
       @i_producto         = @i_producto

     if @w_return <> 0
     begin
        return @w_return
     end
     else
     begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        where pa_canal        = @i_canal   
          and pa_tip_producto = @i_tipo_producto
          and pa_tip_cliente  = @i_tipo_cliente
          and pa_cod_servicio = @i_servicio
          and pa_tip_servicio = null
          
        if @@error != 0
        begin
           print 'Error en sp_selecciona_a06 al Actualizar cob_super..cc_a06_parametros. Canal: %1!, Tipo Producto: %2!, Cod.Servicio: %3! y Tipo Cliente: %4!',@i_canal  ,@i_tipo_producto, @i_servicio,@i_tipo_cliente
           return 31183
        end
        return 0
     end        
  end    --if @i_canal = 'N' 
  
  if @i_canal = 'M' --ref 8
  begin  
     set @w_usu1 = 'WAP'
     exec @w_return = pa_pag_b_insert_aho_a06_wap
       @e_fecha_ini        = @i_fecha_ini,
       @e_fecha_fin        = @i_fecha_fin,
       @e_canal            = @i_canal,
       @e_servicio         = @i_servicio,
       @e_tipo_producto    = @i_tipo_producto,
       @e_tipo_cliente     = @i_tipo_cliente,
       @e_usu1             = @w_usu1,
       @e_moneda           = @i_moneda,
       @e_producto         = @i_producto

     if @w_return = 0
     begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        where pa_canal        = @i_canal   
          and pa_tip_producto = @i_tipo_producto
          and pa_tip_cliente  = @i_tipo_cliente
          and pa_cod_servicio = @i_servicio
          and pa_tip_servicio = null
          
        if @@error != 0
        begin
           print 'Error en sp_selecciona_a06 al Actualizar cob_super..cc_a06_parametros. Canal: %1!, Tipo Producto: %2!, Cod.Servicio: %3! y Tipo Cliente: %4!',@i_canal  ,@i_tipo_producto, @i_servicio,@i_tipo_cliente
           return 31183
        end
        return 0
     end
     else
          begin
             return @w_return
          end
  end    --if @i_canal = 'M' 
end    --if @i_producto = 4 - fin
--Fin Ref05>

if @i_producto = 3
begin  --if @i_producto = 3 - ini
  
  if @i_canal = 'O' or @i_canal = 'R'
  begin  --if @i_canal = 'O' or @i_canal = 'H' - ini
    
    --< ref: 4 >--
    if @i_canal = 'O'
        set
          @w_usu1 = 'ope998',
          @w_usu2 = 'srolese',
          @w_usu3 = 'IVR',
          @w_usu4 = 'SAT',
          @w_usu5 = 'kiosko'
    
    exec @w_return = sp_inserta_cte_a06_ofi
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,                
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @i_producto


    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end
    
  end    --if @i_canal = 'O' or @i_canal = 'H' - fin

  if @i_canal = 'I'
  begin  --if @i_canal = 'I' - ini
    
    set
      @w_usu1 = 'ope998',
      @w_usu2 = 'srolese',
      @w_usu3 = 'cpv001', --ref 7
      @w_usu4 = 'SAT'
    
    exec @w_return = sp_inserta_cte_a06_int
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @i_producto


    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end      
    
  end    --if @i_canal = 'I' - fin

  if @i_canal = 'K' or @i_canal = 'F'
  begin  --if @i_canal = 'I' - ini
    
    if @i_canal = 'K'
      set @w_usu1 = 'kiosko'
    else 
      set @w_usu1 = 'IVR'

    exec @w_return = sp_inserta_cte_a06_kio
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,
      @i_usu1             = @w_usu1,
      @i_usu2             = @w_usu2,
      @i_usu3             = @w_usu3,
      @i_usu4             = @w_usu4,
      @i_usu5             = @w_usu5,
      @i_moneda           = @i_moneda,
      @i_producto         = @i_producto


    if @w_return <> 0
    begin        
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end      
    
  end    --if @i_canal = 'I' - fin

  if @i_canal = 'C'
  begin  --if @i_canal = 'I' - ini

    
    exec @w_return = sp_inserta_cte_a06_atm
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,      
      @i_moneda           = @i_moneda,
      @i_producto         = @i_producto
  
    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end  
   
  end    --if @i_canal = 'I' - fin
  
  if @i_canal = 'T'
  begin  --if @i_canal = 'I' - ini

    
    exec @w_return = sp_inserta_cte_a06_tar
      @i_fecha_ini        = @i_fecha_ini,
      @i_fecha_fin        = @i_fecha_fin,
      @i_canal            = @i_canal,
      @i_servicio         = @i_servicio,
      @i_tipo_producto    = @i_tipo_producto,
      @i_tipo_cliente     = @i_tipo_cliente,      
      @i_moneda           = @i_moneda,
      @i_producto         = @i_producto


    if @w_return <> 0
    begin
        return @w_return
    end
    else
    begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        from cob_super..cc_a06_parametros
        where pa_canal = @i_canal   
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_cliente = @i_tipo_cliente
        and pa_tip_producto = @i_tipo_producto
        and pa_tip_servicio = null
        return 0
    end      
  
   
  end    --if @i_canal = 'I' - fin
  
  --<Ref05 Inicio
  if @i_canal = 'N'
  begin  
     set @w_usu1 = 'cnb001'    
     exec @w_return = sp_inserta_cte_a06_cnb
          @i_fecha_ini        = @i_fecha_ini,
          @i_fecha_fin        = @i_fecha_fin,
          @i_canal            = @i_canal,
          @i_servicio         = @i_servicio,
          @i_tipo_producto    = @i_tipo_producto,
          @i_tipo_cliente     = @i_tipo_cliente,
          @i_usu1             = @w_usu1,
          @i_moneda           = @i_moneda,
          @i_producto         = @i_producto
  
     if @w_return <> 0
     begin
        return @w_return
     end
     else
     begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        where pa_canal = @i_canal   
          and pa_tip_producto = @i_tipo_producto
          and pa_tip_cliente  = @i_tipo_cliente
          and pa_cod_servicio = @i_servicio
          and pa_tip_servicio = null

        if @@error != 0
        begin
           print 'Error en sp_selecciona_a06 al Actualizar cob_super..cc_a06_parametros. Canal: %1!, Tipo Producto: %2!, Cod.Servicio: %3! y Tipo Cliente: %4!',@i_canal  ,@i_tipo_producto, @i_servicio,@i_tipo_cliente
           return 31183
        end
        return 0
     end      
  end    --if @i_canal = 'N' - fin
  --Fin Ref05>
  
  if @i_canal = 'M'  --Ref 8 
  begin  
     set @w_usu1 = 'WAP'    
     exec @w_return = pa_pag_b_insert_cte_a06_wap
          @e_fecha_ini        = @i_fecha_ini,
          @e_fecha_fin        = @i_fecha_fin,
          @e_canal            = @i_canal,
          @e_servicio         = @i_servicio,
          @e_tipo_producto    = @i_tipo_producto,
          @e_tipo_cliente     = @i_tipo_cliente,
          @e_usu1             = @w_usu1,
          @e_moneda           = @i_moneda,
          @e_producto         = @i_producto
  
     if @w_return = 0
     begin
        update cob_super..cc_a06_parametros
        set pa_error = 0, pa_desc_error = 'OK'
        where pa_canal = @i_canal   
          and pa_tip_producto = @i_tipo_producto
          and pa_tip_cliente  = @i_tipo_cliente
          and pa_cod_servicio = @i_servicio
          and pa_tip_servicio = null

        if @@error != 0
        begin
           print 'Error en sp_selecciona_a06 al Actualizar cob_super..cc_a06_parametros. Canal: %1!, Tipo Producto: %2!, Cod.Servicio: %3! y Tipo Cliente: %4!',@i_canal  ,@i_tipo_producto, @i_servicio,@i_tipo_cliente
           return 31183
        end
        return 0
     end
     else
          begin
             return @w_return
     	  end
  end    --if @i_canal = 'M'   
  
end    --if @i_producto = 3 - fin

return 0

go
