#' Health regions yearly population estimates
#'
#' This function provides a tibble containing population estimates for Brazilian health regions from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#' @format A tibble with the following variables.
#' \describe{
#'   \item{codregsaude}{Health regions code}
#'   \item{year}{Year of the estimative}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

regsaude_pop_totals <- function(){

  # Cluster for parallel processing
  cluster <- multidplyr::new_cluster(n = future::availableCores(omit = 1))

  res <- dplyr::left_join(brpop::mun_pop, brpop::mun_reg_saude, by = "codmun") %>%
    dplyr::group_by(.data$codregsaude, .data$year) %>%
    multidplyr::partition(cluster) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::collect() %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$codregsaude, .data$year)

  return(res)
}
