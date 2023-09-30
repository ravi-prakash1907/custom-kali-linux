# `custom-kali-linux:core` 💀

![Docker Pulls](https://img.shields.io/docker/pulls/raviprakash1907/custom-kali-linux) [![Build and Push to dockerhub](https://github.com/ravi-prakash1907/custom-kali-meta/actions/workflows/dockerhub-image.yml/badge.svg)](https://github.com/ravi-prakash1907/custom-kali-meta/actions/workflows/dockerhub-image.yml)  

`custom-kali-linux:core` is a custom Kali Linux image built with docker, motivated from [onemarcfifty](https://github.com/onemarcfifty/kali-linux-docker).  

### Steps to create the image: 

1. Update the configurations in [`env`](./env) file. Customize the [`build`](./build) script as needed.  
2. Make the build-script executable (if not already).  
> ```sh
> chmod +x build
> ```  
3. Run the build script to create the image _(based on the predefined configurations)_.  
> ```sh
> ./build
> ```

## Using `custom-kali-linux:core` 💀

The easiest way to use this image is by running the following `docker run` command:

```sh
$ docker run \
    -it \
    --rm \
    --name kali-custom \
    -p 5908:5908 -p 13389:13389 -p 20022:20022 \
    --mount type=bind,src="$(pwd)/kali",target=/home/trustworthy \
    raviprakash1907/custom-kali-linux:core
```

## Default Credentials 🔑

> User: `trustworthy`   
> Password: `trustworthy`  

> User: `root`  
> Password: `toor`  
