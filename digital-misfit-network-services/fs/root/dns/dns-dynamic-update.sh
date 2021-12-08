#!/usr/bin/env bash
if [ ! -f "/etc/dns/dynamic-hosts.conf" ]; then
  printf '[%(%a %b %e %H:%M:%S %Z %Y)T] Config file /etc/dns/dynamic-hosts.conf not found\n' -1
  exit 255
fi

mapfile -t HOSTS <"/etc/dns/dynamic-hosts.conf"
printf '[%(%a %b %e %H:%M:%S %Z %Y)T] Checking %d hosts\n' -1 ${#HOSTS[@]}
API_URL="https://api.ipify.org"
API_RESPONSE=$(curl -s "${API_URL}")
if [[ "$API_RESPONSE" != "" ]]; then
  USE_IPV4="$API_RESPONSE"
fi

for HOST in "${HOSTS[@]}"; do
  HOST_NAME="$(echo "$HOST" | cut -d . -f 1)"
  DOMAIN="$(echo "${HOST}" | rev | cut -d . -f 1,2 | rev)"
  API_URL="https://api.cloudns.net/dns/records.json"
  API_REQUEST="\
  {
   \"sub-auth-id\": \"$CLOUDNS_SUB_AUTH_ID\",
   \"auth-password\": \"$CLOUDNS_AUTH_PASSWORD\",
   \"domain-name\": \"$DOMAIN\",
   \"host\": \"$HOST_NAME\",
   \"type\": \"A\"
  }"
  API_RESPONSE=$(curl -s --request POST -H "Content-Type:application/json" "$API_URL" --data "$API_REQUEST")
  DOMAIN_ID=$(jq -r '.[] .id' <<<"$API_RESPONSE")
  DOMAIN_IP=$(jq -r '.[] .record' <<<"$API_RESPONSE")
  if [[ "$USE_IPV4" != "$DOMAIN_IP" ]] && [[ "$DOMAIN_ID" != "" ]]; then
    API_URL="https://api.cloudns.net/dns/get-dynamic-url.json"
    API_REQUEST="\
    {
    \"sub-auth-id\": \"$CLOUDNS_SUB_AUTH_ID\",
    \"auth-password\": \"$CLOUDNS_AUTH_PASSWORD\",
    \"domain-name\": \"$DOMAIN\",
    \"record-id\": \"$DOMAIN_ID\"
    }"
    API_RESPONSE=$(curl -s --request POST -H "Content-Type:application/json" "$API_URL" --data "$API_REQUEST")
    UPDATE_URL=$(jq -r '.url' <<<"$API_RESPONSE")
    if [[ "${UPDATE_URL}" != "" ]]; then
      curl -s "$UPDATE_URL"
      printf "[%(%a %b %e %H:%M:%S %Z %Y)T] Updated %s\n" -1 "$HOST"
    fi
  fi
done
