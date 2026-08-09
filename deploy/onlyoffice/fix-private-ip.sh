#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 G2W Tecnologia
# SPDX-License-Identifier: AGPL-3.0-only
#
# Pegadinha conhecida (lição do pvedom, 2026-07-29 — ver
# 01 - Redes/00 - Infraestrutura Zabbix Central/rotinas/implantar-nextcloud-onlyoffice.md):
# o Document Server recusa baixar arquivo de IP/host privado por padrão
# (`allowPrivateIPAddress: false`). Toda instalação sem domínio público
# (o nosso caso hoje, 100% interno) precisa dessa correção, senão qualquer
# tentativa de editar documento dá "Error while downloading the document
# file to be converted".
#
# Rodar depois do primeiro `docker compose up -d`.
set -euo pipefail

CONTAINER="g2wcloud-onlyoffice"

echo "> Aguardando o container ficar saudável..."
for i in $(seq 1 30); do
  status=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER" 2>/dev/null || echo "starting")
  [ "$status" = "healthy" ] && break
  sleep 5
done

echo "> Aplicando allowPrivateIPAddress: true"
docker exec "$CONTAINER" bash -c '
cat > /etc/onlyoffice/documentserver/local.json <<JSON
{
  "services": {
    "CoAuthoring": {
      "request-filtering-agent": {
        "allowPrivateIPAddress": true,
        "allowMetaIPAddress": true
      }
    }
  }
}
JSON
supervisorctl restart all
'

echo "> Pronto. Aguardando servicos reiniciarem..."
sleep 10
docker exec "$CONTAINER" curl -sf http://localhost/healthcheck && echo "OK - Document Server saudavel"
