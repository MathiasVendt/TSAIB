#' @import TMB

.onLoad <- function(libname,pkgname){
  cat("Loading compiled code...\n")
  library.dynam("TSAIB", pkgname, libname)
}
