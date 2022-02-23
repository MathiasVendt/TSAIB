#' @title Time Series Analysis Plots
#'
#' @description Estimates a model based on time series analysis, and accounts for
#' intermission bias of satellite observations.
#' Input file type: NetCDF (Network Common Data Form).
#'
#' @param x The time series for the TSAplots function
#'
#' @return The output from \code{\link{print}}
#' @export
#'
#' @examples
#' TSAplots("Stine and Karina")
#' \dontrun{
#' TSAplots("Mathias")}
TSAplots <- function(x) {
  print(paste0("Hello ", x, ", this is my TSAIB R-package!"))
}
