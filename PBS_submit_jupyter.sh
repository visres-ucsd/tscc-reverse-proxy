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
# Specify subimssion queue / account
#PBS -q home
#PBS -A visres-group
# Specify job name
#PBS -N python-gpu
# Job needs 1 node, 4 (out of 16) cores to get 1 GPU
#PBS -l nodes=1:ppn=4:gpua40
# Default walltime of 4 days
#PBS -l walltime=96:00:00
# Don't send any emails about the job
#PBS -m n
#

# Set some required paths
# export LD_LIBRARY_PATH=/opt/gnu/gcc/lib64/:$LD_LIBRARY_PATH
# PYTHON_EXE=/home/r2gonzalez/miniconda3/envs/dl4cv_p39/bin/python

# Get script, shift to remove from args
script=$1
shift

# Use conda env to start jupyter
conda run -n tf-gpu-alt bash /home/r2gonzalez/tscc-reverse-proxy/independent_jupyter.sh
