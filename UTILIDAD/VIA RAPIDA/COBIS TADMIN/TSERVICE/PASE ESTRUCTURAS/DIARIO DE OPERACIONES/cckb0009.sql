/************************************************************************/
/*   Archivo:  cckb0009.sql                                             */
/*   Motor de Base: 		SYBASE                     					*/
/*    Servidor: 			HP-ACT                                      */
/*   Objeto: re_transa_cs           		                        	*/
/*   Base de datos:  cob_remesas                                        */
/*   Producto: Diario Operaciones                                       */
/*   Disenado por:  Kevin Bastidas                                   	*/
/*   Fecha de escritura:  05/09/2022                                    */
/************************************************************************/
/*                            PROPOSITO                                 */
/*Crear indice para generar el reporte sbs conciliacion Broadnet  		*/
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR        RAZON        Tarea			            */
/*   1  05/09/2022  Kevin Bastidas	RECESABREC-124 TSERVI MOVISTAR CANALES DIGITALES*/
/************************************************************************/


use cob_remesas
go

print 'Inicia Srcipt'
print 'Alterar la longitud campo: tr_causa por trx de 5 digitos'

go

if exists (select 1 from sysobjects where name = 're_transa_cs')
begin
	
	alter table cob_remesas..re_transa_cs  modify tr_causa varchar (5) null
	
end 
go

print 'Update OK'
go


print 'Fin Script'
go
