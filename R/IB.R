#' @title Intermission Bias
#'
#' @description Corrects a struct of timeseries for up to two intermission biases
#'
#' @param TSM The time series struct with the intermission bias
#' @param date The time axis in the time series (dates, seconds, intervals)
#' @param biasvec The vector containging up to 2 different bias. If the data only contains 1 bias, insert that value instead
#' @param biasid a struct with the same dimensions as TSM, with integers indicating the bias: 0 for the restrained time series, 1 for the first bias and 2 for the second bias.
#' @return Time series struct with bias correction
#' @export

IB <- function(TSM,date,biasvec=c(1,-2),biasid) {

  TimeSeriesMatrix=TSM

  numberoftime=dim(TimeSeriesMatrix)[3] # dims are: x, y and time.
  bias1=biasvec[1]
  bias2=biasvec[2]

  TimeSeriesMatrixBias=TimeSeriesMatrix

  TimeSeriesMatrixCORR=TimeSeriesMatrixBias
  TimeSeriesMatrixCORR[biasid==1]=TimeSeriesMatrixCORR[biasid==1]+bias1
  TimeSeriesMatrixCORR[biasid==2]=TimeSeriesMatrixCORR[biasid==2]+bias2


  par(mfrow = c(2,1),mar=c(4,4,1,1))
  # Plottting the biased data
  plot(date,rep(0,numberoftime),xlab="Date",ylab="Measurement",main='TS+bias',
       col="white",ylim = c(min(TimeSeriesMatrixBias,na.rm = TRUE),max(TimeSeriesMatrixBias,na.rm = TRUE)))
  for (j in 1:dim(TimeSeriesMatrixBias)[2]) {
    for (k in 1:dim(TimeSeriesMatrixBias)[1]) {
      points(date,TimeSeriesMatrixBias[k,j,],col="black")
    }
  }
  # Plottting the bias corrected data
  plot(date,rep(0,numberoftime),xlab="Date",ylab="Measurement",main='TS w. bias correction',
       col="white",ylim = c(min(TimeSeriesMatrixCORR,na.rm = TRUE),max(TimeSeriesMatrixCORR,na.rm = TRUE)))
  for (j in 1:dim(TimeSeriesMatrixBias)[2]) {
    for (k in 1:dim(TimeSeriesMatrixBias)[1]) {
      points(date,TimeSeriesMatrixCORR[k,j,],col="black")
    }
  }


}
