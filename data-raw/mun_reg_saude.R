## code to prepare `mun_reg_saude` dataset goes here

mun_reg_saude <- readr::read_csv2(file = "data-raw/regsaude_449.csv") %>%
  dplyr::mutate(
    codmun = as.character(codmun),
    codregsaude = as.character(codregsaude)
  )

usethis::use_data(mun_reg_saude, overwrite = TRUE)
