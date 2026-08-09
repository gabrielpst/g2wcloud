# Tema G2W Cloud

`defaults.php` já está pronto (nome, slogan, cores). Faltam os arquivos de imagem —
pendentes de uma versão vetorial/transparente do emblema, hoje só existe o banner
achatado (`g2wcloud.png`, 1717×916, sem alfa, sem vetor).

## Prompt para gerar os assets (agente de IA de imagem)

```
Isole e refine o emblema "G2W Cloud" a partir da identidade visual de referência
anexa (nuvem com trilhas de circuito, estilo metálico verde-escuro sobre fundo
quase-preto, wordmark "G2W" em prata/branco com o "2" em verde, tipografia
condensada bold).

Preciso de DUAS peças, cada uma em fundo TRANSPARENTE (PNG com canal alfa),
sem o banner/cenário ao redor, alta resolução (mínimo 2048×2048 px), estilo
vetorial de bordas limpas (não fotográfico, sem ruído/grão):

1. EMBLEMA COMPLETO: só o ícone da nuvem com as trilhas de circuito e a seta
   de sincronização, sem texto nenhum. Cores: gradiente metálico verde
   (aproximadamente #3c6c42 a #8ac072) com realces claros, mesma linguagem
   visual do ícone original.

2. MARCA SIMPLIFICADA PARA TAMANHOS PEQUENOS (16–48px): uma versão reduzida
   e de alto contraste do mesmo emblema — menos detalhe (sem as trilhas de
   circuito internas, só a silhueta da nuvem + seta, ou um monograma "G2W"),
   pensada pra ficar legível em favicon/ícone de aba de navegador. Mesma
   paleta verde.

Não inclua texto "CLOUD", tagline nem os ícones de recursos (armazenamento,
acesso, compartilhamento etc.) do banner original — só o emblema isolado.
```

Anexar `g2wcloud.png` (`01 - Redes/20 - Clientes/09 - G2W Gabriel/contexto/g2wcloud.png`) como referência visual ao rodar o prompt.

## Onde colocar os arquivos quando chegarem

| Arquivo esperado | Peça do prompt | Tamanho |
|---|---|---|
| `core/img/logo.svg` + `logo.png` | Emblema completo (1) | logo do canto superior esquerdo / tela de login |
| `core/img/logo-icon.svg` + `.png` | Marca simplificada (2) | ícone de app/atalho |
| `core/img/favicon.svg` + `.png` + `.ico` | Marca simplificada (2) | aba do navegador |
| `core/img/favicon-touch.png` | Marca simplificada (2), fundo sólido | ícone iOS "adicionar à tela" |
| `core/img/logo-mail.gif` | Emblema completo (1), fundo sólido claro | cabeçalho dos e-mails automáticos |

Basta salvar os arquivos com esses nomes exatos nesta pasta — o Nextcloud
substitui as imagens automaticamente, sem precisar editar nenhum código.
