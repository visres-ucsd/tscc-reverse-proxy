#!/bin/bash
# 
# Wrapper for running a GPU job performed using an Python script. 
#
# This script should be passed to qsub and additional arguments (including
# the required python script) should be passed using the -F option of qsub.
#
# Usage:
#
# qsub runPythonGPU.sh -F "</path/to/python-script.py> [args to python script]"
#
# Job submission options:
#
#SBATCH -J python-gpu       #Optional, short for --job-name
#SBATCH -N 1                #Number of nodes
#SBATCH --tasks-per-node 7 #Number of tasks per node
#SBATCH -G 1
#SBATCH -c 8                #Number of threads per process
#SBATCH -t 00:01:00         #Short for --time walltime limit
#SBATCH -o slurm-%j.err-%N  #standard output name
#SBATCH -e slurm-%j.err-%N  #Optional, standard error name
#SBATCH -p condo            #Partition name
#SBATCH -q condo            #QOS name
#SBATCH -A <allocation>     #Allocation name


# Get script, shift to remove from args
script=$1
shift

# Run R script, passing through the arguments
conda run -n tf-gpu bash /home/r2gonzalez/tscc-reverse-proxy/independent_jupyter.sh