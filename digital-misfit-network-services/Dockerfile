FROM ubuntu:impish
USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update -qq
RUN DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y apt-get -y upgrade -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install -qq ca-certificates \
    cron \
    curl \
    git \
    openssl \
    socat
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoremove --purge
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean
RUN rm -rf /etc/cron.*/*
COPY fs /
RUN chmod +x /root/entrypoint.sh
RUN chmod +x /root/.ssl/acme*
ENTRYPOINT ["/bin/bash", "-c", "/root/entrypoint.sh"]
