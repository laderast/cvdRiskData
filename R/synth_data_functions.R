#' function to concatenate a matrix into a vector by row
#'
#' @param mat
#'
#' @return
#' @export
#'
#' @examples
byRow <- function(mat){
  rowVec <- lapply(1:nrow(mat), function(x){mat[x,]})
  outVec <- Reduce(c, rowVec)
  outVec
}

yn <- c("no","yes")

#' Given generated data, calculate framingham risk score for Males
#'
#' @param df
#'
#' @return original data.frame with extra column outProb
#' @export
#'
#' @examples
maleRiskScore <-function(df) {

  coeffList <- list(numAge=3.11296, numHtn=1.85508,
                    numSmoke=0.70953, numT2D=0.5316, #numGenotype=0.55,
                    numBMI=.7927)

  coeffNames <- names(coeffList)

  len <- nrow(df)

  coeffList2 <- lapply(names(coeffList), function(x){vec <-
    rep(coeffList[[x]], times=len)
  vec
  })

  names(coeffList2) <- names(coeffList)

  coeffFrame <- data.frame(coeffList2)

  coeffFrame <- coeffFrame %>% mutate(numHtn2 =
                                        ifelse(df$treat=="Y", 1.99881,
                                               1.93303)) %>% select(-numHtn,
                                                                    numHtn=numHtn2)

  df2 <- df[,coeffNames]
  df2[,c("numAge", "numHtn", "numBMI")] <-
    log(df2[,c("numAge", "numHtn", "numBMI")])
  coeffFrame <- coeffFrame[, coeffNames]

  coefSum <- rowSums(coeffFrame * df2)
  outProb <- (1 - 0.88431 ^ exp(coefSum - 23.988))

  return(data.frame(coefSum, outProb))
}



#' Given generated data, calculate framingham risk score for females
#'
#' @param df
#'
#' @return
#' @export
#'
#' @examples
femaleRiskScore <-function(df) {

  coeffList <- list(numAge=2.72107, numHtn=2.81291,
                    numSmoke=0.61868, numT2D=0.77763, #numGenotype=0.55,
                    numBMI=.51125)

  coeffNames <- names(coeffList)

  len <- nrow(df)

  coeffList2 <- lapply(names(coeffList), function(x){vec <-
    rep(coeffList[[x]], times=len)
  vec
  })

  names(coeffList2) <- names(coeffList)

  coeffFrame <- data.frame(coeffList2)

  coeffFrame <- coeffFrame %>% mutate(numHtn2 =
                                        ifelse(df$treat=="Y", 2.88267,
                                               2.81291)) %>% select(-numHtn,
                                                                    numHtn=numHtn2)

  df2 <- df[,coeffNames]
  df2[,c("numAge", "numHtn", "numBMI")] <-
    log(df2[,c("numAge", "numHtn", "numBMI")])
  coeffFrame <- coeffFrame[, coeffNames]

  coefSum <- rowSums(coeffFrame * df2)
  outProb <- (1 - 0.94833 ^ exp(coefSum - 26.0145))

  return(data.frame(coefSum, outProb))
}


selsel <- function(x){sapply(as.character(x), selectInRange)}

convertYN <- function(x){sapply(x, function(y){
  ynVec <- c("N"=0,"Y"=1)
  return(ynVec[y])
})}

#' Resample within a category
#'
#'convenience function for resampling within a range of values
#'i.e., if category is 10-20, then will select a value between
#'10 and 20.
#'
#' @param rangeString
#'
#' @return
#' @export
#'
#' @examples
selectInRange <- function(rangeString){
  outVal <- 0
  if(grepl("-",rangeString, fixed=TRUE)){
    rangeStrs <- strsplit(rangeString,split = "-")[[1]]
    rangeStrs <- as.numeric(rangeStrs)
    outVal <- round(runif(1, rangeStrs[1], rangeStrs[2]))

  }
  if(grepl("+",rangeString, fixed=TRUE)){
    outVal <- gsub("+","",rangeString, fixed=TRUE)
    #print(rangeString)
    ov <- as.numeric(outVal)
    outVal <- round(runif(1, ov, ov+5))
  }
  if(grepl("<", rangeString, fixed=TRUE)){
    outVal <- gsub("<","", rangeString, fixed=TRUE)
    ov <- as.numeric(outVal)
    outVal <- round(runif(1, ov-5, ov ))
  }
  outVal
}


#TODO: rewrite this using purrr functions
#' Given categorical data, generate risk score
#'
#' @param testData 
#'
#' @return
#' @export
#'
#' @examples
transformDataSet <- function(testData){

  testData <- testData[,!duplicated(colnames(testData))]

  newTestData <- testData %>% mutate(numAge=selsel(age),
                                     numBMI=selsel(bmi),
                                     numTchol=selsel(tchol),
                                     #numHtn=ifelse(convertYN(htn)==1,
                                     #rnorm(1, 180, 15),
                                     #rnorm(1, 120,15)),
                                     #             180, 120),
                                     numTreat=convertYN(treat),
                                     numT2D=convertYN(t2d),
                                     numSmoke=convertYN(smoking),
                                     numGenotype=ifelse(genotype=="0001",
                                                        1,0))

  #add sbp value
  numHtn <- sapply(newTestData$htn, function(x){ifelse(x=="N",
                                                       floor(rnorm(1,120,10)),
                                                       floor(rnorm(1,180,10)))})

  #indTreat <- which(newTestData$treat == "Y")

  newTestData$numHtn <- numHtn

  malePatients <- newTestData %>% filter(gender=="M")
  femalePatients <- newTestData %>% filter(gender=="F")

  mp <- maleRiskScore(malePatients)
  fp <- femaleRiskScore(femalePatients)

  out <- rbind(data.frame(malePatients, mp), data.frame(femalePatients,fp))
  #  out <- out %>% mutate(outProb = outScore/100)

  out
}



callCVD <- function(out){
  testVar <- runif(nrow(out))
  out <- data.frame(out, testVar)
  out <- out %>% mutate(cvd= ifelse(testVar < outProb, "Y", "N"))

}

generatePatientIDs <- function(data){
  patientID <- sample(0:1000000, nrow(data))
  patientID <- as.character(patientID)
  patientID <- sapply(patientID, function(x){
    numZeros <- 8 - nchar(x)
    zeroPad <- paste0(as.character(rep(0,numZeros)), collapse="")
    paste0("HHUID", zeroPad,x, collapse = "")
  })
  return(data.frame(patientID, data))
}
