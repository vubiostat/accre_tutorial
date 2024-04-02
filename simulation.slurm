#!/bin/bash

#SBATCH --mail-user=your@email.adr
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --mem=100M
#SBATCH --output=status/job%a.out
#SBATCH --array=1-20

#   #SBATCH --constrain=haswell   # This was required for C/C++ R package dependencies (FIXME: Might not be needed)

# Create directories if they don't exist
[[ -d status ]] || mkdir status
[[ -d output ]] || mkdir output

# Load require modules to run on ACCRE
module purge
module load GCC/11.3.0
module load OpenMPI/4.1.4
module load R/4.2.1

Rscript --no-save sim-accre.R ${SLURM_ARRAY_TASK_ID}

