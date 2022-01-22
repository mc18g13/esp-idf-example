FROM espressif/idf:latest

ENV TERM=xterm-256color

RUN apt-get update && apt-get install -y \
  ruby \
  sudo \
  nano

ARG USER
ARG HOME

RUN useradd -ms /bin/bash $USER

# give user sudo permissions and set pw
RUN usermod -aG sudo $USER
RUN echo "$USER:pw" | chpasswd

USER $USER
WORKDIR $HOME