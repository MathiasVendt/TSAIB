#' @title Template Model Builder Time Series Analysis
#'
#' @description Utilizes TMB, which is a C++ interface for automatic differentiation that implements Laplace's method, to estimate a time series model
#'
#' @param TSM The time series matrix, with dimensions (x/lon,y/lat,timesteps)
#' @param date The time axis in the time series (i.e., dates, seconds, intervals)
#' @param biasid A struct with the same dimensions as TSM, with integers indicating the bias: 0 for the restrained time series and 1 for the bias. If no bias is present, biasid contains only zeros.
#' @return RW model
#' @export

TMBTSA <- function(TSM,date,biasid) {


  # Defining the Time Series Matrix
  TimeSeriesMatrix=TSM

  # Defining the time vektor length
  numberoftime=dim(TimeSeriesMatrix)[3] # dims are: 61x, 61y and 325months.

  #Initializing time index
  timeindex=array(0,dim(TimeSeriesMatrix)) # allocating space with zeros


  for (i in 1:numberoftime) {
    timeindex[,,i]=i-1               # Inserting index, with start index=0
  }
  # vectorize indices
  timeindex=as.vector(timeindex)
  biasid=as.vector(biasid)

  # Initializing zero vector (lam)
  lam=rep(0,numberoftime)  # allocating space

  # Replacing NaN with NA
  TimeSeriesMatrix[is.na(TimeSeriesMatrix)]=NA

  # Vectorizing the time series matrix
  TimeSeriesVector=as.vector(TimeSeriesMatrix)

  # Initializing TMB
  library(TMB)
#  compile("TSAIB.cpp")
#  dyn.load(dynlib("TSAIB"))

  data <- list(y=TimeSeriesVector,
               timeindex=timeindex,
               biasid=biasid)
  parameters <- list(
    logSdRw=0,
    logSdObs=0,
    lam0=0,
    lam=lam,
    bias=0
  )

  obj <- MakeADFun(data,parameters,random="lam",DLL="TSAIB")

  obj$fn()
  obj$gr()
  opt<-nlminb(obj$par,obj$fn,obj$gr)

  sdr<-sdreport(obj)
  pl <- as.list(sdr,"Est")
  plsd <- as.list(sdr,"Std")
  save(pl,plsd,file="TMBTSA.RData")

  # The correct CI95%
  t.val <- qt(0.975, length(data$y) - 2)

  plot(date,rep(0,numberoftime),xlab="Date",ylab="Measurement",main='TS',
       col="white",ylim = c(min(pl$lam- t.val*plsd$lam),max(pl$lam+ t.val*plsd$lam)))
  lines(date[1:length(plsd$lam)],pl$lam,col="red")
  lines(date[1:length(plsd$lam)],pl$lam+ t.val*plsd$lam,col="green")
  lines(date[1:length(plsd$lam)],pl$lam- t.val*plsd$lam,col="green")

}
