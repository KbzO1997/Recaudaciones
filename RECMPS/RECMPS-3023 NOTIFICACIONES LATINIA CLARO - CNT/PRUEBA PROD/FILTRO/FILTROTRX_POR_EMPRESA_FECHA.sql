cd_empresa cd_fecha_arc                cd_no_archivo             
---------- --------------------------- ------------- ----------- 
38         Jan 2 2024 12:00AM          1             6           
38         Jan 2 2024 12:00AM          2             359         
38         Jan 3 2024 12:00AM          1             5           
38         Jan 3 2024 12:00AM          2             203         
38         Jan 4 2024 12:00AM          1             5           
38         Jan 4 2024 12:00AM          2             2479        
38         Jan 5 2024 12:00AM          1             2000        
38         Jan 5 2024 12:00AM          2             291         
38         Jan 6 2024 12:00AM          1             43          
38         Jan 6 2024 12:00AM          2             78          
38         Jan 8 2024 12:00AM          1             67          
38         Jan 8 2024 12:00AM          2             162         
38         Jan 9 2024 12:00AM          1             54          
38         Jan 9 2024 12:00AM          2             219         
38         Jan 10 2024 12:00AM         1             293         
38         Jan 10 2024 12:00AM         2             7030        
38         Jan 11 2024 12:00AM         1             36          
38         Jan 11 2024 12:00AM         2             314         
38         Jan 12 2024 12:00AM         1             28          
38         Jan 12 2024 12:00AM         2             512         
38         Jan 13 2024 12:00AM         1             6           
38         Jan 13 2024 12:00AM         2             1766        
38         Jan 15 2024 12:00AM         1             14          
38         Jan 15 2024 12:00AM         2             1027        
38         Jan 16 2024 12:00AM         1             13          
38         Jan 16 2024 12:00AM         2             595         
8523       Jan 2 2024 12:00AM          1             2           
8523       Jan 3 2024 12:00AM          1             282         
8523       Jan 4 2024 12:00AM          1             4           
8523       Jan 5 2024 12:00AM          1             5           
8523       Jan 6 2024 12:00AM          1             1           
8523       Jan 8 2024 12:00AM          1             3           
8523       Jan 9 2024 12:00AM          1             2           
8523       Jan 11 2024 12:00AM         1             1           
8523       Jan 13 2024 12:00AM         1             1           
8523       Jan 15 2024 12:00AM         1             21          
8523       Jan 16 2024 12:00AM         1             238         
86881      Jan 2 2024 12:00AM          (null)        1           
86881      Jan 3 2024 12:00AM          (null)        1           
86881      Jan 4 2024 12:00AM          (null)        1           
86881      Jan 5 2024 12:00AM          (null)        1           
86881      Jan 8 2024 12:00AM          (null)        3           
86881      Jan 9 2024 12:00AM          (null)        1           
86881      Jan 10 2024 12:00AM         (null)        1           
86881      Jan 11 2024 12:00AM         (null)        1           
86881      Jan 12 2024 12:00AM         (null)        1           
86881      Jan 15 2024 12:00AM         (null)        2           
86881      Jan 16 2024 12:00AM         (null)        1           
86881      Jan 17 2024 12:00AM         (null)        1           
86882      Jan 2 2024 12:00AM          (null)        1           
86882      Jan 3 2024 12:00AM          (null)        1           
86882      Jan 4 2024 12:00AM          (null)        1           


8688       Jan 2 2024 12:00AM          (null)        102         
8688       Jan 3 2024 12:00AM          (null)        27          
8688       Jan 4 2024 12:00AM          (null)        30          
8688       Jan 5 2024 12:00AM          (null)        43          
8688       Jan 8 2024 12:00AM          (null)        56          
8688       Jan 9 2024 12:00AM          (null)        36          
8688       Jan 10 2024 12:00AM         (null)        23          
8688       Jan 11 2024 12:00AM         (null)        41          
8688       Jan 12 2024 12:00AM         (null)        36          
8688       Jan 15 2024 12:00AM         (null)        82          
8688       Jan 16 2024 12:00AM         (null)        39          
8688       Jan 17 2024 12:00AM         (null)        23       



select cd_empresa , cd_fecha_arc, cd_no_archivo, count(*)
from  cob_pagos..pg_cobro_debitos_servicio 	
where cd_fecha_arc >= '01/02/2024' and cd_cod_error is null
group by cd_empresa , cd_fecha_arc, cd_no_archivo
order by cd_empresa , cd_fecha_arc, cd_no_archivo
