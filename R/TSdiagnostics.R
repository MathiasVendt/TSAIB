#' @title Time series diagnostics
#'
#' @description Shows basic statistics and characteristics of the time series data
#'
#' @param TS The time series to be analyzed
#' @param nanrem Set NaN to be removed or not. e.g.: nanrem="TRUE"
#'
#' @return Basic statistics and characteristics
#' @export

TSdiagnostics <- function(TS,nanrem="FALSE") {


  # Number of NaN's in data set
  cat("Number of NaN's in the data set\n")
  print(sum(is.na(TS)))

  # Number of objects in the data set
  cat("Number of objects in the data set\n")
  print(length(TS))

  # fraction of data set which is NaN's
  cat("Fraction of the data set which is NaN's\n")
  print(sum(is.na(TS))/length(TS))


# Basic statistics
cat("mean\n")
print(mean(TS,na.rm=nanrem))
cat("standard deviation\n")
print(sd(TS,na.rm=nanrem))
cat("median\n")
print(median(TS,na.rm=nanrem))
cat("quantile\n")
print(quantile(TS,na.rm=nanrem))
cat("sum\n")
print(sum(TS,na.rm=nanrem))
print(t.test(TS))


}
