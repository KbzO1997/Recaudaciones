/************************************************************************/
/*   Archivo:  cckb0005.sql                                             */
/*   Objeto: pag_t_concilia_broadnet		                        	*/
/*   Base de datos:  cob_pagos                                          */
/*   Producto: Dep En Linea                                             */
/*   Disenado por:  Kevin Bastidas                                   	*/
/*   Fecha de escritura:  03/Mayo/2022                                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/*Crear indice para generar el reporte sbs conciliacion Broadnet  		*/
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR        RAZON        Tarea			             */
/*03/Mayo/2022 Kevin Bastidas    RECM-321  COMPLEMENTAR INFORMACION PARA RECARGAS MOVISTAR TWENTI Y CNT  */
/************************************************************************/


use cob_pagos
print 'Inicia Srcipt'
go


print 'Creacion Indice pag_t_concilia_broadnet'

go

if exists (select 1 from sysobjects where name = 'pag_t_concilia_broadnet')
begin

	if exists (select 1 from sysindexes where name = 'i_pag_t_concilia_broadnet_02')
			drop index pag_t_concilia_broadnet.i_pag_t_concilia_broadnet_02
	
	create nonclustered index i_pag_t_concilia_broadnet_02 on cob_pagos..pag_t_concilia_broadnet (co_num_ref)
	
end 
go

print 'Creacion de Indices'
go


print 'Fin Script'
go
