# Ubuntu for V-REP

Runs V-REP like a normal GUI Application inside a Docker container.

Assumes X running on the Host, same user of Docker container (uid=1000).

How to use:

```sh
./build.sh
./run.sh
./shutdown.sh
# Closing V-REP also stop the container
```

After `run.sh`, V-REP window opens as a normal GUI Application on Host.
