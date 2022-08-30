#' UF yearly population estimates
#'
#' This function provides a tibble containing population estimates for Brazilian UFs from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#'
#' \describe{
#'   \item{coduf}{UF 2 digits code}
#'   \item{year}{Year of the estimative}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

uf_pop_totals <- function(){

  # Cluster for parallel processing
  cluster <- multidplyr::new_cluster(n = future::availableCores(omit = 1))

  res <- brpop::mun_pop %>%
    dplyr::mutate(coduf = substr(x = .data$codmun, start = 0, stop = 2)) %>%
    dplyr::select(-.data$codmun) %>%
    dplyr::group_by(.data$coduf, .data$year) %>%
    multidplyr::partition(cluster) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::collect() %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$coduf, .data$year)

  return(res)
}
