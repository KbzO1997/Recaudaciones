/************************************************************************/
/*   Archivo:  cckb0014.sql                                             */
/*   Motor de Base: 		SYBASE                     					*/
/*    Servidor: 			HP-ACT                                      */
/*   Objeto: re_transa_cs           		                        	*/
/*   Base de datos:  cob_remesas                                        */
/*   Producto: Diario Operaciones                                       */
/*   Disenado por:  Kevin Bastidas                                   	*/
/*   Fecha de escritura:  02/02/2023                                    */
/************************************************************************/
/*                            PROPOSITO                                 */
/*Crear indice para generar el reporte sbs conciliacion Broadnet  		*/
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  REF FECHA           AUTOR        RAZON         Tarea			    */
/*   1  02/02/2023  Kevin Bastidas	RECMPS-2042 PAGO LC CON FORMA PAGO INTERBANCARIO*/
/************************************************************************/


use cob_remesas
go

print 'Inicia Srcipt'
print 'Alterar la longitud campo: to_causa por trx de 5 digitos'

go

if exists (select 1 from sysobjects where name = 're_total')
begin
	
    alter table cob_remesas..re_total  modify to_causa varchar (5) null
	
end 
go

print 'Update OK'
go


print 'Fin Script'
go
