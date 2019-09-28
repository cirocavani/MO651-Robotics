# Robotics

Project related to the Robotics Course taught at Unicamp.

https://www.ic.unicamp.br/~esther/teaching/2019s2/mo651/index.html


## Setup

Supports install direct on the system or on a docker container.

For a **direct install**, the setup is done in a folder isolated from the rest of the system (assumes a Linux 64 bits).

For a **docker install**, the setup is done in an Ubuntu 18.04 LTS image provisioned with the same scripts of **direct install**.

Development setup for VS Code is available in **direct install**.

Running V-REP in a Docker container is also supported in **direct install**.


### Direct Install

[`install.sh`](setup/install.sh)

```sh
setup/install.sh
```

Jupyter:

```sh
bin/jupyter-lab
# hold the terminal
# Ctrl-C terminate Jupyter Lab.
```

Open [`http://localhost:8888/`](http://localhost:8888/) in the web browser to access Jupyter Lab.


**Running V-REP with Docker**

[ [README](docker/vrep/README.md) ]

In case the host system is not Ubuntu 18.04 or there are missing dependencies, it is possible to run V-REP on a Docker container provided at `docker` folder.

```sh
docker/vrep/build.sh
docker/vrep/run.sh
```

V-REP window opens as a normal GUI Application on Host.


### Docker Install

[ [README](docker/bundle/README.md) ]

Install:

```sh
docker/bundle/build.sh
```

Starting the container (runs Jupyter Lab):

```sh
docker/bundle/run.sh
# Return after the container is started
```

Terminating the container:

```sh
docker/bundle/shutdown.sh
```

Open [`http://localhost:8888/`](http://localhost:8888/) in the web browser to access Jupyter Lab.


### Development

Assuming **direct install**.

Update with VS Code settings and required Python packages.

[`setup-dev.sh`](setup/setup-dev.sh)

```sh
setup/setup-dev.sh
```


## Content

[**`bin`**](bin/)

Commands to start applications:

* `bin/jupyter-lab`: start Jupyter Lab server (`workspace` as work directory)
* `bin/julia-repl`: start Julia REPL prompt (`PROJECT_HOME` as work directory)
* `bin/python-repl`: start Python REPL prompt (`PROJECT_HOME` as work directory, using Jupyter Console running `rebotics_python` kernel)
* `bin/run-notebooks`: execute and update each `.ipynb` from `workspace` non-interactively.


[**`conf`**](conf/)

Project configuration.

* [`env.sh`](conf/env.sh): define environment variables of the project.


[**`workspace`**](workspace/)

Home of experimental code, drafts and examples, normally as Jupyter notebooks.


[**`setup`**](setup/) ([README](setup/README.md))

Scrips to automate initial installation of Conda, Python, Julia and V-REP on a Linux host.


[**`docker`**](docker/) ([README](docker/README.md))

Containerized project infrastructure (containers encapsulating application and dependencies).

Supports a `robotics` container with all project and a `vrep` container to run V-REP on any Linux.


[**`vrep-remote-api-python`**](vrep-remote-api-python/) ([README](vrep-remote-api-python/README.md))

This project contains the Python bindings for C library of V-REP Remote API.


[**`vrep-robot-python`**](vrep-robot-python/) ([README](vrep-robot-python/README.md))

This project contains the basic structure to control a Pioneer P3DX robot on the V-REP simulator and read its sensors.

