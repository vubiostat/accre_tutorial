  ###########################################################################
 ##
## A consistent isomorphic simulation design map to batch array number
##
## This maps the batch array number to specific parameters for simulation.
## 
## Note, if one wishes to preserve prior runs, the existing design
## rows that were used cannot be changed. 
## This is for the end user to manage, and should always be repeatible.
  
## Advanced note: if one is using this to provide a series of parameter
## draws to explore a space for a final estimate under uncertainty, 
## consider using a Halton sequence instead of random draws. It converges
## on estimates with 3-4x greater efficiency. A Halton (an improved Sobol)
## sequence is a low discrepancy sequence similar to a Latin hypercube, but 
## unlike the Latin hypercube one can continue to draw more values
## if convergence was not reached. The package `randtoolbox`
## provides Halton sequences. The Halton is a n-dimensional low
## discrepancy pseudo random number in the space [0,1]^n. Use
## quantile functions to turn into draws inside a distribution.

simulation_design <- expand.grid(
  m = 1:5,
  n = 1:2,
  o = 1:2
)
