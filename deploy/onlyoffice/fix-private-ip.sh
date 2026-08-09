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
# ⚠️ Rodar depois do container estar SAUDÁVEL (não logo após o `up -d`) —
# o entrypoint escreve a config de JWT em local.json de forma assíncrona
# nos primeiros segundos. IMPORTANTE: o merge abaixo é feito com Python
# (lê o local.json inteiro, adiciona só a chave que precisamos, escreve de
# volta) — NUNCA sobrescrever o arquivo com `cat > local.json <<JSON`, isso
# apaga a config de JWT que o entrypoint gerou (bug real que já aconteceu:
# 2026-08-09, deixou toda edição de documento voltando "Download without
# jwt" no log do Nextcloud até ser descoberto e corrigido).
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

echo "> Mesclando allowPrivateIPAddress no local.json (sem apagar o resto)..."
cat > /tmp/g2w-merge-local-json.py <<'PYEOF'
import json
path = "/etc/onlyoffice/documentserver/local.json"
with open(path) as f:
    cfg = json.load(f)
cfg.setdefault("services", {}).setdefault("CoAuthoring", {})["request-filtering-agent"] = {
    "allowPrivateIPAddress": True,
    "allowMetaIPAddress": True,
}
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
print("merge ok")
PYEOF
docker cp /tmp/g2w-merge-local-json.py "$CONTAINER":/tmp/merge.py
docker exec "$CONTAINER" python3 /tmp/merge.py
rm -f /tmp/g2w-merge-local-json.py

echo "> Reiniciando serviços internos do Document Server..."
docker exec "$CONTAINER" supervisorctl restart all

echo "> Pronto. Aguardando servicos reiniciarem..."
sleep 10
docker exec "$CONTAINER" curl -sf http://localhost/healthcheck && echo "OK - Document Server saudavel"
