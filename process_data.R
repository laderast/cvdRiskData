library(data.table)
cvd_patient <- read.csv("data-raw/fullDataTestSet.csv")
devtools::use_data(cvd_patient, overwrite = TRUE)
