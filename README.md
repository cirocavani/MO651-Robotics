# Robotics

Project related to the Robotics Course taught at Unicamp.

https://www.ic.unicamp.br/~esther/teaching/2019s2/mo651/index.html


## Setup

Two types of installation:

* **Local**: assumes a Linux 64 bits system, install on a folder isolated from the rest of the system.
* **Docker**: uses an Ubuntu 18.04 LTS image to install the project  with all dependencies.

...

Local install:

```sh
setup/install.sh
```

Docker install:

```sh
docker/bundle/build.sh
```


## Jupyter

On a Local setup:

```sh
bin/jupyter-lab
# hold the terminal
# Ctrl-C terminate Jupyter Lab.
```

On a Docker setup:

```sh
docker/bundle/run.sh
# Return after the container is started
```

To terminate the Docker container:

```sh
docker/bundle/shutdown.sh
```

In both cases, open `http://localhost:8888/` in the web browser to access Jupyter Lab.
