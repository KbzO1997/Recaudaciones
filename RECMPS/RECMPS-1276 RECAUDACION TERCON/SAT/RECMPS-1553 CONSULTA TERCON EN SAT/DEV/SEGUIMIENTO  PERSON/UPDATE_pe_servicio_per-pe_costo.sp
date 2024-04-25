cob_remesas..sp_helptext sp_seqnos , null, null, showsql
cob_remesas..sp_helptext re_seqnos , null, null, showsql

update cob_remesas..re_seqnos set siguiente = 39964 where tabla = 'pe_costo' 
update cob_remesas..re_seqnos set siguiente = 2307 where tabla = 'pe_servicio_per' 

---VALIDAR EL SECUENCIAL
select  * from cob_remesas..re_seqnos where tabla = 'pe_servicio_per'
go
select w_secCosto = max(sp_servicio_per)  from cob_remesas..pe_servicio_per
go

Desarrollo-2
tabla                          siguiente    w_secCosto 
------------------------------ -----------  ---------- 
pe_servicio_per                2424         2424

Desarrollo-1      
tabla                          siguiente    w_secCosto 
------------------------------ -----------  ----------
pe_servicio_per                2305         2307