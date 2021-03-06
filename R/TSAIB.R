#' @title Time Series Analysis and Intermission Bias
#'
#' @description Estimates a model based on time series analysis, and accounts for
#' intermission bias of satellite observations.
#' Input file type: NetCDF (Network Common Data Form).
#'
#' @param x The names for the hello function
#'
#' @return The output from \code{\link{print}}
#' @export
#'
#' @examples
#' TSAIB("Stine and Karina")
#' \dontrun{
#' TSAIB("Mathias")}
TSAIB <- function(x) {
  print(paste0("Hello ", x, ", this is my TSAIB R-package!"))
}
