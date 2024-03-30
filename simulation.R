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

# Silly example, DELETE for doing real work. Prefered to load from
# external R file for a real project
add_it_up <- function(design)
{
  rnorm(1e6)  # Chew up some CPU for demonstration

  rowSums(design)
}

  ###########################################################################
 ##
## Create directories if they don't exist
if(!file.exists("output")) dir.create("output")
if(!file.exists("status")) dir.create("status")


  ###########################################################################
 ##
##
simulation <- function(array_task_id)
{
  # For educational purposes, array job 12 will crash
  # DELETE THIS, of course to do real work
  if(array_task_id == 12) stop("SOMETHING WENT HORRIBLY WRONG!")

  # Get the simulation design for this batch array
  design <- simulation_design[array_task_id,]

  # Add it up (this would be the actual simulation call for ones research)
  result <- add_it_up(design)  # <==== MODIFY HERE to call real work function

  # Save the result
  save(result, file=file.path(
    "output",
    paste0("result-",
           formatC(array_task_id, width=4, format='d', flag='0'),
           ".Rdata")
    )
  )
}
