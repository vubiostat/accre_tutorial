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
nCores <- 8             # <=== Number of local cpus use to batch
# Windows can only use 1 core
fail <- try(mclapply(1, length, mc.cores = nCores), TRUE)
if(grepl('Windows', fail)) nCores <- 1

# Change the input 
mclapply(12:13,         # <=== MODIFY HERE Batch Array numbers to run locally
         mc.cores = nCores,    
         function(x)
         {
           set.seed(x)
           tryCatch(simulation(x), error = function(e)
           {
             print(sprintf('failure in iteration %d', x))
             print(e)
             NULL
           })
         }
)
