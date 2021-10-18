# docker-cuda-test

This is a test CUDA application that is build and run in docker. Use it for testing the CUDA docker setup.


```shell
# before running docker get latest tag
TAG=$(git describe --tags --abbrev=0)

# show driver details
docker run -it --gpus all flowlab/docker-cuda-test:${TAG} nvidia-smi

# run
docker run -it --gpus all flowlab/docker-cuda-test:${TAG}

# Example nvidia-smi
docker run -it --gpus all flowlab/docker-cuda-test:0.9.0 nvidia-smi

# Example code run
docker run -it --gpus all flowlab/docker-cuda-test:0.9.0
```
