FROM ubuntu:impish
ARG ACME_SH_ARGS
ARG LETS_ENCRYPT_MAIL
ENV ACME_SH_ARGS=$ACME_SH_ARGS
ENV LETS_ENCRYPT_MAIL=$LETS_ENCRYPT_MAIL
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
RUN chmod +x /root/entrypoint
RUN chmod +x /root/.ssl/acme*
RUN /root/.ssl/acme-install
RUN /root/.ssl/acme-register
ENTRYPOINT ["/root/entrypoint"]
