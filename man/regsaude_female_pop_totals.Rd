% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regsaude_female_pop_totals.R
\name{regsaude_female_pop_totals}
\alias{regsaude_female_pop_totals}
\title{Health region yearly female population estimates totals}
\usage{
regsaude_female_pop_totals()
}
\value{
A tibble.
}
\description{
This function provides a tibble containing female population estimates for Brazilian health regions totals from 2000 to 2021.
}
\details{
The estimates were calculated by DataSUS (Brazilian Ministry of Health), manually downloaded from DataSUS website, and organized as a tibble.

More details about the estimation methodology may be found here: \url{http://tabnet.datasus.gov.br/cgi/POPSVS/NT-POPULACAO-RESIDENTE-2000-2021.PDF}

\describe{
\item{regsaude}{health region 4 digits code}
\item{year}{year of the estimative}
\item{pop}{population estimative}
}
}
\seealso{
\link{regsaude_female_pop}.
}
