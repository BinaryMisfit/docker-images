FROM ubuntu:impish
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get -y update -qq
RUN ACCEPT_EULA=Y apt-get -y upgrade -qq
RUN apt-get -y --no-install-recommends install cron sudo -qq
RUN apt-get -y autoremove --purge
RUN apt-get autoclean
RUN rm -rf /etc/cron.*/*
RUN curl https://get.acme.sh | sh -s email=administrator@senselesslyfoolish.com
COPY fs/etc /etc
COPY fs/root /root
RUN touch /var/log/cron
RUN chmod +x /root/entrypoint
RUN chmod +x /etc/cron.d/hello-cron
RUN crontab /etc/cron.d/hello-cron
ENTRYPOINT ["/root/entrypoint"]
