#' @title Example Time Series Data for TSAIB library
#'
#' @description An extracted list using the "GridTSExtract" function, from the data set: Rose, S.K.; Andersen, O.B.; Passaro, M.; Ludwigsen, C.A.; Schwatke, C. Arctic Ocean Sea Level Record from the Complete Radar Altimetry Era: 1991�2018. Remote Sens. 2019, 11, 1672. https://www.mdpi.com/2072-4292/11/14/1672"
#' @format A large list containing 5 elements, which are:
#' \describe{
#' \item{longitude}{Containing longitudes from -180:180, by increments of 0.5 degrees (length: 720)}
#' \item{latitude}{Containing latitudes from 65:81.5, by increments of 0.25 degrees (length: 67)}
#' \item{date}{Containing years from 1991:2019, by increments of 1/12 (length:325)}
#' \item{measurements}{Containing sea_level_anomaly measurements for each increments of: longitude, latitude and date. (dimension: [67,720,325])}
#' \item{TSmatrix}{Containing a 3x3x325 grid of measurements centered around (lon,lat)=(-165,74)}
#' }
"TSdata"
