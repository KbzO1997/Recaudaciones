55767349 -- Reverso
55756886 -- Pago


select ts_hora, * from cob_cuentas..cc_tran_servicio hs where ts_tsfecha = '08/10/2022' and ts_secuencial in(55756886,55767349)

ts_hora                     ts_secuencial ts_cod_alterno ts_tipo_transaccion ts_clase ts_tsfecha                  ts_tabla ts_usuario                                                       ts_terminal                                                      ts_rol ts_correccion ts_ssn_corr ts_reentry ts_origen ts_nodo                        ts_referencia   ts_remoto_ssn ts_cheque_rec ts_ctacte   ts_cta_banco             ts_filial ts_oficina ts_oficial ts_fecha_aper               ts_cliente  ts_ced_ruc    ts_estado ts_direccion_ec ts_descripcion_ec                                                                                                        ts_ciclo ts_categoria ts_producto ts_tipo ts_indicador ts_moneda ts_default  ts_tipo_def ts_rol_ente ts_tipo_promedio ts_numero ts_fecha                    ts_autorizante                                                   ts_causa ts_servicio ts_saldo                   ts_fecha_uso                ts_monto                   ts_fecha_ven                ts_filial_aut ts_ofi_aut ts_autoriz_aut                                                   ts_filial_anula ts_ofi_anula ts_autoriz_anula                                                 ts_cheque_desde ts_cheque_hasta ts_chequera ts_num_cheques ts_departamento ts_cta_gir               ts_endoso   ts_cod_banco ts_corresponsal ts_propietario ts_carta    ts_sec_correccion ts_cheque   ts_cta_banco_dep         ts_oficina_pago ts_contratado              ts_valor                   ts_ocasional               ts_banco ts_ccontable         ts_cta_funcionario ts_mercantil ts_cta_asociada          ts_tipocta ts_fecha_eimp               ts_fecha_rimp               ts_fecha_rofi               ts_tipo_chequera ts_stick_imp ts_tipo_imp ts_tarjcred          ts_aporte_iess             ts_descuento_iess          ts_fonres_iess             ts_agente                      ts_nombre                                                                                                                ts_debito ts_hora                     ts_oficina_cta ts_tsn      ts_tipo_contable ts_estado_sob ts_tipo_credito ts_plazo ts_tipo_sobregiro ts_campo_alt_uno               ts_campo_alt_dos               ts_ubicacion 
--------------------------- ------------- -------------- ------------------- -------- --------------------------- -------- ---------------------------------------------------------------- ---------------------------------------------------------------- ------ ------------- ----------- ---------- --------- ------------------------------ --------------- ------------- ------------- ----------- ------------------------ --------- ---------- ---------- --------------------------- ----------- ------------- --------- --------------- ------------------------------------------------------------------------------------------------------------------------ -------- ------------ ----------- ------- ------------ --------- ----------- ----------- ----------- ---------------- --------- --------------------------- ---------------------------------------------------------------- -------- ----------- -------------------------- --------------------------- -------------------------- --------------------------- ------------- ---------- ---------------------------------------------------------------- --------------- ------------ ---------------------------------------------------------------- --------------- --------------- ----------- -------------- --------------- ------------------------ ----------- ------------ --------------- -------------- ----------- ----------------- ----------- ------------------------ --------------- -------------------------- -------------------------- -------------------------- -------- -------------------- ------------------ ------------ ------------------------ ---------- --------------------------- --------------------------- --------------------------- ---------------- ------------ ----------- -------------------- -------------------------- -------------------------- -------------------------- ------------------------------ ------------------------------------------------------------------------------------------------------------------------ --------- --------------------------- -------------- ----------- ---------------- ------------- --------------- -------- ----------------- ------------------------------ ------------------------------ ------------ 
Aug 10 2022  3:29PM         55756886      0              62688                        Aug 10 2022 12:00AM         (null)   ope998                                                           term24                                                           5      N             0           (null)     L         BOLIVSRV                       0922222222      (null)        0             (null)      5005070292               1         0          (null)     (null)                      0                         (null)    (null)          (null)                                                                                                                   (null)   (null)       (null)      L       (null)       1         (null)      N           (null)      (null)           (null)    Aug 10 2022 12:00AM                                                                          19574    (null)      0.00                       (null)                      10.00                      (null)                      (null)        (null)     0.00                                                             (null)          (null)       0.00                                                             (null)          (null)          (null)      (null)         (null)          (null)                   55756886                 (null)                         (null)      (null)            (null)      (null)                   (null)          0.00                       0.00                       0.00                       (null)   (null)               (null)             (null)       (null)                   C          (null)                      (null)                      (null)                      IBK              (null)       (null)      (null)               0.00                       (null)                     (null)                                                                                                                                                                             (null)    Aug 10 2022  3:29PM         (null)         55756886    (null)           (null)        (null)          (null)   (null)                                                                          0            
Aug 10 2022  3:30PM         55767349      0              62688                        Aug 10 2022 12:00AM         (null)   ope998                                                           term24                                                           5      S             55756886    (null)     L         BOLIVSRV                       0922222222      (null)        0             (null)      5005070292               1         0          (null)     (null)                      0                         (null)    (null)          (null)                                                                                                                   (null)   (null)       (null)      L       (null)       1         (null)      N           (null)      (null)           (null)    Aug 10 2022 12:00AM                                                                          19574    (null)      0.00                       (null)                      10.00                      (null)                      (null)        (null)     0.00                                                             (null)          (null)       0.00                                                             (null)          (null)          (null)      (null)         (null)          (null)                   55767349                 (null)                         (null)      (null)            (null)      (null)                   (null)          0.00                       0.00                       0.00                       (null)   (null)               (null)             (null)       (null)                   C          (null)                      (null)                      (null)                      IBK              (null)       (null)      (null)               0.00                       (null)                     (null)                                                                                                                                                                             (null)    Aug 10 2022  3:30PM         (null)         55767349    (null)           (null)        (null)          (null)   (null)                                                                          0            



select tm_saldo_contable,tm_saldo_disponible, tm_hora ,tm_valor, tm_tsn,* from cob_cuentas..cc_tran_monet where
tm_cta_banco = '5005070292'
and tm_fecha ='2022/08/10'
and tm_valor = 10.00
order by tm_hora

tm_saldo_contable          tm_saldo_disponible        tm_hora                     tm_valor                   tm_tsn      tm_fecha                    tm_secuencial tm_cod_alterno tm_tipo_tran tm_filial tm_oficina tm_usuario                     tm_terminal tm_rol tm_correccion tm_sec_correccion tm_origen tm_nodo                                                          tm_reentry tm_fecha_ult_mov            tm_oficina_pago tm_cta_banco             tm_cheque   tm_valor                   tm_chq_propios             tm_chq_locales             tm_chq_ot_plazas           tm_remoto_ssn tm_moneda tm_efectivo                tm_tipo tm_signo tm_indicador tm_causa tm_departamento tm_ctabanco_dep          tm_prod_dep tm_l24h                    tm_remesas                 tm_contratado              tm_ocasional               tm_saldo_contable          tm_saldo_disponible        tm_banco tm_ctadestino            tm_tipo_xfer tm_tasa_interes          tm_tasa_impuesto         tm_tasa_solca            tm_tasa_comision         tm_valor_interes           tm_valor_impuesto          tm_valor_solca             tm_valor_comision          tm_tarjeta_atm           tm_hora                     tm_beneficiario                tm_oficina_cta tm_tsn      tm_tipo_contable tm_campo_alt_uno               tm_campo_alt_dos               tm_ubicacion tm_canal 
-------------------------- -------------------------- --------------------------- -------------------------- ----------- --------------------------- ------------- -------------- ------------ --------- ---------- ------------------------------ ----------- ------ ------------- ----------------- --------- ---------------------------------------------------------------- ---------- --------------------------- --------------- ------------------------ ----------- -------------------------- -------------------------- -------------------------- -------------------------- ------------- --------- -------------------------- ------- -------- ------------ -------- --------------- ------------------------ ----------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------- ------------------------ ------------ ------------------------ ------------------------ ------------------------ ------------------------ -------------------------- -------------------------- -------------------------- -------------------------- ------------------------ --------------------------- ------------------------------ -------------- ----------- ---------------- ------------------------------ ------------------------------ ------------ -------- 
442,725.08                 442,725.08                 Aug 10 2022  3:29PM         10.00                      55756886    Aug 10 2022 12:00AM         1659003020    0              3050         1         0          ope998                         term24      5      N             (null)            L         BOLIVSRV                                                         N          (null)                      (null)          5005070292               0           10.00                      (null)                     (null)                     (null)                     (null)        1         (null)                     (null)  D        1            524      1               (null)                   (null)      (null)                     (null)                     (null)                     (null)                     442,725.08                 442,725.08                 (null)   0922222222               (null)       (null)                   (null)                   (null)                   (null)                   (null)                     (null)                     (null)                     (null)                     (null)                   Aug 10 2022  3:29PM         0922222222                     50             55756886    2                (null)                         (null)                         0            (null)   
442,735.08                 442,735.08                 Aug 10 2022  3:30PM         10.00                      55767349    Aug 10 2022 12:00AM         1222425305    0              3050         1         0          ope998                         term24      5      S             (null)            L         BOLIVSRV                                                         N          (null)                      (null)          5005070292               55756886    10.00                      (null)                     (null)                     (null)                     (null)        1         (null)                     (null)  D        1            524      1               (null)                   (null)      (null)                     (null)                     (null)                     (null)                     442,735.08                 442,735.08                 (null)   0922222222               (null)       (null)                   (null)                   (null)                   (null)                   (null)                     (null)                     (null)                     (null)                     (null)                   Aug 10 2022  3:30PM         0922222222                     50             55767349    2                (null)                         (null)                         0            (null)   


SELECT cc_disponible, * FROM cob_cuentas..cc_ctacte where cc_cta_banco = '5005070292'

cc_disponible              cc_ctacte   cc_cta_banco             cc_filial cc_oficina cc_oficial cc_nombre                                                        cc_fecha_aper               cc_cliente  cc_ced_ruc    cc_estado cc_cliente_ec cc_direccion_ec cc_descripcion_ec                                                                                                        cc_tipo_dir cc_cobro_ec cc_parroquia cc_zona cc_microficha cc_man_firmas cc_ciclo cc_categoria cc_creditos_mes            cc_debitos_mes             cc_disponible              cc_12h                     cc_24h                     cc_48h                     cc_72h_diferido            cc_remesas                 cc_rem_hoy                 cc_rem_diferido            cc_fecha_ult_mov            cc_fecha_ult_upd            cc_fecha_prx_corte          cc_cred_24h cc_cred_rem cc_dias_sob cc_dias_sob_cont cc_retenidos cc_retenciones             cc_certificados cc_protestos cc_prot_justificados cc_prot_periodo_ant cc_sobregiros cc_anulados cc_revocados cc_bloqueos cc_num_blqmonto cc_suspensos cc_condiciones cc_uso_sobregiro cc_uso_remesa cc_num_chq_defectos cc_producto cc_tipo cc_moneda cc_default  cc_tipo_def cc_rol_ente cc_chequeras cc_cheque_inicial cc_tipo_promedio cc_historico_seq cc_saldo_ult_corte         cc_fecha_ult_corte          cc_saldo_ayer              cc_monto_blq               cc_promedio1               cc_promedio2               cc_promedio3               cc_promedio4               cc_promedio5               cc_promedio6               cc_personalizada cc_contador_firma cc_agen_ec cc_cat_labis cc_contador_trx cc_creditos_hoy            cc_cta_ahomerc           cc_cta_funcionario cc_debitos_hoy             cc_fecha_firma              cc_fecha_prx_capita         cc_fecha_ult_capi           cc_fecha_ult_mov_int        cc_mercantil cc_num_chq_pag_merc cc_num_cta_asoc cc_origen cc_prod_banc cc_prom_disponible         cc_saldo_impuesto          cc_saldo_interes           cc_tipocta cc_cubre_sobregiro cc_tipo_contable cc_campo_alt_uno               cc_campo_alt_dos               
-------------------------- ----------- ------------------------ --------- ---------- ---------- ---------------------------------------------------------------- --------------------------- ----------- ------------- --------- ------------- --------------- ------------------------------------------------------------------------------------------------------------------------ ----------- ----------- ------------ ------- ------------- ------------- -------- ------------ -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- --------------------------- --------------------------- --------------------------- ----------- ----------- ----------- ---------------- ------------ -------------------------- --------------- ------------ -------------------- ------------------- ------------- ----------- ------------ ----------- --------------- ------------ -------------- ---------------- ------------- ------------------- ----------- ------- --------- ----------- ----------- ----------- ------------ ----------------- ---------------- ---------------- -------------------------- --------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- -------------------------- ---------------- ----------------- ---------- ------------ --------------- -------------------------- ------------------------ ------------------ -------------------------- --------------------------- --------------------------- --------------------------- --------------------------- ------------ ------------------- --------------- --------- ------------ -------------------------- -------------------------- -------------------------- ---------- ------------------ ---------------- ------------------------------ ------------------------------ 
442,735.08                 162325      5005070292               1         50         204        NOMBRE: 1396206                                                  Aug 22 2014 12:00AM         1396206     1705243804    A         1396206       3               DESCRIPCION EC: 1396206                                                                                                  D           N           1024         N       0             N             3        N            34,554.71                  591,034.72                 442,735.08                 0.00                       0.00                       0.00                       0.00                       0.00                       0.00                       0.00                       Aug 10 2022 12:00AM         Jul 30 2020 12:00AM         Jun 29 2018 12:00AM         N           N           0           0                0            0.00                       2               0            0                    0                   0             0           0            0           0               0            1              0                0             17                  3           R       1         0           D           P           14           1                 M                0                608.82                     Nov 30 2017 12:00AM         608.82                     0.00                       -29,711.29                 369.18                     605.36                     524.42                     647.52                     3,249.34                   N                2                 0          N            1731            34,554.71                                           N                  591,034.72                 Aug 22 2014 12:00AM         Aug 22 2014 12:00AM         Aug 22 2014 12:00AM         Aug 21 2014 12:00AM         N            0                   0               2         3            -29,682.53                 (null)                     0.00                       P          (null)             2                (null)                         (null)                         