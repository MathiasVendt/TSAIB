#' @title Time series NaN remover
#'
#' @description Removes NaN from the time series data set, with a specified method of choice
#'
#' @param nco The NetCDF object (open with "nc_open" from the "ncdf4" library)
#' @param lonid The variable id for longitude vector. e.g.: "longitude"
#' @param latid The variable id for latitude vector. e.g.: "latitude"
#' @param timeid The variable id for the time vector. e.g.: "date"
#' @param measurementsid The variable id for the measurements vector. e.g.: "sea_level_anomaly"
#' @param coord The center coordinate for the TS grid area. e.g.: c(lon,lat) i.e. c(-164,74)
#' @param radius The square radius of the TS grid. e.g: 0=1x1 grid, 1=3x3 grid, 2=5x5 grid etc.
#' @param dlon Number of data points for each degree longitude
#' @param dlat Number of data points for each degree latitude
#'
#' @return Time series from grid
#' @export
TSnanrem <- function() {


}
