#!/usr/bin/env bash
printf '[%(%a %b %e %H:%M:%S %Z %Y)T] Starting\n' -1
/bin/bash -c "$HOME/ssl/acme-install.sh" >/dev/null 2>&1
/bin/bash -c "$HOME/ssl/acme-register.sh" >/dev/null 2>&1
/bin/bash -c "$HOME/ssl/acme-cron.sh" > /dev/null 2>&1
/bin/bash -c "$HOME/dns/dns-dynamic-update.sh"
printenv > "$HOME/.cron.env"
mapfile -t ACME_ENV <"$HOME/.cron.env"
printf -v ACME_CRON_ENV "\nexport %s" "${ACME_ENV[@]}"
echo "$ACME_CRON_ENV" > "$HOME/.cron.env"
service cron start >/dev/null
trap "printf 'Stopping cron service'; service cron stop >/dev/null; printf '\nShutdown'; exit" SIGINT SIGTERM
while true; do
  tail -F -n +1 "$HOME/.acme.sh/acme.sh.log"
done
