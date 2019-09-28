# Setup

Scrips to automate initial installation of Conda, Python, Julia and V-REP on a Linux host.


## Install

Install Python, Julia, Jupyter and V-REP on `PROJECT_HOME/software`  (assumes a Linux 64 bits).

[`install.sh`](install.sh)

[`env.sh`](../conf/env.sh)

```sh
./install.sh
```


## Development

Update with VS Code settings and required Python packages.

[`setup-dev.sh`](setup-dev.sh)

```sh
./setup-dev.sh
```


## Content

[**`install.sh`**](install.sh)

Download dependencies and install all programs (Python, Julia, Jupyter, V-REP).


[**`install-conda.sh`**](install-conda.sh)

Install Conda package manager with Python 3.7+.


[**`install-jupyter.sh`**](install-jupyter.sh), [`environment-jupyter.yaml`](environment-jupyter.yaml)

Install Conda Environment `jupyter` with Jupyter Lab from channel `conda-force` (latest versions).


[**`install-python.sh`**](install-python.sh), [`environment-python.yaml`](environment-python.yaml)

Install Conda Environment `python` with packages from channel `anaconda` (stable versions). Also add a Jupyter kernel `robotics_python` to be used on Notebooks and REPL.


[**`install-julia.sh`**](install-julia.sh), [`setup.jl`](setup.jl)

Install Julia with data analysis packages (latest versions).


[**`install-vrep.sh`**](install-vrep.sh)

Install V-REP.


[**`downloads.sh`**](downloads.sh), [`packages.sh`](packages.sh), [`CHECKSUM.MD5`](CHECKSUM.MD5)

Download dependencies.


[**`setup-dev.sh`**](setup-dev.sh)

Add VS Code configuration (settings and packages to `python` environment).
