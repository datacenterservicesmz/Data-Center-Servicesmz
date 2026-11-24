#!/bin/sh
# Script nao testado: se falhar, use o PUBLICAR.md
cd "$(dirname "$0")"
command -v git >/dev/null || { echo "Instale o Git"; exit 1; }
command -v gh >/dev/null || { echo "Instale o GitHub CLI: https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || gh auth login
USR=$(gh api user --jq .login)
printf "Nome do repositorio (Enter = datacenter): "; read NOME; NOME=${NOME:-datacenter}
git config user.email >/dev/null 2>&1 || git config user.email "$USR@users.noreply.github.com"
git config user.name >/dev/null 2>&1 || git config user.name "$USR"
[ -d .git ] || git init -b main
git add -A && git commit -m "DATA CENTER" >/dev/null 2>&1
gh repo create "$NOME" --public --source=. --remote=origin --push
gh api -X POST "repos/$USR/$NOME/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1
echo "Repositorio: https://github.com/$USR/$NOME"
echo "Site (1 a 2 minutos): https://$USR.github.io/$NOME/"
echo "Falta: config.js com os dados do Firebase (PUBLICAR.md, passo B)."
