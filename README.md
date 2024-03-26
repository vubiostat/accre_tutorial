# Accre Tutorial
A short tutorial on using [ACCRE](https://www.vanderbilt.edu/accre/) aimed at Biostatistician needs. 

## Parallel Versus Batch

Parallel computing is required to numerically evaluate large [systolic arrays](https://en.wikipedia.org/wiki/Systolic_array).
These kinds of problems are common in solving large partial differential
equations, ultra high dimensional spectral analysis, and nuclear simulations.
ACCRE provides resources for solving such problems, and it involves having a
high number of CPUs and nodes with high speed communication buses allocated
all at once. A problem of this type quickly burns through fair share and can
leave ones shared group account depleted with just a couple requests.

Biostatistics problems typically consist of simulations involving multiple
runs that are independent and do not communicate or share information with
other runs. These types of problems are known as batch array jobs. The
relevant [slurm](https://slurm.schedmd.com/overview.html) parameter is `array`. 
This runs multiple jobs independently and fits them in as needed, likely 
using less resources than a parallel job request. A batch array should
look something like this:

```
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-250
```

It requests a single cpu 250 times independently, and doesn't ask for
any special parallel or systolic needs. Jobs will get queued faster
and turn around will generally be quicker. 

## Goals

What is required is some _simple_ scripts that allow one to quickly identify
a failed job and to reproduce that behavior locally. For example, batch
array number 123 might fail, and in a local development environment one
would wish to reproduce that exact failure to determine what set of 
conditions led to that failure. These scripts should also require
no modification running locally or on ACCRE.

