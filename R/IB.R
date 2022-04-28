#' @title Time Series model (simple constant + trend + sinus + cosine)
#'
#' @description Estimates a simple time series model
#'
#' @param TSM The time series struct with the intermission bias
#' @param date The time axis in the time series (dates, seconds, intervals)
#' @param biasvec The vector containging up to 2 different bias. If the data only contains 1 bias, insert that value instead
#' @param biasid a struct with the same dimensions as TSM, with integers indicating the bias: 0 for the restrained time series, 1 for the first bias and 2 for the second bias.
#' @return Time series struct with bias correction
#' @export

IB <- function(TSM,date,biasvec=c(1,-2),biasid) {


}
