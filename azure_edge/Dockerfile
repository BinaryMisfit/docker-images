FROM mcr.microsoft.com/azure-sql-edge:latest
USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y apt-get --no-install-recommends install mssql-cli --yes
USER mssql
