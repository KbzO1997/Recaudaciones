pe_fpago pe_empresa  pe_ruc        pe_direccion                                                     pe_nombre                                                                                            pe_dias     pe_laborables pe_costo                   pe_fpago pe_producto pe_cuenta                pe_impret pe_oricat   pe_conta pe_porcentaje pe_refestcta pe_porc_retimp           pe_grupo pe_cod_grupo pe_concilia_grp pe_acedita_grp pe_region_pais pe_cod_proveedor pe_dias_reintent pe_cod_serv pe_rubro   pe_impiva pe_porc_impiva           pe_serv_com pe_imdCostCanal pe_fact_diaria pe_periodo_comision pe_cod_ret 
-------- ----------- ------------- ---------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------- ------------- -------------------------- -------- ----------- ------------------------ --------- ----------- -------- ------------- ------------ ------------------------ -------- ------------ --------------- -------------- -------------- ---------------- ---------------- ----------- ---------- --------- ------------------------ ----------- --------------- -------------- ------------------- ---------- 
NCRCTA   1594        0992371188001 Avenida nueve de octubre 100 y Malec¢n. Edificio l               BROADNET S.A                                                                                         0           S             0.00                       NCRCTA   AHO         0002082058               1         (null)      1        0             1            0.0275                   (null)   (null)       (null)          (null)         (null)         (null)           (null)           (null)      (null)     (null)    (null)                   (null)      (null)          (null)         (null)              3440       
NCRCTA   8459        1790511472001 DIRECCION:8459                                                   TERCON                                                                                               0           S             0.00                       NCRCTA   CTE         0009002638               0         (null)      1        0             0            (null)                   N        (null)       N               N              Costa          0                355              CSPR        TRCN       1         0.12                     53          (null)          N              (null)              (null)     
NCRCTA   8461        0993240834001 Km. 24.5 Vía a Santa Elena                                       CVIALCO FIDEICOMISO MERCANTIL FLUJOS FONDO GENERAL DEL PROYECTO                                      1           S             0.00                       NCRCTA   CTE         0005158885               0         (null)      1        0             0            (null)                   N        (null)       N               N              Costa          0                0                CSPR        TPCV       0         (null)                   18          (null)          N              (null)              (null)     
NCRCTA   17072       0990017514001 CHIMBORAZO Y LUQUE                                               TIENDAS INDUSTRIALES ASOCIADAS S.A.                                                                  0           N             0.00                       NCRCTA   CTE         0005066243               0         (null)      0        0             0            (null)                   N        (null)       N               N              Costa          0                528              CSPR        DCTI       1         0.12                     53          (null)          N              (null)              (null)     
NCRCTA   359         0960002350001 DIRECCION:359                                                    EMP CANTONAL DE AGUA POTABLE Y                                                                       0           S             0.00                       NCRCTA   CTE         0000026433               0         (null)      1        100           0            (null)                            (null)                                                     (null)           (null)                                  (null)    (null)                                                              (null)              (null)     
NCRCTA   11          0991307605001 PICHINCHA 335 E ILLINGWORTH                                      AFP GENESIS-PLAN CESANTIA                                                                            0           N             0.25                       NCRCTA   CTE         0000151610               0         (null)      0        0             0            (null)                   N        (null)       N               N              Costa          16787200         0                (null)      (null)     0         (null)                   (null)      N               N              (null)              (null)     
NCRCTA   19574       0992371188001 Avenida nueve de octubre 100 y Malec¢n. Edificio                 BROADNET S.A. (MOVISTAR)                                                                             0           S             0.00                       NCRCTA   AHO         0002096068               1         (null)      1        0             0            0.0275                   N        (null)       N               N              Costa          0                255              (null)      (null)     0         (null)                   (null)      (null)          N              (null)              3440       


Name              Owner Object_type Object_status Create_date         
----------------- ----- ----------- ------------- ------------------- 
pg_person_empresa dbo   user table   -- none --   Sep  4 2011  5:21PM 
Column_name         Type        Length Prec Scale Nulls Not_compressed Default_name Rule_name Access_Rule_name Computed_Column_object Identity   
------------------- ----------- ------ ---- ----- ----- -------------- ------------ --------- ---------------- ---------------------- ---------- 
pe_empresa          int              4 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_ruc              varchar         13 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_direccion        descripcion     64 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_nombre           varchar        100 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_dias             int              4 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_laborables       char             2 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_costo            money            8 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_fpago            varchar          6 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_producto         varchar          3 NULL  NULL     0              0 (null)       (null)    (null)           (null)                          0 
pe_cuenta           cuenta          24 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_impret           tinyint          1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_oricat           int              4 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_conta            tinyint          1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_porcentaje       int              4 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_refestcta        tinyint          1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_porc_retimp      float            8 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_grupo            char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_cod_grupo        int              4 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_concilia_grp     char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_acedita_grp      char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_region_pais      char             8 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_cod_proveedor    int              4 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_dias_reintent    int              4 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_cod_serv         catalogo        10 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_rubro            catalogo        10 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_impiva           tinyint          1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_porc_impiva      float            8 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_serv_com         catalogo        10 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_imdCostCanal     char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_fact_diaria      char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_periodo_comision char             1 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
pe_cod_ret          char             6 NULL  NULL     1              0 (null)       (null)    (null)           (null)                          0 
Object has the following indexes
 
index_name            index_keys    index_description    index_max_rows_per_page index_fillfactor index_reservepagegap index_created       index_local  plldegree disabled 
--------------------- ------------- -------------------- ----------------------- ---------------- -------------------- ------------------- ------------ --------- -------- 
pe_person_empresa_key  pe_empresa   nonclustered, unique                       0                0                    0 Jun  7 2018  9:47AM Global Index         0        0 
index_emp_grupo        pe_cod_grupo nonclustered                               0                0                    0 Jun  7 2018  9:47AM Global Index         0        0 
index_ptn_name                   index_ptn_seg index_ptn_comp     


