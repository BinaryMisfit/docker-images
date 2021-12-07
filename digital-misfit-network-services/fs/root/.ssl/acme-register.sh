#!/usr/bin/env bash
if [ -f "$HOME/.acme.sh/account.conf" ]; then
  exit
fi

"$HOME/.acme.sh/acme.sh" --register-account \
  --home "$HOME/acme.sh" \
  --config-home "$LE_CONFIG_HOME" \
  --cert-home "$LE_WORKING_DIR" \
  -m "$LE_EMAIL" \
  "$ACME_SH_ARGS"
