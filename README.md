# `custom-kali-linux` 💀

![Docker Pulls](https://img.shields.io/docker/pulls/raviprakash1907/custom-kali-linux)  
[![raviprakash1907/custom-kali-linux:latest](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image.yml) [![raviprakash1907/custom-kali-linux:default](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-default.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-default.yml) [![raviprakash1907/custom-kali-linux:meta](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta.yml) [![raviprakash1907/custom-kali-linux:meta-lite](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta-lite.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta-lite.yml)  

`custom-kali-linux` is a collection of customized Kali Linux images for various use cases. All these images are available on my [docker-hub repo](https://hub.docker.com/r/raviprakash1907/custom-kali-linux). These images are based on [`kalilinux/kali-rolling`](https://hub.docker.com/r/kalilinux/kali-rolling), but they differ in terms of the packages used during the build process. There are two main packages used:

1. `kali-desktop-core` 🖥️
2. `kali-linux-default` 🛡️

For more information about the different Kali Linux packages, please visit the [official metapackages page](https://www.kali.org/docs/general-use/metapackages/).

### Tags 🏷️

All images in this repository provide access to the server via **RDP** (port 13389) 🖥️, **VNC** (port 5908) 🖥️, and **SSH** (port 20022) 🔐. The repository offers four main tags:

1. **`core`:** These images are built with the `kali-linux-core` package and have minimal dependencies (related to text editing and version control). They provide lightweight instances and correspond to the Long Term Support (LTS) version of `custom-kali-linux`. Updates are less frequent. 🌱

2. **`default`:** This image is built with the `kali-linux-default` package and includes additional CLI tools for cybersecurity. It is also tagged as `latest`. 🚀

3. **`meta`:** Built from the base image `raviprakash1907/custom-kali-linux:default`, this image is designed for metaverse and extended reality (XR) development and is expected to receive frequent updates. 🌟

4. **`meta-lite`:** Built upon `raviprakash1907/custom-kali-linux:core`, this image is lightweight, offering minimal cybersecurity tools. However, it's also tailored for metaverse and extended reality (XR) development, receiving frequent updates like `custom-kali-linux:meta`. ✨

## Using `custom-kali-linux` 💀

The easiest way to use this image is by running the following `docker run` command:

```sh
$ docker run -it --rm raviprakash1907/custom-kali-linux:<tag>
```

This command provides minimal access to the container via the terminal. To access it via RDP, VNC, and SSH clients, use this command instead:

```sh
$ docker run -it --rm -p 5908:5908 -p 13389:13389 -p 20022:20022 raviprakash1907/custom-kali-linux:<tag>
```

To bind volumes when using the image, you can execute the following command:

```sh
$ docker run \
    -it \
    --rm \
    --name kali-custom \
    -p 5908:5908 -p 13389:13389 -p 20022:20022 \
    --mount type=bind,src="$(pwd)/kali",target=/home/trustworthy \
    raviprakash1907/custom-kali-linux:<tag>
```

## Default Credentials 🔑

> User: `trustworthy`   
> Password: `trustworthy`  

> User: `root`  
> Password: `toor`  

---

## Using with `docker-compose` 🐳

Here, we provide a sample `Dockerfile` used to build the image:

```Dockerfile
FROM raviprakash1907/custom-kali-linux:<tag>

# Switching to root for installation
USER root

## Exposing additional ports for dynamically binding services while testing (beyond port 49151)
EXPOSE 55510

# Start
RUN /bin/sh
```

And a `docker-compose.yml` file:

```yaml
version: "3.0"

services:
  kali:
    build: .
    container_name: custom-kali-meta
    ports: 
      - 13389:13389
      - 20022:20022
      - 5908:5908
      - 55510:55510
    volumes:
      - ./kali/:/home/trustworthy
    command: /bin/sh
  meta:
    image: raviprakash1907/custom-kali-linux:meta
```

You can build and use the container with a single command:

```sh
$ docker-compose up
```
