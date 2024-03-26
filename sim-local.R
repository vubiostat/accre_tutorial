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
source("simulation.R")

  #############################################################################
 ##
## For execution on local desktop/laptop
library(parallel)       # Note: library is called parallel, when it's
                        # really batch array
 
# Change the input 
mclapply(12:13,         # <=== MODIFY HERE Batch Array numbers to run locally
         mc.cores=8,    # <=== Number of local cpus use to batch
         function(x)
         {
           set.seed(x)
           simulation(x)
         }
)

