###########################################
###      Latest  Version - latest       ###
###########################################

###########################################
# docker run \
#     -it \
#     --rm \
#     --name custom-kali \
#     -p 20020:20022 -p 13389:13389 -p 5908:5908 \
#     -p 19070:80 -p 19075:443 \
#     kali:<tag>

###########################################
###########################################

# pulling image of base-custom-kali-linux
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

## updating
RUN apt-get update

## comes pre-exposed from base
# SERVICE:  Host:Docker PORT | default (not taken)
# SSH_PORT: 20022:20022 | 22
# RDP_PORT: 13389:13389 | 3389
# VNC_PORT: 5908:5908 | 5900

# REQUESTING TWO ADDITIONAL PORTS for docker specific TCP
# SSH_PORT: 19070:80 | 80
# RDP_PORT: 19075:443 | 443
EXPOSE 20022 13389 5908 19070 19075

# start
RUN /bin/sh
