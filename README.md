# TANG server in a container

This puts https://github.com/latchset/tang into a container for ease in testing

## Build

```
podman build -t quay.io/youruser/tang-server:latest .
podman push quay.io/youruser/tang-server:latest
```

## Run

When you start up the container, it will create a new tang server key (if not
already present), and listen (internally) on port 7500 for new connections.

To run a set of tang servers, each on a different port, you can simply spin up
a set of containers and map different ports:
```
podman run --detach --name tang7500 -p 7500:7500 quay.io/youruser/tang-server:latest
podman run --detach --name tang7501 -p 7501:7500 quay.io/youruser/tang-server:latest
podman run --detach --name tang7502 -p 7502:7500 quay.io/youruser/tang-server:latest
```

Each tang server container will log their key thumbprint in their own stdout,
or you can use `tang-show-keys` or curl as usual:
```
curl http://host.address:7501/adv
```

The tang server key will be created and stored in `/var/db/tang` in the
container image, but if you want to persist the tang key on a persistent
volume, just patch it in at `/var/db/tang` like `-v tangvolume:/var/db/tang`.
