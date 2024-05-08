/**************************************************************************/
/* Archivo:            cckb0017.sql		                                    */
/* Objeto:             at_transaccion                                       */
/* Base de datos:      cobis                                     		    */
/* Producto:           Recaudaciones                                        */
/* Disenado por:       Kevin Bastidas                                       */
/* Fecha de escritura: 10/03/2023                                           */
/* Descripcion:        Script para aplicar transaccion de reverso           */
/*                                                                          */
/****************************************************************************/
/*                            MODIFICACIONES                                */
/*   FECHA     TAREA        AUTOR          RAZON                            */
/*06/03/2023  RECM-704 		Kevin Bastidas  Aplicar transaccion de reverso  */
/*                                          para recaudacion via rapida ATX */
/****************************************************************************/

use cobis
go

insert into cobis..at_transaccion (tn_trn_code,tn_descripcion,tn_nemonico, tn_desc_larga, tn_calificacion, tn_offline, tn_impresora, tn_trn_reverso)
values (62685, 'TRX RECA PAGO MS','62685','TRX RECA PAGO MS','A','N','S',3925)

go
