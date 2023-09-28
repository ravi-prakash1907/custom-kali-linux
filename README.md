# `modern-crypto` 🐳  

![Docker Pulls](https://img.shields.io/docker/pulls/raviprakash1907/modern-crypto) [![Build and Push to dockerhub](https://github.com/ravi-prakash1907/modern-crypto/actions/workflows/dockerhub-image.yml/badge.svg)](https://github.com/ravi-prakash1907/modern-crypto/actions/workflows/dockerhub-image.yml) [![Build and push to github package repository](https://github.com/ravi-prakash1907/modern-crypto/actions/workflows/github-docker-image.yml/badge.svg)](https://github.com/ravi-prakash1907/modern-crypto/actions/workflows/github-docker-image.yml)

A docker image to import library from 'Modern-Cryptography' repo and provide a platform for hands-on cryptography.

### Quick Reference 🚀

Pull this image using the following command:

```bash
$ docker pull raviprakash1907/modern-crypto
```

**Meant for:** A Python environment for problems related to [Modern Cryptography](https://ravi-prakash1907.github.io/Modern-Cryptography/)  
**Raise issues:** Issues can be raised at the GitHub repository of the `modern-crypto` package, i.e., [https://github.com/ravi-prakash1907/modern-crypto/](https://github.com/ravi-prakash1907/modern-crypto/issues)  

### Source of package and `Dockerfile` links:

- GitHub: [`ghcr.io/ravi-prakash1907/modern-crypto`](https://github.com/ravi-prakash1907/modern-crypto/pkgs/container/modern-crypto)  
- Dockerhub: [`raviprakash1907/modern-crypto`](https://hub.docker.com/r/raviprakash1907/modern-crypto)  

_\* Link to the latest `Dockerfile` [here](https://github.com/ravi-prakash1907/modern-crypto/blob/main/Dockerfile)._  

---  

## What is **modern-crypto**? 🔑  

**`modern-crypto`** is an image built on top of the `jupyter/base-notebook` image and provides an environment for performing a range of practical hands-on implementations of _Modern Cryptography_ algorithms as covered at [this website](https://ravi-prakash1907.github.io/Modern-Cryptography/). The image comes with all the essential libraries pre-installed, including the [`modernCrypto` (📥)](https://ravi-prakash1907.github.io/Modern-Cryptography/pkgs/modernCrypto_latest.zip) module.  

This image can be pulled to use in a personalized container environment. To do this, a custom `Dockerfile` can be created. The following is a sample arrangement of the files and directories, along with your custom `Dockerfile`: 

```
    .
    .
    ├── Dockerfile           # Custom Dockerfile built on top of 'modern-crypto'
    │
    ├── docker-compose.yml   # to built & run image as container (optional)
    │
    └── src/                 # contains source code at host (bind with container)
        .
        .
        └── ...              # User's files/codes
```

To access any python notebook (`.ipynb`) or script (`.py`) inside this container, it is advised to store the file in the `src/` directory, which should exist in the current location for easy access.  

### Example with **Dockerfile**:  

_Using the image from **Dockerhub**:_

```docker
# pulling image of modern-crypto
FROM raviprakash1907/modern-crypto:latest

# copying files from host machine 
# to the container environment
COPY ./src/ ./
```

_Using the image from **GitHub**:_

```docker
# pulling image of modern-crypto
FROM ghcr.io/ravi-prakash1907/modern-crypto:latest

# copying files from host machine 
# to the container environment
COPY ./src/ ./
```

Use the following command to build your image using the above `Dockerfile`(s):  

```bash
$ docker build -t test_mcr .
```

## Usage 👨🏻‍💻  

The easiest way to access the `modern-crypto` image is using the `docker run` command:  

```bash
$ docker run \
    -it \
    --rm \
    -p 8888:8888 \
    raviprakash1907/modern-crypto:<tag>
```

Here, the `--rm` flag is set to delete the container as soon as it exists. The `<tag>` should either be replaced with a valid tag of the image, or it can be skipped completely. In case of **no tag**, by default, docker uses the `latest` image.  

### Running with Data Persistence  

**Using `docker run`:**  

> By default, any changes done inside the containers would not be stored in the host machine. To store the changes made in the container persistently, `--mount` can be used. This will let all the changes be saved persistently in the `$(pwd)` i.e., the current directory, even after the container exits.  
>
> ```bash
> $ docker run \
>     -it \
>     --rm \
>     -p 8888:8888 \
>     --mount type=bind,src="$(pwd)",target=/home/jovyan/bkp \
>     raviprakash1907/modern-crypto:<tag>  
> ```  

**Using `docker-compose.yml`:**  

> As mentioned in the introduction section, a `docker-compose.yml` file can also be created to build and run the image. The following is an example of the same:  
>
> ```yml
> version: '3.0'
> 
> services:
>   app:
>     build: .
>     ports: 
>       - 8888:8888
>     volumes:
>       - ./src/:/home/jovyan/bkp
>     restart: unless-stopped
>   mcr:
>     image: raviprakash1907/modern-crypto:latest  
> ```  
>  
> To run the container using docker-compose.yml, use the following command:  
>
> ```bash
> $ docker compose up  
> ```  

---  

## Wanna Countribute? ✨  

You can contribute to this project in various way. Few of them can be:  
1. Pre-installing the existing python libraries like `crypto`  
2. Providing for `Python 2`  
3. Improving the documentation  
