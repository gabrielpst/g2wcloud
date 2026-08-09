<?php
/**
 * SPDX-FileCopyrightText: 2026 G2W Tecnologia
 * SPDX-License-Identifier: AGPL-3.0-only
 *
 * Aplica logo e favicon do tema G2W Cloud via a mesma camada de serviço que
 * o painel de administração usa (ImageManager + ThemingDefaults::set()).
 *
 * Por quê isso é necessário além de themes/default/: o Nextcloud moderno só
 * usa o arquivo de tema como fallback pra algumas coisas (nome, slogan,
 * cores, fundo). Logo e favicon exibidos na UI (variáveis CSS --image-logo /
 * --image-favicon) só aparecem se tiverem sido "enviados" por essa API —
 * mesmo com o arquivo certo em themes/default/core/img/, sem rodar isso a
 * UI cai no logo padrão da Nextcloud GmbH. Descoberto lendo
 * apps/theming/lib/Themes/CommonThemeTrait.php e
 * apps/theming/lib/Controller/ThemingController.php::uploadImage().
 *
 * Rodar uma vez por instalação nova (ou depois de trocar os arquivos em
 * themes/default/core/img/):
 *   sudo -u www-data php scripts/apply-g2w-brand-images.php
 */
require_once __DIR__ . '/../lib/base.php';

$imageManager = \OC::$server->get(\OCA\Theming\ImageManager::class);
$themingDefaults = \OC::$server->get(\OCA\Theming\ThemingDefaults::class);

$base = __DIR__ . '/../themes/default/core/img';
$jobs = [
    'logo'    => "$base/logo/logo.svg",
    'favicon' => "$base/favicon.png",
];

foreach ($jobs as $key => $file) {
    if (!file_exists($file)) {
        echo "FALTA: $file\n";
        continue;
    }
    try {
        $mime = $imageManager->updateImage($key, $file);
        $themingDefaults->set($key . 'Mime', $mime);
        echo "OK $key -> mime=$mime\n";
    } catch (\Throwable $e) {
        echo "ERRO $key: " . $e->getMessage() . "\n";
    }
}
