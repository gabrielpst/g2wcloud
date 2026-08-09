#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 G2W Tecnologia
# SPDX-License-Identifier: AGPL-3.0-only
#
# Instala o ONLYOFFICE Document Server completo pro G2W Cloud: sobe o
# container, corrige a pegadinha de IP privado, instala e configura o
# conector no Nextcloud. Padrão de toda instalação nova do G2W Cloud.
#
# Requer Docker instalado (curl -fsSL https://get.docker.com | sh).
# Rodar como root (ou quem tiver acesso ao docker) a partir desta pasta:
#   bash install.sh
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -f .env ]; then
    echo "> Gerando segredo JWT..."
    echo "ONLYOFFICE_JWT_SECRET=$(openssl rand -hex 32)" > .env
    chmod 600 .env
fi
JWT_SECRET=$(grep ONLYOFFICE_JWT_SECRET .env | cut -d= -f2)

echo "> Subindo o Document Server..."
docker compose up -d

echo "> Aplicando correcao de IP privado..."
bash fix-private-ip.sh

echo "> Configurando o conector no Nextcloud..."
# URL que o NAVEGADOR do usuário vai usar — precisa ser o IP real da LXC
# na rede, nunca 127.0.0.1 (isso resolveria pra loopback do PC de quem
# acessa, não da LXC). Detecta o IP da interface principal automaticamente;
# sobrescrever com ONLYOFFICE_BROWSER_HOST=<ip-ou-dominio> se precisar
# (ex: quando isso for exposto por um domínio público mais pra frente).
BROWSER_HOST="${ONLYOFFICE_BROWSER_HOST:-$(hostname -I | awk '{print $1}')}"
sudo -u www-data bash configure-nextcloud.sh \
    "http://${BROWSER_HOST}:8082/" \
    "http://127.0.0.1:8082/" \
    "$JWT_SECRET"

echo
echo "=== Concluido ==="
echo "Editor de documentos ativo. Teste criando/abrindo um .docx/.xlsx/.pptx no G2W Cloud."
