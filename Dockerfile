FROM ubuntu:16.04

RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y install curl git && \
  apt-get -y install build-essential make

## Install Coccinelle (pre-packaged)
# RUN apt-get -y install coccinelle

# Install Coccinelle from sources
RUN apt-get -y build-dep coccinelle
RUN apt-get -y install autoconf
RUN git clone https://github.com/coccinelle/coccinelle && \
  cd coccinelle && \
  autoreconf -i && \
  ./configure && \
  make && \
  make install

# Verify Coccinelle installation
RUN which spatch
RUN spatch --version

# Create user "jenkins"
RUN id jenkins 2>/dev/null || useradd --uid 1000 --create-home jenkins

# EOF
