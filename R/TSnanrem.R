#' @title Time series NaN remover/replacer
#'
#' @description Removes or imputes NaN from the time series data set, with a specified method of choice
#'
#' @param TS The time series to remove NaN from
#' @param method The imputation method. e.g.: "omit", "mean", "median" or "value"
#' @param value_nr The specific value for the "value" imputing method. e.g.: value_nr=0
#'
#' @return Time series with NaNs removed or replaced
#' @export
TSnanrem <- function(TS,method="mean",value_nr=0) {
  if(method=="omit"){

    if(is.null(dim(TS))==TRUE){
      nrnan=sum(is.na(TS))
      TS=na.omit(TS)
      print("Number of NaNs removed:")
      print(nrnan)
    }
    else {
      print("Dimensions are too big, TS must be a vector for omit to work")
    }
  }
  if(method=="mean"){
  TS[which(is.na(TS)=="TRUE")]=mean(TS,na.rm = "TRUE")
  }
  if(method=="median"){
    TS[which(is.na(TS)=="TRUE")]=median(TS,na.rm = "TRUE")
  }
  if(method=="value"){
    TS[which(is.na(TS)=="TRUE")]=value_nr
  }
  return(TS)
}
