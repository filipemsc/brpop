#' Municipality yearly population estimates per age
#'
#' A dataset containing population estimates for Brazilian municipalities by age from 2000 to 2020.
#'
#' The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS FTP server, and organized as a tibble.
#'
#' More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}
#'
#' @format A tibble with 18,948,405 rows and 5 variables:
#' \describe{
#'   \item{codmun}{factor. Municipality 6 digits code.}
#'   \item{year}{factor. Year of the estimative.}
#'   \item{sex}{factor. Sex.}
#'   \item{age}{factor. Age in years.}
#'   \item{pop}{integer. Population estimative.}
#' }
#' @source \url{ftp://ftp.datasus.gov.br/dissemin/publicos/uploads/IBGE/POPSVS/}
"mun_pop_age"
