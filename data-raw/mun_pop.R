## code to prepare `mun_pop_idade` dataset goes here

list_dbfs <- list.files(path = "data-raw/DBFs", pattern = "*.dbf", full.names = TRUE)

mun_pop <- tibble::tibble()

for(f in list_dbfs){
  message(f)
  tmp <- foreign::read.dbf(file = f, as.is = FALSE)
  mun_pop <- dplyr::bind_rows(mun_pop, tmp)
  rm(tmp)
}

mun_pop <- mun_pop |>
  dplyr::rename(
    codmun = COD_MUN,
    year = ANO,
    sex = SEXO,
    age = IDADE,
    pop = POP
  ) |>
  dplyr::mutate(
    codmun = as.character(codmun),
    year = as.integer(as.character(year)),
    sex = dplyr::recode_factor(.x = sex, "1" = "Male", "2" = "Female"),
    age = as.integer(as.character(age))
  )

usethis::use_data(mun_pop, overwrite = TRUE, compress = "bzip2")
