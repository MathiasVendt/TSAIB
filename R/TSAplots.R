#' @title Time Series Analysis Plots
#'
#' @description Plots and saves the ACF and PACF for a pre-defined time series, with and without
#' data transformations (log, sqrt), and differencing.
#' Input type: Time series
#'
#' @param TS The time series for the TSAplots function
#' @param date
#'
#' @return Plots from TSAplots
#' @export

TSAplots <- function(TS,date) {
  plot(date,TS)
}
