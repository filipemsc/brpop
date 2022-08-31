#' Municipality yearly population estimates per sex
#'
#' This function provides a tibble containing population estimates for Brazilian municipalities per sex from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#' @format A tibble with the following variables.
#' \describe{
#'   \item{codmun}{Municipality 6 digits code}
#'   \item{year}{Year of the estimative}
#'   \item{sex}{Sex}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

mun_sex_pop_totals <- function(){

  res <- dtplyr::lazy_dt(x = brpop::mun_pop) %>%
    dplyr::group_by(.data$codmun, .data$year, .data$sex) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$codmun, .data$year, .data$sex) %>%
    tibble::as_tibble()

  return(res)
}
