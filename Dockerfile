FROM debian:bullseye

RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y iproute2 inetutils-ping