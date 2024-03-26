#!/bin/bash

#SBATCH --mail-user=your@email.adr
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --mem=500M
#SBATCH --output=status/job%a.out
#SBATCH --array=1-20

#   #SBATCH --constrain=haswell   # This was required for C/C++ R package dependencies (FIXME: Might not be needed)

# Create directories if they don't exist
[[ -d status ]] || mkdir status
[[ -d output ]] || mkdir output

# Load require modules to run on ACCRE
module purge
module GCC/6.4.0-2.28 
module OpenMPI/2.1.1
module Intel/2017.4.196
module IntelMPI/2017.3.196
module load R/3.4.3

Rscript --no-save sim-accre.R ${SLURM_ARRAY_TASK_ID}

