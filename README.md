# docker-cuda-test

This is a test CUDA application that is build and run in docker. Use it for testing the CUDA docker setup.


```shell
# before running docker get latest tag
TAG=$(git describe --tags --abbrev=0)

# show driver details
docker run -it --gpus all flowlab/docker-cuda-test:${TAG} nvidia-smi

# run with 0.3.0 tag to test block sizes
docker run -it --gpus all flowlab/docker-cuda-test:${TAG}
```