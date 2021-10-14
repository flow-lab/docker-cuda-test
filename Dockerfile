FROM nvidia/cuda:11.4.0-devel-ubuntu20.04 as builder

RUN apt-get update \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p app

WORKDIR ./app

ADD Dockerfile main.cu ./

RUN nvcc main.cu -o main

CMD ["./main"]