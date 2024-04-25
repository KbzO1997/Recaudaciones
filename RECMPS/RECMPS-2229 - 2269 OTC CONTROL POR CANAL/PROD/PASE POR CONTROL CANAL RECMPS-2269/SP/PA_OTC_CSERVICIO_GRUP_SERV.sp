/*************************************************************************/
/*  Archivo:            cckb0031.sp                                    */
/*  Base de datos:      CB_PROFILING                                    */
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 17/04/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*Editar SP para filtrar info por canal OTC_D_SERVICIO_CANAL            */
/************************************************************************/
/*                      MODIFICACIONES                                   */
/*  REF.  FECHA RATIONAL AUTOR         Razon                             */
/*  1    17/04/2023 Kevin Bastidas RECMPS-2229 Emision inicial           */
/*************************************************************************/
set serveroutput on;
  
    create or replace PROCEDURE          "PA_OTC_CSERVICIO_GRUP_SERV" 
    (
      E_GRUPO_SERVICIO IN NUMBER, E_CANAL_ID IN NUMBER DEFAULT  1,  S_RESPUESTA OUT sys_refcursor
      
    ) AS
    BEGIN
    BEGIN
      --OPEN S_RESPUESTA FOR SELECT serv.srv_id as id, serv.srv_nombre as nombre, serv.cnv_id as convenioId   from otc_d_servicio serv, OTC_M_CONVENIO conv where serv.CNV_ID = conv.CNV_ID and grp_id = E_GRUPO_SERVICIO order by conv.CNV_ETIQUETA_CODIGO;
    OPEN S_RESPUESTA FOR SELECT serv.srv_id as id, serv.srv_nombre as nombre, serv.cnv_id as convenioId
    from otc_d_servicio serv
    inner join  OTC_M_CONVENIO conv on serv.CNV_ID = conv.CNV_ID 
    left join  OTC_D_SERVICIO_CANAL can on serv.srv_id = can.SRV_ID
    where  grp_id = E_GRUPO_SERVICIO
    and can.CAN_ID = E_CANAL_ID
    order by conv.CNV_ETIQUETA_CODIGO;
    
    EXCEPTION
      WHEN OTHERS THEN
      CLOSE S_RESPUESTA;
      END;
    END;
 
/