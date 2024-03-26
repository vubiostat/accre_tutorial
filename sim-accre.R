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
## Load ones simulation code here. Should be a single command.
## Should export `simulation <- function(x)` that runs the simulation
## Given an array number
source("simulation.R") 

  #############################################################################
 ##
## ACCRE batch run

# Pull the ARRAY number from the command line arguments provided by slurm
args <- commandArgs(trailingOnly=TRUE)
x    <- as.numeric(args[1])

# A simple output statement to the logs
cat("Batch", x, "\n")

# Set the random seed using the array number
# This could be moved inside the simulation function
# But is included here for pedantic purposes as
# this is _key_ to repoducibility. 
set.seed(x) 

# Now run the simulation and provide the array number
simulation(x)
