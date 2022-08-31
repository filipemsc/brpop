#' UF yearly population estimates per sex
#'
#' This function provides a tibble containing population estimates for Brazilian UFs per sex from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#' @format A tibble with the following variables.
#' \describe{
#'   \item{coduf}{UF 2 digits code}
#'   \item{year}{Year of the estimative}
#'   \item{sex}{Sex}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

uf_sex_pop_totals <- function(){

  res <- dtplyr::lazy_dt(mun_pop) %>%
    dplyr::mutate(coduf = substr(x = .data$codmun, start = 0, stop = 2)) %>%
    dplyr::select(-.data$codmun) %>%
    dplyr::group_by(.data$coduf, .data$year, .data$sex) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$coduf, .data$year, .data$sex) %>%
    tibble::as_tibble()

  return(res)
}
