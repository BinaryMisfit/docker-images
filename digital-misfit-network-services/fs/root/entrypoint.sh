#!/usr/bin/env bash
/bin/bash -c "$HOME/.ssl/acme-install.sh" >/dev/null 2>&1
/bin/bash -c "$HOME/.ssl/acme-register.sh" >/dev/null 2>&1
/bin/bash -c "$HOME/.ssl/acme-cron.sh" >/dev/null 2>&1
env > "$HOME/.acme.sh/acme.cron.env"
touch "$HOME/.acme.sh/acme.sh.log"
service cron start >/dev/null
trap "service cron stop > /dev/null; exit" SIGINT SIGTERM
while true; do
  tail -F "$HOME/.acme.sh/acme.sh.log"
done
