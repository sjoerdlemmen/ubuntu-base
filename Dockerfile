# vim: set filetype=dockerfile
FROM ubuntu:16.04
MAINTAINER Sjoerd Lemmen <slemmen@gmail.com>

# Add the trusty-proposed repo
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial-proposed restricted main multiverse universe" >> /etc/apt/sources.list

# enable multiverse on all repos
RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

# Install some utilities
RUN apt-get --quiet update && \
    apt-get install -qy vim \
                        bzip2 \
                        tar \
                        python \
                        python-pip \
                        python-software-properties \
                        curl \
                        wget \
                        apt-transport-https \
                        ca-certificates \
                        supervisor \
                        openssl \
                        software-properties-common \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && apt-get purge -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD files/vimrc /root/.vimrc
RUN chown root:root /root/.vimrc
RUN mkdir -p /data
