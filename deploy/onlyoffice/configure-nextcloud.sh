#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 G2W Tecnologia
# SPDX-License-Identifier: AGPL-3.0-only
#
# Instala o app conector ONLYOFFICE no Nextcloud e aponta pro Document
# Server. Rodar depois que o docker-compose do Document Server já estiver
# de pé (fix-private-ip.sh incluso).
#
#   sudo -u www-data bash configure-nextcloud.sh <url-do-document-server> <jwt-secret>
#
# Ex: sudo -u www-data bash configure-nextcloud.sh http://127.0.0.1:8082/ abc123...
set -euo pipefail

DOC_SERVER_URL="${1:?Uso: configure-nextcloud.sh <url> <jwt-secret>}"
JWT_SECRET="${2:?Uso: configure-nextcloud.sh <url> <jwt-secret>}"

NC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OCC="php ${NC_DIR}/occ"

echo "> Instalando app onlyoffice..."
$OCC app:list --output=json | grep -q '"onlyoffice"' || $OCC app:install onlyoffice
$OCC app:enable onlyoffice

echo "> Configurando URLs e segredo JWT..."
$OCC config:app:set onlyoffice DocumentServerUrl --value="$DOC_SERVER_URL"
$OCC config:app:set onlyoffice DocumentServerInternalUrl --value="$DOC_SERVER_URL"
$OCC config:app:set onlyoffice jwt_secret --value="$JWT_SECRET"
$OCC config:app:set onlyoffice jwt_header --value="Authorization"
$OCC config:app:set onlyoffice jwt_in_body --value="true"

echo "> Permissoes necessarias pra instalacao 100% interna (sem dominio publico)..."
$OCC config:system:set allow_local_remote_servers --value=true --type=boolean

echo "> Conferindo..."
if ! $OCC onlyoffice:documentserver --check; then
	echo "ERRO: onlyoffice:documentserver --check falhou."
	echo "Causas mais comuns: fix-private-ip.sh não rodou (ou rodou antes do"
	echo "container ficar saudável), ou o local.json perdeu a config de JWT"
	echo "(nunca sobrescrever esse arquivo — só mesclar, ver fix-private-ip.sh)."
	exit 1
fi

echo "Concluido."
