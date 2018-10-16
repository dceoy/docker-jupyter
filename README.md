docker-jupyter
==============

Dockerfile for Jupyter notebook based on the latest Python image

Docker image
------------

Pull the image from [Docker Hub](https://hub.docker.com/r/dceoy/jupyter/).

```sh
$ docker pull dceoy/jupyter
```

Usage
-----

Run a server

```sh
$ docker container run --rm -p=8888:8888 -v=${pwd}:/nb -w=/nb dceoy/jupyter
```

Run a server with docker-compose

```sh
$ docker-compose -f /path/to/docker-jupyter/docker-compose.yml up
```
