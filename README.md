# cvdRiskData

Synthetic Cardiovascular Risk Dataset and Data generation script available as an R package. 

Explore the dataset here: https://tladeras.shinyapps.io/cvdnight1/

More information about the generation of this dataset 
is available here: https://www.biorxiv.org/content/early/2017/12/12/232611

To install in R:

```
install.packages("devtools")
devtools::install_github("laderast/cvdRiskData")
```
To access the data in R:

```
library(cvdRiskData)
## full patient data
data(cvd_patient)
## subset with SNP covariates
data(cvd_genodata)
```

If you would like csv versions of this dataset, it is available in the `data-raw/` folder of this repo.
