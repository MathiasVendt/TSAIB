#' @title Time series diagnostics
#'
#' @description Shows basic statistics and characteristics of the time series data
#'
#' @param TS The time series to be analyzed
#'
#' @return Basic statistics and characteristics
#' @export

TSdiagnostics <- function(TS) {
# Basic statistics
cat("mean\n")
print(mean(TS))
cat("standard deviation\n")
print(sd(TS))
cat("median\n")
print(median(TS))
cat("quantile\n")
print(quantile(TS))
cat("sum\n")
print(sum(TS))



}
