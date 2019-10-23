FROM ubuntu:18.04

SHELL ["/bin/sh", "-lxc"]

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        --no-install-recommends \
        sudo \
        tar \
        xz-utils \
        libglib2.0-0 \
        libdbus-1-3 \
        libxkbcommon-x11-0 \
        libsodium23 \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libgl1-mesa-dev && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -G sudo -s /bin/bash robot && \
    passwd -d robot && \
    echo "robot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/robot

USER robot
WORKDIR /home/robot

EXPOSE 19997
EXPOSE 25000

CMD /home/robot/Robotics/software/vrep/vrep.sh
