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
# by docker
$ docker container run -it --rm -p 8888:8888 -v ${HOME}:/work dceoy/jupyter

# by docker-compose
$ docker-compose up -d
```
