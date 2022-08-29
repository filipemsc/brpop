#' Municipality yearly population estimates per age group
#'
#' This function provides a tibble containing population estimates for Brazilian municipalities per age group from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#'
#' \describe{
#'   \item{codmun}{Municipality 6 digits code}
#'   \item{year}{Year of the estimative}
#'   \item{age_group}{Age group}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

mun_pop_age <- function(age_group_option = "SVS2"){

  # Breaks choice
  if(age_group_option == "SVS1"){
    age_breaks <- age_groups$age_group_1$breaks
    age_labels <- age_groups$age_group_1$labels
  } else if(age_group_option == "SVS2"){
    age_breaks <- age_groups$age_group_2$breaks
    age_labels <- age_groups$age_group_2$labels
  } else {
    age_breaks <- age_group_option[[1]]
    age_labels<- age_group_option[[2]]
  }

  # Cluster for parallel processing
  cluster <- multidplyr::new_cluster(n = future::availableCores(omit = 1))

  res <- brpop::mun_pop %>%
    dplyr::mutate(age_group = cut(
      x = .data$age,
      breaks = age_breaks,
      labels = age_labels,
      ordered_result = TRUE
    )) %>%
    dplyr::group_by(.data$codmun, .data$year, .data$age_group) %>%
    multidplyr::partition(cluster) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::collect() %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$codmun, .data$year, .data$age_group)

  return(res)
}
