/*************************************************************************/
/*  Archivo:            cckb0033.sp                                    */
/*  Base de datos:      DB_OTC                                    		*/
/*  Producto:           Recaudaciones                                   */
/*  Disenado por:       Kevin Bastidas                                  */
/*  Fecha de escritura: 28/04/2023                                      */
/************************************************************************/
/*                      PROPOSITO                                       */
/*Editar SP para filtrar info por canal OTC_D_SERVICIO_CANAL            */
/************************************************************************/
/*                      MODIFICACIONES                                   */
/*  REF.  FECHA RATIONAL AUTOR         Razon                             */
/*  1    28/04/2023 Kevin Bastidas RECMPS-2229 Emision inicial           */
/*************************************************************************/
set serveroutput on;
  
    create or replace PROCEDURE DB_OTC."PA_OTC_COBTIENE_DATOSFLUJO" (
    e_flujo IN integer,
    e_banca IN string, 
    s_result OUT sys_refcursor) 
    IS 
    BEGIN
        open  s_result for SELECT distinct c.CNV_CODIGO as codigoConvenio
            ,e.EMP_CODIGO as codigoEmpresa
            ,ts.CTD_DESCRIPCION as tipoServicio
            ,tb.CTD_CODIGO as tipoBanca
            FROM DB_OTC.OTC_D_SERVICIO s
                INNER JOIN DB_OTC.OTC_M_CONVENIO c
            ON s.CNV_ID = c.CNV_ID
                INNER JOIN DB_OTC.OTC_M_FLUJO f
            ON c.CNV_ID = f.CNV_ID
                INNER JOIN DB_OTC.OTC_M_GRUPO_SERVICIO g
            ON s.GRP_ID = g.GRP_ID
                INNER JOIN DB_OTC.OTC_M_EMPRESA e
            ON g.EMP_ID = e.EMP_ID    
                INNER JOIN DB_OTC.OTC_D_CATALOGO ts  
            ON ts.CTD_ID = g.CT_ID_TIPO_SERV
                INNER JOIN DB_OTC.OTC_D_CATALOGO tb 
            ON tb.CTD_ID = g.CT_ID_TIPO_BANCA
            WHERE f.FLU_ID=e_flujo AND tb.CTD_CODIGO=e_banca
            GROUP BY c.CNV_CODIGO
                , e.EMP_CODIGO 
                ,ts.CTD_DESCRIPCION
                ,tb.CTD_CODIGO;
    EXCEPTION
    WHEN OTHERS THEN
    CLOSE s_result;
    END;
 
/