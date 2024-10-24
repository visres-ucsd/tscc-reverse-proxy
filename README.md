## Jupyter Reverse Proxy Service for TSCC

This project was forked from [sdsc-hpc-training-org/reverse-proxy](https://github.com/sdsc-hpc-training-org/reverse-proxy). See this repo for further details.

Though the previous fork should support it, attempts at getting the scripts to run on TSCC nodes were unsucessful. This fork has been modified to create a working solution for running jupyter on TSCC nodes using SDSC's reverse proxy service.

## Setup
1. Configure a Python/Conda environment with Jupyter installed.
2. If running through sbatch, be sure to adjust the job parameters in the batch file to fit your requirements and update the jupyter_root_dir in `independent_jupyter.sh`.

## Usage with `srun`

1. Git clone this repo. `git clone https://github.com/visres-ucsd/tscc-reverse-proxy.git`
2. Start an interactive on TSCC. For example:
    - Requesting 32GB of RAM, and a 1 hour walltime on a condo node: `srun -N 1 -n 4 --mem 32G -t 01:00:00 -p condo -q condo -A ddp364 --pty /bin/bash`
    - Requesting a single A40 GPU, and a 1 hour walltime on the HGC condo node: `srun -N 1 -n 4 -t 1:00:00 -p a40 -q hca-ddp364 --gpus 1 -A ddp364 --pty /bin/bash`
3. Once the interactive session is active, be sure to activate an environment that has jupyterlab installed (and potentially any other required libraries).
4. Run the launch script `./interactive_jupyterlab -d jupyter_root_dir`. Replace `jupyter_root_dir` with the path to the folder you would like jupyter to be rooted at (Defaults to the user's home directory). The notebook can be found by visiting the link displayed using a web browser. The link will follow a pattern similar to `https://[reverse_proxy_key].tscc-user-content.sdsc.edu?token=...`.

## Usage with `sbatch`
Using `sbatch` to start the RPS allows you to run a Jupyter instance without it being dependent on your SSH session. It's very much like running using `srun`, but it is wrapped in a batch file that specfies the job parameters. This means starting our Jupyter server can be accomplished in two commands.

1. `sbatch SBATCH_submit_jupyter.sh` -- submits job to the queue
2. `cat jupyter.log` -- once the job has been running for about a minute, use this to print out the link.

## Notes: 
- `interactive_jupyterlab` will accept the same arguments as `start-jupyter`, but they will be ignored expect for `-d`.
- It is NOT recommended to use `start-jupyter` as attempts to use this script were unsucessful. It has been left for reference.
- By defaults, this uses port 8888. You may specify a port number using the `-P` parameter. However, if the port is already in use by another process, the reverse proxy will not map correctly. This may result in "zombie" servers. To list these servers, use `jupyter server list`. They can be stopped using `jupyter server stop <zombie server port number>`
- If you lose track of your token, it can be displayed with `jupyter server list`.
