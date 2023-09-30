# `custom-kali-linux:default` 💀

![Docker Pulls](https://img.shields.io/docker/pulls/raviprakash1907/custom-kali-linux) [![Build and Push to dockerhub](https://github.com/ravi-prakash1907/custom-kali-meta/actions/workflows/dockerhub-image.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-meta/actions/workflows/dockerhub-image.yml)  

`custom-kali-linux:default` is a custom Kali Linux image built with docker, based on the `kali-linux-default` package.  

## Using `custom-kali-linux:default` 💀

The easiest way to use this image is by running the following `docker run` command:

```sh
$ docker run \
    -it \
    --rm \
    --name kali-custom \
    -p 5908:5908 -p 13389:13389 -p 20022:20022 \
    --mount type=bind,src="$(pwd)/kali",target=/home/trustworthy \
    raviprakash1907/custom-kali-linux:default
```

## Default Credentials 🔑

> User: `trustworthy`   
> Password: `trustworthy`  

> User: `root`  
> Password: `toor`  
