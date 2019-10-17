#!/bin/bash

# Script to generate everything we need for the meeting
# - Creates a clean minimal alpine linux image to use
# - Uses that as a base for the meeting
#
# Assumptions:
# - Your environment has a unix like shell
# - You have a working docker environment
# - There is internet connectivity
#
# The Alpine download URLs are available at:
# https://www.alpinelinux.org/downloads/

WORKAREA="alpine_20191017"
ALPINE_DIST="alpine-minirootfs-3.10.2-x86_64.tar.gz"
ALPINE_VER="3.10"
PACKAGES="apk-tools ca-certificates ssl_client bash coreutils git sqlite"
MYSTERY1="https://github.com/veltman/clmystery.git"
MYSTERY2="https://github.com/NUKnightLab/sql-mysteries.git"

mkdir $WORKAREA
cd $WORKAREA

wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/x86_64/alpine-minirootfs-3.10.2-x86_64.tar.gz
wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/x86_64/alpine-minirootfs-3.10.2-x86_64.tar.gz.sha256

# Build our base alpine inage

cat <<DOCKERFILE > "Dockerfile"
FROM scratch

ADD ${ALPINE_DIST}  /

CMD ["/bin/sh"]
DOCKERFILE

docker build -t ${USER}/alpine:${ALPINE_VER} .

# Now we have an image to build on top of.

cat <<DOCKERFILE > "Dockerfile"
FROM ${USER}/alpine:latest

RUN apk update \
    && apk upgrade \
    && apk add ${PACKAGES} \
    && adduser -D -s /bin/bash -h /home/${USER} ${USER} \
    && cd /home/${USER} \
    && git clone ${MYSTERY1} \
    && git clone ${MYSTERY2}
CMD ["/bin/sh"]
DOCKERFILE

docker build -t ${USER}/alpine-cli .

echo "To use, 'docker run -it ${USER}/alpine-cli /bin/sh'"
