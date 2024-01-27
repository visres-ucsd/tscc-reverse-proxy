#!/bin/bash

# change dir to RPS directory so that all bash scripts can be loaded
dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
cd $dir
echo ${pwd}

# Feel free to modify this line fit your setup
# Do not remove `> jupyter.log` as this is where you will find the RPS link.
./interactive_jupyterlab -d /tscc/projects/ps-visres-group/r2gonzalez -P 8890 > jupyter.log