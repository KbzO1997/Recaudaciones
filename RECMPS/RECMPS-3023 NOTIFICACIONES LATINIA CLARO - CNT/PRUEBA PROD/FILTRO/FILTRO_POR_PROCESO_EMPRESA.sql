cd_fecha_arc                cd_no_archivo             
--------------------------- ------------- ----------- 
Jan 2 2024 12:00AM          1             6           
Jan 2 2024 12:00AM          2             359         
Jan 3 2024 12:00AM          1             5           
Jan 3 2024 12:00AM          2             203         
Jan 4 2024 12:00AM          1             5           
Jan 4 2024 12:00AM          2             2479        
Jan 5 2024 12:00AM          1             2000        
Jan 5 2024 12:00AM          2             291         
Jan 6 2024 12:00AM          1             43          
Jan 6 2024 12:00AM          2             78          
Jan 8 2024 12:00AM          1             67          
Jan 8 2024 12:00AM          2             162         
Jan 9 2024 12:00AM          1             54          
Jan 9 2024 12:00AM          2             219         
Jan 10 2024 12:00AM         1             293         
Jan 10 2024 12:00AM         2             7030        
Jan 11 2024 12:00AM         1             36          
Jan 11 2024 12:00AM         2             314         
Jan 12 2024 12:00AM         1             28          
Jan 12 2024 12:00AM         2             512         
Jan 13 2024 12:00AM         1             6           
Jan 13 2024 12:00AM         2             1766        
Jan 15 2024 12:00AM         1             14          
Jan 15 2024 12:00AM         2             1027        
Jan 16 2024 12:00AM         1             13          
Jan 16 2024 12:00AM         2             595         


select cd_fecha_arc, cd_no_archivo, count(*)
from  cob_pagos..pg_cobro_debitos_servicio 	
where cd_empresa in('38') and cd_fecha_arc >= '01/02/2024' and cd_cod_error is null
group by cd_fecha_arc, cd_no_archivo
order by cd_fecha_arc, cd_no_archivo
