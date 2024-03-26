  ###########################################################################
 ##
## A consistent isomorphic simulation design map to batch array number
##
## This maps the batch array number to specific parameters for simulation.
## 
## Note, if one wishes to preserve prior runs, the existing design
## rows that were used cannot be changed. 
## This is for the end user to manage, and should always be repeatible.

simulation_design <- expand.grid(
  m = 1:5,
  n = 1:2,
  o = 1:2
)
