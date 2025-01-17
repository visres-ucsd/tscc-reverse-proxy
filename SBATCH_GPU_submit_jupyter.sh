#!/bin/bash
# 
# Wrapper for running a GPU job performed using an Python script. 
#
# This script should be passed to qsub and additional arguments (including
# the required python script) should be passed using the -F option of qsub.
#
# Usage:
#
# sbatch SBATCH_submit_jupyter.sh
#
# Job submission options:
#
#SBATCH -J jupyter          #Optional, short for --job-name
#SBATCH -N 1                #Number of nodes
#SBATCH -n 4                #Number of tasks per node
#SBATCH -p a40              #Partition name
#SBATCH -G 1
#SBATCH -t 04:00:00         #Short for --time walltime limit
#SBATCH -o slurm-%j.err-%N  #standard output name
#SBATCH -e slurm-%j.err-%N  #Optional, standard error name
#SBATCH --mem 24G           #Memory allocation
#SBATCH -q hca-ddp364       #QOS name
#SBATCH -A ddp364           #Allocation name


# Get script, shift to remove from args
# script=$1
# shift

# Use conda env to start jupyter
conda run -n tf-gpu bash /tscc/nfs/home/r2gonzalez/tscc-reverse-proxy/independent_jupyter.sh
