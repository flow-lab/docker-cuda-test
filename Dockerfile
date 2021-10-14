FROM nvidia/cuda:11.4.0-devel-ubuntu20.04 as builder

RUN apt-get update \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p app

WORKDIR ./app

ADD Dockerfile main.cu ./

RUN nvcc main.cu -o main

FROM nvidia/cuda:11.4.2-base-ubuntu20.04
ARG APP=/usr/src/app

RUN apt-get update \
    && apt-get install -y ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP}

COPY --from=builder /app/main ${APP}/app

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

CMD ["/usr/src/app/app"]