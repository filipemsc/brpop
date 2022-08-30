## code to prepare `mun_reg_saude` dataset goes here

mun_reg_saude <- rpcdas::generic_pcdas_query(sql_query = "SELECT res_codigo_adotado AS cod_mun, res_RSAUDCOD AS cod_reg_saude FROM \"datasus-sim\" GROUP BY res_codigo_adotado, res_RSAUDCOD") %>%
  dplyr::mutate(
    cod_mun = as.character(cod_mun),
    cod_reg_saude = as.character(cod_reg_saude)
  ) %>%
  dplyr::rename(codmun = cod_mun, codregsaude = cod_reg_saude)


usethis::use_data(mun_reg_saude, overwrite = TRUE)
