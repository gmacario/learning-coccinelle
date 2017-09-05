FROM ubuntu:16.04

RUN apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get -y install curl git && \
  apt-get -y install build-essential make

# Install Coccinelle (pre-packaged)
RUN apt-get -y install coccinelle

# Verify Coccinelle installation
RUN spatch --version

# Create user "jenkins"
RUN id jenkins 2>/dev/null || useradd --uid 1000 --create-home jenkins

# EOF