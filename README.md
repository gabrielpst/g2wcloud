<!--
 - SPDX-FileCopyrightText: 2026 G2W Tecnologia
 - SPDX-FileCopyrightText: 2016-2024 Nextcloud GmbH and Nextcloud contributors
 - SPDX-License-Identifier: AGPL-3.0-or-later
-->
# G2W Cloud ☁

**Seus arquivos. Sua nuvem. Sem limites.**

Fork do [Nextcloud Server](https://github.com/nextcloud/server) (branch `stable34`,
versão 34.0.2) com a marca da **G2W Tecnologia** — armazenamento, sincronização e
compartilhamento de arquivos auto-hospedado, rodando em infraestrutura própria.

## O que é

* 📁 **Seus arquivos, seu servidor** — nada passa por nuvem de terceiro.
* 🔄 **Sincronização** entre computador, celular e navegador.
* 🙌 **Compartilhamento** com controle de quem acessa e por quanto tempo.
* 🔒 **Privacidade e controle** — criptografia e autenticação em duas etapas disponíveis.
* 🚀 **Extensível** — Calendário, Contatos, E-mail, Chamada de vídeo e outros apps
  instaláveis depois, direto pela loja de apps integrada.

## Marca

A identidade "G2W Cloud" fica em [`themes/default/`](themes/default/) — nome,
slogan e cores já vêm configurados no código (nenhuma instância nova precisa de
configuração manual pra exibir a marca certa). Detalhe de como atualizar
logo/favicon em [`themes/default/README.md`](themes/default/README.md).

## Por que uma branch estável, e não a `master`

O `nextcloud/server` upstream mantém a `master` como branch de **desenvolvimento**
(hoje rastreando a próxima versão, ainda instável). Este fork parte da
**`stable34`**, a branch de manutenção da última versão lançada (34.0.2) — a
mesma que recebe os backports de correção de segurança da Nextcloud GmbH.

## Instalação

Requer PHP 8.1+ (com as extensões padrão do Nextcloud: `intl`, `gd`, `mbstring`,
`xml`, `zip`, `curl`, `bz2`, `gmp`, `opcache`), um banco (MySQL/MariaDB ou
PostgreSQL) e um servidor web (Apache ou Nginx + PHP-FPM). Ver a
[documentação de instalação do Nextcloud](https://docs.nextcloud.com/server/34/admin_manual/installation/)
— o processo é idêntico ao do projeto original, só a marca muda.

## Manter atualizado

Este fork acompanha os patches de segurança da `stable34` upstream:

```bash
git remote add upstream https://github.com/nextcloud/server.git
git fetch upstream stable34
git merge upstream/stable34
```

## Licença

[AGPL-3.0-or-later](COPYING), a mesma do projeto original. Ver [`LICENSES/`](LICENSES/)
para as licenças de cada dependência.

## Contato

**G2W Tecnologia**
Site: [cloud.g2wtecnologia.net](https://cloud.g2wtecnologia.net/)
WhatsApp: +55 67 99608-6281
E-mail: contato@g2wtecnologia.net
