docker-jupyter
==============

Dockerfile for Jupyter notebook

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/jupyter/).

```sh
$ docker pull dceoy/jupyter
```

Run a container

```sh
$ docker container run --rm -p 8888:8888 -v $(pwd):/work -w /work -u $(id -u):$(id -g) dceoy/jupyter
```
