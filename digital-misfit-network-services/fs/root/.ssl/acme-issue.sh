#!/usr/bin/env bash
if [ ! -f "/etc/ssl/cert-domains.conf" ]; then
  echo "Config file /etc/ssl/cert-domains.conf not found"
  exit 255
fi

source "$HOME/.acme.sh/acme.cron.env"
env
ls -lha "$LE_WORKING_DIR"
mapfile -t DOMAINS <"/etc/ssl/cert-domains.conf"
for ENTRY in "${DOMAINS[@]}"; do
  mapfile -t -d \, DOMAIN_INFO <<< "$ENTRY"
  printf -v DOMAIN_ARGS -- ' --domain \"%s\"' "${DOMAIN_INFO[@]}"
  printf -v ACME_ISSUE '%s/.acme.sh/acme.sh --issue --dns dns_cloudns --ecc --debug' "$HOME"
  printf -v ACME_ISSUE '%s --home \"%s/.acme.sh\" --config-home \"%s\"' "$ACME_ISSUE" "$HOME" "$LE_CONFIG_HOME"
  printf -v ACME_ISSUE '%s --cert-home \"%s\" %s%s' "$ACME_ISSUE" "$LE_WORKING_DIR" "$ACME_SH_ARGS" "${DOMAIN_ARGS[@]}"
  echo "$ACME_ISSUE"
  #/bin/bash -c "$ACME_ISSUE"
done
ls -lha "$LE_WORKING_DIR"
