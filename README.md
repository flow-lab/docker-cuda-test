# docker-cuda-test

This is a test CUDA application that is build and run in docker. Use it for testing the CUDA docker setup.


```shell
# show driver details
docker run -it --gpus all flowlab/docker-cuda-test:0.3.0 nvidia-smi

# run with 0.3.0 tag to test block sizes
docker run -it --gpus all flowlab/docker-cuda-test:0.3.0
```