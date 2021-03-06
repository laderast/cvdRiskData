% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataDoc.R
\docType{data}
\name{cvd_bayes_net}
\alias{cvd_bayes_net}
\title{CVD risk synthetic dataset}
\format{A Bayesian Network of class \code{CPTgrain} using the \code{gRain} package for representing the data.}
\usage{
data(cvd_bayes_net)
}
\description{
A bayesian network for generating categorical synthetic data for assessing cardiovascular risk. 
Variable types are as follows:
}
\details{
\itemize{
    \item \code{age} Patient Age Category. Age category of patient. string of age ranges.
    \item \code{htn} Does patient have hypertension? Threshold systolic blood pressure is 150. Y/N
    \item \code{treat} Is patient receiving hypertension treatment? Y/N
    \item \code{smoking} Y/N based on threshold of pack years: 10
    \item \code{race} Race based on self-defined question in survey. AmInd (american indian),
    Asian/PI (asian/pacific islander), Black/AfAm (Black/African American), White
    \item \code{gender} Gender of patient. Male, Female, NA means that patient did not want gender recorded.
    \item \code{t2d} Whether patient has Type 2 diabetes. Y/N.
    \item \code{bmi} Body Mass Index of Patient. kg/m^2
    \item \code{sbp} Systolic Blood Pressure in mm/Hg
  \item \code{rs10757278} SNP data. Associated with race and total cholesterol.
  \item \code{rs1333049} SNP data. Associated with race and total cholesterol. Always co-occurs with rs10757278.
  \item \code{rs4665058} SNP data. Associated with race and total cholesterol.
  \item \code{rs8055236} SNP data. Variant is associated with increased risk.
  }
Note that not all covariates (including cardiovascular risk) were generated by the dataset.
Further details about how to generate the entire dataset from this network can be found from
\code{generate_data_from_network} in the vignettes folder.
}
\examples{
library(gRain)
data(cvd_bayes_net)

#generate categorical data for 1000 patients
testData <- simulate(cvd_bayes_net, nsim =1000)
summary(testData)
}
\keyword{datasets}
