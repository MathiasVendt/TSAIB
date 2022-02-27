#' @title Grid Time Series Extractor
#'
#' @description Extracts a time series from a NetCDF lon&lat coordinate grid
#'
#' @param nco The NetCDF object (open with "nc_open" from the "ncdf4" library)
#' @param lonid The variable id for longitude vector. e.g.: "longitude"
#' @param latid The variable id for latitude vector. e.g.: "latitude"
#' @param timeid The variable id for the time vector. e.g.: "date"
#' @param measurementsid The variable id for the measurements vector. e.g.: "sea_level_anomaly"
#' @param coord The center coordinate for the TS grid area. e.g.: c(lon,lat) i.e. c(-165,75)
#' @param radius The square radius of the TS grid. e.g: 0=1x1 grid, 1=3x3 grid, 2=5x5 grid etc.
#' @param dlon Number of datapoints for each degree longitude
#' @param dlat Number of datapoints for each degree latitude
#'
#' @return Time series from grid
#' @export
GridTSExtract <- function(nco,lonid,latid,timeid,measurementsid,coord,radius,dlon,dlat) {
library(ncdf4) # package for netcdf manipulation

lon =  ncvar_get(nco, varid = lonid) # extracting longtitude
lat =  ncvar_get(nco, varid = latid) # extracting latitude
date = ncvar_get(nco, varid = timeid)# extracting date
measurements = ncvar_get(nco, varid = measurementsid) #extracting measurements
centerTS=measurements[which(lat==coord[2]),which(lon==coord[1]),] # lat 75 har NAN
# Allocating space
  TSextract=array(dim=c(1+2*radius,1+2*radius,length(centerTS)))
# Extrating defined TS grid
r=radius
  TSextract[1:(1+2*r),1:(1+2*r),]=measurements[which(lat==coord[2]-r/dlat):which(lat==coord[2]+r/dlat),which(lon==coord[1]-r/dlon):which(lon==coord[1]+r/dlon),]
}

