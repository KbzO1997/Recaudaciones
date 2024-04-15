select 1 from cobis..cl_catalogo cl
inner join cobis..cl_tabla ct on cl.tabla = ct.codigo
where ct.tabla = 'sv_val_srvpub_banco'
and substring (cl.codigo, 1, charindex('-',cl.codigo) - 1) = '3'
and
str_replace(substring('04 2251634', patindex('%[^0]%', '04 2251634'), len('04 2251634')),'',null)
in (str_replace(substring('04 2251634', patindex('%[^0]%', '04 2251634'), len('04 2251634')),'',null),
str_replace(substring(' ', patindex('%[^0]%', ' '), len(' ')),'',null),
str_replace(substring('04 2251634', patindex('%[^0]%', '04 2251634'), len('04 2251634')),'',null)
)
and cl.estado = 'V'

--<!------------------------TEST---------------------------->--
select '0000000000000027645706', SUBSTRING('0000000000000027645706', PATINDEX('%[^0]%', '0000000000000027645706'), LEN('0000000000000027645706'))
select '04 2251634', SUBSTRING('04 2251634', PATINDEX('%[^0]%', '04 2251634'), LEN('04 2251634'))