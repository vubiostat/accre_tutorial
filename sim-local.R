  #############################################################################
 ##
## Any local development requirements
##
## For example, this was required for C/C++ on MacOS
Sys.setenv(PKG_LIBS="-llapack")


  #############################################################################
 ##
## A single line source that loads ones simulation code.
##
## Must export `simulation <- function(x)`
source("add_it_up.R")

  #############################################################################
 ##
## For execution on local desktop/laptop
library(parallel)
 
mclapply(123:124, mc.cores=8, function(x)
{
  set.seed(x)
  simulation(x)
})

