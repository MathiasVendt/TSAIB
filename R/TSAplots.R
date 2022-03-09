#' @title Time Series Analysis Plots
#'
#' @description Plots and saves the ACF and PACF for a pre-defined time series, with and without
#' data transformations (log, sqrt), and differencing.
#' Input type: Time series
#'
#' @param TS The time series for the TSAplots function
#' @param date The time axis in the time series (dates, seconds, intervals)
#' @param trans data transform parameter: trans='log' for log transform, trans='sqrt' for sqrt transform, and trans='NONE' for no transform
#' @param saveas specifies the file format to save the plots in the current working directory. Possible formats is: PDF, JPEG, TIFF, BMP and PNG. e.g.: "pdf" or "jpeg". If none is specified, it will not save the plots
#'
#' @return Plots from TSAplots
#' @export

TSAplots <- function(TS,date,trans="NONE",saveas="NONE") {

  # PDF
  if(saveas=="pdf"){
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

  # JPEG
  if(saveas=="jpeg"){
    # 1. Open jpg file
    jpeg("TSAplots.jpg")
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

  # TIFF
  if(saveas=="tiff"){
    # 1. Open tiff file
    tiff("TSAplots.tiff")
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


  # BMP
  if(saveas=="bmp"){
    # 1. Open png file
    bmp("TSAplots.bmp")
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


  # PNG
  if(saveas=="png"){
    # 1. Open png file
    png("TSAplots.png")
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

  #NONE

    # 1. Create the plots
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



}
