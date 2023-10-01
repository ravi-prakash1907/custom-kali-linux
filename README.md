# `custom-kali-linux:meta-lite` 💀

![Docker Pulls](https://img.shields.io/docker/pulls/raviprakash1907/custom-kali-linux) [![Build and Push to dockerhub](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta-lite.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-linux/actions/workflows/dockerhub-image-meta-lite.yml)  

`custom-kali-linux:meta-lite` is a custom Kali Linux image built with docker with the `kali-linux-default` package. The base image used to build this version is `custom-kali-linux:default`. This Image consists of some additional utilities for XR development. 

## Using `custom-kali-linux:meta-lite` 💀

The easiest way to use this image is by running the following `docker run` command:

```sh
$ docker run \
    -it \
    --rm \
    --name kali-custom \
    -p 5908:5908 -p 13389:13389 -p 20022:20022 \
    --mount type=bind,src="$(pwd)/kali",target=/home/trustworthy \
    raviprakash1907/custom-kali-linux:meta-lite
```

## Default Credentials 🔑

> User: `trustworthy`   
> Password: `trustworthy`  

> User: `root`  
> Password: `toor`  
