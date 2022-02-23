#' @title Time Series Analysis Plots
#'
#' @description Plots and saves the ACF and PACF for a pre-defined time series, with and without
#' data transformations (log, sqrt), and differencing.
#' Input type: Time series
#'
#' @param TS The time series for the TSAplots function
#' @param date The time axis in the time series (dates, seconds, intervals)
#' @param trans data transform parameter: trans='log' for log transform, trans='sqrt' for sqrt transform, and trans='NONE' for no transform
#'
#' @return Plots from TSAplots
#' @export

TSAplots <- function(TS,date,trans) {
  # 1. Open pdf file
  pdf("TSAplots.pdf")
  # 2. Create the plots
  if(trans=="NONE"){
    par(mfrow = c(3,2))}
  if(trans=="log"){
    par(mfrow = c(4,2))}
  if(trans=="sqrt"){
    par(mfrow = c(4,2))}
  plot(date,TS,main='The raw time series',
       xlab='Date',ylab='Measurements')
  plot(date[1:end(date)-1],diff(TS),main='The differenced (once) time series',
       xlab='Date',ylab='Measurements')
  if(trans=="log"){
  plot(date,log(TS),main='The log-transformed time series',
       xlab='Date',ylab='Measurements')
  acf(log(TS),main='ACF of log-transformed time series')
  pacf(log(TS),main='PACF of log-transformed time series')
  }
  if(trans=="sqrt"){
  plot(date,sqrt(TS),main='The sqrt-transformed time series',
       xlab='Date',ylab='Measurements')
  acf(sqrt(TS),main='ACF of sqrt-transformed time series')
  pacf(sqrt(TS),main='PACF of sqrt-transformed time series')
  }
  if(trans=="NONE"){
  acf(TS,main='ACF of time series')
  pacf(TS,main='PACF of time series')
  }
  acf(diff(TS),main='ACF of the differenced (once) time series')
  pacf(diff(TS),main='PACF of the differenced (once) time series')
  # 3. Close and save the file
  dev.off()
}
