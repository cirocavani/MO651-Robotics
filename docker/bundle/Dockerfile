FROM ubuntu:18.04

SHELL ["/bin/sh", "-lxc"]

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        --no-install-recommends \
        build-essential \
        sudo \
        tar \
        xz-utils \
        bzip2 \
        curl \
        ca-certificates \
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

COPY --chown=robot downloads downloads
COPY --chown=robot setup setup
COPY --chown=robot conf conf
COPY --chown=robot bin bin
COPY --chown=robot setup/jupyter_notebook_config.py /home/robot/.jupyter/

RUN ~/setup/install-conda.sh
RUN ~/setup/install-jupyter.sh
RUN ~/setup/install-python.sh
RUN ~/setup/install-julia.sh
RUN ~/setup/install-vrep.sh
RUN ~/software/conda/bin/conda clean -y --all
RUN rm -rf downloads setup

EXPOSE 8888
EXPOSE 19997

CMD /home/robot/bin/jupyter-lab
