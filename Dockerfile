FROM ubuntu:16.04

RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y install curl git

# Install Coccinelle (pre-packaged)
RUN apt-get -y install coccinelle

# Verify Coccinelle installation
RUN spatch --version

# EOF
