#!/usr/bin/env bash
if [ -d "$HOME/acme.sh" ]; then
  exit
fi

mkdir -p /tmp/acme.sh
git clone -qq https://github.com/acmesh-official/acme.sh.git /tmp/acme.sh
pushd /tmp/acme.sh >/dev/null || return
"/tmp/acme.sh/acme.sh" --install \
  --home "$HOME/.acme.sh" \
  --config-home "$LE_CONFIG_HOME" \
  --cert-home "$LE_WORKING_DIR" \
  --accountemail "$LE_EMAIL" \
  "$ACME_SH_ARGS"
rm -rf /tmp/acme.sh
popd >/dev/null || return
