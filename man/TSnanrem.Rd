% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TSnanrem.R
\name{TSnanrem}
\alias{TSnanrem}
\title{Time series NaN remover/replacer}
\usage{
TSnanrem(TS, method = "mean", value_nr = 0)
}
\arguments{
\item{TS}{The time series to remove NaN from}

\item{method}{The imputation method. e.g.: "omit", "mean", "median" or "value"}

\item{value_nr}{The specific value for the "value" imputing method. e.g.: value_nr=0}
}
\value{
Time series with NaNs removed or replaced
}
\description{
Removes or imputes NaN from the time series data set, with a specified method of choice
}
