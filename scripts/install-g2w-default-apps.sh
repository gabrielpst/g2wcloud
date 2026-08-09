#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 G2W Tecnologia
# SPDX-License-Identifier: AGPL-3.0-only
#
# Instala o conjunto de apps padrão de qualquer instalação G2W Cloud:
# Calendário, Contatos, E-mail e Chamada de vídeo (Talk). Não vêm no
# nextcloud/server (só o núcleo de arquivos) — são apps oficiais separados,
# baixados da App Store da própria Nextcloud (apps.nextcloud.com) via CLI.
#
# Funciona mesmo se a tela de Apps do painel estiver com problema — o
# download aqui não passa pela mesma rota que a tela web usa.
#
# Rodar uma vez por instalação nova (como usuário que roda o PHP, ex: www-data):
#   sudo -u www-data bash scripts/install-g2w-default-apps.sh
set -euo pipefail

OCC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OCC="php ${OCC_DIR}/occ"

APPS=(calendar contacts mail spreed)

for app in "${APPS[@]}"; do
    if $OCC app:list --output=json 2>/dev/null | grep -q "\"$app\":"; then
        echo "[$app] já instalado, pulando"
        continue
    fi
    echo "[$app] instalando..."
    $OCC app:install "$app"
done

echo "--- estado final ---"
$OCC app:list | grep -E "calendar|contacts|mail|spreed" || true
