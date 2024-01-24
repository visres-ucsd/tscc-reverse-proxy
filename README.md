## Jupyter Reverse Proxy Service for TSCC

This project was forked from [sdsc-hpc-training-org/reverse-proxy](https://github.com/sdsc-hpc-training-org/reverse-proxy). See this repo for further details.

Though the previous fork should support it, attempts at getting the scripts to run on TSCC nodes were unsucessful. This fork has been modified to create a working solution for running jupyter on TSCC nodes using SDSC's reverse proxy service.

## Usage

1. Git clone this repo. `git clone https://github.com/visres-ucsd/tscc-reverse-proxy.git`
2. Start an interactive on TSCC. For example:
    - Requesting 32GB of RAM, and a 1 hour walltime on a condo node: `srun -N 1 -n 4 --mem 32G -t 01:00:00 -p condo -q condo -A ddp364 --pty /bin/bash`
    - Requesting a GPU, 32GB of RAM, and a 1 hour walltime on a hotel node: `srun -N 1 -n 4 -G 1 --mem 32G -t 01:00:00 -p hotel-gpu -q hotel-gpu -A ddp364 --pty /bin/bash`
3. Once the interactive session is active, be sure to activate an environment that has jupyterlab installed (and potentially any other required libraries).
4. Run the launch script `./interactive_jupyterlab -d jupyter_root_dir`. Replace `jupyter_root_dir` with the path to the folder you would like jupyter to be rooted at (Defaults to the user's home directory). The notebook can be found by visiting the link displayed using a web browser. The link will follow a pattern similar to `https://[reverse_proxy_key].tscc-user-content.sdsc.edu?token=...`.

## Notes: 
- `interactive_jupyterlab` will accept the same arguments as `start-jupyter`, but they will be ignored expect for `-d`.
- It is NOT recommended to use `start-jupyter` as attempts to use this script were unsucessful. It has been left for reference.
- The server is hard coded to run on port 8964. If this port has been taken by another running process, this will not work. If the process is another jupyter instance, it can be stopped using `jupyter server stop 8964`. However there may be additional "zombie" servers running. They can be listed using `jupyter server list`.
- If prompted for a jupyter token/password, you may be able to find it by viewing `jupyterlab.log`. This can be done with `cat jupyterlab.log`. Search for a line similar to below. The token should be the text following `?token=`. Copy and paste into the token prompt.
```
Jupyter Server is running at:
    http://tscc-gpu.local:8964/lab?token=...
```