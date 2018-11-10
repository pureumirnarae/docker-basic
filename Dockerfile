FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# encoding, timezone
RUN apt-get update && apt-get install -y \
    locales sudo \
    --no-install-recommends \
 && localedef -i ko_KR -f UTF-8 ko_KR.UTF-8 \
 && localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && echo 'LANG=ko_KR.UTF-8' >> /etc/default/locale \
 && echo 'export LANG=ko_KR.UTF-8' >> /etc/bash.bashrc \
 && ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
 && echo "Asia/Seoul" > /etc/timezone \
 && apt-get update && apt-get install -y \
    tzdata \
    --no-install-recommends


RUN apt-get update && apt-get install -y \
    apt-transport-https ca-certificates curl gnupg \
    wget openssh-client git make vim uim uim-gtk3 \
    fonts-nanum fonts-nanum-coding fonts-nanum-extra \
    libasound2 \
    libgtk2.0-0 \
    libwebkitgtk-1.0-0 \
    libwebkitgtk-3.0-0 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    --no-install-recommends

ENV HOST_UID=1000 \
    HOST_GID=1000 \
    HOST_NAME=developer

RUN mkdir -p /home/${HOST_NAME} \
 && echo "${HOST_NAME}:x:${HOST_UID}:${HOST_GID}:${HOST_NAME},,,:/home/${HOST_NAME}:/bin/bash" >> /etc/passwd \
 && echo "${HOST_NAME}:x:${HOST_UID}:" >> /etc/group \
 && echo "${HOST_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${HOST_NAME} \
 && chmod 0440 /etc/sudoers.d/${HOST_NAME} \
 && touch /home/${HOST_NAME}/.Xauthority \
 && chown -R ${HOST_NAME}:${HOST_NAME} /home/${HOST_NAME}

