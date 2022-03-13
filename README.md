
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TSAIB

<!-- badges: start -->
<!-- badges: end -->

The goal of TSAIB is to estimate a model based on time series analysis,
and account for intermission bias of satellite observations. Input file
type: NetCDF (Network Common Data Form).

## Installation

You can install the development version of TSAIB like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Data set used for demonstration of the TSAIB package:

``` r
TSdata
#?TSdata
# Description
#  An extracted list using the "GridTSExtract" function, from the data set:
#  Rose, S.K.; Andersen, O.B.; Passaro, M.; Ludwigsen, C.A.; Schwatke, 
#  C. Arctic Ocean Sea Level Record from the Complete Radar 
#  Altimetry Era: 1991�2018. Remote Sens. 2019, 11, 1672. 
#  https://www.mdpi.com/2072-4292/11/14/1672"
# Usage
#  TSdata
# Format
#  A large list containing 5 elements, which are:
#  longitude: containing longitudes from -180:180, by increments of 0.5 degrees (length: 720)
#  latitude: containing latitudes from 65:81.5, by increments of 0.25 degrees (length: 67)
#  date: containing years from 1991:2019, by increments of 1/12 (length:325)
#  measurements: containing sea_level_anomaly measurements for each increments of: 
#  longitude, latitude and date. (dimension: [67,720,325])
#  TSmatrix: containing a 3x3x325 grid of measurements centered around (lon,lat)=(-165,74)
```

## Functions

``` r
GridTSExtract
#?GridTSExtract
# Description
#  Extracts a time series from a NetCDF lon&lat coordinate grid
# Usage
#GridTSExtract(
#  nco,
#  lonid = "longitude",
#  latid = "latitude",
#  timeid = "date",
#  measurementsid = "sea_level_anomaly",
#  coord = c(-165, 74),
#  radius = 0,
#  dlon = 2,
#  dlat = 4
#)
# Arguments
#  nco: The NetCDF object (open with "nc_open" from the "ncdf4" library)
#  lonid: The variable id for longitude vector. e.g.: "longitude"
#  latid: The variable id for latitude vector. e.g.: "latitude"
#  timeid: The variable id for the time vector. e.g.: "date"
#  measurementsid: The variable id for the measurements vector. e.g.: "sea_level_anomaly"
#  coord: The center coordinate for the TS grid area. e.g.: c(lon,lat) i.e. c(-164,74)
#  radius: The square radius of the TS grid. e.g: 0=1x1 grid, 1=3x3 grid, 2=5x5 grid etc.
#  dlon: Number of data points for each degree longitude
#  dlat:Number of data points for each degree latitude
```

``` r
TSdiagnostics
#?TSdiagnostics
# Description
#  Shows basic statistics and characteristics of the time series data
# Usage
#  TSdiagnostics(TS, nanrem = "FALSE")
# Arguments
#  TS:The time series to be analyzed
#  nanrem: Set NaN to be removed or not. e.g.: nanrem="TRUE"
```

``` r
TSnanrem
#?TSnanrem
# Description
#  Removes or imputes NaN from the time series data set, with a specified method of choice
# Usage
#  TSnanrem(TS, method = "mean", value_nr = 0)
# Arguments
#  TS: The time series to remove NaN from
#  method: The imputation method. e.g.: "omit", "mean", "median" or "value"
#  value_nr: The specific value for the "value" imputing method. e.g.: value_nr=0
```

``` r
TSAplots
#?TSAplots
# Description
#  Plots and saves the ACF and PACF for a pre-defined time series, with and without data 
#  transformations (log, sqrt), and differencing. Input type: Time series
# Usage
#  TSAplots(TS, date, trans = "NONE", saveas = "NONE")
# Arguments
#  TS: The time series for the TSAplots function
#  date: The time axis in the time series (dates, seconds, intervals)
#  trans: data transform parameter: trans='log' for log transform, trans='sqrt' for sqrt 
#  transform, and trans='NONE' for no transform
#  saveas: specifies the file format to save the plots in the current working directory. Possible
#  formats is: PDF, JPEG, TIFF, BMP and PNG. e.g.: "pdf" or "jpeg". If none is specified, it will
#  not save the plots
```

``` r
ARIMAbuilder
#?ARIMAbuilder
# Description
#  Lists the top 5 estimated ARIMA/SARIMA models of the form: ARIMA(p,d,q)x(P,D,Q), based on 
#  specified parameter values and ranges
# Usage
#  ARIMAbuilder(TS, p = 1, d = 1, q = 1, P = 1, D = 1, Q = 1, S = 12)
# Arguments
#  TS: The time series to build the models upon (remember to transform before using this function!)
#  p: The maximum AR value, estimated from plot analysis
#  d: The fixed differencing, often 0, 1 or 2
#  q:   The maximum MA value, estimated from plot analysis
#  P:   The maximum seasonal AR value, estimated from plot analysis
#  D:   The fixed seasonal differencing, often 0, 1 or 2
#  Q:   The mazimum seasonal MA value, estimated from plot analysis
#  S:   The seasonality/period of the seasonal differencing
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(TSAIB)
## Initially extract the wanted time series data from your NetCDF object (nco) using GridTSExtract:

#TSdata=GridTSExtract(nco,"longitude","latitude","date","sea_level_anomaly",c(-165,74),1,2,4)

## TSdiagnostics can be used to gather simple statistics about the data
TSdiagnostics(TSdata$TSmatrix,nanrem="TRUE") #analyze extracted dataset, and remove NaN
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> Warning: Removed 4 rows containing non-finite values (stat_bin).
#> Warning: Removed 4 rows containing non-finite values (stat_boxplot).
#> Warning: Removed 4 rows containing non-finite values (stat_density).
#> Warning: Removed 4 rows containing missing values (geom_point).
```

<img src="man/figures/README-example-1.png" width="100%" />

    #> Number of NaN's in the data set
    #> [1] 4
    #> Number of objects in the data set
    #> [1] 2925
    #> Fraction of the data set which is NaN's
    #> [1] 0.001367521
    #> mean
    #> [1] -0.005382746
    #> standard deviation
    #> [1] 0.06690633
    #> median
    #> [1] -0.011
    #> quantile
    #>     0%    25%    50%    75%   100% 
    #> -0.224 -0.046 -0.011  0.040  0.185 
    #> sum
    #> [1] -15.723
    #> 
    #>  One Sample t-test
    #> 
    #> data:  TS
    #> t = -4.3481, df = 2920, p-value = 1.42e-05
    #> alternative hypothesis: true mean is not equal to 0
    #> 95 percent confidence interval:
    #>  -0.007810080 -0.002955411
    #> sample estimates:
    #>    mean of x 
    #> -0.005382746

    ## Based on the output from TSdiagnostics, NaNs may be dealt with using TSnanrem:
    TS_default=TSnanrem(TSdata$TSmatrix[3,3,])# replaces NaN by mean, as default

    ## With the NaN's taken care of, a set of time series analysis plots is made with TSAplots
    TSAplots(TS_default,TSdata$date)
    #> Warning in 1:end(date): numerical expression has 2 elements: only the first used

<img src="man/figures/README-example-2.png" width="100%" />

``` r
## Based on the TSA plots, an Arima(p,d,q)x(P,D,Q) model can be estimated
MODELS=ARIMAbuilder(TSdata$TSmatrix[2,2,],2,1,3,1,1,2,12)
#> [1] 0 1 0 0 1 0
#> [1] 0 1 0 0 1 1
#> [1] 0 1 0 0 1 2
#> [1] 0 1 0 1 1 0
#> [1] 0 1 0 1 1 1
#> [1] 0 1 0 1 1 2
#> [1] 0 1 1 0 1 0
#> [1] 0 1 1 0 1 1
#> [1] 0 1 1 0 1 2
#> [1] 0 1 1 1 1 0
#> [1] 0 1 1 1 1 1
#> Warning in log(s2): NaNs produced
#> Warning in log(s2): NaNs produced

#> Warning in log(s2): NaNs produced
#> [1] 0 1 1 1 1 2
#> [1] 0 1 2 0 1 0
#> [1] 0 1 2 0 1 1
#> [1] 0 1 2 0 1 2
#> [1] 0 1 2 1 1 0
#> [1] 0 1 2 1 1 1
#> Warning in log(s2): NaNs produced

#> Warning in log(s2): NaNs produced

#> Warning in log(s2): NaNs produced
#> [1] 0 1 2 1 1 2
#> [1] 0 1 3 0 1 0
#> [1] 0 1 3 0 1 1
#> [1] 0 1 3 0 1 2
#> [1] 0 1 3 1 1 0
#> [1] 0 1 3 1 1 1
#> [1] 0 1 3 1 1 2
#> [1] 1 1 0 0 1 0
#> [1] 1 1 0 0 1 1
#> [1] 1 1 0 0 1 2
#> [1] 1 1 0 1 1 0
#> [1] 1 1 0 1 1 1
#> [1] 1 1 0 1 1 2
#> [1] 1 1 1 0 1 0
#> [1] 1 1 1 0 1 1
#> [1] 1 1 1 0 1 2
#> [1] 1 1 1 1 1 0
#> [1] 1 1 1 1 1 1
#> [1] 1 1 1 1 1 2
#> [1] 1 1 2 0 1 0
#> [1] 1 1 2 0 1 1
#> [1] 1 1 2 0 1 2
#> [1] 1 1 2 1 1 0
#> [1] 1 1 2 1 1 1
#> [1] 1 1 2 1 1 2
#> [1] 1 1 3 0 1 0
#> [1] 1 1 3 0 1 1
#> [1] 1 1 3 0 1 2
#> [1] 1 1 3 1 1 0
#> [1] 1 1 3 1 1 1
#> [1] 1 1 3 1 1 2
#> [1] 2 1 0 0 1 0
#> [1] 2 1 0 0 1 1
#> [1] 2 1 0 0 1 2
#> [1] 2 1 0 1 1 0
#> [1] 2 1 0 1 1 1
#> [1] 2 1 0 1 1 2
#> [1] 2 1 1 0 1 0
#> [1] 2 1 1 0 1 1
#> [1] 2 1 1 0 1 2
#> [1] 2 1 1 1 1 0
#> [1] 2 1 1 1 1 1
#> [1] 2 1 1 1 1 2
#> [1] 2 1 2 0 1 0
#> [1] 2 1 2 0 1 1
#> [1] 2 1 2 0 1 2
#> [1] 2 1 2 1 1 0
#> [1] 2 1 2 1 1 1
#> [1] 2 1 2 1 1 2
#> [1] 2 1 3 0 1 0
#> [1] 2 1 3 0 1 1
#> [1] 2 1 3 0 1 2
#> [1] 2 1 3 1 1 0
#> [1] 2 1 3 1 1 1
#> [1] 2 1 3 1 1 2
print(MODELS)
#> $`#1(p,q,P,Q)`
#>      dim1 dim2 dim3 dim4
#> [1,]    1    1    1    2
#> 
#> $AIC1
#> [1] -1732.342
#> 
#> $`#2(p,q,P,Q)`
#>      dim1 dim2 dim3 dim4
#> [1,]    2    1    1    2
#> 
#> $AIC2
#> [1] -1727.312
#> 
#> $`#3(p,q,P,Q)`
#>      dim1 dim2 dim3 dim4
#> [1,]    1    2    1    2
#> 
#> $AIC3
#> [1] -1727.245
#> 
#> $`#4(p,q,P,Q)`
#>      dim1 dim2 dim3 dim4
#> [1,]    0    2    1    2
#> 
#> $AIC4
#> [1] -1727.18
#> 
#> $`#5(p,q,P,Q)`
#>      dim1 dim2 dim3 dim4
#> [1,]    1    1    1    1
#> 
#> $AIC5
#> [1] -1726.777
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
