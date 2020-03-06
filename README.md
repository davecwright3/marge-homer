# What is `marge-homer` ?
A docker image built for https://github.com/exosports/HOMER and https://github.com/exosports/MARGE.

# How do I run it?
`marge-homer` is intended to be run on a machine with NVIDIA GPUs with their proper drivers installed. If this is not the case, you may still run this image without using your GPU. The following command will suffice if you fulfill the requirements. Otherwise, omit the `--gpus all` from the command.
```
docker run -it --gpus all davecwright3/marge-homer
```
This will drop you into a shell session within a `marge-homer` container. We recommend, however, that you modify `docker run` with the following arguments to make usage easier.

```
docker run -it --gpus all --mount type=bind,source=$HOME,target=$HOME --user $(id -u):$(id -g) davecwright3/marge-homer
```
The above command will 
1. Enable GPUs
2. Mount your home directory inside the container
3. Start the container with your UID and GID (The shell prompt will not reflect this, this is to be expected)

# How to run MARGE and HOMER
MARGE.py and HOMER.py are added to $PATH in this image, so once in a container you can run `MARGE.py <args>` or `HOMER.py <args>`. MARGE and HOMER are cloned from the above mentioned github repos to `/code/marge` and `/code/homer` inside of the container. The required conda environment will be activated by default.
