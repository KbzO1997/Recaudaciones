/*******************************************************************************/
/* Nombre script:       ccms0046.sql                                           */
/* Realizado por:       María José Silva Goya                                  */
/* Autorizado por:      Dario Barco Leon                                       */
/* Fecha:               13/Nov/2017                                            */
/* Proposito:           Script para insert en tabla at_transaccion             */
/* Tarea Rational:      SGC00028642                                            */
/*******************************************************************************/


use cobis
go

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values ( 62688, 'PAGO TRX MOVISTAR COMPRA PAQUETE HN','ss','TRX MOVISTAR COMPRA PAQUETE HN','A','N','S',62688)

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values ( 62689, 'PAGO TRX MOVISTAR COMPRA PAQUETE HD','ss','TRX MOVISTAR COMPRA PAQUETE HD','A','N','S',62689)

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values ( 62686, 'PAGO TRX TUENTI COMPRA PAQUETE HN','ss','TRX MOVISTAR COMPRA PAQUETE HN','A','N','S',62686)

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values ( 62687, 'PAGO TRX TUENTI COMPRA PAQUETE HD','ss','TRX MOVISTAR COMPRA PAQUETE HD','A','N','S',62687)


go
