#' Health region yearly population estimates per sex and age group
#'
#' This function provides a tibble containing population estimates for Brazilian health regions per sex and age groups from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#' @param age_group_option character or list. SVS1 or SVS2 for defaults age groups from DataSUS, or a list with two vectors, where the first vector are breaks, and the second vector are labels.
#'
#' @format A tibble with the following variables.
#' \describe{
#'   \item{regsaude}{Health region code}
#'   \item{year}{Year of the estimative}
#'   \item{sex}{Sex}
#'   \item{age_group}{Age group}
#'   \item{pop}{Population estimative}
#' }
#'
#' @returns A tibble.
#'
#' @importFrom rlang .data
#' @export

regsaude_sex_pop_age <- function(age_group_option = "SVS2"){

  # Breaks choice
  if(is.character(age_group_option)){
    if(age_group_option == "SVS1"){
      age_breaks <- age_groups$age_group_1$breaks
      age_labels <- age_groups$age_group_1$labels
    } else if(age_group_option == "SVS2"){
      age_breaks <- age_groups$age_group_2$breaks
      age_labels <- age_groups$age_group_2$labels
    }
  } else if(is.list(age_group_option)) {
    age_breaks <- age_group_option[[1]]
    age_labels <- age_group_option[[2]]
  }

  res <- dplyr::left_join(brpop::mun_pop, brpop::mun_reg_saude, by = "codmun") %>%
    dtplyr::lazy_dt() %>%
    dplyr::mutate(age_group = cut(
      x = .data$age,
      breaks = age_breaks,
      ordered_result = TRUE
    )) %>%
    dplyr::group_by(.data$codregsaude, .data$year, .data$sex, .data$age_group) %>%
    dplyr::summarise(pop = sum(.data$pop, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$codregsaude, .data$year, .data$sex, .data$age_group) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(age_group = factor(.data$age_group, labels = age_labels))

  return(res)
}
