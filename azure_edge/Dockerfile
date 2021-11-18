FROM mcr.microsoft.com/azure-sql-edge:latest
ARG DEBIAN_FRONTEND=noninteractive
USER root
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get upgrade --yes
RUN ACCEPT_EULA=Y apt-get --no-install-recommends install mssql-cli --yes
USER mssql
