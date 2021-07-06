FROM ubuntu:latest

LABEL maintainer="XoL <MephistoXoL@gmail.com>" description="Backy2 to Backup RBD images" version="MultiArch v1.0"

## INSTALL PACKAGES
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl jq python3-rbd python3-rados python3-crypto \ 
    python3-alembic python3-dateutil python3-fusepy python3-prettytable python3-psutil \
    python3-setproctitle python3-shortuuid python3-sqlalchemy libfuse2 python3-lz4 python3-pycryptodome
    
## GET VERSION, URL AND INSTALL
RUN URL=$(curl -s https://api.github.com/repos/wamdam/backy2/releases/latest | jq -r '.assets[].browser_download_url') && \
    curl -SLo /tmp/backy2.deb $URL && \
    dpkg -i /tmp/backy2.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get -f install -y

## COPY SCRIPTS
COPY entrypoint.sh /usr/bin/entrypoint.sh

## CLEAN PACKAGES
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh
