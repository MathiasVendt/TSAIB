#' @title Template Model Builder Time Series Analysis
#'
#' @description Utilizes TMB, which is a C++ interface for automatic differentiation that implements Laplace's method, to estimate a time series model
#'
#' @param TSM The time series matrix, with dimensions (x/lon,y/lat,timesteps)
#' @param date The time axis in the time series (i.e., dates, seconds, intervals)
#' @return RW model
#' @export

TMBTSA <- function(TSM,date) {


  # Defining the Time Series Matrix
  TimeSeriesMatrix=TSM

  # Defining the time vektor length
  numberoftime=dim(TimeSeriesMatrix)[3] # dims are: 61x, 61y and 325months.

  #Initializing time index
  timeindex=array(0,dim(TimeSeriesMatrix)) # allocating space with zeros


  for (i in 1:numberoftime) {
    timeindex[,,i]=i-1               # Inserting index, with start index=0
  }
  timeindex=as.vector(timeindex)

  # Initializing zero vector (lam)
  lam=rep(0,numberoftime)  # allocating space

  # Replacing NaN with NA
  TimeSeriesMatrix[is.na(TimeSeriesMatrix)]=NA

  # Vectorizing the time series matrix
  TimeSeriesVector=as.vector(TimeSeriesMatrix)

  # Initializing TMB
  #library(TMB)
  #compile("RW.cpp")
  #dyn.load(dynlib("RW"))

  data <- list(y=TimeSeriesVector,
               timeindex=timeindex)
  parameters <- list(
    logSdRw=0,
    logSdObs=0,
    lam0=0,
    lam=lam
  )

  obj <- MakeADFun(data,parameters,random="lam",DLL="TMBTSA_RW")

  obj$fn()
  obj$gr()
  opt<-nlminb(obj$par,obj$fn,obj$gr)

  sdr<-sdreport(obj)
  pl <- as.list(sdr,"Est")
  plsd <- as.list(sdr,"Std")
  save(pl,plsd,file="RW.RData")

  # The correct CI95%
  t.val <- qt(0.975, length(data$y) - 2)

  plot(date,rep(0,numberoftime),xlab="Date",ylab="Measurement",main='TS',
       col="white",ylim = c(min(TimeSeriesMatrix,na.rm = TRUE),max(TimeSeriesMatrix,na.rm = TRUE)))
  for (j in 1:dim(TimeSeriesMatrix)[2]) {
    for (k in 1:dim(TimeSeriesMatrix)[1]) {
      points(date,TimeSeriesMatrix[k,j,],col="black")
    }
  }
  lines(date[1:length(plsd$lam)],pl$lam,col="red")
  lines(date[1:length(plsd$lam)],pl$lam+ t.val*plsd$lam,col="green")
  lines(date[1:length(plsd$lam)],pl$lam- t.val*plsd$lam,col="green")

}
