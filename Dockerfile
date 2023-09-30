###########################################
###       Latest Version - DEFAULT      ###
###########################################


# while setting up first time. 
# FROM raviprakash1907/custom-kali-linux:default-v0.1 

FROM raviprakash1907/custom-kali-linux:default

# author
LABEL Ravi Prakash <raviprakash.cf>
LABEL org.opencontainers.image.source=https://github.com/ravi-prakash1907/custom-kali-linux
LABEL org.opencontainers.image.description="A collection of customized images of Kali Linux."
LABEL org.opencontainers.image.licenses=GPL

# going root for installation
USER root
# root's password  (default password is 'toor')
RUN echo "root:toor" | chpasswd

# environments
ENV PATH $PATH

## updating
RUN apt-get update

# get golang
RUN mkdir /tmp/downloads
RUN cd /tmp/downloads \
  && wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz \
  && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz \
  && export PATH=$PATH:/usr/local/go/bin/ \
  && rm -rf /tmp/downloads
RUN  /usr/local/go/bin/go version

## installing basics
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y nano \
  python2 \
  pip \
  strace \
  ltrace \
  elfutils \
  patchelf \
  aircrack-ng \
  dmitry \
  binwalk \
  && rm -rf /var/lib/apt/lists/*

## installing security +
RUN apt-get update \
  && apt-get install -y gobuster \
  xxd \
  eyewitness \
  rainbowcrack \
  && rm -rf /var/lib/apt/lists/*

# env variables
ENV PATH /usr/local/go/bin/:$PATH

# change user
USER trustworthy
# set working directory
WORKDIR /home/trustworthy
# start
RUN /bin/sh