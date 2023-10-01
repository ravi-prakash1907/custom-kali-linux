###########################################
###     Latest Version - META-lite      ###
###########################################

# pulling image of base-custom-kali-linux
FROM raviprakash1907/custom-kali-linux:core

# author
LABEL Ravi Prakash <raviprakash.cf>
LABEL org.opencontainers.image.source=https://github.com/ravi-prakash1907/custom-kali-linux
LABEL org.opencontainers.image.description="A collection of customized images of Kali Linux."
LABEL org.opencontainers.image.licenses=GPL

# going root for installation
USER root
# root's password  (default password is 'toor')
RUN echo "root:toor" | chpasswd

# installing metaverse
RUN apt-get update \
  && apt-get install -y Node.js \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt install -y npm \
  && rm -rf /var/lib/apt/lists/*

## comes pre-exposed from base
# SERVICE:  EXPOSED PORT | default
# SSH_PORT: 20022 | 22
# RDP_PORT: 13389 | 3389
# VNC_PORT: 5908 | 5900

# set working directory
WORKDIR /home/trustworthy

# start
RUN /bin/sh
