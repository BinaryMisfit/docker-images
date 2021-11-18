FROM mcr.microsoft.com/azure-sql-edge:latest
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get upgrade --yes
RUN ACCEPT_EULA=Y apt-get --no-install-recommends install mssql-cli sudo --yes
RUN mkdir -p /usr/local/lib/scripts
RUN mkdir -p /var/opt/msqsql/sqldata
RUN mkdir -p /var/opt/mssql/data
COPY /image_content/scripts/*.sh /usr/local/lib/scripts
COPY /image_content/etc/sudoers.d/* /etc/sudoers.d
RUN chmod -R +x /usr/local/lib/scripts/*.sh
RUN ln -s /usr/local/lib/scripts/entrypoint.sh /usr/local/bin/
USER mssql
#ENTRYPOINT entrypoint.sh
