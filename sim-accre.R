  #############################################################################
 ##
## ACCRE specific configuration here
##
## This area is for things that require ACCRE specific configuration
## 
##
## An example when C++ was required and needed specical compile flags
Sys.setenv(PKG_LIBS="-L${MKLROOT}/lib/intel64 -lmkl_rt -lpthread -lm -ldl")
Sys.setenv(PKG_CXXFLAGS="-I${MKLROOT}/include")

  #############################################################################
 ##
## Load simulation file that contains `simulation <- function(array_task_id)`
source("simulation.R") 

  #############################################################################
 ##
## ACCRE batch run

# Pull the ARRAY number from the command line arguments provided by slurm
args <- commandArgs(trailingOnly=TRUE)
array_task_id    <- as.numeric(args[1])

# A simple output statement to the logs
cat("Batch", array_task_id, "\n")

# Set the random seed using the array number
# This could be moved inside the simulation function
# But is included here for pedantic purposes as
# this is _key_ to repoducibility. 
set.seed(array_task_id) 

# Now run the simulation and provide the array number
simulation(array_task_id)
