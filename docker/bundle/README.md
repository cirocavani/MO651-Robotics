# Project Bundle

Install all project inside a Docker container.

Runs V-REP like a normal GUI Application inside a Docker container.

Assumes X running on the Host, same user of Docker container (uid=1000).

How to use:

```sh
./build.sh
./run.sh
./shutdown.sh
```

After `run.sh`, Jupyter Lab is running at [http://127.0.0.1:8888](http://127.0.0.1:8888).

Starting V-Rep from a Terminal in Jupyter opens a window as normal GUI Application on Host.
