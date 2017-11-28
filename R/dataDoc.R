#' CVD risk synthetic dataset
#'
#' A synthetic dataset for predicting cardiovascular risk in patient cohorts.
#'
#' @docType data
#' @name cvd_patient
#' @usage data(cvd_patient)
#' @format
#'   a data frame with variables related to cvd risk.
#'   \itemize{
#'     \item{\code{patientID}} {Patient Identifier. Unique patient identifier for Health Hospital University.
#'     HHUID + 8 digit code}
#'     \item{\code{age}} {Patient Age Category. Age category of patient. string of age ranges.
#` Note that upper bound is not inclusive}
#'     \item{\code{htn}} {Does patient have hypertension? Threshold systolic blood pressure is 150. Y/N}
#'     \item{\code{treat}} {Is patient receiving hypertension treatment? Y/N}
#'     \item{\code{smoking}} {Y/N based on threshold of pack years: 10}
#'     \item{\code{race}} {Race based on self-defined question in survey. AmInd (american indian),
#'     Asian/PI (asian/pacific islander), Black/AfAm (Black/African American), White}
#'     \item{\code{gender}} {Gender of patient. Male, Female, NA means that patient did not want gender recorded.}
#'     \item{\code{t2d}} {Whether patient has Type 2 diabetes. Y/N.}
#'     \item{\code{numAge}} {numerical age in years.}
#'     \item{\code{bmi}} {Body Mass Index of Patient. kg/m^2}
#'     \item{\code{sbp}} {Systolic Blood Pressure in mm/Hg}
#'     \item{\code{cvd}} {Cardiovascular disesase based on extraction from patient billing codes. Y/N}
#'   }
#'
#' @details
#'
#'
#' @source
#'
#'
#'
#' @examples
#' data(cvd_patient)
#'
#' #look at summary of data
#' summary(cvd_patient)
