#!/usr/bin/env bash
printf "Running SQL Server"
if [[ -d /var/opt/mssql/user-data ]]; then
  sudo chown -R mssql: /var/opt/mssql/user-data
fi

if [[ -d /var/opt/mssql/data ]]; then
  sudo chown -R mssql: /var/opt/mssql/data
fi

exec /opt/mssql/bin/sqlservr
