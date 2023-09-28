###########################################
###      Latest Version - META       ###
###########################################

# pulling image of base-custom-kali-linux
FROM raviprakash1907/custom-kali-linux:meta

# author
LABEL Ravi Prakash <raviprakash.cf>
LABEL org.opencontainers.image.source=https://github.com/ravi-prakash1907/custom-kali-meta
LABEL org.opencontainers.image.description="A collection of customized images of Kali Linux."
LABEL org.opencontainers.image.licenses=GPL

# going root for installation
USER root

## updating
RUN apt-get update

# start
RUN service apache2 start
RUN /bin/sh