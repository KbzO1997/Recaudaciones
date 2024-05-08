/*******************************************************************************/
/* Nombre script:       cckb0010.sql                                           */
/* Realizado por:       Kevin Bastidas Zavala                                  */
/* Autorizado por:      Dario Barco Leon                                       */
/* Fecha:               10/Nov/2022                                            */
/* Proposito:           Script para insert en tabla at_transaccion             */
/* Tarea Rational:                                                  */
/*******************************************************************************/


use cobis
go

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values ( 62685, 'PAGO TRX ANT HN','62685','PAGO TRX ANT HN','A','N','S',3925)

go
