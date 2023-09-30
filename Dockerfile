###########################################
###      Latest Version - CORE       ###
###########################################

# ###########################################################
# Inspired from:    onemarcfifty/kali-linux
# GitHub:  https://github.com/onemarcfifty/kali-linux-docker
# ###########################################################

# Base Image
FROM kalilinux/kali-rolling

# author
LABEL Ravi Prakash <raviprakash.cf>
LABEL org.opencontainers.image.source=https://github.com/ravi-prakash1907/custom-kali-linux
LABEL org.opencontainers.image.description="A collection of customized images of Kali Linux."
LABEL org.opencontainers.image.licenses=GPL

# Arguments
ARG DESKTOP_ENVIRONMENT
ARG REMOTE_ACCESS
ARG KALI_PACKAGE
ARG SSH_PORT
ARG RDP_PORT
ARG VNC_PORT
ARG VNC_DISPLAY
ARG BUILD_ENV
ARG HOSTDIR
ARG CONTAINERDIR
ARG UNAME
ARG UPASS

# init env.
ENV DEBIAN_FRONTEND noninteractive

# root's password  (default password is 'toor')
RUN echo "root:toor" | chpasswd

# #####################################################
# the desktop environment to use (defauly - xfce)
# #####################################################

ENV DESKTOP_ENVIRONMENT=${DESKTOP_ENVIRONMENT:-xfce}
ENV DESKTOP_PKG=kali-desktop-${DESKTOP_ENVIRONMENT}

# #####################################################
# the remote client to use (default - x2go)
# #####################################################

ENV REMOTE_ACCESS=${REMOTE_ACCESS:-x2go}

# #####################################################
# the kali packages to install (default - "default")
# #####################################################

ENV KALI_PACKAGE=${KALI_PACKAGE:-default}
ENV KALI_PKG=kali-linux-${KALI_PACKAGE}

# #####################################################
# install packages that we always want
# #####################################################

RUN apt update -q --fix-missing  
RUN apt upgrade -y
RUN apt -y install --no-install-recommends sudo wget curl dbus-x11 xinit openssh-server ${DESKTOP_PKG}
RUN apt -y install locales
RUN sed -i s/^#\ en_US.UTF-8\ UTF-8/en_US.UTF-8\ UTF-8/ /etc/locale.gen
RUN locale-gen

# #####################################################
# create the start bash shell file
# #####################################################

RUN echo "#!/bin/bash" > /startkali.sh
RUN echo "/etc/init.d/ssh start" >> /startkali.sh
RUN chmod 755 /startkali.sh

# #####################################################
# Install the Kali Packages
# #####################################################

RUN apt -y install --no-install-recommends ${KALI_PKG}

# #####################################################
# create the non-root kali user
# #####################################################

RUN useradd -m -s /bin/bash -G sudo ${UNAME}
RUN echo "${UNAME}:${UPASS}" | chpasswd

# #####################################################
# change the ssh port in /etc/ssh/sshd_config
# from default 22 to 2022 
# Now, 22 will be free inside the container
# #####################################################

RUN echo "Port $SSH_PORT" >>/etc/ssh/sshd_config

# #################################
# disable power manager plugin xfce
# #################################

RUN rm /etc/xdg/autostart/xfce4-power-manager.desktop >/dev/null 2>&1
RUN if [ -e /etc/xdg/xfce4/panel/default.xml ] ; \
    then \
        sed -i s/power/fail/ /etc/xdg/xfce4/panel/default.xml ; \
    fi

# #############################
# install and configure x2go
# x2go uses ssh
# #############################

RUN if [ "xx2go" = "x${REMOTE_ACCESS}" ]  ; \
    then \
        apt -y install --no-install-recommends x2goserver ; \
        echo "/etc/init.d/x2goserver start" >> /startkali.sh ; \
    fi

# #############################
# install and configure xrdp
# #############################
# Automation through /startkali
# for RDP service
# #############################

RUN if [ "xrdp" = "x${REMOTE_ACCESS}" ] ; \
    then \
            apt -y install --no-install-recommends xorg xorgxrdp xrdp ; \
            echo "rm -rf /var/run/xrdp >/dev/null 2>&1" >> /startkali.sh ; \
            echo "/etc/init.d/xrdp start" >> /startkali.sh ; \
            sed -i s/^port=3389/port=${RDP_PORT}/ /etc/xrdp/xrdp.ini ; \
            adduser xrdp ssl-cert ; \
            if [ "xfce" = "${DESKTOP_ENVIRONMENT}" ] ; \
            then \
                echo xfce4-session > /home/${UNAME}/.xsession ; \
                chmod +x /home/${UNAME}/.xsession ; \
            fi ; \
    fi

# ###########################################################
# install and configure tigervnc-standalone-server
# ###########################################################
# Automation through /startkali.in for VNC service
# ###########################################################

RUN if [ "xvnc" = "x${REMOTE_ACCESS}" ] ; \
    then \
        apt -y install --no-install-recommends tigervnc-standalone-server tigervnc-tools; \
        echo "/usr/libexec/tigervncsession-start :${VNC_DISPLAY} " >> /startkali.sh ; \
        echo "echo -e '${UPASS}' | vncpasswd -f >/home/${UNAME}/.vnc/passwd" >> /startkali.sh  ;\
        echo "while true; do sudo -u ${UNAME} vncserver -fg -v ; done" >> /startkali.sh ; \
        echo ":${VNC_DISPLAY}=${UNAME}" >>/etc/tigervnc/vncserver.users ;\
        echo '$localhost = "no";' >>/etc/tigervnc/vncserver-config-mandatory ;\
        echo '$SecurityTypes = "VncAuth";' >>/etc/tigervnc/vncserver-config-mandatory ;\
        mkdir -p /home/${UNAME}/.vnc ;\
        chown ${UNAME}:${UNAME} /home/${UNAME}/.vnc ;\
        touch /home/${UNAME}/.vnc/passwd ;\
        chown ${UNAME}:${UNAME} /home/${UNAME}/.vnc/passwd ;\
        chmod 600 /home/${UNAME}/.vnc/passwd ;\
    fi

# ###########################################################
# Automation through /startkali.in
# Will start 3 services and provide the shell
# ###########################################################

RUN echo "/bin/bash" >> /startkali.sh

# ###############################################################
# exposing the newly configured ports and setting the entrypoint
# ###############################################################

EXPOSE ${SSH_PORT} ${RDP_PORT} ${VNC_PORT}
WORKDIR "/root"
ENTRYPOINT ["/bin/bash"]
CMD ["/startkali.sh"]