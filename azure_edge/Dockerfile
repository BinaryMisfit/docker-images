FROM mcr.microsoft.com/azure-sql-edge:latest
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get upgrade --yes
RUN ACCEPT_EULA=Y apt-get --no-install-recommends install mssql-cli --yes
RUN mkdir -p /scripts
RUN mkdir -p /sqldata
RUN mkdir -p /var/opt/mssql/data
COPY /image_content/*.sh /scripts
RUN chmod -R +x /scripts/*.sh
#USER mssql
#ENTRYPOINT /bin/bash /scripts/entrypoint.sh
