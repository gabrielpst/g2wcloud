<?php

/**
 * SPDX-FileCopyrightText: 2026 G2W Tecnologia
 * SPDX-License-Identifier: AGPL-3.0-only
 *
 * Tema de marca da G2W Tecnologia para o G2W Cloud (fork do Nextcloud Server).
 * Nomeado "default" de propósito: OC_Util::getTheme() ativa automaticamente
 * a pasta themes/default/ quando existe, sem precisar declarar 'theme' em
 * config.php. Qualquer instância nova já nasce com a marca G2W.
 *
 * Ver README.md deste tema para instruções de atualização dos assets (logo,
 * favicon) — pendentes de uma versão vetorial/transparente do emblema
 * (banner de origem: 01 - Redes/20 - Clientes/09 - G2W Gabriel/contexto/g2wcloud.png).
 */

class OC_Theme {
	public function getBaseUrl(): string {
		return 'https://cloud.g2wtecnologia.net';
	}

	public function getDocBaseUrl(): string {
		return 'https://docs.nextcloud.com';
	}

	public function getTitle(): string {
		return 'G2W Cloud';
	}

	public function getName(): string {
		return 'G2W Cloud';
	}

	public function getHTMLName(): string {
		return 'G2W Cloud';
	}

	public function getEntity(): string {
		return 'G2W Tecnologia';
	}

	public function getSlogan(): string {
		return 'Seus arquivos. Sua nuvem. Sem limites.';
	}

	public function getShortFooter(): string {
		$entity = $this->getEntity();
		$footer = '© ' . date('Y') . ' <a href="' . $this->getBaseUrl() . '" target="_blank">' . $entity . '</a><br/>';
		$footer .= $this->getSlogan();
		return $footer;
	}

	public function getLongFooter(): string {
		return $this->getShortFooter();
	}

	public function buildDocLinkToKey($key): string {
		return $this->getDocBaseUrl() . '/server/34/go.php?to=' . $key;
	}

	/**
	 * Verde extraído por amostragem de pixel do banner oficial "G2W Cloud"
	 * (destaque do emblema/wordmark, não a sombra do gradiente metálico).
	 * Trocar quando a versão vetorial da marca chegar.
	 */
	public function getColorPrimary(): string {
		return '#3c6c42';
	}

	public function getColorBackground(): string {
		// Mesmo fundo escuro usado no site do G2W Monitor (monitor.g2wseguranca.com.br)
		// e no client desktop — consistência de "canvas" entre todos os produtos G2W.
		return '#00100E';
	}

	public function getScssVariables(): array {
		return [
			'color-primary' => '#3c6c42',
		];
	}
}
