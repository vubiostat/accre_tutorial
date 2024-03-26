  ###########################################################################
 ##
## This is the principal / source that starts the simulation
## This can call out and source any number of things. 
##
## Our simulation will focus on adding it's design
## parameters together
##

source('design.R') # Design from a consistent source



  ###########################################################################
 ##
## Load ones actual target simulation here

# source('the_real_work.R') # <==== MODIFY HERE to load the real work

  ###########################################################################
 ##
## Create directories if they don't exist
if(!file.exists("output")) dir.create("output")
if(!file.exists("status")) dir.create("status")


  ###########################################################################
 ##
##
simulation <- function(x)
{
  # For educational purposes, array job 12 will crash
  # Delete this, of course, if one wishes results for batch array 12
  if(x == 12) stop("SOMETHING WENT HORRIBLY WRONG!")

  # Get the simulation design for this batch array
  design <- simulation_design[x,]

  # Add it up (this would be the actual simulation call for ones research)
  result <- rowSums(design)  # <==== MODIFY HERE to call real work function

  # Save the result
  save(result, file.path("output", paste0("result-", formatC(x, width=4, format='d', flag='0'))))
}
